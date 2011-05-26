MODULE MyGLSpeed; (** AUTHOR "fnecati"; PURPOSE "speed timing for OpenGLoberon"; *)

IMPORT  GL := OpenGL, GLC := OpenGLConst, Commands, Kernel, KernelLog,
			 GLContext, WMGraphics, Raster, Math, SYSTEM ;	

CONST
	 pi = Math.pi;
	 
VAR 
	image: Raster.Image; (* for saving the rendered image *)

	gear1, gear2, gear3: GL.GLuint;
	rotx, roty, rotz, angle, angley: GL.GLfloat;	
	ztrans: REAL;
	  	        
PROCEDURE SaveToImage(fname: ARRAY OF CHAR);
VAR imres: LONGINT;
BEGIN
	 WMGraphics.StoreImage(image, fname, imres); 	 
	KernelLog.String(fname); KernelLog.String(" saved."); KernelLog.Ln;
END SaveToImage;


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
	angley := 0.0;	ztrans := -40.0;		
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

END InitGears;

PROCEDURE Reshape;
BEGIN	

GL.SetFCR();
	GL.glClearColor(0.0, 0.0, 0.0, 0.0);
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity();
	GL.glFrustum(-1,1,-1,1, 5, 100); 
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity(); 

	GL.glTranslatef(0.0, 0.0, ztrans); 
GL.DelFCR();
END Reshape;

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
 GL.glFinish;  (* blocks, wait untill finishing GL operations *)
END DrawGears;


(* test framerate for glxgears *)
PROCEDURE RenderTestGear*(ctxt: Commands.Context);
VAR 
	 context: GLContext.Context;  (* GL context *)
	 width, height: LONGINT; (* size of window *)
	 
      i, count, time, frames: LONGINT;
      timer: Kernel.MilliTimer;
      
BEGIN
(* get window width and height *)
 IF ~ (ctxt.arg.GetInteger(width, FALSE) & ctxt.arg.GetInteger(height, FALSE)) THEN ctxt.error.String(" invalid window size."); ctxt.error.Ln; ctxt.error.Update; RETURN END;

 (* control window size *)
 width := ABS(width); height := ABS(height);
 IF width<10 THEN width := 10; END;
 IF width>1024 THEN width := 1024 END;
 IF height<10 THEN height := 10; END;
 IF height>1024 THEN height := 1024 END;

(* get iteration count *)
IF ~ ctxt.arg.GetInteger(count, FALSE) THEN  ctxt.error.String(" invalid iteration count."); ctxt.error.Ln; ctxt.error.Update; RETURN END;

(* create a visible GL context and an image for saving*)
	 NEW(context);
	context.Init(width , height, "GL-Test Display", FALSE);
	
	NEW(image);
	Raster.Create(image, width, height, Raster.BGRA8888);
 
context.MakeCurrent();

(* init gears *)
   InitGears;
   Reshape;

(* ************************* *)
(* ************************* *)
(* start timing with SwapBuffers*)
Kernel.SetTimer(timer, 0);
FOR i:=1 TO count DO
	DrawGears;
	context.SwapBuffers;
	angle := angle + 0.05;
END;
time:=Kernel.Elapsed(timer);
GL.glReadPixels(0, 0, width, height, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, image.adr);


ctxt.out.String("------------- RenderTestGear ------------------"); ctxt.out.Ln; 
ctxt.out.Int(width, 0); ctxt.out.String("x"); ctxt.out.Int(height, 0);   ctxt.out.String(": with SwapBuffers, DrawGears  time for "); 
ctxt.out.Int(count, 0); ctxt.out.String(" iteration: ");  ctxt.out.Int(time, 0); ctxt.out.String(" ms.");  ctxt.out.Ln; 

