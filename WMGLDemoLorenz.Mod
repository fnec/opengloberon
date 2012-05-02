MODULE WMGLDemoLorenz; (** AUTHOR "fnecati"; PURPOSE "opengl Lorenz Strange Attractor demo"; *)

(* Adapted from freeglut examples:

 * Lorenz Strange Attractor
 *
 * Written by John F. Fay in honor of the "freeglut" 2.0.0 release in July 2003
 *
 * What it does:
 *  This program starts with two particles right next to each other.  The particles
 *  move through a three-dimensional phase space governed by the following equations:
 *       dx/dt = sigma * ( y - x )
 *       dy/dt = r * x - y + x * z
 *       dz/dt = x * y + b * z
 *  These are the Lorenz equations and define the "Lorenz Attractor."  Any two particles
 *  arbitrarily close together will move apart as time increases, but their tracks are
 *  confined within a region of the space.
 *
 * Commands:
 *  Arrow keys:  Rotate the view
 *  PgUp, PgDn:  Zoom in and out

 *
 *  'r'/'R':  Reset the simulation
 *  'a'/'A':  Animate
 * '-' / '+' : decrease, increase simulation time between time steps
 *  <spacebar>:  Single-step advancement in time
 *  'q':  Quit
 * 's' save window image
 *)

IMPORT
	WMRectangles, WMGraphics, Strings, Kernel, Random, MathL,
	WM := WMWindowManager,  WMDialogs, Inputs, WMMessages,
	GL := OpenGL, GLC := OpenGLConst, WMGL := WMGLWindow, SYSTEM;


CONST

	(* Number of points to draw in the curves *)
	NUM_POINTS  =  512;

	(* Angle to rotate when the user presses an arrow key *)
	ROTATION_ANGLE = 5.0;

	(* Amount to scale bu when the user presses PgUp or PgDn *)
	SCALE_FACTOR = 0.8;

TYPE
	Vector3 = ARRAY 3 OF LONGREAL;
	Positions = POINTER TO ARRAY NUM_POINTS OF Vector3;


