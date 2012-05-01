MODULE WMGLWindow; (** AUTHOR "fnecati"; PURPOSE "an OpenGL Context enabled WM.Window using GLXPixmap for LinuxAos"; *)

IMPORT
	Kernel32, User32, KernelLog, WinApi, GL:=OpenGL, GLC := OpenGLConst, Raster,
	WM := WMWindowManager,  SYSTEM, Strings;

CONST
	debug = FALSE;
	debugevent = FALSE;

CONST
	opDoubleBuffered = 0;
	opStereo = 1;

TYPE
	WindowStruct*= POINTER TO RECORD
		windowClassName, title*: ARRAY 32 OF CHAR;
		Instance: Kernel32.HMODULE;
		hWind*: WinApi.HWND;   (* handle of this window *)
		hDC*: WinApi.HDC; (* drawing context of this window*)
		hGLRC* : WinApi.HGLRC; (* GL render context handles for this window *)
		width*, height*: LONGINT; (* size of window *)
		doublebuffer*: BOOLEAN;

	END;

	Buffer = POINTER TO ARRAY OF CHAR;


TYPE
	Context*= OBJECT
	VAR
		winGL* : WindowStruct;
		wincreated*: BOOLEAN;
		initialized: BOOLEAN;
		res: BOOLEAN;
		buffer: Buffer;	(* for speedup flip image in y*)
		mode: Raster.Mode;

    	PROCEDURE Init*(w, h: LONGINT);
    	BEGIN  {EXCLUSIVE}
    		wincreated := FALSE;
		initialized := FALSE;
    		NEW(winGL);
    		winGL.doublebuffer := TRUE;
    		winGL.width := w; winGL.height := h;

    		winGL.title:="GLContext.Window";
		(* Resize(w, h); *)
    		NEW(buffer, w*h*4);
		Raster.InitMode(mode, Raster.srcCopy);
    		initialized := TRUE;
		AWAIT (wincreated);
    	END Init;

	PROCEDURE Close*;
	VAR res: LONGINT;
	BEGIN {EXCLUSIVE}
		 wincreated := FALSE;
		 res := User32.SendMessage(winGL.hWind, User32.WMClose, 0, 0);

		IF debug THEN KernelLog.String("Close SendMessage res = "); KernelLog.Int(res, 0); KernelLog.Ln; END;

	END Close;

	PROCEDURE MakeCurrent*();
	BEGIN
		res := GL.wglMakeCurrent(winGL.hDC, winGL.hGLRC);
		IF debug THEN KernelLog.String("ctx MakeCurrent res= "); KernelLog.Boolean(res); KernelLog.Ln; END;
	END MakeCurrent;

	PROCEDURE DeActivate*;
	BEGIN
		res := GL.wglMakeCurrent(0, 0);
		IF debug THEN KernelLog.String("ctx DeActivate res= "); KernelLog.Boolean(res); KernelLog.Ln; END;
	END DeActivate;

	PROCEDURE SwapBuffers*;
	VAR res: WinApi.BOOL;
	BEGIN {EXCLUSIVE}
		IF winGL.doublebuffer THEN
		 	res := WinApi.SwapBuffers(winGL.hDC);
		ELSE
	 	 	GL.glFlush();
		END;
	END SwapBuffers;

		(** move the window to x,y and  resize width,height *)
	PROCEDURE MoveResizeWindow*(x, y, w, h: LONGINT);
	BEGIN
		User32.MoveWindow(winGL.hWind, x, y, w, h, 1); (* repaint *)
	END MoveResizeWindow;

	PROCEDURE Resize*(w, h: LONGINT);
	BEGIN
		buffer := NIL;
		NEW(buffer, w*h*4);
		MoveResizeWindow(0,0, w, h);
	END Resize;

	PROCEDURE RenderInto*(image: Raster.Image);
	VAR
		i: LONGINT;
		w, h: LONGINT;
	BEGIN {EXCLUSIVE}
			w := image.width; h := image.height;
			GL.glReadPixels(0, 0, w, h, GLC.GL_BGRA, GLC.GL_UNSIGNED_BYTE, SYSTEM.ADR(buffer^[0]));
			(* flip vertical, y *)
			FOR i := 0 TO h - 1 DO
				Raster.PutPixels(image, 0, h-1-i, w, Raster.BGRA8888, buffer^, i * w * 4, mode)
			END;
	END RenderInto;

	PROCEDURE MyLoop;
	VAR
		 res: Kernel32.BOOL;
		  msg: User32.Msg;
	BEGIN
		BEGIN {EXCLUSIVE} AWAIT (initialized); END;
		wincreated := CreateHWND( winGL);
		IF ~wincreated THEN CloseWindow(winGL); RETURN; END;

	(*	GL.ReadOpenGLCore();*)

		BEGIN {EXCLUSIVE} AWAIT (wincreated);   END;
		IF debug THEN  KernelLog.String("entering messageLoop"); KernelLog.Ln; END;
		LOOP

			(* Check for new window messages *)
			WHILE User32.GetMessage(msg, 0, 0, 0) # 0 DO
				IF msg.message=User32.WMQuit THEN
						(* QUIT-message (from close window) *)
						IF debugevent THEN KernelLog.String("MainLoop: Got WMQuit message"); KernelLog.Ln; END;

				ELSE
					res := User32.DispatchMessage(msg);
				END;
				Kernel32.Sleep( 1 );
			END;

			 IF ~wincreated THEN
			 		IF debug THEN KernelLog.String("message loop exiting"); KernelLog.Ln; END;
			  	EXIT;
			  END;
		END;
		BEGIN {EXCLUSIVE} AWAIT(~wincreated) END;
		CloseWindow(winGL);
		winGL := NIL;
		IF debug THEN KernelLog.String( "Display: closed" ); KernelLog.Ln; END;
	END MyLoop;

