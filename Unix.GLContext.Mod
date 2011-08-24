MODULE GLContext; (** AUTHOR "fnecati"; PURPOSE "OpenGL Context for LinuxAos"; *) 
IMPORT
	X11, GL:=OpenGL, GLC := OpenGLConst, Api:=X11Api, Raster,
	Trace,  SYSTEM;

CONST debug = FALSE;

TYPE
	GLWindowContext*=RECORD
		display* : X11.DisplayPtr;
		win*  : X11.Window ;
		glctx*, glctx1* : GL.GLXContext;	
		visualInfoPtr* : Api.VisualInfoPtr;
		wmDeleteWindow*: X11.Atom;
	END;

	Buffer = POINTER TO ARRAY OF CHAR;
		
TYPE Context* = OBJECT
VAR
	width*, height*: LONGINT; (* size of GL window *)
	glWin* : GLWindowContext; 
	doublebuffered*: BOOLEAN; (* is context doublebuffered *)
	visible*: BOOLEAN; (* is window hidden *) 	
 	buffer: Buffer; (* for speedup flip image in y*)
 	rastermode: Raster.Mode;

	PROCEDURE Init*(w, h: LONGINT; title: ARRAY OF CHAR; isvisible: BOOLEAN);
	VAR
		res: LONGINT;
		att : ARRAY [*] OF GL.GLint;
		xev  : Api.XEvent;
	  	masks: LONGINT;
 
	BEGIN {EXCLUSIVE}
		width := w; height := h; 
		visible := isvisible;
		X11.Lock;

	(*  get a connection *)	
		glWin.display := X11.OpenDisplay(0);
		IF glWin.display =0 THEN
 			X11.Unlock;
 			Trace.String(" cannot connect to X server"); Trace.Ln; 
			Close;
			RETURN;
		END;  
	 
		(* Check if GLX is supported on this display *)
		IF ( GL.glXQueryExtension( glWin.display, 0, 0 ) =  0 ) THEN
			X11.Unlock;
		       Trace.String("GLX is NOT supported on this display"); Trace.Ln;
		       Close;
			RETURN
		END;

		(* Catch WM close*)
		glWin.wmDeleteWindow := Api.InternAtom( glWin.display, "WM_DELETE_WINDOW", Api.False);


		NEW(att, 13);
		att[0] := GLC.GLX_RGBA;
		att[1] := GLC.GLX_DOUBLEBUFFER;
		att[2] := GLC.GLX_DEPTH_SIZE;	att[3] := 24; 
		att[4] := GLC.GLX_STENCIL_SIZE;	att[5] := 8; 
		att[6] := GLC.GLX_RED_SIZE;  	att[7] := 8;
		att[8] := GLC.GLX_GREEN_SIZE;	att[9] := 8;
		att[10] := GLC.GLX_RED_SIZE;	att[11] := 8;
		att[12] := 0 ;


		(* att := [GLC.GLX_RGBA, GLC.GLX_DOUBLEBUFFER, GLC.GLX_DEPTH_SIZE,  24, GLC.GLX_STENCIL_SIZE, 8, 0];*)
		doublebuffered := TRUE;
 
		glWin.visualInfoPtr := GL.glXChooseVisual(glWin.display, (*X11.DefaultScreen(glWin.display)*) 0 , SYSTEM.ADR(att[0]));

		IF glWin.visualInfoPtr = NIL THEN
			X11.Unlock;
			Trace.String(" NO appropriate visual found"); Trace.Ln;   	
			Close;
			RETURN;
		ELSE 
			IF debug THEN
				Trace.String("visualInfoPtr.depth= "); Trace.Int(glWin.visualInfoPtr.depth,0); Trace.Ln;
			 	Trace.String("visualInfoPtr.visual ");  Trace.Int(glWin.visualInfoPtr.visualID, 0); Trace.Hex(glWin.visualInfoPtr.visualID, 4);Trace.Ln; 
			 	Trace.String("visualInfoPtr.screen ");  Trace.Int(glWin.visualInfoPtr.screen, 0); Trace.Ln; 
			 END;	
		END;

		glWin.win := X11.CreateSimpleWindow(glWin.display, X11.DefaultRootWindow(glWin.display), 0, 0, width, height, 0, 0, 0);
		IF glWin.win = 0 THEN
			X11.Unlock;
			Trace.String(" could not create window");
			Close;
			RETURN;
		END;

		masks := SYSTEM.VAL(LONGINT, Api.ExposureMask + Api.StructureNotifyMask);
		X11.SelectInput(glWin.display, glWin.win, masks ); 
 
		IF visible THEN
			(* Map window *)
			Api.MapWindow(glWin.display, glWin.win); 
			res := Api.StoreName(glWin.display, glWin.win, title); 
			(* Make sure that our window ends up on top of things *)
			(* Api.RaiseWindow(glWin.display, glWin.win);*)

			IF debug THEN Trace.String(" Opened "); Trace.Ln; END;
	
			(* Wait for map notification *)	
		 	REPEAT  
		 		Api.NextEvent( glWin.display, xev );
		 		IF debug THEN Trace.String("Event type="); Trace.Int(xev.typ,4); Trace.Ln; END;
			UNTIL (xev.typ = Api.MapNotify) & (xev.window =glWin. win);

		END;

		GL.glXWaitX(); 

	 	(* create GL context *)
	 	(* GL_TRUE: Use direct rendering, GL_FLASE: use X server for rendering *)
	 	glWin.glctx := GL.glXCreateContext(glWin.display, glWin.visualInfoPtr, 0, GLC.GL_TRUE);
	 	IF glWin.glctx = 0 THEN
	 		X11.Unlock;
			Trace.String(" could not create context");
			Close;
			RETURN;
		END;  
  
		(* create a second GL context with sharing context 1 *)
		glWin.glctx1 := GL.glXCreateContext(glWin.display, glWin.visualInfoPtr, glWin.glctx, GLC.GL_TRUE);
		IF glWin.glctx1 = 0 THEN
			X11.Unlock;
			Trace.String(" could not create context-1");
			Close;
			RETURN;
		END;  

		IF debug THEN
			Trace.String("glXCreateContext glctx= "); Trace.Int(glWin.glctx, 0); Trace.Ln;
			Trace.String("glXCreateContext glctx1= "); Trace.Int(glWin.glctx1, 0); Trace.Ln;
	 	END;  
 	
	 	res := GL.glXMakeCurrent(glWin.display, glWin.win, glWin.glctx);
	 	IF debug THEN
			Trace.String("glXMakeCurrent res= "); Trace.Int(res, 0); Trace.Ln;	
	 	END;
 
	 	X11.Flush(glWin.display);
	 	GL.glXWaitX();
		X11.Unlock;
		IF debug THEN Trace.String("GL.glXIsDirect(glWin.display, gglWin.lctx)= "); Trace.Boolean(GL.glXIsDirect(glWin.display, glWin.glctx)=1); Trace.Ln; END; 
		
		NEW(buffer, w*h*4); (* create RGBA buffer for render operations *)
		Raster.InitMode(rastermode, Raster.srcCopy);
	END Init;
 
	PROCEDURE MakeCurrent*();
	 VAR res: LONGINT;
	 BEGIN 
		(* X11.Lock; *)
		res := GL.glXMakeCurrent(glWin.display, glWin.win, glWin.glctx);
		 IF debug THEN Trace.String(" MakeCurrent:"); Trace.Boolean(res=1); Trace.Ln; END;
		(* X11.Unlock; *)
	END MakeCurrent;

	PROCEDURE MakeCurrent1*();
	 VAR res: LONGINT;
	 BEGIN 
	    (* X11.Lock;*)
		res := GL.glXMakeCurrent(glWin.display, glWin.win, glWin.glctx1);
		IF debug THEN Trace.String(" MakeCurrent-1:"); Trace.Boolean(res=1); Trace.Ln; END;
		(* X11.Unlock;*)
	END MakeCurrent1;
 
	PROCEDURE SwapBuffers*;
	  VAR res: LONGINT;
	 BEGIN {EXCLUSIVE} 
		 X11.Lock();
		IF doublebuffered THEN
			GL.glXSwapBuffers(glWin.display, glWin.win);
		ELSE
	 		GL.glFlush();
		END;	
 		X11.Unlock();	
	END SwapBuffers;
 
	PROCEDURE DeActivate*();
 	VAR res: LONGINT;
 	BEGIN 
	(* X11.Lock; *)
		res := GL.glXMakeCurrent(glWin.display, 0, 0);
		IF debug THEN Trace.String(" DeActivate:"); Trace.Boolean(res=1); Trace.Ln; END;
	(* X11.Unlock; *)
	END DeActivate;

	PROCEDURE Close*;
	VAR res: LONGINT;
	BEGIN    	
		X11.Lock;  
		(* do we have a rendering context *)
		IF glWin.glctx # 0 THEN
			(* Release the context *)
		    	res := GL.glXMakeCurrent(glWin.display, 0, 0);
		    	(* Delete the context *)
			GL.glXDestroyContext(glWin.display, glWin.glctx1);
			GL.glXDestroyContext(glWin.display, glWin.glctx);
			IF debug THEN Trace.String("context deleted"); Trace.Ln; END;
		END;
	
		(* do we have a window *)
		IF glWin.win # 0 THEN
			(* Unmap the window*)
			Api.UnmapWindow(glWin.display, glWin.win);
			(* Destroy the window *)
			res:= Api.DestroyWindow(glWin.display, glWin.win);
			IF debug THEN Trace.String("window deleted"); Trace.Ln; END;
		END;
	
		(* do we have a display *)
		IF glWin.display # 0 THEN	
			 res := Api.CloseDisplay(glWin.display);
			IF debug THEN Trace.String("display deleted"); Trace.Ln; END;
		END;
	
		X11.Unlock; 	 
		glWin.glctx := 0;   glWin.win :=0;  glWin.display :=0; glWin.visualInfoPtr := NIL;
 	END Close;
 
 
	PROCEDURE RenderInto*(image: Raster.Image);
	VAR
		i: LONGINT;
		w, h: LONGINT;
	BEGIN
		w := image.width;
		h := image.height;
		GL.glReadPixels(0, 0, w, h, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, SYSTEM.ADR(buffer^[0]));
		(* flip vertical, y *)
		FOR i := 0 TO h - 1 DO
			Raster.PutPixels(image, 0, h-1-i, w, Raster.BGRA8888, buffer^, i * w * 4, rastermode)
		END
	END RenderInto;

 (*
	PROCEDURE Hide*;
	BEGIN {EXCLUSIVE}
		X11.Lock;
		X11.LowerWindow(glWin.display, glWin.win);
		GL.glXWaitX();
		X11.Sync(glWin.display, X11.False);
		X11.Unlock;
	END Hide;

	PROCEDURE Show*;
	BEGIN {EXCLUSIVE}
		X11.Lock;
		Api.RaiseWindow(glWin.display, glWin.win);
		GL.glXWaitX();
		X11.Sync(glWin.display, X11.False);
		X11.Unlock;	
	END Show;
*)

