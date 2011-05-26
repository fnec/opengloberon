MODULE MyWMGLPlotSurface; (** AUTHOR "fnecati"; PURPOSE "a test for 3D function plotting with light"; *)

IMPORT
	WMRectangles, WMGraphics, Strings, Math:=MathL,
	WM := WMWindowManager,  WMMessages,  WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, GLContext, SYSTEM;

CONST 
	Nx = 50; (* number of samples in X, Y directions *)
	Ny = 50;
	Ymin = -1.0; Xmin = -1.0;
	Ymax = 1.0;  Xmax = 1.0;
	dx = (Xmax - Xmin)/Nx;
	dy = (Ymax - Ymin)/Ny;

(* Angle to rotate when the user presses an arrow key *)
	angle = 5.0;

(* Amount to scale bu when the user presses PgUp or PgDn *)
	scalefactor = 0.8;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;
	
   TVector3d* = ARRAY [3] OF LONGREAL;
   
	GLWindow* =  OBJECT(WM.BufferWindow)
	VAR
		context : GLContext.Context;
		width, height: LONGINT;

		ambientLight,  diffuseLight, specularLight, 
	    (* Position the light somewhere close over the top of the figure*)
	  	position: ARRAY 4 OF GL.GLfloat;	 
		drawMode: LONGINT;
		funcplane: GL.GLuint;
		
		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			width := w; height := h;
			Init(w, h, TRUE); (* use alpha, for 32bpp img *)
			manager := WM.GetDefaultManager();
			manager.Add(100, 100, SELF, {WM.FlagFrame, WM.FlagClose, WM.FlagNoResizing});

			SetTitle(Strings.NewString("MyGLWindow: Lorenz "));
						
			NEW(context);
			context.Init(w, h, "MyGLWindow", FALSE);

			context.MakeCurrent();
			Reshape;
			initGL;
			context.DeActivate();
			
			UpdateImage;	
		END New; 

		
		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);

		BEGIN

		CASE CHR(ucs) OF
			 "d": drawMode := (drawMode+1) MOD 3; DrawMode(drawMode); UpdateImage;		
			| "s":		SaveImage;
			| "q" :		Close;
		ELSE	

			IF  keysym = 0FF51H  THEN   context.MakeCurrent(); GL.SetFCR(); GL.glRotated ( angle, 0.0, 0.0, 1.0 ) ; GL.DelFCR(); context.DeActivate(); UpdateImage; (* Cursor Left *)
			ELSIF keysym = 0FF53H THEN  context.MakeCurrent(); GL.SetFCR(); GL.glRotated ( -angle, 0.0, 0.0, 1.0 ) ; GL.DelFCR(); context.DeActivate(); UpdateImage; (* Cursor Right *)
			ELSIF keysym = 0FF54H THEN  context.MakeCurrent(); GL.SetFCR(); GL.glRotated ( -angle, 0.0, 1.0, 0.0 ); GL.DelFCR(); context.DeActivate(); UpdateImage; (* Cursor Down *)
			ELSIF keysym = 0FF52H THEN   context.MakeCurrent(); GL.SetFCR(); GL.glRotated ( angle, 0.0, 1.0, 0.0 ); GL.DelFCR(); context.DeActivate(); UpdateImage; (* Cursor Up *)
			ELSIF keysym = 0FF56H THEN   context.MakeCurrent(); GL.SetFCR(); GL.glScaled ( scalefactor, scalefactor, scalefactor ) ; GL.DelFCR(); context.DeActivate(); UpdateImage;  (* Page Down *)
			ELSIF keysym = 0FF55H THEN  context.MakeCurrent(); GL.SetFCR(); GL.glScaled ( 1.0 / scalefactor, 1.0 / scalefactor, 1.0 / scalefactor ) ; GL.DelFCR(); context.DeActivate(); UpdateImage; (* Page Up *)
			ELSE 
			END;
		END;	
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			IF dz < 0 THEN
				context.MakeCurrent(); 
				GL.SetFCR(); GL.glScaled ( scalefactor, scalefactor, scalefactor ) ; GL.DelFCR(); 
				context.DeActivate(); 
				UpdateImage; 
			ELSE
				context.MakeCurrent(); 
				GL.SetFCR(); GL.glScaled ( 1.0 / scalefactor, 1.0 / scalefactor, 1.0 / scalefactor ) ; GL.DelFCR();
				 context.DeActivate(); 
				 UpdateImage; 
			END;
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
			Close^;			
			 context.Close;
			 context := NIL;				
		END Close;

		PROCEDURE UpdateImage;
		VAR t: LONGINT;
		BEGIN  {EXCLUSIVE}
			context.MakeCurrent();
					Display;	
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


