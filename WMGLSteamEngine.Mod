MODULE WMGLSteamEngine; (** AUTHOR "fnecati"; PURPOSE "opengl steam engine demo"; *)

(*
	Based on steam.c written by Troy Robinette.
	Miniature Steam Engine Simulation.
*)


IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, SYSTEM, Math:=MathL, KernelLog,
	WM := WMWindowManager,  WMMessages, WMDialogs, Inputs,
	GL := OpenGL, GLC := OpenGLConst, WMGL:=WMGLWindow , Lib := GLLib;

CONST waittime=50;

CONST
	pi = 3.141592653;
	degToRad = pi / 180;

	mag = 120.0;  phase = -4;  arcLen = 2.7;  arcR = 0.15;
	dAngle = 10.0;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		 timer: Kernel.MilliTimer;
		alive, animated: BOOLEAN;
		eyeposz: LONGREAL;
		piston, flywheel: GL.GLuint;
		crankAngle: REAL;
		headAngle: REAL;
		angleY, angleX: REAL;
		obj: GL.TGLUQuadric;

		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			Init(w, h, FALSE); (* use alpha, for 32bpp img *)
			WM.AddWindow(SELF, 100, 100);

			SetTitle(Strings.NewString("WMGLDemoSized"));

			animated := FALSE;

			InitGL;
			Reshape(w, h);
			UpdateImage();
			Invalidate(WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight()));
			alive := TRUE;
		END New;


		PROCEDURE ChangeAngle();
		BEGIN
				crankAngle := crankAngle + dAngle;
				IF crankAngle >= 360.0 THEN crankAngle := crankAngle - 360.0 END;
				headAngle := angles[ENTIER(crankAngle)];
				GL.DelFCR();
				UpdateImage;
		END ChangeAngle;

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
		BEGIN
			CASE CHR(ucs) OF
				"a", "A": animated := ~ animated;
				| "s": SaveImage;
				| "q" : Close;
				| " ": ChangeAngle();
				(*| "w": context.WinInfo();*)

			ELSE
				IF keysym = Inputs.KsUp THEN angleY := angleY - 10.0; GL.DelFCR(); UpdateImage;
				ELSIF keysym = Inputs.KsDown THEN angleY := angleY + 10.0; GL.DelFCR(); UpdateImage;
				ELSIF keysym = Inputs.KsRight THEN angleX := angleX + 10.0; GL.DelFCR();  UpdateImage;
				ELSIF  keysym = Inputs.KsLeft  THEN angleX := angleX - 10.0; GL.DelFCR(); UpdateImage;
				END;
			END;

		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			eyeposz := eyeposz + dz;
			IF eyeposz < -100 THEN eyeposz:= -100.0; END;
			IF eyeposz > 200.0 THEN eyeposz:= 200.0; END;
			GL.DelFCR();
			UpdateImage;
		END WheelMove;

		PROCEDURE Handle(VAR m: WMMessages.Message);
		BEGIN
			IF (m.msgType = WMMessages.MsgExt) & (m.ext # NIL) & (m.ext IS KillerMsg) THEN
				Close;
			ELSE Handle^(m)
			END
		END Handle;

		PROCEDURE Close*;
		BEGIN {EXCLUSIVE}
			alive := FALSE;
			Close^;
		END Close;


		PROCEDURE UpdateImage;
		VAR	rect: WMRectangles.Rectangle;
		BEGIN
			context.MakeCurrent();
				Display;
				context.RenderInto(backImg);
			context.DeActivate();

			Swap;

			(*rect := WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight());
			WMRectangles.MoveRel(rect, bounds.l, bounds.t);
			WMRectangles.ClipRect(rect, bounds);
			manager.AddDirty(rect);
*)
			Invalidate(WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight()));

		END UpdateImage;

		PROCEDURE SaveImage;
		VAR res: LONGINT;
			fname: ARRAY 128 OF CHAR;
		BEGIN

		fname:="mywmgltest.bmp";
		IF WMDialogs.QueryString(" Save File name: ",fname)=WMDialogs.ResOk THEN
				WMGraphics.StoreImage(img, fname,res);
		END;

		END SaveImage;



PROCEDURE  DrawBox(x, y, z: GL.GLdouble);
BEGIN
	GL.glPushMatrix;
		GL.glScaled(x, y, z);
		Lib.SolidCube(1);
	GL.glPopMatrix
END DrawBox;

