MODULE X11Api; (** AUTHOR "fnecati"; PURPOSE "some missing types, const and functions in Unix.X11.Mod"; *)

IMPORT
	X11;

CONST

(* *********************************************** *)
	(* X11/Xlib.h*)
(* *********************************************** *)
TYPE
	Status* = WORD;
	(* ******************************************** *)
	(* ******************************************** *)
	 (* Definitions of specific events. from  X11lib.h *)



	TYPE MotionEvent* = RECORD
		typ* : WORD;		(* of event *)
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;	        (* "event" window reported relative to *)
		root* : X11.Window;	        (* root window that the event occurred on *)
		subwindow* : X11.Window;	(* child window *)
		time* : X11.Time;		(* milliseconds *)
		x*, y* : WORD;		(* pointer x, y coordinates in event window *)
		xRoot*, yRoot* : WORD;	(* coordinates relative to root *)
		state* : WORDSET;	(* key or button mask *)
		isHint* : CHAR;		(* detail *)
		sameScreen* : X11.Bool;	(* same screen flag *)
	END;
	TYPE PointerMovedEvent* = MotionEvent;

	TYPE  CrossingEvent* = RECORD
		typ* : WORD;		(* of event *)
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;	        (* "event" window reported relative to *)
		root* : X11.Window;	        (* root window that the event occurred on *)
		subwindow* : X11.Window;	(* child window *)
		time* : X11.Time;		(* milliseconds *)
		x*, y* : WORD;		(* pointer x, y coordinates in event window *)
		xRoot*, yRoot* : WORD;	(* coordinates relative to root *)
		mode* : WORD;		(* NotifyNormal, NotifyGrab, NotifyUngrab *)
		detail* : WORD;
		(*
		* NotifyAncestor, NotifyVirtual, NotifyInferior,
		* NotifyNonlinear,NotifyNonlinearVirtual
		*)
		sameScreen* : X11.Bool;	(* same screen flag *)
		focus* : X11.Bool;		(* boolean focus *)
		state* : WORDSET;	(* key or button mask *)
	END;
	TYPE EnterWindowEvent* = CrossingEvent;
	TYPE LeaveWindowEvent* = CrossingEvent;

	TYPE FocusChangeEvent* = RECORD
		typ* : WORD;		(* FocusIn or FocusOut *)
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;		(* window of event *)
		mode* : LONGINT;		(* NotifyNormal, NotifyWhileGrabbed, NotifyGrab, NotifyUngrab *)
		detail* : LONGINT;
		(*
		* NotifyAncestor, NotifyVirtual, NotifyInferior,
		* NotifyNonlinear,NotifyNonlinearVirtual, NotifyPointer,
		* NotifyPointerRoot, NotifyDetailNone
		*)
	END;
	TYPE FocusInEvent* = FocusChangeEvent;
	TYPE FocusOutEvent* = FocusChangeEvent;

	(* generated on EnterWindow and FocusIn  when KeyMapState selected *)
	TYPE KeymapEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;
		keyVector* : ARRAY 32 OF CHAR;
	END;



	TYPE NoExposeEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		drawable* : X11.Drawable;
		majorCode* : WORD;		(* core is CopyArea or CopyPlane *)
		minorCode* : WORD;		(* not defined in the core *)
	END;

	TYPE VisibilityEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;
		state* : WORD;		(* Visibility state *)
	END;

	TYPE CreateWindowEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		parent* : X11.Window;		(* parent of the window *)
		window* : X11.Window;		(* window id of window created *)
		x*, y* : WORD;		(* window location *)
		width*, height* : WORD;	(* size of window *)
		borderWidth* : WORD;	(* border width *)
		overrideRedirect* : BOOLEAN;	(* creation should be overridden *)
	END;

	TYPE DestroyWindowEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
	END;

	TYPE UnmapEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
		fromConfigure* : BOOLEAN;
	END;

	TYPE MapEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
		overrideRedirect* : BOOLEAN;	(* boolean, is override set... *)
	END;

	TYPE MapRequestEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		parent* : X11.Window;
		window* : X11.Window;
	END;

	TYPE ReparentEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
		parent* : X11.Window;
		x*, y* : WORD;
		overrideRedirect* : BOOLEAN;
	END;


	TYPE GravityEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
		x*, y* : WORD;
	END;

	TYPE ResizeRequestEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;
		width*, height* : LONGWORD;
	END;

	TYPE ConfigureRequestEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		parent* : X11.Window;
		window* : X11.Window;
		x*, y* : WORD;
		width*, height* : WORD;
		borderWidth* : WORD;
		above* : X11.Window;
		detail* : WORD;		(* Above, Below, TopIf, BottomIf, Opposite *)
		valueMask* : LONGWORD(*unsigned*);
	END;

	TYPE CirculateEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		event* : X11.Window;
		window* : X11.Window;
		place* : WORD;		(* PlaceOnTop, PlaceOnBottom *)
	END;

	TYPE CirculateRequestEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		parent* : X11.Window;
		window* : X11.Window;
		place* : WORD;		(* PlaceOnTop, PlaceOnBottom *)
	END;

	TYPE PropertyEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;
		atom* : X11.Atom;
		time* : X11.Time;
		state* : WORD;		(* NewValue, Deleted *)
	END;

	TYPE SelectionClearEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;
		selection* : X11.Atom;
		time* : X11.Time;
	END;

	TYPE MappingEvent* = RECORD
		typ* : WORD;
		serial* : LONGWORD(*unsigned*);	(* # of last request processed by server *)
		sendEvent* : BOOLEAN;	(* true if this came from a SendEvent request *)
		display* : X11.DisplayPtr;	(* Display the event was read from *)
		window* : X11.Window;		(* unused *)
		request* : WORD;		(* one of MappingModifier, MappingKeyboard, MappingPointer *)
		firstKeycode* : WORD;	(* first keycode *)
		count* : WORD;		(* defines range of change w. firstKeycode*)
	END;




	(* ************************************************************** *)
	(*  GenericEvent.  This event is the standard event for all newer extensions. *)

	TYPE GenericEvent* = RECORD
		typ* : WORD;         (* of event. Always GenericEvent *)
		serial* : LONGWORD(*unsigned*);       (* # of last request processed *)
		sendEvent* : BOOLEAN;   (* true if from SendEvent request *)
		display* : X11.DisplayPtr;     (* Display the event was read from *)
		extension* : WORD;    (* major opcode of extension that caused the event *)
		evtype* : WORD;       (* actual event type. *)
	END;

	TYPE GenericEventCookie* = RECORD
		typ* : WORD;         (* of event. Always GenericEvent *)
		serial* : LONGWORD(*unsigned*);       (* # of last request processed *)
		sendEvent* : BOOLEAN;   (* true if from SendEvent request *)
		display* : X11.DisplayPtr;     (* Display the event was read from *)
		extension* : WORD;    (* major opcode of extension that caused the event *)
		evtype* : WORD;       (* actual event type. *)
		cookie* : WORD;
		data* : ADDRESS;
	END;


BEGIN

END X11Api.
