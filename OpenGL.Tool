OpenGL Framework for WinAos and LinuxAos Oberon

Compile Libraries:

LinuxAos:

Compiler.Compile OpenGLConst.Mod MyX11Api.Mod Unix.OpenGL.Mod  Unix.GLContext.Mod ~

WinAos:

Compiler.Compile OpenGLConst.Mod WinApi.Mod Win32.OpenGL.Mod  Win32.GLContext.Mod~


Compile Examples:

Compiler.Compile  
GLinfo.Mod GLTest.Mod 
MyXGear.Mod 
MyWMGLWindow.Mod
MyWMGLWindow2.Mod
MyWMGLWindow3.Mod
MyWMGLWindow4.Mod
MyWMGLWindow6.Mod
MyWMGLWindow7.Mod
MyWMGLWindow9.Mod
MyWMGLWindowFlags.Mod 
MyWMGLWindowLorenz.Mod 
MyWMGLPlotSurface.Mod ~

WinAos specific version of MyWMGLWindow7.Mod by tobj..@ .., thanks :
Compiler.Compile  Win32.MyWMGLWindow7b.Mod ~ 

How to use:

(* Import OpenGL, OpenGLConst and GLContext modules in your module *)

IMPORT 
     ... OpenGL, OpenGLConst, GLContext, ..., Raster, ..
     
(* Create an instance of GLContext.Context object, an Image object *)

VAR 
	context: GLContext.Context;
	image: Raster.Image;
	width, height: LONGINT;
	...
	
	width := 300; height := 300;
	
	(* create an image object using Raster module with RGBA8888 mode (32 bpp image *)
	NEW(image);
	Raster.Create(image, width, height, Raster.RGBA8888);
 	
 	NEW(context);
 
 	(* init the context; width, height, title, isvisible *)
 
 	context.Init(400, 400, "MyGLContext", FALSE);
 
 
 	(*
 	Since, creating a GL context needs a window, Init creates a dumy window on the underlying OS.
 	In WinAos a Win32 window  and in UnixAos a X11 window dumy windows are cretated to obtain 
 	a valid OpenGL context. So, these parametes are width and height of the window, title: title of window, 
 	isvisible: whether the created window is visible or not.
  
 	The last two parameter title and isvisble parameter for debuging purpose and maybe removed in the future versions.
	*) 


	(* before using any OpenGL commands acquire the OpenGL context *)

	context.MakeCurrent();
  
		 (* 
			... 
			your OpenGL commands 
			...
  		*)

	(* After finishing your commands, get the rendered image from OpenGL framebuffer (GPU) to the Image object (CPU) *)

 	 context.RenderInto(image);
  
	(* finally, release the OpenGL context *)
	
	context.DeActivate();
  
		...
  
 (* Whatever you like with image object. 
	You may store this image or show it in any WMWindowManager.Window object.
	Note that, OpenGL picture origin is lover-left corner, while Oberon image's origin
	top-left. context.RenderInto procedure flips the OpenGL image while reading pixel
	to Image object.
	
 *)
 
 
 By default, OpenGL 1.1 commands are loaded by the driver. If you would like to use higher extensions,
 1.2 .. 4.x,  use OpenGL.ReadExtensions after context.MakeCurrent().
 
 
 OpenGL driver uses different floating point exceptions while using floating point operations in
 coordinate transfomations, etc. These operations are in the driver side. So, these floating operations conflicts 
 with the Oberons' floating operations and may produce unpredictable results. In the OpenGL binding module, 
 SetFCR and DelFCR command may be used to set Floating Point Control Register and recover this problem just 
 before the these OpenGL commands and after respectively. See the provided examples for usage.
 
 
 While using OpenGL with WMWindowManager.Window care should be taken. The OpenGL contexts
 is process and thread sensitive. One context to one one thread. If more than one available, as in Active objects,
 after first thread acquires the OpenGL context using context.MakeCurrent the other thread can not access the 
 context untill previous thread release it (context.DeActivate).
  
  Nvidia, Ati, Intel, Mesa drivers may behave differently depending on extensions. The examples are tested on 
  Nvidia 8500GT GPU vith latest driver (Windows-XP32-SP3, Ubuntu 10.04 X64, Pardus-32bit-2011 with MESA) and not 
  all OpenGL functions are tested, there can be miss-definition in the OpenGL.Mod functions.
  

 All contributions and corrections are welcome ...
 