PROCEDURE  DrawCylinder (outerR, innerR, length: GL.GLdouble);
BEGIN
	GL.glPushMatrix;
		GL.gluCylinder(obj, outerR, outerR, length, 20, 1);

		GL.glPushMatrix;
			GL.glRotatef(180, 0.0, 1.0, 0.0);
			GL.gluDisk(obj, innerR, outerR, 20, 1);
		GL.glPopMatrix;
		GL.glTranslated(0.0, 0.0, length);
		GL.gluDisk(obj, innerR, outerR, 20, 1);
	GL.glPopMatrix
END DrawCylinder;

PROCEDURE  DrawPiston;
BEGIN
	GL.glPushMatrix;
		GL.glColor4f(0.3, 0.6, 0.9, 1.0);

		GL.glPushMatrix;
			GL.glRotatef(90, 0.0, 1.0, 0.0);
			GL.glTranslatef(0.0, 0.0, -0.07);
			DrawCylinder( 0.125, 0.06, 0.12);
		GL.glPopMatrix;

		GL.glRotatef(-90, 1.0, 0.0, 0.0);
		GL.glTranslatef(0.0, 0.0, 0.05);

		DrawCylinder(0.06, 0.0, 0.6);
		GL.glTranslatef(0.0, 0.0, 0.6);
		DrawCylinder(0.2, 0.0, 0.5);
	GL.glPopMatrix
END DrawPiston;

PROCEDURE  DrawEnginePole;
BEGIN
	GL.glPushMatrix;
		GL.glColor4f(0.8, 0.8, 0.6, 1.0);
		DrawBox(0.5, 3.0, 0.5);

		GL.glColor3f(0.5, 0.1, 0.5);
		GL.glRotatef(90, 0.0, 1.0, 0.0);
		GL.glTranslatef(0.0, 0.9, -0.4);

		DrawCylinder(0.1, 0.0, 2);
	GL.glPopMatrix
END DrawEnginePole;

PROCEDURE  DrawCylinderHead;
BEGIN
	GL.glPushMatrix;
		GL.glColor4f(0.5, 1.0, 0.5, 0.1);
		GL.glRotatef(90, 1.0, 0.0, 0.0);
		GL.glTranslatef(0, 0.0, 0.4);
		GL.glRotatef(headAngle, 1, 0, 0);
		GL.glTranslatef(0, 0.0, -0.4);
		DrawCylinder( 0.25, 0.21, 1.6);
		GL.glRotatef(180, 1.0, 0.0, 0.0);
		GL.gluDisk(obj, 0, 0.25, 20, 1);
	GL.glPopMatrix
END DrawCylinderHead;

PROCEDURE  DrawFlywheel;
BEGIN
	GL.glPushMatrix;
		GL.glColor4f(0.5, 0.5, 1.0, 1.0);
		GL.glRotatef(90, 0.0, 1.0, 0.0);
		DrawCylinder( 0.625, 0.08, 0.5);
	GL.glPopMatrix
END DrawFlywheel;

PROCEDURE  DrawCrankBell;
VAR ang: REAL;
BEGIN
	ang := crankAngle - headAngle;
	GL.DelFCR();
	GL.glPushMatrix;
		GL.glColor4f(1.0, 0.5, 0.5, 1.0);
		GL.glRotatef(90.0, 0.0, 1.0, 0.0);
		DrawCylinder(0.3, 0.08, 0.12);

		GL.glColor4f(0.5, 0.1, 0.5, 1.0);
		GL.glTranslatef(0.0, 0.2, 0.0);
		DrawCylinder( 0.06, 0.0, 0.34);

		GL.glTranslatef(0.0, 0.0, 0.22);
		GL.glRotatef(90.0, 0.0, 1.0, 0.0);

		GL.glRotatef(ang, 1.0, 0.0, 0.0);
		GL.glCallList(piston);
	GL.glPopMatrix;
END DrawCrankBell;

PROCEDURE  DrawCrank;
BEGIN
	GL.glPushMatrix;

		GL.glRotatef(crankAngle, 1.0, 0.0, 0.0);

		GL.glPushMatrix();
			GL.glRotatef(90.0, 0.0, 1.0, 0.0);
			GL.glTranslatef(0.0, 0.0, -1.0);
			DrawCylinder( 0.08, 0.0, 1.4);
		GL.glPopMatrix;

		GL.glPushMatrix;
			GL.glTranslatef(0.28, 0.0, 0.0);
			DrawCrankBell;
		GL.glPopMatrix;

		GL.glPushMatrix();
			GL.glTranslatef(-0.77, 0.0, 0.0);
			GL.glCallList(flywheel);
		GL.glPopMatrix;

	GL.glPopMatrix