ctxt.out.String(" 1 frame in: "); ctxt.out.FloatFix(time/count, 10, 4, 0); ctxt.out.String(" ms."); ctxt.out.Ln;
frames := 5000*count;
frames := frames DIV time;
(* # of frames in 5 secs. *)
ctxt.out.Int(frames, 0); ctxt.out.String(" frames in 5 seconds."); ctxt.out.Ln; ctxt.out.Update;

(* SaveToImage("testspeedgear1.bmp"); *)

(* ************************* *)
(* ************************* *)
(* start timing with GL-DrawGears*)
Kernel.SetTimer(timer, 0);
FOR i:=1 TO count DO
	DrawGears;
	angle := angle + 0.05;
END;
time:=Kernel.Elapsed(timer);
GL.glReadPixels(0, 0, width, height, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, image.adr);

ctxt.out.Int(width, 0); ctxt.out.String("x"); ctxt.out.Int(height, 0);   ctxt.out.String(":  DrawGears  time for "); 
ctxt.out.Int(count, 0); ctxt.out.String(" iteration: ");  ctxt.out.Int(time, 0); ctxt.out.String(" ms.");  ctxt.out.Ln; 

ctxt.out.String(" 1 frame in: "); ctxt.out.FloatFix(time/count, 10, 4, 0); ctxt.out.String(" ms."); ctxt.out.Ln;

frames := 5000*count;
frames := frames DIV time;

(* # of frames in 5 secs. *)
ctxt.out.Int(frames, 0); ctxt.out.String(" frames in 5 seconds."); ctxt.out.Ln; 
ctxt.out.Update;

(* SaveToImage("testspeedgear2.bmp"); *)

(* finally, close GL context *)
context.Close; 
context := NIL;
END RenderTestGear;


(* tests glReadPixel framerate *)
PROCEDURE ReadpixelTest*(ctxt: Commands.Context);
VAR 
	 context: GLContext.Context;  (* GL context *)
	 width, height: LONGINT; (* size of window *)
	 
      i, count, time: LONGINT;
      timer: Kernel.MilliTimer;
      
BEGIN
(* get window width and height *)
 IF ~ (ctxt.arg.GetInteger(width, FALSE) & ctxt.arg.GetInteger(height, FALSE)) THEN ctxt.error.String(" invalid window size."); ctxt.error.Ln; ctxt.error.Update; RETURN END;

 (* control window size *)
 width := ABS(width); height := ABS(height);
 IF width<10 THEN width := 10; END;
 IF width>1024 THEN width := 1024 END;
 IF height<10 THEN height := 10; END;
 IF height>1024 THEN height := 1024 END;

(* get iteration count *)
IF ~ ctxt.arg.GetInteger(count, FALSE) THEN  ctxt.error.String(" invalid iteration count."); ctxt.error.Ln; ctxt.error.Update; RETURN END;

(* create GL context and an image *)
	 NEW(context);
	context.Init(width , height, "GL-Test Display", FALSE);
	
	NEW(image);
	Raster.Create(image, width, height, Raster.BGRA8888);
 
context.MakeCurrent();

(* clear GL framebuffer with color *)
GL.glClearColor(0.3, 0.6, 0.8, 1.0);	
GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

(* ************************* *)
(* ************************* *)
(* start timing *)
Kernel.SetTimer(timer, 0);
FOR i:=1 TO count DO
	GL.glReadPixels(0, 0, width, height, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, image.adr); (* blocking function *)
END;
time:=Kernel.Elapsed(timer);
ctxt.out.String("------------- ReadpixelTest ------------------"); ctxt.out.Ln; 
ctxt.out.Int(width, 0); ctxt.out.String("x"); ctxt.out.Int(height, 0);   ctxt.out.String(": glReadPixels time for "); 
ctxt.out.Int(count, 0); ctxt.out.String(" iteration: ");  ctxt.out.Int(time, 0); ctxt.out.String(" ms.");  ctxt.out.Ln; 

ctxt.out.String(" 1 frame in: "); ctxt.out.FloatFix(time/count, 10, 4, 0); ctxt.out.String(" ms."); ctxt.out.Ln;
(* # of frames in 5 secs. *)
ctxt.out.Int((5000*count) DIV time,0); ctxt.out.String(" frames in 5 seconds."); ctxt.out.Ln; ctxt.out.Update;

(* SaveToImage("testspeed1.bmp");*)


(* ************************* *)
(* ************************* *)
(* start timing for flipped image*)
Kernel.SetTimer(timer, 0);
FOR i:=1 TO count DO
	context.RenderInto(image);  (* blocking method, due to glReadPixels, and flipping *)
END;
time:=Kernel.Elapsed(timer);

ctxt.out.Int(width, 0); ctxt.out.String("x"); ctxt.out.Int(height, 0);   ctxt.out.String(": flipped glReadPixels time for "); 
ctxt.out.Int(count, 0); ctxt.out.String(" iteration: ");  ctxt.out.Int(time, 0); ctxt.out.String(" ms.");  ctxt.out.Ln; 

ctxt.out.String(" 1 frame in: "); ctxt.out.FloatFix(time/count, 10, 4, 0); ctxt.out.String(" ms."); ctxt.out.Ln;
(* # of frames in 5 secs. *)
ctxt.out.Int((5000*count) DIV time,0); ctxt.out.String(" frames in 5 seconds."); ctxt.out.Ln; ;
ctxt.out.Update;

(* SaveToImage("testspeed2.bmp"); *)

(* finally, close GL context *)
context.Close; 
context := NIL;
END ReadpixelTest;

BEGIN	

END MyGLSpeed.


MyGLSpeed.ReadpixelTest  1024 1024 100 ~

MyGLSpeed.ReadpixelTest  512 512 100 ~

(* ********************************** *)

MyGLSpeed.RenderTestGear  300 300 1000 ~

MyGLSpeed.RenderTestGear  512 512 100 ~




SystemTools.Free MyGLSpeed GLContext~ 

(* 
PC: 2.4GHz, 4GB, Intel Core2Quad Q6600, Nvida 8500GT-512 GB, LinuxAos 0.96b 

------------- ReadpixelTest ------------------
1024x1024: glReadPixels time for 100 iteration: 273 ms.
 1 frame in:     2.7300 ms.
1831 frames in 5 seconds.
1024x1024: flipped glReadPixels time for 100 iteration: 3064 ms.
 1 frame in:    30.6400 ms.
163 frames in 5 seconds.
------------- ReadpixelTest ------------------
512x512: glReadPixels time for 100 iteration: 73 ms.
 1 frame in:     0.7300 ms.
6849 frames in 5 seconds.
512x512: flipped glReadPixels time for 100 iteration: 1545 ms.
 1 frame in:    15.4500 ms.
323 frames in 5 seconds.
------------- RenderTestGear ------------------
300x300: with SwapBuffers, DrawGears  time for 1000 iteration: 238 ms.
 1 frame in:     0.2380 ms.
21008 frames in 5 seconds.
300x300:  DrawGears  time for 1000 iteration: 187 ms.
 1 frame in:     0.1870 ms.
26737 frames in 5 seconds.
------------- RenderTestGear ------------------
512x512: with SwapBuffers, DrawGears  time for 100 iteration: 41 ms.
 1 frame in:     0.4100 ms.
12195 frames in 5 seconds.
512x512:  DrawGears  time for 100 iteration: 47 ms.
 1 frame in:     0.4700 ms.
10638 frames in 5 seconds.
***************************************************
***************************************************

Same PC, on WindowsXP, using WinAos

------------- ReadpixelTest ------------------
1024x1024: glReadPixels time for 100 iteration: 234 ms.
 1 frame in:     2.3400 ms.
2136 frames in 5 seconds.
1024x1024: flipped glReadPixels time for 100 iteration: 2781 ms.
 1 frame in:    27.8100 ms.
179 frames in 5 seconds.
------------- ReadpixelTest ------------------
512x512: glReadPixels time for 100 iteration: 62 ms.
 1 frame in:     0.6200 ms.
8064 frames in 5 seconds.
512x512: flipped glReadPixels time for 100 iteration: 1532 ms.
 1 frame in:    15.3200 ms.
326 frames in 5 seconds.
------------- RenderTestGear ------------------
300x300: with SwapBuffers, DrawGears  time for 1000 iteration: 16672 ms.
 1 frame in:    16.6720 ms.
299 frames in 5 seconds.
300x300:  DrawGears  time for 1000 iteration: 187 ms.
 1 frame in:     0.1870 ms.
26737 frames in 5 seconds.
------------- RenderTestGear ------------------
512x512: with SwapBuffers, DrawGears  time for 100 iteration: 1656 ms.
 1 frame in:    16.5600 ms.
301 frames in 5 seconds.
512x512:  DrawGears  time for 100 iteration: 47 ms.
 1 frame in:     0.4700 ms.
10638 frames in 5 seconds.

*)