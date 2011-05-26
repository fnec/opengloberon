MODULE  GLTest; (** AUTHOR "fnecati"; PURPOSE "Simple GL rendering with commands"; *)

IMPORT  GL := OpenGL, GLC := OpenGLConst, KernelLog,
			S:=SYSTEM, Math, GLContext, WMGraphics, Raster ;

(* Note:
	Since GL is state machine, drawing with different commands may leave 
	artifacts of previous commands.  
	
	Rendered images are saved as *.bmp file to the disk
	Examples from OpenGL-redbook.
*)
CONST 

	pi = Math.pi;
	degToRad = pi / 180.0;
	
TYPE 
	
	Point = ARRAY 3 OF GL.GLfloat;

VAR 
	 w, h: LONGINT; (* size of window *)
	 ctx : GLContext.Context;  (* GL context *)
	 image: Raster.Image; (* for saving the rendered image *)


PROCEDURE Error;
BEGIN
 KernelLog.String("Run the OpenDisplay command"); KernelLog.Ln;
END Error;

PROCEDURE SaveToImage(fname: ARRAY OF CHAR);
VAR imres: LONGINT;
BEGIN
	ctx.RenderInto(image);
	 WMGraphics.StoreImage(image, fname, imres); 
	KernelLog.String(fname); KernelLog.String(" saved."); KernelLog.Ln;
END SaveToImage;

(* for Primitives commands *)
(* ******************* *)
PROCEDURE Points;
BEGIN
 GL.glBegin(GLC.GL_POINTS);
GL.SetFCR();
   GL.glVertex3f( 0.0, 1.0,-1.0);(* a *)
   GL.glVertex3f(-1.0,-1.0, 0.0);(* b *)
   GL.glVertex3f( 1.0,-1.0, 0.0);(* c *)
GL.DelFCR();
  GL.glEnd();
END Points;

PROCEDURE Line;
BEGIN
GL.glBegin(GLC.GL_LINE_LOOP); 
GL.SetFCR();
   GL.glVertex3f( 0.0, 1.0,-1.0);(* a *)
   GL.glVertex3f(-1.0,-1.0, 0.0);(* b *)
   GL.glVertex3f( 1.0,-1.0, 0.0);(* c *)
GL.DelFCR();  
  GL.glEnd();
END Line;

PROCEDURE Triangle;
BEGIN
GL.glBegin(GLC.GL_POLYGON);
GL.SetFCR();
	GL.glVertex3f( 0.0, 1.0,-1.0); (* a *)
	GL.glVertex3f(-1.0,-1.0, 0.0); (* b *)
	GL.glVertex3f( 1.0,-1.0, 0.0); (* c *)
GL.DelFCR();
GL.glEnd();
END Triangle;

PROCEDURE Square;
BEGIN
GL.glBegin(GLC.GL_POLYGON);
GL.SetFCR();
	GL.glVertex3f(0.0,0.0 ,0.0);(* a *)
	GL.glVertex3f(1.0,0.0, 0.0);(* b *)
	GL.glVertex3f(1.0,0.0,-1.0);(* c *)
	GL.glVertex3f(0.0,0.0,-1.0);(* d *)
GL.DelFCR();
GL.glEnd();
END Square;

PROCEDURE Esquare();
BEGIN
GL.SetFCR();
GL.glBegin(GLC.GL_QUAD_STRIP);
    GL.glVertex3f(0.0,0.0 ,0.0);(* a0 *)
    GL.glVertex3f(0.0,1.0 ,0.0);(* a1 *)
    GL.glVertex3f(1.0,0.0, 0.0);(* b0 *)
    GL.glVertex3f(1.0,1.0, 0.0);(* b1 *)
    GL.glVertex3f(1.0,0.0,-1.0);(* c0 *)
    GL.glVertex3f(1.0,1.0,-1.0);(* c1 *)
    GL.glVertex3f(0.0,0.0,-1.0);(* d0 *)
    GL.glVertex3f(0.0,1.0,-1.0);(* d1 *)
    GL.glVertex3f(0.0,0.0 ,0.0);(* a0 *)
    GL.glVertex3f(0.0,1.0 ,0.0);(* a1 *)
