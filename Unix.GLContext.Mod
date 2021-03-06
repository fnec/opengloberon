MODULE GLContext; (** AUTHOR "fnecati"; PURPOSE "OpenGL Context using GLXPixmap for LinuxAos"; *)

IMPORT
	Machine, X11, GL:=OpenGL, GLC := OpenGLConst, Raster,
	KernelLog, SYSTEM;

(*! resizeble context using X11 Pixmap *)

CONST debug = FALSE;

TYPE
	WindowStruct *= POINTER TO RECORD
		display- : X11.DisplayPtr;
		root: X11.Window;
		glctx- : GL.GLXContext;
		width-, height-: SIZE;
		visualInfoPtr- : X11.VisualInfoPtr;
		pixmap-: X11.Pixmap;
		glxpixmap-: GL.GLXPixmap;
	END;

	Buffer* = POINTER TO ARRAY OF CHAR;

TYPE Context* = OBJECT
	VAR
		glWin-: WindowStruct;
	 	buffer: Buffer; (* for speedup flip image in y*)

	PROCEDURE Init*(w, h: SIZE);
	VAR
		resb: X11.Bool;
		att: ARRAY 13 OF GL.Int;
	  	dumy1, dumy2: SIGNED32;

	BEGIN
		NEW(glWin);
		glWin.width := w; glWin.height := h;
		Machine.Acquire( Machine.X11 );

	(*  get a connection *)
		glWin.display := X11.OpenDisplay("");
		IF glWin.display = NIL THEN
 			Machine.Release( Machine.X11 );
 			KernelLog.String(" cannot connect to X server"); KernelLog.Ln;
			Close;
			RETURN;
		END;

		(* Check if GLX is supported on this display *)
		resb := GL.glXQueryExtension( glWin.display, dumy1, dumy2);
		IF resb = 0  THEN
			Machine.Release( Machine.X11 );
		       KernelLog.String("GLX is NOT supported on this display"); KernelLog.Ln;
		       Close;
			RETURN
		END;

(*		NEW(att, 13); *)
		att[0] := GLC.GLX_RGBA;
		att[1] := GLC.GLX_DOUBLEBUFFER;
		att[2] := GLC.GLX_DEPTH_SIZE;	att[3] := 24;
		att[4] := GLC.GLX_STENCIL_SIZE;	att[5] := 8;
		att[6] := GLC.GLX_RED_SIZE;  	att[7] := 8;
		att[8] := GLC.GLX_GREEN_SIZE;	att[9] := 8;
		att[10] := GLC.GLX_BLUE_SIZE;	att[11] := 8;
		att[12] := 0 ;


		glWin.visualInfoPtr := GL.glXChooseVisual(glWin.display, 0, ADDRESSOF(att[0]));

		IF glWin.visualInfoPtr = NIL THEN
			Machine.Release( Machine.X11 );
			KernelLog.String(" NO appropriate visual found"); KernelLog.Ln;
			Close;
			RETURN;
		ELSE
			IF debug THEN
				KernelLog.String("visualInfoPtr.depth: "); KernelLog.Int(glWin.visualInfoPtr.depth,0); KernelLog.Ln;
			 	KernelLog.String("visualInfoPtr.visual: "); KernelLog.Hex(glWin.visualInfoPtr.visualID, -4); KernelLog.Char("H"); KernelLog.Ln;
			 	KernelLog.String("visualInfoPtr.screen: ");  KernelLog.Int(glWin.visualInfoPtr.screen, 0); KernelLog.Ln;
			 END;
		END;

		glWin.root := X11.DefaultRootWindow(glWin.display);
		glWin.pixmap := X11.CreatePixmap(glWin.display, glWin.root, w(SIGNED16), h(SIGNED16), glWin.visualInfoPtr.depth);
		IF glWin.pixmap = NIL THEN
			Machine.Release( Machine.X11 );
			KernelLog.String(" glWin.pixmap ERROR"); KernelLog.Ln;
			Close;
			RETURN;
		END;

		glWin.glxpixmap := GL.glXCreateGLXPixmap(glWin.display, glWin.visualInfoPtr, glWin.pixmap);

		IF glWin.glxpixmap = NIL THEN
			Machine.Release( Machine.X11 );
			KernelLog.String("glWin.glxpixmap ERROR"); KernelLog.Ln;
			Close;
			RETURN;
		END;
