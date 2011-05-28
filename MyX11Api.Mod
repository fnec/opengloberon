MODULE MyX11Api; (** AUTHOR "fnecati"; PURPOSE "some missing structures and functions in Unix.X11.Mod"; *)

IMPORT
		X11, Unix, Modules, Trace,  SYSTEM;	
		
TYPE 
	   ADDRESS= SYSTEM.ADDRESS;
	   VisualInfoPtr*  = POINTER TO X11.VisualInfo; 
	   DisplayPtr* = X11.DisplayPtr;

(* Cursor control & motion *)
(* X11/keysymdef.h *)
CONST

 XK_Home* = 	0FF50H;
 XK_Left* = 	0FF51H;  (* Move left, left arrow *)
 XK_Up* = 	0FF52H;  (* Move up, up arrow *)
 XK_Right* = 	0FF53H;  (* Move right, right arrow *)
 XK_Down* = 	0FF54H;  (* Move down, down arrow *)
 XK_Prior* = 	0FF55H;  (* Prior, previous *)
 XK_Page_Up* = 	0FF55H;
 XK_Next* = 	0FF56H;  (* Next *)
 XK_Page_Down* = 0FF56H;
 XK_End* = 	0FF57H;  (* EOL *)
 XK_Begin* = 	0FF58H;  (* BOL *)


(* EVENT DEFINITIONS
    similar to Unix.X11.Mod but changed types to SET for easy usage 
*)
 
(*  Input Event Masks. Used as event-mask window attribute and as arguments
   to Grab requests.  Not to be confused with event names. *)

CONST
    NoEventMask* =	{ };  KeyPressMask* = { 0 }; KeyReleaseMask* = { 1 };
    ButtonPressMask* = { 2 };  ButtonReleaseMask* = { 3 };  EnterWindowMask* = { 4 };  
    LeaveWindowMask* = { 5 };  PointerMotionMask* = { 6 };  PointerMotionHintMask* = { 7 };  
    Button1MotionMask* = { 8 }; Button2MotionMask* = { 9 }; Button3MotionMask* = { 10 }; 
    Button4MotionMask* = { 11 };  Button5MotionMask* = { 12 };  ButtonMotionMask* = { 13 }; 
    KeymapStateMask* = { 14 }; ExposureMask* = { 15 }; VisibilityChangeMask* = { 16 }; 
    StructureNotifyMask* = { 17 }; ResizeRedirectMask* = { 18 }; SubstructureNotifyMask* = { 19 }; 
    SubstructureRedirectMask	* = { 20 }; FocusChangeMask	* = { 21 }; PropertyChangeMask* = { 22 }; 
    ColormapChangeMask* = { 23 }; OwnerGrabButtonMask* = { 24 }; 

(* Event names.  Used in "type" field in XEvent structures.  Not to be
confused with event masks above.  They start from 2 because 0 and 1
are reserved in the protocol for errors and replies. *)

