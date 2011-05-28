MODULE MyXGear; (** AUTHOR "fnecati"; PURPOSE "Adjusted for commandline run"; *)

IMPORT
	X11, Api := MyX11Api, GL:=OpenGL, GLC := OpenGLConst, Kernel, 
	Trace,  Math ,  SYSTEM ;

(* 
Opens a native X11 window and renders. 
From command line, linux terminal, run with : aos  -x  MyXGear.Test 
or 
 from oberon window:   MyXGear.Open ~
*)

CONST 
	debug = FALSE; (* for window creation/closing *)
	debugevents = FALSE; (* for testing events *)
	pi = Math.pi;
	
VAR
	
	timer : Kernel.MilliTimer; 
	
	(* window variables *)
	display : X11.DisplayPtr;
	win : X11.Window ;
	visinfoptr : Api.VisualInfoPtr; (* pointer to X11 VisualInfo *)
	glctx : GL.GLXContext;  (* GL context *)
	
	(*	gc : X11.GC; (* graphics context, may be useful for X11 drawing operations *)	*)
	
	gwa : Api.XWindowAttributes; (* get window attributes *) 	
	swa : Api.XSetWindowAttributes; (* set window attributes*)
	cmap : X11.Colormap; (* colormap for window *)
	
	width, height : LONGINT; (* size of window *)
	alive : BOOLEAN; (* for main loop control *)	
	  
	  
  (*  gear variables *)
  	gear1, gear2, gear3: GL.GLuint;
  	rotx, roty, rotz, angle: GL.GLfloat;	

PROCEDURE  MakeGear (innerRadius, outerRadius, width: GL.GLfloat; teeth: LONGINT;  toothDepth: GL.GLfloat);
VAR  r0, r1, r2 , angle, da, u, v, len: GL.GLfloat;
	  i: LONGINT;
BEGIN 
	
	r0 := innerRadius;
	r1 := outerRadius - toothDepth / 2.0;
	r2 := outerRadius + toothDepth / 2.0;
	
	da := 2.0 * pi / teeth / 4.0;
	
	GL.glShadeModel(GLC.GL_FLAT);

	GL.glNormal3f(0.0, 0.0, 1.0);

	(* draw front face *)
	GL.glBegin(GLC.GL_QUAD_STRIP);

	FOR  i := 0 TO teeth DO 
			angle := i * 2.0 * Math.pi / teeth;
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), width * 0.5);
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), width * 0.5);
	END;
	GL.glEnd;

	(* draw front sides of teeth *)
	GL.glBegin(GLC.GL_QUADS);
		da := 2.0 * Math.pi / teeth / 4.0;
		FOR  i := 0 TO teeth - 1 DO 
			angle := i * 2.0 * Math.pi / teeth;
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + da), r2 * Math.sin(angle + da), width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + 2 * da), r2 * Math.sin(angle + 2 * da), width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), width * 0.5);
		END;
	GL.glEnd;

	GL.glNormal3f(0.0, 0.0, -1.0);

	(* draw back face *)
	GL.glBegin(GLC.GL_QUAD_STRIP);

	 FOR i := 0 TO teeth DO 
			angle := i * 2.0 * Math.pi / teeth;
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), -width * 0.5);
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), -width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), -width * 0.5);
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), -width * 0.5);
	END;
	GL.glEnd;

	(* draw back sides of teeth *)
	GL.glBegin(GLC.GL_QUADS);
		da := 2.0 * Math.pi / teeth / 4.0;
		FOR i := 0 TO teeth - 1 DO
			angle := i * 2.0 * Math.pi / teeth;
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), -width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + 2 * da), r2 * Math.sin(angle + 2 * da), -width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + da), r2 * Math.sin(angle + da), -width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), -width * 0.5);
	END;
	GL.glEnd;

	(* draw outward faces of teeth *)
	GL.glBegin(GLC.GL_QUAD_STRIP);

	FOR i := 0 TO teeth - 1 DO 
			angle := i * 2.0 * Math.pi / teeth;
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle), r1 * Math.sin(angle), -width * 0.5);
			u := r2 * Math.cos(angle + da) - r1 * Math.cos(angle);
			v := r2 * Math.sin(angle + da) - r1 * Math.sin(angle);
			len := Math.sqrt(u * u + v * v);
			u := u / len;  v := v / len;
			GL.glNormal3f(v, -u, 0.0);
			GL.glVertex3f(r2 * Math.cos(angle + da), r2 * Math.sin(angle + da), width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + da), r2 * Math.sin(angle + da), -width * 0.5);
			GL.glNormal3f(Math.cos(angle), Math.sin(angle), 0.0);
			GL.glVertex3f(r2 * Math.cos(angle + 2 * da), r2 * Math.sin(angle + 2 * da), width * 0.5);
			GL.glVertex3f(r2 * Math.cos(angle + 2 * da), r2 * Math.sin(angle + 2 * da), -width * 0.5);
			u := r1 * Math.cos(angle + 3 * da) - r2 * Math.cos(angle + 2 * da);
			v := r1 * Math.sin(angle + 3 * da) - r2 * Math.sin(angle + 2 * da);
			GL.glNormal3f(v, -u, 0.0);
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), width * 0.5);
			GL.glVertex3f(r1 * Math.cos(angle + 3 * da), r1 * Math.sin(angle + 3 * da), -width * 0.5);
			GL.glNormal3f(Math.cos(angle), Math.sin(angle), 0.0);
	END;

	GL.glVertex3f(r1 * Math.cos(0), r1 * Math.sin(0), width * 0.5);
	GL.glVertex3f(r1 * Math.cos(0), r1 * Math.sin(0), -width * 0.5);

	GL.glEnd;

	GL.glShadeModel(GLC.GL_SMOOTH);

	(* draw inside radius cylinder *)
	GL.glBegin(GLC.GL_QUAD_STRIP);
	FOR i := 0 TO teeth DO
			angle := i * 2.0 * Math.pi / teeth;
			GL.glNormal3f(-Math.cos(angle), -Math.sin(angle), 0.0);
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), -width * 0.5);
			GL.glVertex3f(r0 * Math.cos(angle), r0 * Math.sin(angle), width * 0.5);
	END;	
	GL.glEnd;
