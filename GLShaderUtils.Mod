MODULE GLShaderUtils; (** AUTHOR "fnecati"; PURPOSE "OpenGL GLSL utils "; *)

IMPORT
	SYSTEM, GL := OpenGL, GLC := OpenGLConst, Files, Strings, KernelLog;

TYPE PChar* = POINTER TO ARRAY OF CHAR;

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
(*	KernelLog.String(str^); KernelLog.Ln; *)
	
	 RETURN SYSTEM.VAL(PChar, SYSTEM.ADR(str[0]));
	
END TextFileRead;

PROCEDURE PrintShaderSource*(obj: GL.GLuint);
VAR sourceLength, sslength: LONGINT;
	ssource: PChar;
BEGIN
	 GL.glGetShaderiv(obj, GLC.GL_SHADER_SOURCE_LENGTH, SYSTEM.ADR(sourceLength));
    KernelLog.Int(obj, 0);  KernelLog.String(" sourceLength= "); KernelLog.Int(sourceLength, 0); KernelLog.Ln; 
    NEW(ssource, sourceLength);
    GL.glGetShaderSource(obj, sourceLength, sslength, SYSTEM.ADR(ssource^[0]));
    KernelLog.String("************** SOURCE *********************************"); KernelLog.Ln; 
    KernelLog.String(ssource^); KernelLog.Ln; 
   KernelLog.String("*******************************************************"); KernelLog.Ln; 
END PrintShaderSource;

PROCEDURE PrintOpenGLError*(CONST title: ARRAY OF CHAR);
VAR glErr: GL.GLenum;
	  str: Strings.String;
BEGIN 
    glErr := GL.glGetError();
    WHILE glErr # GLC.GL_NO_ERROR DO
    	   str := GL.GLUErrorString(glErr);	
        KernelLog.String(title);  KernelLog.String(" glError: "); KernelLog.String(str^); KernelLog.Ln; 
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
        KernelLog.String(infoLog^); KernelLog.Ln; 
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
        KernelLog.String(infoLog^); KernelLog.Ln; 
        infoLog := NIL;
    END;
END PrintProgramInfoLog;
	

PROCEDURE LoadShaders*( vertshader, fragshader: PChar;  VAR prog: GL.GLuint): BOOLEAN;
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

  (* Compile the fragment shader and print out the compiler log *)
  GL.glCompileShader(fs);
  GL.glGetShaderiv(fs, GLC.GL_COMPILE_STATUS, SYSTEM.ADR(fragcompiled));
  PrintShaderInfoLog(fs);

  IF (vertcompiled = GLC.GL_FALSE) OR  (fragcompiled = GLC.GL_FALSE) THEN RETURN FALSE; END; 
   

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


END GLShaderUtils.
