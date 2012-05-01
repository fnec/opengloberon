MODULE OGLDemoFonts; (** AUTHOR "fnecati"; PURPOSE "simple demo for Fonts support in OpenGL using glBitmap"; *)
 (* uses A2 Fonts in OpenGL Window using glBitmaps *)

IMPORT
	Strings,  S := SYSTEM, KernelLog,  Streams,
	Raster, WMGraphics,
	GL := OpenGL, GLC := OpenGLConst, OGW:=OGLWindow;

CONST

	debug = FALSE;

VAR
	wr: Streams.Writer;

TYPE

	GLWindow* =  OBJECT(OGW.Window)
	VAR
		anglez: REAL;

		fontOffset: GL.GLuint;
		mode: Raster.Mode;
		font: WMGraphics.Font;

	PROCEDURE &New(w, h: LONGINT);
	BEGIN
		Init(w,h,100,100, FALSE);
		SetTitle("OGLFonts Demo");
		anglez := 0.0;
		Raster.InitMode(mode, Raster.srcCopy);
	END New;

	(* OGLWindow callback method *)
	PROCEDURE OnLoad();
	BEGIN
		GL.glShadeModel (GLC.GL_FLAT);
		MakeRasterFont();
		GL.glClearColor (0.0, 0.0, 0.0, 0.0); (*  clear the background and set it to black *)
	END OnLoad;

	PROCEDURE KeyEvent (ucs: LONGINT; flags: SET; keysym: LONGINT);
	BEGIN
		CASE CHR(ucs) OF
			 "-" : anglez := anglez - 1.0; ReDisplay();
			| "+" : anglez := anglez + 1.0; ReDisplay();
			| "p": (* PrintVals;*)

			| "q" : Close;
		ELSE

		END;
	END KeyEvent;

	PROCEDURE PrintGlyphInfo(code: LONGINT; g: WMGraphics.GlyphSpacings);
	BEGIN
		IF debug THEN
			IF (code>=20) & (code < 128) THEN
				wr.String("------"); wr.Char(CHR(code));  wr.String("------"); wr.Ln;
				wr.String("g.bearing.l= "); wr.Int(g.bearing.l, 0); wr.Ln;
				wr.String("g.bearing.t= "); wr.Int(g.bearing.t, 0); wr.Ln;
				wr.String("g.bearing.r= "); wr.Int(g.bearing.r, 0); wr.Ln;
				wr.String("g.bearing.b= "); wr.Int(g.bearing.b, 0); wr.Ln;
				wr.String("g.width= "); wr.Int(g.width, 0); wr.Ln;
				wr.String("g.height= "); wr.Int(g.height, 0); wr.Ln;
				wr.String("g.ascent= "); wr.Int(g.ascent, 0); wr.Ln;
				wr.String("g.descent= "); wr.Int(g.descent, 0); wr.Ln;
				wr.String("g.dx= "); wr.Int(g.dx, 0); wr.Ln;
				wr.String("g.dy= "); wr.Int(g.dy, 0); wr.Ln;
				wr.Update;
			END;
		END;
	END PrintGlyphInfo;

	(* transpose font Raster image to OpenGL font image *)
	PROCEDURE FlipImage(im: WMGraphics.Image): WMGraphics.Image;
	VAR i, j: LONGINT;
		tim: WMGraphics.Image;
		pix: Raster.Pixel;

	BEGIN
		NEW(tim);
		Raster.Create(tim, im.width, im.height, im.fmt);
		FOR j :=0 TO im.height-1 DO
			FOR i:=0 TO im.width-1 DO
			 	Raster.Get(im,i, j, pix, mode);
				Raster.Put(tim, im.width-i-1, im.height-j-1, pix, mode);
			END;
		END;
	 	RETURN tim;
	END FlipImage;

	PROCEDURE  MakeRasterFont;
	VAR i: LONGINT;
		fim, charimg: WMGraphics.Image;
		g: WMGraphics.GlyphSpacings;
	BEGIN
		(* font := WMGraphics.GetDefaultFont(); *)
		(* font := WMGraphics.GetFont("Arial", 12, {});*)
		 font := WMGraphics.GetFont("Courier", 12, {});
		GL.glPixelStorei(GLC.GL_UNPACK_ALIGNMENT, 1);

		GL.glRasterPos2i(0, 0);
		fontOffset := GL.glGenLists (256);

		FOR i := 0 TO 255 DO
			font.GetGlyphSpacings(i, g);
			(* PrintGlyphInfo(i,g); *)
			font.GetGlyphMap(i, charimg);
			IF debug THEN
				IF (i >=20) & (i < 128) THEN
					wr.String("charimg.width="); wr.Int(charimg.width,0); wr.Ln;
					wr.String("charimg.height="); wr.Int(charimg.height,0); wr.Ln;
				END;
			END;
			fim := FlipImage(charimg);

	   		GL.glNewList(fontOffset + i, GLC.GL_COMPILE);
			GL.SetFCR();
				GL.glBitmap(fim.width, fim.height, 0.0, 0.0, g.width +g.bearing.r (*+g.bearing.l*), 0.0,fim.adr);
			GL.DelFCR();
			GL.glEndList();
		END;

	END MakeRasterFont;

	PROCEDURE DrawString(s: ARRAY OF CHAR);
	BEGIN
		GL.glPushAttrib (GLC.GL_LIST_BIT);
		GL.glListBase(fontOffset);
		GL.glCallLists(Strings.Length(s), GLC.GL_UNSIGNED_BYTE, S.ADR(s[0]));
		GL.glPopAttrib ();
	END DrawString;

	PROCEDURE DrawStringAt(x, y, z: REAL;  s: ARRAY OF CHAR);
	BEGIN
		GL.glPushAttrib (GLC.GL_LIST_BIT);
		GL.glRasterPos3f(x, y, z);

		GL.glListBase(fontOffset);
		GL.glCallLists(Strings.Length(s), GLC.GL_UNSIGNED_BYTE, S.ADR(s[0]));
		GL.glPopAttrib ();
	END DrawStringAt;

	(* OGLWindow callback method *)
	PROCEDURE Reshape(w, h: LONGINT);
	VAR wx, hx: LONGREAL;
	BEGIN
		wx := w; hx := h;
		GL.glViewport(0, 0, w, h);
		GL.glMatrixMode(GLC.GL_PROJECTION);
		GL.glLoadIdentity();
		GL.SetFCR();
			GL.glOrtho (0.0, wx, 0.0, hx, -1.0, 1.0);
		GL.DelFCR();

		GL.glMatrixMode(GLC.GL_MODELVIEW);
		GL.glLoadIdentity();
	END Reshape;

	PROCEDURE DrawLetters;
	VAR dx, dy: LONGINT;
	BEGIN

		GL.glClear (GLC.GL_COLOR_BUFFER_BIT);
		GL.glPushMatrix();
		GL.SetFCR();
			GL.glRotatef(anglez, 0.0, 0.0, 1.0);
		GL.DelFCR();

		GL.glColor3f(1.0, 1.0, 1.0);

		GL.glRasterPos2i(20, 60);
			DrawString("THE QUICK BROWN FOX JUMPS");
		GL.glRasterPos2i(20, 40);
			DrawString("OVER A LAZY DOG");

		GL.glColor3f(0.0, 1.0, 0.0);

		font.GetStringSize("Hello OpenGL Oberon", dx, dy);
		GL.glRasterPos3f(width DIV 2-dx DIV 2, height DIV 2, 0.0);
		DrawString("Hello OpenGL Oberon");

	(*		GL.glRasterPos2f(-0.9, 0.5);
				DrawString("THE QUICK BROWN FOX JUMPS");
			GL.glRasterPos2f(-0.9, 0.0);
			DrawString("OVER A LAZY DOG");

			GL.glColor3f(0.0, 1.0, 0.0);
			GL.glRasterPos3f(-0.9, -0.5, -0.5);

			DrawString("Hello OpenGL Oberon");
	*)

		GL.glColor3f(1.0, 0.0, 0.0);
		GL.glBegin(GLC.GL_LINES);
			GL.glVertex2f(0.0,0.0);
			GL.glVertex2f(width, height);
		GL.glEnd();

		GL.glColor3f(1.0, 0.0, 1.0);
			DrawStringAt(20.0, 100.0, 0.2, "THE QUICK BROWN FOX JUMPS");

		GL.glPopMatrix();
	END DrawLetters;

	(* OGLWindow callback method *)
	PROCEDURE Display;
	BEGIN
		DrawLetters();
		SwapBuffers();
	END Display;

BEGIN
	MainLoop();
END GLWindow;

PROCEDURE Open*;
VAR
	window: GLWindow;
BEGIN
	NEW(window, 640, 480);
END Open;

BEGIN
	Streams.OpenWriter(wr, KernelLog.Send);
END OGLDemoFonts.

SystemTools.Free  OGLDemoFonts  OGLWindow~ ~

OGLDemoFonts.Open ~

