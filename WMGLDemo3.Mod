MODULE WMGLDemo3; (** AUTHOR "fnecati"; PURPOSE "opengl glxgears implementation"; *)

IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Math, SYSTEM,
	WM := WMWindowManager,  WMMessages, WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, WMGL:=WMGLWindow;

CONST waittime = 20;
		pi = Math.pi;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		 timer: Kernel.MilliTimer;
		alive, animated: BOOLEAN;
		ztrans: REAL;

		(* for gears *)
		light: BOOLEAN;
		drawMode: LONGINT;
	  	gear1, gear2, gear3: GL.GLuint;
	  	rotx, roty, rotz, angle, angley: GL.GLfloat;

		PROCEDURE &New(w, h: LONGINT);
		BEGIN

			Init(w, h, FALSE); (* use alpha, for 32bpp img *)

			WM.AddWindow(SELF, 100, 100);

			SetTitle(Strings.NewString("WMGLDemo3: Gears "));
			angle := 0.0;
			angley := 0.0;
			ztrans := -40.0;
			light := TRUE;
			drawMode := 0;
			InitGears;
			Reshape(w,h);
			UpdateImage;

			animated := FALSE;
			alive := TRUE;
		END New;

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
		BEGIN

		CASE CHR(ucs) OF
			"a", "A": animated := ~ animated;

			| "d": drawMode := (drawMode+1) MOD 3; DrawMode(drawMode); UpdateImage;
			| "l": light := ~ light;
					context.MakeCurrent();
					IF light THEN GL.glEnable(GLC.GL_LIGHTING ); ELSE  GL.glDisable(GLC.GL_LIGHTING ); END;
					context.DeActivate();
					UpdateImage;
			| "y": angley := angley + 5.0; UpdateImage;
			| "-" : angle := angle - 1.0; UpdateImage;
			| "+" : angle := angle + 1.0; UpdateImage;

			| "s": SaveImage;
			| "q" : Close;
		ELSE

		END;
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			ztrans := ztrans + dz;
			IF ztrans > -1.0 THEN ztrans := -1.0; END;
			IF ztrans <-100.0 THEN ztrans := -100.0; END;
			Reshape(GetWidth(), GetHeight());
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
			window := NIL;
		END Close;


		PROCEDURE UpdateImage;
		BEGIN
			context.MakeCurrent();
			DrawGears;
			context.RenderInto(backImg);
			context.DeActivate();
			Swap();
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

	PROCEDURE DrawMode(dm: LONGINT);
	VAR drawMode: LONGINT;
	BEGIN
		drawMode := dm;
		context.MakeCurrent();

	        IF drawMode = 0 THEN       (* fill mode*)
	            GL.glPolygonMode(GLC.GL_FRONT_AND_BACK, GLC.GL_FILL);
	            GL.glEnable(GLC.GL_DEPTH_TEST);
	            GL.glEnable(GLC.GL_CULL_FACE);
	        ELSIF drawMode = 1 THEN  (* wireframe mode *)
	            GL.glPolygonMode(GLC.GL_FRONT_AND_BACK, GLC.GL_LINE);
	            GL.glDisable(GLC.GL_DEPTH_TEST);
	            GL.glDisable(GLC.GL_CULL_FACE);
	        ELSE                    (* point mode *)

	            GL.glPolygonMode(GLC.GL_FRONT_AND_BACK, GLC.GL_POINT);
	            GL.glDisable(GLC.GL_DEPTH_TEST);
	            GL.glDisable(GLC.GL_CULL_FACE);
		  END;

		 context.DeActivate();;

	END DrawMode;

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
		GL.glFinish();

	END MakeGear;

	PROCEDURE  InitGears;
	VAR
		red, green, blue, lightPos: ARRAY [4] OF GL.GLfloat;

	BEGIN
		rotx := 20;  roty := 30;  rotz := 0;  angle := 20;

		(* Init view *)

		(* lightPos := [ 5.0, 5.0, 10.0, 1.0];*)
	(*	lightPos := [ 1.0, 1.0, 1.0, 0.0];  (* directional *)
		red := [ 0.8, 0.1, 0.0, 1.0];
		green := [ 0.0, 0.8, 0.2, 1.0];
		blue := [ 0.2, 0.2, 1.0, 1.0];
	*)
	    lightPos[0] := 1.0;	lightPos[1] := 1.0;  lightPos[2] := 1.0; lightPos[3] := 0.0;
	    red[0] := 0.8; red[1] := 0.1; red[2] := 0.0; red[3] := 1.0;
	    green[0] := 0.0; green[1] := 0.8; green[2] := 0.2; green[3] := 1.0;
	    blue[0] := 0.2; blue[1] := 0.2; blue[2] := 1.0; blue[3] := 1.0;

	context.MakeCurrent;

	(*GL.SetFCR();	*)
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
		GL.glFinish();
	(*GL.DelFCR();	*)
	END InitGears;

	PROCEDURE DrawGears();
	VAR angle1, angle2: REAL;
	BEGIN

		angle1 := -2.0 * angle - 9.0;
		angle2 := -2.0 * angle - 25.0;

		GL.SetFCR();
			GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

			GL.glPushMatrix;
				GL.glRotatef(angley, 0.0, 1.0, 0.0);

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
		GL.glPopMatrix;

		 GL.DelFCR();
	END DrawGears;

	PROCEDURE Reshape(w, h: LONGINT);
	BEGIN
		context.MakeCurrent();
		GL.SetFCR();
			GL.glViewport(0, 0, w, h);
			GL.glClearColor(0.0, 0.0, 0.0, 0.0);
			GL.glMatrixMode(GLC.GL_PROJECTION);
			GL.glLoadIdentity();
		(*	GL.gluPerspective(45.0, w/h, 1.0, 100.0); *)
			GL.glFrustum(-1,1,-1,1, 5, 100);
			GL.glMatrixMode(GLC.GL_MODELVIEW);
			GL.glLoadIdentity();

			GL.glTranslatef(0.0, 0.0, ztrans);
		GL.DelFCR();
		context.DeActivate();
	END Reshape;


BEGIN  {ACTIVE}
	Kernel.SetTimer(timer, waittime);
	WHILE alive DO

		IF animated THEN
			 IF Kernel.Expired(timer) THEN
 			 	 angle := angle + 2.0;
			 	 UpdateImage();
				Kernel.SetTimer(timer, waittime);
			END;
		END;

	END;
END GLWindow;

VAR
	window: GLWindow;

PROCEDURE Open*;
BEGIN
  IF window = NIL THEN
	NEW(window, 256, 256);
 END;
END Open;

BEGIN

END WMGLDemo3.

SystemTools.Free  WMGLDemo3  WMGLWindow  ~

WMGLDemo3.Open ~
