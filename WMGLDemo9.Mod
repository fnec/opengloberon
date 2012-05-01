MODULE WMGLDemo9; (** AUTHOR "fnecati"; PURPOSE "a demo using opengl Frame Buffer Object FBO and texture "; *)

IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Raster, Inputs,
	WM := WMWindowManager,  WMMessages, KernelLog, WMDialogs,
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, WMGL := WMGLWindow;

CONST
		waittime=20;
		renderBufferWidth = 256;
		renderBufferHeight = 256;
TYPE
	STRING = ARRAY 256 OF CHAR;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;


	Vector = ARRAY [*] OF REAL;
	Vertex = RECORD
		tu, tv: REAL;
    		x, y, z: REAL;
	END;
	VertexArray = POINTER TO ARRAY OF Vertex;

	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		 timer: Kernel.MilliTimer;

		alive, animated: BOOLEAN;
		eyeposz: LONGREAL;
		drawMode:LONGINT; (* fill, lines, points *)

		spinXL, spinYL, spinXR, spinYR : REAL;
		testTextureID, dynamicTextureID: GL.GLuint;
		frameBuffer, depthRenderBuffer: GL.GLuint;

	(*	cubeVertices: Vector; *)
		cubeVertices: VertexArray;

		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			Init(w, h, FALSE); (* use alpha, for 32bpp img *)
			WM.AddWindow(SELF, 100, 100);
			SetTitle(Strings.NewString("WMGLDemo9: FBO"));

			eyeposz := 1.0;
			drawMode := 0;
			animated := FALSE;
			alive := TRUE;
			InitContext;
		  END New;

		  PROCEDURE InitContext;
		  BEGIN
			context.MakeCurrent();
				GL.ReadExtensions;
				initGL;
			context.DeActivate();

			UpdateImage;
		END InitContext;

PROCEDURE NewVertex(u,v,x, y, z: REAL):Vertex;
VAR vert: Vertex;
BEGIN
	vert.tu := u; vert.tv := v;
	vert.x := x; vert.y := y; vert.z := z;
	RETURN vert;
END NewVertex;

PROCEDURE InitVertex;
BEGIN
(* cubeVertices :=
   [ 0.0,0.0, -1.0,-1.0, 1.0,
    1.0,0.0,  1.0,-1.0, 1.0,
    1.0,1.0,  1.0, 1.0, 1.0,
    0.0,1.0, -1.0, 1.0, 1.0,

    1.0,0.0, -1.0,-1.0,-1.0,
    1.0,1.0, -1.0, 1.0,-1.0,
    0.0,1.0,  1.0, 1.0,-1.0,
    0.0,0.0,  1.0,-1.0,-1.0,

    0.0,1.0, -1.0, 1.0,-1.0,
    0.0,0.0, -1.0, 1.0, 1.0,
    1.0,0.0,  1.0, 1.0, 1.0,
    1.0,1.0,  1.0, 1.0,-1.0,

    1.0,1.0, -1.0,-1.0,-1.0,
    0.0,1.0,  1.0,-1.0,-1.0,
    0.0,0.0,  1.0,-1.0, 1.0,
    1.0,0.0, -1.0,-1.0, 1.0,

    1.0,0.0,  1.0,-1.0,-1.0,
    1.0,1.0,  1.0, 1.0,-1.0,
    0.0,1.0,  1.0, 1.0, 1.0,
    0.0,0.0,  1.0,-1.0, 1.0,

    0.0,0.0, -1.0,-1.0,-1.0,
    1.0,0.0, -1.0,-1.0, 1.0,
    1.0,1.0, -1.0, 1.0, 1.0,
    0.0,1.0, -1.0, 1.0,-1.0];
*)
NEW(cubeVertices, 24);
cubeVertices[0]:=NewVertex( 0.0,0.0, -1.0,-1.0, 1.0);
cubeVertices[1]:=NewVertex( 1.0,0.0,  1.0,-1.0, 1.0);
cubeVertices[2]:=NewVertex(1.0,1.0,  1.0, 1.0, 1.0);
cubeVertices[3]:=NewVertex(0.0,1.0, -1.0, 1.0, 1.0);

cubeVertices[4]:=NewVertex( 1.0,0.0, -1.0,-1.0,-1.0);
cubeVertices[5]:=NewVertex( 1.0,1.0, -1.0, 1.0,-1.0);
cubeVertices[6]:=NewVertex( 0.0,1.0,  1.0, 1.0,-1.0);
cubeVertices[7]:=NewVertex(0.0,0.0,  1.0,-1.0,-1.0);

