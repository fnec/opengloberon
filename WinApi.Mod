MODULE WinApi; (** AUTHOR "fnecati"; PURPOSE "missing WinApi functions"; *)

IMPORT
	 S:=SYSTEM, Kernel32, User32, GDI32;

CONST
		NULL* = Kernel32.NULL;


	 (** CreateWindow dwStyle values *)
		WS_OVERLAPPED* = {};
		WS_POPUP* = {31};
		WS_CHILD* = {30};
		WS_MINIMIZE* = {29};
		WS_VISIBLE* = {28};
		WS_DISABLED* = {27};
		WS_CLIPSIBLINGS* = {26};
		WS_CLIPCHILDREN* = {25};
		WS_MAXIMIZE* = {24};
		WS_CAPTION* = {22, 23};
		WS_BORDER* = {23};
		WS_DLGFRAME* = {22};
		WS_VSCROLL* = {21};
		WS_HSCROLL* = {20};
		WS_SYSMENU* = {19};
		WS_THICKFRAME* = {18};
		WS_GROUP* = {17};
		WS_TABSTOP* = {16};
		WS_MINIMIZEBOX* = {17};
		WS_MAXIMIZEBOX* = {16};
		WS_TILED* = {};
		WS_ICONIC* = {29};
		WS_SIZEBOX* = {18};
		WS_TILEDWINDOW* = {16..19, 22, 23};
		WS_OVERLAPPEDWINDOW* = {16..19, 22, 23};
		WS_POPUPWINDOW* = {19, 23, 31};
		WS_CHILDWINDOW* = {30};
		
		(** CreateWindow dwExStyle values *)
		WS_EX_DLGMODALFRAME* = {0};
		WS_EX_NOPARENTNOTIFY* = {2};
		WS_EX_TOPMOST* = {3};
		WS_EX_ACCEPTFILES* = {4};
		WS_EX_TRANSPARENT* = {5};
		WS_EX_MDICHILD* = {6};
		WS_EX_TOOLWINDOW* = {7};
		WS_EX_WINDOWEDGE* = {8};
		WS_EX_CLIENTEDGE* = {9};
		WS_EX_CONTEXTHELP* = {10};
		WS_EX_RIGHT* = {12};
		WS_EX_LEFT* = {};
		WS_EX_RTLREADING* = {13};
		WS_EX_LTRREADING* = {};
		WS_EX_LEFTSCROLLBAR* = {14};
		WS_EX_RIGHTSCROLLBAR* = {};
		WS_EX_CONTROLPARENT* = {16};
		WS_EX_STATICEDGE* = {17};
		WS_EX_APPWINDOW* = {18};
		WS_EX_OVERLAPPEDWINDOW* = {8, 9};
		WS_EX_PALETTEWINDOW* = {3, 7, 8};
		
		(** window Class styles*)
		CS_VREDRAW* = {0};
		CS_HREDRAW* = {1};
		CS_KEYCVTWINDOW* = {2};
		CS_DBLCLKS* = {3};
		CS_OWNDC* = {5};
		CS_CLASSDC* = {6};
		CS_PARENTDC* = {7};
		CS_NOKEYCVT* = {8};
		CS_NOCLOSE* = {9};
		CS_SAVEBITS* = {11};
		CS_BYTEALIGNCLIENT* = {12};
		CS_BYTEALIGNWINDOW* = {13};
		CS_GLOBALCLASS* = {14};
		CS_IME* = {16};
		

		(* pixel format description values *)		
		PFD_TYPE_RGBA* = 0 (* {} *);
		PFD_TYPE_COLORINDEX* = 1 (* {0} *);
		PFD_MAIN_PLANE* = 0 (* {} *);
		PFD_OVERLAY_PLANE* = 1 (* {0} *);
		PFD_UNDERLAY_PLANE* = -1 (* {0..31} *);
		PFD_DOUBLEBUFFER* = {0};
		PFD_STEREO* = {1};
		PFD_DRAW_TO_WINDOW* = {2};
		PFD_DRAW_TO_BITMAP* = {3};
		PFD_SUPPORT_GDI* = {4};
		PFD_SUPPORT_OPENGL* = {5};
		PFD_GENERIC_FORMAT* = {6};
		PFD_NEED_PALETTE* = {7};
		PFD_NEED_SYSTEM_PALETTE* = {8};
		PFD_SWAP_EXCHANGE* = {9};
		PFD_SWAP_COPY* = {10};
		PFD_SWAP_LAYER_BUFFERS* = {11};
		PFD_DOUBLEBUFFER_DONTCARE* = {30};
		PFD_STEREO_DONTCARE* = {31};

		(* HDC Types *)
		OBJ_BITMAP* = 7 (* {0..2} *);
		OBJ_MEMDC* = 10;
		OBJ_ENHMETADC* = 12;
		OBJ_METADC* = 4;
		
		DIB_RGB_COLORS* = 0 (* {} *);
		DIB_PAL_COLORS* = 1 (* {0} *);

		BIRGB* = GDI32.BIRGB;
		
  TYPE
	
		ADDRESS* = LONGINT;
		HANDLE* = Kernel32.HANDLE;
		HDC* = HANDLE;
		HGLRC* = HANDLE;
		HPALETTE* = HANDLE;
		HGDIOBJ* = HANDLE;
		BOOL* = Kernel32.BOOL;
		HWND* = HANDLE;
		HBITMAP* = HANDLE;
		WORD* = INTEGER;
		DWORD* = LONGINT;
		
		RGBQUAD* = RECORD
			rgbBlur*, rgbGreen*, rgbRed*, rgbReserved*: CHAR;
		END;	

		PALETTEENTRY* = RECORD
			peRed*: CHAR;
			peGreen*: CHAR;
			peBlue*: CHAR;
			peFlags*: CHAR;
		END;
		PtrPALETTEENTRY* = POINTER TO PALETTEENTRY;
		
		LOGPALETTE* = RECORD 
			palVersion*: INTEGER;
			palNumEntries*: INTEGER;
			palPalEntry*: ARRAY 1 OF PALETTEENTRY;
		END;
		PtrLOGPALETTE* = POINTER TO LOGPALETTE;

		BITMAP* = RECORD 
			bmType*: LONGINT;
			bmWidth*: LONGINT;
			bmHeight*: LONGINT;
			bmWidthBytes*: LONGINT;
			bmPlanes*: INTEGER;
			bmBitsPixel*: INTEGER;
			bmBits*: LONGINT;
		END;
		
		BITMAPINFOHEADER* = RECORD
			biSize*: LONGINT;
			biWidth*: LONGINT;
			biHeight*: LONGINT;
			biPlanes*: INTEGER;
			biBitCount*: INTEGER;
			biCompression*: LONGINT;
			biSizeImage*: LONGINT;
			biXPelsPerMeter*: LONGINT;
			biYPelsPerMeter*: LONGINT;
			biClrUsed*: LONGINT;
			biClrImportant*: LONGINT;
		END;
			
		BITMAPINFO* = RECORD 
			bmiHeader*: BITMAPINFOHEADER;
			bmiColors*: ARRAY 1 OF RGBQUAD;
		END;


	PIXELFORMATDESCRIPTOR* = RECORD
		nSize*: INTEGER;
		nVersion*: INTEGER;
		dwFlags*: SET;
		iPixelType*: CHAR;
		cColorBits*: CHAR;
		cRedBits*: CHAR;
		cRedShift*: CHAR;
		cGreenBits*: CHAR;
		cGreenShift*: CHAR;
		cBlueBits*: CHAR;
		cBlueShift*: CHAR;
		cAlphaBits*: CHAR;
		cAlphaShift*: CHAR;
		cAccumBits*: CHAR;
		cAccumRedBits*: CHAR;
		cAccumGreenBits*: CHAR;
		cAccumBlueBits*: CHAR;
		cAccumAlphaBits*: CHAR;
		cDepthBits*: CHAR;
		cStencilBits*: CHAR;
		cAuxBuffers*: CHAR;
		iLayerType*: CHAR;
		bReserved*: CHAR;
		dwLayerMask*: SET;
		dwVisibleMask*: SET;
		dwDamageMask*: SET;
	END;
		

