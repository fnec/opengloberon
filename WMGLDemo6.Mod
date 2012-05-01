MODULE WMGLDemo6;  (** AUTHOR "fnecati"; PURPOSE "simple radar sweep example "; *)

IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Math,
	WM := WMWindowManager,  WMMessages, WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, WMGL:=WMGLWindow;

CONST waittime = 50;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		 timer: Kernel.MilliTimer;
		alive,  animated: BOOLEAN;
		angle : REAL;

		plane: GL.GLuint; (* radar plane list *)
		circle: GL.GLuint;
		drawMode: LONGINT;

		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			Init(w, h, FALSE); (* use alpha, for 32bpp img *)
			WM.AddWindow(SELF, 100, 100);

			SetTitle(Strings.NewString("WMGLDemo6-RadarSweep"));

			Reshape(w, h);
			context.MakeCurrent();
			initGL;
			context.DeActivate();
			angle := 00.0;
			drawMode:= 0;
			animated := FALSE;
			alive := TRUE;
			DrawMode(0);
			UpdateImage;
		END New;

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
		BEGIN
			CASE CHR(ucs) OF
				"a", "A": animated := ~ animated;
				| "d": drawMode := (drawMode+1) MOD 3; DrawMode(drawMode); UpdateImage;
				| "-" : angle := angle - 3.0; UpdateImage;
				| "+" : angle := angle + 3.0; UpdateImage;

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
			window := NIL;
		END Close;

		PROCEDURE UpdateImage;
		BEGIN
			context.MakeCurrent();
				DrawPlane;
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

		 context.DeActivate();
	END DrawMode;

	PROCEDURE initGL;
	VAR i, n: LONGINT;
		  da,  a, b: GL.GLfloat;
		  ga, gb: GL.GLfloat;
		  twopi: REAL;

	BEGIN
		GL.glClearColor (0, 0, 0, 0);
		n := 120;
		twopi := 2.0*Math.pi;
		da := twopi / n;

		(* make the plane list *)
		plane := GL.glGenLists(1);
		GL.glNewList(plane, GLC.GL_COMPILE);

		GL.glBegin (GLC.GL_QUADS);
			FOR i := 0 TO n-1 DO
				a := i*da;
				b := a + da;
				ga := 0.90 * (i / n);
				gb := 0.90 * ((i + 1) / n);
				GL.glColor3f  (0.0, ga, 0.0);
				GL.glVertex2i (0, 0);
				GL.glVertex2f (Math.cos(a),  Math.sin(a));
				GL.glColor3f(0.0, gb, 0.0);
		          	GL.glVertex2f (Math.cos(b), Math.sin(b));
		          	GL.glVertex2i (0, 0);
			END;
		GL.glEnd ();
		GL.glEndList;

		(* create circle list *)
		circle := GL.glGenLists(1);
		GL.glNewList(circle, GLC.GL_COMPILE);
		GL.glColor3f  (1.0, 0.0, 0.0);
		GL.glLineWidth(8.0);

		a := 0.0;
		GL.glBegin (GLC.GL_LINES);
		FOR i := 0 TO n-1 DO
			a := i*da;
			b := a + da;
			GL.glVertex2f( 1.1*Math.cos(a), 1.1*Math.sin(a));
			GL.glVertex2f( 1.1*Math.cos(b),  1.1*Math.sin(b));
		END;
		GL.glEnd ();
		GL.glEndList;
	 END initGL;

	PROCEDURE DrawPlane();
	BEGIN
		GL.glClear(GLC.GL_COLOR_BUFFER_BIT+ GLC.GL_DEPTH_BUFFER_BIT);
		(* draw circle *)
		GL.glCallList(circle);
		GL.glPushMatrix();
			GL.SetFCR();
				GL.glRotatef(angle, 0, 0, 1);
			GL.DelFCR();
	    (* draw radar plane *)
		GL.glCallList(plane);
		GL.glPopMatrix();
	END DrawPlane;


	PROCEDURE Reshape(w, h: LONGINT);
	BEGIN
		context.MakeCurrent();
		GL.glViewport(0,0, w, h);
		GL.glMatrixMode(GLC.GL_PROJECTION);
		GL.glLoadIdentity ();
		GL.SetFCR();
			GL.glOrtho(-1.5 ,1.5, -1.5, 1.5, -1.0, 1.0);
		GL.DelFCR();
		GL. glMatrixMode (GLC.GL_MODELVIEW);
		GL.glLoadIdentity ();
	context.DeActivate();
	END Reshape;

BEGIN {ACTIVE}
	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN
			 IF Kernel.Expired(timer) THEN
			 	 UpdateImage();
			 	  angle := angle + 5.0;
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

END WMGLDemo6.

SystemTools.Free  WMGLDemo6 WMGLWindow ~

WMGLDemo6.Open ~