GL.glEnd();

  GL.glBegin(GLC.GL_POLYGON);
	GL.glVertex3f(0.0,0.0 ,0.0);(* a0 *)
	GL.glVertex3f(1.0,0.0, 0.0);(* b0 *)
	GL.glVertex3f(1.0,0.0,-1.0);(* c0 *)
	GL.glVertex3f(0.0,0.0,-1.0);(* d0 *)
	GL.glVertex3f(0.0,1.0 ,0.0);(* a1 *)
	GL.glVertex3f(1.0,1.0, 0.0);(* b1 *)
	GL.glVertex3f(1.0,1.0,-1.0);(* c1 *)
	GL.glVertex3f(0.0,1.0,-1.0);(* d1 *)
  GL.glEnd();
GL.DelFCR();  
END Esquare;

PROCEDURE Park;
VAR i: LONGINT;
    p: REAL;
    x, y: REAL;
BEGIN
 GL.glBegin(GLC.GL_TRIANGLE_FAN);
   GL.glVertex3f(0,0,0.0 );   
   FOR i:=0 TO 390 BY 30 DO
   	p := i*3.14/180;
   	x := Math.sin(p); y := Math.cos(p);
    	GL.SetFCR(); GL.glVertex3f(x, y, 0.0 ); GL.DelFCR();
   END;
  GL.glEnd();
END Park;

PROCEDURE Pillar;
VAR i : LONGINT;
    p: REAL;
    x, y: REAL;
BEGIN
GL.glBegin(GLC.GL_QUAD_STRIP);
   FOR i := 0 TO 390 BY 30 DO
   	p :=i*3.14/180;
   	x := Math.sin(p)/2.0; y := Math.cos(p)/2.0;
   	GL.SetFCR();
	GL.glVertex3f(x, y,1.0 );
	GL.glVertex3f(x, y,0.0 );
	GL.DelFCR();
   END;
 GL.glEnd();
END Pillar;
(* ******************* *)


PROCEDURE Primitives*;

BEGIN 
IF ctx = NIL THEN Error; RETURN END;
GL.SetFCR();	
	(* Resize *)
	ctx.MakeCurrent();
	GL.glViewport(0, 0, w, h);
	
	(* Restore *)
	GL.glClearColor (0, 0, 0, 0);
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;

	GL.glOrtho(-2.0, 2.0, -2.0 , 2.0, -4.0, 4.0);
	
	GL.glClear (GLC.GL_COLOR_BUFFER_BIT+ GLC.GL_DEPTH_BUFFER_BIT);

GL.DelFCR();
	GL.glPushMatrix();
	GL.glTranslatef(-0.3, 0.3, 0);
	GL.glScalef(0.4, 0.4, 0.5);
	Points();
	GL.glPopMatrix();
	
	GL.glPushMatrix();
	GL.glColor3f (0.0, 1.0, 1.0);	
	GL.glTranslatef(0.3, 0.3, 0);
	GL.glScalef(0.4, 0.4, 0.5);
	Line();
	GL.glPopMatrix();
	
	GL.glPushMatrix();	
	GL.glColor3f (1.0, 0.0, 1.0);
	GL.glRotatef(45, 0, 0, 1);
	GL.glTranslatef(0.3, 0.5, 0);
	GL.glScalef(0.4, 0.4, 0.5);	
	Triangle();
	GL.glPopMatrix();	
	
	GL.glPushMatrix();	
	GL.glColor3f (0.0, 1.0, 1.0);
	GL.glTranslatef(-0.3, -0.3, 0);
	GL.glScalef(0.4, 0.4, 0.5);	
	Square();
	GL.glPopMatrix();	
	
	GL.glPushMatrix();	
	GL.glTranslatef(-0.3, 0.3, 0);
	GL.glScalef(0.4, 0.4, 0.5);	
	Esquare();
	GL.glPopMatrix();	
	
	GL.glPushMatrix();	
	GL.glTranslatef(0.6, 0.6, 0);
	GL.glScalef(0.4, 0.4, 0.5);	
	Park();
	GL.glPopMatrix();	
	
	GL.glPushMatrix();		
	GL.glColor3f (1.0, 1.0, 1.0);
	GL.glTranslatef(0.6, -0.6, 0);
	GL.glScalef(0.4, 0.4, 0.5);
	Pillar();
	GL.glPopMatrix();	

	
