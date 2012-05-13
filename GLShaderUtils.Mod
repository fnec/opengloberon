MODULE GLShaderUtils; (** AUTHOR "fnecati"; PURPOSE "OpenGL GLSL utils "; *)

IMPORT
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, Files, Strings, Streams, KernelLog;

TYPE
	PChar* = POINTER TO ARRAY OF CHAR;
	Vector16f = ARRAY 16 OF REAL; (* 4x4 GLfloat Matrix *)
VAR
	wr: Streams.Writer;

(* write projection matrix *)
PROCEDURE WriteProjMatrixf*(CONST title: ARRAY OF CHAR);
VAR i: LONGINT;
	v: Vector16f;
BEGIN
	GL.glGetFloatv(GLC.GL_PROJECTION_MATRIX, SYSTEM.ADR(v[0]));
	wr.String("-----------------"); wr.Ln;
	wr.String("Float PROJECTION_MATRIX: "); wr.String(title); wr.Ln;
	FOR i:=0 TO 15 DO
		wr.FloatFix(v[i], 10,4,0);
	END;
	wr.Ln; wr.Update;
END WriteProjMatrixf;

(* write modelview matrix *)
PROCEDURE WriteModelMatrixf*(CONST title: ARRAY OF CHAR);
VAR i : LONGINT;
	v: Vector16f;
BEGIN
	GL.glGetFloatv(GLC.GL_MODELVIEW_MATRIX, SYSTEM.ADR(v[0]));
	wr.String("-----------------"); wr.Ln;
	wr.String("Float GL_MODELVIEW_MATRIX: ");wr.String(title); wr.Ln;
	FOR i:=0 TO 15 DO
		wr.FloatFix(v[i], 10,4,0);
	END;
	wr.Ln; wr.Update;
END WriteModelMatrixf;

PROCEDURE TextFileRead*(CONST fname: ARRAY OF CHAR): PChar;
VAR
	f: Files.File; rider: Files.Rider;
	str: PChar; len: LONGINT;
BEGIN
	f := Files.Old(fname);
	IF f = NIL THEN RETURN NIL END;
	len := f.Length();

	NEW(str, len+1);
	f.Set(rider, 0);

	f.ReadBytes(rider, str^, 0, len);
(*	wr.String(str^); wr.Ln; wr.Update*)

	 RETURN SYSTEM.VAL(PChar, SYSTEM.ADR(str[0]));
END TextFileRead;

PROCEDURE PrintShaderSource*(obj: GL.GLuint);
VAR sourceLength, sslength: LONGINT;
	ssource: PChar;
BEGIN
	GL.glGetShaderiv(obj, GLC.GL_SHADER_SOURCE_LENGTH, SYSTEM.ADR(sourceLength));
	wr.Int(obj, 0);  wr.String(" sourceLength= "); wr.Int(sourceLength, 0); wr.Ln;
	NEW(ssource, sourceLength);
	GL.glGetShaderSource(obj, sourceLength, sslength, SYSTEM.ADR(ssource^[0]));
	wr.String("************** SOURCE *********************************"); wr.Ln;
	wr.String(ssource^); wr.Ln;
	wr.String("*******************************************************"); wr.Ln; wr.Update;
END PrintShaderSource;

PROCEDURE PrintOpenGLError*(CONST title: ARRAY OF CHAR);
VAR glErr: GL.GLenum;
	str: Strings.String;
BEGIN
	glErr := GL.glGetError();
	WHILE glErr # GLC.GL_NO_ERROR DO
		str := GL.GLUErrorString(glErr);
		wr.String(title);  wr.String(" glError: "); wr.String(str^); wr.Ln; wr.Update;
		glErr := GL.glGetError();
	END;
END PrintOpenGLError;

PROCEDURE PrintShaderInfoLog*(obj: GL.GLuint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("sinfo-1: "); (* Check for OpenGL errors *)
	
	GL.glGetShaderiv(obj, GLC.GL_INFO_LOG_LENGTH, SYSTEM.ADR(infologLength));
	PrintOpenGLError("sinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		GL.glGetShaderInfoLog(obj, infologLength, charsWritten, SYSTEM.ADR(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintShaderInfoLog;

PROCEDURE PrintProgramInfoLog*(obj: GL.GLuint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("pinfo-1: "); (* Check for OpenGL errors *)
	GL.glGetProgramiv(obj, GLC.GL_INFO_LOG_LENGTH, SYSTEM.ADR(infologLength));

	PrintOpenGLError("pinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		GL.glGetProgramInfoLog(obj, infologLength, charsWritten, SYSTEM.ADR(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintProgramInfoLog;

PROCEDURE LoadShaders*( VAR vertshader, fragshader: PChar;  VAR prog: GL.GLuint): BOOLEAN;
VAR
	vs, fs: GL.GLuint;                       (* handles for shaders *)
	vertcompiled, fragcompiled: GL.GLint;  (* status values *)
	linked: GL.GLint;
BEGIN
	(* Create shaders *)
	vs := GL.glCreateShader(GLC.GL_VERTEX_SHADER);
	fs := GL.glCreateShader(GLC.GL_FRAGMENT_SHADER);

	(* Load source code strings into shaders *)
	GL.glShaderSource(vs, 1, SYSTEM.ADR(vertshader), 0);
	GL.glShaderSource(fs, 1, SYSTEM.ADR(fragshader), 0);

	(* Compile the vertex shader and print out the compiler log *)
	GL.glCompileShader(vs);
	GL.glGetShaderiv(vs, GLC.GL_COMPILE_STATUS, SYSTEM.ADR(vertcompiled));
	PrintShaderInfoLog(vs);
	(* PrintShaderSource(vs); *)

	 (* Compile the fragment shader and print out the compiler log *)
	GL.glCompileShader(fs);
	GL.glGetShaderiv(fs, GLC.GL_COMPILE_STATUS, SYSTEM.ADR(fragcompiled));
	PrintShaderInfoLog(fs);
	(*PrintShaderSource(fs);*)
	IF (vertcompiled = GLC.GL_FALSE) OR  (fragcompiled = GLC.GL_FALSE) THEN
		GL.glDeleteShader(vs);
		GL.glDeleteShader(fs);
		RETURN FALSE; 
	END;

	(* Create a program and attach the two compiled shaders *)
	prog := GL.glCreateProgram();
	GL.glAttachShader(prog, vs);
	GL.glAttachShader(prog, fs);

	(* Link the program *)
	GL.glLinkProgram(prog);
	GL.glGetProgramiv(prog, GLC.GL_LINK_STATUS, SYSTEM.ADR(linked));
	IF  linked = GLC.GL_FALSE THEN RETURN FALSE END;
	RETURN TRUE
END LoadShaders;

BEGIN
	Streams.OpenWriter(wr, KernelLog.Send);
END GLShaderUtils.