(*		GL.glXWaitX();
		 X11.Sync(glWin.display,X11.False);
*)
	 	(* create GL context *)
	 	(* GL_TRUE: Use direct rendering, GL_FLASE: use X server for rendering *)
	 	glWin.glctx := GL.glXCreateContext(glWin.display, glWin.visualInfoPtr, 0, GLC.GL_TRUE);
	 	IF glWin.glctx = NIL THEN
	 		Machine.Release( Machine.X11 );
			KernelLog.String("could not create context");
			Close;
			RETURN;
		END;


(*	 	resb := GL.glXMakeCurrent(glWin.display, glWin.glxpixmap, glWin.glctx);
	 	IF debug THEN
			KernelLog.String("glXMakeCurrent res= "); KernelLog.Boolean(resb = 1); KernelLog.Ln;
	 	END;
*)
	 	X11.Flush(glWin.display);
(*	 	GL.glXWaitX();*)
		Machine.Release( Machine.X11 );

		IF debug THEN KernelLog.String("GL.glXIsDirect(glWin.display, glWin.lctx)= "); KernelLog.Boolean(GL.glXIsDirect(glWin.display, glWin.glctx) = 1); KernelLog.Ln; END;

		NEW(buffer, w*h*4); (* create RGBA buffer for render operations *)

		(* after creating context, load OpenGL core functions *)
	(*	GL.ReadOpenGLCore(); *)

	END Init;

		(** Close the window *)
	PROCEDURE Close*;
	BEGIN (*{EXCLUSIVE} *)
		CloseWindow();
	END Close;

	PROCEDURE CloseWindow;
	VAR resb: X11.Bool; res: INTEGER;
	BEGIN
		Machine.Acquire( Machine.X11 );
		GL.glXWaitGL();
		GL.glXWaitX();
		X11.Sync(glWin.display,X11.False);

		(* do we have a rendering context *)
		IF glWin.glctx # NIL THEN
			(* Release the context *)
			resb := GL.glXMakeCurrent(glWin.display, NIL, NIL);
			(* Delete the context *)
			GL.glXDestroyContext(glWin.display, glWin.glctx);
			IF debug THEN KernelLog.String("context deleted"); KernelLog.Ln; END;
		END;

		(* do we have a window *)
		IF glWin.glxpixmap # NIL THEN
			GL.glXDestroyGLXPixmap(glWin.display, glWin.glxpixmap);
			IF debug THEN KernelLog.String("GLXPixmap deleted"); KernelLog.Ln; END;
		END;

		(* do we have a window *)
		IF glWin.pixmap # NIL THEN
			X11.FreePixmap(glWin.display, glWin.pixmap);
			IF debug THEN KernelLog.String("X11-Pixmap deleted"); KernelLog.Ln; END;
		END;

		(* do we have a display *)
		IF glWin.display # NIL THEN
			 res := X11.CloseDisplay(glWin.display);
			IF debug THEN KernelLog.String("display deleted"); KernelLog.Ln; END;
		END;
		glWin := NIL;
		Machine.Release( Machine.X11 );
 	END CloseWindow;

	(** *)
	PROCEDURE CreatePixmaps(w, h: SIZE);
	VAR resb: X11.Bool;
	BEGIN
		Machine.Acquire( Machine.X11 );
		resb := GL.glXMakeCurrent(glWin.display, NIL, NIL);
		(* first delete these, do we have a gxpixmap *)
		IF glWin.glxpixmap # NIL THEN
			GL.glXDestroyGLXPixmap(glWin.display, glWin.glxpixmap);
			IF debug THEN KernelLog.String("GLXPixmap deleted"); KernelLog.Ln; END;
		END;

		(* do we have a pixmap *)
		IF glWin.pixmap # NIL THEN
			X11.FreePixmap(glWin.display, glWin.pixmap);
			IF debug THEN KernelLog.String("X11-Pixmap deleted"); KernelLog.Ln; END;
		END;

		(* now create them *)
		glWin.pixmap := X11.CreatePixmap(glWin.display, glWin.root, w(SIGNED16), h(SIGNED16), glWin.visualInfoPtr.depth);
		IF glWin.pixmap = NIL THEN
			KernelLog.String(" glWin.pixmap ERROR"); KernelLog.Ln;
			Machine.Release( Machine.X11 );
			RETURN ;
		END;

		glWin.glxpixmap := GL.glXCreateGLXPixmap(glWin.display, glWin.visualInfoPtr, glWin.pixmap);

		IF glWin.glxpixmap = NIL THEN
			KernelLog.String("glWin.glxpixmap ERROR"); KernelLog.Ln;
			Machine.Release( Machine.X11 );
			RETURN;
		END;
		Machine.Release( Machine.X11 );
	END CreatePixmaps;

	PROCEDURE GetDisplay*(): ADDRESS;
	BEGIN
		RETURN glWin.display;
	END GetDisplay;

	PROCEDURE GetContext*(): ADDRESS;
	BEGIN
		RETURN glWin.glctx;
	END GetContext;

	PROCEDURE GetScreen*(): SIGNED32;
	BEGIN
		RETURN 0; (*context.glWin.screen*)
	END GetScreen;

	PROCEDURE Resize*(w, h: SIZE);
	BEGIN {EXCLUSIVE}	
		IF (glWin.width = w) & (glWin.height = h) THEN RETURN END;
		buffer := NIL;
		NEW(buffer, w*h*4);
		CreatePixmaps(w, h);			
		glWin.width := w; glWin.height := h;
		IF debug THEN
			KernelLog.String("context.resize w, h = "); KernelLog.Int(w, 0); KernelLog.Int(h, 10); KernelLog.Ln;
		END;
	END Resize;

	PROCEDURE MakeCurrent*();
	 VAR resb: X11.Bool;
	 BEGIN
		Machine.Acquire( Machine.X11 );
