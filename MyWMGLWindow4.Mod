MODULE MyWMGLWindow4; (** AUTHOR "fnecati"; PURPOSE ""; *)
 (* triangle using vertex arrays  *)
IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Math, SYSTEM,
	WM := WMWindowManager,  WMMessages, KernelLog, WMDialogs,
	GL := OpenGL, GLC := OpenGLConst, GLContext;

CONST waittime=5;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;


	Vertex=RECORD
		x, y, z: REAL;	(* vertex *)
		nx, ny, nz: REAL; (* normal *)
		s0, t0: REAL; (* Texcoord0 *)
	END;
	MyVertex = POINTER TO ARRAY OF Vertex;	
	
	GLWindow* =  OBJECT(WM.BufferWindow)
	VAR
		 timer: Kernel.MilliTimer; 
		alive,  animated: BOOLEAN;
		context:   GLContext.Context;
		width, height: LONGINT;
		
		angle: REAL;
		drawMode: LONGINT;
		vertexVBOID, indexVBOID, vaoID: GL.GLuint;
		pindices : ARRAY [3] OF INTEGER;
		pvertex : MyVertex;
	     lookatz: LONGREAL;
				
		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			width := w; height := h;
			Init(w, h, TRUE); (* use alpha, for 32bpp img *)
			manager := WM.GetDefaultManager();
			manager.Add(100, 100, SELF, {WM.FlagFrame, WM.FlagClose, WM.FlagNoResizing});

			SetTitle(Strings.NewString("MyGLWindow-Gears "));

			NEW(context);
			context.Init(w, h, "MyGLWindow", FALSE);
			context.MakeCurrent();
				GL.ReadExtensions;
				initGL;
			context.DeActivate();
			lookatz := 3.0;	
			angle := 0.0;
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
			| "-" : angle := angle - 1.0; UpdateImage;
			| "+" : angle := angle + 1.0; UpdateImage;
			| "s": SaveImage;
			| "q" : Close;
		ELSE	

		END;	
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			lookatz := lookatz + dz;
			Reshape;
			UpdateImage;
		END WheelMove;
		
		PROCEDURE Handle(VAR m: WMMessages.Message);
		BEGIN
			IF (m.msgType = WMMessages.MsgExt) & (m.ext # NIL) & (m.ext IS KillerMsg) THEN
				Close;
			ELSE Handle^(m)
			END
		END Handle;

		(** *)
		PROCEDURE DeleteBuffers*;
		BEGIN
			context.MakeCurrent();
				GL.glDeleteBuffersARB(1, SYSTEM.ADR(vertexVBOID));
				GL.glDeleteBuffersARB(1, SYSTEM.ADR(indexVBOID));
				GL.glDeleteBuffersARB(1, SYSTEM.ADR(vaoID));
			context.DeActivate();
		END DeleteBuffers;
		
		PROCEDURE Close*;
		BEGIN
			alive := FALSE;	
			Close^;
			DeleteBuffers;
			 context.Close;
			 context := NIL;
			window := NIL;
		END Close;


		PROCEDURE UpdateImage;		
		BEGIN {EXCLUSIVE}
			context.MakeCurrent();
				displayCB;
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

PROCEDURE initGL();
VAR offset: LONGINT;
BEGIN
        NEW(pvertex,3);
	(* VERTEX 0 *)
	pvertex[0].x := 0.0;
	pvertex[0].y := 0.0;
	pvertex[0].z := 0.0;
	pvertex[0].nx := 0.0;
	pvertex[0].ny := 0.0;
	pvertex[0].nz := 1.0;
	pvertex[0].s0 := 0.0;
	pvertex[0].t0 := 0.0;
	(* VERTEX 1*)
	pvertex[1].x := 1.0;
	pvertex[1].y := 0.0;
	pvertex[1].z := 0.0;
	pvertex[1].nx := 0.0;
	pvertex[1].ny := 0.0;
	pvertex[1].nz := 1.0;
	pvertex[1].s0 := 1.0;
	pvertex[1].t0 := 0.0;
	(* VERTEX 2 *)
	pvertex[2].x := 0.0;
	pvertex[2].y := 1.0;
	pvertex[2].z := 0.0;
	pvertex[2].nx := 0.0;
	pvertex[2].ny := 0.0;
	pvertex[2].nz := 1.0;
	pvertex[2].s0 := 0.0;
	pvertex[2].t0 := 1.0;

	pindices[0] := 0;  pindices[1] := 1; pindices[2] := 2;

 	GL.glClearColor(0.9, 0.9, 0.9, 1.0);
   	GL.glColor3f(0.2, 0.8, 0.5);	
   	
	GL.glGenVertexArrays(1, SYSTEM.ADR(vaoID));
	GL.glBindVertexArray(vaoID);
	GL.glGenBuffers(1, SYSTEM.ADR(vertexVBOID));
	GL.glBindBuffer(GLC.GL_ARRAY_BUFFER, vertexVBOID);
	GL.glBufferData(GLC.GL_ARRAY_BUFFER, LEN(pvertex,0)*8*4, SYSTEM.ADR(pvertex[0].x), GLC.GL_STATIC_DRAW);
 
	GL.glEnableVertexAttribArray(0);  
	offset := 0; 
	GL.glVertexAttribPointer(0, 3, GLC.GL_FLOAT, GLC.GL_FALSE, 8*4, offset);

	GL.glEnableVertexAttribArray(1);
	offset := 12;
	GL.glVertexAttribPointer(1, 3, GLC.GL_FLOAT, GLC.GL_FALSE, 8*4, offset);
		 
	GL.glGenBuffers(1, SYSTEM.ADR(indexVBOID));
	GL.glBindBuffer(GLC.GL_ELEMENT_ARRAY_BUFFER, indexVBOID);
	GL.glBufferData(GLC.GL_ELEMENT_ARRAY_BUFFER, 3*2, SYSTEM.ADR(pindices[0]), GLC.GL_STATIC_DRAW);

END initGL;

PROCEDURE displayCB();
BEGIN
    (* clear buffer *)
    GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT );
	GL.glPushMatrix();
		 GL.SetFCR();
			GL.glRotatef(angle, 0.0, 0.0, 1.0);
		GL.DelFCR();
	(*The starting point of the IBO *)
	GL.glDrawElements(GLC.GL_TRIANGLES, 3, GLC.GL_UNSIGNED_SHORT, 0); 
	GL.glPopMatrix();
END displayCB;

PROCEDURE Reshape;
BEGIN	 {EXCLUSIVE}
context.MakeCurrent();
GL.SetFCR();
 	GL.glMatrixMode(GLC.GL_PROJECTION);
	GL.glLoadIdentity();
	GL.gluPerspective(45.0, 1.0, 0.1, 100.0);
	
	GL.glMatrixMode(GLC.GL_MODELVIEW);
	GL.glLoadIdentity();		
	GL.gluLookAt(0.0, 0.0, lookatz,   0.0, 0.0, 0.0,   0.0, 1.0, 0.0); (* eye(x,y,z), focal(x,y,z), up(x,y,z) *) 
GL.DelFCR();
context.DeActivate();
END Reshape;


BEGIN  {ACTIVE} 

	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN
			 IF Kernel.Expired(timer) THEN  			 	
			 	 UpdateImage();
			 	  angle := angle + 1.0;
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

END MyWMGLWindow4.

SystemTools.Free  MyWMGLWindow4  GLContext  ~

MyWMGLWindow4.Open ~