cubeVertices[8]:=NewVertex(0.0,1.0, -1.0, 1.0,-1.0);
cubeVertices[9]:=NewVertex( 0.0,0.0, -1.0, 1.0, 1.0);
cubeVertices[10]:=NewVertex(1.0,0.0,  1.0, 1.0, 1.0);
cubeVertices[11]:=NewVertex(1.0,1.0,  1.0, 1.0,-1.0);

cubeVertices[12]:=NewVertex(  1.0,1.0, -1.0,-1.0,-1.0);
cubeVertices[13]:=NewVertex(  0.0,1.0,  1.0,-1.0,-1.0);
cubeVertices[14]:=NewVertex( 0.0,0.0,  1.0,-1.0, 1.0);
cubeVertices[15]:=NewVertex( 1.0,0.0, -1.0,-1.0, 1.0);

cubeVertices[16]:=NewVertex(1.0,0.0,  1.0,-1.0,-1.0);
cubeVertices[17]:=NewVertex(1.0,1.0,  1.0, 1.0,-1.0);
cubeVertices[18]:=NewVertex(0.0,1.0,  1.0, 1.0, 1.0);
cubeVertices[19]:=NewVertex(0.0,0.0,  1.0,-1.0, 1.0);

cubeVertices[20]:=NewVertex( 0.0,0.0, -1.0,-1.0,-1.0);
cubeVertices[21]:=NewVertex( 1.0,0.0, -1.0,-1.0, 1.0);
cubeVertices[22]:=NewVertex(1.0,1.0, -1.0, 1.0, 1.0);
cubeVertices[23]:=NewVertex( 0.0,1.0, -1.0, 1.0,-1.0);

END InitVertex;

		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
		BEGIN
			IF  keysym = Inputs.KsLeft  THEN  spinXL := spinXL - 5.0;  GL.DelFCR(); UpdateImage; (* Cursor Left *)
			ELSIF keysym = Inputs.KsRight  THEN  spinXR := spinXR + 5.0; GL.DelFCR(); UpdateImage; (* Cursor Right *)
			ELSIF keysym = Inputs.KsDown THEN  spinYL := spinYL - 5.0; GL.DelFCR(); UpdateImage; (* Cursor Down *)
			ELSIF keysym = Inputs.KsUp THEN  spinYR := spinYR + 5.0; GL.DelFCR(); UpdateImage; (* Cursor Up *)
			ELSIF ucs = ORD("s") THEN SaveImage;
			ELSIF  ucs = ORD("q") THEN Close;
			ELSIF  ucs = ORD("a") THEN animated := ~ animated;
			ELSE
			END;
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
			eyeposz := eyeposz + dz;
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
			Shutdown;
			Close^;
			window := NIL;
		END Close;

		PROCEDURE UpdateImage;
		BEGIN
			context.MakeCurrent();
				displayCB();
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

		PROCEDURE Reshape(w, h: LONGINT);
		BEGIN
			context.MakeCurrent();
			GL.glViewport(0, 0, w, h);
			GL.glMatrixMode(GLC.GL_MODELVIEW);
			GL.glLoadIdentity();
			GL.SetFCR();
				GL.gluLookAt(5, 5, eyeposz,   0, 0, 0,   0, 1, 0); (* eye(x,y,z), focal(x,y,z), up(x,y,z) *)
			GL.DelFCR();
			  context.DeActivate();
		END Reshape;


PROCEDURE initGL();
VAR strstatus: STRING;
	status : GL.GLenum;
BEGIN
 	InitVertex;
 	spinXL := 30.0; spinYL := 30.0; spinXR := 0.0; spinYR := 0.0;
GL.SetFCR();
	GL.glClearColor( 0.0, 0.0, 1.0, 1.0 );
	GL.glEnable(GLC.GL_TEXTURE_2D);
	GL.glEnable(GLC.GL_DEPTH_TEST);

	GL.glMatrixMode( GLC.GL_PROJECTION );
	GL.glLoadIdentity();

	GL.gluPerspective( 45.0, 1.0, 1.0, 100.0 );