END MakeGear;

PROCEDURE  InitGears;
VAR
	red, green, blue, lightPos: ARRAY [4] OF GL.GLfloat; 
	
BEGIN 
	rotx := 20;  roty := 30;  rotz := 0;  angle := 20;

(*	(* lightPos := [ 5.0, 5.0, 10.0, 1.0];*)
	lightPos := [ 1.0, 1.0, 1.0, 0.0];  (* directional *)
	red := [ 0.8, 0.1, 0.0, 1.0];  
	green := [ 0.0, 0.8, 0.2, 1.0];  
	blue := [ 0.2, 0.2, 1.0, 1.0];
*)

    lightPos[0] := 1.0;	lightPos[1] := 1.0;  lightPos[2] := 1.0; lightPos[3] := 0.0;
    red[0] := 0.8; red[1] := 0.1; red[2] := 0.0; red[3] := 1.0;
    green[0] := 0.0; green[1] := 0.8; green[2] := 0.2; green[3] := 1.0;
    blue[0] := 0.2; blue[1] := 0.2; blue[2] := 1.0; blue[3] := 1.0;

	GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_POSITION, SYSTEM.ADR(lightPos[0]));
	GL.glEnable(GLC.GL_CULL_FACE);
	GL.glEnable(GLC.GL_LIGHTING);			
	GL.glEnable(GLC.GL_LIGHT0);
	GL.glEnable(GLC.GL_DEPTH_TEST);
	
	(* make the gears *)
	gear1 := GL.glGenLists(1);
	GL.glNewList(gear1, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, SYSTEM.ADR(red[0]));
	MakeGear( 1.0, 4.0, 1.0, 20, 0.7);
	GL.glEndList;

	
	gear2 := GL.glGenLists(1);
	GL.glNewList(gear2, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, SYSTEM.ADR(green[0]));
	MakeGear( 0.5, 2.0, 2.0, 10, 0.7);
	GL.glEndList;

	
	gear3 := GL.glGenLists(1);	
	GL.glNewList(gear3, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, SYSTEM.ADR(blue[0]));
	MakeGear(1.3, 2.0, 0.5, 10, 0.7);
	GL.glEndList;

	 GL.glEnable(GLC.GL_NORMALIZE); 		
END InitGears;

PROCEDURE DrawGears();
VAR angle1, angle2: REAL;
BEGIN

angle1 := -2.0 * angle - 9.0;
angle2 := -2.0 * angle - 25.0;

GL.SetFCR(); 
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

	GL.glPushMatrix;
	
	GL.glRotatef(rotx, 1.0, 0.0, 0.0);
	GL.glRotatef(roty, 0.0, 1.0, 0.0);
	GL.glRotatef(rotz, 0.0, 0.0, 1.0);
	
	
	GL.glPushMatrix;
	GL.glTranslatef(-3.0, -2.0, 0.0);
	GL.glRotatef(angle, 0.0, 0.0, 1.0);
	GL.glCallList(gear1);
	GL.glPopMatrix;
	
	GL.glPushMatrix;
	GL.glTranslatef(3.1, -2.0, 0.0);
	GL.glRotatef(angle1, 0.0, 0.0, 1.0);
	GL.glCallList(gear2);
	GL.glPopMatrix;
	
	GL.glPushMatrix;
	GL.glTranslatef(-3.1, 4.2, 0.0);
	GL.glRotatef(angle2, 0.0, 0.0, 1.0);
	GL.glCallList(gear3);
	GL.glPopMatrix;

	GL.glPopMatrix;	

 GL.DelFCR();
 
     GL.glXSwapBuffers(display, win);