VAR

	(* GDI32.dll *)
	CreateDIBSection- : PROCEDURE { WINAPI }  (p0: HDC;   p1: ADDRESS (*BITMAPINFO*); p2: LONGINT;  p3: ADDRESS; p4: HANDLE; p5: LONGINT): HBITMAP;
	CreatePalette-: PROCEDURE { WINAPI } ( p0: ADDRESS (*LOGPALETTE*)): HPALETTE;
	GetCurrentObject-: PROCEDURE { WINAPI } (p0: HDC; p1: LONGINT): HGDIOBJ;
	GetObject-: PROCEDURE { WINAPI }  (p0: HGDIOBJ; p1: LONGINT; p2: ADDRESS): LONGINT;
	GetObjectType-: PROCEDURE  { WINAPI } (h: HGDIOBJ): LONGINT;
	RealizePalette- : PROCEDURE  { WINAPI } (p0: HDC): LONGINT;
	SelectPalette-: PROCEDURE { WINAPI } (p0: HDC; p1: HPALETTE; p2: BOOL): HPALETTE;
	ChoosePixelFormat- :PROCEDURE  { WINAPI } (p0: HDC;   p1: ADDRESS (*PIXELFORMATDESCRIPTOR*)): LONGINT;
 	DescribePixelFormat-: PROCEDURE { WINAPI } (p0: HDC; p1: LONGINT; p2: LONGINT;  p3: ADDRESS(*PIXELFORMATDESCRIPTOR*)): LONGINT;
	GetPixelFormat-: PROCEDURE { WINAPI } (p0: HDC): LONGINT;
	SetPixelFormat- : PROCEDURE { WINAPI }  (p0: HDC; p1: LONGINT;  p2: ADDRESS (*PIXELFORMATDESCRIPTOR*)): BOOL;
	SwapBuffers- : PROCEDURE { WINAPI }  (p0: HDC): BOOL;

	(* USER32.dll *)
	GetDesktopWindow-: PROCEDURE { WINAPI } (): HWND;
	GetWindowDC- : PROCEDURE  { WINAPI } (hwin: HWND): HDC;
	
	PROCEDURE GetDC*(hwn: HANDLE): HDC;
	BEGIN
		RETURN User32.GetDC(hwn);
	END GetDC;

	PROCEDURE DeleteDC*(hdc: HDC): LONGINT;
	BEGIN
		RETURN GDI32.DeleteDC(hdc);
	END DeleteDC;

	PROCEDURE ReleaseDC*(hwn: HWND; hdc: HDC): LONGINT;
	BEGIN
		RETURN User32.ReleaseDC(hwn, hdc);
	END ReleaseDC;

	PROCEDURE SelectObject*(hdc: HDC; hbm: HBITMAP): LONGINT;
	BEGIN
		RETURN GDI32.SelectObject(hdc, hbm);
	END SelectObject;

	PROCEDURE DeleteObject*(hnd: HANDLE): LONGINT;
	BEGIN
		RETURN GDI32.DeleteObject(hnd);
	END DeleteObject;


	PROCEDURE CreateCompatibleDC*(hdc: HDC): HDC;
	BEGIN
		RETURN GDI32.CreateCompatibleDC(hdc);
	END CreateCompatibleDC;
				