GL.DelFCR();


	(* Create a frame-buffer object and a render-buffer object...*)


	GL.glGenFramebuffersEXT( 1, SYSTEM.ADR(frameBuffer));
	GL.glGenRenderbuffersEXT( 1, SYSTEM.ADR(depthRenderBuffer));

	(* Initialize the render-buffer for usage as a depth buffer.
	 We don't really need this to render things into the frame-buffer object,
	 but without it the geometry will not be sorted properly. *)
	GL.glBindRenderbufferEXT( GLC.GL_RENDERBUFFER_EXT, depthRenderBuffer);
	GL.glRenderbufferStorageEXT( GLC.GL_RENDERBUFFER_EXT, GLC.GL_DEPTH_COMPONENT24, renderBufferWidth, renderBufferHeight );


	(* Check for errors...*)

	status := GL.glCheckFramebufferStatusEXT( GLC.GL_FRAMEBUFFER_EXT );
	IF status # GLC.GL_FRAMEBUFFER_COMPLETE_EXT THEN
		strstatus := FramebufferStatusToString(GL.glCheckFramebufferStatusEXT(GLC.GL_FRAMEBUFFER_EXT));
		KernelLog.String("framebuffer completeness: "); KernelLog.String(strstatus);  KernelLog.Ln;
		RETURN;
	END;

	(* Now, create our dynamic texture. It doesn't actually get loaded with any
	 pixel data, but its texture ID becomes associated with the pixel data
	 contained in the frame-buffer object. This allows us to bind to this data
	 like we would any regular texture.
	*)



	GL.glGenTextures( 1, SYSTEM.ADR(dynamicTextureID));

	GL.glBindTexture( GLC.GL_TEXTURE_2D, dynamicTextureID );

	GL.glTexImage2D( GLC.GL_TEXTURE_2D, 0, GLC.GL_RGBA8,
		          renderBufferWidth, renderBufferHeight,
		          0, GLC.GL_RGBA, GLC.GL_UNSIGNED_BYTE, 0 );

	GL.glTexParameteri( GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MAG_FILTER, GLC.GL_LINEAR );
	GL.glTexParameteri( GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MIN_FILTER, GLC.GL_LINEAR );

	(* Load a regular texture... *)


	loadTexture();

END initGL;

PROCEDURE loadTexture;
VAR teximg: Raster.Image;
BEGIN
 teximg := WMGraphics.LoadImage("WMIcons.tar://WMKernelLog.png", FALSE);
IF teximg # NIL THEN

	GL.glGenTextures( 1, SYSTEM.ADR(testTextureID) );
	GL.glBindTexture(GLC.GL_TEXTURE_2D, testTextureID);

	GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MAG_FILTER, GLC.GL_LINEAR);
	GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MIN_FILTER, GLC.GL_LINEAR);

	GL.glTexImage2D( GLC.GL_TEXTURE_2D, 0, GLC.GL_RGBA8, teximg.width, teximg.height, 0,
	GLC.GL_RGBA, GLC.GL_UNSIGNED_BYTE, teximg.adr );
ELSE
 	KernelLog.String("teximg= NIL"); KernelLog.Ln;
END;

teximg := NIL;
END loadTexture;

PROCEDURE Shutdown;
BEGIN
context.MakeCurrent();
   GL.glDeleteTextures( 1, SYSTEM.ADR(testTextureID) );
    GL.glDeleteTextures( 1, SYSTEM.ADR(dynamicTextureID) );

	GL.glDeleteFramebuffersEXT( 1, SYSTEM.ADR(frameBuffer) );
	GL.glDeleteRenderbuffersEXT( 1, SYSTEM.ADR(depthRenderBuffer) );
context.DeActivate;
END Shutdown;

PROCEDURE displayCB();
BEGIN
	(*
	 Bind the frame-buffer object and attach to it a render-buffer object
	 set up as a depth-buffer.
	*)

	GL.glBindFramebufferEXT( GLC.GL_FRAMEBUFFER_EXT, frameBuffer );
	(*glBindRenderbufferEXT( GLC.GL_RENDERBUFFER_EXT, depthRenderBuffer );*)
	GL.glFramebufferTexture2DEXT( GLC.GL_FRAMEBUFFER_EXT, GLC.GL_COLOR_ATTACHMENT0_EXT, GLC.GL_TEXTURE_2D, dynamicTextureID, 0 );
	GL.glFramebufferRenderbufferEXT( GLC.GL_FRAMEBUFFER_EXT, GLC.GL_DEPTH_ATTACHMENT_EXT, GLC.GL_RENDERBUFFER_EXT, depthRenderBuffer );

	(*
	 Set up the frame-buffer object just like you would set up a window.
	*)

	GL.glViewport( 0, 0, renderBufferWidth, renderBufferHeight );
	GL.glClearColor( 1.0, 0.0, 0.0, 1.0 );

	GL.glClear( GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT );

	(*
	 Let the user spin the cube about with the right mouse button, so our
	 dynamic texture will show motion.
	*)