END DrawGears;

PROCEDURE Reshape(w, h: LONGINT);
BEGIN	
GL.SetFCR();
	GL.glViewport(0, 0, w, h);
	GL.glClearColor(0.0, 0.0, 0.0, 0.0);
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity();
	GL.glFrustum(-1,1,-1,1, 5, 60); 
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity(); 
	GL.glTranslatef(0.0, 0.0, -40.0);
GL.DelFCR();
END Reshape;

(* close the window and its resources *)
 PROCEDURE Close;
  VAR res: LONGINT;
 BEGIN    	
	(* do we have a rendering context *)
	IF glctx # 0 THEN
		(* Release the context *)
	    	res := GL.glXMakeCurrent(display, 0, 0);
	    	(* Delete the context *)
		GL.glXDestroyContext(display, glctx);
		glctx := 0;
		IF debug THEN Trace.String("context deleted"); Trace.Ln; END;
	END;
	
	(* do we have a window *)
	IF win # 0 THEN
		(* Unmap the window*)
		Api.UnmapWindow(display, win);
		(* Destroy the window *)
		res:= Api.DestroyWindow(display, win);
		win := 0;
		IF debug THEN Trace.String("window deleted"); Trace.Ln; END;
	END;
	
	(* do we have a display *)
	IF display # 0 THEN	
		res := Api.CloseDisplay(display);
		display := 0;
		IF debug THEN Trace.String("display deleted"); Trace.Ln; END;
	END;
	
 END Close;
 
PROCEDURE  InitWindow(w, h: LONGINT; CONST title: ARRAY OF CHAR);
VAR 
	res: LONGINT;
	masks: SET;
	buf: X11.Buffer;
	attrib : ARRAY [*] OF GL.GLint;  (* attributes of GL window *) 

BEGIN
 display := X11.OpenDisplay(0);
 IF display =0 THEN
 	Trace.String(" cannot connect to X server"); Trace.Ln; 
	Close;
     RETURN;
END;  
  	   
(*  NEW(attrib, 7);
  attrib[0] := GLC.GLX_RGBA; 
  attrib[1] := GLC.GLX_DEPTH_SIZE; attrib[2] := 24; 
  attrib[3] := GLC.GLX_STENCIL_SIZE; attrib[4] := 8; 
  attrib[5] := GLC.GLX_DOUBLEBUFFER; attrib[6] := 0 ;
*)
(*
 attrib := [GLC.GLX_RGBA, GLC.GLX_DOUBLEBUFFER, GLC.GLX_DEPTH_SIZE,  24, 0];
 *)
  NEW(attrib, 13);
  attrib[0] := GLC.GLX_RGBA;
  attrib[1] := GLC.GLX_DOUBLEBUFFER;
  attrib[2] := GLC.GLX_DEPTH_SIZE;	attrib[3] := 24; 
  attrib[4] := GLC.GLX_STENCIL_SIZE;	attrib[5] := 8; 
  attrib[6] := GLC.GLX_RED_SIZE;  	attrib[7] := 8;
  attrib[8] := GLC.GLX_GREEN_SIZE;	attrib[9] := 8;
  attrib[10] := GLC.GLX_RED_SIZE;	attrib[11] := 8;
  attrib[12] := 0 ;

 (* try to find a visual with this attribs *)	
 visinfoptr := GL.glXChooseVisual(display, 0 , SYSTEM.ADR(attrib[0]));
 
 IF visinfoptr = NIL THEN
  	IF debug THEN Trace.String(" NO appropriate visual found"); Trace.Ln; END;
  	Close;
     RETURN;
 ELSE 
	 IF debug THEN 
		 Trace.String("visinfoptr.depth= "); Trace.Int(visinfoptr.depth,0); Trace.Ln;
	 	Trace.String("visinfoptr.visual ");  Trace.Int(visinfoptr.visualID, 0); Trace.Ln; 
	END;