BEGIN {ACTIVE}
			MyLoop;
END Context;

TYPE
	Window* =  OBJECT(WM.DoubleBufferWindow)
	VAR
		context* : Context;

		PROCEDURE &Init(w, h: LONGINT; alpha: BOOLEAN);
		BEGIN
			Init^(w, h, alpha); (* use alpha, for 32bpp img *)
			NEW(context);
			context.Init(w, h);
		END Init;

		(** *)
		PROCEDURE Close*();
		BEGIN
			context.Close();
			context := NIL;
			Close^;
		END Close;

		PROCEDURE Reshape*(w,h: LONGINT);
		BEGIN
		END Reshape;

		PROCEDURE UpdateImage*();
		BEGIN

		END UpdateImage;

		PROCEDURE Resized(w, h: LONGINT);
		BEGIN
			context.Resize(w, h);
			ReInit(w, h);
			Reshape(w, h);
			UpdateImage;
		END Resized;

	END Window;

VAR
	ctxtcounter: LONGINT;

    PROCEDURE CreateHWND(VAR glWin:WindowStruct): BOOLEAN;
		VAR res: Kernel32.BOOL;
			 dwStyle: SET;
			 dwExStyle: LONGINT;
			 windowClass: User32.WndClassEx;
			 bres: BOOLEAN;
			 scnt: ARRAY 16 OF CHAR;
       BEGIN

		glWin.Instance := Kernel32.GetModuleHandle( NIL );

		(* to create multiple GLContext with different window, change class name by appending and increasing counter value  *)
		INC(ctxtcounter); Strings.IntToStr(ctxtcounter, scnt);
		glWin.windowClassName := "WinAos.GLWindow";
		Strings.Append(glWin.windowClassName, scnt);
		IF debug THEN KernelLog.String("glWin.windowClassName= "); KernelLog.String(glWin.windowClassName); KernelLog.Ln; END;

		windowClass.cbSize := SYSTEM.SIZEOF( User32.WndClassEx );
		windowClass.style := WinApi.CS_OWNDC + WinApi.CS_VREDRAW + WinApi.CS_HREDRAW;
		windowClass.lpfnWndProc := WindowProc; (* Message handler *)
		windowClass.cbClsExtra := 0;
		windowClass.cbWndExtra := 0;
		windowClass.hInstance := glWin.Instance;
		windowClass.hIcon := Kernel32.NULL;
		windowClass.hIconSm := Kernel32.NULL;
		windowClass.hCursor := Kernel32.NULL;
		windowClass.hbrBackground := Kernel32.NULL;
		windowClass.lpszMenuName := Kernel32.NULL;
		windowClass.lpszClassName := SYSTEM.VAL( Kernel32.LPSTR, SYSTEM.ADR( glWin.windowClassName ) );

		(* register window class *)
		res := User32.RegisterClassEx( windowClass );
		IF res = 0 THEN
			IF debug THEN
				KernelLog.String("RegisterClassEx res= "); KernelLog.Int(res, 0); KernelLog.Ln;
				KernelLog.String("ERROR: "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
			END;
			RETURN FALSE;
		END;

		dwExStyle :=0;
		dwStyle := WinApi.WS_POPUP +  WinApi.WS_CLIPSIBLINGS + WinApi.WS_CLIPCHILDREN;

		 (* create the window *)
		glWin.hWind := User32.CreateWindowEx(dwExStyle , glWin.windowClassName, glWin.title, dwStyle , 10, 10, glWin.width, glWin.height, 0, 0,  glWin.Instance, 0);
		IF glWin.hWind = 0 THEN
			IF debug THEN
				KernelLog.String("CreateWindowEx hWind= "); KernelLog.Int(glWin.hWind, 0); KernelLog.Ln;
				KernelLog.String("ERROR: CreateWindowEx: "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
			END;
			RETURN FALSE;
		END;

		res := User32.UpdateWindow(glWin.hWind);

		(* get drawing context for this window *)
		glWin.hDC := User32.GetDC(glWin.hWind);

		IF glWin.hDC = 0 THEN
			IF debug THEN
				KernelLog.String("hDC= "); KernelLog.Int(glWin.hDC, 0); KernelLog.Ln;
				KernelLog.String("ERROR: GetDC: "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
			END;
			RETURN FALSE;
		END;

		(* create GL context for this window *)
		bres := CreateGLRC(glWin, {opDoubleBuffered}, 24, 8, 8, 8,0,0);
		RETURN bres;
	END CreateHWND;

	PROCEDURE CloseWindow(VAR glWin: WindowStruct);
	VAR res: Kernel32.BOOL;
		bres : BOOLEAN;
	BEGIN {EXCLUSIVE}

	   (* do we have a rendering context *)
    IF  glWin.hGLRC # 0 THEN
        (* Release the DC and RC contexts *)
        GL.wglMakeCurrent(0, 0 );

        (* Delete the rendering context *)

        bres := GL.wglDeleteContext( glWin.hGLRC );

        glWin.hGLRC := 0;
         IF debug THEN KernelLog.String("delete glcontext .."); KernelLog.Ln; END;
    END;

    (* Do we have a device context *)
    IF glWin.hDC # 0 THEN

        (* Release the device context *)
        res := User32.ReleaseDC(glWin.hWind, glWin.hDC);
        glWin.hDC := 0;
      IF debug THEN KernelLog.String("release hdc .."); KernelLog.Ln; END;
    END;

    (* Do we have a window *)
    IF glWin.hWind # 0 THEN
        (* Destroy the window *)
		res := User32.DestroyWindow(glWin.hWind );
		glWin.hWind := Kernel32.NULL;
        IF debug THEN KernelLog.String("destroy window .."); KernelLog.Ln; END;
   END;

    (* Do we have an instance? *)
    IF  glWin.Instance # 0 THEN
        (* Unregister class *)
        res := User32.UnregisterClass( glWin.windowClassName, glWin.Instance );
        glWin.Instance := Kernel32.NULL;
        IF debug THEN KernelLog.String("unregister class .."); KernelLog.Ln; END;
    END;

	IF debugevent THEN KernelLog.String("CloseWindow Ok."); KernelLog.Ln; END;
	END CloseWindow;

PROCEDURE CreateGLRC(VAR glWin: WindowStruct; Options: SET; colorbits, depthbits, stencilbits, accumbits, auxbuffers: LONGINT; layer: LONGINT): BOOLEAN;

VAR
  pfd: WinApi.PIXELFORMATDESCRIPTOR;
  pixelformat : LONGINT;
  res: LONGINT;

BEGIN

    pfd.nSize := SYSTEM.SIZEOF(WinApi.PIXELFORMATDESCRIPTOR);
    pfd.nVersion := 1;
    pfd.dwFlags := WinApi.PFD_SUPPORT_OPENGL + WinApi.PFD_DRAW_TO_WINDOW + WinApi.PFD_DOUBLEBUFFER;

   IF opStereo IN Options THEN
      pfd.dwFlags := pfd.dwFlags + WinApi.PFD_STEREO;
   END;

    pfd.iPixelType := CHR(WinApi.PFD_TYPE_RGBA);
    pfd.cColorBits := CHR(colorbits);
    pfd.cDepthBits := CHR(depthbits);
    pfd.cStencilBits := CHR(stencilbits);
    pfd.cAccumBits := CHR(accumbits);
    pfd.cAuxBuffers := CHR(auxbuffers);

	IF layer = 0 THEN
		pfd.iLayerType := CHR(WinApi.PFD_MAIN_PLANE);
	ELSIF layer > 0 THEN
		pfd.iLayerType := CHR(WinApi.PFD_OVERLAY_PLANE);
	ELSE
		pfd.iLayerType := CHR(WinApi.PFD_UNDERLAY_PLANE);
	END;

	pixelformat := WinApi.ChoosePixelFormat(glWin.hDC, SYSTEM.ADR(pfd));
	IF pixelformat = 0 THEN
		IF debug THEN
			KernelLog.String("pixelformat= "); KernelLog.Int(pixelformat, 0); KernelLog.Ln;
			KernelLog.String(" ERROR: Choosepixelformat Kernel32.GetLastError()= "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
		END;
		RETURN FALSE;
	END;
  (*    ASSERT(pixelformat # 0, 201); *)

	res := WinApi.DescribePixelFormat(glWin.hDC, pixelformat, SYSTEM.SIZEOF(WinApi.PIXELFORMATDESCRIPTOR), SYSTEM.ADR(pfd));
	IF res = 0 THEN
		IF debug THEN
			KernelLog.String("ERROR: Describepixelformat Kernel32.GetLastError()= "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
		END;
   		RETURN FALSE;
   	END;

	res := WinApi.SetPixelFormat(glWin.hDC, pixelformat, SYSTEM.ADR(pfd));
	IF res =0 THEN
		IF debug THEN
			KernelLog.String("ERROR: SetpixelFormat: "); KernelLog.Int(Kernel32.GetLastError(), 0); KernelLog.Ln;
		END;
		RETURN FALSE;
	END;
  	(* ASSERT(res # 0, 202); *)

	glWin.hGLRC := GL.wglCreateContext(glWin.hDC);

  RETURN (glWin.hGLRC # 0)

END CreateGLRC;

PROCEDURE {WINAPI} WindowProc( wnd: User32.HWND;  uMsg: LONGINT;  wParam: User32.WParam;
															    lParam: User32.LParam ): User32.LResult;
VAR res: LONGINT;
BEGIN
	CASE uMsg OF

	User32.WMActivate: (* Window activate message? (iconification) *)
		res := User32.ShowWindow(wnd, User32.SWShow );
		(* Did we receive a close message *)
		|  User32.WMClose: User32.PostQuitMessage(0);
			  IF debugevent THEN  KernelLog.String("WindowProc: Got WMClose message"); KernelLog.Ln; END;
			  RETURN 0;

		| User32.WMSize:
				RETURN User32.DefWindowProc(wnd, uMsg, wParam, lParam)
	ELSE
	END;
  RETURN User32.DefWindowProc(wnd, uMsg, wParam, lParam)
END WindowProc;


BEGIN
ctxtcounter := 0;
END WMGLWindow.

SystemTools.Free WMGLWindow ~

SystemTools.FreeDownTo OpenGL ~ 