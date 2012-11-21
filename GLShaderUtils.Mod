MODULE GLShaderUtils; (** AUTHOR "fnecati"; PURPOSE "OpenGL GLSL utils "; *)

IMPORT
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, GLU, Files, Strings, Streams, KernelLog;

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
	GL.GetFloatv(GLC.GL_PROJECTION_MATRIX, SYSTEM.ADR(v[0]));
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
	GL.GetFloatv(GLC.GL_MODELVIEW_MATRIX, SYSTEM.ADR(v[0]));
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

PROCEDURE PrintShaderSource*(obj: GL.Uint);
VAR sourceLength, sslength: LONGINT;
	ssource: PChar;
BEGIN
	GL.GetShaderiv(obj, GLC.GL_SHADER_SOURCE_LENGTH, SYSTEM.ADR(sourceLength));
	wr.Int(obj, 0);  wr.String(" sourceLength= "); wr.Int(sourceLength, 0); wr.Ln;
	NEW(ssource, sourceLength);
	GL.GetShaderSource(obj, sourceLength, sslength, SYSTEM.ADR(ssource^[0]));
	wr.String("************** SOURCE *********************************"); wr.Ln;
	wr.String(ssource^); wr.Ln;
	wr.String("*******************************************************"); wr.Ln; wr.Update;
END PrintShaderSource;

PROCEDURE PrintOpenGLError*(CONST title: ARRAY OF CHAR);
VAR glErr: GL.Enum;
	str: Strings.String;
BEGIN
	glErr := GL.GetError();
	WHILE glErr # GLC.GL_NO_ERROR DO
		str := GLU.ErrorString(glErr);
		wr.String(title);  wr.String(" glError: "); wr.String(str^); wr.Ln; wr.Update;
		glErr := GL.GetError();
	END;
END PrintOpenGLError;

PROCEDURE PrintShaderInfoLog*(obj: GL.Uint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("sinfo-1: "); (* Check for OpenGL errors *)

	GL.GetShaderiv(obj, GLC.GL_INFO_LOG_LENGTH, SYSTEM.ADR(infologLength));
	PrintOpenGLError("sinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		GL.GetShaderInfoLog(obj, infologLength, charsWritten, SYSTEM.ADR(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintShaderInfoLog;

PROCEDURE PrintProgramInfoLog*(obj: GL.Uint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("pinfo-1: "); (* Check for OpenGL errors *)
	GL.GetProgramiv(obj, GLC.GL_INFO_LOG_LENGTH, SYSTEM.ADR(infologLength));

	PrintOpenGLError("pinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		GL.GetProgramInfoLog(obj, infologLength, charsWritten, SYSTEM.ADR(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintProgramInfoLog;

PROCEDURE LoadShaders*( VAR vertshader, fragshader: PChar;  VAR prog: GL.Uint): BOOLEAN;
VAR
	vs, fs: GL.Uint;                       (* handles for shaders *)
	vertcompiled, fragcompiled: GL.Int;  (* status values *)
	linked: GL.Int;
BEGIN
	(* Create shaders *)
	vs := GL.CreateShader(GLC.GL_VERTEX_SHADER);
	fs := GL.CreateShader(GLC.GL_FRAGMENT_SHADER);

	(* Load source code strings into shaders *)
	GL.ShaderSource(vs, 1, SYSTEM.ADR(vertshader), 0);
	GL.ShaderSource(fs, 1, SYSTEM.ADR(fragshader), 0);

	(* Compile the vertex shader and print out the compiler log *)
	GL.CompileShader(vs);
	GL.GetShaderiv(vs, GLC.GL_COMPILE_STATUS, SYSTEM.ADR(vertcompiled));
	IF vertcompiled = GLC.GL_FALSE THEN
			KernelLog.String("ERROR: vertex shader is not compiled "); KernelLog.Ln;
			PrintShaderInfoLog(vs);
			GL.DeleteShader(vs);
			RETURN FALSE;
	END;

	(* PrintShaderSource(vs); *)

	 (* Compile the fragment shader and print out the compiler log *)
	GL.CompileShader(fs);
	GL.GetShaderiv(fs, GLC.GL_COMPILE_STATUS, SYSTEM.ADR(fragcompiled));
	IF fragcompiled = GLC.GL_FALSE THEN
		KernelLog.String("ERROR: fragment shader is not compiled "); KernelLog.Ln;
		PrintShaderInfoLog(fs);
		GL.DeleteShader(fs);
		RETURN FALSE;
	END;

	(* PrintShaderSource(fs);*)

	(* Create a program and attach the two compiled shaders *)
	prog := GL.CreateProgram();
	GL.AttachShader(prog, vs);
	GL.AttachShader(prog, fs);

	(* Link the program *)
	GL.LinkProgram(prog);
	GL.GetProgramiv(prog, GLC.GL_LINK_STATUS, SYSTEM.ADR(linked));
	IF  linked = GLC.GL_FALSE THEN
		KernelLog.String("ERROR: program is not linked"); KernelLog.Ln;
		RETURN FALSE
	END;
	RETURN TRUE
END LoadShaders;

BEGIN
	Streams.OpenWriter(wr, KernelLog.Send);
END GLShaderUtils.
