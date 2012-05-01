MODULE OGLDemo2; (** AUTHOR "fnecati"; PURPOSE "an OGLWindow demo"; *)

IMPORT
	 GL:=OpenGL, GLC := OpenGLConst, OGW := OGLWindow,
	KernelLog ;

TYPE
	MyGLControl = OBJECT(OGW.Window)
	VAR
		eyeposz: LONGREAL;
		anglez: REAL;

	PROCEDURE &New(w, h: LONGINT );
	BEGIN
		Init(w,h, 400,300, FALSE);
			anglez := 30.0;
			eyeposz := 10.0;
		SetTitle("OGLDemo2");
		SetIdleTime(1000); (* set idle time to 50ms *)

		SetGameMode(TRUE);
	END New;

	(** *)
	PROCEDURE IdleDisplay();
	BEGIN
		 ReDisplay();
	END IdleDisplay;

	(** *)
	PROCEDURE Close*;
	BEGIN
		KernelLog.String("Closing.."); KernelLog.Ln;
		Close^;
	END Close;


	PROCEDURE PointerMove* (x, y : LONGINT; keys : SET);
	BEGIN
	(*	KernelLog.String("PointerMove: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerMove;

	PROCEDURE PointerDown* (x, y : LONGINT; keys : SET);
	BEGIN
	(*	KernelLog.String("PointerDown: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerDown;

	PROCEDURE PointerUp* (x, y : LONGINT; keys : SET);
	BEGIN
		(* KernelLog.String("PointerUp: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerUp;

	(** *)
	PROCEDURE WheelMove*(dz: LONGINT);
	BEGIN
		eyeposz := eyeposz + dz;
		IF eyeposz < 0.0 THEN eyeposz := 0.0; END;
		IF eyeposz > 99.0 THEN eyeposz := 99.0; END;
		GL.DelFCR();
		Reshape(width, height);
		ReDisplay;
	END WheelMove;

	(** *)
	PROCEDURE KeyEvent* (ucs : LONGINT; flags : SET; keysym : LONGINT);
	BEGIN
		CASE CHR(ucs) OF

			 "-" : anglez := anglez - 5.0; ReDisplay;
			| "+" : anglez := anglez + 5.0; ReDisplay;
			| "r" : MoveResizeWindow(10,10, 400, 400);
			| "d": SetDecorations(FALSE);
 			| "D": SetDecorations(TRUE);
			| "q" : Close;
		ELSE

		END;
	END KeyEvent ;

	PROCEDURE DrawAQuad();
	BEGIN
		GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

 		GL.glPushMatrix();

 		GL.SetFCR();
			GL.glRotatef(anglez, 0.0, 0.0, 1.0);
 		GL.DelFCR();


 		GL.glBegin(GLC.GL_QUADS);
 		GL.glColor3f(1., 0., 0.); GL.glVertex3f(-0.75, -0.75, 1.);
 		GL.glColor3f(0., 1., 0.); GL.glVertex3f( 0.75, -0.75, 1.);
 		GL.glColor3f(0., 0., 1.); GL.glVertex3f( 0.75,  0.75, 1.);
 		GL.glColor3f(1., 1., 0.); GL.glVertex3f(-0.75,  0.75, 1.);
 		GL.glEnd();

 		GL.glPopMatrix();

	END DrawAQuad;

	PROCEDURE  Cube*;
	BEGIN

	GL.glPushMatrix();
	GL.SetFCR();
		GL.glRotatef(anglez, 1.0, 1.0, 0.0);
	GL.DelFCR();

	GL.glBegin(GLC.GL_POLYGON); (* top face oriented toward y *)
		GL.glColor3f(0.0,0.0,1.0);
		GL.glVertex3f(-1.0, 1.0, 1.0);
		GL.glVertex3f(1.0, 1.0, 1.0);
		GL.glVertex3f(1.0, 1.0, -1.0);
		GL.glVertex3f(-1.0, 1.0, -1.0);
	GL.glEnd();

	GL.glBegin(GLC.GL_POLYGON); (* back face oriented toward -z *)
		GL.glColor3f(0.0,1.0,0.0);
		GL.glVertex3f(-1.0, 1.0, -1.0);
		GL.glVertex3f(1.0, 1.0, -1.0);
		GL.glVertex3f(1.0, -1.0, -1.0);
		GL.glVertex3f(-1.0, -1.0, -1.0);
	GL.glEnd();

	GL.glBegin(GLC.GL_POLYGON); (* right face oriented toward x *)
		GL.glColor3f(1.0,0.0,0.0);
		GL.glVertex3f(1.0, 1.0, 1.0);
		GL.glVertex3f(1.0, -1.0, 1.0);
		GL.glVertex3f(1.0, -1.0, -1.0);
		GL.glVertex3f(1.0, 1.0, -1.0);
	GL.glEnd();

	GL.glBegin(GLC.GL_POLYGON); (* left face oriented toward -x *)
		GL.glColor3f(1.0,0.0,0.0);
		GL.glVertex3f(-1.0, -1.0, 1.0);
		GL.glVertex3f(-1.0, 1.0, 1.0);
		GL.glVertex3f(-1.0, 1.0, -1.0);
		GL.glVertex3f(-1.0, -1.0, -1.0);
	GL.glEnd();

	GL.glBegin(GLC.GL_POLYGON); (* bottom face oriented toward -y *)
		GL.glColor3f(0.0,0.0,1.0);
		GL.glVertex3f(-1.0, -1.0, 1.0);
		GL.glVertex3f(-1.0, -1.0, -1.0);
		GL.glVertex3f(1.0, -1.0, -1.0);
		GL.glVertex3f(1.0, -1.0, 1.0);
	GL.glEnd();

	GL.glBegin(GLC.GL_POLYGON); (* front face oriented toward z*)
		GL.glColor3f(0.0,1.0,0.0);
		GL.glVertex3f(1.0, 1.0, 1.0);
		GL.glVertex3f(-1.0, 1.0, 1.0);
		GL.glVertex3f(-1.0, -1.0, 1.0);
		GL.glVertex3f(1.0, -1.0, 1.0);
	GL.glEnd();

	GL.glPopMatrix;
	END Cube;

	PROCEDURE Display;
	BEGIN
		DrawAQuad();
		Cube();
		SwapBuffers();
		 anglez := anglez + 5.0;

	END Display;


	PROCEDURE Reshape(w, h: LONGINT);
	BEGIN
		GL.glViewport(0, 0, w, h) ;
		GL.glClearColor(0.0, 0.0 ,0.0, 1.0) ;

		GL.glEnable(GLC.GL_DEPTH_TEST);

		GL.glMatrixMode(GLC.GL_PROJECTION);
		GL.glLoadIdentity();
		GL.gluPerspective(45.0, 1.0, 0.1, 100.0);

		GL.glMatrixMode(GLC.GL_MODELVIEW);
		GL.glLoadIdentity();

		GL.SetFCR();
			GL.gluLookAt(0.0, 0.0, eyeposz, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
		GL.DelFCR();
	END Reshape;

	BEGIN
		MainLoop();
	END MyGLControl;

PROCEDURE Open*;
VAR
	mywin: MyGLControl;
BEGIN
	NEW(mywin, 300,300);
END Open;

BEGIN
END OGLDemo2.

	OGLDemo2.Open~

SystemTools.Free OGLDemo2 OGLWindow~

SystemTools.FreeDownTo  OpenGL ~ 