(* ctx.SwapBuffers *);
SaveToImage("glprimitives.bmp");	
ctx.DeActivate;
END Primitives;


PROCEDURE  MakeGear (innerRadius, outerRadius, width: REAL; teeth: LONGINT;  toothDepth: REAL);
VAR  r0, r1, r2 , angle, da, u, v, len: REAL;
		i: LONGINT;
BEGIN
	
	r0 := innerRadius;
	r1 := outerRadius - toothDepth / 2.0;
	r2 := outerRadius + toothDepth / 2.0;

	da := 2.0 * Math.pi / teeth / 4.0;

GL.SetFCR();
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
GL.DelFCR();	
END MakeGear;


PROCEDURE  Do*;
VAR
	i: LONGINT;
	r, g, b: ARRAY 3 OF GL.GLfloat;
BEGIN 
	IF ctx = NIL THEN Error; RETURN END;

	r[0] := 1;  g[0] := 0;  b[0] := 0;
	r[1] := 0;  g[1] := 1;  b[1] := 0;
	r[2] := 0;  g[2] := 0;  b[2] := 1;
	

GL.SetFCR();
	(* Resize *)
	ctx.MakeCurrent();
	GL.glViewport(0, 0, w, h);

	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	
	GL.glOrtho(0, 1, 0, 1, -1, 1);
	
	(* Restore, Draw *)
	GL.glClearColor (0.6, 0.6, 0.6, 0);
	GL.glClear (GLC.GL_COLOR_BUFFER_BIT);
	
	GL.glBegin(GLC.GL_TRIANGLES);
		i := 0;
		GL.glColor3f (r[i], g[i], b[i]);
		GL.glVertex3f (0.25, 0.25, 0.0);
		
		i := (i + 1) MOD 3;
		GL.glColor3f (r[i], g[i], b[i]);
		GL.glVertex3f (0.75, 0.25, 0.0);
		
		i := (i + 1) MOD 3;
		GL.glColor3f (r[i], g[i], b[i]);
		GL.glVertex3f (0.5, 0.75, 0.0);
	GL.glEnd;
GL.DelFCR();

(* ctx.SwapBuffers *);
SaveToImage("gldo.bmp");	 
ctx.DeActivate;
END Do;

PROCEDURE  Do1*;
BEGIN 
IF ctx = NIL THEN Error; RETURN END;

GL.SetFCR();	
	(* intialize *)
ctx.MakeCurrent();
	GL.glViewport(0, 0, w, h);
	
	GL.glClearColor (0, 0, 0, 0);
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glOrtho(0, 1, 0, 1, -1, 1);
	
	(* draw *)
	GL.glClear (GLC.GL_COLOR_BUFFER_BIT);
	GL.glColor3d (1.0, 1.0, 1.0);
	GL.glBegin(GLC.GL_POLYGON);
		GL.glColor3d (1.0, 0.0, 0.0);
		GL.glVertex3d (0.25, 0.25, 0.0);
		GL.glColor3d (0.0, 1.0, 0.0);
		GL.glVertex3d (0.75, 0.25, 0.0);
		GL.glColor3d (0.0, 0.0, 1.0);
		GL.glVertex3d (0.75, 0.75, 0.0);
		GL.glColor3d (1.0, 1.0, 0.0);
		GL.glVertex3d (0.25, 0.75, 0.0);
	GL.glEnd;

GL.DelFCR();	
(* ctx.SwapBuffers *);
	
