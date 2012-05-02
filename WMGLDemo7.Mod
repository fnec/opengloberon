MODULE WMGLDemo7;  (** AUTHOR "fnecati"; PURPOSE "opengl mirroring effect "; *)

IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, SYSTEM,
	WM := WMWindowManager,  WMMessages, WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, WMGL := WMGLWindow;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;


	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		timer: Kernel.MilliTimer;
		alive,  animated: BOOLEAN;
		xrot : REAL;
 		quad: GL.TGLUQuadricObj;
		drawMode: LONGINT;
		font: WMGraphics.Font;
		frames: LONGINT;
		fpsstr: ARRAY 30 OF CHAR;

	PROCEDURE &New(w, h: LONGINT);
	BEGIN
		Init(w, h, FALSE); (* use alpha, for 32bpp img *)
		WM.AddWindow(SELF, 100, 100);

		SetTitle(Strings.NewString("WMGLDemo7- Mirroring"));

		canvas.SetColor(WMGraphics.Green);
		font := canvas.GetFont();
		fpsstr := "FPS: ";

		Reshape(w, h);
		context.MakeCurrent();
		initGL;
		context.DeActivate();
		xrot := 0.0;
		drawMode:= 0;

		DrawMode(0);
		UpdateImage;
		animated := FALSE;
		alive := TRUE;
	END New;

	PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
	BEGIN
		CASE CHR(ucs) OF
			"a", "A": animated := ~ animated;

			| "d": drawMode := (drawMode+1) MOD 3; DrawMode(drawMode); GL.DelFCR(); UpdateImage;

			| "-" : xrot := xrot - 1.0; GL.DelFCR(); UpdateImage;
			| "+" : xrot := xrot + 1.0; GL.DelFCR();UpdateImage;

			| "s": SaveImage;
			| "q" : Close;
		ELSE

		END;
	END KeyEvent;

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
	VAR
		textWidth, textHeight: LONGINT;
		rect: WMRectangles.Rectangle;
	BEGIN
		context.MakeCurrent();
			Display;
			context.RenderInto(backImg);
		context.DeActivate();
		
		canvas.SetColor(WMGraphics.Green);
		font.GetStringSize(fpsstr, textWidth, textHeight);
		canvas.DrawString(4, textHeight, fpsstr);
		Swap();
		
	
		rect := WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight());
		WMRectangles.MoveRel(rect, bounds.l, bounds.t);
		WMRectangles.ClipRect(rect, bounds);
		manager.AddDirty(rect);
	
	(*	Invalidate(WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight()));*)
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

	PROCEDURE initGL;
	VAR
		white, black: ARRAY[4] OF GL.GLfloat;
	BEGIN
		GL.glDisable (GLC.GL_DITHER);
		GL.glEnable (GLC.GL_DEPTH_TEST);
		white[0] := 1.0; white[1] := 1.0; white[2] := 1.0; white[3] := 1.0;
		black[0] := 0.0; black[1] := 0.0; black[2] := 0.0; black[3] := 0.0;

		(* Set up light1 *)
	 	GL.glEnable (GLC.GL_LIGHTING);
	 	GL.glEnable (GLC.GL_LIGHT1);
		GL.glLightfv (GLC.GL_LIGHT1, GLC.GL_DIFFUSE, SYSTEM.ADR(white[0]));
		GL.glLightfv (GLC.GL_LIGHT1, GLC.GL_SPECULAR, SYSTEM.ADR(white[0]));

		(* ambient and diffuse will track glColor *)
		GL.glEnable (GLC.GL_COLOR_MATERIAL);
		GL.glColorMaterial (GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE);
		GL.glMaterialfv (GLC.GL_FRONT, GLC.GL_SPECULAR, SYSTEM.ADR(white[0]));
		GL.glMaterialf (GLC.GL_FRONT, GLC.GL_SHININESS, 20.);
		quad := GL.gluNewQuadric ();
	END initGL;

	PROCEDURE drawScene (order: GL.GLenum);
	VAR
		pos: ARRAY [4] OF GL.GLfloat;
	BEGIN
	 	pos[0] := -2.8; pos[1] := 5.0; pos[2] := 1.8; pos[3] := 1.0;
	 	GL.glLightfv (GLC.GL_LIGHT1, GLC.GL_POSITION, SYSTEM.ADR(pos[0]));
		GL.glPushMatrix();

		GL.glEnable (GLC.GL_CULL_FACE);
		GL.glCullFace (GLC.GL_BACK);
		GL.glFrontFace (order);

		(* Draw the walls *)
	 	GL.glColor3f (1., 1., 1.);
		GL.glBegin(GLC.GL_QUADS);
		GL.glNormal3f (1., 0., 0.);
			GL.glVertex3f (-3., 3., 4.);
			GL.glVertex3f (-3., -3., 4.);
			GL.glVertex3f (-3., -3., -3.);
			GL.glVertex3f (-3., 3., -3.);
		GL.glNormal3f (0., 0., 1.);
			GL.glVertex3f (-3., 3., -3.);
			GL.glVertex3f (-3., -3., -3.);
			GL.glVertex3f (3., -3., -3.);
			GL.glVertex3f (3., 3., -3.);
		  GL.glNormal3f (-1., 0., 0.);
			GL.glVertex3f (3., 3., -3.);
			GL.glVertex3f (3., -3., -3.);
			GL.glVertex3f (3., -3., 3.);
			GL.glVertex3f (3., 3., 3.);
		GL.glEnd();
		GL.glDisable (GLC.GL_CULL_FACE);

		(* Draw the cylinder *)
	 	GL.glRotatef (xrot, 1., 0., 0.);
	 	GL.glTranslatef (0.0, 0.0, -1.0);

	 	GL.glColor3f (0.5, 0.5, 1.0);
	 	GL.glPushMatrix ();
	 	GL.glTranslatef (0.0, 0.0, 2.0);
	 	GL.gluDisk (quad, 0.0, 0.25, 18, 1);
	 	GL.glPopMatrix ();

	 	GL.gluCylinder (quad, 0.25, 0.25, 2.0, 18, 8);

	 	GL.glPushMatrix ();
	 	GL.glScalef (1., 1., -1.);
	 	GL.gluDisk (quad, 0.0, 0.25, 18, 1);
	 	GL.glPopMatrix ();

		GL.glPopMatrix();
	END drawScene;

	PROCEDURE Display();
	VAR xx: REAL;
	BEGIN
		GL.glClear (GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);
		GL.glMatrixMode(GLC.GL_MODELVIEW);
		GL.glLoadIdentity ();
		GL.SetFCR();
			GL.gluLookAt (0.0, 1.0, 7.0, -1.0, 0.0, 0.0,  0.0, 1.0, 0.0);
		GL.DelFCR();

		xx := -xrot*0.35;
		GL.SetFCR();
			GL.glRotatef (xx, 0.0, 1.0, 0.0);
		GL.DelFCR();

		(*GL.glRotatef (-xrot*0.35, 0.0, 1.0, 0.0);*)
		(* Draw reflected scene first *)

		GL.glPushMatrix ();
		(* Mirrors lies in YZ plane, so scale by -1.0 in X axis *)
		GL.SetFCR();
		GL.glScalef (-1.0, 1.0, 1.0);
		(* Mirror is 2.0 units from origin, so translate by 4.0 *)
		GL.glTranslatef (4.0, 0.0, 0.0);
		GL.DelFCR();

		drawScene(GLC.GL_CW);
		GL.glPopMatrix ();

		(* draw mirror *)
		GL.glClear (GLC.GL_DEPTH_BUFFER_BIT);
		GL.glPushAttrib (SHORT(0FFFFFFFFH));
		GL.glDisable (GLC.GL_LIGHTING);
		(* Create imperfect reflector effect by blending a black
		   mirror over the reflected scene with alpha of 0.05 *)
		GL.glEnable (GLC.GL_BLEND);
		GL.glBlendFunc (GLC.GL_SRC_ALPHA, GLC.GL_ONE_MINUS_SRC_ALPHA);
		GL.glColor4f (0., 0., 0., 0.05);
		GL.glBegin (GLC.GL_QUADS);
			GL.glVertex3f (-2., 1., 3.);
			GL.glVertex3f (-2., -1., 3.);
			GL.glVertex3f (-2., -1., -2.5);
			GL.glVertex3f (-2., 1., -2.5);
		GL.glEnd ();
		GL.glPopAttrib();

		(* Draw the real scene *)
		drawScene(GLC.GL_CCW);
	END Display;

	PROCEDURE Reshape(w, h: LONGINT);
	BEGIN
		context.MakeCurrent();
		GL.glViewport (0, 0, w, h);
		GL.glMatrixMode (GLC.GL_PROJECTION);
		GL.glLoadIdentity ();
		GL.gluPerspective (50.0, 1.0, 1.0, 20.0);
		context.DeActivate();
	END Reshape;

BEGIN  {ACTIVE}
	Kernel.SetTimer(timer, 10);
	WHILE alive DO
		IF animated THEN
	 		UpdateImage();
	 		xrot := xrot + 1.0;
			GL.DelFCR();
			INC(frames);
			IF Kernel.Expired(timer) THEN
				Strings.FloatToStr(frames/5.0, 0, 2, 0, fpsstr);
				Strings.Concat("FPS:", fpsstr, fpsstr);
				Kernel.SetTimer(timer, 5000);
				frames := 0;
			END;

		END;
	END;
END GLWindow;

PROCEDURE Open*;
VAR
	window: GLWindow;
BEGIN
	NEW(window, 256, 256);
END Open;

BEGIN

END WMGLDemo7.

SystemTools.Free  WMGLDemo7 WMGLWindow ~  OpenGL OpenGLConst ~

WMGLDemo7.Open ~

SystemTools.FreeDownTo OpenGL ~ 