(* from W3dVectors.Mod *)
PROCEDURE Cross(a, b: TVector3d): TVector3d;
VAR result : TVector3d;
BEGIN 
	result[0]:=a[1]*b[2]-a[2]*b[1]; 
	result[1]:=a[2]*b[0]-a[0]*b[2]; 
	result[2]:=a[0]*b[1]-a[1]*b[0]; 
	RETURN result 
END Cross;

PROCEDURE Sqr(x: LONGREAL):LONGREAL;
BEGIN
	RETURN x * x
END Sqr;

PROCEDURE VLength3(a: TVector3d):LONGREAL;
VAR t: LONGREAL;
BEGIN
	a[0] := ABS(a[0]); a[1]:= ABS(a[1]); a[2]:=ABS(a[2]);
	IF a[0] > a[1] THEN t := a[0]; a[0] := a[1]; a[1]:=t END;
	IF a[1] > a[2] THEN t := a[1]; a[1] := a[2]; a[2]:=t END;
	(* a.z >= a.y, a.z >= a.x *)
	IF a[2] = 0 THEN RETURN 0
	ELSE RETURN a[2] * Math.sqrt(1 + Sqr(a[0]/a[2]) + Sqr(a[1]/a[2]))
	END
END VLength3;

PROCEDURE VScaled3*(a:TVector3d; factor:LONGREAL):TVector3d;
VAR result : TVector3d;
BEGIN 
       result := factor*a;
	RETURN result  
END VScaled3;

PROCEDURE VNormed3*(a: TVector3d):TVector3d;
BEGIN 
	RETURN VScaled3(a, 1/VLength3(a)) 
END VNormed3;

(* PROCEDURE MyFunc ( x, y: LONGREAL): LONGREAL;
VAR z: LONGREAL;
BEGIN
 z := 2*Math.exp(- (x*x + y*y));
 RETURN z;
END MyFunc;
*)

 PROCEDURE MyFunc ( x, y: LONGREAL): LONGREAL;
VAR z, r: LONGREAL;
BEGIN
 r :=10* (x*x + y*y);
 IF r # 0.0  THEN 
	 z := Math.sin(r)/r;
 ELSE
	z := 1.0;
 END;
 RETURN z;
END MyFunc;

PROCEDURE Grid;
VAR x: LONGREAL;
BEGIN 
  GL.glLineWidth(1.0);
  GL.glColor3d(1.0,1.0,1.0);
  GL.glBegin(GLC.GL_LINES);
  x := -1.0;
  WHILE x <=1.0 DO
    GL.SetFCR();
    GL.glVertex3d(-1.0, 0.0, x);
    GL.glVertex3d(1.0, 0.0, x);
    GL.glVertex3d(x, 0.0,-1.0);
    GL.glVertex3d(x, 0.0, 1.0);
    GL.DelFCR();
    x := x + 0.2;
  END;
  GL.glEnd();
END Grid;
(*
PROCEDURE render;
VAR i, j: LONGINT;
	x, y: LONGREAL;
BEGIN
  FOR i:=0 TO Nx-1 DO
    FOR j:=0 TO Ny-1 DO
             x := Xmin + i*dx;
             y := Ymin + j*dy;
	      GL.glBegin (GLC.GL_QUADS);        
			GL.glVertex3d(x, MyFunc(x,y), y);
			GL.glVertex3d(x+dx, MyFunc(x+dx, y), y);
			GL.glVertex3d(x+dx, MyFunc(x+dx,y+dy), y+dy);
			GL.glVertex3d(x, MyFunc(x,y+dy), y+dy);
		GL.glEnd();
	END;
 END;
END render;
*)
PROCEDURE render;
VAR i, j: LONGINT;
	x, y: LONGREAL;
	p1, p2, p3, norm, v1, v2: TVector3d;