SaveToImage("gldo1.bmp");
ctx.DeActivate;
END Do1;

PROCEDURE  Gears*;
VAR

	gear1, gear2, gear3: GL.GLuint;
	rotx, roty, rotz, angle, angle1, angle2: GL.GLfloat;
	red, green, blue, lightPos: ARRAY 4 OF GL.GLfloat; 
	
BEGIN 
	IF ctx = NIL THEN Error; RETURN END;

	rotx := 20;  roty := 30;  rotz := 0;  angle := 20;
			
	(* Init view *)
		
(*	lightPos := [ 5.0, 5.0, 10.0, 0.0];
	red := [ 0.8, 0.1, 0.0, 1.0];  
	green := [ 0.0, 0.8, 0.2, 1.0];  
	blue := [ 0.2, 0.2, 1.0, 1.0];
*)
	lightPos[0] := 1.0;  	lightPos[1] := 1.0;	lightPos[2] := 1.0;	lightPos[3] := 0.0; (* directional *)
	
	red[0] := 0.8; 		red[1] := 0.1;		red[2] := 0.0;		red[3] := 1.0;
	green[0] := 0.0;	green[1] := 0.8;	green[2] := 0.2;	green[3] := 1.0;
	blue[0] := 0.2;		blue[1] := 0.2;		blue[2] := 1.0;		blue[3] := 1.0;
	
GL.SetFCR();
ctx.MakeCurrent1();
	GL.glEnable(GLC.GL_LIGHTING);
	GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_POSITION, S.ADR(lightPos[0]));
	GL.glEnable(GLC.GL_LIGHT0);
	GL.glEnable(GLC.GL_CULL_FACE);	
	GL.glEnable(GLC.GL_DEPTH_TEST);
	
	(* make the gears *)
	gear1 := GL.glGenLists(1);
	GL.glNewList(gear1, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, S.ADR(red[0]));
	MakeGear( 1.0, 4.0, 1.0, 20, 0.7);
	GL.glEndList;

	gear2 := GL.glGenLists(1);
	GL.glNewList(gear2, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, S.ADR(green[0]));
	MakeGear( 0.5, 2.0, 2.0, 10, 0.7);
	GL.glEndList;

	gear3 := GL.glGenLists(1);	
	GL.glNewList(gear3, GLC.GL_COMPILE);
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT_AND_DIFFUSE, S.ADR(blue[0]));
	MakeGear(1.3, 2.0, 0.5, 10, 0.7);
	GL.glEndList;


	(* ********** projection matrices  *********** *)
	GL.glClearColor (0.0, 0.0, 0.0, 0);
	GL.glViewport(0, 0, w, h);
	GL.glMatrixMode (GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glFrustum(-1.0, 1.0, -1, 1, 5.0, 60.0); 

	GL.glMatrixMode (GLC.GL_MODELVIEW);
	GL.glLoadIdentity;
	
	GL.glTranslatef(0.0, 0.0, -40.0);
GL.DelFCR();

	(* ********** Draw ********** *)
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
(* ctx.SwapBuffers *);
SaveToImage("glgears.bmp");

ctx.DeActivate;
END Gears;

PROCEDURE  SetP (VAR a: ARRAY OF GL.GLfloat;  a0, a1, a2: LONGREAL);
BEGIN
	a[0] := SHORT(a0);  a[1] := SHORT(a1);  a[2] := SHORT(a2)
END SetP;

PROCEDURE  BezSurf*;
VAR
	 i, j : LONGINT;
	ctrlPoints: ARRAY 4, 4 OF Point;
BEGIN
	IF ctx = NIL THEN Error; RETURN END;

	SetP(ctrlPoints[0, 0], -1.5, -1.5, 4.0);
	SetP(ctrlPoints[0, 1], -0.5, -1.5, 2.0);
	SetP(ctrlPoints[0, 2], 0.5, -1.5, -1.0);
	SetP(ctrlPoints[0, 3], 1.5, -1.5, 2.0);
	
	SetP(ctrlPoints[1, 0], -1.5, -0.5, 1.0);
	SetP(ctrlPoints[1, 1], -0.5, -0.5, 3.0);
	SetP(ctrlPoints[1, 2], 0.5, -0.5, 0.0);
	SetP(ctrlPoints[1, 3], 1.5, -0.5, -1.0);
	
	SetP(ctrlPoints[2, 0], -1.5, 0.5, 4.0);
	SetP(ctrlPoints[2, 1], -0.5, 0.5, 0.0);
	SetP(ctrlPoints[2, 2], 0.5, 0.5, 3.0);
	SetP(ctrlPoints[2, 3], 1.5, 0.5, 4.0);
	
	SetP(ctrlPoints[2, 0], -1.5, 1.5, -2.0);
	SetP(ctrlPoints[2, 1], -0.5, 1.5, -2.0);
	SetP(ctrlPoints[2, 2], 0.5, 1.5, 0.0);
	SetP(ctrlPoints[2, 3], 1.5, 1.5, -1.0);
	


GL.SetFCR();	
	(* Init View *)
	ctx.MakeCurrent();	
	
	GL.glMap2f(GLC.GL_MAP2_VERTEX_3, 0, 1, 3, 4, 0, 1, 12, 4, S.ADR(ctrlPoints[0, 0, 0]));
	GL.glEnable(GLC.GL_MAP2_VERTEX_3);
	GL.glMapGrid2f(20, 0, 1, 20, 0, 1);
	GL.glEnable(GLC.GL_DEPTH_TEST);
	GL.glShadeModel(GLC.GL_FLAT);	

	(* intialize *)
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glOrtho(-4.0, 4.0, -4.0 , 4.0, -4.0, 4.0);
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity;


	(*  draw *)	
	GL.glClearColor (0.0, 0, 0, 0);
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);
	GL.glColor3d(1.0, 1.0, 0.0);
	GL.glPushMatrix ();
	GL.glRotatef(85, 1, 1, 1);
	FOR  j := 0 TO 8 DO
		GL.glBegin(GLC.GL_LINE_STRIP);
			FOR  i := 0 TO 30 DO
				GL.glEvalCoord2d( i / 30.0,  j / 8.0)
			END;
		GL.glEnd;
		GL.glBegin(GLC.GL_LINE_STRIP);
			FOR  i := 0 TO 30 DO
				GL.glEvalCoord2d( j / 8.0, i / 30.0)
			END;
		GL.glEnd
	END;
	GL.glPopMatrix ();
	GL.glFinish();
	
