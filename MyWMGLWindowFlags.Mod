MODULE MyWMGLWindowFlags; (** AUTHOR "fnecati"; PURPOSE ""; *)
 (* Flags simulation 
  translation from HeNe lesson11a
 *)
IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Raster, Math,
	WM := WMWindowManager,  WMMessages, KernelLog, WMDialogs,
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, GLContext;

CONST 
		waittime=5;

TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	Points=ARRAY 45, 45, 3 OF GL.GLfloat;
	
	GLWindow* =  OBJECT(WM.BufferWindow)
	VAR
		 timer: Kernel.MilliTimer; 

		alive, animated: BOOLEAN;		
		context : GLContext.Context;
		width, height: LONGINT;

		xrot: GL.GLfloat;                 (* Rotate v about x *)
 		yrot: GL.GLfloat;                    (* Rotate v about y *)
 		zrot: GL.GLfloat;                    (* Rotate v about z *)
		texture, texture2:  GL.GLuint;  (*  handles for texture *)
		wigglecount, wigglecount2: LONGINT;        (* Rychlost vln*)
		hold: GL.GLfloat;                    (* Pomocnk zajilynulosti pohybu *)
		points, points2:  Points;  (* flag vertice points *)

					
		PROCEDURE &New(w, h: LONGINT);
		BEGIN
			width := w; height := h;
			Init(w, h, TRUE); (* use alpha, for 32bpp img *)
			manager := WM.GetDefaultManager();
			manager.Add(100, 100, SELF, {WM.FlagFrame, WM.FlagClose, WM.FlagNoResizing});
			SetTitle(Strings.NewString("MyGLWindow: Flags"));
			
			wigglecount := 0; wigglecount2 := 0;
			animated := FALSE;
			alive := TRUE;
			InitContext;
		  END New;
		  
		  PROCEDURE InitContext;
		  BEGIN

			NEW(context);
			context.Init(width, height, "MyGLWindow", FALSE);
			context.MakeCurrent();
				GL.ReadExtensions;
				initGL;
			context.DeActivate();
			Reshape();
			UpdateImage;			
		END InitContext;


		PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);	     
		BEGIN
			IF ucs = ORD("s") THEN SaveImage;
			ELSIF  ucs = ORD("q") THEN Close;
			ELSIF  ucs = ORD("a") THEN animated := ~ animated;
			ELSE
			END;
		END KeyEvent;

		PROCEDURE WheelMove*(dz : LONGINT);
		BEGIN
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


		PROCEDURE Close*;
		BEGIN
			alive := FALSE;	
			Close^;	
			Shutdown;			
			 context.Close;
			 context := NIL;
		END Close;

		PROCEDURE UpdateImage;		
		BEGIN {EXCLUSIVE}
			context.MakeCurrent();
				displayCB();
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

		PROCEDURE Reshape();
		BEGIN 
		  context.MakeCurrent();
		  GL.glViewport(0, 0, width, height);                        
		  (* Resetuje aktuastaven  *)
		  GL.glMatrixMode(GLC.GL_PROJECTION);     (* projection matrix *)
		  GL.glLoadIdentity();                                       (* Reset matrix *)
		  GL.gluPerspective(45.0, 1.0 ,0.1,100.0);           (*  perspective view *)
		  GL.glMatrixMode(GLC.GL_MODELVIEW);   (* model view matrix *)
		  GL.glLoadIdentity;        (* Reset matix *)
		  context.DeActivate();
		END Reshape;