PROCEDURE InitWinApiLibs;
VAR
	lib: Kernel32.HMODULE; str: ARRAY 32 OF CHAR;
BEGIN
	str := "GDI32.DLL";
	lib := Kernel32.LoadLibrary(str);
	
	Kernel32.GetProcAddress(lib, "CreateDIBSection", S.VAL(LONGINT,CreateDIBSection ));
	Kernel32.GetProcAddress(lib, "CreatePalette", S.VAL(LONGINT,CreatePalette ));
	Kernel32.GetProcAddress(lib, "GetCurrentObject", S.VAL(LONGINT,GetCurrentObject ));

	Kernel32.GetProcAddress(lib, "GetObjectA", S.VAL(LONGINT,GetObject ));
	Kernel32.GetProcAddress(lib, "GetObjectType", S.VAL(LONGINT,GetObjectType ));
	Kernel32.GetProcAddress(lib, "RealizePalette", S.VAL(LONGINT,RealizePalette ));
	Kernel32.GetProcAddress(lib, "SelectPalette", S.VAL(LONGINT,SelectPalette ));	 

	Kernel32.GetProcAddress(lib, "ChoosePixelFormat", S.VAL(LONGINT,ChoosePixelFormat ));
	Kernel32.GetProcAddress(lib, "DescribePixelFormat", S.VAL(LONGINT,DescribePixelFormat ));
	Kernel32.GetProcAddress(lib, "GetPixelFormat", S.VAL(LONGINT,GetPixelFormat ));	
	Kernel32.GetProcAddress(lib, "SetPixelFormat", S.VAL(LONGINT,SetPixelFormat ));
	Kernel32.GetProcAddress(lib, "SwapBuffers", S.VAL(LONGINT,SwapBuffers ));
	
	str := "USER32.DLL";
	lib := Kernel32.LoadLibrary(str);	
	Kernel32.GetProcAddress(lib, "GetDesktopWindow", S.VAL(LONGINT,GetDesktopWindow ));
	Kernel32.GetProcAddress(lib, "GetWindowDC", S.VAL(LONGINT,GetWindowDC ));		
END InitWinApiLibs;

BEGIN
	InitWinApiLibs;

END WinApi.