GL.DelFCR();	
(* ctx.SwapBuffers *);
SaveToImage("glpbeziersurf.bmp");

ctx.DeActivate;
END BezSurf;


PROCEDURE  Accum*;
VAR
	thing1, thing2: GL.GLint;
BEGIN 
IF ctx = NIL THEN Error; RETURN END;

ctx.MakeCurrent();

	thing1 := GL.glGenLists(1);
	GL.glNewList(thing1, GLC.GL_COMPILE);
	GL.glColor3f(1, 0, 0);
	GL.glRectf(-1, -1, 1, 0);
	GL.glEndList;

	thing2 := GL.glGenLists(1);
	GL.glNewList(thing2, GLC.GL_COMPILE);
	GL.glColor3f(0.0, 1.0, 0.0);
	GL.glRectf(0.0, -1.0, 1.0, 1.0);
	GL.glEndList;
	

	(* initialize *)
	GL.glClearColor(0.6, 0.6, 0.6, 0);
	GL.glClearAccum(0.0, 0.0, 0, 0.0);

	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity;

	(* draw *)
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT);
	GL.glCallList(thing1);
	GL.glAccum(GLC.GL_LOAD, 0.5);

	GL.glClear(GLC.GL_COLOR_BUFFER_BIT);
	GL.glCallList(thing2);
	GL.glAccum(GLC.GL_ACCUM, 0.5);

	GL.glAccum(GLC.GL_RETURN, 1);

	GL.glFinish();

	(* ctx.SwapBuffers *);