BEGIN
  FOR i:=0 TO Nx-1 DO
    FOR j:=0 TO Ny-1 DO
             x := Xmin + i*dx;
             y := Ymin + j*dy;
	      GL.glBegin (GLC.GL_TRIANGLES);
	             p1[0] := x;  p1[1] := MyFunc(x,y); p1[2] := y;
	             p2[0] := x+dx;  p2[1] := MyFunc(x+dx, y); p2[2] := y;
	             p3[0] := x; p3[1] := MyFunc(x,y+dy); p3[2] := y + dy;
	             v1 := p2-p1; v2 := p3-p1;
	             norm := VNormed3(Cross(v1, v2));
	      		GL.glNormal3d(norm[0], norm[1], norm[2]);
			GL.glVertex3d(p1[0], p1[1], p1[2]);
			GL.glVertex3d(p2[0], p2[1], p2[2]);
			GL.glVertex3d(p3[0], p3[1], p3[2]);
			

	             p1[0] := x+dx;  p1[1] := MyFunc(x+dx,y); p1[2] := y;
	             p2[0] := x+dx;  p2[1] := MyFunc(x+dx, y+dy); p2[2] := y+dy;
	             p3[0] := x; p3[1] := MyFunc(x,y+dy); p3[2] := y + dy;
	             v1 := p2-p1; v2 := p3-p1;
	             norm := VNormed3(Cross(v1, v2));
	      		GL.glNormal3d(norm[0], norm[1], norm[2]);
			GL.glVertex3d(p1[0], p1[1], p1[2]);
			GL.glVertex3d(p2[0], p2[1], p2[2]);
			GL.glVertex3d(p3[0], p3[1], p3[2]);
			

		GL.glEnd();
	END;
 END;
END render;

PROCEDURE Reshape;
BEGIN
 GL.SetFCR();
    GL.glViewport (0, 0, width, height);
    GL.glMatrixMode (GLC.GL_PROJECTION);
    GL.glLoadIdentity ();
    GL.gluPerspective (30, 1.0, 1.0, 100.0);

    GL.glMatrixMode (GLC.GL_MODELVIEW);
    GL.glLoadIdentity();
    GL.gluLookAt (5.0, 5.0, 7.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
 GL.DelFCR();      
END Reshape;

PROCEDURE DrawMode(dm: LONGINT);
VAR drawMode: LONGINT;
BEGIN
(*	drawMode := dm;
	context.MakeCurrent();
	  	
        IF drawMode = 0 THEN       (* fill mode*)
		
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
*)	  
END DrawMode;

PROCEDURE initGL;
BEGIN 
    (* Setup the lighting *)

   ambientLight[0] :=  1.0; ambientLight[1] :=  1.0; ambientLight[2] :=  1.0; ambientLight[3] :=  1.0;
  diffuseLight[0] := 1.0; diffuseLight[1] := 0.9; diffuseLight[2] := 0.8; diffuseLight[3] := 1.0;
  specularLight[0] :=  0.0; specularLight[1] :=  1.0; specularLight[2] :=  0.0; specularLight[3] :=  1.0;
    (* Position the light somewhere close over the top of the figure*)
  position[0] := 1.0; position[1] := 1.0; position[2] := 1.0; position[3] := 1.0;
 
    (* Call the actual options for light0 *)
  GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_AMBIENT, SYSTEM.ADR(ambientLight[0]));
 (* GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_DIFFUSE, SYSTEM.ADR(diffuseLight[0]));*)
  GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_SPECULAR, SYSTEM.ADR(specularLight[0]));
  GL.glLightfv(GLC.GL_LIGHT0, GLC.GL_POSITION, SYSTEM.ADR(position[0]));

  GL.glEnable (GLC.GL_DEPTH_TEST);
  GL.glEnable (GLC.GL_LIGHTING);
  GL.glEnable (GLC.GL_LIGHT0);
  GL.glShadeModel (GLC.GL_FLAT);  (* can be GL_SMOOTH if you dont want to see edges *)
 (* GL.glShadeModel (GLC.GL_SMOOTH);*)
(*  GL.glEnable(GLC.GL_CULL_FACE);*)
   GL.glClearColor (0.0,0.0,0.0,1.0);

   	(* make the plane *)
	funcplane := GL.glGenLists(1);
		GL.glNewList(funcplane, GLC.GL_COMPILE);
		render;
	GL.glEndList;	
END initGL;


PROCEDURE Display;
BEGIN
  GL.glClear (GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);  
(*  Grid(); *)
(*  render(); *)
 GL.glCallList(funcplane);	
END Display;

BEGIN
END GLWindow;

PROCEDURE Open*;
VAR
	window: GLWindow;
BEGIN
	NEW(window, 512, 512);
END Open;

BEGIN

END MyWMGLPlotSurface.

SystemTools.Free  MyWMGLPlotSurface  GLContext ~    OpenGL   OpenGLConst ~

MyWMGLPlotSurface.Open ~
