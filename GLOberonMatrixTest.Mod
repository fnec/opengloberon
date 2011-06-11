MODULE GLOberonMatrixTest; (** AUTHOR "fnecati"; PURPOSE ""; *)

IMPORT
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, KernelLog, Streams, GLContext, Math;

(* 	Tests OpenGL transformation matrices NaN values for various floating point scenarios.

	Compiler.Compile  GLOberonMatrixTest.Mod ~
	
	GLOberonMatrixTest.Open ~ 
 *)	

TYPE 
	Vector16f = ARRAY 16 OF REAL; (* 4x4 GLfloat Matrix *)

VAR
	wr: Streams.Writer;
	
(* write projection matrix *)
PROCEDURE WriteProjMatrixf*(CONST title: ARRAY OF CHAR);
VAR i: LONGINT;
       v: Vector16f;
BEGIN
GL.glGetFloatv(GLC.GL_PROJECTION_MATRIX, SYSTEM.ADR(v[0]));
wr.String("-----------------"); wr.Ln; 
wr.String("Float PROJECTION_MATRIX: "); wr.String(title); wr.Ln;
	FOR i:=0 TO 15 DO
		wr.FloatFix(v[i], 10,4,0); 
	END;
wr.Ln; wr.Update;
END WriteProjMatrixf;

(* write modelview matrix *)
PROCEDURE WriteModelMatrixf*(CONST title: ARRAY OF CHAR);
VAR i : LONGINT;
       v: Vector16f;
BEGIN
GL.glGetFloatv(GLC.GL_MODELVIEW_MATRIX, SYSTEM.ADR(v[0]));
wr.String("-----------------"); wr.Ln; 
wr.String("Float GL_MODELVIEW_MATRIX: ");wr.String(title); wr.Ln;
	FOR i:=0 TO 15 DO
		wr.FloatFix(v[i], 10,4,0); 
	END;
wr.Ln; wr.Update;
END WriteModelMatrixf;

(** test with/ without  SetFCR, DelFCR *)
PROCEDURE Open*;
VAR 
	context: GLContext.Context;
	x, y, z: LONGREAL;
	xr, yr : REAL;
BEGIN
 x := 10.0;
NEW(context); (* create a gl context *)
context.Init(100,100,"Test1", FALSE);
context.MakeCurrent(); (* make it current *)

	(* start GL commands *)

	GL.glClearColor(0.0, 0.0, 0.0, 0.0);
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity();
		WriteProjMatrixf("identity:");	
		
(* ************* glFrustum test ********************* *)
		GL.glFrustum(-1,1,-1,1, 5, 100); 
	WriteProjMatrixf("without SetFCR frustum:");	

	GL.glLoadIdentity();
	GL.SetFCR();
		GL.glFrustum(-1,1,-1,1, 5, 100); 
	GL.DelFCR();	
		WriteProjMatrixf("with SetFCR frustum:");

	GL.glLoadIdentity();
	GL.SetFCR();
		GL.glFrustum(-1,1/2 ,-1, 1/2, 5, 100); 
	GL.DelFCR();	
		WriteProjMatrixf("with SetFCR frustum-2:");

	GL.glLoadIdentity();
	GL.SetFCR();
		GL.glFrustum(-1, 1.0/2.0 ,-1+ x, 1.0/2.0, 5, 100); 
	GL.DelFCR();	
		WriteProjMatrixf("with SetFCR frustum-2:");