BEGIN 
END Context;

(* ***************************************** *)
(* ***************************************** *)
(* **************** For Testing with X11 window ** *)

VAR
 disp: Context;
 
PROCEDURE DrawAQuad(ctxt: Context); 
VAR x: LONGREAL;
BEGIN
	x := 5.0;
	ctxt.MakeCurrent();
	GL.glViewport(0,0,256,256);
	GL.glClearColor(0.3, 0.1, 0.5, 1.0);
	GL.glEnable(GLC.GL_DEPTH_TEST); 
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);
	GL.glColor3f(0,1,0); 
  

	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity();
 
	GL.SetFCR();
		GL.gluPerspective(45., 1.,1., 100.);
	GL.DelFCR();
 
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity();
	x := x+ 0.1;
	GL.SetFCR(); 
		GL.gluLookAt(0, 0, x,   0, 0, 0,   0, 1, 0); (* eye(x,y,z), focal(x,y,z), up(x,y,z) *) 
	GL.DelFCR();
 
	GL.glBegin(GLC.GL_QUADS);
		GL.glColor3f(1., 0., 0.); GL.glVertex3f(-0.75, -0.75, 0.);
		GL.glColor3f(0., 1., 0.); GL.glVertex3f( 0.75, -0.75, 0.);
		GL.glColor3f(0., 0., 1.); GL.glVertex3f( 0.75,  0.75, 0.);
		GL.glColor3f(1., 1., 0.); GL.glVertex3f(-0.75,  0.75, 0.);
	GL.glEnd(); 
 
	GL.glFinish();
	ctxt.SwapBuffers;
END DrawAQuad; 


(** *)
PROCEDURE Test*;
BEGIN
IF disp= NIL THEN
	 NEW(disp);
	disp.Init(256, 256, "MyTestDisplay", TRUE);
	disp.MakeCurrent();
	DrawAQuad(disp);
END;	
END Test;


PROCEDURE CloseDisp*;
BEGIN
IF disp # NIL THEN disp.Close; disp := NIL; END;	
END CloseDisp;

(*

PROCEDURE HideDisp*;
BEGIN
IF disp # NIL THEN disp.Hide; END;	
END HideDisp;

PROCEDURE ShowDisp*;
BEGIN
IF disp # NIL THEN disp.Show; END;	
END ShowDisp;
*)

BEGIN	
	 GL.InitOpenGL;
END GLContext.

GLContext.Test ~ 

(*
GLContext.HideDisp ~ 

GLContext.ShowDisp ~ 

*)

GLContext.CloseDisp ~ 

SystemTools.Free GLContext ~
