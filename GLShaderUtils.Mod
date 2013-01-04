MODULE GLShaderUtils; (** AUTHOR "fnecati"; PURPOSE "OpenGL GLSL utils "; *)

IMPORT
	SYSTEM, gl := OpenGL, glc := OpenGLConst, glu := GLU, Files, Strings, Streams, KernelLog;

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
	gl.GetFloatv(glc.GL_PROJECTION_MATRIX, ADDRESSOF(v[0]));
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
	gl.GetFloatv(glc.GL_MODELVIEW_MATRIX, ADDRESSOF(v[0]));
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

	 RETURN SYSTEM.VAL(PChar, ADDRESSOF(str[0]));
END TextFileRead;

PROCEDURE PrintShaderSource*(obj: gl.Uint);
VAR sourceLength, sslength: LONGINT;
	ssource: PChar;
BEGIN
	gl.GetShaderiv(obj, glc.GL_SHADER_SOURCE_LENGTH, ADDRESSOF(sourceLength));
	wr.Int(obj, 0);  wr.String(" sourceLength= "); wr.Int(sourceLength, 0); wr.Ln;
	NEW(ssource, sourceLength);
	gl.GetShaderSource(obj, sourceLength, sslength, ADDRESSOF(ssource^[0]));
	wr.String("************** SOURCE *********************************"); wr.Ln;
	wr.String(ssource^); wr.Ln;
	wr.String("*******************************************************"); wr.Ln; wr.Update;
END PrintShaderSource;

PROCEDURE PrintOpenGLError*(CONST title: ARRAY OF CHAR);
VAR glErr: gl.Enum;
	str: Strings.String;
BEGIN
	glErr := gl.GetError();
	WHILE glErr # glc.GL_NO_ERROR DO
		str := glu.ErrorString(glErr);
		wr.String(title);  wr.String(" glError: "); wr.String(str^); wr.Ln; wr.Update;
		glErr := gl.GetError();
	END;
END PrintOpenGLError;

PROCEDURE PrintShaderInfoLog*(obj: gl.Uint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("sinfo-1: "); (* Check for OpenGL errors *)

	gl.GetShaderiv(obj, glc.GL_INFO_LOG_LENGTH, ADDRESSOF(infologLength));
	PrintOpenGLError("sinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		gl.GetShaderInfoLog(obj, infologLength, charsWritten, ADDRESSOF(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintShaderInfoLog;

PROCEDURE PrintProgramInfoLog*(obj: gl.Uint);
VAR infologLength, charsWritten: LONGINT;
	infoLog: PChar;
BEGIN
	infologLength := 0;
	charsWritten  := 0;
	PrintOpenGLError("pinfo-1: "); (* Check for OpenGL errors *)
	gl.GetProgramiv(obj, glc.GL_INFO_LOG_LENGTH, ADDRESSOF(infologLength));

	PrintOpenGLError("pinfo-2: "); (* Check for OpenGL errors *)

	IF infologLength > 0 THEN
		NEW(infoLog, infologLength);
		gl.GetProgramInfoLog(obj, infologLength, charsWritten, ADDRESSOF(infoLog[0]));
		wr.String(infoLog^); wr.Ln; wr.Update;
		infoLog := NIL;
	END;
END PrintProgramInfoLog;

PROCEDURE LoadTheseShaders*( VAR vertshader, fragshader: PChar;  VAR prog: gl.Uint): BOOLEAN;
VAR
	vs, fs: gl.Uint;                       (* handles for shaders *)
	vertcompiled, fragcompiled: gl.Int;  (* status values *)
	linked: gl.Int;
BEGIN
	(* Create shaders *)
	vs := gl.CreateShader(glc.GL_VERTEX_SHADER);
	fs := gl.CreateShader(glc.GL_FRAGMENT_SHADER);

	(* Load source code strings into shaders *)
	gl.ShaderSource(vs, 1, ADDRESSOF(vertshader), 0);
	gl.ShaderSource(fs, 1, ADDRESSOF(fragshader), 0);

	(* Compile the vertex shader and print out the compiler log *)
	gl.CompileShader(vs);
	gl.GetShaderiv(vs, glc.GL_COMPILE_STATUS, ADDRESSOF(vertcompiled));
	IF vertcompiled = glc.GL_FALSE THEN
			KernelLog.String("ERROR: vertex shader is not compiled "); KernelLog.Ln;
			PrintShaderInfoLog(vs);
			gl.DeleteShader(vs);
			RETURN FALSE;
	END;

	(* PrintShaderSource(vs); *)

	 (* Compile the fragment shader and print out the compiler log *)
	gl.CompileShader(fs);
	gl.GetShaderiv(fs, glc.GL_COMPILE_STATUS, ADDRESSOF(fragcompiled));
	IF fragcompiled = glc.GL_FALSE THEN
		KernelLog.String("ERROR: fragment shader is not compiled "); KernelLog.Ln;
		PrintShaderInfoLog(fs);
		gl.DeleteShader(fs);
		RETURN FALSE;
	END;

	(* PrintShaderSource(fs);*)

	(* Create a program and attach the two compiled shaders *)
	prog := gl.CreateProgram();
	gl.AttachShader(prog, vs);
	gl.AttachShader(prog, fs);

	(* Link the program *)
	gl.LinkProgram(prog);
	gl.GetProgramiv(prog, glc.GL_LINK_STATUS, ADDRESSOF(linked));
	IF  linked = glc.GL_FALSE THEN
		KernelLog.String("ERROR: program is not linked"); KernelLog.Ln;
		PrintProgramInfoLog(prog);
		gl.DeleteShader(fs);
		gl.DeleteShader(vs);
		RETURN FALSE
	END;
		gl.DeleteShader(fs);
		gl.DeleteShader(vs);	
	RETURN TRUE
END LoadTheseShaders;

PROCEDURE LoadShaders*( CONST vertshaderFile, fragshaderFile: ARRAY OF CHAR): gl.Uint;
VAR
	vss, fss: PChar; (* shader source pointers *)
	program: gl.Uint;
	ok: BOOLEAN;
BEGIN
	vss :=TextFileRead(vertshaderFile);
	IF vss = NIL THEN RETURN 0 END;
		
	fss :=TextFileRead(fragshaderFile);
	IF fss = NIL THEN RETURN 0 END;

	ok := LoadTheseShaders(vss, fss, program);
	IF ~ ok THEN program := 0 END;

	RETURN program
END LoadShaders;

BEGIN
	Streams.OpenWriter(wr, KernelLog.Send);
END GLShaderUtils.