(* ************* gluPerspective test ******************* *)
	GL.glLoadIdentity();
		GL.gluPerspective(45.0, 1, 1, 100); 
	WriteProjMatrixf("without SetFCR perpective:");	

	GL.glLoadIdentity();
		GL.gluPerspective(x, 1, 1, 100); 
	WriteProjMatrixf("without SetFCR perpective-1:");	

	GL.glLoadIdentity();
		GL.gluPerspective(x+10.0, 1, 1, 100); 
	WriteProjMatrixf("without SetFCR perpective-2:");	

	GL.glLoadIdentity();
		GL.SetFCR();
			GL.gluPerspective(45.0, 1, 1, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR perpective:");

	GL.glLoadIdentity();
		GL.SetFCR();
			GL.gluPerspective(x, 1, 1, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR perpective-1:");	

	GL.glLoadIdentity();
		GL.SetFCR();
			GL.gluPerspective(x+10, 1, 1, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR perpective-2:");
		
(* ************* glOrtho Test ************************* *)
	GL.glLoadIdentity();
		GL.glOrtho(-1,1,-1,1, 5, 100); 
	WriteProjMatrixf("without SetFCR ortho:");

	GL.glLoadIdentity();
		GL.glOrtho(-1,1,-x, x, 5, 100); 
	WriteProjMatrixf("without SetFCR ortho-1:");

	GL.glLoadIdentity();
		GL.glOrtho(-1,1,-x-0.1, x+0.1, 5, 100); 
	WriteProjMatrixf("without SetFCR ortho-2:");

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.glOrtho(-1,1,-1,1, 5, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR ortho:");

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.glOrtho(-1,1,-x, x, 5, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR ortho-1:");	

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.glOrtho(-1,1, -x-0.1, x+0.1, 5, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR ortho-2:");

		y := -1-0.1;  z := 1.0;
	GL.glLoadIdentity();

		GL.SetFCR();
		GL.glOrtho(-1,1, y, z, 5, 100); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR ortho-3:");



(* ************* gluOrtho2D Test ************************* *)
	GL.glLoadIdentity();
		GL.gluOrtho2D(-1,1,-1,1); 
	WriteProjMatrixf("without SetFCR gluOrtho2D:");

	GL.glLoadIdentity();
		GL.gluOrtho2D(-1,1,-x, x); 
	WriteProjMatrixf("without SetFCR gluOrtho2D-1:");

	GL.glLoadIdentity();
		GL.gluOrtho2D(-1,1,-x-0.1, x+0.1); 
	WriteProjMatrixf("without SetFCR gluOrtho2D-2:");

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.gluOrtho2D(-1,1,-1,1); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR gluOrtho2D:");

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.gluOrtho2D(-1,1,-x, x); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR gluOrtho2D-1:");	

	GL.glLoadIdentity();
		GL.SetFCR();
		GL.gluOrtho2D(-1,1, -x-0.1, x+0.1); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR gluOrtho2D-2:");

		y := -1-0.1;  z := 1.0;
	GL.glLoadIdentity();

		GL.SetFCR();
		GL.gluOrtho2D(-1,1, y, z); 
		GL.DelFCR();
	WriteProjMatrixf("with SetFCR gluOrtho2D-3:");
	
	(* ************************************************ *)
	(* ************************************************ *)
	
	xr := 45.0;
	wr.String("*************************************************"); wr.Ln; wr.Update;
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity(); 
	
		(* ***** glTranslate test ********** *)	
	GL.glTranslatef(0.0, 0.0,Math.sin(xr) );	
		WriteModelMatrixf("without SetFCR translate :");
		
	GL.glLoadIdentity(); 
	GL.glTranslatef(10.0+1.0, xr-0.1,Math.sin(xr) );	
		WriteModelMatrixf("without SetFCR translate-1 :");

		(* ***** glRotate test ********** *)
		
	GL.glLoadIdentity(); 
	xr := 45.0;
		GL.glRotatef(xr, 0.0, 0.0, 1.0); 
		WriteModelMatrixf("without SetFCR rotatez 45 :");
		
	GL.glLoadIdentity(); 
		GL.glRotatef(Math.sin(xr) , 0.0, 0.0, 1.0); 
		WriteModelMatrixf("without SetFCR rotatez 45 -1 :");

	GL.glLoadIdentity(); 
	yr := Math.sin(xr);
		GL.glRotatef(yr , 0.0, 0.0, 1.0); 
		WriteModelMatrixf("without SetFCR rotatez 45 -2 :");
				
		
	GL.glLoadIdentity(); 
	xr := 45.0;
	GL.SetFCR;
		GL.glRotatef(xr, 0.0, 0.0, 1.0); 
	GL.DelFCR();	
		WriteModelMatrixf("with SetFCR rotatez 45 :");

	GL.glLoadIdentity(); 
	GL.SetFCR;
		GL.glRotatef(Math.sin(xr) , 0.0, 0.0, 1.0); 
	GL.DelFCR();	
		WriteModelMatrixf("with SetFCR rotatez 45 -1 :");

	GL.glLoadIdentity(); 
	yr := Math.sin(xr);
	GL.SetFCR;
		GL.glRotatef(yr , 0.0, 0.0, 1.0); 
	GL.DelFCR();	
		WriteModelMatrixf("with SetFCR rotatez 45 -2 :");

	GL.glLoadIdentity(); 
	GL.SetFCR;
		GL.glRotatef(xr + 10.0 , 0.0, 0.0, 1.0); 
	GL.DelFCR();	
		WriteModelMatrixf("with SetFCR rotatez 45 -3 :");

context.Close; (* close gl contex *)
	
END Open;


BEGIN
Streams.OpenWriter(wr, KernelLog.Send);
END GLOberonMatrixTest.


GLOberonMatrixTest.Open ~ 

SystemTools.Free GLOberonMatrixTest GLContext ~ 

(*

My Conclusion:

OpenGL and glu transformations functions; ( glFrustum, gluPerspective, glRotate, glOrtho, gluOrtho2d, gluLookAt .. etc.) 
are made in OpenGL driver in software. 
I think, floating point exceptions are disabled because of these calculations, may be due to  prevent overflows, NaN values, 
because of a floating point division in matrix operations. 

But in Oberon, floating point exceptions are enabled. So, if we do not disable floating point exception in FPU control register
these OpenGL functions can produce NaNs in corresponding transformation matrices which affects the consequent
matrices and vertex values and we can get unexpected results.


As a rule of thumb:

	If you are using any of these function and if you are making floating operation in Oberon before using 
	the functions,  floating point exception is allready enabled, then, just before the calling these functions
	disable floating point exceptions using SetFCR() to make OpenGL happy!, then enable it using DelFCR 
	to make Oberon happy.  If there are any NaN in transformation matrix, you have problems.. 
	
	for example,
	
		(* this is ok *)
		GL.SetFCR();
			GL.glRotate(z, 0, 0, 1.0)
		GL.DelFCR)(;	
	
		(* this produces NaN *)	
		  z := z+ 1.0;
		  GL.glRotate(z, 0.0, 0, 1.0);
		  
		  (* but this is ok *)
 		  z := z+ 1.0;
 		  GL.SetFCR();
		 	 GL.glRotate(z, 0.0, 0, 1.0);
		  GL.DelFCR();
		
		(* these produce NaN also*)
		GL.glRotate(z + 1.0, 0.0, 0, 1.0);
		GL.glRotate(Math.sin(z), 0.0, 0, 1.0);
		
and test your other scenarios.

		
		
OpenGL transformation matrix formats:

x: x-vector, y: y-vector, z: z-vector, t: translation vector

row-wise 

as a Vector format:
	 v = [x0, x1, x2, m3, y4, y5, y6, m7, z8, z9, z10, m11, t12, t13, t14, m15]
or 

as a Matrix format: 

		
           i1		i2		i3		i4
---------------------------
j1		x1		y5		z9		t13
j2		x2		y6		z10		t14
j3		x3		y7		z11		t15
j4		m4		m8		m12	m16	
---------------------------


*)