PROCEDURE initGL();
VAR x, y: LONGINT;
BEGIN 
loadTextures;
  GL.glEnable(GLC.GL_TEXTURE_2D);                          (* Zapne mapov textur*)
  GL.glShadeModel(GLC.GL_SMOOTH);			                    (* Povolemntv*)
  GL.glClearColor(0.0, 0.0, 0.0, 0.5);	  	            (* rnozad  *)
  GL.glClearDepth(1.0);				                        (* Nastavenloubkov bufferu*)
  GL.glEnable(GLC.GL_DEPTH_TEST);			                    (* Povolloubkovestov*)
  GL.glDepthFunc(GLC.GL_LEQUAL);				                    (* Typ hloubkov testov *)
  GL.glHint(GLC.GL_PERSPECTIVE_CORRECTION_HINT, GLC.GL_NICEST); (* Nejleppektivnorekce *)
  GL.glPolygonMode(GLC.GL_BACK, GLC.GL_FILL);                  (* P strana vypln polygony *)
  (*GL.glPolygonMode(GLC.GL_FRONT, GLC.GL_LINE);*)                 (* Zadntrana vypln mu *)
  GL.glPolygonMode(GLC.GL_FRONT, GLC.GL_FILL);
  FOR x:=0 TO 44 DO                                 (* initialize vertices *)
    FOR y:=0 TO 44 DO
      points[x,y,0] := x/5 - 4.5;
      points[x,y,1] := y/5 - 4.5;
      points[x,y,2] := Math.sin((((x/5)*40)/360)*2*Math.pi);
     END;
   END;  

  FOR x:=0 TO 44 DO                                 (* initialize vertices *)
    FOR y:=0 TO 44 DO
      points2[x,y,0] := x/5 - 1.5;
      points2[x,y,1] := y/5 - 1.5;
      points2[x,y,2] := Math.sin((((x/5)*40)/360)*2*Math.pi);
     END;
   END;  

END initGL;

PROCEDURE loadTextures;
VAR teximg: Raster.Image;
	
BEGIN
	teximg := WMGraphics.LoadImage("europe.bmp", FALSE);
    GL.glGenTextures(1, SYSTEM.ADR(texture));  
    GL.glBindTexture(GLC.GL_TEXTURE_2D, texture);
    GL.glTexImage2D(GLC.GL_TEXTURE_2D, 0, GLC.GL_RGBA, teximg.width, teximg.height, 0, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, teximg.adr);
    GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MAG_FILTER, GLC.GL_LINEAR);   
    GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MIN_FILTER, GLC.GL_LINEAR);
    teximg := NIL;

	teximg := WMGraphics.LoadImage("turkiye.bmp", FALSE);
    GL.glGenTextures(1, SYSTEM.ADR(texture2));  
    GL.glBindTexture(GLC.GL_TEXTURE_2D, texture2);
    GL.glTexImage2D(GLC.GL_TEXTURE_2D, 0, GLC.GL_RGBA, teximg.width, teximg.height, 0, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, teximg.adr);
    GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MAG_FILTER, GLC.GL_LINEAR);   
    GL.glTexParameteri(GLC.GL_TEXTURE_2D, GLC.GL_TEXTURE_MIN_FILTER, GLC.GL_LINEAR);
    teximg := NIL;
    
END loadTextures;

PROCEDURE Shutdown;
BEGIN
END Shutdown;



PROCEDURE displayEurope;
VAR
  x, y: LONGINT;                                         
  float_x, float_y, float_xb, float_yb: GL.GLfloat;           
 BEGIN  
  GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT);  (* Smazovku a hloubkover *)
 GL.SetFCR();
  GL.glLoadIdentity();	                                    (* Reset matix *)
  GL.glTranslatef(0.0,0.0,-12.0);                          (* Posunuto obrazovky *)
  GL.glRotatef(xrot,1.0,0.0,0.0);                          (* Rotace na ose x *)
  GL.glRotatef(yrot,0.0,1.0,0.0);                          (* Rotace na ose y *)
  GL.glRotatef(zrot,0.0,0.0,1.0);                          (* Rotace na ose z *)
 GL.DelFCR(); 
 
  GL.glBindTexture(GLC.GL_TEXTURE_2D, texture);              (* Vextury *)
  GL.glBegin(GLC.GL_QUADS);                                    (* Zaek kreslentverc  *)
  FOR x:=0 TO 43 DO                                   (* Cykly prochjole *)
     FOR y:=0 TO 43 DO
        float_x := x/44;                                (* Vypo texturovordin *)
        float_y := y/44;
        float_xb := (x+1)/44;
        float_yb := (y+1)/44;
        GL.glTexCoord2f(float_x, float_y);                  (* Zad jednotlivd  *)
         GL.glVertex3f(points[x,y,0], points[x,y,1], points[x,y,2]);
        GL.glTexCoord2f(float_x, float_yb);
        GL.glVertex3f(points[x,y+1,0], points[x,y+1,1], points[x,y+1,2]);
        GL.glTexCoord2f(float_xb, float_yb);
        GL.glVertex3f(points[x+1, y+1,0], points[x+1,y+1,1], points[x+1,y+1,2]);
        GL.glTexCoord2f(float_xb, float_y);
        GL.glVertex3f(points[x+1,y,0], points[x+1,y,1], points[x+1,y,2]);
        END;
    END;    
  GL.glEnd();                                              (* Konec kreslentverc *)
  
  IF wigglecount = 2 THEN                             (* Pro snnychlosti pohybu *)

    FOR y:=0 TO 44 DO                                   (* Proch hodnoty na y *)
    	  hold := points[0,y,2];                            (* Ulo vlny *)
    	  FOR x:=0 TO 43 DO points[x,y,2] := points[x+1,y,2]; END; (* Peno sousedn prvku *)
        points[44,y,2] := hold;                           (* Uloaj bude na druhtran *)
     END;;
    wigglecount := 0;                                  (* Nulov poadla vykreslov *)

    ELSE wigglecount := wigglecount + 1;              (* Inkrementace poadla *)
  END;  