END DrawCrank;


PROCEDURE  InitGL;
	VAR  matSpecular, lightPos: ARRAY [4] OF GL.GLfloat;
			shininess: GL.GLfloat;
BEGIN
	context.MakeCurrent;

	matSpecular := [1.0, 1.0, 1.0, 1.0];
	shininess := 50.0;

	angleX := 200.0;  angleY := 0.0;
	headAngle := 0.0;  crankAngle := 0.0;
	eyeposz := 1.0;

	GL.glClearColor(0.1, 0.2, 0.2, 0.0);

	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_SPECULAR, SYSTEM.ADR(matSpecular[0]));
	GL.glMaterialf(GLC.GL_FRONT, GLC.GL_SHININESS, shininess);

	(* Set light position that moves with the viewpoint *)
	lightPos := [0.0, 0.0, 1.0, 0.0];  (* In eye coordinates *)
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity;
	GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_POSITION, SYSTEM.ADR(lightPos[0]));


	GL.glEnable(GLC.GL_LIGHTING);
	GL.glEnable(GLC.GL_LIGHT0);
	GL.glDepthFunc(GLC.GL_LEQUAL);
	GL.glEnable(GLC.GL_DEPTH_TEST);
	GL.glDisable(GLC.GL_ALPHA_TEST);

	GL.glColorMaterial(GLC.GL_FRONT_AND_BACK, GLC.GL_DIFFUSE);
	GL.glEnable(GLC.GL_COLOR_MATERIAL);
	GL.glShadeModel(GLC.GL_SMOOTH);

	obj := GL.gluNewQuadric();

	piston := GL.glGenLists(1);
	GL.glNewList(piston, GLC.GL_COMPILE);
		DrawPiston();
	GL.glEndList;

	flywheel := GL.glGenLists(1);
	GL.glNewList(flywheel, GLC.GL_COMPILE);
		DrawFlywheel();
	GL.glEndList;


	context.DeActivate();
END InitGL;


PROCEDURE  Display;
BEGIN

	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

	GL.glPushMatrix;
		GL.glTranslated(0.0, 0.0, eyeposz);
		GL.glRotatef(angleX, 0.0, 1.0, 0.0);
		GL.glRotatef(angleY, 1.0, 0.0, 0.0);

		DrawEnginePole();

		GL.glPushMatrix();
			GL.glTranslatef(0.5, 1.4, 0.0);
			DrawCylinderHead;
		GL.glPopMatrix;

		GL.glPushMatrix();
			GL.glTranslatef(0.0, -0.8, 0.0);
			DrawCrank;
		GL.glPopMatrix;

	GL.glPopMatrix;

END Display;

PROCEDURE  Reshape (w, h: LONGINT);
BEGIN
	 context.MakeCurrent;
	GL.glViewport(0, 0, w, h);

	GL.glMatrixMode (GLC.GL_PROJECTION);
	GL.glLoadIdentity;

	GL.gluPerspective(45.0, 1.0, 0.1, 2000.0);
	GL.DelFCR();
	GL.glMatrixMode (GLC.GL_MODELVIEW);
	GL.glLoadIdentity;

	GL.glTranslated(0.0, 0.0, -10);

	context.DeActivate;
END Reshape;


BEGIN {ACTIVE}

	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN
			IF Kernel.Expired(timer) THEN
				ChangeAngle();
				Kernel.SetTimer(timer, waittime);
			END;
		END;
	END;

END GLWindow;

VAR  angles: ARRAY 360 OF REAL;

PROCEDURE Open*;
VAR
	window: GLWindow;
BEGIN
	NEW(window, 256, 256);
END Open;

PROCEDURE InitAngleTable;
	VAR  i: LONGINT;
BEGIN
	FOR  i := 0 TO 359 DO
		angles[i] := SHORT(mag * Math.arctan( arcR * Math.sin((phase - i) * degToRad) /
						(arcLen - arcR * Math.cos((phase - i) * degToRad))) )
	END
END InitAngleTable;

BEGIN
	InitAngleTable;
END WMGLSteamEngine.

SystemTools.Free  WMGLSteamEngine  WMGLWindow~

WMGLSteamEngine.Open ~

SystemTools.FreeDownTo OpenGL ~

