MODULE OGLWindowTest; (** AUTHOR "fnecati"; PURPOSE "OpenGL WindowManager ; *)

IMPORT
	 GL:=OpenGL, GLC := OpenGLConst, OGW := OGLWindow, Inputs,
	KernelLog, GLLib ;
	
TYPE
	MyGLControl = OBJECT(OGW.Window)
	VAR
		listenerPos, source0Pos, source1Pos,  source2Pos  : ARRAY [3] OF REAL;
		transdz: REAL;
				
	PROCEDURE &New(w, h: LONGINT );
	BEGIN
		Init(w,h,10,10, FALSE);
		listenerPos := [ 0.0, 0.0, 4.0];
		source0Pos := [ -2.0, 0.0, 0.0];
		source1Pos := [ 2.0, 0.0, 0.0];
		source2Pos := [ 0.0, 0.0, -4.0];
		transdz := -6.6;
		SetTitle("MyTest2");
		SetIdleTime(50)
	END New;

	(** *)
	PROCEDURE IdleDisplay*();
	VAR x: REAL;
	BEGIN
		x := listenerPos[0] + 0.1;
		IF x > 4.0 THEN x := -4.0; END;
		 listenerPos[0] :=x;
		 GL.DelFCR();
		 ReDisplay;
	END IdleDisplay;
	
	(** *)
	PROCEDURE Close*;
	BEGIN
		KernelLog.String("Closing.."); KernelLog.Ln; 
		Close^;
	END Close;
		
	PROCEDURE OnLoad*;
	BEGIN
		OnLoad^;		
	END OnLoad;
	

	PROCEDURE PointerMove* (x, y : LONGINT; keys : SET);
	BEGIN
(*		KernelLog.String("PointerMove: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerMove;

	PROCEDURE PointerDown* (x, y : LONGINT; keys : SET);
	BEGIN
(*		KernelLog.String("PointerDown: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerDown;

	PROCEDURE PointerUp* (x, y : LONGINT; keys : SET);
	BEGIN
		(* KernelLog.String("PointerUp: "); KernelLog.Int(x, 0); KernelLog.Int(y,4); KernelLog.String(" : "); KernelLog.Bits(keys, 0, 4);  KernelLog.Ln;*)
	END PointerUp;
	
	(** *)
	PROCEDURE WheelMove*(dz: LONGINT);
	BEGIN
		transdz := transdz + dz;
		Reshape(width, height);
		ReDisplay;
	END WheelMove;
	
	(** *)
	PROCEDURE KeyEvent* (ucs : LONGINT; flags : SET; keysym : LONGINT);
	BEGIN
		CASE CHR(ucs) OF
		 | "q": Close; 
		ELSE
		END;
			CASE keysym OF		
				Inputs.KsLeft: listenerPos[0] := listenerPos[0]- 0.1; GL.DelFCR(); ReDisplay
				| Inputs.KsRight: listenerPos[0] := listenerPos[0]+ 0.1; GL.DelFCR(); ReDisplay;
				| Inputs.KsUp: 	listenerPos[2] := listenerPos[2]- 0.1; GL.DelFCR(); Display;
				| Inputs.KsDown: listenerPos[2] := listenerPos[2]+ 0.1;GL.DelFCR();  Display;
		ELSE
		END;						 
	END KeyEvent ;
	
	
		PROCEDURE ChangePosititon*;
		VAR x: REAL;
		BEGIN
			x := listenerPos[0] + 0.1;
			IF x > 3.0 THEN x := -3.0; END;
			listenerPos[0] := x;
		END ChangePosititon;
		
			
		PROCEDURE Display; 
		BEGIN 
			GL.glClear(GLC.GL_COLOR_BUFFER_BIT + GLC.GL_DEPTH_BUFFER_BIT) ;
			GL.glPushMatrix() ;
				GL.glRotatef(20.0,1.0,1.0, 0.0) ;
	
				(* sources *)
				GL.glPushMatrix() ;
					GL.glTranslatef(source0Pos[0], source0Pos[1], source0Pos[2]) ;
					GL.glColor3f(1.0, 0.0, 0.0) ;
					GLLib.WireCube(0.5) ;
				GL.glPopMatrix() ;
	
				GL.glPushMatrix() ;
					GL.glTranslatef(source2Pos[0], source2Pos[1], source2Pos[2]) ;
					GL.glColor3f(0.0, 0.0,1.0) ;
					GLLib.WireCube(0.5) ;
				GL.glPopMatrix() ;
	
				GL.glPushMatrix() ;
					GL.glTranslatef(source1Pos[0], source0Pos[1], source0Pos[2]) ;
					GL.glColor3f(0.0,1.0, 0.0) ;
					GLLib.WireCube(0.5) ;
				GL.glPopMatrix() ;
	
				(* the listener *)
				GL.glPushMatrix() ;
					GL.glTranslatef(listenerPos[0], listenerPos[1], listenerPos[2]) ;
 					GL.glColor3f(1.0,1.0, 1.0);
					GLLib.WireCube(0.5) ;
				GL.glPopMatrix() ;
			GL.glPopMatrix() ;
			SwapBuffers();
			
		END Display; 


		PROCEDURE Reshape(w, h: LONGINT);
		VAR ratio: LONGREAL;
		BEGIN 
			ratio := w / h;	
			GL.glViewport(0, 0, w, h) ;
			GL.glClearColor(0.0, 0.0 ,0.0, 1.0) ;

			GL.glMatrixMode(GLC.GL_PROJECTION) ;
			GL.glLoadIdentity() ; 
			GL.SetFCR();
				GL.gluPerspective(60.0,ratio,1.0,30.0) ;
			GL.DelFCR(); 	
			
			GL.glMatrixMode(GLC.GL_MODELVIEW) ; 
			GL.glLoadIdentity() ;
			GL.SetFCR();
				GL.glTranslatef(0.0,0.0, transdz) ;
   			GL.DelFCR();
		END Reshape;


	BEGIN
	END MyGLControl;

PROCEDURE Open*;
VAR 
	mywin: MyGLControl;
BEGIN
	NEW(mywin, 300,300);
END Open;

BEGIN	
END OGLWindowTest.

OGLWindowTest.Open~

SystemTools.Free OGLWindowTest OGLWindow~ 