END displayEurope;

PROCEDURE displayTurkiye();
VAR
  x, y: LONGINT;                                         
  float_x, float_y, float_xb, float_yb: GL.GLfloat;
         
 BEGIN  
 GL.SetFCR();
  GL.glLoadIdentity();	                                    (* Reset matix *)
  GL.glTranslatef(2.0,0.0,-22.0);                          (* Posunuto obrazovky *)
  GL.glRotatef(xrot,1.0,0.0,0.0);                          (* Rotace na ose x *)
  GL.glRotatef(yrot,0.0,1.0,0.0);                          (* Rotace na ose y *)
  GL.glRotatef(zrot,0.0,0.0,1.0);                          (* Rotace na ose z *)
 GL.DelFCR(); 
 
  GL.glBindTexture(GLC.GL_TEXTURE_2D, texture2);              (* Vextury *)
  GL.glBegin(GLC.GL_QUADS);                                    (* Zaek kreslentverc  *)
  FOR x:=0 TO 43 DO                                   (* Cykly prochjole *)
     FOR y:=0 TO 43 DO
        float_x := x/44;                                (* Vypo texturovordin *)
        float_y := y/44;
        float_xb := (x+1)/44;
        float_yb := (y+1)/44;
        GL.glTexCoord2f(float_x, float_y);                  (* Zad jednotlivd  *)
         GL.glVertex3f(points2[x,y,0], points2[x,y,1], points2[x,y,2]);
        GL.glTexCoord2f(float_x, float_yb);
        GL.glVertex3f(points2[x,y+1,0], points2[x,y+1,1], points2[x,y+1,2]);
        GL.glTexCoord2f(float_xb, float_yb);
        GL.glVertex3f(points2[x+1, y+1,0], points2[x+1,y+1,1], points2[x+1,y+1,2]);
        GL.glTexCoord2f(float_xb, float_y);
        GL.glVertex3f(points2[x+1,y,0], points2[x+1,y,1], points2[x+1,y,2]);
        END;
    END;    
  GL.glEnd();                                              (* Konec kreslentverc *)
  
  IF wigglecount2 = 2 THEN                             (* Pro snnychlosti pohybu *)

    FOR y:=0 TO 44 DO                                   (* Proch hodnoty na y *)
    	  hold := points2[0,y,2];                            (* Ulo vlny *)
    	  FOR x:=0 TO 43 DO points2[x,y,2] := points2[x+1,y,2]; END; (* Peno sousedn prvku *)
        points2[44,y,2] := hold;                           (* Uloaj bude na druhtran *)
     END;;
    wigglecount2 := 0;                                  (* Nulov poadla vykreslov *)

    ELSE wigglecount2 := wigglecount2 + 1;              (* Inkrementace poadla *)
  END;  

END displayTurkiye;

PROCEDURE displayCB();
BEGIN
	displayEurope;
	  xrot := xrot + 0.3;
	  yrot := yrot + 0.2;
	  zrot := zrot + 0.4;
	  
	displayTurkiye;	
END displayCB;

BEGIN  { ACTIVE } 
	Kernel.SetTimer(timer, waittime);
	WHILE alive DO
		IF animated THEN			 
			 IF Kernel.Expired(timer) THEN  
			 	 UpdateImage();
				Kernel.SetTimer(timer, waittime);
			END;	
		END;
	END;	

END GLWindow;

PROCEDURE Open*;
VAR 
	window: GLWindow;
BEGIN
	NEW(window, 400, 400) ;
END Open;

BEGIN
END MyWMGLWindowFlags.

SystemTools.Free  MyWMGLWindowFlags  GLContext ~OpenGL OpenGLConst ~

MyWMGLWindowFlags.Open  ~