END;

 cmap := X11.CreateColormap(display, X11.DefaultRootWindow(display), visinfoptr.visual, X11.AllocNone);
 IF cmap = 0 THEN
 	IF debug THEN 
	 	Trace.String(" cannot create colormap"); Trace.Ln; 
	 	X11.GetErrorText(display, cmap, buf, LEN(buf));
	 	Trace.String("ERROR: CreateColormap = "); Trace.String(buf); Trace.Ln;
 	END;
 END;

 (* window event masks *)	
 masks :=  Api.KeyPressMask + Api.KeyReleaseMask + Api.ButtonPressMask + Api.ButtonReleaseMask + Api.PointerMotionMask
 + Api.ButtonMotionMask + Api.ExposureMask + Api.StructureNotifyMask + Api.FocusChangeMask;

  (* window attributes *)
 swa.background_pixel := 0;
 swa.border_pixel := 0;
 swa.colormap := cmap;
 swa.event_mask := masks;
 
 masks := { Api.CWBackPixel, Api.CWBorderPixel, Api.CWColormap, Api.CWEventMask};
 
 win := Api.CreateWindow(display, X11.DefaultRootWindow(display), 0, 0, w, h,
		        0, visinfoptr.depth, Api.InputOutput,  visinfoptr.visual, masks, SYSTEM.ADR(swa));

(* 
gc := X11.CreateGC( display, win, 0, 0 );
IF gc = 0 THEN  
  	IF debug THEN Trace.String(' could not create X11 graphics context '); Trace.Ln; END;	
END;
	X11.SetPlaneMask( display, gc, ASH( 1, 24 ) - 1);
	X11.SetGraphicsExposures( display, gc, X11.True );
	X11.SetBackground( display, gc, 0FFH );
*)

 (* show window *)	
  Api.MapWindow(display, win);

 (* set title of window *)	 
 res := Api.StoreName(display, win, title); 

(* create GL context *)
 (* GL_TRUE: Use direct rendering, GL_FLASE: use X server for rendering *)
 glctx := GL.glXCreateContext(display, visinfoptr, 0, GLC.GL_TRUE); 
	 IF debug THEN Trace.String("glXCreateContext glctx= "); Trace.Int(glctx, 0); Trace.Ln; END;
  
 res := GL.glXMakeCurrent(display, win, glctx);
	IF debug THEN  Trace.String("glXMakeCurrent res= "); Trace.Int(res, 0); Trace.Ln; END;

END InitWindow;

PROCEDURE Wr(CONST str: ARRAY OF CHAR);
BEGIN
	IF debugevents THEN Trace.StringLn(str); Trace.Ln END;
END Wr;

(* process pending X11 events *)
PROCEDURE LoopForEvents;
VAR xev: X11.Event;
	res: LONGINT;
BEGIN
 WHILE Api.Pending(display)>0 DO 
	X11.NextEvent(display, xev);
			CASE xev.typ OF
			X11.Expose:
					res := Api.GetWindowAttributes(display, win, SYSTEM.ADR(gwa));					
					Reshape(gwa.width, gwa.height);
					Wr("Expose");
			| X11.KeyPress:	Wr("KeyPressed");
							alive := FALSE;
			| X11.KeyRelease:	Wr("KeyReleased");
			| X11.ButtonPress: Wr("ButtonPressed");
			| X11.ButtonRelease: Wr("ButtonRelease");
			| X11.MotionNotify: Wr("MotionNotify");
			| X11.FocusIn: Wr("FocusIn");
			| X11.FocusOut: Wr("FocusOut");
			| X11.GraphicsExpose: Wr("GraphicsExpose");
			| X11.NoExpose: Wr("NoExpose");
			| X11.UnmapNotify: Wr("UnmapNotify");
			| X11.MapNotify: Wr("MapNotify");
			| X11.PropertyNotify: Wr("PropertyNotify");						
			| X11.SelectionClear: Wr("SelectionClear");
			| X11.SelectionRequest: Wr("SelectionRequest");
			| X11.SelectionNotify: Wr("SelectionNotify");				

			(* and others .... *)
			| X11.ClientMessage: Wr("ClientMessage");
			| X11.MappingNotify: Wr("MappingNotify");
			ELSE	
			END;	
	   	END;
END LoopForEvents;

(* windows main loop *)
PROCEDURE MainLoop;
VAR	frames : LONGINT; 	
BEGIN
frames := 0;
Kernel.SetTimer(timer, 5000);
alive := TRUE;

WHILE  alive  DO 
		(* process X11 events *)
		LoopForEvents;

		DrawGears();
		angle := angle + 0.05;

		 (* measure timing info *)
		INC(frames);
		IF Kernel.Expired(timer) THEN
			Trace.Int(frames,0); Trace.String(" frames in 5 secs."); 
			Trace.String(" FPS = "); Trace.Int(frames DIV 5,0); 
			Trace.Ln;
			Kernel.SetTimer(timer,5000);
			frames := 0;
		END;
END;

END MainLoop;

PROCEDURE Open*;
BEGIN
	width := 300; height := 300;
	InitWindow(width, height, 'Oberon GL Gears' );
    	
	InitGears(); 
	Reshape(width, height ); 
	
	(* enter to main loop *)
	MainLoop;

	(* finally close the window *)
	Close;
END Open;


BEGIN	
GL.InitOpenGL;
END MyXGear.

MyXGear.Open~

SystemTools.Free MyXGear ~ 