SaveToImage("glaccumulation.bmp");	
ctx.DeActivate;
END Accum;



PROCEDURE  MakeBall ():GL.GLuint;
CONST  da = 18;  db = 18;  r = 1.0;
VAR  list: GL.GLuint;  color: BOOLEAN;
		a, b: LONGINT;  
		x, y, z: LONGREAL;
BEGIN
ctx.MakeCurrent();
	list := GL.glGenLists(1);
	GL.glNewList(list, GLC.GL_COMPILE);
	color := FALSE;
	FOR  a := -90 TO 90 - da BY da DO
		GL.glBegin(GLC.GL_QUAD_STRIP);
			FOR  b := 0 TO 360 BY db DO
				IF color THEN GL.glColor3d(1, 0, 0); ELSE GL.glColor3d(1, 1, 1); END;
				x := Math.cos(b * degToRad) * Math.cos(a * degToRad);
				y := Math.sin(b * degToRad) * Math.cos(a * degToRad);
				z := Math.sin(a * degToRad);
				GL.SetFCR(); GL.glVertex3d(x, y, z); GL.DelFCR();
				
				x := r * Math.cos(b * degToRad) * Math.cos((a + da) * degToRad);
				y := Math.sin(b * degToRad) * Math.cos((a + da) * degToRad);
				z := Math.sin((a + da) * degToRad);
				
				GL.SetFCR();	GL.glVertex3d(x, y, z); GL.DelFCR();
				color := ~color
			END;
		GL.glEnd
	END;
	
	GL.glEndList;
	
ctx.DeActivate();
KernelLog.String("MakeBall. Ok"); KernelLog.Ln;	
	RETURN list;
	
END MakeBall;

PROCEDURE  MakeLines ():GL.GLuint;
	VAR  list: GL.GLuint;  i: LONGINT;
		  x: REAL;	
BEGIN
ctx.MakeCurrent();
	list := GL.glGenLists(1);
	GL.glNewList(list, GLC.GL_COMPILE);
	
	GL.glBegin(GLC.GL_LINES);
		GL.glColor3f(0.0, 1.0, 1.0);
		FOR  i := -5 TO 5 DO
			GL.SetFCR();	GL.glVertex2i(i, -5);  GL.glVertex2i(i, 5); GL.DelFCR();	
		END;
		FOR  i := -5 TO 5 DO
			GL.SetFCR();	GL.glVertex2i(-5, i);  GL.glVertex2i(5, i); GL.DelFCR();	
		END;
		FOR  i := -5 TO 5 DO
			x := i*1.15;
			GL.SetFCR();	GL.glVertex2i(i, -5);  GL.glVertex2f(x, -5.9); GL.DelFCR();	
		END;
GL.SetFCR();
		GL.glVertex2f(-5.3, -5.35);
		GL.glVertex2f(5.3, -5.35);
		GL.glVertex2f(-5.75, -5.9);
		GL.glVertex2f(5.75, -5.9);
GL.DelFCR();		
	GL.glEnd;
	
	GL.glEndList;
ctx.DeActivate();
	KernelLog.String("MakeLines. Ok"); KernelLog.Ln;	
	RETURN list
END MakeLines;

PROCEDURE  Bounce*;
VAR

	ball, lines: GL.GLuint;
	x, y: REAL;
	vx, vy: REAL;
	zRot, dRot: LONGINT;
		
BEGIN
IF ctx = NIL THEN Error; RETURN END;

	x := 0.0;  y := 1.0;  zRot := 0;  dRot := 6;
	vx := 0.2;  vy := 0.0;
	
(* Initview *)

  	lines := MakeLines();
  	ball := MakeBall();

