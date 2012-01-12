MODULE OGLWindow; (** AUTHOR "fnecati"; PURPOSE "OpenGL enabled OO X11Window wrapper; *)

IMPORT
	 X11, Api := X11Api, GL:=OpenGL, GLC := OpenGLConst, Kernel, Inputs ,
	Trace,  SYSTEM ;

CONST 
	debug = TRUE; (* for window creation/closing *)
	debugevents = FALSE; (* for testing events *)

CONST
	ML = 0;  MM = 1;  MR = 2;

	ShiftKeyBit = 0;  ShiftLockBit = 1;  ControlKeyBit = 2;  Mod1KeyBit = 3;
	Mod2KeyBit = 4;  Mod3KeyBit = 5;  Mod4KeyBit = 6;  Mod5KeyBit = 7;

TYPE
	Hints = RECORD
		flags: SET;
		functions: LONGINT;
		decorations: LONGINT;
		inputMode: LONGINT;
		status: LONGINT;
	END;
	
VAR 	
	keySymbol: ARRAY 256 OF LONGINT;
	xbuttons: SET;
	compstatus: X11.ComposeStatus;
		  

TYPE Window* = OBJECT
VAR
	timer, idletimer : Kernel.MilliTimer; 
	
	(* window variables *)
	display-: X11.DisplayPtr;
	win- : X11.Window ;
	glctx- : GL.GLXContext;  (* GL context *)

	title-: ARRAY 128 OF CHAR;
	alive* : BOOLEAN; (* for main loop control *)	
	
	left-, top-: LONGINT; (* top left origin of window *)
	width-, height- : LONGINT; (* size of window *)

	frames-:LONGINT;
	idletime-: LONGINT; (* ms, for IdleDisplay *)
	
	fullscreen-, fullwindow-, decorations-: BOOLEAN;
	hidecursor-: BOOLEAN;
	wmDelete : X11.Atom;
	
PROCEDURE & Init*(w, h, l, t: LONGINT; fs: BOOLEAN);
BEGIN
	width := w; height := h;
	left := l;  top := t ;
	title:="OGLWindow";
	idletime := 1000; 
	fullscreen := FALSE;
	decorations := TRUE;
	fullwindow := fs;	
	hidecursor := FALSE;
	InitWindow(width,height, left, top); 
END Init;

(** Close the window *)
PROCEDURE Close*;
BEGIN
alive := FALSE;
(*CloseWindow;	*)
END Close;

(** reshape GL state*)
PROCEDURE Reshape*(w, h: LONGINT);
BEGIN
END Reshape;

(* Display procedure for GL *) 
PROCEDURE Display*();
END Display;

(** Redisplay proc for GL  *)
PROCEDURE ReDisplay*();
VAR
	xev: Api.XEvent;
	res: LONGINT;
BEGIN
	xev.typ := Api.Expose; 
	res := Api.SendEvent(display, win, Api.False, {Api.ExposureMask}, SYSTEM.ADR(xev));
END ReDisplay;

(** called when window opened and GL context created *)
PROCEDURE OnLoad*();
END OnLoad;

(** when iddle time expired, redisplay GL content *)
PROCEDURE IdleDisplay*();
END IdleDisplay;

(** for GL contexts *)
PROCEDURE MakeCurrent*();
VAR res: LONGINT;
BEGIN 
	res := GL.glXMakeCurrent(display, win, glctx);
	IF debug THEN Trace.String(" MakeCurrent:"); Trace.Boolean(res=1); Trace.Ln; END;
END MakeCurrent;

PROCEDURE DeActivate*();
VAR res: LONGINT;
 BEGIN 
	res := GL.glXMakeCurrent(display, 0, 0);
	IF debug THEN Trace.String(" DeActivate:"); Trace.Boolean(res=1); Trace.Ln; END;
END DeActivate;
		
PROCEDURE SwapBuffers*();
BEGIN
	GL.glXSwapBuffers(display, win);	
END SwapBuffers;

PROCEDURE FocusGot*();
END FocusGot;

(** called by X11 events *)
PROCEDURE FocusLost*();
END FocusLost;

PROCEDURE KeyEvent* (ucs : LONGINT; flags : SET; keysym : LONGINT);
END KeyEvent ;
	
PROCEDURE PointerDown* (x, y : LONGINT; keys : SET);
END PointerDown;

PROCEDURE PointerUp* (x, y : LONGINT; keys : SET);
END PointerUp;

PROCEDURE PointerMove* (x, y : LONGINT; keys : SET);
END PointerMove;

PROCEDURE PointerLeave*();
END PointerLeave;

PROCEDURE WheelMove*(dz : LONGINT);
END WheelMove;

(** resize width,height *)
PROCEDURE ResizeWindow*(w, h: LONGINT);
BEGIN
	X11.ResizeWindow(display, win, ABS(w) ,ABS(h));
END ResizeWindow;

(** move to x,y and  resize width,height *)
PROCEDURE MoveResizeWindow*(x, y, w, h: LONGINT);
BEGIN
	X11.MoveResizeWindow(display, win, x, y, ABS(w) ,ABS(h));
END MoveResizeWindow;

(** close the window and its resources *)
 PROCEDURE CloseWindow;
  VAR res: LONGINT;
 BEGIN

	(* do we have a rendering context *)
	IF glctx # 0 THEN
		(* Release the context *)
	    	res := GL.glXMakeCurrent(display, 0, 0);
	    	(* Delete the context *)
		GL.glXDestroyContext(display, glctx);
		glctx := 0;
		IF debug THEN Trace.String("context deleted"); Trace.Ln; END;
	END;
	
	(* do we have a window *)
	IF win # 0 THEN
		(* Unmap the window*)
		Api.UnmapWindow(display, win);
		(* Destroy the window *)
		res:= Api.DestroyWindow(display, win);
		win := 0;
		IF debug THEN Trace.String("window deleted"); Trace.Ln; END;
	END;
	
	(* do we have a display *)
	IF display # 0 THEN	
		res := Api.CloseDisplay(display);
		display := 0;
		IF debug THEN Trace.String("display deleted"); Trace.Ln; END;
	END;

 END CloseWindow;

(** make null cursor for mouse pointer *) 
PROCEDURE HidePointer*(hide: BOOLEAN);
VAR
	fg : X11.Color;
	pixmap: X11.Pixmap;
	noCursor: X11.Cursor;
	data: ARRAY 8 OF CHAR;
	i : LONGINT;
BEGIN
	IF hide = hidecursor THEN RETURN END;
	hidecursor := hide;
	IF hidecursor THEN
		fg.red := 0;  fg.green := 0;  fg.blue :=0;
		FOR i:=0 TO 7 DO data[i] := 0X  END;
		pixmap := X11.CreateBitmapFromData( display, win, SYSTEM.ADR( data[0] ), 8, 8 );
		noCursor := X11.CreatePixmapCursor( display, pixmap, pixmap, SYSTEM.ADR( fg ), SYSTEM.ADR( fg ), 0, 0 );
		X11.DefineCursor( display, win, noCursor ); 
(*		Api.FreeCursor(displayi noCursor); *)
		X11.FreePixmap(display, pixmap);
	END;	
END HidePointer;

(** set title of the window *)
PROCEDURE SetTitle*(tit: ARRAY OF CHAR);
VAR res: LONGINT;
BEGIN
	COPY(tit, title);
	 res := Api.StoreName(display, win, title); 
END SetTitle;

(** set idle time  for calling IdleDisplay proc *)
PROCEDURE SetIdleTime*(ms: LONGINT);
BEGIN
 idletime := ms;
END SetIdleTime;
 
 (** set X11 window decorartion on/off *)
PROCEDURE SetDecorations*(decor: BOOLEAN);
VAR 	hints: Hints; 
	property: X11.Atom;
BEGIN
		IF (decor = decorations) OR fullwindow THEN RETURN END; (* no need to set again *)
	IF  ~fullscreen THEN
		decorations := decor;
		hints.flags := {1};
 		IF ~decor THEN hints.decorations := 0; ELSE hints.decorations := 1; END;
		property := Api.InternAtom(display, "_MOTIF_WM_HINTS", Api.True); 
		X11.ChangeProperty(display, win, property, property, 32, Api.PropModeReplace, SYSTEM.ADR(hints), 5);
	END;	
END SetDecorations;

(** Set X11 window state to full *)
	PROCEDURE SetFullWindow*(fullw: BOOLEAN);
	VAR 
		cm: Api.XClientMessageEvent;
		xev: Api.XEvent;
		dl: Api.Data40l;
		wmstate, wmfullscreen: X11.Atom;
		res: LONGINT;
	BEGIN
	
	IF (fullw = fullwindow) OR ~ decorations THEN RETURN END; (* no need to set again*)
	fullwindow := fullw;	
	
	wmstate := Api.InternAtom(display, "_NET_WM_STATE", Api.False);
	wmfullscreen := Api.InternAtom(display, "_NET_WM_STATE_FULLSCREEN", Api.False);

	cm.typ := Api.ClientMessage; cm.window := win;  cm.messageType := wmstate;
	cm.format := 32; 
	IF fullwindow THEN dl[0] := 1; ELSE dl[0] := 0; END;
	dl[1] := wmfullscreen;  dl[2] := 0;
	cm.data:=SYSTEM.VAL(Api.Data40, dl);  xev := SYSTEM.VAL(Api.XEvent, cm);

	res := Api.SendEvent(display, X11.DefaultRootWindow(display), Api.False, {Api.SubstructureNotifyMask}, SYSTEM.ADR(xev));
	END SetFullWindow;

(** create an X11 window, and GL context *)
PROCEDURE  InitWindow(w, h, l, t: LONGINT);
VAR 
	res: LONGINT;
	masks: SET;
	attrib : POINTER TO ARRAY OF GL.GLint;  (* attributes of GL window *) 
	swa : Api.XSetWindowAttributes; (* set window attributes*)
	visinfoptr : Api.VisualInfoPtr; (* pointer to X11 VisualInfo *)
	xev: Api.XEvent;
BEGIN

 display := X11.OpenDisplay(0);
 IF display =0 THEN
 	Trace.String(" cannot connect to X server"); Trace.Ln; 
	Close;
     RETURN;
END;  
 
  NEW(attrib, 13);
  attrib[0] := GLC.GLX_RGBA;
  attrib[1] := GLC.GLX_DOUBLEBUFFER;
  attrib[2] := GLC.GLX_DEPTH_SIZE;	attrib[3] := 24; 
  attrib[4] := GLC.GLX_STENCIL_SIZE;	attrib[5] := 8; 
  attrib[6] := GLC.GLX_RED_SIZE;  	attrib[7] := 8;
  attrib[8] := GLC.GLX_GREEN_SIZE;	attrib[9] := 8;
  attrib[10] := GLC.GLX_RED_SIZE;	attrib[11] := 8;
  attrib[12] := 0 ;

 (* try to find a visual with this attribs *)	
 visinfoptr := GL.glXChooseVisual(display, 0 , SYSTEM.ADR(attrib[0]));
 
 IF visinfoptr = NIL THEN
  	IF debug THEN Trace.String(" NO appropriate visual found"); Trace.Ln; END;
  	Close;
     RETURN;
 ELSE 
	 IF debug THEN 
		 Trace.String("visinfoptr.depth= "); Trace.Int(visinfoptr.depth,0); Trace.Ln;
	 	Trace.String("visinfoptr.visual ");  Trace.Int(visinfoptr.visualID, 0); Trace.Ln; 
	END;
END;


  (* window attributes *)
 swa.backgroundPixel := 0;
 swa.borderPixel := 0;
 swa.colormap := X11.CreateColormap(display, X11.DefaultRootWindow(display), visinfoptr.visual, X11.AllocNone);

 (* window event masks *)	
 masks :=  {Api.KeyPressMask, Api.KeyReleaseMask, Api.ButtonPressMask, Api.ButtonReleaseMask, Api.PointerMotionMask,
  Api.ButtonMotionMask, Api.ExposureMask, Api.StructureNotifyMask,  Api.FocusChangeMask} ;

 swa.eventMask := masks;
 
 masks := { Api.CWBackPixel, Api.CWBorderPixel, Api.CWColormap, Api.CWEventMask};
 
 win := Api.CreateWindow(display, X11.DefaultRootWindow(display), l, t, w, h,
		        0, visinfoptr.depth, Api.InputOutput,  visinfoptr.visual, masks, SYSTEM.ADR(swa));

					(* set wm_delete_events if in windowed mode *)
					wmDelete := Api.InternAtom(display, "WM_DELETE_WINDOW", Api.True);   
					res := Api.SetWMProtocols(display, win, SYSTEM.ADR(wmDelete), 1);
					
  Api.MapWindow(display, win);

 res := Api.StoreName(display, win, title); 

			(* Wait for map notification *)	
		 	REPEAT  
		 		Api.NextEvent( display, xev );
		 		IF debug THEN Trace.String("Event type="); Trace.Int(xev.typ,4); Trace.Ln; END;
			UNTIL (xev.typ = Api.MapNotify) & (xev.window = win);
			
 glctx := GL.glXCreateContext(display, visinfoptr, 0, GLC.GL_TRUE); 
	 	IF glctx = 0 THEN
			 IF debug THEN Trace.String("glXCreateContext glctx= "); Trace.Int(glctx, 0); Trace.Ln; END;	 		 		
			Close;
			RETURN;
		END; 

(*MakeCurrent();*)
END InitWindow;


	(* Returns wether key (SHIFT, CTRL or ALT) is pressed *)
	PROCEDURE KeyState( ): SET;
	VAR keys: SET;
	BEGIN
		keys := {};
		IF ShiftKeyBit IN xbuttons THEN  INCL( keys, Inputs.LeftShift )  END;
		IF ControlKeyBit IN xbuttons THEN  INCL( keys, Inputs.LeftCtrl )  END;
		IF Mod1KeyBit IN xbuttons THEN  INCL( keys, Inputs.LeftAlt )  END;
		IF Mod4KeyBit IN xbuttons THEN  INCL( keys, Inputs.LeftMeta )  END;
		IF Mod5KeyBit IN xbuttons THEN  INCL( keys, Inputs.RightAlt )  END;
		RETURN keys
	END KeyState;
	
(* process pending X11 events for this window *)
PROCEDURE LoopForEvents;
VAR 		event: Api.XEvent;
		kp : Api.XKeyEvent; 	be : Api.XButtonPressedEvent; em: Api.XExposeEvent;
		cm : Api.XClientMessageEvent; cn : Api.XConfigureEvent; me: Api.XMotionEvent;
		datal: Api.Data40l;
	       keycount, xr, yr, x, y, i: LONGINT;
		buffer: X11.Buffer;  keysym: X11.KeySym; 
		newxbuttons, bdiff: SET;
		rw, cw: X11.Window; 
		ch: CHAR;
		flags: SET;
BEGIN
 WHILE Api.Pending(display)>0 DO 
	Api.NextEvent(display, event);
			CASE event.typ OF
			Api.KeyPress: kp := SYSTEM.VAL(Api.XKeyEvent, event);
					keycount := Api.LookupString( kp, buffer, X11.BufferSize, keysym, compstatus );
					X11.QueryPointer( display, event.window, rw, cw, xr, yr, x, y, newxbuttons );
					i := 0;
					IF keycount = 0 THEN
						bdiff := newxbuttons / xbuttons;  xbuttons := newxbuttons;
						ch := 0X;
						IF ShiftKeyBit IN bdiff THEN keysym := Inputs.KsShiftL
						ELSIF ControlKeyBit IN bdiff THEN keysym := Inputs.KsControlL
						ELSIF Mod1KeyBit IN bdiff THEN keysym := Inputs.KsAltL
						ELSIF Mod4KeyBit IN bdiff THEN keysym := Inputs.KsMetaL
						ELSIF Mod5KeyBit IN bdiff THEN keysym := Inputs.KsAltR
						END;
						flags := KeyState();
						KeyEvent( ORD(0X), flags, keysym )
					ELSE
						xbuttons := newxbuttons;
						WHILE i < keycount DO
							ch := buffer[i];  flags := KeyState( );
							keysym := keySymbol[ORD( ch )];
							IF ch = 0F1X THEN  ch := 0A4X
							ELSIF ch = 0F2X THEN ch := 0A5X
							END;
							KeyEvent( ORD(ch), flags, keysym);
							INC( i )
						END
					END;								
			| Api.KeyRelease: kp := SYSTEM.VAL(Api.XKeyEvent, event);
					X11.QueryPointer( display, event.window, rw, cw, xr, yr, x, y, newxbuttons );
					bdiff := newxbuttons / xbuttons;  xbuttons := newxbuttons;
					IF bdiff # {} THEN
						ch := 0X;
						IF ShiftKeyBit IN bdiff THEN keysym := Inputs.KsShiftL
						ELSIF ControlKeyBit IN bdiff THEN keysym := Inputs.KsControlL
						ELSIF Mod1KeyBit IN bdiff THEN keysym := Inputs.KsAltL
						ELSIF Mod4KeyBit IN bdiff THEN keysym := Inputs.KsMetaL
						ELSIF Mod5KeyBit IN bdiff THEN keysym := Inputs.KsAltR
						END;
						flags := KeyState( ) + {Inputs.Release};
						KeyEvent(ORD(ch), flags, keysym);	
					END;			
			| Api.ButtonPress: be := SYSTEM.VAL(Api.XButtonPressedEvent, event); Wr("ButtonPressed");
					be.y := height-be.y-1; (* gl window coord is lower-left *)
					CASE be.button OF
					| Api.Button1:   INCL( xbuttons, ML ); PointerDown( be.x, be.y, xbuttons );
					| Api.Button2:   INCL( xbuttons, MM ); PointerDown( be.x, be.y, xbuttons );
					| Api.Button3:   INCL( xbuttons, MR ); PointerDown( be.x, be.y, xbuttons );
					| Api.Button4:  WheelMove(-1);
					| Api.Button5:  WheelMove(+1);
					ELSE  (* ignore *)
					END;
					
			| Api.ButtonRelease: be := SYSTEM.VAL(Api.XButtonReleasedEvent, event);
					be.y := height-be.y -1 ; (* gl window coord is lower-left *)
					CASE be.button OF
					| Api.Button1:   EXCL( xbuttons, ML );PointerUp( be.x, be.y, xbuttons );
					| Api.Button2:   EXCL( xbuttons, MM );  PointerUp( be.x, be.y, xbuttons );
					| Api.Button3:  EXCL( xbuttons, MR );  PointerUp( be.x, be.y, xbuttons );
(*					| Api.Button4:  WheelMove(-1); 
					| Api.Button5:  WheelMove(+1);*)
					ELSE  (* ignore *)
					END;
								
			| Api.MotionNotify: me := SYSTEM.VAL(Api.XMotionEvent, event);
					PointerMove( me.x, height-me.y-1,  xbuttons )
			| Api.Expose, Api.GraphicsExpose:  	
					em := SYSTEM.VAL( Api.XExposeEvent, event );
					IF em.count = 0 THEN (* wait until last message*)
						Wr("Expose");
						Display;
					END;

			| Api.ConfigureNotify: Wr("ConfigureNotify");
					cn := SYSTEM.VAL(Api.XConfigureEvent, event);

			                (* call Reshape only if our window-size changed *)
					IF (cn.width # width) OR  (cn.height # height) THEN
						width := cn.width;
						height := cn.height;
						Reshape(width, height);			
					END;
						
			| Api.ClientMessage: 
					cm := SYSTEM.VAL( Api.XClientMessageEvent, event );
					datal := SYSTEM.VAL( Api.Data40l, cm.data );
					IF  SYSTEM.VAL( X11.Atom,datal[0] ) = wmDelete THEN									
						(* shutdown *)
						alive := FALSE;
					END; 
			ELSE	
			END;	
	   	END;
END LoopForEvents;


(* windows main loop *)
PROCEDURE MainLoop*;
BEGIN
frames := 0;
Kernel.SetTimer(timer, 1000);
alive := TRUE;

	MakeCurrent();
 	OnLoad;
	Reshape(width, height);
	
WHILE  alive  DO 
		(* process X11 events *)
		LoopForEvents;

		IF idletime # 0 THEN
				IF Kernel.Expired(idletimer) THEN
					IdleDisplay;
					Kernel.SetTimer(idletimer, idletime);
				END;
		END;
				
		 (* measure timing info *)
		 IF debug THEN
			INC(frames);
			IF Kernel.Expired(timer) THEN
				Trace.Int(frames,0); Trace.String(" frames in 5 secs."); 
				Trace.String(" FPS = "); Trace.Int(frames DIV 5,0); 
				Trace.Ln;
				Kernel.SetTimer(timer,5000);
				frames := 0;
			END;
		END;
		
END;
CloseWindow;
END MainLoop;

BEGIN 
	MainLoop;
END Window;


	PROCEDURE InitKeysym;
	VAR i: LONGINT;
	BEGIN
		FOR i := 0 TO 255 DO keySymbol[i] := i END;
		keySymbol[07FH] := Inputs.KsBackSpace;
		keySymbol[009H] := Inputs.KsTab;
		keySymbol[00AH] := Inputs.KsReturn;
		keySymbol[00DH] := Inputs.KsReturn;

		keySymbol[0C1H] := Inputs.KsUp;
		keySymbol[0C2H] := Inputs.KsDown;
		keySymbol[0C3H] := Inputs.KsRight;
		keySymbol[0C4H] := Inputs.KsLeft;

		keySymbol[0A0H] := Inputs.KsInsert;
		keySymbol[0A1H] := Inputs.KsDelete;
		keySymbol[0A2H] := Inputs.KsPageUp;
		keySymbol[0A3H] := Inputs.KsPageDown;
		keySymbol[0A8H] := Inputs.KsHome;
		keySymbol[0A9H] := Inputs.KsEnd;
		FOR i := 0F1H TO 0FCH DO keySymbol[i] := 0FFBEH + (i - 0F1H) END
	END InitKeysym;
		
PROCEDURE Wr(CONST str: ARRAY OF CHAR);
BEGIN
	IF debugevents THEN Trace.StringLn(str); Trace.Ln END;
END Wr;

BEGIN
InitKeysym;
 GL.InitOpenGL;
END OGLWindow.

SystemTools.Free OGLWindow ~ 