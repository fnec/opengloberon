MODULE MyWMGLSLBricks; (** AUTHOR "fnecati"; PURPOSE "GLSL bricks shading example from OrangeBook"; *)
 
IMPORT
	SYSTEM, WMRectangles, WMGraphics, Strings,  Inputs,
	WM := WMWindowManager,  WMMessages, WMDialogs, KernelLog, 
	GL := OpenGL, GLC := OpenGLConst, GLContext, GLLib, GLSUtil := GLShaderUtils;

TYPE 
	PChar = GLSUtil.PChar; 
			
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WM.BufferWindow)
	VAR
		context : GLContext.Context;
		width, height: LONGINT;
		color: LONGINT;	 
		
		(* Movement variables *)
		fXDiff,  fYDiff, fZDiff: REAL;
		xLastIncr, yLastIncr: LONGINT;
		fXInertia, fYInertia, fScale, ftime: REAL;
		xLast, yLast : LONGINT;
		rotate: BOOLEAN;
		RotL : REAL;
	
		brickProg: GL.GLuint;  (* shader program *)
				
		PROCEDURE &New(w, h: LONGINT);
		VAR res: BOOLEAN;
		BEGIN
			width := w; height := h;
			Init(w, h, TRUE); (* use alpha, for 32bpp img *)
			manager := WM.GetDefaultManager();
			manager.Add(100, 100, SELF, {WM.FlagFrame, WM.FlagClose, WM.FlagNoResizing});

			SetTitle(Strings.NewString("MyGLSLWindow Bricks"));
			color := 0;

			fXDiff := 206;  fYDiff := 16; fZDiff := 10;
			xLastIncr := 0; yLastIncr := 0;
			fXInertia := -0.5; fYInertia := 0.0;
			fScale := 1.0; ftime := 0.0;
			xLast := -1; yLast := -1;

			rotate := TRUE;
			RotL := 1 * 3.14 / 180; 


			NEW(context);
			context.Init(w, h, "MyGLWindow", FALSE);
			context.MakeCurrent();
				GL.ReadExtensions();
				GL.ReadImplementationProperties;			
				
				GL.glDepthFunc(GLC.GL_LESS);
				GL.glEnable(GLC.GL_DEPTH_TEST);
				
 				IF (GL.GL_ARB_vertex_shader & GL.GL_ARB_fragment_shader) THEN
					KernelLog.String("Ready for GLSL"); KernelLog.Ln; 
				ELSE
					KernelLog.String("No GLSL support"); KernelLog.Ln; 
					Close;
				END;
				res := InstallBrickShaders();
				IF res THEN 
					KernelLog.String("GLSLBrick installed"); KernelLog.Ln; 
				ELSE
					KernelLog.String("GLSLBrick NOT installed"); KernelLog.Ln; 
				END;	
			context.DeActivate();	
			
			Reshape(w, h);	
			UpdateImage;
		END New; 

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);	     
		BEGIN
		CASE CHR(ucs) OF
			| "b": NextClearColor(); UpdateImage;
			| "-" : fScale := fScale - 0.5; UpdateImage;
			| "+" :  fScale := fScale + 0.5; UpdateImage;
			| "s": SaveImage;
			| "q" : Close;			
		ELSE	
			CASE keysym OF 
				Inputs.KsHome:  fXDiff := 0; fYDiff := 35; fZDiff := 0;
			            xLastIncr := 0; yLastIncr := 0; fXInertia := -0.5; fYInertia := 0;
			            fScale := 1.0; UpdateImage;
			|	Inputs.KsLeft : fXDiff := fXDiff - 1.0 ; UpdateImage;
			|	Inputs.KsRight: fXDiff := fXDiff + 1.0; UpdateImage;
			|	Inputs.KsUp: fYDiff := fYDiff - 1.0; UpdateImage;
			|	Inputs.KsDown: fYDiff := fYDiff + 1.0; UpdateImage;
			
			ELSE
			END;			
		END;	
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			fScale := fScale + dz*0.5*0.2;			
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
			Close^;			
			 context.Close;
			 context := NIL;				
		END Close;

		PROCEDURE UpdateImage;
		VAR	rect: WMRectangles.Rectangle;
		BEGIN 
			context.MakeCurrent();
				Display(); 
			context.RenderInto(img); 
			context.DeActivate();
			
			rect := WMRectangles.MakeRect(0, 0, GetWidth(), GetHeight());
			WMRectangles.MoveRel(rect, bounds.l, bounds.t);
			WMRectangles.ClipRect(rect, bounds);
			manager.AddDirty(rect);			
		END UpdateImage;

		PROCEDURE SaveImage;
		VAR res: LONGINT;
			fname: ARRAY 128 OF CHAR;
		BEGIN		
			fname:="mywmglsltest.bmp";
			IF WMDialogs.QueryString(" Save File name: ",fname)=WMDialogs.ResOk THEN
					WMGraphics.StoreImage(img, fname,res);
			END;		
		END SaveImage;

		PROCEDURE DrawCube();
		VAR size, scale, delta: REAL;
			A, B, C, D, E, F, G, H, I, K, L, M, N, O: ARRAY [3] OF REAL;
		BEGIN

			size := 1.0;  scale := 0.2; delta := 0.1;
			A := [ size,  size,  size * scale + delta ];
			B := [ size,  size, -size * scale + delta ];
			C := [ size, -size, -size * scale ];
			D := [ size, -size,  size * scale ];
			E := [-size,  size,  size * scale + delta ];
			F := [-size,  size, -size * scale + delta ];
			G := [-size, -size, -size * scale ];
			H := [-size, -size,  size * scale ];
			I := [ 1.0,  0.0,  0.0];
			K := [-1.0,  0.0,  0.0];
			L := [ 0.0,  0.0, -1.0];
			M := [ 0.0,  0.0,  1.0];
			N := [ 0.0,  1.0,  0.0];
			O := [ 0.0, -1.0,  0.0];

			GL.SetFCR();
			GL.glBegin(GLC.GL_QUADS);
				GL.glNormal3fv(SYSTEM.ADR(I[0]));

				GL.glTexCoord2f(1,1);
				GL.glVertex3fv(SYSTEM.ADR(D[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(C[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(B[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(A[0]));
	
				GL.glNormal3fv(SYSTEM.ADR(K[0]));
	
				GL.glTexCoord2f(1,1);
 				GL.glVertex3fv(SYSTEM.ADR(G[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(H[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(E[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(F[0]));
	
				GL.glNormal3fv(SYSTEM.ADR(L[0]));
	
				GL.glTexCoord2f(1,1);
				GL.glVertex3fv(SYSTEM.ADR(C[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(G[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(F[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(B[0]));
	
				GL.glNormal3fv(SYSTEM.ADR(M[0]));
	
				GL.glTexCoord2f(1,1);
				GL.glVertex3fv(SYSTEM.ADR(H[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(D[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(A[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(E[0]));
	
				GL.glNormal3fv(SYSTEM.ADR(N[0]));
	
				GL.glTexCoord2f(1,1);
				GL.glVertex3fv(SYSTEM.ADR(E[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(A[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(B[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(F[0]));
	
				GL.glNormal3fv(SYSTEM.ADR(O[0]));
    
				GL.glTexCoord2f(1,1);
				GL.glVertex3fv(SYSTEM.ADR(G[0]));
				GL.glTexCoord2f(0,1);
				GL.glVertex3fv(SYSTEM.ADR(C[0]));
				GL.glTexCoord2f(0,0);
				GL.glVertex3fv(SYSTEM.ADR(D[0]));
				GL.glTexCoord2f(1,0);
				GL.glVertex3fv(SYSTEM.ADR(H[0]));
    
			GL.glEnd();
			GL.DelFCR();
		END DrawCube;

		PROCEDURE Display();
		VAR x: REAL;
		BEGIN
		
			GL.glLoadIdentity();
			GL.SetFCR();  
				GL.glTranslatef(0.0, 0.0, -5.0);
				GL.glRotatef(fYDiff, 1,0,0);
				GL.glRotatef(fXDiff, 0,1,0);
				GL.glRotatef(fZDiff, 0,0,1);
				GL.glScalef(fScale, fScale, fScale);
			GL.DelFCR();
			
			GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);

			GL.glUniform3f(getUniLoc(brickProg, "MortarColor"), 0.85, 0.86, 0.84);
			GL.glUniform3f(getUniLoc(brickProg, "LightPosition"), 0.0, 0.0, 4.0);
			DrawCube();
			

			GL.glLoadIdentity();
			x := fXDiff + 90.0;
			GL.SetFCR();  
				GL.glTranslatef(0.0, 0.0, -5.0);
				GL.glRotatef(fYDiff, 1,0,0);
				GL.glRotatef(x, 0,1,0);
				GL.glRotatef(fZDiff, 0,0,1);
				GL.glScalef(fScale, fScale, fScale);
			GL.DelFCR(); 
			

			GL.glUniform3f(getUniLoc(brickProg, "MortarColor"), 0.1, 1.0, 0.2);
			GL.glUniform3f(getUniLoc(brickProg, "LightPosition"), 2.0, 0.0, 2.0);
			GLLib.SolidTeapot(0.8);
(*			GLLib.SolidSphere(0.8, 50,40); *)
(*			GLLib.SolidDodecahedron;*)
(*			GLLib.SolidTorus(0.2, 0.9, 10, 40); *)

		END Display;

		PROCEDURE NextClearColor ();
		BEGIN 
			context.MakeCurrent();
			INC(color);    	
			CASE color OF    
			0:  GL.glClearColor(0.0, 0.0, 0.0, 1.0);
			|1:  GL.glClearColor(0.2, 0.2, 0.3, 1.0);
			ELSE 
				GL.glClearColor(0.7, 0.7, 0.7, 1.0);
				color := 0;
			END;
			context.DeActivate();		        
		END NextClearColor;

		PROCEDURE Reshape(w,  h: LONGINT);
		VAR vp, aspect: REAL;
			vp1, vp2, vp3, vp4: REAL;
		BEGIN
			context.MakeCurrent;

			vp := 0.8;
			aspect :=  w / h;
			vp1 := -vp; vp2 := vp; vp3 := -vp/aspect; vp4 := vp/aspect;

			GL.glViewport(0, 0, w, h);
			GL.glMatrixMode(GLC.GL_PROJECTION);
			GL.glLoadIdentity();
    
			GL.SetFCR();
				GL.gluPerspective(45, 1, 0.1, 100);
			 GL.DelFCR();

			GL.glMatrixMode(GLC.GL_MODELVIEW);
			GL.glLoadIdentity();

			GL.SetFCR();
				GL.glTranslatef(0.0, 0.0, -5.0);
			GL.DelFCR();   
		
			context.DeActivate();
		END Reshape;

		(* Get the location of a uniform variable *)
		PROCEDURE getUniLoc(program: GL.GLuint; CONST name: ARRAY OF CHAR): GL.GLint;
		VAR loc: GL.GLint;
		BEGIN
			loc := GL.glGetUniformLocation(program, name);
			IF loc = -1 THEN
				KernelLog.String("No such uniform named "); KernelLog.String(name); KernelLog.Ln; 
    			END;    
    			GLSUtil.PrintOpenGLError("getUniloc: ");  (* Check for OpenGL errors *)
			RETURN loc;
		END getUniLoc;

		PROCEDURE InstallBrickShaders(): BOOLEAN;
		VAR
			vss, fss: PChar;
		BEGIN
		    (* Create a vertex shader object and a fragment shader object *)
		    
			vss := GLSUtil.TextFileRead("brick.vert");
			fss := GLSUtil.TextFileRead("brick.frag");
		    (* Install program object as part of current state *)

			IF ~ GLSUtil.LoadShaders(vss, fss, brickProg) THEN
				KernelLog.String("LoadShader Error"); KernelLog.Ln;  
				RETURN FALSE;
			END;
	
			GL.glUseProgram(brickProg);

    			(* Set up initial uniform values *)
    			GL.glUniform3f(getUniLoc(brickProg, "BrickColor"), 1.0, 0.3, 0.2);
    			GL.glUniform3f(getUniLoc(brickProg, "MortarColor"), 0.85, 0.86, 0.84);
    			GL.glUniform2f(getUniLoc(brickProg, "BrickSize"), 0.30, 0.15);
    			GL.glUniform2f(getUniLoc(brickProg, "BrickPct"), 0.90, 0.85);
    			GL.glUniform3f(getUniLoc(brickProg, "LightPosition"), 0.0, 0.0, 4.0);

    			RETURN TRUE;
		END InstallBrickShaders;

END GLWindow;

PROCEDURE Open*;
VAR 
	window: GLWindow;
BEGIN
	NEW(window, 300, 300);
END Open;

BEGIN

END MyWMGLSLBricks.

SystemTools.Free  MyWMGLSLBricks GLShaderUtils GLLib GLContext~ ~

MyWMGLSLBricks.Open ~