GL.SetFCR();
	GL.glMatrixMode( GLC.GL_MODELVIEW );
	GL.glLoadIdentity();
	GL.glTranslatef( 0.0, 0.0, -5.0 );
	GL.glRotatef( spinYR, 1.0, 0.0, 0.0 );
	GL.glRotatef( spinXR, 0.0, 1.0, 0.0 );
GL.DelFCR();
	(*
	 Now, render the cube to the frame-buffer object just like you we would
	 have done with a regular window.
	*)

	GL.glBindTexture( GLC.GL_TEXTURE_2D, testTextureID );
	GL.glInterleavedArrays( GLC.GL_T2F_V3F, 0, SYSTEM.ADR(cubeVertices[0]) );
	GL.glDrawArrays( GLC.GL_QUADS, 0, 24 );


	(* Unbind the frame-buffer and render-buffer objects.*)


	GL.glBindFramebufferEXT( GLC.GL_FRAMEBUFFER_EXT, 0 );
	 GL.glBindRenderbufferEXT(GLC. GL_RENDERBUFFER_EXT, 0 );

	(* --------------------------------------------------------------------------
	 Now, set up the regular window for rendering...
	-------------------------------------------------------------------------- *)
GL.SetFCR();
	GL.glViewport( 0, 0, GetWidth(), GetHeight() );
	GL.glClearColor( 0.0, 0.0, 0.0, 1.0 );
	GL.glClear( GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT );

	(*Let the user spin the cube about with the left mouse button.*)
	GL.glMatrixMode( GLC.GL_MODELVIEW );
	GL.glLoadIdentity();
	GL.glTranslatef( 0.0, 0.0, -5.0 );
	GL.glRotatef( spinYL, 1.0, 0.0, 0.0 );
	GL.glRotatef( spinXL, 0.0, 1.0, 0.0 );
GL.DelFCR();

    (* Finally, we'll use the dynamic texture like a regular static texture.*)

	GL.glBindTexture( GLC.GL_TEXTURE_2D, dynamicTextureID );
	GL.glInterleavedArrays( GLC.GL_T2F_V3F, 0, SYSTEM.ADR(cubeVertices[0].tu));
	GL.glDrawArrays( GLC.GL_QUADS, 0, 24 );
END displayCB;


BEGIN  { ACTIVE }
	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN
			 IF Kernel.Expired(timer) THEN
			 	 UpdateImage();
			 	  spinXR := spinXR + 1.0; GL.DelFCR();
				Kernel.SetTimer(timer, waittime);
			END;
		END;
	END;

END GLWindow;

VAR
	window: GLWindow;

PROCEDURE FramebufferStatusToString(status: GL.GLenum): STRING;
VAR s: STRING;
BEGIN
	CASE status OF
	GLC.GL_FRAMEBUFFER_COMPLETE_EXT: s := "FRAMEBUFFER_COMPLETE_EXT:   8CD5H";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT: s :=  "FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT:  8CD6H";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT: s := "FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT:  8CD7H";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT: s := "FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT:  8CD9H";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT: s := "FRAMEBUFFER_INCOMPLETE_FORMATS_EXT:  8CDAH";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT: s := "FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT:   8CDBH";
	| GLC.GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT: s := "FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT:  8CDCH";
	| GLC.GL_FRAMEBUFFER_UNSUPPORTED_EXT: s := "FRAMEBUFFER_UNSUPPORTED_EXT:  8CDDH";
	ELSE
		s := "UNKNOWN STATUS";
	END;
    RETURN s;
END FramebufferStatusToString;


PROCEDURE Open*;
BEGIN
  IF window = NIL THEN
	NEW(window, 256, 256);
 END;
END Open;

BEGIN
END WMGLDemo9.

SystemTools.Free  WMGLDemo9  WMGLWindow ~ OpenGL OpenGLConst ~

WMGLDemo9.Open ~