GL.SetFCR();
ctx.MakeCurrent();
  	GL.glClearColor(0, 0.0, 0.0, 0);
	GL.glShadeModel (GLC.GL_FLAT);
	GL.glEnable(GLC.GL_CULL_FACE);
	GL.glCullFace(GLC.GL_BACK);	
  (****************)

	GL.glMatrixMode (GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glOrtho(-6.0, 6.0, -6.0, 6.0 , -6.0, 6.0);

	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity;
	
	GL.glClear (GLC.GL_COLOR_BUFFER_BIT);

	GL.glCallList(lines);

	GL.glPushMatrix;
	GL.glTranslatef(x, y, 0.0);
	GL.glScalef(2, 2, 2);
	GL.glRotatef(8, 0, 0, 1);
	GL.glRotatef(90, 1, 0, 0);
	GL.glRotatef(zRot, 0, 0, 1);

	GL.glCallList(ball);

	GL.glPopMatrix;

GL.DelFCR();
(* ctx.SwapBuffers *);
SaveToImage("glbounce.bmp");
ctx.DeActivate;	
END Bounce;

PROCEDURE  Cube*;
BEGIN 
IF ctx = NIL THEN Error; RETURN END;
ctx.MakeCurrent();
GL.SetFCR();
	GL.glClearColor(0.0, 0.0, 0.0, 0.0);
	
	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.gluPerspective(45, 1, 1, 100);
	
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity;
	GL.glTranslatef(0.0, 0.0, -10.0);
	GL.glRotatef(45, 1.0, 1.0, 0.0);

	(* draw *)
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

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
GL.glFinish();

GL.DelFCR();

(* ctx.SwapBuffers *);
SaveToImage("glcube.bmp");
ctx.DeActivate;
END Cube;


PROCEDURE  Quadric*;
VAR
	matAmbient, matSpecular, lightPosition, modelAmbient: ARRAY 4 OF GL.GLfloat;
	matShininess: GL.GLfloat;
	qObj: GL.TGLUQuadricObj;
	startList: GL.GLuint;		
BEGIN 
IF ctx = NIL THEN Error; RETURN END;
(*	matAmbient := [ 0.5, 0.5, 0.5, 1.0];
	matSpecular := [ 1.0, 1.0, 1.0, 1.0];
	matShininess := 50.0;
	lightPosition := [ 1.0, 1.0, 1.0, 0.0];
	modelAmbient := [ 0.5, 0.5, 0.5, 1.0];
*)	
matAmbient[0] := 0.5;	matAmbient[1] :=  0.5;	matAmbient[2] := 0.5; 	matAmbient[3] := 1.0;
matSpecular[0] := 1.0;	matSpecular[1] := 1.0;	matSpecular[2] := 1.0;	matSpecular[3] := 1.0;
matShininess := 50.0;
lightPosition[0] := 1.0; 	lightPosition[1] := 1.0;		lightPosition[2] := 1.0;		lightPosition[3] := 0.0;
modelAmbient[0] := 0.5;	modelAmbient[1] := 0.5;	modelAmbient[2] := 0.5;	modelAmbient[3] := 1.0;

ctx.MakeCurrent();
	GL.glClearColor(0.0, 0.0, 0.0, 0.0);

	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_AMBIENT, S.ADR(matAmbient[0]));
	GL.glMaterialfv(GLC.GL_FRONT, GLC.GL_SPECULAR, S.ADR(matSpecular[0]));
	GL.glMaterialf(GLC.GL_FRONT, GLC.GL_SHININESS, matShininess);
	GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_POSITION, S.ADR(lightPosition[0]));
	GL.glLightModelfv(GLC.GL_LIGHT_MODEL_AMBIENT, S.ADR(modelAmbient[0]));

	GL.glEnable(GLC.GL_LIGHTING);
	GL.glEnable(GLC.GL_LIGHT0);
	GL.glEnable(GLC.GL_DEPTH_TEST);