(*		GL.glXWaitX();
		X11.Sync(glWin.display,X11.False);
*)
		resb := GL.glXMakeCurrent(glWin.display, glWin.glxpixmap, glWin.glctx);
 		Machine.Release( Machine.X11 );
		 IF debug THEN KernelLog.String(" MakeCurrent:"); KernelLog.Boolean(resb= 1); KernelLog.Ln; END;
	END MakeCurrent;

	PROCEDURE DeActivate*();
 	VAR resb: X11.Bool;
 	BEGIN
		Machine.Acquire( Machine.X11 );
(*		GL.glXWaitX();
		X11.Sync(glWin.display,X11.False);
*)
		resb := GL.glXMakeCurrent(glWin.display, 0, 0);
		Machine.Release( Machine.X11 );
		IF debug THEN KernelLog.String(" DeActivate:"); KernelLog.Boolean(resb = 1); KernelLog.Ln; END;
	END DeActivate;

	PROCEDURE RenderInto*(image: Raster.Image);
	VAR
		i: SIZE;
		w, h, bytes: SIZE;
		sadr, dadr: ADDRESS;
	BEGIN
		(* KernelLog.String("context.RenderInto ..."); KernelLog.Ln; *)
		IF (image = NIL) OR (image.adr = NIL) THEN RETURN END;
		w := image.width; h := image.height;
		(* KernelLog.String("renderinto w, h = "); KernelLog.Int(w, 0); KernelLog.Int(h, 10); KernelLog.Ln;  *)
		Machine.Acquire( Machine.X11 );
		GL.glXWaitGL();
		GL.ReadPixels(0, 0, w(GL.Sizei), h(GL.Sizei), GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, ADDRESSOF(buffer^[0]) );
		Machine.Release( Machine.X11 );

		(* flip vertical, y *)
		bytes := w*4;
		sadr := ADDRESSOF(buffer[bytes*(h-1)]); dadr := image.adr;
		FOR i := 0 TO h - 1 DO
			SYSTEM.MOVE(sadr - i*bytes, dadr + i*bytes, bytes);
		END;
		(* KernelLog.String("context.RenderInto Finished"); KernelLog.Ln;  *)
	END RenderInto;

BEGIN
END Context;

BEGIN
END GLContext.

System.Free GLContext ~
