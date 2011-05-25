MODULE MyWMGLWindow; (** AUTHOR "fnecati"; PURPOSE ""; *)
 (* uses simple primitives, quad and a cube *)
IMPORT
	WMRectangles, WMGraphics, Strings, Kernel,
	WM := WMWindowManager,  WMMessages, WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, GLContext;

CONST waittime=10;
TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WM.BufferWindow)
	VAR
		 timer: Kernel.MilliTimer; 
		alive, dead, animated: BOOLEAN;
		context : GLContext.Context;
		width, height: LONGINT;
		eyeposz: LONGREAL;
		anglez: REAL;
				
		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			width := w; height := h;
			Init(w, h, TRUE); (* use alpha, for 32bpp img *)
			manager := WM.GetDefaultManager();
			manager.Add(100, 100, SELF, {WM.FlagFrame, WM.FlagClose, WM.FlagNoResizing});

			SetTitle(Strings.NewString("MyGLWindow1 "));
						
			animated := FALSE;
			NEW(context);
			context.Init(w, h, "MyGLWindow", FALSE);
			anglez := 30.0;	
			eyeposz := 10.0;
			
			ReshapeQuad;
			UpdateImage;

			alive := TRUE;
		END New; 

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);	     
		BEGIN

		CASE CHR(ucs) OF
			"a", "A": animated := ~ animated;   
			| "-" : anglez := anglez - 5.0; UpdateImage;
			| "+" : anglez := anglez + 5.0; UpdateImage;
			| "s": SaveImage;
			| "q" : Close;
		ELSE	

		END;	
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			eyeposz := eyeposz + dz;
			IF eyeposz < 0 THEN eyeposz:=0.0; END;
			IF eyeposz > 99 THEN eyeposz:=99; END;
			ReshapeQuad;
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
		BEGIN
			alive := FALSE;	
			Close^;			
			 context.Close;
			 context := NIL;				
		END Close;

		PROCEDURE UpdateImage;
		BEGIN {EXCLUSIVE}
			context.MakeCurrent();
				DrawAQuad(); 
				Cube();
			context.RenderInto(img); 
			context.DeActivate();
			
			Invalidate(WMRectangles.MakeRect(0, 0, width, height));		
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

PROCEDURE ReshapeQuad();
VAR lookat: LONGREAL;
BEGIN 
lookat := eyeposz;

 context.MakeCurrent();

  GL.glClearColor(0.3, 0.3, 0.0, 0.0);
  GL.glEnable(GLC.GL_DEPTH_TEST); 

GL.SetFCR();  
 GL.glMatrixMode(GLC.GL_PROJECTION);
 GL.glLoadIdentity();
 GL.gluPerspective(45, 1, 0.1, 100);

 GL.glMatrixMode(GLC.GL_MODELVIEW);
 GL.glLoadIdentity();
 GL.gluLookAt(0.0, 0.0, lookat, 0., 0., 0., 0., 1., 0.);

GL.DelFCR(); 
context.DeActivate;
END ReshapeQuad;

PROCEDURE DrawAQuad(); 
BEGIN
 GL.glPushMatrix();
 GL.SetFCR(); 
	GL.glRotatef(anglez, 0.0, 0.0, 1.0);
 GL.DelFCR();
 GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);
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
(*  GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT); *)
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

BEGIN {ACTIVE} 

	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN
			 IF Kernel.Expired(timer) THEN  
			 	 UpdateImage();
 			 	 anglez := anglez + 5;
				Kernel.SetTimer(timer, waittime);
			END;	
		END;	
	END;

	dead := TRUE;
END GLWindow;

PROCEDURE Open*;
VAR 
	window: GLWindow;
BEGIN
	NEW(window, 512, 512);
END Open;

BEGIN

END MyWMGLWindow.

SystemTools.Free  MyWMGLWindow  GLContext~ ~

MyWMGLWindow.Open ~