TYPE
	KillerMsg = OBJECT
	END KillerMsg;

	GLWindow* =  OBJECT(WMGL.Window)
	VAR
		timer: Kernel.MilliTimer;
		waittime: LONGINT; (* between animation time *)
		alive,  animated: BOOLEAN;

		red_position: Positions ;          (* Path of the red point *)
		grn_position: Positions ;          (* Path of the green point *)
		array_index: LONGINT ;                             (* Position in *_position arrays of most recent point *)
		distance: LONGREAL ;                       (* Distance between the two points *)

		(* GLUT variables *)
		yaw, pit: LONGREAL ;                 (* Euler angles of the viewing rotation *)
		scale: LONGREAL;                          (* Scale factor *)
		xcen, ycen, zcen: LONGREAL ;   (* Coordinates of the point looked at *)

		animate: LONGINT; ;                             (* 0 - stop, 1 = go, 2 = single-step *)

		(* Lorenz Attractor variables *)
		s0, r0, b0 : LONGREAL ;   (* Default Lorenz attactor parameters *)
		time_step : LONGREAL ;                     (* Time step in the simulation *)
		sigma, r, b: LONGREAL ;  (* Lorenz attactor parameters *)

		distancestr: ARRAY 64 OF CHAR; (* to display distance on the window *);

	PROCEDURE &New(w, h: LONGINT);
	BEGIN
		Init(w, h, FALSE); (* use alpha, for 32bpp img *)
		WM.AddWindow(SELF, 100, 100);

		SetTitle(Strings.NewString("WMGLDemoLorenz: Lorenz Attractor "));

		animated := FALSE;
		waittime := 60;

		canvas.SetFont(canvas.GetFont());
		array_index:= 0;
		initGL;
		Reshape(w, h);
		UpdateImage;
		alive := TRUE;
	END New;

	PROCEDURE ResetPositions;
	VAR i: LONGINT;
	BEGIN
		(* Reset the Lorenz parameters *)
		sigma := s0 ;  b := b0 ;  r := r0 ;
		(* Set an initial position *)
		red_position[0][0] := random.Uniform();
		red_position[0][1] := random.Uniform();
		red_position[0][2] := random.Uniform();
		grn_position[0][0] := random.Uniform();
		grn_position[0][1] := random.Uniform();
		grn_position[0][2] := random.Uniform();
		array_index := 0 ;
		(* Initialize the arrays *)
		FOR i := 1 TO NUM_POINTS-1 DO
			red_position[i] := red_position[0];
			grn_position[i] := grn_position[0];
		END;

	END ResetPositions;

	PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
	BEGIN
		CASE CHR(ucs) OF
			"a" :	animated := ~ animated;  IF animated THEN animate := 1; ELSE animate := 0 END;
					GL.DelFCR();  UpdateImage;
			| "-" :	DEC(waittime,5); IF waittime < 10 THEN waittime := 10; END;
			| "+" :	INC(waittime,5); IF waittime>1000 THEN waittime := 1000; END;
			| "r" :	ResetPositions; UpdateImage;
			| " " : 	animate := 2; GL.DelFCR(); UpdateImage;
			| "s":	SaveImage;
			| "q" :	Close;
		ELSE

			IF  keysym = Inputs.KsLeft  THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glRotated ( ROTATION_ANGLE, 0.0, 0.0, 1.0 );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSIF keysym = Inputs.KsRight THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glRotated ( -ROTATION_ANGLE, 0.0, 0.0, 1.0 );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSIF keysym = Inputs.KsDown THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glRotated ( -ROTATION_ANGLE, 0.0, 1.0, 0.0 );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSIF keysym = Inputs.KsUp THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glRotated ( ROTATION_ANGLE, 0.0, 1.0, 0.0 );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSIF keysym = Inputs.KsPageDown THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glScaled ( SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSIF keysym = Inputs.KsPageUp THEN
				context.MakeCurrent();
				GL.SetFCR();
				GL.glScaled ( 1.0 / SCALE_FACTOR, 1.0 / SCALE_FACTOR, 1.0 / SCALE_FACTOR );
				GL.DelFCR();
				context.DeActivate();
				UpdateImage;
			ELSE
			END;

		END;
	END KeyEvent;

	PROCEDURE Close*;
	BEGIN {EXCLUSIVE}
		alive := FALSE;
		Close^;
	END Close;

	PROCEDURE Handle(VAR m: WMMessages.Message);
	BEGIN
		IF (m.msgType = WMMessages.MsgExt) & (m.ext # NIL) & (m.ext IS KillerMsg) THEN
			Close;
		ELSE Handle^(m)
		END
	END Handle;

	PROCEDURE UpdateImage;
	BEGIN
		context.MakeCurrent();
			Display;
			 TimerCB;
		context.RenderInto(backImg);
		context.DeActivate();

		canvas.SetColor(WMGraphics.White);
		canvas.DrawString(10,15, distancestr);
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

	PROCEDURE initGL;
	BEGIN
		s0 := 10.0; r0 := 28.0; b0 := 8.0/3.0 ;
		time_step := 0.03;
		sigma := 10.0; r := 28.0; b := 8.0/3.0 ;
		distance := 0.0 ;

		yaw := 0.0; pit := 0.0;
		scale := 1.0 ;
		xcen := 0.0; ycen := 0.0; zcen := 0.0 ;

		animate := 1 ;
		NEW(red_position); NEW(grn_position);
		ResetPositions;

		context.MakeCurrent;
		(* Set up the OpenGL parameters *)
		GL.glEnable ( GLC.GL_DEPTH_TEST ) ;
		GL.glClearColor ( 0.0, 0.0, 0.0, 0.0 ) ;
		GL.glClearDepth ( 1.0 ) ;
		context.DeActivate;
	END initGL;

	PROCEDURE DrawCurve (index: LONGINT; CONST position: Positions);
	VAR i: LONGINT;
	BEGIN
		i := index;
		GL.glBegin (GLC.GL_LINE_STRIP) ;

		REPEAT
			IF i = NUM_POINTS-1 THEN i := 0 ELSE i := i + 1 END;
			 GL.glVertex3dv ( SYSTEM.ADR(position[i]) ) ;
		 UNTIL ( i = index ) ;

		GL.glEnd () ;
	END DrawCurve;

	PROCEDURE Display;
	BEGIN
		GL.glClear ( GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT );

		(* Draw some axes *)
		GL.glBegin ( GLC.GL_LINES ) ;
		GL.glColor3f ( 0.0, 0.0, 1.0 ) ;  (* blue *)
		GL.glVertex3d ( 0.0, 0.0, 0.0 ) ;
		GL.glVertex3d ( 2.0, 0.0, 0.0 ) ; (* x- axis *)

		GL.glColor3f ( 1.0, 1.0, 0.0 ) ;  (* yellow *)
		GL.glVertex3d ( 0.0, 0.0, 0.0 ) ;
		GL.glVertex3d ( 0.0, 1.0, 0.0 ) ; (* y- axis *)

		GL.glColor3f (0.0, 1.0, 1.0 ) ;  (* cyan *)
		GL.glVertex3d ( 0.0, 0.0, 0.0 ) ;
		GL.glVertex3d ( 0.0, 0.0, 1.0 ) ; (* z- axis *)
	 	GL.glEnd ();

	 	GL.glColor3d ( 1.0, 0.0, 0.0 ) ;  (* Red *)
	 	DrawCurve ( array_index, red_position ) ;

	 	GL.glColor3d ( 0.0, 1.0, 0.0 ) ;  (* Green *)
	 	DrawCurve ( array_index, grn_position ) ;
	END Display;

	PROCEDURE Reshape(w, h: LONGINT);
	BEGIN
		context.MakeCurrent();
		GL.glViewport(0, 0, w, h);
		(* Set up the OpenGL parameters *)
		GL.glEnable ( GLC.GL_DEPTH_TEST ) ;
		GL.glClearColor ( 0.0, 0.0, 0.0, 0.0 ) ;
		GL.glClearDepth ( 1.0 ) ;

		GL.glMatrixMode ( GLC.GL_PROJECTION ) ;
		GL.glLoadIdentity ();
		GL.SetFCR();
			GL.glFrustum ( -1.0, 1.0, -1.0, 1.0, 10.0, 100.0 ) ;
		GL.DelFCR();

		xcen := 0.0; ycen := 0.0; zcen := 0.0;

		GL.glMatrixMode ( GLC.GL_MODELVIEW ) ;
		GL.glLoadIdentity () ;
		GL.SetFCR();
			GL.glTranslated ( 0.0, 0.0, zcen-40.0 ) ;
		GL.DelFCR();

	context.DeActivate;
	END Reshape;

	PROCEDURE TimerCB;
	VAR
		deltax, deltay, deltaz: LONGREAL;
		new_index: LONGINT;
		str: ARRAY 64 OF CHAR;
	BEGIN
		(* Function called at regular intervals to update the positions of the points *)
		new_index := array_index + 1 ;

		(* Set the next timed callback *)
		IF  animate > 0  THEN
			IF  new_index = NUM_POINTS THEN new_index := 0  END;
			AdvanceInTime ( time_step, red_position[array_index], red_position[new_index] ) ;
			AdvanceInTime ( time_step, grn_position[array_index], grn_position[new_index] ) ;
			(*  WritePositions;*)
		 	array_index := new_index ;

			deltax := red_position[array_index][0] - grn_position[array_index][0] ;
			deltay := red_position[array_index][1] - grn_position[array_index][1] ;
			deltaz := red_position[array_index][2] - grn_position[array_index][2] ;
			distance := MathL.sqrt ( deltax * deltax + deltay * deltay + deltaz * deltaz ) ;

			distancestr :="Distance= ";
			Strings.FloatToStr(distance, 10,4,0, str);
			Strings.Append(distancestr, str);

			IF ( animate = 2 ) THEN animate := 0 END ;
		END;

	END TimerCB;

	(* ********** Functions ***************** *)

	(* The Lorenz Attractor *)
	PROCEDURE CalcDeriv ( VAR  position: Vector3; VAR deriv: Vector3);
	BEGIN
		(* Calculate the Lorenz attractor derivatives *)
	 	deriv[0] := sigma * ( position[1] - position[0] ) ;
	 	deriv[1] := ( r + position[2] ) * position[0] - position[1] ;
	 	deriv[2] := -position[0] * position[1] - b * position[2] ;
	END CalcDeriv;

	PROCEDURE AdvanceInTime (time_step: LONGREAL; VAR position: Vector3; VAR new_position: Vector3 );
	VAR i: LONGINT;
	       deriv0, deriv1, deriv2, deriv3: Vector3;
	BEGIN
		(* Move a point along the Lorenz attractor *)
		(* Save the present values *)
		new_position := position;
		(* First pass in a Fourth-Order Runge-Kutta integration method *)
		CalcDeriv ( position, deriv0 ) ;
		FOR i := 0 TO 2 DO
			new_position[i] := position[i] + 0.5 * time_step * deriv0[i] ;
		END;
		(* Second pass *)
		CalcDeriv ( new_position, deriv1 ) ;
		FOR i := 0 TO 2 DO
			new_position[i] := position[i] + 0.5 * time_step * deriv1[i] ;
		END;
		(* Third pass *)
		CalcDeriv ( position, deriv2 ) ;
		FOR i := 0 TO 2 DO
			new_position[i] := position[i] + time_step * deriv2[i] ;
		END;
		(* Second pass *)
		CalcDeriv ( new_position, deriv3 ) ;
		FOR i := 0 TO 2 DO
			new_position[i] := position[i] + 0.1666666666666666667 * time_step * ( deriv0[i] + 2.0 * ( deriv1[i] + deriv2[i] ) + deriv3[i] ) ;
		END;
	END AdvanceInTime;

BEGIN {ACTIVE}

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


VAR
	random: Random.Generator;

PROCEDURE Open*;
VAR
	window: GLWindow;
BEGIN
	NEW(window, 256, 256);
END Open;

BEGIN
	NEW(random);
	random.InitSeed(12345);
END WMGLDemoLorenz.

SystemTools.Free  WMGLDemoLorenz  WMGLWindow ~    OpenGL   OpenGLConst ~

WMGLDemoLorenz.Open ~