(*  Create 4 display lists, each with a different quadric object.
 *  Different drawing styles and surface normal specifications
 *  are demonstrated.
 *)
	startList := GL.glGenLists(4);
	qObj := GL.gluNewQuadric();
	GL.gluQuadricCallback(qObj, GLC.GLU_ERROR, 0 (* S.ADR(QuadricError)*));

	GL.gluQuadricDrawStyle(qObj, GLC.GLU_FILL); (* smooth shaded *)
	GL.gluQuadricNormals(qObj, GLC.GLU_SMOOTH);
	GL.glNewList(startList, GLC.GL_COMPILE);
		GL.gluSphere(qObj, 0.75, 15, 10);
	GL.glEndList();

	GL.gluQuadricDrawStyle(qObj, GLC.GLU_FILL); (* flat shaded *)
	GL.gluQuadricNormals(qObj, GLC.GLU_FLAT);
	GL.glNewList(startList+1, GLC.GL_COMPILE);
		GL.gluCylinder(qObj, 0.5, 0.3, 1.0, 15, 5);
	GL.glEndList();

	GL.gluQuadricDrawStyle(qObj, GLC.GLU_LINE); (* all polygons wireframe *)
	GL.gluQuadricNormals(qObj, GLC.GLU_NONE);
	GL.glNewList(startList+2, GLC.GL_COMPILE);
		GL.gluDisk(qObj, 0.25, 1.0, 20, 4);
	GL.glEndList();

	GL.gluQuadricDrawStyle(qObj, GLC.GLU_SILHOUETTE); (* boundary only  *)
	GL.gluQuadricNormals(qObj, GLC.GLU_NONE);
	GL.glNewList(startList+3, GLC.GL_COMPILE);
		GL.gluPartialDisk(qObj, 0.0, 1.0, 20, 4, 0.0, 225.0);
	GL.glEndList;

	(* Resize *)
	GL.glViewport(0, 0, w, h);

	GL.glMatrixMode (GLC.GL_PROJECTION);
	GL.glLoadIdentity;
	GL.glOrtho(-2.5, 2.5, -2.5 , 2.5 , -10.0, 10.0);
		
	GL.glMatrixMode (GLC.GL_MODELVIEW);
	GL.glLoadIdentity;

	(* draw *)
GL.SetFCR();
	GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);
	GL.glPushMatrix;
	
	GL.glEnable(GLC.GL_LIGHTING);
	GL.glShadeModel (GLC.GL_SMOOTH);
	GL.glTranslated(-1.0, -1.0, 0.0);
	GL.glCallList(startList);

	GL.glShadeModel (GLC.GL_FLAT);
	GL.glTranslated(0.0, 2.0, 0.0);
	GL.glPushMatrix;
	GL.glRotated(300.0, 1.0, 0.0, 0.0);
	GL.glCallList(startList+1);
	GL.glPopMatrix;

	GL.glDisable(GLC.GL_LIGHTING);
	GL.glColor3d(0.0, 1.0, 1.0);
	GL.glTranslated(2.0, -2.0, 0.0);
	GL.glCallList(startList+2);

	GL.glColor3d(1.0, 1.0, 0.0);
	GL.glTranslated(0.0, 2.0, 0.0);
	GL.glCallList(startList+3);	
	
	GL.glPopMatrix;
	GL.glFinish();
	
GL.DelFCR();	

SaveToImage("glquadric.bmp");
ctx.DeActivate;
END Quadric;

PROCEDURE OpenDisplay*;
BEGIN 
w := 512; h := 512;
IF ctx = NIL THEN
	 NEW(ctx);
	ctx.Init(w , h, "GL-Test Display", FALSE);
	NEW(image);
	Raster.Create(image, w, h, Raster.BGRA8888);
END;	
END OpenDisplay;

(** *)
PROCEDURE CloseDisplay*;
BEGIN 
IF ctx # NIL THEN ctx.Close; ctx := NIL; END;	
END CloseDisplay;

BEGIN

END  GLTest.


GLTest.OpenDisplay~ 			GLTest.CloseDisplay~ 


GLTest.Primitives ~     GLTest.Do ~     GLTest.Do1 ~   GLTest.Gears ~

GLTest.BezSurf ~         GLTest.Accum ~    GLTest.Bounce ~ GLTest.Cube ~

GLTest.Quadric ~

SystemTools.Free GLTest  GLContext  ~ 