(* missing constants are added *)
CONST
    KeyPress* = 2;  KeyRelease* =3;  ButtonPress* = 4;  ButtonRelease* = 5;  MotionNotify* =6;
    EnterNotify* = 7; LeaveNotify* =8;  FocusIn* = 9;  FocusOut* = 10;  KeymapNotify* = 11;
    Expose* = 12;  GraphicsExpose* = 13;  NoExpose* = 14;  VisibilityNotify* = 15;
    CreateNotify* = 16; DestroyNotify* = 17; UnmapNotify* = 18;  MapNotify* = 19;
    MapRequest* = 20;  ReparentNotify* = 21; ConfigureNotify* = 22; ConfigureRequest* = 23;
    GravityNotify* = 24; ResizeRequest* =	25; CirculateNotify* = 26; CirculateRequest* = 27;
    PropertyNotify* = 28; SelectionClear* = 29; SelectionRequest* =30; SelectionNotify* = 31;
    ColormapNotify* = 32;  ClientMessage* = 33;  MappingNotify* = 34;  GenericEvent* = 35;
    LASTEvent* =		36;	 (* must be bigger than any event # *)
     
	
	 (*  Window classes used by CreateWindow *)
	   InputOutput* = 1;
	   InputOnly* = 2;

(* Window attributes for CreateWindow and ChangeWindowAttributes *)
           CWBackPixmap* = 0;
           CWBackPixel* = 1;
           CWBorderPixmap* = 2;
           CWBorderPixel* =3;
           CWBitGravity* =4;
           CWWinGravity* =5;
           CWBackingStore* =6;
           CWBackingPlanes* =7;
           CWBackingPixel* =8;
           CWOverrideRedirect* =9;
           CWSaveUnder* =10;
           CWEventMask* =11;
           CWDontPropagate* =12;
           CWColormap* =13;
           CWCursor* =14;
TYPE 
	XSetWindowAttributes* = RECORD
             background_pixmap*: X11.Pixmap; (* background, None, or ParentRelative *)
            background_pixel*: LONGINT;(* background pixel *)
             border_pixmap*: X11.Pixmap;    (* border of the window or CopyFromParent *)
            border_pixel*: LONGINT;(* border pixel value *)
            bit_gravity*: LONGINT;         (* one of bit gravity values *)
            win_gravity*: LONGINT;         (* one of the window gravity values *)
            backing_store*: LONGINT;       (* NotUseful, WhenMapped, Always *)
           backing_planes*: LONGINT;(* planes to be preserved if possible *)
            backing_pixel*: LONGINT;(* value to use in restoring planes *)
            save_under*: BOOLEAN;         (* should bits under be saved? (popups) *)
            event_mask*:  SET;         (* set of events that should be saved *)
             do_not_propagate_mask*: SET;(* set of events that should not propagate *)
            override_redirect*: BOOLEAN;  (* boolean value for override_redirect *)
             colormap*: X11.Colormap;       (* color map to be associated with window *)
             cursor*: X11.Cursor ;           (* cursor to be displayed (or None) *)
    END ;
    	   
XWindowAttributes* = RECORD
	 x*, y*: LONGINT;			(* location of window *)
	width*, height*: LONGINT;		(* width and height of window *)
	border_width*: LONGINT;			(* border width of window *)
	depth*: LONGINT;			(* depth of window *)
	visual* : X11.VisualPtr;			(* the associated visual structure *)
	root* : X11.Window;				(* root of screen containing window *)
	class*: LONGINT;			(* InputOutput, InputOnly*)
	bit_gravity*: LONGINT;			(* one of the bit gravity values *)
	win_gravity*: LONGINT;			(* one of the window gravity values *)
	backing_store*: LONGINT;		(* NotUseful, WhenMapped, Always *)
	backing_planes*: LONGINT;		(* planes to be preserved if possible *)
	backing_pixel*: LONGINT;		(* value to be used when restoring planes *)
	save_under*: BOOLEAN;			(* boolean, should bits under be saved? *)
	colormap*: X11.Colormap;			(* color map to be associated with window *)
	map_installed*: BOOLEAN;		(* boolean, is color map currently installed*)
	map_state*: LONGINT;		(* IsUnmapped, IsUnviewable, IsViewable *)
	all_event_masks*: SET;		(* set of events all people have interest in*)
	your_event_mask*: SET;		(* my event mask *)
	do_not_propagate_mask*: SET;	(* set of events that should not propagate *)
	override_redirect*: BOOLEAN;		(* boolean value for override-redirect *)
	screen*: LONGINT; (*X11.Screen;*)			(* back pointer to correct screen *)
END;

(* X11/X.h *)
 XConfigureEvent* = RECORD
	type*: LONGINT;	        (* ConfigureNotify *)
	serial*: LONGINT;	(* # of last request processed by server *)
	send_event*: X11.Bool;	(* true if this came from a SendEvent request *)
	display*: X11.DisplayPtr;	(* Display the event was read from *)
	event*: X11.Window;
	window*: X11.Window;
	x*, y*: LONGINT;
	width*, height*: LONGINT;
	border_width*: LONGINT;
	above*: X11.Window;
	override_redirect*: X11.Bool;
    END;	


VAR
	xlib: LONGINT;
	CloseDisplay- : PROCEDURE { C } (display:X11.DisplayPtr): LONGINT;
	DestroyWindow-: PROCEDURE { C }(display:X11.DisplayPtr; win: X11.Window): LONGINT;
	FreeColormap- : PROCEDURE { C } (display:X11.DisplayPtr;  colormap: X11.Colormap);
	GetWindowAttributes- : PROCEDURE { C } (display:X11.DisplayPtr; win: X11.Window; attr: ADDRESS): LONGINT;
	InternAtom-: PROCEDURE {C} ( d: X11.DisplayPtr;  CONST name: ARRAY OF CHAR;  onlyifexists: X11.Bool ): X11.Atom;
	MapWindow- : PROCEDURE { C } (display:X11.DisplayPtr; win: X11.Window);	
	UnmapWindow- : PROCEDURE { C } (display:X11.DisplayPtr; win: X11.Window);	
	Pending- : PROCEDURE { C } (display:X11.DisplayPtr): LONGINT;
	RaiseWindow-: PROCEDURE { C }(display:X11.DisplayPtr; win: X11.Window);
	StoreName- : PROCEDURE { C } (display:X11.DisplayPtr; win: X11.Window; CONST s: ARRAY OF CHAR): LONGINT;
	CreateWindow- : PROCEDURE { C } (display: X11.DisplayPtr; parent: X11.Window;  x,  y: LONGINT;  width, height, border_width, depth, class: LONGINT; visual: X11.VisualPtr; valuemask: SET;  attributes: ADDRESS (*XSetWindowAttributes*) ): X11.Window;
	LookupKeysym- : PROCEDURE { C } ( CONST event: X11.KeyEvent; index: LONGINT): X11.KeySym;

PROCEDURE LoadX11Functions;
BEGIN {EXCLUSIVE}

		xlib := Unix.Dlopen( Unix.libX11name, 2 );
	
		Unix.Dlsym( xlib, "XCloseDisplay", SYSTEM.VAL( ADDRESS, CloseDisplay));
		Unix.Dlsym( xlib, "XCreateWindow", SYSTEM.VAL( ADDRESS, CreateWindow));
		Unix.Dlsym( xlib, "XDestroyWindow", SYSTEM.VAL( ADDRESS, DestroyWindow));
		Unix.Dlsym( xlib, "XFreeColormap", SYSTEM.VAL( ADDRESS, FreeColormap));
		Unix.Dlsym( xlib, "XGetWindowAttributes", SYSTEM.VAL( ADDRESS, GetWindowAttributes));
		Unix.Dlsym( xlib, "XInternAtom", SYSTEM.VAL( ADDRESS, InternAtom));
		Unix.Dlsym( xlib, "XMapWindow", SYSTEM.VAL( ADDRESS, MapWindow));
		Unix.Dlsym( xlib, "XUnmapWindow", SYSTEM.VAL( ADDRESS, UnmapWindow));	
		Unix.Dlsym( xlib, "XPending", SYSTEM.VAL( ADDRESS, Pending));
		Unix.Dlsym( xlib, "XRaiseWindow", SYSTEM.VAL( ADDRESS, RaiseWindow));
		Unix.Dlsym( xlib, "XStoreName", SYSTEM.VAL( ADDRESS, StoreName));
		Unix.Dlsym( xlib, "XLookupKeysym", SYSTEM.VAL( ADDRESS, LookupKeysym));
		
END LoadX11Functions;

PROCEDURE OnClose;
BEGIN {EXCLUSIVE}
 IF xlib # 0 THEN
       Unix.Dlclose(xlib);
       Trace.String(Unix.libX11name); Trace.StringLn(' unloaded.');      
END;
END OnClose;

	
BEGIN	
LoadX11Functions;
Modules.InstallTermHandler(OnClose) ;
END MyX11Api.
