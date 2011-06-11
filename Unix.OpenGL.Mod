MODULE OpenGL; (** AUTHOR "fnecati"; PURPOSE "OpenGL binding for UnixAos"; *)

IMPORT SYSTEM, Unix, Modules, MyX11Api, Strings, GLC := OpenGLConst, Trace;

(* Compiler.Compile  Unix.OpenGL.Mod~ 
Compiler.Compile OpenGLConst.Mod MyX11Api.Mod Unix.OpenGL.Mod Unix.GLContext.Mod ~
*)


(*
==============================================================================
      OpenGL 4.1 - Headertranslation
       Version 4.1a
       Works with :   LinuxAos
{==============================================================================}

       Containts the translations of glext.h, gl_1_1.h, glu.h and weglext.h. 
       It also contains some helperfunctions that were inspired by those
       found in Mike Lischke's OpenGL12.pas.

       Copyright (C) DGL-OpenGL2-Portteam
       All Rights Reserved

       Obtained through:
       Delphi OpenGL Community(DGL) - www.delphigl.com
                                                                              }
       Converted and maintained by DGL's GL2.0-Team :
         - Sascha Willems                - http://www.delphigl.de
         - Steffen Xonna (Lossy eX)      - http://www.dev-center.de
         - Lars Middendorf               - http://www.3d-seite.de
       Additional input :
         - Martin Waldegger (Mars)       - http://www.basegraph.com
         - Benjamin Rosseaux (BeRo)      - http://www.0ok.de
       Additional thanks:
           sigsegv (libdl.so)

==============================================================================
 You may retrieve the latest version of this file at the Delphi OpenGL
 Community home page, located at http://www.delphigl.com/

 The contents of this file are used with permission, subject to
 the Mozilla Public License Version 1.1 (the "License"); you may
 not use this file except in compliance with the License. You may
 obtain a copy of the License at
 http://www.mozilla.org/MPL/MPL-1.1.html

 Software distributed under the License is distributed on an
 "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 implied. See the License for the specific language governing
 rights and limitations under the License.
 
*)


VAR
	 (* handle to library *)
 	GL_LibHandle-: LONGINT;
	GLU_LibHandle-:LONGINT;
	oldfcr-, newfcr-: SET;
		
CONST 
  
   GL_LibName = 'libGL.so'; 
    GLU_LibName = 'libGLU.so';


TYPE

  ADDRESS * = SYSTEM.ADDRESS;
  AnsiChar* = POINTER TO ARRAY OF CHAR;	
  PAnsiChar * = POINTER TO ARRAY OF AnsiChar;
  THandle * = LONGINT;
  TXID* = LONGINT;

  Pointer * = ADDRESS;
  Integer * = LONGINT;
  Cardinal * = LONGINT;
  Int64 * = HUGEINT;
  
  PInteger * = POINTER TO ARRAY OF  Integer;
  PPointer * = ADDRESS;
  PCardinal * = ADDRESS;
  WORD * = INTEGER;
  DWORD * = LONGINT;
  
  GLenum * = LONGINT;
  GLboolean * = LONGINT;
  GLbitfield * = SET; (*LONGINT;*)
  GLbyte * = INTEGER;
  GLshort * = INTEGER;
  GLint * = LONGINT;
  GLsizei * = LONGINT;
  GLubyte * = CHAR;
  GLushort * = INTEGER;
  GLuint * = LONGINT;
  GLfloat * = REAL;
  GLclampf * = REAL;
  GLdouble * = LONGREAL;
  GLclampd * = LONGREAL;
  GLvoid * = LONGINT;
  GLint64 * = HUGEINT;
  GLuint64 * = HUGEINT;

  TGLenum * = GLenum;
  TGLboolean * = GLboolean;
  TGLbitfield * = GLbitfield;
  TGLbyte * = GLbyte;
  TGLshort * = GLshort;
  TGLint * = GLint;
  TGLsizei * = GLsizei;
  TGLubyte * = GLubyte;
  TGLushort * = GLushort;
  TGLuint * = GLuint;
  TGLfloat * = GLfloat;
  TGLclampf * = GLclampf;
  TGLdouble * = GLdouble;
  TGLclampd * = GLclampd;
  TGLvoid * = GLvoid;
  TGLint64 * = GLint64;
  TGLuint64 * = GLuint64;

 PGLboolean * = ADDRESS; (*POINTER TO ARRAY OF GLboolean;*)
  PGLbyte * = ADDRESS; (*POINTER TO ARRAY OF GLbyte;*)
  PGLshort * = ADDRESS; (*POINTER TO ARRAY OF GLshort;*)
  PGLint * =  ADDRESS; (* POINTER TO ARRAY OF GLint; *)
  PGLsizei * = ADDRESS; (*POINTER TO ARRAY OF GLsizei;*)
  PGLubyte * = ADDRESS; (*POINTER TO ARRAY OF GLubyte;*)
  PGLushort * = ADDRESS; (*POINTER TO ARRAY OF GLushort;*)
  PGLuint * = ADDRESS; (*POINTER TO ARRAY OF GLuint;*)
  PGLclampf * = ADDRESS; (*POINTER TO ARRAY OF GLclampf;*)
  PGLfloat * =  ADDRESS; (*POINTER TO ARRAY OF GLfloat; *)
  PGLdouble * = ADDRESS; (* POINTER TO ARRAY OF GLdouble;*)
  PGLclampd * = ADDRESS; (*POINTER TO ARRAY OF GLclampd;*)
  PGLenum * =  ADDRESS; (* POINTER TO ARRAY OF GLenum *);
  PGLvoid * = ADDRESS; (*GLvoid*);
  PPGLvoid * = ADDRESS; (*POINTER TO ARRAY OF PGLvoid;*)
  PGLint64 * =  ADDRESS; (*POINTER TO ARRAY OF GLint64; *)
  PGLuint64 * = ADDRESS; (* POINTER TO ARRAY OF GLuint64; *)
  
  (* GL_NV_half_float*)
  GLhalfNV * = WORD;
  TGLhalfNV * = GLhalfNV;
   PGLhalfNV * = POINTER TO ARRAY OF GLhalfNV;

 (* GL_ARB_shader_objects *)
  PGLHandleARB * = POINTER TO ARRAY OF GLHandleARB ;
  GLHandleARB * = Integer;
  GLcharARB * = AnsiChar;
  PGLcharARB * = PAnsiChar;
  PPGLcharARB * =  POINTER TO ARRAY OF PGLcharARB;

(* GL_VERSION_1_5 *)
  GLintptr* = GLint;
  GLsizeiptr* = GLsizei;

 (* GL_ARB_vertex_buffer_object *)
  GLintptrARB* = GLint;
  GLsizeiptrARB* = GLsizei;
    
  (* GL_VERSION_2_0 *)
  GLHandle * = Integer;
  PGLchar * = PAnsiChar;
  PPGLchar * = POINTER TO ARRAY OF PGLchar;
  
  (* GL_EXT_timer_query*)
  GLint64EXT * = Int64;
  TGLint64EXT * = GLint64EXT;
  PGLint64EXT * = POINTER TO ARRAY OF TGLint64EXT;

  GLuint64EXT * = TGLuint64;
  TGLuint64EXT * = GLuint64EXT;
  PGLuint64EXT * = POINTER TO ARRAY OF TGLuint64EXT;

(*  WGL_ARB_pbuffer *)
  HPBUFFERARB * = THandle;

  (* WGL_EXT_pbuffer*)
  HPBUFFEREXT * = THandle;

  (* WGL_NV_present_video *)
  PHVIDEOOUTPUTDEVICENV * = POINTER TO ARRAY OF HVIDEOOUTPUTDEVICENV;
  HVIDEOOUTPUTDEVICENV * = THandle;

  (* WGL_NV_video_output*)
  PHPVIDEODEV * =  POINTER TO ARRAY OF HPVIDEODEV;
  HPVIDEODEV * = THandle;


  HPGPUNV * = THandle;
  HGPUNV * = THandle;
  
(*/ WGL_NV_gpu_affinity *)
  PHPGPUNV * = POINTER TO ARRAY OF HPGPUNV;
  PHGPUNV * = POINTER TO ARRAY OF HGPUNV;

  (* WGL_NV_video_capture *)
  HVIDEOINPUTDEVICENV * = THandle;
  PHVIDEOINPUTDEVICENV * = POINTER TO ARRAY OF HVIDEOINPUTDEVICENV;

  (* ARB_sync*)
  GLsync * = Pointer;

 (* GL_ARB_cl_event *)
  (* These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event } *)
  _cl_context = LONGINT;
  _cl_event = LONGINT;
  p_cl_context = POINTER TO ARRAY OF _cl_context;
  p_cl_event = POINTER TO ARRAY OF _cl_event;
  
  
  (* GL_ARB_debug_output *)
  TglDebugProcARB = PROCEDURE { C } (source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST message_: PGLchar; userParam: PGLvoid); 

  (* GL_AMD_debug_output *)
  TglDebugProcAMD = PROCEDURE { C } (id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; CONST message_: PGLchar; userParam: PGLvoid); 
  
 (* GL_NV_vdpau_interop *)
  GLvdpauSurfaceNV = GLintptr;
  PGLvdpauSurfaceNV =  POINTER TO ARRAY OF GLvdpauSurfaceNV;
 


 (*! GLX - LINUX *)

    PDisplay* = MyX11Api.DisplayPtr; 
    PXVisualInfo* = MyX11Api.VisualInfoPtr;

    GLXContext* = TXID; (* Pointer *)
    GLXContextID* = TXID;
    GLXDrawable* = TXID;
    GLXFBConfig* = TXID; (* Pointer *)
    GLXPbuffer* = TXID;
    GLXPixmap* = TXID;
    GLXWindow* = TXID;

    Window* = TXID;
    Colormap* = TXID;
    Pixmap* = TXID;
    Font* = TXID;

(*    Datatypes corresponding to GL's types TGL(name)(type)(count) *)
  TGLVectorub2 * = ARRAY 2 OF TGLubyte;
  TGLVectori2  * = ARRAY 2 OF TGLint;
  TGLVectorf2  * = ARRAY 2 OF TGLfloat;
  TGLVectord2  * = ARRAY 2 OF TGLdouble;
  TGLVectorp2  * = ARRAY 2 OF Pointer;

  TGLVectorub3 * = ARRAY 3 OF TGLubyte;
  TGLVectori3  * = ARRAY 3 OF TGLint;
  TGLVectorf3  * = ARRAY 3 OF TGLfloat;
  TGLVectord3  * = ARRAY 3 OF TGLdouble;
  TGLVectorp3  * = ARRAY 3 OF Pointer;

  TGLVectorub4 * = ARRAY 4 OF TGLubyte;
  TGLVectori4  * = ARRAY 4 OF TGLint;
  TGLVectorf4  * = ARRAY 4 OF TGLfloat;
  TGLVectord4  * = ARRAY 4 OF TGLdouble;
  TGLVectorp4  * = ARRAY 4 OF Pointer;

  TGLArrayf4 * = TGLVectorf4;
  TGLArrayf3 * = TGLVectorf3;
  TGLArrayd3 * = TGLVectord3;
  TGLArrayi4 * = TGLVectori4;
  TGLArrayp4 * = TGLVectorp4;

  TGlMatrixub3 * = ARRAY 3,3 OF TGLubyte;
  TGlMatrixi3  * = ARRAY 3,3 OF TGLint;
  TGLMatrixf3  * = ARRAY 3,3 OF TGLfloat;
  TGLMatrixd3  * = ARRAY 3,3 OF TGLdouble;

  TGlMatrixub4 * = ARRAY 4,4 OF TGLubyte;
  TGlMatrixi4  * = ARRAY 4,4 OF TGLint;
  TGLMatrixf4  * = ARRAY 4,4 OF TGLfloat;
  TGLMatrixd4  * = ARRAY 4,4 OF TGLdouble;

  TGLVector3f * = TGLVectorf3;

  (* Datatypes corresponding to OpenGL12.pas for easy porting*)
  TVector3d * = TGLVectord3;

  TVector4i * = TGLVectori4;
  TVector4f * = TGLVectorf4;
  TVector4p * = TGLVectorp4;

  TMatrix4f * = TGLMatrixf4;
  TMatrix4d * = TGLMatrixd4;

  PGLMatrixd4 * = POINTER TO ARRAY OF TGLMatrixd4;
  PVector4i * =  POINTER TO ARRAY OF TVector4i;



  TRect* = RECORD
    Left*, Top*, Right*, Bottom*: LONGINT;
  END;

  PGPU_DEVICE * = POINTER TO GPU_DEVICE;
  GPU_DEVICE * = RECORD
    cb*: DWORD;
    DeviceName*: ARRAY 32 OF CHAR;
    DeviceString*: ARRAY 128 OF CHAR;
    Flags*: DWORD;
    rcVirtualScreen*: TRect;
  END;


  (* GLU types *)
  TGLUNurbs * = LONGINT;
  
  TGLUQuadric * = LONGINT;
  
  TGLUTesselator * = LONGINT;
 
  PGLUNurbs * = POINTER TO ARRAY OF TGLUNurbs;
  PGLUQuadric * = POINTER TO ARRAY OF TGLUQuadric;
  PGLUTesselator * = POINTER TO ARRAY OF TGLUTesselator;
  
  (* backwards compatibility *)
  TGLUNurbsObj * = TGLUNurbs;
  TGLUQuadricObj * = TGLUQuadric;
  TGLUTesselatorObj * = TGLUTesselator;
  TGLUTriangulatorObj * = TGLUTesselator;
  PGLUNurbsObj * = PGLUNurbs;
  PGLUQuadricObj * = PGLUQuadric;
  PGLUTesselatorObj * = PGLUTesselator;
  PGLUTriangulatorObj * = PGLUTesselator;

  (* GLUQuadricCallback *)
  TGLUQuadricErrorProc * = PROCEDURE { C }(errorCode: GLenum); 
  (* GLUTessCallback *)
  TGLUTessBeginProc * = PROCEDURE { C }(AType: GLenum); 
  TGLUTessEdgeFlagProc * = PROCEDURE { C } (Flag: GLboolean); 
  TGLUTessVertexProc * = PROCEDURE { C } (VertexData: Pointer); 
  TGLUTessEndProc * = PROCEDURE { C }; 
  TGLUTessErrorProc * = PROCEDURE { C }(ErrNo: GLenum); 
  TGLUTessCombineProc * = PROCEDURE { C }(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer); 
  TGLUTessBeginDataProc * = PROCEDURE { C } (AType: GLenum; UserData: Pointer); 
  TGLUTessEdgeFlagDataProc * = PROCEDURE { C }(Flag: GLboolean; UserData: Pointer); 
  TGLUTessVertexDataProc * = PROCEDURE { C }(VertexData: Pointer; UserData: Pointer); 
  TGLUTessEndDataProc * = PROCEDURE { C }(UserData: Pointer); 
  TGLUTessErrorDataProc * = PROCEDURE { C }(ErrNo: GLenum; UserData: Pointer); 
  TGLUTessCombineDataProc * = PROCEDURE { C }(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer; UserData: Pointer); 
  (* GLUNurbsCallback *)
  TGLUNurbsErrorProc * = PROCEDURE { C } (ErrorCode: TGLenum);

VAR

   GL_VERSION_1_0* ,
  GL_VERSION_1_1* ,
  GL_VERSION_1_2* ,
  GL_VERSION_1_3* ,
  GL_VERSION_1_4* ,
  GL_VERSION_1_5* ,
  GL_VERSION_2_0* ,
  GL_VERSION_2_1* ,
  GL_VERSION_3_0* ,
  GL_VERSION_3_1* ,
  GL_VERSION_3_2* ,
  GL_VERSION_3_3* ,
  GL_VERSION_4_0* ,
  GL_VERSION_4_1* ,
  GLU_VERSION_1_1* ,
  GLU_VERSION_1_2* ,
  GLU_VERSION_1_3* ,
  GL_3DFX_multisample* ,
  GL_3DFX_tbuffer* ,
  GL_3DFX_texture_compression_FXT1* ,
  GL_APPLE_client_storage* ,
  GL_APPLE_element_array* ,
  GL_APPLE_fence* ,
  GL_APPLE_specular_vector* ,
  GL_APPLE_transform_hint* ,
  GL_APPLE_vertex_array_object* ,
  GL_APPLE_vertex_array_range* ,
  GL_APPLE_ycbcr_422* ,
  GL_APPLE_texture_range* ,
  GL_APPLE_float_pixels* ,
  GL_APPLE_vertex_program_evaluators* ,
  GL_APPLE_aux_depth_stencil* ,
  GL_APPLE_object_purgeable* ,
  GL_APPLE_row_bytes* ,
  GL_APPLE_rgb_422* ,
  GL_ARB_depth_texture* ,
  GL_ARB_fragment_program* ,
  GL_ARB_imaging* ,
  GL_ARB_matrix_palette* ,
  GL_ARB_multisample* ,
  GL_ARB_multitexture* ,
  GL_ARB_point_parameters* ,
  GL_ARB_shadow* ,
  GL_ARB_shadow_ambient* ,
  GL_ARB_texture_border_clamp* ,
  GL_ARB_texture_compression* ,
  GL_ARB_texture_cube_map* ,
  GL_ARB_texture_env_add* ,
  GL_ARB_texture_env_combine* ,
  GL_ARB_texture_env_crossbar* ,
  GL_ARB_texture_env_dot3* ,
  GL_ARB_texture_mirrored_repeat* ,
  GL_ARB_transpose_matrix* ,
  GL_ARB_vertex_blend* ,
  GL_ARB_vertex_buffer_object* ,
  GL_ARB_vertex_program* ,
  GL_ARB_window_pos* ,
  GL_ARB_shader_objects* ,
  GL_ARB_vertex_shader* ,
  GL_ARB_fragment_shader* ,
  GL_ARB_shading_language_100* ,
  GL_ARB_occlusion_query* ,
  GL_ARB_texture_non_power_of_two* ,
  GL_ARB_point_sprite* ,
  GL_ARB_fragment_program_shadow* ,
  GL_ARB_draw_buffers* ,
  GL_ARB_texture_rectangle* ,
  GL_ARB_color_buffer_float* ,
  GL_ARB_half_float_pixel* ,
  GL_ARB_texture_float* ,
  GL_ARB_pixel_buffer_object* ,
  GL_ARB_depth_buffer_float* ,
  GL_ARB_draw_instanced* ,
  GL_ARB_framebuffer_object* ,
  GL_ARB_framebuffer_sRGB* ,
  GL_ARB_geometry_shader4* ,
  GL_ARB_half_float_vertex* ,
  GL_ARB_instanced_arrays* ,
  GL_ARB_map_buffer_range* ,
  GL_ARB_texture_buffer_object* ,
  GL_ARB_texture_compression_rgtc* ,
  GL_ARB_texture_rg* ,
  GL_ARB_vertex_array_object* ,
  GL_ARB_uniform_buffer_object* ,
  GL_ARB_compatibility* ,
  GL_ARB_copy_buffer* ,
  GL_ARB_shader_texture_lod* ,
  GL_ARB_depth_clamp* ,
  GL_ARB_draw_elements_base_vertex* ,
  GL_ARB_fragment_coord_conventions* ,
  GL_ARB_provoking_vertex* ,
  GL_ARB_seamless_cube_map* ,
  GL_ARB_sync* ,
  GL_ARB_texture_multisample* ,
  GL_ARB_vertex_array_bgra* ,
  GL_ARB_draw_buffers_blend* ,
  GL_ARB_sample_shading* ,
  GL_ARB_texture_cube_map_array* ,
  GL_ARB_texture_gather* ,
  GL_ARB_texture_query_lod* ,
  GL_ARB_shading_language_include* ,
  GL_ARB_texture_compression_bptc* ,
  GL_ARB_blend_func_extended* ,
  GL_ARB_explicit_attrib_location* ,
  GL_ARB_occlusion_query2* ,
  GL_ARB_sampler_objects* ,
  GL_ARB_shader_bit_encoding* ,
  GL_ARB_texture_rgb10_a2ui* ,
  GL_ARB_texture_swizzle* ,
  GL_ARB_timer_query* ,
  GL_ARB_vertex_type_2_10_10_10_rev* ,
  GL_ARB_draw_indirect* ,
  GL_ARB_gpu_shader5* ,
  GL_ARB_gpu_shader_fp64* ,
  GL_ARB_shader_subroutine* ,
  GL_ARB_tessellation_shader* ,
  GL_ARB_texture_buffer_object_rgb32* ,
  GL_ARB_transform_feedback2* ,
  GL_ARB_transform_feedback3* ,
  GL_ARB_ES2_compatibility* ,
  GL_ARB_get_program_binary* ,
  GL_ARB_separate_shader_objects* ,
  GL_ARB_shader_precision* ,
  GL_ARB_vertex_attrib_64bit* ,
  GL_ARB_viewport_array* ,
  GL_ARB_cl_event* ,
  GL_ARB_debug_output* ,
  GL_ARB_robustness* ,
  GL_ARB_shader_stencil_export* ,  
  GL_ATI_draw_buffers* ,
  GL_ATI_element_array* ,
  GL_ATI_envmap_bumpmap* ,
  GL_ATI_fragment_shader* ,
  GL_ATI_map_object_buffer* ,
  GL_ATI_pn_triangles* ,
  GL_ATI_separate_stencil* ,
  GL_ATI_text_fragment_shader* ,
  GL_ATI_texture_env_combine3* ,
  GL_ATI_texture_float* ,
  GL_ATI_texture_mirror_once* ,
  GL_ATI_vertex_array_object* ,
  GL_ATI_vertex_attrib_array_object* ,
  GL_ATI_vertex_streams* ,
  GL_ATI_meminfo* ,
  GL_AMD_performance_monitor* ,
  GL_AMD_texture_texture4* ,
  GL_AMD_vertex_shader_tesselator* ,
  GL_AMD_draw_buffers_blend* ,
  GL_AMD_shader_stencil_export* ,
  GL_AMD_seamless_cubemap_per_texture* ,
  GL_AMD_conservative_depth* ,
  GL_AMD_name_gen_delete* ,
  GL_AMD_debug_output* ,
  GL_AMD_transform_feedback3_lines_triangles* ,
  GL_AMD_depth_clamp_separate* ,
  GL_EXT_422_pixels* ,
  GL_EXT_abgr* ,
  GL_EXT_bgra* ,
  GL_EXT_blend_color* ,
  GL_EXT_blend_func_separate* ,
  GL_EXT_blend_logic_op* ,
  GL_EXT_blend_minmax* ,
  GL_EXT_blend_subtract* ,
  GL_EXT_clip_volume_hint* ,
  GL_EXT_cmyka* ,
  GL_EXT_color_matrix* ,
  GL_EXT_color_subtable* ,
  GL_EXT_compiled_vertex_array* ,
  GL_EXT_convolution* ,
  GL_EXT_coordinate_frame* ,
  GL_EXT_copy_texture* ,
  GL_EXT_cull_vertex* ,
  GL_EXT_draw_range_elements* ,
  GL_EXT_fog_coord* ,
  GL_EXT_framebuffer_object* ,
  GL_EXT_histogram* ,
  GL_EXT_index_array_formats* ,
  GL_EXT_index_func* ,
  GL_EXT_index_material* ,
  GL_EXT_index_texture* ,
  GL_EXT_light_texture* ,
  GL_EXT_misc_attribute* ,
  GL_EXT_multi_draw_arrays* ,
  GL_EXT_multisample* ,
  GL_EXT_packed_pixels* ,
  GL_EXT_paletted_texture* ,
  GL_EXT_pixel_transform* ,
  GL_EXT_pixel_transform_color_table* ,
  GL_EXT_point_parameters* ,
  GL_EXT_polygon_offset* ,
  GL_EXT_rescale_normal* ,
  GL_EXT_secondary_color* ,
  GL_EXT_separate_specular_color* ,
  GL_EXT_shadow_funcs* ,
  GL_EXT_shared_texture_palette* ,
  GL_EXT_stencil_two_side* ,
  GL_EXT_stencil_wrap* ,
  GL_EXT_subtexture* ,
  GL_EXT_texture* ,
  GL_EXT_texture3D* ,
  GL_EXT_texture_compression_s3tc* ,
  GL_EXT_texture_cube_map* ,
  GL_EXT_texture_edge_clamp* ,
  GL_EXT_texture_env_add* ,
  GL_EXT_texture_env_combine* ,
  GL_EXT_texture_env_dot3* ,
  GL_EXT_texture_filter_anisotropic* ,
  GL_EXT_texture_lod_bias* ,
  GL_EXT_texture_object* ,
  GL_EXT_texture_perturb_normal* ,
  GL_EXT_texture_rectangle* ,
  GL_EXT_vertex_array* ,

  GL_EXT_vertex_shader* ,
  GL_EXT_vertex_weighting* ,
  GL_EXT_depth_bounds_test* ,
  GL_EXT_texture_mirror_clamp* ,
  GL_EXT_blend_equation_separate* ,
  GL_EXT_pixel_buffer_object* ,
  GL_EXT_texture_compression_dxt1* ,
  GL_EXT_stencil_clear_tag* ,
  GL_EXT_packed_depth_stencil* ,
  GL_EXT_texture_sRGB* ,
  GL_EXT_framebuffer_blit* ,
  GL_EXT_framebuffer_multisample* ,
  GL_EXT_timer_query* ,
  GL_EXT_gpu_program_parameters* ,
  GL_EXT_bindable_uniform* ,
  GL_EXT_draw_buffers2* ,
  GL_EXT_draw_instanced* ,
  GL_EXT_framebuffer_sRGB* ,
  GL_EXT_geometry_shader4* ,
  GL_EXT_gpu_shader4* ,
  GL_EXT_packed_float* ,
  GL_EXT_texture_array* ,
  GL_EXT_texture_buffer_object* ,
  GL_EXT_texture_compression_latc* ,
  GL_EXT_texture_compression_rgtc* ,
  GL_EXT_texture_integer* ,
  GL_EXT_texture_shared_exponent* ,
  GL_EXT_transform_feedback* ,
  GL_EXT_direct_state_access* ,
  GL_EXT_vertex_array_bgra* ,
  GL_EXT_texture_swizzle* ,
  GL_EXT_provoking_vertex* ,
  GL_EXT_texture_snorm* ,
  GL_EXT_separate_shader_objects* ,
  GL_EXT_shader_image_load_store* ,
  GL_EXT_vertex_attrib_64bit* ,
  GL_EXT_texture_sRGB_decode* ,
  GL_FfdMaskSGIX* ,
  GL_HP_convolution_border_modes* ,
  GL_HP_image_transform* ,
  GL_HP_occlusion_test* ,
  GL_HP_texture_lighting* ,
  GL_IBM_cull_vertex* ,
  GL_IBM_multimode_draw_arrays* ,
  GL_IBM_rasterpos_clip* ,
  GL_IBM_texture_mirrored_repeat* ,
  GL_IBM_vertex_array_lists* ,
  GL_INGR_blend_func_separate* ,
  GL_INGR_color_clamp* ,
  GL_INGR_interlace_read* ,
  GL_INGR_palette_buffer* ,
  GL_INTEL_parallel_arrays* ,
  GL_INTEL_texture_scissor* ,
  GL_MESA_resize_buffers* ,
  GL_MESA_window_pos* ,
  GL_NV_blend_square* ,
  GL_NV_copy_depth_to_color* ,
  GL_NV_depth_clamp* ,
  GL_NV_evaluators* ,
  GL_NV_fence* ,
  GL_NV_float_buffer* ,
  GL_NV_fog_distance* ,
  GL_NV_fragment_program* ,
  GL_NV_half_float* ,
  GL_NV_light_max_exponent* ,
  GL_NV_multisample_filter_hint* ,
  GL_NV_occlusion_query* ,
  GL_NV_packed_depth_stencil* ,
  GL_NV_pixel_data_range* ,
  GL_NV_point_sprite* ,
  GL_NV_primitive_restart* ,
  GL_NV_register_combiners* ,
  GL_NV_register_combiners2* ,
  GL_NV_texgen_emboss* ,
  GL_NV_texgen_reflection* ,
  GL_NV_texture_compression_vtc* ,
  GL_NV_texture_env_combine4* ,
  GL_NV_texture_expand_normal* ,
  GL_NV_texture_rectangle* ,
  GL_NV_texture_shader* ,
  GL_NV_texture_shader2* ,
  GL_NV_texture_shader3* ,
  GL_NV_vertex_array_range* ,
  GL_NV_vertex_array_range2* ,
  GL_NV_vertex_program* ,
  GL_NV_vertex_program1_1* ,
  GL_NV_vertex_program2* ,
  GL_NV_fragment_program_option* ,
  GL_NV_fragment_program2* ,
  GL_NV_vertex_program2_option* ,
  GL_NV_vertex_program3* ,
  GL_NV_depth_buffer_float* ,
  GL_NV_fragment_program4* ,
  GL_NV_framebuffer_multisample_coverage* ,
  GL_NV_geometry_program4* ,
  GL_NV_gpu_program4* ,
  GL_NV_parameter_buffer_object* ,
  GL_NV_transform_feedback* ,
  GL_NV_vertex_program4* ,
  GL_NV_conditional_render* ,
  GL_NV_present_video* ,
  GL_NV_explicit_multisample* ,
  GL_NV_transform_feedback2* ,
  GL_NV_video_capture* ,
  GL_NV_copy_image* ,
  GL_NV_parameter_buffer_object2* ,
  GL_NV_shader_buffer_load* ,
  GL_NV_vertex_buffer_unified_memory* ,
  GL_NV_gpu_program5* ,
  GL_NV_gpu_shader5* ,
  GL_NV_shader_buffer_store* ,
  GL_NV_tessellation_program5* ,
  GL_NV_vertex_attrib_integer_64bit* ,
  GL_NV_multisample_coverage* ,
  GL_NV_vdpau_interop* ,
  GL_NV_texture_barrier* ,
  GL_OML_interlace* ,
  GL_OML_resample* ,
  GL_OML_subsample* ,
  GL_PGI_misc_hints* ,
  GL_PGI_vertex_hints* ,
  GL_REND_screen_coordinates* ,
  GL_S3_s3tc* ,
  GL_SGIS_detail_texture* ,
  GL_SGIS_fog_function* ,
  GL_SGIS_generate_mipmap* ,
  GL_SGIS_multisample* ,
  GL_SGIS_pixel_texture* ,
  GL_SGIS_point_line_texgen* ,
  GL_SGIS_point_parameters* ,
  GL_SGIS_sharpen_texture* ,
  GL_SGIS_texture4D* ,
  GL_SGIS_texture_border_clamp* ,
  GL_SGIS_texture_color_mask* ,
  GL_SGIS_texture_edge_clamp* ,
  GL_SGIS_texture_filter4* ,
  GL_SGIS_texture_lod* ,
  GL_SGIS_texture_select* ,
  GL_SGIX_async* ,
  GL_SGIX_async_histogram* ,
  GL_SGIX_async_pixel* ,
  GL_SGIX_blend_alpha_minmax* ,
  GL_SGIX_calligraphic_fragment* ,
  GL_SGIX_clipmap* ,
  GL_SGIX_convolution_accuracy* ,
  GL_SGIX_depth_pass_instrument* ,
  GL_SGIX_depth_texture* ,
  GL_SGIX_flush_raster* ,
  GL_SGIX_fog_offset* ,
  GL_SGIX_fog_scale* ,
  GL_SGIX_fragment_lighting* ,
  GL_SGIX_framezoom* ,
  GL_SGIX_igloo_interface* ,
  GL_SGIX_impact_pixel_texture* ,
  GL_SGIX_instruments* ,
  GL_SGIX_interlace* ,
  GL_SGIX_ir_instrument1* ,
  GL_SGIX_list_priority* ,
  GL_SGIX_pixel_texture* ,
  GL_SGIX_pixel_tiles* ,
  GL_SGIX_polynomial_ffd* ,
  GL_SGIX_reference_plane* ,
  GL_SGIX_resample* ,
  GL_SGIX_scalebias_hint* ,
  GL_SGIX_shadow* ,
  GL_SGIX_shadow_ambient* ,
  GL_SGIX_sprite* ,
  GL_SGIX_subsample* ,
  GL_SGIX_tag_sample_buffer* ,
  GL_SGIX_texture_add_env* ,
  GL_SGIX_texture_coordinate_clamp* ,
  GL_SGIX_texture_lod_bias* ,
  GL_SGIX_texture_multi_buffer* ,
  GL_SGIX_texture_scale_bias* ,
  GL_SGIX_texture_select* ,
  GL_SGIX_vertex_preclip* ,
  GL_SGIX_ycrcb* ,
  GL_SGIX_ycrcb_subsample* ,
  GL_SGIX_ycrcba* ,
  GL_SGI_color_matrix* ,
  GL_SGI_color_table* ,
  GL_SGI_depth_pass_instrument* ,
  GL_SGI_texture_color_table* ,
  GL_SUNX_constant_data* ,
  GL_SUN_convolution_border_modes* ,
  GL_SUN_global_alpha* ,
  GL_SUN_mesh_array* ,
  GL_SUN_slice_accum* ,
  GL_SUN_triangle_list* ,
  GL_SUN_vertex* ,

  GL_WIN_phong_shading* ,
  GL_WIN_specular_fog* ,
  WGL_3DFX_multisample* ,
  WGL_ARB_buffer_region* ,
  WGL_ARB_extensions_string* ,
  WGL_ARB_make_current_read* ,
  WGL_ARB_multisample* ,
  WGL_ARB_pbuffer* ,
  WGL_ARB_pixel_format* ,
  WGL_ARB_pixel_format_float* ,
  WGL_ARB_render_texture* ,
  WGL_ARB_create_context* ,
  WGL_ARB_create_context_profile* ,
  WGL_ARB_framebuffer_sRGB* ,
  WGL_ARB_create_context_robustness* ,
  WGL_ATI_pixel_format_float* ,
  WGL_AMD_gpu_association* ,
  WGL_EXT_depth_float* ,
  WGL_EXT_display_color_table* ,
  WGL_EXT_extensions_string* ,
  WGL_EXT_make_current_read* ,
  WGL_EXT_multisample* ,
  WGL_EXT_pbuffer* ,
  WGL_EXT_pixel_format* ,
  WGL_EXT_swap_control* ,
  WGL_EXT_create_context_es2_profile* ,
  WGL_I3D_digital_video_control* ,
  WGL_I3D_gamma* ,
  WGL_I3D_genlock* ,
  WGL_I3D_image_buffer* ,
  WGL_I3D_swap_frame_lock* ,
  WGL_I3D_swap_frame_usage* ,
  WGL_NV_float_buffer* ,
  WGL_NV_render_depth_texture* ,
  WGL_NV_render_texture_rectangle* ,
  WGL_NV_vertex_array_range* ,
  WGL_NV_present_video* ,
  WGL_NV_video_output* ,
  WGL_NV_swap_group* ,
  WGL_NV_gpu_affinity* ,
  WGL_NV_video_capture* ,
  WGL_NV_copy_image* ,
  WGL_NV_multisample_coverage* ,
  WGL_OML_sync_control* ,
  WGL_3DL_stereo_control* ,
  WIN_draw_range_elements* ,
  WIN_swap_hint* ,
 
(*!  GLX_VERSION_1_0* , *)
  GLX_VERSION_1_3* ,
  GLX_VERSION_1_4* ,
  GLX_ARB_multisample* ,
  GLX_ARB_fbconfig_float* ,
  GLX_ARB_get_proc_address* ,
  GLX_ARB_create_context* ,
  GLX_ARB_create_context_profile* ,
  GLX_ARB_vertex_buffer_object* ,
  GLX_ARB_framebuffer_sRGB* ,
  GLX_ARB_create_context_robustness* ,
  GLX_EXT_visual_info* ,
  GLX_EXT_visual_rating* ,
  GLX_EXT_import_context* ,
  GLX_EXT_fbconfig_packed_float* ,
  GLX_EXT_framebuffer_sRGB* ,
  GLX_EXT_texture_from_pixmap* ,
  GLX_EXT_swap_control* ,
  GLX_EXT_create_context_es2_profile : BOOLEAN;
    
   

TYPE

  (*! GL_VERSION_1_0 *)
  TglCullFace = PROCEDURE { C }(mode: TGLenum); 
  TglFrontFace = PROCEDURE { C }(mode: TGLenum); 
  TglHint = PROCEDURE { C }(target: TGLenum; mode: TGLenum); 
  TglLineWidth = PROCEDURE { C }(width: TGLfloat); 
  TglPointSize = PROCEDURE { C }(size: TGLfloat); 
  TglPolygonMode = PROCEDURE { C }(face: TGLenum; mode: TGLenum); 
  TglScissor = PROCEDURE { C }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglTexParameterf = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexParameterfv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexParameteri = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexParameteriv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglTexImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglDrawBuffer = PROCEDURE { C }(mode: TGLenum); 
  TglClear = PROCEDURE { C }(mask: TGLbitfield); 
  TglClearColor = PROCEDURE { C }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 
  TglClearStencil = PROCEDURE { C }(s: TGLint); 
  TglClearDepth = PROCEDURE { C }(depth: TGLclampd); 
  TglStencilMask = PROCEDURE { C }(mask: TGLuint); 
  TglColorMask = PROCEDURE { C }(red: TGLboolean; green: TGLboolean; blue: TGLboolean; alpha: TGLboolean); 
  TglDepthMask = PROCEDURE { C }(flag: TGLboolean); 
  TglDisable = PROCEDURE { C }(cap: TGLenum); 
  TglEnable = PROCEDURE { C }(cap: TGLenum); 
  TglFinish = PROCEDURE { C }(); 
  TglFlush = PROCEDURE { C }(); 
  TglBlendFunc = PROCEDURE { C }(sfactor: TGLenum; dfactor: TGLenum); 
  TglLogicOp = PROCEDURE { C }(opcode: TGLenum); 
  TglStencilFunc = PROCEDURE { C }(func: TGLenum; ref: TGLint; mask: TGLuint); 
  TglStencilOp = PROCEDURE { C }(fail: TGLenum; zfail: TGLenum; zpass: TGLenum); 
  TglDepthFunc = PROCEDURE { C }(func: TGLenum); 
  TglPixelStoref = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglPixelStorei = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglReadBuffer = PROCEDURE { C }(mode: TGLenum); 
  TglReadPixels = PROCEDURE { C }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; pixels: PGLvoid); 
  TglGetBooleanv = PROCEDURE { C }(pname: TGLenum; params: PGLboolean); 
  TglGetDoublev = PROCEDURE { C }(pname: TGLenum; params: PGLdouble); 
  TglGetError = PROCEDURE { C }(): TGLenum; 
  TglGetFloatv = PROCEDURE { C }(pname: TGLenum; params: PGLfloat); 
  TglGetIntegerv* = PROCEDURE { C }(pname: TGLenum; params: ADDRESS (*PGLint*)); 
  TglGetString* =  PROCEDURE { C }(name: TGLenum): ADDRESS; 
  TglGetTexImage = PROCEDURE { C }(target: TGLenum; level: TGLint; format: TGLenum; _type: TGLenum; pixels: PGLvoid); 
  TglGetTexParameteriv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexParameterfv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexLevelParameterfv = PROCEDURE { C }(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLfloat); 
  TglGetTexLevelParameteriv = PROCEDURE { C }(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLint); 
  TglIsEnabled =  PROCEDURE { C }(cap: TGLenum): TGLboolean; 
  TglDepthRange = PROCEDURE { C }(zNear: TGLclampd; zFar: TGLclampd); 
  TglViewport = PROCEDURE { C }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

  (*! GL_VERSION_1_1 *)
  TglDrawArrays = PROCEDURE { C }(mode: TGLenum; first: TGLint; count: TGLsizei); 
  TglDrawElements = PROCEDURE { C }(mode: TGLenum; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 
  TglGetPointerv = PROCEDURE { C }(pname: TGLenum; params: PGLvoid); 
  TglPolygonOffset = PROCEDURE { C }(factor: TGLfloat; units: TGLfloat); 
  TglCopyTexImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalFormat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; border: TGLint); 
  TglCopyTexImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalFormat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint); 
  TglCopyTexSubImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyTexSubImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglTexSubImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglBindTexture = PROCEDURE { C }(target: TGLenum; texture: TGLuint); 
  TglDeleteTextures = PROCEDURE { C }(n: TGLsizei;  textures: PGLuint); 
  TglGenTextures = PROCEDURE { C }(n: TGLsizei; textures: PGLuint); 
  
(*! ifdef DEPRECATED *)
  TglAccum = PROCEDURE { C }(op: TGLenum; value: TGLfloat); 
  TglAlphaFunc = PROCEDURE { C }(func: TGLenum; ref: TGLclampf); 
  TglAreTexturesResident =  PROCEDURE { C }(n: TGLsizei; CONST textures: PGLuint; residences: PGLboolean): TGLboolean; 
  TglArrayElement = PROCEDURE { C }(i: TGLint); 
  TglBegin = PROCEDURE { C }(mode: TGLenum);
  TglBitmap = PROCEDURE { C }(width: TGLsizei; height: TGLsizei; xorig: TGLfloat; yorig: TGLfloat; xmove: TGLfloat; ymove: TGLfloat; CONST bitmap: PGLubyte); 
  TglCallList = PROCEDURE { C }(list: TGLuint); 
  TglCallLists = PROCEDURE { C }(n: TGLsizei; _type: TGLenum;  lists: PGLvoid); 
  TglClearAccum = PROCEDURE { C }(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); 
  TglClearIndex = PROCEDURE { C }(c: TGLfloat); 
  TglClipPlane = PROCEDURE { C }(plane: TGLenum; CONST equation: PGLdouble); 
  TglColor3b = PROCEDURE { C }(red: TGLbyte; green: TGLbyte; blue: TGLbyte); 
  TglColor3bv = PROCEDURE { C }(CONST v: PGLbyte); 
  TglColor3d = PROCEDURE { C }(red: TGLdouble; green: TGLdouble; blue: TGLdouble); 
  TglColor3dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglColor3f = PROCEDURE { C }(red: TGLfloat; green: TGLfloat; blue: TGLfloat); 
  TglColor3fv = PROCEDURE { C }( v: ADDRESS (*PGLfloat*)); 
  TglColor3i = PROCEDURE { C }(red: TGLint; green: TGLint; blue: TGLint); 
  TglColor3iv = PROCEDURE { C }(CONST v: PGLint); 
  TglColor3s = PROCEDURE { C }(red: TGLshort; green: TGLshort; blue: TGLshort); 
  TglColor3sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglColor3ub = PROCEDURE { C }(red: TGLubyte; green: TGLubyte; blue: TGLubyte); 
  TglColor3ubv = PROCEDURE { C }(CONST v: PGLubyte); 
  TglColor3ui = PROCEDURE { C }(red: TGLuint; green: TGLuint; blue: TGLuint); 
  TglColor3uiv = PROCEDURE { C }(CONST v: PGLuint); 
  TglColor3us = PROCEDURE { C }(red: TGLushort; green: TGLushort; blue: TGLushort); 
  TglColor3usv = PROCEDURE { C }(CONST v: PGLushort); 
  TglColor4b = PROCEDURE { C }(red: TGLbyte; green: TGLbyte; blue: TGLbyte; alpha: TGLbyte); 
  TglColor4bv = PROCEDURE { C }(CONST v: PGLbyte); 
  TglColor4d = PROCEDURE { C }(red: TGLdouble; green: TGLdouble; blue: TGLdouble; alpha: TGLdouble); 
  TglColor4dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglColor4f = PROCEDURE { C }(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); 
  TglColor4fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglColor4i = PROCEDURE { C }(red: TGLint; green: TGLint; blue: TGLint; alpha: TGLint); 
  TglColor4iv = PROCEDURE { C }(CONST v: PGLint); 
  TglColor4s = PROCEDURE { C }(red: TGLshort; green: TGLshort; blue: TGLshort; alpha: TGLshort); 
  TglColor4sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglColor4ub = PROCEDURE { C }(red: TGLubyte; green: TGLubyte; blue: TGLubyte; alpha: TGLubyte); 
  TglColor4ubv = PROCEDURE { C }(CONST v: PGLubyte); 
  TglColor4ui = PROCEDURE { C }(red: TGLuint; green: TGLuint; blue: TGLuint; alpha: TGLuint); 
  TglColor4uiv = PROCEDURE { C }(CONST v: PGLuint); 
  TglColor4us = PROCEDURE { C }(red: TGLushort; green: TGLushort; blue: TGLushort; alpha: TGLushort); 
  TglColor4usv = PROCEDURE { C }(CONST v: PGLushort); 
  TglColorMaterial = PROCEDURE { C }(face: TGLenum; mode: TGLenum); 
  TglColorPointer = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglCopyPixels = PROCEDURE { C }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; _type: TGLenum); 
  TglDeleteLists = PROCEDURE { C }(list: TGLuint; range: TGLsizei); 
  TglDisableClientState = PROCEDURE { C }(_array: TGLenum); 
  TglDrawPixels = PROCEDURE { C }(width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglEdgeFlag = PROCEDURE { C }(flag: TGLboolean); 
  TglEdgeFlagPointer = PROCEDURE { C }(stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglEdgeFlagv = PROCEDURE { C }(CONST flag: PGLboolean); 
  TglEnableClientState = PROCEDURE { C }(_array: TGLenum); 
  TglEnd = PROCEDURE { C }(); 
  TglEndList = PROCEDURE { C }(); 
  TglEvalCoord1d = PROCEDURE { C }(u: TGLdouble); 
  TglEvalCoord1dv = PROCEDURE { C }(CONST u: PGLdouble); 
  TglEvalCoord1f = PROCEDURE { C }(u: TGLfloat); 
  TglEvalCoord1fv = PROCEDURE { C }(CONST u: PGLfloat); 
  TglEvalCoord2d = PROCEDURE { C }(u: TGLdouble; v: TGLdouble); 
  TglEvalCoord2dv = PROCEDURE { C }(CONST u: PGLdouble); 
  TglEvalCoord2f = PROCEDURE { C }(u: TGLfloat; v: TGLfloat); 
  TglEvalCoord2fv = PROCEDURE { C }(CONST u: PGLfloat); 
  TglEvalMesh1 = PROCEDURE { C }(mode: TGLenum; i1: TGLint; i2: TGLint); 
  TglEvalMesh2 = PROCEDURE { C }(mode: TGLenum; i1: TGLint; i2: TGLint; j1: TGLint; j2: TGLint); 
  TglEvalPoint1 = PROCEDURE { C }(i: TGLint); 
  TglEvalPoint2 = PROCEDURE { C }(i: TGLint; j: TGLint); 
  TglFeedbackBuffer = PROCEDURE { C }(size: TGLsizei; _type: TGLenum; buffer: PGLfloat); 
  TglFogf = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglFogfv = PROCEDURE { C }(pname: TGLenum; CONST params: PGLfloat); 
  TglFogi = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglFogiv = PROCEDURE { C }(pname: TGLenum; CONST params: PGLint); 
  TglFrustum = PROCEDURE { C }(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; zNear: TGLdouble; zFar: TGLdouble); 
  TglGenLists =  PROCEDURE { C }(range: TGLsizei): TGLuint; 
  TglGetClipPlane = PROCEDURE { C }(plane: TGLenum; equation: PGLdouble); 
  TglGetLightfv = PROCEDURE { C }(light: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetLightiv = PROCEDURE { C }(light: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMapdv = PROCEDURE { C }(target: TGLenum; query: TGLenum; v: PGLdouble); 
  TglGetMapfv = PROCEDURE { C }(target: TGLenum; query: TGLenum; v: PGLfloat); 
  TglGetMapiv = PROCEDURE { C }(target: TGLenum; query: TGLenum; v: PGLint); 
  TglGetMaterialfv = PROCEDURE { C }(face: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMaterialiv = PROCEDURE { C }(face: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetPixelMapfv = PROCEDURE { C }(map: TGLenum; values: PGLfloat); 
  TglGetPixelMapuiv = PROCEDURE { C }(map: TGLenum; values: PGLuint); 
  TglGetPixelMapusv = PROCEDURE { C }(map: TGLenum; values: PGLushort); 
  TglGetPolygonStipple = PROCEDURE { C }(mask: PGLubyte); 
  TglGetTexEnvfv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexEnviv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexGendv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; params: PGLdouble); 
  TglGetTexGenfv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexGeniv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; params: PGLint); 
  TglIndexMask = PROCEDURE { C }(mask: TGLuint); 
  TglIndexPointer = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglIndexd = PROCEDURE { C }(c: TGLdouble); 
  TglIndexdv = PROCEDURE { C }( c: PGLdouble); 
  TglIndexf = PROCEDURE { C }(c: TGLfloat); 
  TglIndexfv = PROCEDURE { C }( c: PGLfloat); 
  TglIndexi = PROCEDURE { C }(c: TGLint); 
  TglIndexiv = PROCEDURE { C }( c: PGLint); 
  TglIndexs = PROCEDURE { C }(c: TGLshort); 
  TglIndexsv = PROCEDURE { C }( c: PGLshort); 
  TglIndexub = PROCEDURE { C }(c: TGLubyte); 
  TglIndexubv = PROCEDURE { C }( c: PGLubyte); 
  TglInitNames = PROCEDURE { C }(); 
  TglInterleavedArrays = PROCEDURE { C }(format: TGLenum; stride: TGLsizei;  _pointer: PGLvoid); 
  TglIsList =  PROCEDURE { C } (list: TGLuint): BOOLEAN; 
  TglIsTexture =  PROCEDURE { C } (texture: TGLuint): BOOLEAN; 
  TglLightModelf = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglLightModelfv = PROCEDURE { C }(pname: TGLenum;  params: PGLfloat); 
  TglLightModeli = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglLightModeliv = PROCEDURE { C }(pname: TGLenum;  params: PGLint); 
  TglLightf = PROCEDURE { C }(light: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglLightfv = PROCEDURE { C }(light: TGLenum; pname: TGLenum;   params: PGLfloat);
  TglLighti = PROCEDURE { C }(light: TGLenum; pname: TGLenum; param: TGLint); 
  TglLightiv = PROCEDURE { C }(light: TGLenum; pname: TGLenum;  params: PGLint); 
  TglLineStipple = PROCEDURE { C }(factor: TGLint; pattern: TGLushort); 
  TglListBase = PROCEDURE { C }(base: TGLuint); 
  TglLoadIdentity = PROCEDURE { C }(); 
  TglLoadMatrixd = PROCEDURE { C }( m: PGLdouble); 
  TglLoadMatrixf = PROCEDURE { C }( m: PGLfloat); 
  TglLoadName = PROCEDURE { C }(name: TGLuint); 
  TglMap1d = PROCEDURE { C }(target: TGLenum; u1: TGLdouble; u2: TGLdouble; stride: TGLint; order: TGLint; CONST points: PGLdouble); 
  TglMap1f = PROCEDURE { C }(target: TGLenum; u1: TGLfloat; u2: TGLfloat; stride: TGLint; order: TGLint; CONST points: PGLfloat); 
  TglMap2d = PROCEDURE { C }(target: TGLenum; u1: TGLdouble; u2: TGLdouble; ustride: TGLint; uorder: TGLint; v1: TGLdouble; v2: TGLdouble; vstride: TGLint; vorder: TGLint; CONST points: PGLdouble); 
  TglMap2f = PROCEDURE { C }(target: TGLenum; u1: TGLfloat; u2: TGLfloat; ustride: TGLint; uorder: TGLint; v1: TGLfloat; v2: TGLfloat; vstride: TGLint; vorder: TGLint; points: ADDRESS (*CONST points: PGLfloat*)); 
  TglMapGrid1d = PROCEDURE { C }(un: TGLint; u1: TGLdouble; u2: TGLdouble); 
  TglMapGrid1f = PROCEDURE { C }(un: TGLint; u1: TGLfloat; u2: TGLfloat); 
  TglMapGrid2d = PROCEDURE { C }(un: TGLint; u1: TGLdouble; u2: TGLdouble; vn: TGLint; v1: TGLdouble; v2: TGLdouble); 
  TglMapGrid2f = PROCEDURE { C }(un: TGLint; u1: TGLfloat; u2: TGLfloat; vn: TGLint; v1: TGLfloat; v2: TGLfloat); 
  TglMaterialf = PROCEDURE { C }(face: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglMaterialfv = PROCEDURE { C }(face: TGLenum; pname: TGLenum;  params:  ADDRESS(*GLfloat*)); 
  TglMateriali = PROCEDURE { C }(face: TGLenum; pname: TGLenum; param: TGLint); 
  TglMaterialiv = PROCEDURE { C }(face: TGLenum; pname: TGLenum;  params: PGLint); 
  TglMatrixMode = PROCEDURE { C }(mode: TGLenum); 
  TglMultMatrixd = PROCEDURE { C }( m: PGLdouble); 
  TglMultMatrixf = PROCEDURE { C }( m: PGLfloat); 
  TglNewList = PROCEDURE { C }(list: TGLuint; mode: TGLenum); 
  TglNormal3b = PROCEDURE { C }(nx: TGLbyte; ny: TGLbyte; nz: TGLbyte); 
  TglNormal3bv = PROCEDURE { C }( v: PGLbyte); 
  TglNormal3d = PROCEDURE { C }(nx: TGLdouble; ny: TGLdouble; nz: TGLdouble); 
  TglNormal3dv = PROCEDURE { C }( v: PGLdouble); 
  TglNormal3f = PROCEDURE { C }(nx: TGLfloat; ny: TGLfloat; nz: TGLfloat); 
  TglNormal3fv = PROCEDURE { C }( v: PGLfloat); 
  TglNormal3i = PROCEDURE { C }(nx: TGLint; ny: TGLint; nz: TGLint); 
  TglNormal3iv = PROCEDURE { C }( v: PGLint); 
  TglNormal3s = PROCEDURE { C }(nx: TGLshort; ny: TGLshort; nz: TGLshort); 
  TglNormal3sv = PROCEDURE { C }( v: PGLshort); 
  TglNormalPointer = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei;  _pointer: PGLvoid); 
  TglOrtho = PROCEDURE { C }(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; zNear: TGLdouble; zFar: TGLdouble); 
  TglPassThrough = PROCEDURE { C }(token: TGLfloat); 
  TglPixelMapfv = PROCEDURE { C }(map: TGLenum; mapsize: TGLsizei;  values: PGLfloat); 
  TglPixelMapuiv = PROCEDURE { C }(map: TGLenum; mapsize: TGLsizei;  values: PGLuint); 
  TglPixelMapusv = PROCEDURE { C }(map: TGLenum; mapsize: TGLsizei;  values: PGLushort); 
  TglPixelTransferf = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglPixelTransferi = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglPixelZoom = PROCEDURE { C }(xfactor: TGLfloat; yfactor: TGLfloat); 
  TglPolygonStipple = PROCEDURE { C }( mask: PGLubyte); 
  TglPopAttrib = PROCEDURE { C }(); 
  TglPopClientAttrib = PROCEDURE { C }(); 
  TglPopMatrix = PROCEDURE { C }(); 
  TglPopName = PROCEDURE { C }(); 
  TglPrioritizeTextures = PROCEDURE { C }(n: TGLsizei; CONST textures: PGLuint; CONST priorities: PGLclampf); 
  TglPushAttrib = PROCEDURE { C }(mask: TGLbitfield); 
  TglPushClientAttrib = PROCEDURE { C }(mask: TGLbitfield); 
  TglPushMatrix = PROCEDURE { C }(); 
  TglPushName = PROCEDURE { C }(name: TGLuint); 
  TglRasterPos2d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble); 
  TglRasterPos2dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglRasterPos2f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat); 
  TglRasterPos2fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglRasterPos2i = PROCEDURE { C }(x: TGLint; y: TGLint); 
  TglRasterPos2iv = PROCEDURE { C }(CONST v: PGLint); 
  TglRasterPos2s = PROCEDURE { C }(x: TGLshort; y: TGLshort); 
  TglRasterPos2sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglRasterPos3d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglRasterPos3dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglRasterPos3f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglRasterPos3fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglRasterPos3i = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint); 
  TglRasterPos3iv = PROCEDURE { C }(CONST v: PGLint); 
  TglRasterPos3s = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglRasterPos3sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglRasterPos4d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglRasterPos4dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglRasterPos4f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglRasterPos4fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglRasterPos4i = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglRasterPos4iv = PROCEDURE { C }(CONST v: PGLint); 
  TglRasterPos4s = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglRasterPos4sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglRectd = PROCEDURE { C }(x1: TGLdouble; y1: TGLdouble; x2: TGLdouble; y2: TGLdouble); 
  TglRectdv = PROCEDURE { C }(CONST v1: PGLdouble; CONST v2: PGLdouble); 
  TglRectf = PROCEDURE { C }(x1: TGLfloat; y1: TGLfloat; x2: TGLfloat; y2: TGLfloat); 
  TglRectfv = PROCEDURE { C }(CONST v1: PGLfloat; CONST v2: PGLfloat); 
  TglRecti = PROCEDURE { C }(x1: TGLint; y1: TGLint; x2: TGLint; y2: TGLint); 
  TglRectiv = PROCEDURE { C }(CONST v1: PGLint; CONST v2: PGLint); 
  TglRects = PROCEDURE { C }(x1: TGLshort; y1: TGLshort; x2: TGLshort; y2: TGLshort); 
  TglRectsv = PROCEDURE { C }(CONST v1: PGLshort; CONST v2: PGLshort); 
  TglRenderMode =  PROCEDURE { C } (mode: TGLenum): TGLint; 
  TglRotated = PROCEDURE { C }(anTgle: TGLdouble; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglRotatef = PROCEDURE { C }(CONST angle, x, y, z: TGLfloat); 
  TglScaled = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglScalef = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglSelectBuffer = PROCEDURE { C }(size: TGLsizei; buffer: PGLuint); 
  TglShadeModel = PROCEDURE { C }(mode: TGLenum); 
  TglTexCoord1d = PROCEDURE { C }(s: TGLdouble); 
  TglTexCoord1dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglTexCoord1f = PROCEDURE { C }(s: TGLfloat); 
  TglTexCoord1fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglTexCoord1i = PROCEDURE { C }(s: TGLint); 
  TglTexCoord1iv = PROCEDURE { C }(CONST v: PGLint); 
  TglTexCoord1s = PROCEDURE { C }(s: TGLshort); 
  TglTexCoord1sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglTexCoord2d = PROCEDURE { C }(s: TGLdouble; t: TGLdouble); 
  TglTexCoord2dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglTexCoord2f = PROCEDURE { C }(s: TGLfloat; t: TGLfloat); 
  TglTexCoord2fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglTexCoord2i = PROCEDURE { C }(s: TGLint; t: TGLint); 
  TglTexCoord2iv = PROCEDURE { C }(CONST v: PGLint); 
  TglTexCoord2s = PROCEDURE { C }(s: TGLshort; t: TGLshort); 
  TglTexCoord2sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglTexCoord3d = PROCEDURE { C }(s: TGLdouble; t: TGLdouble; r: TGLdouble); 
  TglTexCoord3dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglTexCoord3f = PROCEDURE { C }(s: TGLfloat; t: TGLfloat; r: TGLfloat); 
  TglTexCoord3fv = PROCEDURE { C }(CONST v: PGLfloat);  
  TglTexCoord3i = PROCEDURE { C }(s: TGLint; t: TGLint; r: TGLint); 
  TglTexCoord3iv = PROCEDURE { C }(CONST v: PGLint); 
  TglTexCoord3s = PROCEDURE { C }(s: TGLshort; t: TGLshort; r: TGLshort); 
  TglTexCoord3sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglTexCoord4d = PROCEDURE { C }(s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); 
  TglTexCoord4dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglTexCoord4f = PROCEDURE { C }(s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); 
  TglTexCoord4fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglTexCoord4i = PROCEDURE { C }(s: TGLint; t: TGLint; r: TGLint; q: TGLint); 
  TglTexCoord4iv = PROCEDURE { C }(CONST v: PGLint); 
  TglTexCoord4s = PROCEDURE { C }(s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); 
  TglTexCoord4sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglTexCoordPointer = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglTexEnvf = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexEnvfv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexEnvi = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexEnviv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglTexGend = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; param: TGLdouble); 
  TglTexGendv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; CONST params: PGLdouble); 
  TglTexGenf = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexGenfv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexGeni = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexGeniv = PROCEDURE { C }(coord: TGLenum; pname: TGLenum; CONST params: PGLint); 


  TglTranslated = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglTranslatef = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertex2d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble); 
  TglVertex2dv = PROCEDURE { C }( v: PGLdouble); 
  TglVertex2f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat); 
  TglVertex2fv = PROCEDURE { C }( v: PGLfloat); 
  TglVertex2i = PROCEDURE { C }(x: TGLint; y: TGLint); 
  TglVertex2iv = PROCEDURE { C }( v: PGLint); 
  TglVertex2s = PROCEDURE { C }(x: TGLshort; y: TGLshort); 
  TglVertex2sv = PROCEDURE { C }( v: PGLshort); 
  TglVertex3d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertex3dv = PROCEDURE { C }( v: PGLdouble); 
  TglVertex3f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertex3fv = PROCEDURE { C }( v: PGLfloat); 
  TglVertex3i = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint); 
  TglVertex3iv = PROCEDURE { C }( v: PGLint); 
  TglVertex3s = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertex3sv = PROCEDURE { C }( v: PGLshort); 
  TglVertex4d = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertex4dv = PROCEDURE { C }( v: PGLdouble); 
  TglVertex4f = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertex4fv = PROCEDURE { C }( v: PGLfloat); 
  TglVertex4i = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertex4iv = PROCEDURE { C }( v: PGLint); 
  TglVertex4s = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertex4sv = PROCEDURE { C }( v: PGLshort); 
  TglVertexPointer = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei;  _pointer: PGLvoid); 
(*! endif *)

  (*! GL_VERSION_1_2 *)
  TglBlendColor* = PROCEDURE { C }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 
  TglBlendEquation = PROCEDURE { C }(mode: TGLenum); 
  TglDrawRangeElements = PROCEDURE { C }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 
  TglTexImage3D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage3D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglCopyTexSubImage3D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

 (*! ifdef DEPRECATED 1.2 *)
  TglColorTable = PROCEDURE { C } (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; CONST table: PGLvoid);  
  TglColorTableParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglColorTableParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglCopyColorTable = PROCEDURE { C }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);  
  TglGetColorTable = PROCEDURE { C }(target: GLenum; format: GLenum; _type: GLenum; table: PGLvoid);  
  TglGetColorTableParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetColorTableParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint);  
  TglColorSubTable = PROCEDURE { C }(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; _type: GLenum; CONST data: PGLvoid);  
  TglCopyColorSubTable = PROCEDURE { C }(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);  
  TglConvolutionFilter1D = PROCEDURE { C }(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; CONST image: PGLvoid);  
  TglConvolutionFilter2D = PROCEDURE { C }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; CONST image: PGLvoid);  
  TglConvolutionParameterf = PROCEDURE { C }(target: GLenum; pname: GLenum; params: GLfloat);  
  TglConvolutionParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglConvolutionParameteri = PROCEDURE { C }(target: GLenum; pname: GLenum; params: GLint);  
  TglConvolutionParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglCopyConvolutionFilter1D = PROCEDURE { C }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);  
  TglCopyConvolutionFilter2D = PROCEDURE { C }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetConvolutionFilter = PROCEDURE { C }(target: GLenum; format: GLenum; _type: GLenum; image: PGLvoid);  
  TglGetConvolutionParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetConvolutionParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint);  
  TglGetSeparableFilter = PROCEDURE { C }(target: GLenum; format: GLenum; _type: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);  
  TglSeparableFilter2D = PROCEDURE { C }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; CONST row: PGLvoid; CONST column: PGLvoid);  
  TglGetHistogram = PROCEDURE { C }(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid);  
  TglGetHistogramParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetHistogramParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMinmax = PROCEDURE { C }(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid);  
  TglGetMinmaxParameterfv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMinmaxParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint);  
  TglHistogram = PROCEDURE { C }(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);  
  TglMinmax = PROCEDURE { C }(target: GLenum; internalformat: GLenum; sink: GLboolean);  
  TglResetHistogram = PROCEDURE { C }(target: GLenum);  
  TglResetMinmax = PROCEDURE { C }(target: GLenum);  
(*! endif *)
  
  (*! GL_VERSION_1_3 *)
  TglActiveTexture = PROCEDURE { C }(texture: TGLenum); 
  TglSampleCoverage = PROCEDURE { C }(value: TGLclampf; invert: TGLboolean); 
  TglCompressedTexImage3D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage3D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage2D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage1D = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglGetCompressedTexImage = PROCEDURE { C }(target: TGLenum; level: TGLint; img: PGLvoid); 

(*! ifdef DEPRECATED 1.3 *)
  TglClientActiveTexture = PROCEDURE { C }(texture: GLenum);  
  TglMultiTexCoord1d = PROCEDURE { C }(target: GLenum; s: GLdouble);  
  TglMultiTexCoord1dv = PROCEDURE { C }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord1f = PROCEDURE { C }(target: GLenum; s: GLfloat);  
  TglMultiTexCoord1fv = PROCEDURE { C }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord1i = PROCEDURE { C }(target: GLenum; s: GLint);  
  TglMultiTexCoord1iv = PROCEDURE { C }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord1s = PROCEDURE { C }(target: GLenum; s: GLshort);  
  TglMultiTexCoord1sv = PROCEDURE { C }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord2d = PROCEDURE { C }(target: GLenum; s: GLdouble; t: GLdouble);  
  TglMultiTexCoord2dv = PROCEDURE { C }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord2f = PROCEDURE { C }(target: GLenum; s: GLfloat; t: GLfloat);  
  TglMultiTexCoord2fv = PROCEDURE { C }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord2i = PROCEDURE { C }(target: GLenum; s: GLint; t: GLint);  
  TglMultiTexCoord2iv = PROCEDURE { C }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord2s = PROCEDURE { C }(target: GLenum; s: GLshort; t: GLshort);  
  TglMultiTexCoord2sv = PROCEDURE { C }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord3d = PROCEDURE { C }(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);  
  TglMultiTexCoord3dv = PROCEDURE { C }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord3f = PROCEDURE { C }(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);  
  TglMultiTexCoord3fv = PROCEDURE { C }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord3i = PROCEDURE { C }(target: GLenum; s: GLint; t: GLint; r: GLint);  
  TglMultiTexCoord3iv = PROCEDURE { C }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord3s = PROCEDURE { C }(target: GLenum; s: GLshort; t: GLshort; r: GLshort);  
  TglMultiTexCoord3sv = PROCEDURE { C }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord4d = PROCEDURE { C }(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);  
  TglMultiTexCoord4dv = PROCEDURE { C }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord4f = PROCEDURE { C }(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);  
  TglMultiTexCoord4fv = PROCEDURE { C }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord4i = PROCEDURE { C }(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);  
  TglMultiTexCoord4iv = PROCEDURE { C }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord4s = PROCEDURE { C }(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);  
  TglMultiTexCoord4sv = PROCEDURE { C }(target: GLenum; CONST v: PGLshort);  
  TglLoadTransposeMatrixf = PROCEDURE { C }(CONST m: PGLfloat);  
  TglLoadTransposeMatrixd = PROCEDURE { C }(CONST m: PGLdouble);  
  TglMultTransposeMatrixf = PROCEDURE { C }(CONST m: PGLfloat);  
  TglMultTransposeMatrixd = PROCEDURE { C }(CONST m: PGLdouble);  
(*! endif *)

  
  (*! GL_VERSION_1_4 *)
  TglBlendFuncSeparate = PROCEDURE { C }(sfactorRGB: TGLenum; dfactorRGB: TGLenum; sfactorAlpha: TGLenum; dfactorAlpha: TGLenum); 
  TglMultiDrawArrays = PROCEDURE { C }(mode: TGLenum; first: PGLint; count: PGLsizei; primcount: TGLsizei); 
  TglMultiDrawElements = PROCEDURE { C }(mode: TGLenum; CONST count: PGLsizei; _type: TGLenum; CONST indices: PGLvoid; primcount: TGLsizei); 
  TglPointParameterf = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfv = PROCEDURE { C }(pname: TGLenum; CONST params: PGLfloat); 
  TglPointParameteri = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglPointParameteriv = PROCEDURE { C }(pname: TGLenum; CONST params: PGLint); 

  (*! ifdef DEPRECATED 1.4 *)
  TglFogCoordf = PROCEDURE { C }(coord: GLfloat); 
  TglFogCoordfv = PROCEDURE { C }(CONST coord: PGLfloat); 
  TglFogCoordd = PROCEDURE { C }(coord: GLdouble); 
  TglFogCoorddv = PROCEDURE { C }(CONST coord: PGLdouble); 
  TglFogCoordPointer = PROCEDURE { C }(_type: GLenum; stride: GLsizei; CONST _pointer: PGLvoid); 
  TglSecondaryColor3b = PROCEDURE { C }(red: GLbyte; green: GLbyte; blue: GLbyte); 
  TglSecondaryColor3bv = PROCEDURE { C }(CONST v: PGLbyte); 
  TglSecondaryColor3d = PROCEDURE { C }(red: GLdouble; green: GLdouble; blue: GLdouble); 
  TglSecondaryColor3dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglSecondaryColor3f = PROCEDURE { C }(red: GLfloat; green: GLfloat; blue: GLfloat); 
  TglSecondaryColor3fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglSecondaryColor3i = PROCEDURE { C }(red: GLint; green: GLint; blue: GLint); 
  TglSecondaryColor3iv = PROCEDURE { C }(CONST v: PGLint); 
  TglSecondaryColor3s = PROCEDURE { C }(red: GLshort; green: GLshort; blue: GLshort); 
  TglSecondaryColor3sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglSecondaryColor3ub = PROCEDURE { C }(red: GLubyte; green: GLubyte; blue: GLubyte); 
  TglSecondaryColor3ubv = PROCEDURE { C }(CONST v: PGLubyte); 
  TglSecondaryColor3ui = PROCEDURE { C }(red: GLuint; green: GLuint; blue: GLuint); 
  TglSecondaryColor3uiv = PROCEDURE { C }(CONST v: PGLuint); 
  TglSecondaryColor3us = PROCEDURE { C }(red: GLushort; green: GLushort; blue: GLushort); 
  TglSecondaryColor3usv = PROCEDURE { C }(CONST v: PGLushort); 
  TglSecondaryColorPointer = PROCEDURE { C }(size: GLint; _type: GLenum; stride: GLsizei; CONST _pointer: PGLvoid); 
  TglWindowPos2d = PROCEDURE { C }(x: GLdouble; y: GLdouble); 
  TglWindowPos2dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos2f = PROCEDURE { C }(x: GLfloat; y: GLfloat); 
  TglWindowPos2fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos2i = PROCEDURE { C }(x: GLint; y: GLint); 
  TglWindowPos2iv = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos2s = PROCEDURE { C }(x: GLshort; y: GLshort); 
  TglWindowPos2sv = PROCEDURE { C }(CONST v: PGLshort); 
  TglWindowPos3d = PROCEDURE { C }(x: GLdouble; y: GLdouble; z: GLdouble); 
  TglWindowPos3dv = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos3f = PROCEDURE { C }(x: GLfloat; y: GLfloat; z: GLfloat); 
  TglWindowPos3fv = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos3i = PROCEDURE { C }(x: GLint; y: GLint; z: GLint); 
  TglWindowPos3iv = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos3s = PROCEDURE { C }(x: GLshort; y: GLshort; z: GLshort); 
  TglWindowPos3sv = PROCEDURE { C }(CONST v: PGLshort); 
(*! endif *)

  (*! GL_VERSION_1_5 *)
  TglGenQueries = PROCEDURE { C }(n: GLsizei; ids: PGLuint); 
  TglDeleteQueries = PROCEDURE { C }(n: GLsizei;  ids: PGLuint); 
  TglIsQuery = PROCEDURE { C } (id: GLuint): BOOLEAN; 
  TglBeginQuery = PROCEDURE { C }(target: GLenum; id: GLuint); 
  TglEndQuery = PROCEDURE { C }(target: GLenum); 
  TglGetQueryiv = PROCEDURE { C }(target, pname: GLenum; params: PGLint); 
  TglGetQueryObjectiv = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLint); 
  TglGetQueryObjectuiv = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLuint); 
  TglBindBuffer = PROCEDURE { C }(target: TGLenum; buffer: TGLuint); 
  TglDeleteBuffers = PROCEDURE { C }(n: TGLsizei;  buffers: PGLuint ); 
  TglGenBuffers = PROCEDURE { C }(n: TGLsizei;  buffers: PGLuint); 
  TglIsBuffer = PROCEDURE { C } (buffer: TGLuint): TGLboolean; 
  TglBufferData = PROCEDURE { C }(target: TGLenum; size: TGLsizei;  data: ADDRESS; usage: TGLenum); 
  TglBufferSubData = PROCEDURE { C }(target: TGLenum; offset: TGLsizei; size: TGLsizei;  data: PGLvoid); 
  TglGetBufferSubData = PROCEDURE { C }(target: TGLenum; offset: TGLsizei; size: TGLsizei; data: PGLvoid); 
  TglMapBuffer = PROCEDURE { C } (target: TGLenum; access: TGLenum): PGLvoid; 
  TglUnmapBuffer = PROCEDURE { C } (target: TGLenum): TGLboolean; 
  TglGetBufferParameteriv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetBufferPointerv = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLvoid); 

  (*! GL_VERSION_2_0 *)
  TglBlendEquationSeparate = PROCEDURE { C }(modeRGB: GLenum; modeAlpha: GLenum); 
  TglDrawBuffers = PROCEDURE { C }(n: GLsizei;  bufs: PGLenum); 
  TglStencilOpSeparate = PROCEDURE { C }(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); 
  TglStencilFuncSeparate = PROCEDURE { C }(frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint); 
  TglStencilMaskSeparate = PROCEDURE { C }(face: GLenum; mask: GLuint); 
  TglAttachShader = PROCEDURE { C }(programObj, shaderObj: GLHandle); 
  TglBindAttribLocation = PROCEDURE { C }(programObj: GLHandle; index: GLuint; name: PGLchar); 
  TglCompileShader = PROCEDURE { C }(shaderObj: GLHandle); 
  TglCreateProgram = PROCEDURE { C }(): GLHandle; 
  TglCreateShader = PROCEDURE { C } (shaderType: GLenum): GLHandle; 
  TglDeleteProgram = PROCEDURE { C }(programObj: GLHandle); 
  TglDeleteShader = PROCEDURE { C }(shaderObj: GLHandle); 
  TglDetachShader = PROCEDURE { C }(programObj, shaderObj: GLHandle); 
  TglDisableVertexAttribArray = PROCEDURE { C }(index: GLuint); 
  TglEnableVertexAttribArray = PROCEDURE { C }(index: GLuint); 
  TglGetActiveAttrib = PROCEDURE { C }(programObj: GLHandle; index: GLuint; maxlength: GLsizei; VAR length: GLint; VAR size: GLint; VAR _type: GLenum; name: PGLchar); 
  TglGetActiveUniform = PROCEDURE { C }(programObj: GLHandle; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLchar); 
  TglGetAttachedShaders = PROCEDURE { C }(programObj: GLHandle; MaxCount: GLsizei; VAR Count: GLint; shaders: PGLuint); 
  TglGetAttribLocation = PROCEDURE { C } (programObj: GLHandle; char: PGLchar): GLint; 
  TglGetProgramiv = PROCEDURE { C }(programObj: GLHandle; pname: TGLenum; params: PGLint); 
  TglGetProgramInfoLog = PROCEDURE { C }(programObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar); 
  TglGetShaderiv = PROCEDURE { C }(shaderObj: GLHandle; pname: TGLenum; params: PGLint); 
  TglGetShaderInfoLog = PROCEDURE { C }(shaderObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar); 
  TglGetShaderSource = PROCEDURE { C }(shaderObj: GLHandle; maxlength: GLsizei; VAR length: GLsizei; source: PGLchar); 
  TglGetUniformLocation = PROCEDURE { C } (programObj: GLHandle; CONST char: PGLchar): GLint; 
  TglGetUniformfv = PROCEDURE { C }(programObj: GLHandle; location: GLint; params: PGLfloat); 
  TglGetUniformiv = PROCEDURE { C }(programObj: GLHandle; location: GLint; params: PGLint); 
  TglGetVertexAttribfv = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetVertexAttribiv = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLint); 
  TglGetVertexAttribPointerv = PROCEDURE { C }(index: GLuint; pname: GLenum; _pointer: PGLvoid); 
  TglIsProgram = PROCEDURE { C } (programObj: GLHandle) : TGLboolean; 
  TglIsShader = PROCEDURE { C } (shaderObj: GLHandle) : TGLboolean; 
  TglLinkProgram = PROCEDURE { C }(programObj: GLHandle); 
  TglShaderSource = PROCEDURE { C }(shaderObj: GLHandle; count: GLsizei; _string: PPGLchar; lengths: PGLint); 
  TglUseProgram = PROCEDURE { C }(programObj: GLHandle); 
  TglUniform1f = PROCEDURE { C }(location: GLint; v0: GLfloat); 
  TglUniform2f = PROCEDURE { C }(location: GLint; v0, v1: GLfloat); 
  TglUniform3f = PROCEDURE { C }(location: GLint; v0, v1, v2: GLfloat); 
  TglUniform4f = PROCEDURE { C }(location: GLint; v0, v1, v2, v3: GLfloat); 
  TglUniform1i = PROCEDURE { C }(location: GLint; v0: GLint); 
  TglUniform2i = PROCEDURE { C }(location: GLint; v0, v1: GLint); 
  TglUniform3i = PROCEDURE { C }(location: GLint; v0, v1, v2: GLint); 
  TglUniform4i = PROCEDURE { C }(location: GLint; v0, v1, v2, v3: GLint); 
  TglUniform1fv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform2fv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform3fv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform4fv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform1iv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform2iv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform3iv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform4iv = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniformMatrix2fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglValidateProgram = PROCEDURE { C }(programObj: GLHandle); 
  TglVertexAttrib1d = PROCEDURE { C }(index: GLuint; x: GLdouble); 
  TglVertexAttrib1dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib1f = PROCEDURE { C }(index: GLuint; x: GLfloat); 
  TglVertexAttrib1fv = PROCEDURE { C }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib1s = PROCEDURE { C }(index: GLuint; x: GLshort); 
  TglVertexAttrib1sv = PROCEDURE { C }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib2d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble); 
  TglVertexAttrib2dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib2f = PROCEDURE { C }(index: GLuint; x: GLfloat; y: GLfloat); 
  TglVertexAttrib2fv = PROCEDURE { C }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib2s = PROCEDURE { C }(index: GLuint; x: GLshort; y: GLshort); 
  TglVertexAttrib2sv = PROCEDURE { C }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib3d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglVertexAttrib3dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib3f = PROCEDURE { C }(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); 
  TglVertexAttrib3fv = PROCEDURE { C }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib3s = PROCEDURE { C }(index: GLuint; x: GLshort; y: GLshort; z: GLshort); 
  TglVertexAttrib3sv = PROCEDURE { C }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4Nbv = PROCEDURE { C }(index: GLuint; CONST v: PGLbyte); 
  TglVertexAttrib4Niv = PROCEDURE { C }(index: GLuint; CONST v: PGLint); 
  TglVertexAttrib4Nsv = PROCEDURE { C }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4Nub = PROCEDURE { C }(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); 
  TglVertexAttrib4Nubv = PROCEDURE { C }(index: GLuint; CONST v: PGLubyte); 
  TglVertexAttrib4Nuiv = PROCEDURE { C }(index: GLuint; CONST v: PGLuint); 
  TglVertexAttrib4Nusv = PROCEDURE { C }(index: GLuint; CONST v: PGLushort); 
  TglVertexAttrib4bv = PROCEDURE { C }(index: GLuint; CONST v: PGLbyte); 
  TglVertexAttrib4d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglVertexAttrib4dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib4f = PROCEDURE { C }(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); 
  TglVertexAttrib4fv = PROCEDURE { C }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib4iv = PROCEDURE { C }(index: GLuint; CONST v: PGLint); 
  TglVertexAttrib4s = PROCEDURE { C }(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); 
  TglVertexAttrib4sv = PROCEDURE { C }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubv = PROCEDURE { C }(index: GLuint; CONST v: PGLubyte); 
  TglVertexAttrib4uiv = PROCEDURE { C }(index: GLuint; CONST v: PGLuint); 
  TglVertexAttrib4usv = PROCEDURE { C }(index: GLuint; CONST v: PGLushort); 
  TglVertexAttribPointer = PROCEDURE { C }(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei;  _pointer: PGLvoid); 

  (*! GL_VERSION_2_1 *)
  TglUniformMatrix2x3fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3x2fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix2x4fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4x2fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3x4fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4x3fv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 

  (*! GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions: 
   ARB_framebuffer_object 
   ARB_map_buffer_range 
   ARB_vertex_array_object  *)
  TglColorMaski = PROCEDURE { C }(index_: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean); 
  TglGetBooleani_v = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PGLboolean); 
  TglGetIntegeri_v = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PGLint); 
  TglEnablei = PROCEDURE { C }(target: GLenum; index_: GLuint); 
  TglDisablei = PROCEDURE { C }(target: GLenum; index_: GLuint); 
  TglIsEnabledi = PROCEDURE { C } (target: GLenum; index_: GLuint): GLboolean; 
  TglBeginTransformFeedback = PROCEDURE { C }(primitiveMode: GLenum); 
  TglEndTransformFeedback = PROCEDURE { C }(); 
  TglBindBufferRange = PROCEDURE { C }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei); 
  TglBindBufferBase = PROCEDURE { C }(target: GLenum; index_: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryings = PROCEDURE { C }(program_: GLuint; count: GLsizei; CONST varyings: PPGLchar; bufferMode: GLenum); 
  TglGetTransformFeedbackVarying = PROCEDURE { C }(program_: GLuint; index_: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; type_: PGLsizei; name: PGLchar); 
  TglClampColor = PROCEDURE { C }(targe: GLenum; clamp: GLenum); 
  TglBeginConditionalRender = PROCEDURE { C }(id: GLuint; mode: GLenum); 
  TglEndConditionalRender = PROCEDURE { C }(); 
  TglVertexAttribIPointer = PROCEDURE { C }(index_: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid); 
  TglGetVertexAttribIiv = PROCEDURE { C }(index_: GLuint; pname: GLenum; params: PGLint); 
  TglGetVertexAttribIuiv = PROCEDURE { C }(index_: GLuint; pname: GLenum; params: PGLuint); 
  TglVertexAttribI1i = PROCEDURE { C }(index_: GLuint; x: GLint); 
  TglVertexAttribI2i = PROCEDURE { C }(index_: GLuint; x: GLint; y: GLint); 
  TglVertexAttribI3i = PROCEDURE { C }(index_: GLuint; x: GLint; y: GLint; z: GLint); 
  TglVertexAttribI4i = PROCEDURE { C }(index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); 
  TglVertexAttribI1ui = PROCEDURE { C }(index_: GLuint; x: GLuint); 
  TglVertexAttribI2ui = PROCEDURE { C }(index_: GLuint; x: GLuint; y: GLuint); 
  TglVertexAttribI3ui = PROCEDURE { C }(index_: GLuint; x: GLuint; y: GLuint; z: GLuint); 
  TglVertexAttribI4ui = PROCEDURE { C }(index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); 
  TglVertexAttribI1iv = PROCEDURE { C }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI2iv = PROCEDURE { C }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI3iv = PROCEDURE { C }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI4iv = PROCEDURE { C }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI1uiv = PROCEDURE { C }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI2uiv = PROCEDURE { C }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI3uiv = PROCEDURE { C }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI4uiv = PROCEDURE { C }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI4bv = PROCEDURE { C }(index_: GLuint; CONST v: PGLbyte); 
  TglVertexAttribI4sv = PROCEDURE { C }(index_: GLuint; CONST v: PGLshort); 
  TglVertexAttribI4ubv = PROCEDURE { C }(index_: GLuint; CONST v: PGLubyte); 
  TglVertexAttribI4usv = PROCEDURE { C }(index_: GLuint; CONST v: PGLushort); 
  TglGetUniformuiv = PROCEDURE { C }(program_: GLuint; location: GLint; params: PGLuint); 
  TglBindFragDataLocation = PROCEDURE { C }(program_: GLuint; color: GLuint; CONST name: PGLchar); 
  TglGetFragDataLocation = PROCEDURE { C } (program_: GLuint; CONST name: PGLchar): GLint; 
  TglUniform1ui = PROCEDURE { C }(location: GLint; v0: GLuint); 
  TglUniform2ui = PROCEDURE { C }(location: GLint; v0: GLuint; v1: GLuint); 
  TglUniform3ui = PROCEDURE { C }(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); 
  TglUniform4ui = PROCEDURE { C }(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); 
  TglUniform1uiv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform2uiv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform3uiv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform4uiv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglTexParameterIiv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLint); 
  TglTexParameterIuiv = PROCEDURE { C }(target: GLenum; pname: GLenum; CONST params: PGLuint); 
  TglGetTexParameterIiv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint); 
  TglGetTexParameterIuiv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLuint); 
  TglClearBufferiv = PROCEDURE { C }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLint); 
  TglClearBufferuiv = PROCEDURE { C }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLuint); 
  TglClearBufferfv = PROCEDURE { C }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLfloat); 
  TglClearBufferfi = PROCEDURE { C }(buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint); 
  TglGetStringi = PROCEDURE { C } (name: GLenum; index: GLuint): PGLubyte; 

  (*! GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions: 
   ARB_copy_buffer 
   ARB_uniform_buffer_object  *)
  TglDrawArraysInstanced = PROCEDURE { C }(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); 
  TglDrawElementsInstanced = PROCEDURE { C }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei); 
  TglTexBuffer = PROCEDURE { C }(target: GLenum; internalformat: GLenum; buffer: GLuint); 
  TglPrimitiveRestartIndex = PROCEDURE { C }(index_: GLuint); 

  (*! GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions: 
   ARB_draw_elements_base_vertex 
   ARB_provoking_vertex 
   ARB_sync 
   ARB_texture_multisample  *)
  TglGetInteger64i_v = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PGLint64); 
  TglGetBufferParameteri64v = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint64); 
  TglFramebufferTexture = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTextureFace = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); 

(*! GL_VERSION_3_3 *)
  (* OpenGL 3.3 also reuses entry points from these extensions: *)
  (* ARB_blend_func_extended *)
  (* ARB_sampler_objects *)
  (* ARB_explicit_attrib_location, but it has none *)
  (* ARB_occlusion_query2 (no entry points) *)
  (* ARB_shader_bit_encoding (no entry points) *)
  (* ARB_texture_rgb10_a2ui (no entry points) *)
  (* ARB_texture_swizzle (no entry points) *)
  (* ARB_timer_query *)
  (* ARB_vertex_type_2_10_10_10_rev *)
  TglVertexAttribDivisor = PROCEDURE { C } (index: GLuint; divisor: GLuint); 
 
 
   (*! GL_VERSION_4_0 *)
  (* OpenGL 4.0 also reuses entry points from these extensions: *)
  (* ARB_texture_query_lod (no entry points) *)
  (* ARB_draw_indirect *)
  (* ARB_gpu_shader5 (no entry points) *)
  (* ARB_gpu_shader_fp64 *)
  (* ARB_shader_subroutine *)
  (* ARB_tessellation_shader *)
  (* ARB_texture_buffer_object_rgb32 (no entry points) *)
  (* ARB_texture_cube_map_array (no entry points) *)
  (* ARB_texture_gather (no entry points) *)
  (* ARB_transform_feedback2 *)
  (* ARB_transform_feedback3 *)
  TglMinSampleShading = PROCEDURE { C }(value: GLclampf); 
  TglBlendEquationi = PROCEDURE { C }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparatei = PROCEDURE { C }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 
  TglBlendFunci = PROCEDURE { C }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparatei = PROCEDURE { C }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 

  (*! GL_VERSION_4_1 *)
  (* OpenGL 4.1 also reuses entry points from these extensions: *)
  (* ARB_ES2_compatibility *)
  (* ARB_get_program_binary *)
  (* ARB_separate_shader_objects *)
  (* ARB_shader_precision (no entry points) *)
  (* ARB_vertex_attrib_64bit *)
  (* ARB_viewport_array *)
  
  
 (* GL_3DFX_tbuffer *)
  TglTbufferMask3DFX = PROCEDURE { C }(mask: TGLuint); 


  (* GL_ARB_matrix_palette *)
  TglCurrentPaletteMatrixARB = PROCEDURE { C }(index: TGLint); 
  TglMatrixIndexubvARB = PROCEDURE { C }(size: TGLint; CONST indices: PGLubyte); 
  TglMatrixIndexusvARB = PROCEDURE { C }(size: TGLint; CONST indices: PGLushort); 
  TglMatrixIndexuivARB = PROCEDURE { C }(size: TGLint; CONST indices: PGLuint); 
  TglMatrixIndexPointerARB = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_ARB_multisample *)
  TglSampleCoverageARB = PROCEDURE { C }(value: TGLclampf; invert: TGLboolean); 

  (* GL_ARB_multitexture *)
  TglActiveTextureARB = PROCEDURE { C }(texture: TGLenum); 
  TglClientActiveTextureARB = PROCEDURE { C }(texture: TGLenum); 
  TglMultiTexCoord1dARB = PROCEDURE { C }(target: TGLenum; s: TGLdouble); 
  TglMultiTexCoord1dvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord1fARB = PROCEDURE { C }(target: TGLenum; s: TGLfloat); 
  TglMultiTexCoord1fvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord1iARB = PROCEDURE { C }(target: TGLenum; s: TGLint); 
  TglMultiTexCoord1ivARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord1sARB = PROCEDURE { C }(target: TGLenum; s: TGLshort); 
  TglMultiTexCoord1svARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord2dARB = PROCEDURE { C }(target: TGLenum; s: TGLdouble; t: TGLdouble); 
  TglMultiTexCoord2dvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord2fARB = PROCEDURE { C }(target: TGLenum; s: TGLfloat; t: TGLfloat); 
  TglMultiTexCoord2fvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord2iARB = PROCEDURE { C }(target: TGLenum; s: TGLint; t: TGLint); 
  TglMultiTexCoord2ivARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord2sARB = PROCEDURE { C }(target: TGLenum; s: TGLshort; t: TGLshort); 
  TglMultiTexCoord2svARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord3dARB = PROCEDURE { C }(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble); 
  TglMultiTexCoord3dvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord3fARB = PROCEDURE { C }(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat); 
  TglMultiTexCoord3fvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord3iARB = PROCEDURE { C }(target: TGLenum; s: TGLint; t: TGLint; r: TGLint); 
  TglMultiTexCoord3ivARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord3sARB = PROCEDURE { C }(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort); 
  TglMultiTexCoord3svARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord4dARB = PROCEDURE { C }(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); 
  TglMultiTexCoord4dvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord4fARB = PROCEDURE { C }(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); 
  TglMultiTexCoord4fvARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord4iARB = PROCEDURE { C }(target: TGLenum; s: TGLint; t: TGLint; r: TGLint; q: TGLint); 
  TglMultiTexCoord4ivARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord4sARB = PROCEDURE { C }(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); 
  TglMultiTexCoord4svARB = PROCEDURE { C }(target: TGLenum; CONST v: PGLshort); 

  (* GL_ARB_point_parameters *)
  TglPointParameterfARB = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfvARB = PROCEDURE { C }(pname: TGLenum; CONST params: PGLfloat); 

  (* GL_ARB_texture_compression *)
  TglCompressedTexImage3DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage2DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage1DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage3DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage2DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage1DARB = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglGetCompressedTexImageARB = PROCEDURE { C }(target: TGLenum; level: TGLint; img: PGLvoid); 

  (* GL_ARB_transpose_matrix *)
  TglLoadTransposeMatrixfARB = PROCEDURE { C }(CONST m: PGLfloat); 
  TglLoadTransposeMatrixdARB = PROCEDURE { C }(CONST m: PGLdouble); 
  TglMultTransposeMatrixfARB = PROCEDURE { C }(CONST m: PGLfloat); 
  TglMultTransposeMatrixdARB = PROCEDURE { C }(CONST m: PGLdouble); 

  (* GL_ARB_vertex_blend *)
  TglWeightbvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLbyte); 
  TglWeightsvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLshort); 
  TglWeightivARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLint); 
  TglWeightfvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLfloat); 
  TglWeightdvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLdouble); 
  TglWeightubvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLubyte); 
  TglWeightusvARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLushort); 
  TglWeightuivARB = PROCEDURE { C }(size: TGLint; CONST weights: PGLuint); 
  TglWeightPointerARB = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexBlendARB = PROCEDURE { C }(count: TGLint); 

  (* GL_ARB_vertex_buffer_object *)
  TglBindBufferARB = PROCEDURE { C }(target: TGLenum; buffer: TGLuint); 
  TglDeleteBuffersARB = PROCEDURE { C }(n: TGLsizei;  buffers: PGLuint); 
  TglGenBuffersARB = PROCEDURE { C }(n: TGLsizei; buffers: PGLuint ); 
  TglIsBufferARB = PROCEDURE { C } (buffer: TGLuint): TGLboolean; 
  TglBufferDataARB = PROCEDURE { C }(target: TGLenum; size: TGLsizei;  data: PGLvoid; usage: TGLenum); 
  TglBufferSubDataARB = PROCEDURE { C }(target: TGLenum; offset: TGLsizei; size: TGLsizei;  data: PGLvoid); 
  TglGetBufferSubDataARB = PROCEDURE { C }(target: TGLenum; offset: TGLsizei; size: TGLsizei; data: PGLvoid); 
  TglMapBufferARB = PROCEDURE { C } (target: TGLenum; access: TGLenum): PGLvoid; 
  TglUnmapBufferARB = PROCEDURE { C }( target: TGLenum): TGLboolean; 
  TglGetBufferParameterivARB = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetBufferPointervARB = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLvoid); 

  (* GL_ARB_vertex_program *)
  TglVertexAttrib1dARB = PROCEDURE { C }(index: TGLuint; x: TGLdouble); 
  TglVertexAttrib1dvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib1fARB = PROCEDURE { C }(index: TGLuint; x: TGLfloat); 
  TglVertexAttrib1fvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib1sARB = PROCEDURE { C }(index: TGLuint; x: TGLshort); 
  TglVertexAttrib1svARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib2dARB = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble); 
  TglVertexAttrib2dvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib2fARB = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat); 
  TglVertexAttrib2fvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib2sARB = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort); 
  TglVertexAttrib2svARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib3dARB = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexAttrib3dvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib3fARB = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexAttrib3fvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib3sARB = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexAttrib3svARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4NbvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttrib4NivARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttrib4NsvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4NubARB = PROCEDURE { C }(index: TGLuint; x: TGLubyte; y: TGLubyte; z: TGLubyte; w: TGLubyte); 
  TglVertexAttrib4NubvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttrib4NuivARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttrib4NusvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttrib4bvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttrib4dARB = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexAttrib4dvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib4fARB = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexAttrib4fvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib4ivARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttrib4sARB = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexAttrib4svARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttrib4uivARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttrib4usvARB = PROCEDURE { C }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttribPointerARB = PROCEDURE { C }(index: TGLuint; size: TGLint; _type: TGLenum; normalized: TGLboolean; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglEnableVertexAttribArrayARB = PROCEDURE { C }(index: TGLuint); 
  TglDisableVertexAttribArrayARB = PROCEDURE { C }(index: TGLuint); 
  TglProgramStringARB = PROCEDURE { C }(target: TGLenum; format: TGLenum; len: TGLsizei; CONST _string: PGLvoid); 
  TglBindProgramARB = PROCEDURE { C }(target: TGLenum; _program: TGLuint); 
  TglDeleteProgramsARB = PROCEDURE { C }(n: TGLsizei; CONST programs: PGLuint); 
  TglGenProgramsARB = PROCEDURE { C }(n: TGLsizei; programs: PGLuint); 
  TglProgramEnvParameter4dARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramEnvParameter4dvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLdouble); 
  TglProgramEnvParameter4fARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramEnvParameter4fvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLfloat); 
  TglProgramLocalParameter4dARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramLocalParameter4dvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLdouble); 
  TglProgramLocalParameter4fARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramLocalParameter4fvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLfloat); 
  TglGetProgramEnvParameterdvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLdouble); 
  TglGetProgramEnvParameterfvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLfloat); 
  TglGetProgramLocalParameterdvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLdouble); 
  TglGetProgramLocalParameterfvARB = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLfloat); 
  TglGetProgramivARB = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetProgramStringARB = PROCEDURE { C }(target: TGLenum; pname: TGLenum; _string: PGLvoid); 
  TglGetVertexAttribdvARB = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetVertexAttribfvARB = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribivARB = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribPointervARB = PROCEDURE { C }(index: TGLuint; pname: TGLenum; _pointer: PGLvoid); 
  TglIsProgramARB = PROCEDURE { C } (_program: TGLuint): TGLboolean; 

  (* GL_ARB_window_pos *)
  TglWindowPos2dARB = PROCEDURE { C }(x: TGLdouble; y: TGLdouble); 
  TglWindowPos2dvARB = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos2fARB = PROCEDURE { C }(x: TGLfloat; y: TGLfloat); 
  TglWindowPos2fvARB = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos2iARB = PROCEDURE { C }(x: TGLint; y: TGLint); 
  TglWindowPos2ivARB = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos2sARB = PROCEDURE { C }(x: TGLshort; y: TGLshort); 
  TglWindowPos2svARB = PROCEDURE { C }(CONST v: PGLshort); 
  TglWindowPos3dARB = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglWindowPos3dvARB = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos3fARB = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglWindowPos3fvARB = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos3iARB = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint); 
  TglWindowPos3ivARB = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos3sARB = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglWindowPos3svARB = PROCEDURE { C }(CONST v: PGLshort); 

  (* GL_ARB_draw_buffers *)
  TglDrawBuffersARB = PROCEDURE { C }(n: TGLsizei; bufs: PGLenum); 

  (* GL_ARB_color_buffer_float *)
  TglClampColorARB = PROCEDURE { C }(target: TGLenum; clamp: TGLenum); 

  (* GL_ARB_vertex_shader *)
  TglGetActiveAttribARB = PROCEDURE { C }(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLcharARB); 
  TglGetAttribLocationARB = PROCEDURE { C } (programObj: GLHandleARB; CONST char: PGLcharARB): GLint; 
  TglBindAttribLocationARB = PROCEDURE { C }(programObj: GLHandleARB; index: GLuint; CONST name: PGLcharARB); 

  (* GL_ARB_shader_objects *)
  TglDeleteObjectARB = PROCEDURE { C }(Obj: GLHandleARB); 
  TglGetHandleARB = PROCEDURE { C } (pname: GLenum): GLHandleARB; 
  TglDetachObjectARB = PROCEDURE { C }(container, attached: GLHandleARB); 
  TglCreateShaderObjectARB = PROCEDURE { C } (shaderType: GLenum): GLHandleARB; 
  TglShaderSourceARB = PROCEDURE { C }(shaderObj: GLHandleARB; count: GLsizei; _string: PPGLcharARB; lengths: PGLint); 
  TglCompileShaderARB = PROCEDURE { C }(shaderObj: GLHandleARB); 
  TglCreateProgramObjectARB = PROCEDURE { C }(): GLHandleARB; 
  TglAttachObjectARB = PROCEDURE { C }(programObj, shaderObj: GLHandleARB); 
  TglLinkProgramARB = PROCEDURE { C }(programObj: GLHandleARB); 
  TglUseProgramObjectARB = PROCEDURE { C }(programObj: GLHandleARB); 
  TglValidateProgramARB = PROCEDURE { C }(programObj: GLHandleARB); 
  TglUniform1fARB = PROCEDURE { C }(location: GLint; v0: GLfloat); 
  TglUniform2fARB = PROCEDURE { C }(location: GLint; v0, v1: GLfloat); 
  TglUniform3fARB = PROCEDURE { C }(location: GLint; v0, v1, v2: GLfloat); 
  TglUniform4fARB = PROCEDURE { C }(location: GLint; v0, v1, v2, v3: GLfloat); 
  TglUniform1iARB = PROCEDURE { C }(location: GLint; v0: GLint); 
  TglUniform2iARB = PROCEDURE { C }(location: GLint; v0, v1: GLint); 
  TglUniform3iARB = PROCEDURE { C }(location: GLint; v0, v1, v2: GLint); 
  TglUniform4iARB = PROCEDURE { C }(location: GLint; v0, v1, v2, v3: GLint); 
  TglUniform1fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform2fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform3fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform4fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform1ivARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform2ivARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform3ivARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform4ivARB = PROCEDURE { C }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniformMatrix2fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4fvARB = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglGetObjectParameterfvARB = PROCEDURE { C }(Obj: GLHandleARB; pname: GLenum; params: PGLfloat); 
  TglGetObjectParameterivARB = PROCEDURE { C }(Obj: GLHandleARB; pname: GLenum; params: PGLint); 
  TglGetInfoLogARB = PROCEDURE { C }(shaderObj: GLHandleARB; maxLength: GLsizei; VAR length: GLint; infoLog: PGLcharARB); 
  TglGetAttachedObjectsARB = PROCEDURE { C }(programobj: GLHandleARB; maxCount: GLsizei; VAR count: GLsizei; objects: PGLHandleARB); 
  TglGetUniformLocationARB = PROCEDURE { C } (programObj: GLHandleARB; CONST char: PGLcharARB): GLint; 
  TglGetActiveUniformARB = PROCEDURE { C }(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLcharARB); 
  TglGetUniformfvARB = PROCEDURE { C }(programObj: GLHandleARB; location: GLint; params: PGLfloat); 
  TglGetUniformivARB = PROCEDURE { C }(programObj: GLHandleARB; location: GLint; params: PGLint); 
  TglGetShaderSourceARB = PROCEDURE { C }(shader: GLHandleARB; maxLength: GLsizei; VAR length: GLsizei; source: PGLcharARB); 

  (* GL_ARB_Occlusion_Query *)
  TglGenQueriesARB = PROCEDURE { C }(n: GLsizei; ids: PGLuint); 
  TglDeleteQueriesARB = PROCEDURE { C }(n: GLsizei; CONST ids: PGLuint); 
  TglIsQueryARB = PROCEDURE { C } (id: GLuint): BOOLEAN; 
  TglBeginQueryARB = PROCEDURE { C }(target: GLenum; id: GLuint); 
  TglEndQueryARB = PROCEDURE { C }(target: GLenum); 
  TglGetQueryivARB = PROCEDURE { C }(target, pname: GLenum; params: PGLint); 
  TglGetQueryObjectivARB = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLint); 
  TglGetQueryObjectuivARB = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLuint); 

  (* GL_ARB_draw_instanced *)
  TglDrawArraysInstancedARB = PROCEDURE { C }(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); 
  TglDrawElementsInstancedARB = PROCEDURE { C }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei); 

  (* GL_ARB_framebuffer_object *)
  TglIsRenderbuffer = PROCEDURE { C } (renderbuffer: GLuint): GLboolean; 
  TglBindRenderbuffer = PROCEDURE { C }(target: GLenum; renderbuffer: GLuint); 
  TglDeleteRenderbuffers = PROCEDURE { C }(n: GLsizei;  renderbuffers: PGLuint); 
  TglGenRenderbuffers = PROCEDURE { C }(n: GLsizei; renderbuffers: PGLuint); 
  TglRenderbufferStorage = PROCEDURE { C }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); 
  TglGetRenderbufferParameteriv = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLint); 
  TglIsFramebuffer = PROCEDURE { C } (framebuffer: GLuint): GLboolean; 
  TglBindFramebuffer = PROCEDURE { C }(target: GLenum; framebuffer: GLuint); 
  TglDeleteFramebuffers = PROCEDURE { C }(n: GLsizei;  framebuffers: PGLuint); 
  TglGenFramebuffers = PROCEDURE { C }(n: GLsizei; framebuffers: PGLuint); 
  TglCheckFramebufferStatus = PROCEDURE { C } (target: GLenum): GLenum; 
  TglFramebufferTexture1D = PROCEDURE { C }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTexture2D = PROCEDURE { C }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTexture3D = PROCEDURE { C }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); 
  TglFramebufferRenderbuffer = PROCEDURE { C }(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); 
  TglGetFramebufferAttachmentParameteriv = PROCEDURE { C }(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); 
  TglGenerateMipmap = PROCEDURE { C }(target: GLenum); 
  TglBlitFramebuffer = PROCEDURE { C }(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); 
  TglRenderbufferStorageMultisample = PROCEDURE { C }(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); 
  TglFramebufferTextureLayer = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); 

  (* GL_ARB_geometry_shader4 *)
  TglProgramParameteriARB = PROCEDURE { C }(program_: GLuint; pname: GLenum; value: GLint); 
  TglFramebufferTextureARB = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTextureLayerARB = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); 
  TglFramebufferTextureFaceARB = PROCEDURE { C }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); 

  (* GL_ARB_instanced_arrays *)
  TglVertexAttribDivisorARB = PROCEDURE { C }(index_: GLuint; divisor: GLuint); 

  (* GL_ARB_map_buffer_range *)
  TglMapBufferRange = PROCEDURE { C } (target: GLenum; offset: GLsizei; length: GLsizei; access: GLbitfield): PGLvoid; 
  TglFlushMappedBufferRange = PROCEDURE { C }(target: GLenum; offset: GLsizei; length: GLsizei); 

  (* GL_ARB_texture_buffer_object *)
  TglTexBufferARB = PROCEDURE { C }(target: GLenum; internalformat: GLenum; buffer: GLuint); 

  (* GL_ARB_vertex_array_object *)
  TglBindVertexArray = PROCEDURE { C }(array_: GLuint); 
  TglDeleteVertexArrays = PROCEDURE { C }(n: GLsizei;  arrays: PGLuint); 
  TglGenVertexArrays = PROCEDURE { C }(n: GLsizei; arrays: PGLuint); 
  TglIsVertexArray = PROCEDURE { C } (array_: GLuint): GLboolean; 

  (* GL_ARB_uniform_buffer_object *)
  TglGetUniformIndices = PROCEDURE { C }(program_: GLuint; uniformCount: GLsizei; CONST uniformNames: PPGLchar; uniformIndices: PGLuint); 
  TglGetActiveUniformsiv = PROCEDURE { C }(program_: GLuint; uniformCount: GLsizei; CONST uniformIndices: PGLuint; pname: GLenum; params: PGLint); 
  TglGetActiveUniformName = PROCEDURE { C }(program_: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar); 
  TglGetUniformBlockIndex = PROCEDURE { C } (program_: GLuint; CONST uniformBlockName: PGLchar): GLuint; 
  TglGetActiveUniformBlockiv = PROCEDURE { C }(program_: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint); 
  TglGetActiveUniformBlockName = PROCEDURE { C }(program_: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar); 
  TglUniformBlockBinding = PROCEDURE { C }(program_: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint); 

  (* GL_ARB_copy_buffer *)
  TglCopyBufferSubData = PROCEDURE { C }(readTarget: GLenum; writeTarget: GLenum; readOffset: GLint; writeOffset: GLint; size: GLsizei); 

  (* GL_ARB_draw_elements_base_vertex *)
  TglDrawElementsBaseVertex = PROCEDURE { C }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; basevertex: GLint); 
  TglDrawRangeElementsBaseVertex = PROCEDURE { C }(mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; basevertex: GLint); 
  TglDrawElementsInstancedBaseVertex = PROCEDURE { C }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei; basevertex: GLint); 
  TglMultiDrawElementsBaseVertex = PROCEDURE { C }(mode: GLenum; CONST count: PGLsizei; type_: GLenum; CONST indices: PPGLvoid; primcount: GLsizei; CONST basevertex: PGLint); 

  (* GL_ARB_provoking_vertex *)
  TglProvokingVertex = PROCEDURE { C }(mode: GLenum); 

  (* GL_ARB_sync *)
  TglFenceSync = PROCEDURE { C } (condition: GLenum; flags: GLbitfield): GLsync; 
  TglIsSync = PROCEDURE { C } (sync: GLsync): GLboolean; 
  TglDeleteSync = PROCEDURE { C }(sync: GLsync); 
  TglClientWaitSync = PROCEDURE { C } (sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum; 
  TglWaitSync = PROCEDURE { C }(sync: GLsync; flags: GLbitfield; timeout: GLuint64); 
  TglGetInteger64v = PROCEDURE { C }(pname: GLenum; params: PGLint64); 
  TglGetSynciv = PROCEDURE { C }(sync: GLsync; pname: GLenum; butSize: GLsizei; length: PGLsizei; values: PGLint); 

  (* GL_ARB_texture_multisample *)
  TglTexImage2DMultisample = PROCEDURE { C }(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); 
  TglTexImage3DMultisample = PROCEDURE { C }(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); 
  TglGetMultisamplefv = PROCEDURE { C }(pname: GLenum; index_: GLuint; val: PGLfloat); 
  TglSampleMaski = PROCEDURE { C }(index_: GLuint; mask: GLbitfield); 

  (* GL_ARB_draw_buffers_blend *)
  TglBlendEquationiARB = PROCEDURE { C }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparateiARB = PROCEDURE { C }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 
  TglBlendFunciARB = PROCEDURE { C }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparateiARB = PROCEDURE { C }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 

  (* GL_ARB_sample_shading *)
  TglMinSampleShadingARB = PROCEDURE { C }(value: GLclampf); 

    (*  GL_ARB_shading_language_include *)
  TglNamedStringARB = PROCEDURE { C }(type_: GLenum; namelen: GLint; CONST name: PGLchar; stringlen: GLint; CONST string_: PGLchar); 
  TglDeleteNamedStringARB = PROCEDURE { C }(namelen: GLint; CONST name: PGLchar); 
  TglCompileShaderIncludeARB = PROCEDURE { C } (shader: GLuint; count: GLsizei; CONST path: PPGLchar; CONST length: PGLint); 
  TglIsNamedStringARB = PROCEDURE { C }(namelen: GLint; CONST name: PGLchar): GLboolean; 
  TglGetNamedStringARB = PROCEDURE { C }(namelen: GLint; CONST name: PGLchar; bufSize: GLsizei; stringlen: GLint; string_: PGLchar); 
  TglGetNamedStringivARB = PROCEDURE { C }(namelen: GLint; CONST name: PGLchar; pname: GLenum; params: PGLint); 

  (*  GL_ARB_blend_func_extended *)
  TglBindFragDataLocationIndexed = PROCEDURE { C }(program_: GLuint; colorNumber: GLuint; index: GLuint; CONST name: PGLchar); 
  TglGetFragDataIndex = PROCEDURE { C }(program_: GLuint; CONST name: PGLchar): GLint; 

  (*  GL_ARB_sampler_objects *)
  TglGenSamplers = PROCEDURE { C }(count: GLsizei; samplers: PGLuint); 
  TglDeleteSamplers = PROCEDURE { C }(count: GLsizei; CONST samplers: PGLuint); 
  TglIsSampler = PROCEDURE { C }(sampler: GLuint): GLboolean; 
  TglBindSampler = PROCEDURE { C }(unit_: GLuint; sampler: GLuint); 
  TglSamplerParameteri = PROCEDURE { C }(sampler: GLuint; pname: GLenum; param: GLint); 
  TglSamplerParameteriv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; CONST param: PGLint); 
  TglSamplerParameterf = PROCEDURE { C }(sampler: GLuint; pname: GLenum; param: GLfloat); 
  TglSamplerParameterfv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; CONST param: PGLfloat); 
  TglSamplerParameterIiv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; CONST param: PGLint); 
  TglSamplerParameterIuiv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; CONST param: PGLuint); 
  TglGetSamplerParameteriv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; params: PGLint); 
  TglGetSamplerParameterIiv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; params: PGLint); 
  TglGetSamplerParameterfv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetSamplerParameterIuiv = PROCEDURE { C }(sampler: GLuint; pname: GLenum; params: PGLuint); 

  (*  GL_ARB_timer_query *)
  TglQueryCounter = PROCEDURE { C }(id: GLuint; target: GLenum); 
  TglGetQueryObjecti64v = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLint64); 
  TglGetQueryObjectui64v = PROCEDURE { C }(id: GLuint; pname: GLenum; params: PGLuint64); 

  (*  GL_ARB_vertex_type_2_10_10_10_rev *)
  TglVertexP2ui = PROCEDURE { C }(type_: GLenum; value: GLuint); 
  TglVertexP2uiv = PROCEDURE { C }(type_: GLenum; CONST value: PGLuint); 
  TglVertexP3ui = PROCEDURE { C }(type_: GLenum; value: GLuint); 
  TglVertexP3uiv = PROCEDURE { C }(type_: GLenum; CONST value: PGLuint); 
  TglVertexP4ui = PROCEDURE { C }(type_: GLenum; value: GLuint); 
  TglVertexP4uiv = PROCEDURE { C }(type_: GLenum; CONST value: PGLuint); 
  TglTexCoordP1ui = PROCEDURE { C }(type_: GLenum; coords: GLuint); 
  TglTexCoordP1uiv = PROCEDURE { C }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP2ui = PROCEDURE { C }(type_: GLenum; coords: GLuint); 
  TglTexCoordP2uiv = PROCEDURE { C }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP3ui = PROCEDURE { C }(type_: GLenum; coords: GLuint); 
  TglTexCoordP3uiv = PROCEDURE { C }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP4ui = PROCEDURE { C }(type_: GLenum; coords: GLuint); 
  TglTexCoordP4uiv = PROCEDURE { C }(type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP1ui = PROCEDURE { C }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP1uiv = PROCEDURE { C }(texture: GLenum; type_: GLenum; CONST coords: GLuint); 
  TglMultiTexCoordP2ui = PROCEDURE { C }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP2uiv = PROCEDURE { C }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP3ui = PROCEDURE { C }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP3uiv = PROCEDURE { C }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP4ui = PROCEDURE { C }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP4uiv = PROCEDURE { C }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglNormalP3ui = PROCEDURE { C }(type_: GLenum; coords: GLuint); 
  TglNormalP3uiv = PROCEDURE { C }(type_: GLenum; CONST coords: PGLuint); 
  TglColorP3ui = PROCEDURE { C }(type_: GLenum; color: GLuint); 
  TglColorP3uiv = PROCEDURE { C }(type_: GLenum; CONST color: PGLuint); 
  TglColorP4ui = PROCEDURE { C }(type_: GLenum; color: GLuint); 
  TglColorP4uiv = PROCEDURE { C }(type_: GLenum; CONST color: GLuint); 
  TglSecondaryColorP3ui = PROCEDURE { C }(type_: GLenum; color: GLuint); 
  TglSecondaryColorP3uiv = PROCEDURE { C }(type_: GLenum; CONST color: PGLuint); 
  TglVertexAttribP1ui = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP1uiv = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP2ui = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP2uiv = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP3ui = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP3uiv = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP4ui = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP4uiv = PROCEDURE { C }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 

  (*  GL_ARB_draw_indirect *)
  TglDrawArraysIndirect = PROCEDURE { C }(mode: GLenum; CONST indirect: PGLvoid); 
  TglDrawElementsIndirect = PROCEDURE { C }(mode: GLenum; type_: GLenum; CONST indirect: PGLvoid); 

  (*  GL_ARB_gpu_shader_fp64 *)
  TglUniform1d = PROCEDURE { C }(location: GLint; x: GLdouble); 
  TglUniform2d = PROCEDURE { C }(location: GLint; x: GLdouble; y: GLdouble); 
  TglUniform3d = PROCEDURE { C }(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglUniform4d = PROCEDURE { C }(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglUniform1dv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform2dv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform3dv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform4dv = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniformMatrix2dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix2x3dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix2x4dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3x2dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3x4dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4x2dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4x3dv = PROCEDURE { C }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglGetUniformdv = PROCEDURE { C }(program_: GLuint; location: GLint; params: PGLdouble); 

  (*  GL_ARB_shader_subroutine *)
  TglGetSubroutineUniformLocation = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; CONST name: PGLchar): GLint; 
  TglGetSubroutineIndex = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; CONST name: PGLchar): GLuint; 
  TglGetActiveSubroutineUniformiv = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint); 
  TglGetActiveSubroutineUniformName = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); 
  TglGetActiveSubroutineName = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); 
  TglUniformSubroutinesuiv = PROCEDURE { C }(shadertype: GLenum; count: GLsizei; CONST indices: PGLuint); 
  TglGetUniformSubroutineuiv = PROCEDURE { C }(shadertype: GLenum; location: GLint; params: PGLuint); 
  TglGetProgramStageiv = PROCEDURE { C }(program_: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint); 

  (*  GL_ARB_tessellation_shader *)
  TglPatchParameteri = PROCEDURE { C }(pname: GLenum; value: GLint); 
  TglPatchParameterfv = PROCEDURE { C }(pname: GLenum; CONST values: PGLfloat); 

  (*  GL_ARB_transform_feedback2 *)
  TglBindTransformFeedback = PROCEDURE { C }(target: GLenum; id: GLuint); 
  TglDeleteTransformFeedbacks = PROCEDURE { C }(n: GLsizei; CONST ids: PGLuint); 
  TglGenTransformFeedbacks = PROCEDURE { C }(n: GLsizei; ids: PGLuint); 
  TglIsTransformFeedback = PROCEDURE { C }(id: GLuint): GLboolean; 
  TglPauseTransformFeedback = PROCEDURE { C }(); 
  TglResumeTransformFeedback = PROCEDURE { C }(); 
  TglDrawTransformFeedback = PROCEDURE { C }(mode: GLenum; id: GLuint); 

  (*  GL_ARB_transform_feedback3 *)
  TglDrawTransformFeedbackStream = PROCEDURE { C }(mode: GLenum; id: GLuint; stream: GLuint); 
  TglBeginQueryIndexed = PROCEDURE { C }(target: GLenum; index: GLuint; id: GLuint); 
  TglEndQueryIndexed = PROCEDURE { C }(target: GLenum; index: GLuint); 
  TglGetQueryIndexediv = PROCEDURE { C }(target: GLenum; index: GLuint; pname: GLenum; params: PGLint); 

  (*  GL_ARB_ES2_compatibility *)
  TglReleaseShaderCompiler = PROCEDURE { C }(); 
  TglShaderBinary = PROCEDURE { C }(count: GLsizei; CONST shaders: PGLuint; binaryformat: GLenum; CONST binary: PGLvoid; length: GLsizei); 
  TglGetShaderPrecisionFormat = PROCEDURE { C }(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint); 
  TglDepthRangef = PROCEDURE { C }(n: GLclampf; f: GLclampf); 
  TglClearDepthf = PROCEDURE { C }(d: GLclampf); 

  (* GL_ARB_get_program_binary *)
  TglGetProgramBinary = PROCEDURE { C }(program_: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid); 
  TglProgramBinary = PROCEDURE { C }(program_: GLuint; binaryFormat: GLenum; CONST binary: PGLvoid; length: GLsizei); 
  TglProgramParameteri = PROCEDURE { C }(program_: GLuint; pname: GLenum; value: GLint); 
  
  (* GL_ARB_separate_shader_objects*)
  TglUseProgramStages = PROCEDURE { C }(pipeline: GLuint; stages: GLbitfield; program_: GLuint); 
  TglActiveShaderProgram = PROCEDURE { C }(pipeline: GLuint; program_: GLuint); 
  TglCreateShaderProgramv = PROCEDURE { C }(type_: GLenum; count: GLsizei; CONST strings: PPGLchar): GLuint; 
  TglBindProgramPipeline = PROCEDURE { C }(pipeline: GLuint); 
  TglDeleteProgramPipelines = PROCEDURE { C }(n: GLsizei; CONST pipelines: PGLuint); 
  TglGenProgramPipelines = PROCEDURE { C }(n: GLsizei; pipelines: PGLuint); 
  TglIsProgramPipeline = PROCEDURE { C }(pipeline: GLuint): GLboolean; 
  TglGetProgramPipelineiv = PROCEDURE { C }(pipeline: GLuint; pname: GLenum; params: PGLint); 
  TglProgramUniform1i = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint); 
  TglProgramUniform1iv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform1f = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat); 
  TglProgramUniform1fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform1d = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLdouble); 
  TglProgramUniform1dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform1ui = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint); 
  TglProgramUniform1uiv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform2i = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint); 
  TglProgramUniform2iv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform2f = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat); 
  TglProgramUniform2fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform2d = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble); 
  TglProgramUniform2dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform2ui = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint); 
  TglProgramUniform2uiv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform3i = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint); 
  TglProgramUniform3iv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform3f = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); 
  TglProgramUniform3fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform3d = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble); 
  TglProgramUniform3dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform3ui = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); 
  TglProgramUniform3uiv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform4i = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); 
  TglProgramUniform4iv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform4f = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); 
  TglProgramUniform4fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform4d = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble); 
  TglProgramUniform4dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform4ui = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); 
  TglProgramUniform4uiv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniformMatrix2fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix2x3fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3x2fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2x4fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4x2fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3x4fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4x3fv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2x3dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3x2dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix2x4dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4x2dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3x4dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4x3dv = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglValidateProgramPipeline = PROCEDURE { C }(pipeline: GLuint); 
  TglGetProgramPipelineInfoLog = PROCEDURE { C }(pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); 

  (* GL_ARB_vertex_attrib_64bit *)
  TglVertexAttribL1d = PROCEDURE { C }(index: GLuint; x: GLdouble); 
  TglVertexAttribL2d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble); 
  TglVertexAttribL3d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglVertexAttribL4d = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglVertexAttribL1dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL2dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL3dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL4dv = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribLPointer = PROCEDURE { C }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid); 
  TglGetVertexAttribLdv = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLdouble); 

  (* GL_ARB_viewport_array*)
  TglViewportArrayv = PROCEDURE { C }(first: GLuint; count: GLsizei;  v: PGLfloat); 
  TglViewportIndexedf = PROCEDURE { C }(index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat); 
  TglViewportIndexedfv = PROCEDURE { C }(index: GLuint;  v: PGLfloat); 
  TglScissorArrayv = PROCEDURE { C }(first: GLuint; count: GLsizei;  v: PGLint); 
  TglScissorIndexed = PROCEDURE { C }(index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei); 
  TglScissorIndexedv = PROCEDURE { C }(index: GLuint;  v: PGLint); 
  TglDepthRangeArrayv = PROCEDURE { C }(first: GLuint; count: GLsizei;  v: PGLclampd); 
  TglDepthRangeIndexed = PROCEDURE { C }(index: GLuint; n: GLclampd; f: GLclampd); 
  TglGetFloati_v = PROCEDURE { C }(target: GLenum; index: GLuint; data: PGLfloat); 
  TglGetDoublei_v = PROCEDURE { C }(target: GLenum; index: GLuint; data: PGLdouble); 

  (* GL_ARB_cl_event *)
  TglCreateSyncFromCLeventARB = PROCEDURE { C }(context: p_cl_context; event: p_cl_event; flags: GLbitfield): GLsync; 

  (* GL_ARB_debug_output*)
  TglDebugMessageControlARB = PROCEDURE { C }(source: GLenum; type_: GLenum; severity: GLenum; count: GLsizei; CONST ids: PGLuint; enabled: GLboolean); 
  TglDebugMessageInsertARB = PROCEDURE { C }(source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST buf: PGLchar); 
 (* TglDebugMessageCallbackARB = PROCEDURE { C }(callback: TglDebugProcARB; CONST userParam: PGLvoid); *)
  TglGetDebugMessageLogARB = PROCEDURE { C }(count: GLuint; bufsize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint; 

  (* GL_ARB_robustness*)
  TglGetGraphicsResetStatusARB = PROCEDURE { C }(): GLenum; 
  TglGetnMapdvARB = PROCEDURE { C }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble); 
  TglGetnMapfvARB = PROCEDURE { C }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat); 
  TglGetnMapivARB = PROCEDURE { C }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint); 
  TglGetnPixelMapfvARB = PROCEDURE { C }(map: GLenum; bufSize: GLsizei; values: PGLfloat); 
  TglGetnPixelMapuivARB = PROCEDURE { C }(map: GLenum; bufSize: GLsizei; values: PGLuint); 
  TglGetnPixelMapusvARB = PROCEDURE { C }(map: GLenum; bufSize: GLsizei; values: PGLushort); 
  TglGetnPolygonStippleARB = PROCEDURE { C }(bufSize: GLsizei; pattern: PGLubyte); 
  TglGetnColorTableARB = PROCEDURE { C }(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; table: PGLvoid); 
  TglGetnConvolutionFilterARB = PROCEDURE { C }(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; image: PGLvoid); 
  TglGetnSeparableFilterARB = PROCEDURE { C }(target: GLenum; format: GLenum; type_: GLenum; rowBufSize: GLsizei; row: PGLvoid; columnBufSize: GLsizei; column: PGLvoid; span: PGLvoid); 
  TglGetnHistogramARB = PROCEDURE { C }(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid); 
  TglGetnMinmaxARB = PROCEDURE { C }(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid); 
  TglGetnTexImageARB = PROCEDURE { C }(target: GLenum; level: GLint; format: GLenum; type_: GLenum; bufSize: GLsizei; img: PGLvoid); 
  TglReadnPixelsARB = PROCEDURE { C }(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; bufSize: GLsizei; data: PGLvoid); 
  TglGetnCompressedTexImageARB = PROCEDURE { C }(target: GLenum; lod: GLint; bufSize: GLsizei; img: PGLvoid); 
  TglGetnUniformfvARB = PROCEDURE { C }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat); 
  TglGetnUniformivARB = PROCEDURE { C }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLint); 
  TglGetnUniformuivARB = PROCEDURE { C }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint); 
  TglGetnUniformdvARB = PROCEDURE { C }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble); 
 
  (* GL_ATI_draw_buffers *)
  TglDrawBuffersATI = PROCEDURE { C }(n: TGLsizei; CONST bufs: PGLenum); 

  (* GL_ATI_element_array *)
  TglElementPointerATI = PROCEDURE { C }(_type: TGLenum; CONST _pointer: PGLvoid); 
  TglDrawElementArrayATI = PROCEDURE { C }(mode: TGLenum; count: TGLsizei); 
  TglDrawRangeElementArrayATI = PROCEDURE { C }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei); 

  (* GL_ATI_envmap_bumpmap *)
  TglTexBumpParameterivATI = PROCEDURE { C }(pname: TGLenum; CONST param: PGLint); 
  TglTexBumpParameterfvATI = PROCEDURE { C }(pname: TGLenum; CONST param: PGLfloat); 
  TglGetTexBumpParameterivATI = PROCEDURE { C }(pname: TGLenum; param: PGLint); 
  TglGetTexBumpParameterfvATI = PROCEDURE { C }(pname: TGLenum; param: PGLfloat); 

  (* GL_ATI_fragment_shader *)
  TglGenFragmentShadersATI = PROCEDURE { C } (range: TGLuint): TGLuint; 
  TglBindFragmentShaderATI = PROCEDURE { C }(id: TGLuint); 
  TglDeleteFragmentShaderATI = PROCEDURE { C }(id: TGLuint); 
  TglBeginFragmentShaderATI = PROCEDURE { C }(); 
  TglEndFragmentShaderATI = PROCEDURE { C }(); 
  TglPassTexCoordATI = PROCEDURE { C }(dst: TGLuint; coord: TGLuint; swizzle: TGLenum); 
  TglSampleMapATI = PROCEDURE { C }(dst: TGLuint; interp: TGLuint; swizzle: TGLenum); 
  TglColorFragmentOp1ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint); 
  TglColorFragmentOp2ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint); 
  TglColorFragmentOp3ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint; arg3: TGLuint; arg3Rep: TGLuint; arg3Mod: TGLuint); 
  TglAlphaFragmentOp1ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint); 
  TglAlphaFragmentOp2ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint); 
  TglAlphaFragmentOp3ATI = PROCEDURE { C }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint; arg3: TGLuint; arg3Rep: TGLuint; arg3Mod: TGLuint); 
  TglSetFragmentShaderConstantATI = PROCEDURE { C }(dst: TGLuint; CONST value: PGLfloat); 

  (* GL_ATI_map_object_buffer *)
  TglMapObjectBufferATI = PROCEDURE { C } (buffer: TGLuint): PGLvoid; 
  TglUnmapObjectBufferATI = PROCEDURE { C }(buffer: TGLuint); 

  (* GL_ATI_pn_triangles *)
  TglPNTrianglesiATI = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglPNTrianglesfATI = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 

  (* GL_ATI_separate_stencil *)
  TglStencilOpSeparateATI = PROCEDURE { C }(face: TGLenum; sfail: TGLenum; dpfail: TGLenum; dppass: TGLenum); 
  TglStencilFuncSeparateATI = PROCEDURE { C }(frontfunc: TGLenum; backfunc: TGLenum; ref: TGLint; mask: TGLuint); 

  (* GL_ATI_vertex_array_object *)
  TglNewObjectBufferATI = PROCEDURE { C } (size: TGLsizei;  _pointer: PGLvoid; usage: TGLenum): TGLuint; 
  TglIsObjectBufferATI = PROCEDURE { C } (buffer: TGLuint): TGLboolean; 
  TglUpdateObjectBufferATI = PROCEDURE { C }(buffer: TGLuint; offset: TGLuint; size: TGLsizei;  _pointer: PGLvoid; preserve: TGLenum); 
  TglGetObjectBufferfvATI = PROCEDURE { C }(buffer: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetObjectBufferivATI = PROCEDURE { C }(buffer: TGLuint; pname: TGLenum; params: PGLint); 
  TglFreeObjectBufferATI = PROCEDURE { C }(buffer: TGLuint); 
  TglArrayObjectATI = PROCEDURE { C }(_array: TGLenum; size: TGLint; _type: TGLenum; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetArrayObjectfvATI = PROCEDURE { C }(_array: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetArrayObjectivATI = PROCEDURE { C }(_array: TGLenum; pname: TGLenum; params: PGLint); 
  TglVariantArrayObjectATI = PROCEDURE { C }(id: TGLuint; _type: TGLenum; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetVariantArrayObjectfvATI = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVariantArrayObjectivATI = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLint); 

  (* GL_ATI_vertex_attrib_array_object *)
  TglVertexAttribArrayObjectATI = PROCEDURE { C }(index: TGLuint; size: TGLint; _type: TGLenum; normalized: TGLboolean; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetVertexAttribArrayObjectfvATI = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribArrayObjectivATI = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLint); 

  (* GL_ATI_vertex_streams *)
  TglVertexStream1sATI = PROCEDURE { C }(stream: TGLenum; x: TGLshort); 
  TglVertexStream1svATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream1iATI = PROCEDURE { C }(stream: TGLenum; x: TGLint); 
  TglVertexStream1ivATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream1fATI = PROCEDURE { C }(stream: TGLenum; x: TGLfloat); 
  TglVertexStream1fvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream1dATI = PROCEDURE { C }(stream: TGLenum; x: TGLdouble); 
  TglVertexStream1dvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream2sATI = PROCEDURE { C }(stream: TGLenum; x: TGLshort; y: TGLshort); 
  TglVertexStream2svATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream2iATI = PROCEDURE { C }(stream: TGLenum; x: TGLint; y: TGLint); 
  TglVertexStream2ivATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream2fATI = PROCEDURE { C }(stream: TGLenum; x: TGLfloat; y: TGLfloat); 
  TglVertexStream2fvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream2dATI = PROCEDURE { C }(stream: TGLenum; x: TGLdouble; y: TGLdouble); 
  TglVertexStream2dvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream3sATI = PROCEDURE { C }(stream: TGLenum; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexStream3svATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream3iATI = PROCEDURE { C }(stream: TGLenum; x: TGLint; y: TGLint; z: TGLint); 
  TglVertexStream3ivATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream3fATI = PROCEDURE { C }(stream: TGLenum; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexStream3fvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream3dATI = PROCEDURE { C }(stream: TGLenum; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexStream3dvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream4sATI = PROCEDURE { C }(stream: TGLenum; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexStream4svATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream4iATI = PROCEDURE { C }(stream: TGLenum; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertexStream4ivATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream4fATI = PROCEDURE { C }(stream: TGLenum; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexStream4fvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream4dATI = PROCEDURE { C }(stream: TGLenum; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexStream4dvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLdouble); 
  TglNormalStream3bATI = PROCEDURE { C }(stream: TGLenum; nx: TGLbyte; ny: TGLbyte; nz: TGLbyte); 
  TglNormalStream3bvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLbyte); 
  TglNormalStream3sATI = PROCEDURE { C }(stream: TGLenum; nx: TGLshort; ny: TGLshort; nz: TGLshort); 
  TglNormalStream3svATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLshort); 
  TglNormalStream3iATI = PROCEDURE { C }(stream: TGLenum; nx: TGLint; ny: TGLint; nz: TGLint); 
  TglNormalStream3ivATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLint); 
  TglNormalStream3fATI = PROCEDURE { C }(stream: TGLenum; nx: TGLfloat; ny: TGLfloat; nz: TGLfloat); 
  TglNormalStream3fvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLfloat); 
  TglNormalStream3dATI = PROCEDURE { C }(stream: TGLenum; nx: TGLdouble; ny: TGLdouble; nz: TGLdouble); 
  TglNormalStream3dvATI = PROCEDURE { C }(stream: TGLenum; CONST coords: PGLdouble); 
  TglClientActiveVertexStreamATI = PROCEDURE { C }(stream: TGLenum); 
  TglVertexBlendEnviATI = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglVertexBlendEnvfATI = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 

  (* GL_AMD_performance_monitor *)
  TglGetPerfMonitorGroupsAMD = PROCEDURE { C }(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint); 
  TglGetPerfMonitorCountersAMD = PROCEDURE { C }(group: GLuint; numCounters: PGLint; maxActiveCouters: PGLint; counterSize: GLsizei; counters: PGLuint); 
  TglGetPerfMonitorGroupStringAMD = PROCEDURE { C }(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar); 
  TglGetPerfMonitorCounterStringAMD = PROCEDURE { C }(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar); 
  TglGetPerfMonitorCounterInfoAMD = PROCEDURE { C }(group: GLuint; counter: GLuint; pname: GLenum; data: Pointer); 
  TglGenPerfMonitorsAMD = PROCEDURE { C }(n: GLsizei; monitors: PGLuint); 
  TglDeletePerfMonitorsAMD = PROCEDURE { C }(n: GLsizei; monitors: PGLuint); 
  TglSelectPerfMonitorCountersAMD = PROCEDURE { C }(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; counterList: PGLuint); 
  TglBeginPerfMonitorAMD = PROCEDURE { C }(monitor: GLuint); 
  TglEndPerfMonitorAMD = PROCEDURE { C }(monitor: GLuint); 
  TglGetPerfMonitorCounterDataAMD = PROCEDURE { C }(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint); 

  (* GL_AMD_vertex_shader_tesselator *)
  TglTessellationFactorAMD = PROCEDURE { C }(factor: GLfloat); 
  TglTessellationModeAMD = PROCEDURE { C }(mode: GLenum); 

  (* GL_AMD_draw_buffers_blend *)
  TglBlendFuncIndexedAMD = PROCEDURE { C }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparateIndexedAMD = PROCEDURE { C }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 
  TglBlendEquationIndexedAMD = PROCEDURE { C }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparateIndexedAMD = PROCEDURE { C }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 

  (* GL_AMD_name_gen_delete *)
  TglGenNamesAMD = PROCEDURE { C }(identifier: GLenum; num: GLuint; names: PGLuint); 
  TglDeleteNamesAMD = PROCEDURE { C }(identifier: GLenum; num: GLuint; CONST names: PGLuint); 
  TglIsNameAMD = PROCEDURE { C }(identifier: GLenum; name: GLuint): GLboolean; 

  (* GL_AMD_debug_output *)
  TglDebugMessageEnableAMD = PROCEDURE { C }(category: GLenum; severity: GLenum; count: GLsizei; CONST ids: PGLuint; enabled: GLboolean); 
  TglDebugMessageInsertAMD = PROCEDURE { C }(category: GLenum; severity: GLenum; id: GLuint; length: GLsizei; CONST buf: PGLchar); 
 (* TglDebugMessageCallbackAMD = PROCEDURE { C }(callback: TGLDebugProcAMD; userParam: PGLvoid);  *)
  TglGetDebugMessageLogAMD = PROCEDURE { C }(count: GLuint; bufsize: GLsizei; categories: PGLenum; severities: PGLuint; ids: PGLuint; lengths: PGLsizei; message: PGLchar): GLuint; 
 
  (* GL_EXT_blend_color *)
  TglBlendColorEXT = PROCEDURE { C }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 

  (* GL_EXT_blend_func_separate *)
  TglBlendFuncSeparateEXT = PROCEDURE { C }(sfactorRGB: TGLenum; dfactorRGB: TGLenum; sfactorAlpha: TGLenum; dfactorAlpha: TGLenum); 

  (* GL_EXT_blend_minmax *)
  TglBlendEquationEXT = PROCEDURE { C }(mode: TGLenum); 

  (* GL_EXT_color_subtable *)
  TglColorSubTableEXT = PROCEDURE { C }(target: TGLenum; start: TGLsizei; count: TGLsizei; format: TGLenum; _type: TGLenum; CONST data: PGLvoid); 
  TglCopyColorSubTableEXT = PROCEDURE { C }(target: TGLenum; start: TGLsizei; x: TGLint; y: TGLint; width: TGLsizei); 

  (* GL_EXT_compiled_vertex_array *)
  TglLockArraysEXT = PROCEDURE { C }(first: TGLint; count: TGLsizei); 
  TglUnlockArraysEXT = PROCEDURE { C }(); 

  (* GL_EXT_convolution *)
  TglConvolutionFilter1DEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST image: PGLvoid); 
  TglConvolutionFilter2DEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST image: PGLvoid); 
  TglConvolutionParameterfEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: TGLfloat); 
  TglConvolutionParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglConvolutionParameteriEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: TGLint); 
  TglConvolutionParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglCopyConvolutionFilter1DEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyConvolutionFilter2DEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglGetConvolutionFilterEXT = PROCEDURE { C }(target: TGLenum; format: TGLenum; _type: TGLenum; image: PGLvoid); 
  TglGetConvolutionParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetConvolutionParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetSeparableFilterEXT = PROCEDURE { C }(target: TGLenum; format: TGLenum; _type: TGLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid); 
  TglSeparableFilter2DEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST row: PGLvoid; CONST column: PGLvoid); 

  (* GL_EXT_coordinate_frame *)
  TglTangent3bEXT = PROCEDURE { C }(tx: TGLbyte; ty: TGLbyte; tz: TGLbyte); 
  TglTangent3bvEXT = PROCEDURE { C }(CONST v: PGLbyte); 
  TglTangent3dEXT = PROCEDURE { C }(tx: TGLdouble; ty: TGLdouble; tz: TGLdouble); 
  TglTangent3dvEXT = PROCEDURE { C }(CONST v: PGLdouble); 
  TglTangent3fEXT = PROCEDURE { C }(tx: TGLfloat; ty: TGLfloat; tz: TGLfloat); 
  TglTangent3fvEXT = PROCEDURE { C }(CONST v: PGLfloat); 
  TglTangent3iEXT = PROCEDURE { C }(tx: TGLint; ty: TGLint; tz: TGLint); 
  TglTangent3ivEXT = PROCEDURE { C }(CONST v: PGLint); 
  TglTangent3sEXT = PROCEDURE { C }(tx: TGLshort; ty: TGLshort; tz: TGLshort); 
  TglTangent3svEXT = PROCEDURE { C }(CONST v: PGLshort); 
  TglBinormal3bEXT = PROCEDURE { C }(bx: TGLbyte; by: TGLbyte; bz: TGLbyte); 
  TglBinormal3bvEXT = PROCEDURE { C }(CONST v: PGLbyte); 
  TglBinormal3dEXT = PROCEDURE { C }(bx: TGLdouble; by: TGLdouble; bz: TGLdouble); 
  TglBinormal3dvEXT = PROCEDURE { C }(CONST v: PGLdouble); 
  TglBinormal3fEXT = PROCEDURE { C }(bx: TGLfloat; by: TGLfloat; bz: TGLfloat); 
  TglBinormal3fvEXT = PROCEDURE { C }(CONST v: PGLfloat); 
  TglBinormal3iEXT = PROCEDURE { C }(bx: TGLint; by: TGLint; bz: TGLint); 
  TglBinormal3ivEXT = PROCEDURE { C }(CONST v: PGLint); 
  TglBinormal3sEXT = PROCEDURE { C }(bx: TGLshort; by: TGLshort; bz: TGLshort); 
  TglBinormal3svEXT = PROCEDURE { C }(CONST v: PGLshort); 
  TglTangentPointerEXT = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglBinormalPointerEXT = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_copy_texture *)
  TglCopyTexImage1DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; border: TGLint); 
  TglCopyTexImage2DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint); 
  TglCopyTexSubImage1DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyTexSubImage2DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglCopyTexSubImage3DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

  (* GL_EXT_cull_vertex *)
  TglCullParameterdvEXT = PROCEDURE { C }(pname: TGLenum; params: PGLdouble); 
  TglCullParameterfvEXT = PROCEDURE { C }(pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_draw_range_elements *)
  TglDrawRangeElementsEXT = PROCEDURE { C }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 

  (* GL_EXT_fog_coord *)
  TglFogCoordfEXT = PROCEDURE { C }(coord: TGLfloat); 
  TglFogCoordfvEXT = PROCEDURE { C }(CONST coord: PGLfloat); 
  TglFogCoorddEXT = PROCEDURE { C }(coord: TGLdouble); 
  TglFogCoorddvEXT = PROCEDURE { C }(CONST coord: PGLdouble); 
  TglFogCoordPointerEXT = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei;  _pointer: PGLvoid); 

  (* GL_EXT_framebuffer_object *)
  TglIsRenderbufferEXT = PROCEDURE { C } (renderbuffer: TGLuint): BOOLEAN; 
  TglBindRenderbufferEXT = PROCEDURE { C }(target: TGLenum; renderbuffer: TGLuint); 
  TglDeleteRenderbuffersEXT = PROCEDURE { C }(n: TGLsizei;  renderbuffers: PGLuint); 
  TglGenRenderbuffersEXT = PROCEDURE { C }(n: TGLsizei; renderbuffers: PGLuint); 
  TglRenderbufferStorageEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 
  TglGetRenderbufferParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglIsFramebufferEXT = PROCEDURE { C } (framebuffer: TGLuint): BOOLEAN; 
  TglBindFramebufferEXT = PROCEDURE { C }(target: TGLenum; framebuffer: TGLuint); 
  TglDeleteFramebuffersEXT = PROCEDURE { C }(n: TGLsizei;  framebuffers: PGLuint); 
  TglGenFramebuffersEXT = PROCEDURE { C }(n: TGLsizei; framebuffers: PGLuint); 
  TglCheckFramebufferStatusEXT = PROCEDURE { C } (target: TGLenum): TGLenum; 
  TglFramebufferTexture1DEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint); 
  TglFramebufferTexture2DEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint); 
  TglFramebufferTexture3DEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint; zoffset: TGLint); 
  TglFramebufferRenderbufferEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; renderbuffertarget: TGLenum; renderbuffer: TGLuint); 
  TglGetFramebufferAttachmentParameterivEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; pname: TGLenum; params: PGLint); 
  TglGenerateMipmapEXT = PROCEDURE { C }(target: TGLenum); 

  (* GL_EXT_histogram *)
  TglGetHistogramEXT = PROCEDURE { C }(target: TGLenum; reset: TGLboolean; format: TGLenum; _type: TGLenum; values: PGLvoid); 
  TglGetHistogramParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetHistogramParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMinmaxEXT = PROCEDURE { C }(target: TGLenum; reset: TGLboolean; format: TGLenum; _type: TGLenum; values: PGLvoid); 
  TglGetMinmaxParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMinmaxParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglHistogramEXT = PROCEDURE { C }(target: TGLenum; width: TGLsizei; internalformat: TGLenum; sink: TGLboolean); 
  TglMinmaxEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; sink: TGLboolean); 
  TglResetHistogramEXT = PROCEDURE { C }(target: TGLenum); 
  TglResetMinmaxEXT = PROCEDURE { C }(target: TGLenum); 

  (* GL_EXT_index_func *)
  TglIndexFuncEXT = PROCEDURE { C }(func: TGLenum; ref: TGLclampf); 

  (* GL_EXT_index_material *)
  TglIndexMaterialEXT = PROCEDURE { C }(face: TGLenum; mode: TGLenum); 

  (* GL_EXT_light_texture *)
  TglApplyTextureEXT = PROCEDURE { C }(mode: TGLenum); 
  TglTextureLightEXT = PROCEDURE { C }(pname: TGLenum); 
  TglTextureMaterialEXT = PROCEDURE { C }(face: TGLenum; mode: TGLenum); 

  (* GL_EXT_multi_draw_arrays *)
  TglMultiDrawArraysEXT = PROCEDURE { C }(mode: TGLenum; first: PGLint; count: PGLsizei; primcount: TGLsizei); 
  TglMultiDrawElementsEXT = PROCEDURE { C }(mode: TGLenum;  count: PGLsizei; _type: TGLenum;  indices: PGLvoid; primcount: TGLsizei); 

  (* GL_EXT_multisample *)
  TglSampleMaskEXT = PROCEDURE { C }(value: TGLclampf; invert: TGLboolean); 
  TglSamplePatternEXT = PROCEDURE { C }(pattern: TGLenum); 

  (* GL_EXT_paletted_texture *)
  TglColorTableEXT = PROCEDURE { C }(target: TGLenum; internalFormat: TGLenum; width: TGLsizei; format: TGLenum; _type: TGLenum;  table: PGLvoid); 
  TglGetColorTableEXT = PROCEDURE { C }(target: TGLenum; format: TGLenum; _type: TGLenum; data: PGLvoid); 
  TglGetColorTableParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetColorTableParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_pixel_transform *)
  TglPixelTransformParameteriEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglPixelTransformParameterfEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglPixelTransformParameterivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglPixelTransformParameterfvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 

  (* GL_EXT_point_parameters *)
  TglPointParameterfEXT = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfvEXT = PROCEDURE { C }(pname: TGLenum; CONST params: PGLfloat); 

  (* GL_EXT_polygon_offset *)
  TglPolygonOffsetEXT = PROCEDURE { C }(factor: TGLfloat; bias: TGLfloat); 

  (* GL_EXT_secondary_color *)
  TglSecondaryColor3bEXT = PROCEDURE { C }(red: TGLbyte; green: TGLbyte; blue: TGLbyte); 
  TglSecondaryColor3bvEXT = PROCEDURE { C }(CONST v: PGLbyte); 
  TglSecondaryColor3dEXT = PROCEDURE { C }(red: TGLdouble; green: TGLdouble; blue: TGLdouble); 
  TglSecondaryColor3dvEXT = PROCEDURE { C }(CONST v: PGLdouble); 
  TglSecondaryColor3fEXT = PROCEDURE { C }(red: TGLfloat; green: TGLfloat; blue: TGLfloat); 
  TglSecondaryColor3fvEXT = PROCEDURE { C }(CONST v: PGLfloat); 
  TglSecondaryColor3iEXT = PROCEDURE { C }(red: TGLint; green: TGLint; blue: TGLint); 
  TglSecondaryColor3ivEXT = PROCEDURE { C }(CONST v: PGLint); 
  TglSecondaryColor3sEXT = PROCEDURE { C }(red: TGLshort; green: TGLshort; blue: TGLshort); 
  TglSecondaryColor3svEXT = PROCEDURE { C }(CONST v: PGLshort); 
  TglSecondaryColor3ubEXT = PROCEDURE { C }(red: TGLubyte; green: TGLubyte; blue: TGLubyte); 
  TglSecondaryColor3ubvEXT = PROCEDURE { C }(CONST v: PGLubyte); 
  TglSecondaryColor3uiEXT = PROCEDURE { C }(red: TGLuint; green: TGLuint; blue: TGLuint); 
  TglSecondaryColor3uivEXT = PROCEDURE { C }(CONST v: PGLuint); 
  TglSecondaryColor3usEXT = PROCEDURE { C }(red: TGLushort; green: TGLushort; blue: TGLushort); 
  TglSecondaryColor3usvEXT = PROCEDURE { C }(CONST v: PGLushort); 
  TglSecondaryColorPointerEXT = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_stencil_two_side *)
  TglActiveStencilFaceEXT = PROCEDURE { C }(face: TGLenum); 

  (* GL_EXT_subtexture *)
  TglTexSubImage1DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage2DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 

  (* GL_EXT_texture3D *)
  TglTexImage3DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage3DEXT = PROCEDURE { C }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 

  (* GL_EXT_texture_object *)
  TglAreTexturesResidentEXT = PROCEDURE { C } (n: TGLsizei;  textures: PGLuint; residences: PGLboolean): TGLboolean; 
  TglBindTextureEXT = PROCEDURE { C }(target: TGLenum; texture: TGLuint); 
  TglDeleteTexturesEXT = PROCEDURE { C }(n: TGLsizei;  textures: PGLuint); 
  TglGenTexturesEXT = PROCEDURE { C }(n: TGLsizei; textures: PGLuint); 
  TglIsTextureEXT = PROCEDURE { C } (texture: TGLuint): TGLboolean; 
  TglPrioritizeTexturesEXT = PROCEDURE { C }(n: TGLsizei;  textures: PGLuint;  priorities: PGLclampf); 

  (* GL_EXT_texture_perturb_normal *)
  TglTextureNormalEXT = PROCEDURE { C }(mode: TGLenum); 

  (* GL_EXT_vertex_array *)
  TglArrayElementEXT = PROCEDURE { C }(i: TGLint); 
  TglColorPointerEXT = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglDrawArraysEXT = PROCEDURE { C }(mode: TGLenum; first: TGLint; count: TGLsizei); 
  TglEdgeFlagPointerEXT = PROCEDURE { C }(stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLboolean); 
  TglGetPointervEXT = PROCEDURE { C }(pname: TGLenum; params: PGLvoid); 
  TglIndexPointerEXT = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglNormalPointerEXT = PROCEDURE { C }(_type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglTexCoordPointerEXT = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexPointerEXT = PROCEDURE { C }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_vertex_shader *)
  TglBeginVertexShaderEXT = PROCEDURE { C }(); 
  TglEndVertexShaderEXT = PROCEDURE { C }(); 
  TglBindVertexShaderEXT = PROCEDURE { C }(id: TGLuint); 
  TglGenVertexShadersEXT = PROCEDURE { C } (range: TGLuint): TGLuint; 
  TglDeleteVertexShaderEXT = PROCEDURE { C }(id: TGLuint); 
  TglShaderOp1EXT = PROCEDURE { C }(op: TGLenum; res: TGLuint; arg1: TGLuint); 
  TglShaderOp2EXT = PROCEDURE { C }(op: TGLenum; res: TGLuint; arg1: TGLuint; arg2: TGLuint); 
  TglShaderOp3EXT = PROCEDURE { C }(op: TGLenum; res: TGLuint; arg1: TGLuint; arg2: TGLuint; arg3: TGLuint); 
  TglSwizzleEXT = PROCEDURE { C }(res: TGLuint; _in: TGLuint; outX: TGLenum; outY: TGLenum; outZ: TGLenum; outW: TGLenum); 
  TglWriteMaskEXT = PROCEDURE { C }(res: TGLuint; _in: TGLuint; outX: TGLenum; outY: TGLenum; outZ: TGLenum; outW: TGLenum); 
  TglInsertComponentEXT = PROCEDURE { C }(res: TGLuint; src: TGLuint; num: TGLuint); 
  TglExtractComponentEXT = PROCEDURE { C }(res: TGLuint; src: TGLuint; num: TGLuint); 
  TglGenSymbolsEXT = PROCEDURE { C } (datatype: TGLenum; storagetype: TGLenum; range: TGLenum; components: TGLuint): TGLuint; 
  TglSetInvariantEXT = PROCEDURE { C }(id: TGLuint; _type: TGLenum; CONST addr: PGLvoid); 
  TglSetLocalConstantEXT = PROCEDURE { C }(id: TGLuint; _type: TGLenum; CONST addr: PGLvoid); 
  TglVariantbvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLbyte); 
  TglVariantsvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLshort); 
  TglVariantivEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLint); 
  TglVariantfvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLfloat); 
  TglVariantdvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLdouble); 
  TglVariantubvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLubyte); 
  TglVariantusvEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLushort); 
  TglVariantuivEXT = PROCEDURE { C }(id: TGLuint; CONST addr: PGLuint); 
  TglVariantPointerEXT = PROCEDURE { C }(id: TGLuint; _type: TGLenum; stride: TGLuint; CONST addr: PGLvoid); 
  TglEnableVariantClientStateEXT = PROCEDURE { C }(id: TGLuint); 
  TglDisableVariantClientStateEXT = PROCEDURE { C }(id: TGLuint); 
  TglBindLightParameterEXT = PROCEDURE { C } (light: TGLenum; value: TGLenum): TGLuint; 
  TglBindMaterialParameterEXT = PROCEDURE { C } (face: TGLenum; value: TGLenum): TGLuint; 
  TglBindTexGenParameterEXT = PROCEDURE { C } (_unit: TGLenum; coord: TGLenum; value: TGLenum): TGLuint; 
  TglBindTextureUnitParameterEXT = PROCEDURE { C } ( _unit: TGLenum; value: TGLenum): TGLuint; 
  TglBindParameterEXT = PROCEDURE { C } (value: TGLenum): TGLuint; 
  TglIsVariantEnabledEXT = PROCEDURE { C } (id: TGLuint; cap: TGLenum): TGLboolean; 
  TglGetVariantBooleanvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetVariantIntegervEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetVariantFloatvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLfloat); 
  TglGetVariantPointervEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLvoid); 
  TglGetInvariantBooleanvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetInvariantIntegervEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetInvariantFloatvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLfloat); 
  TglGetLocalConstantBooleanvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetLocalConstantIntegervEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetLocalConstantFloatvEXT = PROCEDURE { C }(id: TGLuint; value: TGLenum; data: PGLfloat); 

  (* GL_EXT_vertex_weighting *)
  TglVertexWeightfEXT = PROCEDURE { C }(weight: TGLfloat); 
  TglVertexWeightfvEXT = PROCEDURE { C }(CONST weight: PGLfloat); 
  TglVertexWeightPointerEXT = PROCEDURE { C }(size: TGLsizei; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_stencil_clear_tag *)
  TglStencilClearTagEXT = PROCEDURE { C }(stencilTagBits: TGLsizei; stencilClearTag: TGLuint); 

  (* GL_EXT_framebuffer_blit *)
  TglBlitFramebufferEXT = PROCEDURE { C }(srcX0: TGLint; srcY0: TGLint; srcX1: TGLint; srcY1: TGLint; dstX0: TGLint; dstY0: TGLint; dstX1: TGLint; dstY1: TGLint; mask: TGLbitfield; filter: TGLenum); 

  (* GL_EXT_framebuffer_multisample *)
  TglRenderbufferStorageMultisampleEXT = PROCEDURE { C }(target: TGLenum; samples: TGLsizei; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 

  (* GL_EXT_timer_query *)
  TglGetQueryObjecti64vEXT = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLint64EXT); 
  TglGetQueryObjectui64vEXT = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLuint64EXT); 

  (* GL_EXT_gpu_program_parameters *)
  TglProgramEnvParameters4fvEXT = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 
  TglProgramLocalParameters4fvEXT = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 

  (* GL_EXT_bindable_uniform *)
  TglUniformBufferEXT = PROCEDURE { C }(_program: TGLuint; location: TGLint; buffer: TGLuint); 
  TglGetUniformBufferSizeEXT = PROCEDURE { C } (_program: TGLuint; location: TGLint): TGLint; 
  TglGetUniformOffsetEXT = PROCEDURE { C }( _program: TGLuint; location: TGLint): PGLint; 

  (* GL_EXT_draw_buffers2 *)
  TglColorMaskIndexedEXT = PROCEDURE { C }(buf: TGLuint; r: TGLboolean; g: TGLboolean; b: TGLboolean; a: TGLboolean); 
  TglGetBooleanIndexedvEXT = PROCEDURE { C }(value: TGLenum; index: TGLuint; data: PGLboolean); 
  TglGetIntegerIndexedvEXT = PROCEDURE { C }(value: TGLenum; index: TGLuint; data: PGLint); 
  TglEnableIndexedEXT = PROCEDURE { C }(target: TGLenum; index: TGLuint); 
  TglDisableIndexedEXT = PROCEDURE { C }(target: TGLenum; index: TGLuint); 
  TglIsEnabledIndexedEXT = PROCEDURE { C } (target: TGLenum; index: TGLuint): TGLboolean; 

  (* GL_EXT_draw_instanced *)
  TglDrawArraysInstancedEXT = PROCEDURE { C }(mode: TGLenum; first: TGLint; count: TGLsizei; primcount: TGLsizei); 
  TglDrawElementsInstancedEXT = PROCEDURE { C }(mode: TGLenum; count: TGLsizei; _type: TGLenum; CONST indices: Pointer; primcount: TGLsizei); 

  (* GL_EXT_geometry_shader4 *)
  TglProgramParameteriEXT = PROCEDURE { C } (_program: TGLuint; pname: TGLenum; value: TGLint); 
  TglFramebufferTextureEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint); 
(*  TglFramebufferTextureLayerEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; layer: TGLint);  *)
  TglFramebufferTextureFaceEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; face: TGLenum); 

  (* GL_EXT_gpu_shader4 *)
  TglVertexAttribI1iEXT = PROCEDURE { C }(index: TGLuint; x: TGLint); 
  TglVertexAttribI2iEXT = PROCEDURE { C }(index: TGLuint; x: TGLint; y: TGLint); 
  TglVertexAttribI3iEXT = PROCEDURE { C }(index: TGLuint; x: TGLint; y: TGLint; z: TGLint); 
  TglVertexAttribI4iEXT = PROCEDURE { C }(index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertexAttribI1uiEXT = PROCEDURE { C }(index: TGLuint; x: TGLuint); 
  TglVertexAttribI2uiEXT = PROCEDURE { C }(index: TGLuint; x: TGLuint; y: TGLuint); 
  TglVertexAttribI3uiEXT = PROCEDURE { C }(index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint); 
  TglVertexAttribI4uiEXT = PROCEDURE { C }(index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglVertexAttribI1ivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI2ivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI3ivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI4ivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI1uivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI2uivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI3uivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI4uivEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI4bvEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttribI4svEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttribI4ubvEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttribI4usvEXT = PROCEDURE { C }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttribIPointerEXT = PROCEDURE { C }(index: TGLuint; size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: Pointer); 
  TglGetVertexAttribIivEXT = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribIuivEXT = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLuint); 
  TglUniform1uiEXT = PROCEDURE { C }(location: TGLint; v0: TGLuint); 
  TglUniform2uiEXT = PROCEDURE { C }(location: TGLint; v0: TGLuint; v1: TGLuint); 
  TglUniform3uiEXT = PROCEDURE { C }(location: TGLint; v0: TGLuint; v1: TGLuint; v2: TGLuint); 
  TglUniform4uiEXT = PROCEDURE { C }(location: TGLint; v0: TGLuint; v1: TGLuint; v2: TGLuint; v3: TGLuint); 
  TglUniform1uivEXT = PROCEDURE { C }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform2uivEXT = PROCEDURE { C }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform3uivEXT = PROCEDURE { C }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform4uivEXT = PROCEDURE { C }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglGetUniformuivEXT = PROCEDURE { C }(_program: TGLuint; location: TGLint; params: PGLuint); 
  TglBindFragDataLocationEXT = PROCEDURE { C }(_program: TGLuint; colorNumber: TGLuint; CONST name: PGLchar); 
  TglGetFragDataLocationEXT = PROCEDURE { C } (_program: TGLuint; CONST name: PGLchar): TGLint;

  (* GL_EXT_texture_array *)
  TglFramebufferTextureLayerEXT = PROCEDURE { C }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; layer: TGLint); 

  (* GL_EXT_texture_buffer_object *)
  TglTexBufferEXT = PROCEDURE { C }(target: TGLenum; internalformat: TGLenum; buffer: TGLuint); 

  (* GL_EXT_texture_integer *)
  TglClearColorIiEXT = PROCEDURE { C }(r: TGLint; g: TGLint; b: TGLint; a: TGLint); 
  TglClearColorIuiEXT = PROCEDURE { C }(r: TGLuint; g: TGLuint; b: TGLuint; a: TGLuint); 
  TglTexParameterIivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglTexParameterIuivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLuint); 
  TglGetTexParameterIivEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexParameterIiuvEXT = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLuint); 

  (* GL_HP_image_transform *)
  TglImageTransformParameteriHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglImageTransformParameterfHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglImageTransformParameterivHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglImageTransformParameterfvHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetImageTransformParameterivHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetImageTransformParameterfvHP = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_depth_bounds_test *)
  TglDepthBoundsEXT = PROCEDURE { C }(zmin: TGLclampd; zmax: TGLclampd); 

  (* GL_EXT_blend_equation_separate *)
  TglBlendEquationSeparateEXT = PROCEDURE { C }(modeRGB: TGLenum; modeAlpha: TGLenum); 

  (* GL_EXT_transform_feedback *)
  TglBeginTransformFeedbackEXT = PROCEDURE { C }(primitiveMode: GLenum); 
  TglEndTransformFeedbackEXT = PROCEDURE { C }(); 
  TglBindBufferRangeEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei); 
  TglBindBufferOffsetEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei); 
  TglBindBufferBaseEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryingsEXT = PROCEDURE { C }(program_: GLuint; count: GLsizei;  locations: PGLint; bufferMode: GLenum); 
  TglGetTransformFeedbackVaryingEXT = PROCEDURE { C }(program_: GLuint; index_: GLuint; location: PGLint); 

  (* GL_EXT_direct_state_access *)
  TglClientAttribDefaultEXT = PROCEDURE { C }(mask: GLbitfield);  
  TglPushClientAttribDefaultEXT = PROCEDURE { C }(mask: GLbitfield);  
  TglMatrixLoadfEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixLoaddEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixMultfEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixMultdEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixLoadIdentityEXT = PROCEDURE { C }(mode: GLenum);  
  TglMatrixRotatefEXT = PROCEDURE { C }(mode: GLenum; angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixRotatedEXT = PROCEDURE { C }(mode: GLenum; angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixScalefEXT = PROCEDURE { C }(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixScaledEXT = PROCEDURE { C }(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixTranslatefEXT = PROCEDURE { C }(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixTranslatedEXT = PROCEDURE { C }(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixFrustumEXT = PROCEDURE { C }(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);  
  TglMatrixOrthoEXT = PROCEDURE { C }(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);  
  TglMatrixPopEXT = PROCEDURE { C }(mode: GLenum);  
  TglMatrixPushEXT = PROCEDURE { C }(mode: GLenum);  
  TglMatrixLoadTransposefEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixLoadTransposedEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixMultTransposefEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixMultTransposedEXT = PROCEDURE { C }(mode: GLenum; CONST m: PGLdouble);  
  TglTextureParameterfEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; param: GLfloat);  
  TglTextureParameterfvEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglTextureParameteriEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; param: GLint);  
  TglTextureParameterivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglTextureImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyTextureImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);  
  TglCopyTextureImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);  
  TglCopyTextureSubImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);  
  TglCopyTextureSubImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetTextureImageEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);  
  TglGetTextureParameterfvEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetTextureParameterivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetTextureLevelParameterfvEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);  
  TglGetTextureLevelParameterivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: GLint);  
  TglTextureImage3DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage3DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyTextureSubImage3DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglMultiTexParameterfEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexParameterfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexParameteriEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexParameterivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyMultiTexImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);  
  TglCopyMultiTexImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);  
  TglCopyMultiTexSubImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);  
  TglCopyMultiTexSubImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetMultiTexImageEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);  
  TglGetMultiTexParameterfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexParameterivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexLevelParameterfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexLevelParameterivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLint);  
  TglMultiTexImage3DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage3DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum; CONST pixels:PGLvoid);  
  TglCopyMultiTexSubImage3DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglBindMultiTextureEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; texture: GLuint);  
  TglEnableClientStateIndexedEXT = PROCEDURE { C }(array_: GLenum; index_: GLuint);  
  TglDisableClientStateIndexedEXT = PROCEDURE { C }(array_: GLenum; index_: GLuint);  
  TglMultiTexCoordPointerEXT = PROCEDURE { C }(texunit: GLenum; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid);  
  TglMultiTexEnvfEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexEnvfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexEnviEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexEnvivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexGendEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLdouble);  
  TglMultiTexGendvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLdouble);  
  TglMultiTexGenfEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexGenfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexGeniEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexGenivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglGetMultiTexEnvfvEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexEnvivEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexGendvEXT = PROCEDURE { C }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLdouble);  
  TglGetMultiTexGenfvEXT = PROCEDURE { C }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexGenivEXT = PROCEDURE { C }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLint);  
  TglGetFloatIndexedvEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PGLfloat);  
  TglGetDoubleIndexedvEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PGLdouble);  
  TglGetPointerIndexedvEXT = PROCEDURE { C }(target: GLenum; index_: GLuint; data: PPGLvoid);  
  TglCompressedTextureImage3DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage3DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage2DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage1DEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglGetCompressedTextureImageEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; lod: GLint; img: PGLvoid);  
  TglCompressedMultiTexImage3DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage3DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage2DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage1DEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglGetCompressedMultiTexImageEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; lod: GLint; img: PGLvoid);  
  TglNamedProgramStringEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; format: GLenum; len: GLsizei; CONST string_: PGLvoid);  
  TglNamedProgramLocalParameter4dEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglNamedProgramLocalParameter4dvEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLdouble);  
  TglNamedProgramLocalParameter4fEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);  
  TglNamedProgramLocalParameter4fvEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLfloat);  
  TglGetNamedProgramLocalParameterdvEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLdouble);  
  TglGetNamedProgramLocalParameterfvEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLfloat);  
  TglGetNamedProgramivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetNamedProgramStringEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; pname: GLenum; string_: PGLvoid);  
  TglNamedProgramLocalParameters4fvEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLfloat);  
  TglNamedProgramLocalParameterI4iEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);  
  TglNamedProgramLocalParameterI4ivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLint);  
  TglNamedProgramLocalParametersI4ivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLint);  
  TglNamedProgramLocalParameterI4uiEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);  
  TglNamedProgramLocalParameterI4uivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLuint);  
  TglNamedProgramLocalParametersI4uivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLuint);  
  TglGetNamedProgramLocalParameterIivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLint);  
  TglGetNamedProgramLocalParameterIuivEXT = PROCEDURE { C }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLuint);  
  TglTextureParameterIivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglTextureParameterIuivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLuint);  
  TglGetTextureParameterIivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetTextureParameterIuivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);  
  TglMultiTexParameterIivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexParameterIuivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLuint);  
  TglGetMultiTexParameterIivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexParameterIuivEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);  
  TglProgramUniform1fEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat);  
  TglProgramUniform2fEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);  
  TglProgramUniform3fEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);  
  TglProgramUniform4fEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);  
  TglProgramUniform1iEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint);  
  TglProgramUniform2iEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint);  
  TglProgramUniform3iEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);  
  TglProgramUniform4iEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);  
  TglProgramUniform1fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform2fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform3fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform4fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform1ivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform2ivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform3ivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform4ivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniformMatrix2fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix2x3fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3x2fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix2x4fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4x2fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3x4fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4x3fvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniform1uiEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint);  
  TglProgramUniform2uiEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint);  
  TglProgramUniform3uiEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);  
  TglProgramUniform4uiEXT = PROCEDURE { C }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);  
  TglProgramUniform1uivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform2uivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform3uivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform4uivEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglNamedBufferDataEXT = PROCEDURE { C }(buffer: GLuint; size: GLsizei; CONST data: PGLvoid; usage: GLenum);  
  TglNamedBufferSubDataEXT = PROCEDURE { C }(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; CONST data: PGLvoid);  
  TglMapNamedBufferEXT = PROCEDURE { C }(buffer: GLuint; access: GLenum): PGLvoid;  
  TglUnmapNamedBufferEXT = PROCEDURE { C }(buffer: GLuint): GLboolean;  
  TglMapNamedBufferRangeEXT = PROCEDURE { C }(buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): PGLvoid;  
  TglFlushMappedNamedBufferRangeEXT = PROCEDURE { C }(buffer: GLuint; offset: GLintptr; length: GLsizeiptr);  
  TglNamedCopyBufferSubDataEXT = PROCEDURE { C }(readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr);  
  TglGetNamedBufferParameterivEXT = PROCEDURE { C }(buffer: GLuint; pname: GLenum; params: PGLint);  
  TglGetNamedBufferPointervEXT = PROCEDURE { C }(buffer: GLuint; pname: GLenum; params: PPGLvoid);  
  TglGetNamedBufferSubDataEXT = PROCEDURE { C }(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: PGLvoid);  
  TglTextureBufferEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint);  
  TglMultiTexBufferEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; interformat: GLenum; buffer: GLuint);  
  TglNamedRenderbufferStorageEXT = PROCEDURE { C }(renderbuffer: GLuint; interformat: GLenum; width: GLsizei; height: GLsizei);  
  TglGetNamedRenderbufferParameterivEXT = PROCEDURE { C }(renderbuffer: GLuint; pname: GLenum; params: PGLint);  
  TglCheckNamedFramebufferStatusEXT = PROCEDURE { C }(framebuffer: GLuint; target: GLenum): GLenum;  
  TglNamedFramebufferTexture1DEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTexture2DEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTexture3DEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);  
  TglNamedFramebufferRenderbufferEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);  
  TglGetNamedFramebufferAttachmentParameterivEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint);  
  TglGenerateTextureMipmapEXT = PROCEDURE { C }(texture: GLuint; target: GLenum);  
  TglGenerateMultiTexMipmapEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum);  
  TglFramebufferDrawBufferEXT = PROCEDURE { C }(framebuffer: GLuint; mode: GLenum);  
  TglFramebufferDrawBuffersEXT = PROCEDURE { C }(framebuffer: GLuint; n: GLsizei; CONST bufs: PGLenum);  
  TglFramebufferReadBufferEXT = PROCEDURE { C }(framebuffer: GLuint; mode: GLenum);  
  TglGetFramebufferParameterivEXT = PROCEDURE { C }(framebuffer: GLuint; pname: GLenum; params: PGLint);  
  TglNamedRenderbufferStorageMultisampleEXT = PROCEDURE { C }(renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);  
  TglNamedRenderbufferStorageMultisampleCoverageEXT = PROCEDURE { C }(renderbuffer: GLuint; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);  
  TglNamedFramebufferTextureEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTextureLayerEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);  
  TglNamedFramebufferTextureFaceEXT = PROCEDURE { C }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);  
  TglTextureRenderbufferEXT = PROCEDURE { C }(texture: GLuint; target: GLenum; renderbuffer: GLuint);  
  TglMultiTexRenderbufferEXT = PROCEDURE { C }(texunit: GLenum; target: GLenum; renderbuffer: GLuint);  
  TglProgramUniform1dEXT = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLdouble);  
  TglProgramUniform2dEXT = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble);  
  TglProgramUniform3dEXT = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglProgramUniform4dEXT = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglProgramUniform1dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform2dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform3dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform4dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniformMatrix2dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix2x3dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix2x4dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3x2dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3x4dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4x2dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4x3dvEXT = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  

  (* GL_EXT_separate_shader_objects *)
  TglUseShaderProgramEXT = PROCEDURE { C }(_type: GLenum; _program: GLuint); 
  TglActiveProgramEXT = PROCEDURE { C }(_program: GLuint); 
  TglCreateShaderProgramEXT = PROCEDURE { C } (_type: GLenum; CONST _string: PGLchar): GLuint; 

   (* GL_EXT_shader_image_load_store *)
  TglBindImageTextureEXT = PROCEDURE { C }(index: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLint);  
  TglMemoryBarrierEXT = PROCEDURE { C }(barriers: GLbitfield);  

  (* GL_EXT_vertex_attrib_64bit *)
  TglVertexAttribL1dEXT = PROCEDURE { C }(index: GLuint; x: GLdouble);  
  TglVertexAttribL2dEXT = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble);  
  TglVertexAttribL3dEXT = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglVertexAttribL4dEXT = PROCEDURE { C }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglVertexAttribL1dvEXT = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL2dvEXT = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL3dvEXT = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL4dvEXT = PROCEDURE { C }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribLPointerEXT = PROCEDURE { C }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid);  
  TglGetVertexAttribLdvEXT = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLdouble);  
  TglVertexArrayVertexAttribLOffsetEXT = PROCEDURE { C }(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; offset: GLintptr);  
  
  (*  GL_MESA_resize_buffers *)
  TglResizeBuffersMESA = PROCEDURE { C }(); 

  (* GL_MESA_window_pos *)
  TglWindowPos2dMESA = PROCEDURE { C }(x: TGLdouble; y: TGLdouble); 
  TglWindowPos2dvMESA = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos2fMESA = PROCEDURE { C }(x: TGLfloat; y: TGLfloat); 
  TglWindowPos2fvMESA = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos2iMESA = PROCEDURE { C }(x: TGLint; y: TGLint); 
  TglWindowPos2ivMESA = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos2sMESA = PROCEDURE { C }(x: TGLshort; y: TGLshort); 
  TglWindowPos2svMESA = PROCEDURE { C }(CONST v: PGLshort); 
  TglWindowPos3dMESA = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglWindowPos3dvMESA = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos3fMESA = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglWindowPos3fvMESA = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos3iMESA = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint); 
  TglWindowPos3ivMESA = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos3sMESA = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglWindowPos3svMESA = PROCEDURE { C }(CONST v: PGLshort); 
  TglWindowPos4dMESA = PROCEDURE { C }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglWindowPos4dvMESA = PROCEDURE { C }(CONST v: PGLdouble); 
  TglWindowPos4fMESA = PROCEDURE { C }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglWindowPos4fvMESA = PROCEDURE { C }(CONST v: PGLfloat); 
  TglWindowPos4iMESA = PROCEDURE { C }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglWindowPos4ivMESA = PROCEDURE { C }(CONST v: PGLint); 
  TglWindowPos4sMESA = PROCEDURE { C }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglWindowPos4svMESA = PROCEDURE { C }(CONST v: PGLshort); 

  (* GL_NV_evaluators *)
  TglMapControlPointsNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; _type: TGLenum; ustride: TGLsizei; vstride: TGLsizei; uorder: TGLint; vorder: TGLint; _packed: TGLboolean; CONST points: PGLvoid); 
  TglMapParameterivNV = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglMapParameterfvNV = PROCEDURE { C }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetMapControlPointsNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; _type: TGLenum; ustride: TGLsizei; vstride: TGLsizei; _packed: TGLboolean; points: PGLvoid); 
  TglGetMapParameterivNV = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMapParameterfvNV = PROCEDURE { C }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMapAttribParameterivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetMapAttribParameterfvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglEvalMapsNV = PROCEDURE { C }(target: TGLenum; mode: TGLenum); 

  (* GL_NV_fence *)
  TglDeleteFencesNV = PROCEDURE { C }(n: TGLsizei; CONST fences: PGLuint); 
  TglGenFencesNV = PROCEDURE { C }(n: TGLsizei; fences: PGLuint); 
  TglIsFenceNV = PROCEDURE { C } (fence: TGLuint): TGLboolean; 
  TglTestFenceNV = PROCEDURE { C } (fence: TGLuint): TGLboolean; 
  TglGetFenceivNV = PROCEDURE { C }(fence: TGLuint; pname: TGLenum; params: PGLint); 
  TglFinishFenceNV = PROCEDURE { C }(fence: TGLuint); 
  TglSetFenceNV = PROCEDURE { C }(fence: TGLuint; condition: TGLenum); 

  (* GL_NV_fragment_program *)
  TglProgramNamedParameter4fNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramNamedParameter4dNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramNamedParameter4fvNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; CONST v: PGLfloat); 
  TglProgramNamedParameter4dvNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; CONST v: PGLdouble); 
  TglGetProgramNamedParameterfvNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; params: PGLfloat); 
  TglGetProgramNamedParameterdvNV = PROCEDURE { C }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; params: PGLdouble); 

  (* GL_NV_half_float *)
  TglVertex2hNV = PROCEDURE { C }(x: TGLhalfNV; y: TGLhalfNV); 
  TglVertex2hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglVertex3hNV = PROCEDURE { C }(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV); 
  TglVertex3hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglVertex4hNV = PROCEDURE { C }(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV); 
  TglVertex4hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglNormal3hNV = PROCEDURE { C }(nx: TGLhalfNV; ny: TGLhalfNV; nz: TGLhalfNV); 
  TglNormal3hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglColor3hNV = PROCEDURE { C }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV); 
  TglColor3hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglColor4hNV = PROCEDURE { C }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV; alpha: TGLhalfNV); 
  TglColor4hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglTexCoord1hNV = PROCEDURE { C }(s: TGLhalfNV); 
  TglTexCoord1hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglTexCoord2hNV = PROCEDURE { C }(s: TGLhalfNV; t: TGLhalfNV); 
  TglTexCoord2hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglTexCoord3hNV = PROCEDURE { C }(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV); 
  TglTexCoord3hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglTexCoord4hNV = PROCEDURE { C }(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV); 
  TglTexCoord4hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglMultiTexCoord1hNV = PROCEDURE { C }(target: TGLenum; s: TGLhalfNV); 
  TglMultiTexCoord1hvNV = PROCEDURE { C }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord2hNV = PROCEDURE { C }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV); 
  TglMultiTexCoord2hvNV = PROCEDURE { C }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord3hNV = PROCEDURE { C }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV); 
  TglMultiTexCoord3hvNV = PROCEDURE { C }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord4hNV = PROCEDURE { C }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV); 
  TglMultiTexCoord4hvNV = PROCEDURE { C }(target: TGLenum; CONST v: PGLhalfNV); 
  TglFogCoordhNV = PROCEDURE { C }(fog: TGLhalfNV); 
  TglFogCoordhvNV = PROCEDURE { C }(CONST fog: PGLhalfNV); 
  TglSecondaryColor3hNV = PROCEDURE { C }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV); 
  TglSecondaryColor3hvNV = PROCEDURE { C }(CONST v: PGLhalfNV); 
  TglVertexWeighthNV = PROCEDURE { C }(weight: TGLhalfNV); 
  TglVertexWeighthvNV = PROCEDURE { C }(CONST weight: PGLhalfNV); 
  TglVertexAttrib1hNV = PROCEDURE { C }(index: TGLuint; x: TGLhalfNV); 
  TglVertexAttrib1hvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib2hNV = PROCEDURE { C }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV); 
  TglVertexAttrib2hvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib3hNV = PROCEDURE { C }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV); 
  TglVertexAttrib3hvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib4hNV = PROCEDURE { C }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV); 
  TglVertexAttrib4hvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttribs1hvNV = PROCEDURE { C }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs2hvNV = PROCEDURE { C }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs3hvNV = PROCEDURE { C }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs4hvNV = PROCEDURE { C }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 

  (* GL_NV_occlusion_query *)
  TglGenOcclusionQueriesNV = PROCEDURE { C }(n: TGLsizei; ids: PGLuint); 
  TglDeleteOcclusionQueriesNV = PROCEDURE { C }(n: TGLsizei; CONST ids: PGLuint); 
  TglIsOcclusionQueryNV = PROCEDURE { C } (id: TGLuint): TGLboolean; 
  TglBeginOcclusionQueryNV = PROCEDURE { C }(id: TGLuint); 
  TglEndOcclusionQueryNV = PROCEDURE { C }(); 
  TglGetOcclusionQueryivNV = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetOcclusionQueryuivNV = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLuint); 

  (* GL_NV_pixel_data_range *)
  TglPixelDataRangeNV = PROCEDURE { C }(target: TGLenum; length: TGLsizei; _pointer: PGLvoid); 
  TglFlushPixelDataRangeNV = PROCEDURE { C }(target: TGLenum); 

  (* GL_NV_point_sprite *)
  TglPointParameteriNV = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglPointParameterivNV = PROCEDURE { C }(pname: TGLenum; CONST params: PGLint); 

  (* GL_NV_primitive_restart *)
  TglPrimitiveRestartNV = PROCEDURE { C }(); 
  TglPrimitiveRestartIndexNV = PROCEDURE { C }(index: TGLuint); 

  (* GL_NV_register_combiners *)
  TglCombinerParameterfvNV = PROCEDURE { C }(pname: TGLenum; CONST params: PGLfloat); 
  TglCombinerParameterfNV = PROCEDURE { C }(pname: TGLenum; param: TGLfloat); 
  TglCombinerParameterivNV = PROCEDURE { C }(pname: TGLenum; CONST params: PGLint); 
  TglCombinerParameteriNV = PROCEDURE { C }(pname: TGLenum; param: TGLint); 
  TglCombinerInputNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; variable: TGLenum; input: TGLenum; mapping: TGLenum; componentUsage: TGLenum); 
  TglCombinerOutputNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; abOutput: TGLenum; cdOutput: TGLenum; sumOutput: TGLenum; scale: TGLenum; bias: TGLenum; abDotProduct: TGLboolean; cdDotProduct: TGLboolean; muxSum: TGLboolean); 
  TglFinalCombinerInputNV = PROCEDURE { C }(variable: TGLenum; input: TGLenum; mapping: TGLenum; componentUsage: TGLenum); 
  TglGetCombinerInputParameterfvNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; variable: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetCombinerInputParameterivNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; variable: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetCombinerOutputParameterfvNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetCombinerOutputParameterivNV = PROCEDURE { C }(stage: TGLenum; portion: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetFinalCombinerInputParameterfvNV = PROCEDURE { C }(variable: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetFinalCombinerInputParameterivNV = PROCEDURE { C }(variable: TGLenum; pname: TGLenum; params: PGLint); 

  (* GL_NV_register_combiners2*)
  TglCombinerStageParameterfvNV = PROCEDURE { C }(stage: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetCombinerStageParameterfvNV = PROCEDURE { C }(stage: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_NV_vertex_array_range *)
  TglFlushVertexArrayRangeNV = PROCEDURE { C }(); 
  TglVertexArrayRangeNV = PROCEDURE { C }(length: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_NV_vertex_program *)
  TglAreProgramsResidentNV = PROCEDURE { C } (n: TGLsizei; CONST programs: PGLuint; residences: PGLboolean): TGLboolean; 
  TglBindProgramNV = PROCEDURE { C }(target: TGLenum; id: TGLuint); 
  TglDeleteProgramsNV = PROCEDURE { C }(n: TGLsizei; CONST programs: PGLuint); 
  TglExecuteProgramNV = PROCEDURE { C }(target: TGLenum; id: TGLuint; CONST params: PGLfloat); 
  TglGenProgramsNV = PROCEDURE { C }(n: TGLsizei; programs: PGLuint); 
  TglGetProgramParameterdvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetProgramParameterfvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetProgramivNV = PROCEDURE { C }(id: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetProgramStringNV = PROCEDURE { C }(id: TGLuint; pname: TGLenum; _program: PGLubyte); 
  TglGetTrackMatrixivNV = PROCEDURE { C }(target: TGLenum; address: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribdvNV = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetVertexAttribfvNV = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribivNV = PROCEDURE { C }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribPointervNV = PROCEDURE { C }(index: TGLuint; pname: TGLenum; _pointer: PGLvoid); 
  TglIsProgramNV = PROCEDURE { C } (id: TGLuint): TGLboolean; 
  TglLoadProgramNV = PROCEDURE { C }(target: TGLenum; id: TGLuint; len: TGLsizei; CONST _program: PGLubyte); 
  TglProgramParameter4dNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramParameter4dvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST v: PGLdouble); 
  TglProgramParameter4fNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramParameter4fvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST v: PGLfloat); 
  TglProgramParameters4dvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLuint; CONST v: PGLdouble); 
  TglProgramParameters4fvNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLuint; CONST v: PGLfloat); 
  TglRequestResidentProgramsNV = PROCEDURE { C }(n: TGLsizei; CONST programs: PGLuint); 
  TglTrackMatrixNV = PROCEDURE { C }(target: TGLenum; address: TGLuint; matrix: TGLenum; transform: TGLenum); 
  TglVertexAttribPointerNV = PROCEDURE { C }(index: TGLuint; fsize: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexAttrib1dNV = PROCEDURE { C }(index: TGLuint; x: TGLdouble); 
  TglVertexAttrib1dvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib1fNV = PROCEDURE { C }(index: TGLuint; x: TGLfloat); 
  TglVertexAttrib1fvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib1sNV = PROCEDURE { C }(index: TGLuint; x: TGLshort); 
  TglVertexAttrib1svNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib2dNV = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble); 
  TglVertexAttrib2dvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib2fNV = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat); 
  TglVertexAttrib2fvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib2sNV = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort); 
  TglVertexAttrib2svNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib3dNV = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexAttrib3dvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib3fNV = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexAttrib3fvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib3sNV = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexAttrib3svNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4dNV = PROCEDURE { C }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexAttrib4dvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib4fNV = PROCEDURE { C }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexAttrib4fvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib4sNV = PROCEDURE { C }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexAttrib4svNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubNV = PROCEDURE { C }(index: TGLuint; x: TGLubyte; y: TGLubyte; z: TGLubyte; w: TGLubyte); 
  TglVertexAttrib4ubvNV = PROCEDURE { C }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttribs1dvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs1fvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs1svNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs2dvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs2fvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs2svNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs3dvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs3fvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs3svNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs4dvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs4fvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs4svNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs4ubvNV = PROCEDURE { C }(index: TGLuint; count: TGLsizei; CONST v: PGLubyte); 

  (* GL_NV_depth_buffer_float *)
  TglDepthRangedNV = PROCEDURE { C }(n: TGLdouble; f: TGLdouble); 
  TglClearDepthdNV = PROCEDURE { C }(d: TGLdouble); 
  TglDepthBoundsdNV = PROCEDURE { C }(zmin: TGLdouble; zmax: TGLdouble); 

  (* GL_NV_framebuffer_multisample_coverage *)
  TglRenderbufferStorageMultsampleCoverageNV = PROCEDURE { C }(target: TGLenum; coverageSamples: TGLsizei; colorSamples: TGLsizei; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 

  (* GL_NV_geometry_program4 *)
  TglProgramVertexLimitNV = PROCEDURE { C }(target: TGLenum; limit: TGLint); 

  (* GL_NV_gpu_program4 *)
  TglProgramLocalParameterI4iNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglProgramLocalParameterI4ivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLint); 
  TglProgramLocalParametersI4ivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLint); 
  TglProgramLocalParameterI4uiNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglProgramLocalParameterI4uivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLuint); 
  TglProgramLocalParametersI4uivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLuint); 
  TglProgramEnvParameterI4iNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglProgramEnvParameterI4ivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLint); 
  TglProgramEnvParametersI4ivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLint); 
  TglProgramEnvParameterI4uiNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglProgramEnvParameterI4uivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; CONST params: PGLuint); 
  TglProgramEnvParametersI4uivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLuint); 
  TglGetProgramLocalParameterIivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLint); 
  TglGetProgramLocalParameterIuivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLuint); 
  TglGetProgramEnvParameterIivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLint); 
  TglGetProgramEnvParameterIuivNV = PROCEDURE { C }(target: TGLenum; index: TGLuint; params: PGLuint); 

  (* GL_NV_parameter_buffer_object *)
  TglProgramBufferParametersfvNV = PROCEDURE { C }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 
  TglProgramBufferParametersIivNV = PROCEDURE { C }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLsizei; CONST params: TGLint); 
  TglProgramBufferParametersIuivNV = PROCEDURE { C }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLuint; CONST params: PGLuint); 

  (* GL_NV_transform_feedback *)
  TglBeginTransformFeedbackNV = PROCEDURE { C }(primitiveMode: TGLenum); 
  TglEndTransformFeedbackNV = PROCEDURE { C }(); 
  TglTransformFeedbackAttribsNV = PROCEDURE { C }(count: TGLsizei; CONST attribs: TGLint; bufferMode: TGLenum); 
  TglBindBufferRangeNV = PROCEDURE { C }(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint; size: GLsizei); 
  TglBindBufferOffsetNV = PROCEDURE { C }(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint); 
  TglBindBufferBaseNV = PROCEDURE { C }(target: GLenum; index: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryingsNV = PROCEDURE { C }(program_: TGLuint; count: TGLsizei; CONST varyings: PPGLchar; bufferMode: TGLenum); 
  TglActiveVaryingNV = PROCEDURE { C }(program_: TGLuint; CONST name: PGLchar); 
  TglGetVaryingLocationNV = PROCEDURE { C } (program_: TGLuint; CONST name: PGLchar): TGLint; 
  TglGetActiveVaryingNV = PROCEDURE { C }(program_: TGLuint; index: TGLuint; bufSize: TGLsizei; length: PGLsizei; size: PGLsizei; _type: PGLenum; name: PGLchar); 
  TglGetTransformFeedbackVaryingNV = PROCEDURE { C }(program_: TGLuint; index: TGLuint; location: PGLint); 
   TglTransformFeedbackStreamAttribsNV = PROCEDURE { C } (count: GLsizei; CONST attribs: PGLint; nbuffers: GLsizei; CONST bufstreams: PGLint; bufferMode: GLenum); 
   
  (* GL_NV_conditional_render *)
  TglBeginConditionalRenderNV = PROCEDURE { C }(id: GLuint; mode: GLenum); 
  TglEndConditionalRenderNV = PROCEDURE { C }(); 

  (* GL_NV_present_video *)
  TglPresentFrameKeyedNV = PROCEDURE { C }(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDuratioId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; key0: GLuint; target1: GLenum; fill1: GLuint; key1: GLuint); 
  TglPresentFrameDualFillNV = PROCEDURE { C }(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDurationId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; target1: GLenum; fill1: GLuint; target2: GLenum; fill2: GLuint; target3: GLenum; fill3: GLuint); 
  TglGetVideoivNV = PROCEDURE { C }(video_slot: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideouivNV = PROCEDURE { C }(video_slot: GLuint; pname: GLenum; params: PGLuint); 
  TglGetVideoi64vNV = PROCEDURE { C }(video_slot: GLuint; pname: GLenum; params: PGLint64EXT); 
  TglGetVideoui64vNV = PROCEDURE { C }(video_slot: GLuint; pname: GLenum; params: PGLuint64EXT); 
(*  TglVideoParameterivNV = PROCEDURE { C }(video_slot: GLuint; pname: GLenum; CONST params: PGLint);  *)
  
  (* GL_NV_explicit_multisample *)
  TglGetMultisamplefvNV = PROCEDURE { C } (pname: GLenum; index: GLuint; val: PGLfloat); 
  TglSampleMaskIndexedNV = PROCEDURE { C } (index: GLuint; mask: GLbitfield); 
  TglTexRenderbufferNV = PROCEDURE { C } (target: GLenum; renderbuffer: GLuint); 

  (* GL_NV_transform_feedback2 *)
  TglBindTransformFeedbackNV = PROCEDURE { C }(target: GLenum; id: GLuint); 
  TglDeleteTransformFeedbacksNV = PROCEDURE { C }(n: GLsizei; ids: PGLuint); 
  TglGenTransformFeedbacksNV = PROCEDURE { C }(n: GLsizei; ids: PGLuint); 
  TglIsTransformFeedbackNV = PROCEDURE { C }(id: GLuint): GLboolean; 
  TglPauseTransformFeedbackNV = PROCEDURE { C }(); 
  TglResumeTransformFeedbackNV = PROCEDURE { C }(); 
  TglDrawTransformFeedbackNV = PROCEDURE { C }(mode: GLenum; id: GLuint); 

  (* GL_NV_video_capture *)
  TglBeginVideoCaptureNV = PROCEDURE { C }(video_capture_slot: GLuint); 
  TglBindVideoCaptureStreamBufferNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; offset: GLsizei); 
  TglBindVideoCaptureStreamTextureNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; target: GLenum; texture: GLuint); 
  TglEndVideoCaptureNV = PROCEDURE { C }(video_capture_slot: GLuint); 
  TglGetVideoCaptureivNV = PROCEDURE { C }(video_capture_slot: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideoCaptureStreamivNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideoCaptureStreamfvNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetVideoCaptureStreamdvNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLdouble); 
  TglVideoCaptureNV = PROCEDURE { C } (video_capture_slot: GLuint; sequence_num: PGLuint; capture_time: PGLuint64EXT): GLenum; 
  TglVideoCaptureStreamParameterivNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLint); 
  TglVideoCaptureStreamParameterfvNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLfloat); 
  TglVideoCaptureStreamParameterdvNV = PROCEDURE { C }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLdouble); 

  (* GL_NV_copy_image *)
  TglCopyImageSubDataNV = PROCEDURE { C }(srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei); 

    (* GL_NV_shader_buffer_load *)
  TglMakeBufferResidentNV = PROCEDURE { C }(target: GLenum; access: GLenum); 
  TglMakeBufferNonResidentNV = PROCEDURE { C }(target: GLenum); 
  TglIsBufferResidentNV = PROCEDURE { C }(target: GLenum): GLboolean; 
  TglMakeNamedBufferResidentNV = PROCEDURE { C }(buffer: GLuint; access: GLenum); 
  TglMakeNamedBufferNonResidentNV = PROCEDURE { C }(buffer: GLuint); 
  TglIsNamedBufferResidentNV = PROCEDURE { C }(buffer: GLuint): GLboolean; 
  TglGetBufferParameterui64vNV = PROCEDURE { C }(target: GLenum; pname: GLenum; params: PGLuint64EXT); 
  TglGetNamedBufferParameterui64vNV = PROCEDURE { C }(buffer: GLuint; pname: GLenum; params: PGLuint64EXT); 
  TglGetIntegerui64vNV = PROCEDURE { C }(value: GLenum; result: PGLuint64EXT); 
  TglUniformui64NV = PROCEDURE { C }(location: GLint; value: GLuint64EXT); 
  TglUniformui64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT); 
  TglGetUniformui64vNV = PROCEDURE { C }(_program: GLuint; location: GLint; params: PGLuint64EXT); 
  TglProgramUniformui64NV = PROCEDURE { C }(_program: GLuint; location: GLint; value: GLuint64EXT); 
  TglProgramUniformui64vNV = PROCEDURE { C }(_program: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT); 

  (* GL_NV_vertex_buffer_unified_memory *)
  TglBufferAddressRangeNV = PROCEDURE { C }(pname: GLenum; index: GLuint; adress: GLuint64EXT; length: GLsizei); 
  TglVertexFormatNV = PROCEDURE { C }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglNormalFormatNV = PROCEDURE { C }(_type: GLenum; stride: GLsizei); 
  TglColorFormatNV = PROCEDURE { C }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglIndexFormatNV = PROCEDURE { C }(_type: GLenum; stride: GLsizei); 
  TglTexCoordFormatNV = PROCEDURE { C }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglEdgeFlagFormatNV = PROCEDURE { C }(stride: GLsizei); 
  TglSecondaryColorFormatNV = PROCEDURE { C }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglFogCoordFormatNV = PROCEDURE { C }(_type: GLenum; stride: GLsizei); 
  TglVertexAttribFormatNV = PROCEDURE { C }(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei); 
  TglVertexAttribIFormatNV = PROCEDURE { C }(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei); 
  TglGetIntegerui64i_vNV = PROCEDURE { C }(value: GLenum; index: GLuint; Result: PGLuint64EXT); 

   (* GL_NV_gpu_program5 *)
  TglProgramSubroutineParametersuivNV = PROCEDURE { C }(target: GLenum; count: GLsizei; CONST params: PGLuint);  
  TglGetProgramSubroutineParameteruivNV = PROCEDURE { C }(target: GLenum; index: GLuint; param: PGLuint); 

    (*  GL_NV_gpu_shader5 *)
  TglUniform1i64NV = PROCEDURE { C }(location: GLint; x: GLint64EXT);  
  TglUniform2i64NV = PROCEDURE { C }(location: GLint; x: GLint64EXT; y: GLint64EXT);  
  TglUniform3i64NV = PROCEDURE { C }(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglUniform4i64NV = PROCEDURE { C }(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglUniform1i64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform2i64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform3i64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform4i64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform1ui64NV = PROCEDURE { C }(location: GLint; x: GLuint64EXT);  
  TglUniform2ui64NV = PROCEDURE { C }(location: GLint; x: GLuint64EXT; y: GLuint64EXT);  
  TglUniform3ui64NV = PROCEDURE { C }(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglUniform4ui64NV = PROCEDURE { C }(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglUniform1ui64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform2ui64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform3ui64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform4ui64vNV = PROCEDURE { C }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglGetUniformi64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; params: PGLint64EXT);  
  TglProgramUniform1i64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLint64EXT);  
  TglProgramUniform2i64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT);  
  TglProgramUniform3i64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglProgramUniform4i64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglProgramUniform1i64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform2i64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform3i64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform4i64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform1ui64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLuint64EXT);  
  TglProgramUniform2ui64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT);  
  TglProgramUniform3ui64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglProgramUniform4ui64NV = PROCEDURE { C }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglProgramUniform1ui64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform2ui64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform3ui64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform4ui64vNV = PROCEDURE { C }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  

  (* GL_NV_vertex_attrib_integer_64bit *)
  TglVertexAttribL1i64NV = PROCEDURE { C }(index: GLuint; x: GLint64EXT);  
  TglVertexAttribL2i64NV = PROCEDURE { C }(index: GLuint; x: GLint64EXT; y: GLint64EXT);  
  TglVertexAttribL3i64NV = PROCEDURE { C }(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglVertexAttribL4i64NV = PROCEDURE { C }(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglVertexAttribL1i64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL2i64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL3i64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL4i64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL1ui64NV = PROCEDURE { C }(index: GLuint; x: GLuint64EXT);  
  TglVertexAttribL2ui64NV = PROCEDURE { C }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT);  
  TglVertexAttribL3ui64NV = PROCEDURE { C }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglVertexAttribL4ui64NV = PROCEDURE { C }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglVertexAttribL1ui64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL2ui64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL3ui64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL4ui64vNV = PROCEDURE { C }(index: GLuint; CONST v: PGLuint64EXT);  
  TglGetVertexAttribLi64vNV = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLint64EXT);  
  TglGetVertexAttribLui64vNV = PROCEDURE { C }(index: GLuint; pname: GLenum; params: PGLuint64EXT);  
  TglVertexAttribLFormatNV = PROCEDURE { C }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei);  

  (* GL_NV_vdpau_interop *)
  TglVDPAUInitNV = PROCEDURE { C }(CONST vdpDevice: PGLvoid; CONST getProcAddress: PGLvoid);  
  TglVDPAUFiniNV = PROCEDURE { C };  
  TglVDPAURegisterVideoSurfaceNV = PROCEDURE { C }(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei; CONST textureNames: PGLuint): GLvdpauSurfaceNV;  
  TglVDPAURegisterOutputSurfaceNV = PROCEDURE { C }(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei; CONST textureNames: PGLuint): GLvdpauSurfaceNV;  
  TglVDPAUIsSurfaceNV = PROCEDURE { C }(surface: GLvdpauSurfaceNV);  
  TglVDPAUUnregisterSurfaceNV = PROCEDURE { C }(surface: GLvdpauSurfaceNV);  
  TglVDPAUGetSurfaceivNV = PROCEDURE { C }(surface: GLvdpauSurfaceNV; pname: GLenum; bufSize: GLsizei; length: PGLsizei; values: PGLint);  
  TglVDPAUSurfaceAccessNV = PROCEDURE { C }(surface: GLvdpauSurfaceNV; access: GLenum);  
  TglVDPAUMapSurfacesNV = PROCEDURE { C }(numSurfaces: GLsizei; CONST surfaces: PGLvdpauSurfaceNV);  
  TglVDPAUUnmapSurfacesNV = PROCEDURE { C }(numSurface: GLsizei; CONST surfaces: PGLvdpauSurfaceNV);  

  (* GL_NV_texture_barrier *)
  TglTextureBarrierNV = PROCEDURE { C };

 (*! window support functions for Linux *)
(* ************************************************* *)

  TglXChooseVisual = PROCEDURE { C } (dpy: PDisplay; screen: GLint; attribList: ADDRESS (*PGLint*)): PXVisualInfo; 
  TglXCopyContext = PROCEDURE { C }(dpy: PDisplay; src: GLXContext; dst: GLXContext; mask: GLuint); 
  TglXCreateContext = PROCEDURE { C } (dpy: PDisplay; vis: PXVisualInfo; shareList: GLXContext; direct: GLboolean): GLXContext; 
  TglXCreateGLXPixmap = PROCEDURE { C } (dpy: PDisplay; vis: PXVisualInfo; pixmap: Pixmap): GLXPixmap; 
  TglXDestroyContext = PROCEDURE { C }(dpy: PDisplay; ctx: GLXContext); 
  TglXDestroyGLXPixmap = PROCEDURE { C }(dpy : PDisplay; pix: GLXPixmap); 
  TglXGetConfig = PROCEDURE { C } (dpy : PDisplay; vis: PXVisualInfo; attrib: GLint; VAR value: GLint): GLint; 
  TglXGetCurrentContext = PROCEDURE { C }(): GLXContext; 
  TglXGetCurrentDrawable = PROCEDURE { C }(): GLXDrawable ;
  TglXIsDirect = PROCEDURE { C } (dpy: PDisplay; ctx: GLXContext): GLboolean; 
  TglXMakeCurrent = PROCEDURE { C } (dpy: PDisplay; drawable: GLXDrawable; ctx: GLXContext): GLboolean;
  TglXQueryExtension = PROCEDURE { C } (dpy: PDisplay;  errorBase: ADDRESS (*GLint*); eventBase: (*GLint*) ADDRESS): GLboolean; 
  TglXQueryVersion = PROCEDURE { C } (dpy: PDisplay; VAR major: GLint; VAR minor: GLint): GLboolean; 
  TglXSwapBuffers = PROCEDURE { C }(dpy: PDisplay; drawable: GLXDrawable); 
  TglXUseXFont = PROCEDURE { C }(font: Font; first: GLint; count: GLint; listBase: GLint); 
  TglXWaitGL = PROCEDURE { C };  
  TglXWaitX = PROCEDURE { C }; 

  TglXGetClientString = PROCEDURE { C }( dpy: PDisplay; name: GLint): PGLchar; 
  TglXQueryServerString = PROCEDURE { C } (dpy: PDisplay; screen: GLint; name: GLint): PGLchar; 
  TglXQueryExtensionsString = PROCEDURE { C } (dpy: PDisplay; screen: GLint): PGLchar; 

  (* GLX_VERSION_1_3 *)
  TglXGetFBConfigs = PROCEDURE { C } (dpy: PDisplay; screen: GLint; nelements: PGLint): GLXFBConfig; 
  TglXChooseFBConfig = PROCEDURE { C } (dpy: PDisplay; screen: GLint; attrib_list: PGLint; nelements: PGLint): GLXFBConfig; 
  TglXGetFBConfigAttrib = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; attribute: GLint; value: PGLint): GLint; 
  TglXGetVisualFromFBConfig = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig) : PXVisualInfo;
  TglXCreateWindow = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; win: Window; attrib_list: PGLint): GLXWindow; 
  TglXDestroyWindow = PROCEDURE { C }(dpy: PDisplay; win: GLXWindow); 
  TglXCreatePixmap = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; pixmap: Pixmap; attrib_list: PGLint): GLXPixmap; 

  TglXDestroyPixmap = PROCEDURE { C }(dpy: PDisplay; pixmap: GLXPixmap); 
  TglXCreatePbuffer = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; attrib_list: PGLint): GLXPbuffer; 
  TglXDestroyPbuffer = PROCEDURE { C }(dpy: PDisplay; pbuf: GLXPbuffer); 
  TglXQueryDrawable = PROCEDURE { C }(dpy: PDisplay; draw: GLXDrawable; attribute: GLint; value: PGLuint); 
  TglXCreateNewContext = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; render_type: GLint; share_list: GLXContext; direct: GLboolean): GLXContext ;
  TglXMakeContextCurrent = PROCEDURE { C }( display: PDisplay; draw: GLXDrawable; read_: GLXDrawable; ctx: GLXContext): GLboolean; 
  TglXGetCurrentReadDrawable = PROCEDURE { C }(): GLXDrawable; 
  TglXGetCurrentDisplay = PROCEDURE { C }(): PDisplay;

  TglXQueryContext = PROCEDURE { C } (dpy: PDisplay; ctx: GLXContext; attribute: GLint; VAR value: GLint): GLint; 
  TglXSelectEvent = PROCEDURE { C }(dpy: PDisplay; draw: GLXDrawable; event_mask: GLuint); 
  TglXGetSelectedEvent = PROCEDURE { C }(dpy: PDisplay; draw: GLXDrawable; VAR event_mask: GLuint); 

  (* GLX_VERSION_1_4 *)
  TglXGetProcAddress = PROCEDURE { C } (CONST name: ARRAY OF CHAR): Pointer; 

  (* GLX_ARB_get_proc_address *)
  TglXGetProcAddressARB = PROCEDURE { C } (CONST name: ARRAY OF CHAR): Pointer; 

  (* GLX_ARB_create_context *)
  TglXCreateContextAttribsARB = PROCEDURE { C } (dpy: PDisplay; config: GLXFBConfig; share_context: GLXContext; direct: GLboolean;  attrib_list: PGLint): GLXContext; 

  (* GLX_EXT_import_context *)
  TglXGetCurrentDisplayEXT = PROCEDURE { C }(): PDisplay; 
  TglXQueryContextInfoEXT = PROCEDURE { C } (dpy: PDisplay; context: GLXContext; attribute: GLint; VAR value: GLint): GLint; 
  TglXGetContextIDEXT = PROCEDURE { C } (CONST context: GLXContext): GLXContextID; 
  TglXImportContextEXT = PROCEDURE { C } (dpy: PDisplay; contextID: GLXContextID): GLXContext; 
  TglXFreeContextEXT = PROCEDURE { C }(dpy: PDisplay; context: GLXContext); 
  
  (* GLX_EXT_texture_from_pixmap *)
  TglXBindTexImageEXT = PROCEDURE { C }(dpy: PDisplay; drawable: GLXDrawable; buffer: GLint;  attrib_list: PGLint); 
  TglXReleaseTexImageEXT = PROCEDURE { C }(dpy: PDisplay; drawable: GLXDrawable; buffer: GLint); 



  (*! GL utility functions and procedures *)
VAR

  gluErrorString - : PROCEDURE { C } (errCode: TGLenum): AnsiChar; 
  gluGetString - : PROCEDURE { C } (name: TGLenum): ADDRESS; 
  gluOrtho2D - : PROCEDURE { C }(left, right, bottom, top: TGLdouble); 
  gluPerspective - : PROCEDURE { C }(fovy, aspect, zNear, zFar: TGLdouble); 
  gluPickMatrix - : PROCEDURE { C }(x, y, width, height: TGLdouble; CONST viewport: TVector4i); 
  gluLookAt - : PROCEDURE { C }(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: TGLdouble); 
  gluProject - : PROCEDURE { C } (objx, objy, objz: TGLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; winx, winy, winz: PGLdouble): TGLint; 
  gluUnProject - : PROCEDURE { C } (winx, winy, winz: TGLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; objx, objy, objz: PGLdouble): TGLint; 
  gluScaleImage - : PROCEDURE { C } (format: TGLenum; widthin, heightin: TGLint; typein: TGLenum; datain: Pointer; widthout, heightout: TGLint; typeout: TGLenum; CONST dataout: Pointer): TGLint; 
  gluBuild1DMipmaps - : PROCEDURE { C } (target: TGLenum; components, width: TGLint; format, atype: TGLenum; CONST data: Pointer): TGLint; 
  gluBuild2DMipmaps - : PROCEDURE { C } (target: TGLenum; components, width, height: TGLint; format, atype: TGLenum; CONST Data: Pointer): TGLint; 
  gluNewQuadric - : PROCEDURE { C }(): TGLUQuadric; 
  gluDeleteQuadric - : PROCEDURE { C }(state: TGLUQuadric); 
  gluQuadricNormals - : PROCEDURE { C }(quadObject: TGLUQuadric; normals: TGLenum); 
  gluQuadricTexture - : PROCEDURE { C }(quadObject: PGLUQuadric; textureCoords: TGLboolean); 
  gluQuadricOrientation - : PROCEDURE { C }(quadObject: PGLUQuadric; orientation: TGLenum); 
  gluQuadricDrawStyle - : PROCEDURE { C }(quadObject: TGLUQuadric; drawStyle: TGLenum); 
  gluCylinder - : PROCEDURE { C }(quadObject: TGLUQuadric; baseRadius, topRadius, height: TGLdouble; slices, stacks: TGLint); 
  gluDisk - : PROCEDURE { C }(quadObject: TGLUQuadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint); 
  gluPartialDisk - : PROCEDURE { C }(quadObject: TGLUQuadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint; startAngle, sweepAngle: TGLdouble); 
  gluSphere - : PROCEDURE { C }(quadObject: TGLUQuadric; radius: TGLdouble; slices, stacks: TGLint); 
  gluQuadricCallback - : PROCEDURE { C }(quadObject: TGLUQuadric; which: TGLenum; fn: ADDRESS (*TGLUQuadricErrorProc*)); 
  gluNewTess - : PROCEDURE { C }(): PGLUTesselator; 
  gluDeleteTess - : PROCEDURE { C }(tess: PGLUTesselator); 
  gluTessBeginPolygon - : PROCEDURE { C }(tess: PGLUTesselator; polygon_data: Pointer); 
  gluTessBeginContour - : PROCEDURE { C }(tess: PGLUTesselator); 
  gluTessVertex - : PROCEDURE { C }(tess: PGLUTesselator; CONST coords: TGLArrayd3; data: Pointer); 
  gluTessEndContour - : PROCEDURE { C }(tess: PGLUTesselator); 
  gluTessEndPolygon - : PROCEDURE { C }(tess: PGLUTesselator); 
  gluTessProperty - : PROCEDURE { C }(tess: PGLUTesselator; which: TGLenum; value: TGLdouble); 
  gluTessNormal - : PROCEDURE { C }(tess: PGLUTesselator; x, y, z: TGLdouble); 
  gluTessCallback - : PROCEDURE { C }(tess: PGLUTesselator; which: TGLenum; fn: Pointer); 
  gluGetTessProperty - : PROCEDURE { C }(tess: PGLUTesselator; which: TGLenum; value: PGLdouble); 
  gluNewNurbsRenderer - : PROCEDURE { C }(): PGLUNurbs; 
  gluDeleteNurbsRenderer - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluBeginSurface - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluBeginCurve - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluEndCurve - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluEndSurface - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluBeginTrim - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluEndTrim - : PROCEDURE { C }(nobj: PGLUNurbs); 
  gluPwlCurve - : PROCEDURE { C }(nobj: PGLUNurbs; count: TGLint; points: PGLfloat; stride: TGLint; atype: TGLenum); 
  gluNurbsCurve - : PROCEDURE { C }(nobj: PGLUNurbs; nknots: TGLint; knot: PGLfloat; stride: TGLint; ctlarray: PGLfloat; order: TGLint; atype: TGLenum); 
  gluNurbsSurface - : PROCEDURE { C }(nobj: PGLUNurbs; sknot_count: TGLint; sknot: PGLfloat; tknot_count: TGLint; tknot: PGLfloat; s_stride, t_stride: TGLint; ctlarray: PGLfloat; sorder, torder: TGLint; atype: TGLenum); 
  gluLoadSamplingMatrices - : PROCEDURE { C }(nobj: PGLUNurbs; CONST modelMatrix, projMatrix: TGLMatrixf4; CONST viewport: TVector4i); 
  gluNurbsProperty - : PROCEDURE { C }(nobj: PGLUNurbs; aproperty: TGLenum; value: TGLfloat); 
  gluGetNurbsProperty - : PROCEDURE { C }(nobj: PGLUNurbs; aproperty: TGLenum; value: PGLfloat); 
  gluNurbsCallback - : PROCEDURE { C }(nobj: PGLUNurbs; which: TGLenum; fn: TGLUNurbsErrorProc); 
  gluBeginPolygon - : PROCEDURE { C }(tess: PGLUTesselator); 
  gluNextContour - : PROCEDURE { C }(tess: PGLUTesselator; atype: TGLenum); 
  gluEndPolygon - : PROCEDURE { C }(tess: PGLUTesselator); 

  VAR
  
  (*! GL_VERSION_1_0*)
  glCullFace- : TglCullFace;
  glFrontFace- : TglFrontFace;
  glHint- : TglHint;
  glLineWidth- : TglLineWidth;
  glPointSize- : TglPointSize;
  glPolygonMode- : TglPolygonMode;
  glScissor- : TglScissor;
  glTexParameterf- : TglTexParameterf;
  glTexParameterfv- : TglTexParameterfv;
  glTexParameteri- : TglTexParameteri;
  glTexParameteriv- : TglTexParameteriv;
  glTexImage1D- : TglTexImage1D;
  glTexImage2D- : TglTexImage2D;
  glDrawBuffer- : TglDrawBuffer;
  glClear- : TglClear;
  glClearColor- : TglClearColor;
  glClearStencil- : TglClearStencil;
  glClearDepth- : TglClearDepth;
  glStencilMask- : TglStencilMask;
  glColorMask- : TglColorMask;
  glDepthMask- : TglDepthMask;
  glDisable- : TglDisable;
  glEnable- : TglEnable;
  glFinish- : TglFinish;
  glFlush- : TglFlush;
  glBlendFunc- : TglBlendFunc;
  glLogicOp- : TglLogicOp;
  glStencilFunc- : TglStencilFunc;
  glStencilOp- : TglStencilOp;
  glDepthFunc- : TglDepthFunc;
  glPixelStoref- : TglPixelStoref;
  glPixelStorei- : TglPixelStorei;
  glReadBuffer- : TglReadBuffer;
  glReadPixels- : TglReadPixels;
  glGetBooleanv- : TglGetBooleanv;
  glGetDoublev- : TglGetDoublev;
  glGetError- : TglGetError;
  glGetFloatv- : TglGetFloatv;
  glGetIntegerv- : TglGetIntegerv;
  glGetString- : TglGetString;
  glGetTexImage- : TglGetTexImage;
  glGetTexParameteriv- : TglGetTexParameteriv;
  glGetTexParameterfv- : TglGetTexParameterfv;
  glGetTexLevelParameterfv- : TglGetTexLevelParameterfv;
  glGetTexLevelParameteriv- : TglGetTexLevelParameteriv;
  glIsEnabled- : TglIsEnabled;
  glDepthRange- : TglDepthRange;
  glViewport- : TglViewport;

  (*! GL_VERSION_1_1*)
  glDrawArrays- : TglDrawArrays;
  glDrawElements- : TglDrawElements;
  glGetPointerv- : TglGetPointerv;
  glPolygonOffset- : TglPolygonOffset;
  glCopyTexImage1D- : TglCopyTexImage1D;
  glCopyTexImage2D- : TglCopyTexImage2D;
  glCopyTexSubImage1D- : TglCopyTexSubImage1D;
  glCopyTexSubImage2D- : TglCopyTexSubImage2D;
  glTexSubImage1D- : TglTexSubImage1D;
  glTexSubImage2D- : TglTexSubImage2D;
  glBindTexture- : TglBindTexture;
  glDeleteTextures- : TglDeleteTextures;
  glGenTextures- : TglGenTextures;
  
(*! ifdef DEPRECATED*)
  glAccum- : TglAccum;
  glAlphaFunc- : TglAlphaFunc;
  glAreTexturesResident- : TglAreTexturesResident;
  glArrayElement- : TglArrayElement;
  glBegin- : TglBegin;
  glBitmap- : TglBitmap;
  glCallList- : TglCallList;
  glCallLists- : TglCallLists;
  glClearAccum- : TglClearAccum;
  glClearIndex- : TglClearIndex;
  glClipPlane- : TglClipPlane;
  glColor3b- : TglColor3b;
  glColor3bv- : TglColor3bv;
  glColor3d- : TglColor3d;
  glColor3dv- : TglColor3dv;
  glColor3f- : TglColor3f;
  glColor3fv- : TglColor3fv;
  glColor3i- : TglColor3i;
  glColor3iv- : TglColor3iv;
  glColor3s- : TglColor3s;
  glColor3sv- : TglColor3sv;
  glColor3ub- : TglColor3ub;
  glColor3ubv- : TglColor3ubv;
  glColor3ui- : TglColor3ui;
  glColor3uiv- : TglColor3uiv;
  glColor3us- : TglColor3us;
  glColor3usv- : TglColor3usv;
  glColor4b- : TglColor4b;
  glColor4bv- : TglColor4bv;
  glColor4d- : TglColor4d;
  glColor4dv- : TglColor4dv;
  glColor4f- : TglColor4f;
  glColor4fv- : TglColor4fv;
  glColor4i- : TglColor4i;
  glColor4iv- : TglColor4iv;
  glColor4s- : TglColor4s;
  glColor4sv- : TglColor4sv;
  glColor4ub- : TglColor4ub;
  glColor4ubv- : TglColor4ubv;
  glColor4ui- : TglColor4ui;
  glColor4uiv- : TglColor4uiv;
  glColor4us- : TglColor4us;
  glColor4usv- : TglColor4usv;
  glColorMaterial- : TglColorMaterial;
  glColorPointer- : TglColorPointer;
  glCopyPixels- : TglCopyPixels;
  glDeleteLists- : TglDeleteLists;
  glDisableClientState- : TglDisableClientState;
  glDrawPixels- : TglDrawPixels;
  glEdgeFlag- : TglEdgeFlag;
  glEdgeFlagPointer- : TglEdgeFlagPointer;
  glEdgeFlagv- : TglEdgeFlagv;
  glEnableClientState- : TglEnableClientState;
  glEnd- : TglEnd;
  glEndList- : TglEndList;
  glEvalCoord1d- : TglEvalCoord1d;
  glEvalCoord1dv- : TglEvalCoord1dv;
  glEvalCoord1f- : TglEvalCoord1f;
  glEvalCoord1fv- : TglEvalCoord1fv;
  glEvalCoord2d- : TglEvalCoord2d;
  glEvalCoord2dv- : TglEvalCoord2dv;
  glEvalCoord2f- : TglEvalCoord2f;
  glEvalCoord2fv- : TglEvalCoord2fv;
  glEvalMesh1- : TglEvalMesh1;
  glEvalMesh2- : TglEvalMesh2;
  glEvalPoint1- : TglEvalPoint1;
  glEvalPoint2- : TglEvalPoint2;
  glFeedbackBuffer- : TglFeedbackBuffer;
  glFogf- : TglFogf;
  glFogfv- : TglFogfv;
  glFogi- : TglFogi;
  glFogiv- : TglFogiv;
  glFrustum- : TglFrustum;
  glGenLists- : TglGenLists;
  glGetClipPlane- : TglGetClipPlane;
  glGetLightfv- : TglGetLightfv;
  glGetLightiv- : TglGetLightiv;
  glGetMapdv- : TglGetMapdv;
  glGetMapfv- : TglGetMapfv;
  glGetMapiv- : TglGetMapiv;
  glGetMaterialfv- : TglGetMaterialfv;
  glGetMaterialiv- : TglGetMaterialiv;
  glGetPixelMapfv- : TglGetPixelMapfv;
  glGetPixelMapuiv- : TglGetPixelMapuiv;
  glGetPixelMapusv- : TglGetPixelMapusv;
  glGetPolygonStipple- : TglGetPolygonStipple;
  glGetTexEnvfv- : TglGetTexEnvfv;
  glGetTexEnviv- : TglGetTexEnviv;
  glGetTexGendv- : TglGetTexGendv;
  glGetTexGenfv- : TglGetTexGenfv;
  glGetTexGeniv- : TglGetTexGeniv;
  glIndexMask- : TglIndexMask;
  glIndexPointer- : TglIndexPointer;
  glIndexd- : TglIndexd;
  glIndexdv- : TglIndexdv;
  glIndexf- : TglIndexf;
  glIndexfv- : TglIndexfv;
  glIndexi- : TglIndexi;
  glIndexiv- : TglIndexiv;
  glIndexs- : TglIndexs;
  glIndexsv- : TglIndexsv;
  glIndexub- : TglIndexub;
  glIndexubv- : TglIndexubv;
  glInitNames- : TglInitNames;
  glInterleavedArrays- : TglInterleavedArrays;
  glIsList- : TglIsList;
  glIsTexture- : TglIsTexture;
  glLightModelf- : TglLightModelf;
  glLightModelfv- : TglLightModelfv;
  glLightModeli- : TglLightModeli;
  glLightModeliv- : TglLightModeliv;
  glLightf- : TglLightf;
  glLightfv- : TglLightfv;
  glLighti- : TglLighti;
  glLightiv- : TglLightiv;
  glLineStipple- : TglLineStipple;
  glListBase- : TglListBase;
  glLoadIdentity- : TglLoadIdentity;
  glLoadMatrixd- : TglLoadMatrixd;
  glLoadMatrixf- : TglLoadMatrixf;
  glLoadName- : TglLoadName;
  glMap1d- : TglMap1d;
  glMap1f- : TglMap1f;
  glMap2d- : TglMap2d;
  glMap2f- : TglMap2f;
  glMapGrid1d- : TglMapGrid1d;
  glMapGrid1f- : TglMapGrid1f;
  glMapGrid2d- : TglMapGrid2d;
  glMapGrid2f- : TglMapGrid2f;
  glMaterialf- : TglMaterialf;
  glMaterialfv- : TglMaterialfv;
  glMateriali- : TglMateriali;
  glMaterialiv- : TglMaterialiv;
  glMatrixMode- : TglMatrixMode;
  glMultMatrixd- : TglMultMatrixd;
  glMultMatrixf- : TglMultMatrixf;
  glNewList- : TglNewList;
  glNormal3b- : TglNormal3b;
  glNormal3bv- : TglNormal3bv;
  glNormal3d- : TglNormal3d;
  glNormal3dv- : TglNormal3dv;
  glNormal3f- : TglNormal3f;
  glNormal3fv- : TglNormal3fv;
  glNormal3i- : TglNormal3i;
  glNormal3iv- : TglNormal3iv;
  glNormal3s- : TglNormal3s;
  glNormal3sv- : TglNormal3sv;
  glNormalPointer- : TglNormalPointer;
  glOrtho- : TglOrtho;
  glPassThrough- : TglPassThrough;
  glPixelMapfv- : TglPixelMapfv;
  glPixelMapuiv- : TglPixelMapuiv;
  glPixelMapusv- : TglPixelMapusv;
  glPixelTransferf- : TglPixelTransferf;
  glPixelTransferi- : TglPixelTransferi;
  glPixelZoom- : TglPixelZoom;
  glPolygonStipple- : TglPolygonStipple;
  glPopAttrib- : TglPopAttrib;
  glPopClientAttrib- : TglPopClientAttrib;
  glPopMatrix- : TglPopMatrix;
  glPopName- : TglPopName;
  glPrioritizeTextures- : TglPrioritizeTextures;
  glPushAttrib- : TglPushAttrib;
  glPushClientAttrib- : TglPushClientAttrib;
  glPushMatrix- : TglPushMatrix;
  glPushName- : TglPushName;
  glRasterPos2d- : TglRasterPos2d;
  glRasterPos2dv- : TglRasterPos2dv;
  glRasterPos2f- : TglRasterPos2f;
  glRasterPos2fv- : TglRasterPos2fv;
  glRasterPos2i- : TglRasterPos2i;
  glRasterPos2iv- : TglRasterPos2iv;
  glRasterPos2s- : TglRasterPos2s;
  glRasterPos2sv- : TglRasterPos2sv;
  glRasterPos3d- : TglRasterPos3d;
  glRasterPos3dv- : TglRasterPos3dv;
  glRasterPos3f- : TglRasterPos3f;
  glRasterPos3fv- : TglRasterPos3fv;
  glRasterPos3i- : TglRasterPos3i;
  glRasterPos3iv- : TglRasterPos3iv;
  glRasterPos3s- : TglRasterPos3s;
  glRasterPos3sv- : TglRasterPos3sv;
  glRasterPos4d- : TglRasterPos4d;
  glRasterPos4dv- : TglRasterPos4dv;
  glRasterPos4f- : TglRasterPos4f;
  glRasterPos4fv- : TglRasterPos4fv;
  glRasterPos4i- : TglRasterPos4i;
  glRasterPos4iv- : TglRasterPos4iv;
  glRasterPos4s- : TglRasterPos4s;
  glRasterPos4sv- : TglRasterPos4sv;
  glRectd- : TglRectd;
  glRectdv- : TglRectdv;
  glRectf- : TglRectf;
  glRectfv- : TglRectfv;
  glRecti- : TglRecti;
  glRectiv- : TglRectiv;
  glRects- : TglRects;
  glRectsv- : TglRectsv;
  glRenderMode- : TglRenderMode;
  glRotated- : TglRotated;
  glRotatef- : TglRotatef;
  glScaled- : TglScaled;
  glScalef- : TglScalef;
  glSelectBuffer- : TglSelectBuffer;
  glShadeModel- : TglShadeModel;
  glTexCoord1d- : TglTexCoord1d;
  glTexCoord1dv- : TglTexCoord1dv;
  glTexCoord1f- : TglTexCoord1f;
  glTexCoord1fv- : TglTexCoord1fv;
  glTexCoord1i- : TglTexCoord1i;
  glTexCoord1iv- : TglTexCoord1iv;
  glTexCoord1s- : TglTexCoord1s;
  glTexCoord1sv- : TglTexCoord1sv;
  glTexCoord2d- : TglTexCoord2d;
  glTexCoord2dv- : TglTexCoord2dv;
  glTexCoord2f- : TglTexCoord2f;
  glTexCoord2fv- : TglTexCoord2fv;
  glTexCoord2i- : TglTexCoord2i;
  glTexCoord2iv- : TglTexCoord2iv;
  glTexCoord2s- : TglTexCoord2s;
  glTexCoord2sv- : TglTexCoord2sv;
  glTexCoord3d- : TglTexCoord3d;
  glTexCoord3dv- : TglTexCoord3dv;
  glTexCoord3f- : TglTexCoord3f;
  glTexCoord3fv- : TglTexCoord3fv;
  glTexCoord3i- : TglTexCoord3i;
  glTexCoord3iv- : TglTexCoord3iv;
  glTexCoord3s- : TglTexCoord3s;
  glTexCoord3sv- : TglTexCoord3sv;
  glTexCoord4d- : TglTexCoord4d;
  glTexCoord4dv- : TglTexCoord4dv;
  glTexCoord4f- : TglTexCoord4f;
  glTexCoord4fv- : TglTexCoord4fv;
  glTexCoord4i- : TglTexCoord4i;
  glTexCoord4iv- : TglTexCoord4iv;
  glTexCoord4s- : TglTexCoord4s;
  glTexCoord4sv- : TglTexCoord4sv;
  glTexCoordPointer- : TglTexCoordPointer;
  glTexEnvf- : TglTexEnvf;
  glTexEnvfv- : TglTexEnvfv;
  glTexEnvi- : TglTexEnvi;
  glTexEnviv- : TglTexEnviv;
  glTexGend- : TglTexGend;
  glTexGendv- : TglTexGendv;
  glTexGenf- : TglTexGenf;
  glTexGenfv- : TglTexGenfv;
  glTexGeni- : TglTexGeni;
  glTexGeniv- : TglTexGeniv;
  glTranslated- : TglTranslated;
  glTranslatef- : TglTranslatef;
  glVertex2d- : TglVertex2d;
  glVertex2dv- : TglVertex2dv;
  glVertex2f- : TglVertex2f;
  glVertex2fv- : TglVertex2fv;
  glVertex2i- : TglVertex2i;
  glVertex2iv- : TglVertex2iv;
  glVertex2s- : TglVertex2s;
  glVertex2sv- : TglVertex2sv;
  glVertex3d- : TglVertex3d;
  glVertex3dv- : TglVertex3dv;
  glVertex3f- : TglVertex3f;
  glVertex3fv- : TglVertex3fv;
  glVertex3i- : TglVertex3i;
  glVertex3iv- : TglVertex3iv;
  glVertex3s- : TglVertex3s;
  glVertex3sv- : TglVertex3sv;
  glVertex4d- : TglVertex4d;
  glVertex4dv- : TglVertex4dv;
  glVertex4f- : TglVertex4f;
  glVertex4fv- : TglVertex4fv;
  glVertex4i- : TglVertex4i;
  glVertex4iv- : TglVertex4iv;
  glVertex4s- : TglVertex4s;
  glVertex4sv- : TglVertex4sv;
  glVertexPointer- : TglVertexPointer;
(*! endif *)

  (*! GL_VERSION_1_2*)
  glBlendColor- : TglBlendColor;
  glBlendEquation- : TglBlendEquation;
  glDrawRangeElements- : TglDrawRangeElements;
  glTexImage3D- : TglTexImage3D;
  glTexSubImage3D- : TglTexSubImage3D;
  glCopyTexSubImage3D- : TglCopyTexSubImage3D;
  
(*! ifdef DEPRECATED*)
  glColorTable- : TglColorTable;
  glColorTableParameterfv- : TglColorTableParameterfv;
  glColorTableParameteriv- : TglColorTableParameteriv;
  glCopyColorTable- : TglCopyColorTable;
  glGetColorTable- : TglGetColorTable;
  glGetColorTableParameterfv- : TglGetColorTableParameterfv;
  glGetColorTableParameteriv- : TglGetColorTableParameteriv;
  glColorSubTable- : TglColorSubTable;
  glCopyColorSubTable- : TglCopyColorSubTable;
  glConvolutionFilter1D- : TglConvolutionFilter1D;
  glConvolutionFilter2D- : TglConvolutionFilter2D;
  glConvolutionParameterf- : TglConvolutionParameterf;
  glConvolutionParameterfv- : TglConvolutionParameterfv;
  glConvolutionParameteri- : TglConvolutionParameteri;
  glConvolutionParameteriv- : TglConvolutionParameteriv;
  glCopyConvolutionFilter1D- : TglCopyConvolutionFilter1D;
  glCopyConvolutionFilter2D- : TglCopyConvolutionFilter2D;
  glGetConvolutionFilter- : TglGetConvolutionFilter;
  glGetConvolutionParameterfv- : TglGetConvolutionParameterfv;
  glGetConvolutionParameteriv- : TglGetConvolutionParameteriv;
  glGetSeparableFilter- : TglGetSeparableFilter;
  glSeparableFilter2D- : TglSeparableFilter2D;
  glGetHistogram- : TglGetHistogram;
  glGetHistogramParameterfv- : TglGetHistogramParameterfv;
  glGetHistogramParameteriv- : TglGetHistogramParameteriv;
  glGetMinmax- : TglGetMinmax;
  glGetMinmaxParameterfv- : TglGetMinmaxParameterfv;
  glGetMinmaxParameteriv- : TglGetMinmaxParameteriv;
  glHistogram- : TglHistogram;
  glMinmax- : TglMinmax;
  glResetHistogram- : TglResetHistogram;
  glResetMinmax- : TglResetMinmax;
(*{$endif}*)

  (*! GL_VERSION_1_3*)
  glActiveTexture- : TglActiveTexture;
  glSampleCoverage- : TglSampleCoverage;
  glCompressedTexImage3D- : TglCompressedTexImage3D;
  glCompressedTexImage2D- : TglCompressedTexImage2D;
  glCompressedTexImage1D- : TglCompressedTexImage1D;
  glCompressedTexSubImage3D- : TglCompressedTexSubImage3D;
  glCompressedTexSubImage2D- : TglCompressedTexSubImage2D;
  glCompressedTexSubImage1D- : TglCompressedTexSubImage1D;
  glGetCompressedTexImage- : TglGetCompressedTexImage;
  
(*!  ifdef DEPRECATED*)
  glClientActiveTexture- : TglClientActiveTexture;
  glMultiTexCoord1d- : TglMultiTexCoord1d;
  glMultiTexCoord1dv- : TglMultiTexCoord1dv;
  glMultiTexCoord1f- : TglMultiTexCoord1f;
  glMultiTexCoord1fv- : TglMultiTexCoord1fv;
  glMultiTexCoord1i- : TglMultiTexCoord1i;
  glMultiTexCoord1iv- : TglMultiTexCoord1iv;
  glMultiTexCoord1s- : TglMultiTexCoord1s;
  glMultiTexCoord1sv- : TglMultiTexCoord1sv;
  glMultiTexCoord2d- : TglMultiTexCoord2d;
  glMultiTexCoord2dv- : TglMultiTexCoord2dv;
  glMultiTexCoord2f- : TglMultiTexCoord2f;
  glMultiTexCoord2fv- : TglMultiTexCoord2fv;
  glMultiTexCoord2i- : TglMultiTexCoord2i;
  glMultiTexCoord2iv- : TglMultiTexCoord2iv;
  glMultiTexCoord2s- : TglMultiTexCoord2s;
  glMultiTexCoord2sv- : TglMultiTexCoord2sv;
  glMultiTexCoord3d- : TglMultiTexCoord3d;
  glMultiTexCoord3dv- : TglMultiTexCoord3dv;
  glMultiTexCoord3f- : TglMultiTexCoord3f;
  glMultiTexCoord3fv- : TglMultiTexCoord3fv;
  glMultiTexCoord3i- : TglMultiTexCoord3i;
  glMultiTexCoord3iv- : TglMultiTexCoord3iv;
  glMultiTexCoord3s- : TglMultiTexCoord3s;
  glMultiTexCoord3sv- : TglMultiTexCoord3sv;
  glMultiTexCoord4d- : TglMultiTexCoord4d;
  glMultiTexCoord4dv- : TglMultiTexCoord4dv;
  glMultiTexCoord4f- : TglMultiTexCoord4f;
  glMultiTexCoord4fv- : TglMultiTexCoord4fv;
  glMultiTexCoord4i- : TglMultiTexCoord4i;
  glMultiTexCoord4iv- : TglMultiTexCoord4iv;
  glMultiTexCoord4s- : TglMultiTexCoord4s;
  glMultiTexCoord4sv- : TglMultiTexCoord4sv;
  glLoadTransposeMatrixf- : TglLoadTransposeMatrixf;
  glLoadTransposeMatrixd- : TglLoadTransposeMatrixd;
  glMultTransposeMatrixf- : TglMultTransposeMatrixf;
  glMultTransposeMatrixd- : TglMultTransposeMatrixd;
(*! endif *)

  (*! GL_VERSION_1_4*)
  glBlendFuncSeparate- : TglBlendFuncSeparate;
  glMultiDrawArrays- : TglMultiDrawArrays;
  glMultiDrawElements- : TglMultiDrawElements;
  glPointParameterf- : TglPointParameterf;
  glPointParameterfv- : TglPointParameterfv;
  glPointParameteri- : TglPointParameteri;
  glPointParameteriv- : TglPointParameteriv;
  
(*! ifdef DEPRECATED*)
  glFogCoordf- : TglFogCoordf;
  glFogCoordfv- : TglFogCoordfv;
  glFogCoordd- : TglFogCoordd;
  glFogCoorddv- : TglFogCoorddv;
  glFogCoordPointer- : TglFogCoordPointer;
  glSecondaryColor3b- : TglSecondaryColor3b;
  glSecondaryColor3bv- : TglSecondaryColor3bv;
  glSecondaryColor3d- : TglSecondaryColor3d;
  glSecondaryColor3dv- : TglSecondaryColor3dv;
  glSecondaryColor3f- : TglSecondaryColor3f;
  glSecondaryColor3fv- : TglSecondaryColor3fv;
  glSecondaryColor3i- : TglSecondaryColor3i;
  glSecondaryColor3iv- : TglSecondaryColor3iv;
  glSecondaryColor3s- : TglSecondaryColor3s;
  glSecondaryColor3sv- : TglSecondaryColor3sv;
  glSecondaryColor3ub- : TglSecondaryColor3ub;
  glSecondaryColor3ubv- : TglSecondaryColor3ubv;
  glSecondaryColor3ui- : TglSecondaryColor3ui;
  glSecondaryColor3uiv- : TglSecondaryColor3uiv;
  glSecondaryColor3us- : TglSecondaryColor3us;
  glSecondaryColor3usv- : TglSecondaryColor3usv;
  glSecondaryColorPointer- : TglSecondaryColorPointer;
  glWindowPos2d- : TglWindowPos2d;
  glWindowPos2dv- : TglWindowPos2dv;
  glWindowPos2f- : TglWindowPos2f;
  glWindowPos2fv- : TglWindowPos2fv;
  glWindowPos2i- : TglWindowPos2i;
  glWindowPos2iv- : TglWindowPos2iv;
  glWindowPos2s- : TglWindowPos2s;
  glWindowPos2sv- : TglWindowPos2sv;
  glWindowPos3d- : TglWindowPos3d;
  glWindowPos3dv- : TglWindowPos3dv;
  glWindowPos3f- : TglWindowPos3f;
  glWindowPos3fv- : TglWindowPos3fv;
  glWindowPos3i- : TglWindowPos3i;
  glWindowPos3iv- : TglWindowPos3iv;
  glWindowPos3s- : TglWindowPos3s;
  glWindowPos3sv- : TglWindowPos3sv;
(*! endif *)

  (*! GL_VERSION_1_5 *)
  glGenQueries- : TglGenQueries;
  glDeleteQueries- : TglDeleteQueries;
  glIsQuery- : TglIsQuery;
  glBeginQuery- : TglBeginQuery;
  glEndQuery- : TglEndQuery;
  glGetQueryiv- : TglGetQueryiv;
  glGetQueryObjectiv- : TglGetQueryObjectiv;
  glGetQueryObjectuiv- : TglGetQueryObjectuiv;
  glBindBuffer- : TglBindBuffer;
  glDeleteBuffers- : TglDeleteBuffers;
  glGenBuffers- : TglGenBuffers;
  glIsBuffer- : TglIsBuffer;
  glBufferData- : TglBufferData;
  glBufferSubData- : TglBufferSubData;
  glGetBufferSubData- : TglGetBufferSubData;
  glMapBuffer- : TglMapBuffer;
  glUnmapBuffer- : TglUnmapBuffer;
  glGetBufferParameteriv- : TglGetBufferParameteriv;
  glGetBufferPointerv- : TglGetBufferPointerv;

  (*! GL_VERSION_2_0 *)
  glBlendEquationSeparate- : TglBlendEquationSeparate;
  glDrawBuffers- : TglDrawBuffers;
  glStencilOpSeparate- : TglStencilOpSeparate;
  glStencilFuncSeparate- : TglStencilFuncSeparate;
  glStencilMaskSeparate- : TglStencilMaskSeparate;
  glAttachShader- : TglAttachShader;
  glBindAttribLocation- : TglBindAttribLocation;
  glCompileShader- : TglCompileShader;
  glCreateProgram- : TglCreateProgram;
  glCreateShader- : TglCreateShader;
  glDeleteProgram- : TglDeleteProgram;
  glDeleteShader- : TglDeleteShader;
  glDetachShader- : TglDetachShader;
  glDisableVertexAttribArray- : TglDisableVertexAttribArray;
  glEnableVertexAttribArray- : TglEnableVertexAttribArray;
  glGetActiveAttrib- : TglGetActiveAttrib;
  glGetActiveUniform- : TglGetActiveUniform;
  glGetAttachedShaders- : TglGetAttachedShaders;
  glGetAttribLocation- : TglGetAttribLocation;
  glGetProgramiv- : TglGetProgramiv;
  glGetProgramInfoLog- : TglGetProgramInfoLog;
  glGetShaderiv- : TglGetShaderiv;
  glGetShaderInfoLog- : TglGetShaderInfoLog;
  glGetShaderSource- : TglGetShaderSource;
  glGetUniformLocation- : TglGetUniformLocation;
  glGetUniformfv- : TglGetUniformfv;
  glGetUniformiv- : TglGetUniformiv;
  glGetVertexAttribfv- : TglGetVertexAttribfv;
  glGetVertexAttribiv- : TglGetVertexAttribiv;
  glGetVertexAttribPointerv- : TglGetVertexAttribPointerv;
  glIsProgram- : TglIsProgram;
  glIsShader- : TglIsShader;
  glLinkProgram- : TglLinkProgram;
  glShaderSource- : TglShaderSource;
  glUseProgram- : TglUseProgram;
  glUniform1f- : TglUniform1f;
  glUniform2f- : TglUniform2f;
  glUniform3f- : TglUniform3f;
  glUniform4f- : TglUniform4f;
  glUniform1i- : TglUniform1i;
  glUniform2i- : TglUniform2i;
  glUniform3i- : TglUniform3i;
  glUniform4i- : TglUniform4i;
  glUniform1fv- : TglUniform1fv;
  glUniform2fv- : TglUniform2fv;
  glUniform3fv- : TglUniform3fv;
  glUniform4fv- : TglUniform4fv;
  glUniform1iv- : TglUniform1iv;
  glUniform2iv- : TglUniform2iv;
  glUniform3iv- : TglUniform3iv;
  glUniform4iv- : TglUniform4iv;
  glUniformMatrix2fv- : TglUniformMatrix2fv;
  glUniformMatrix3fv- : TglUniformMatrix3fv;
  glUniformMatrix4fv- : TglUniformMatrix4fv;
  glValidateProgram- : TglValidateProgram;
  glVertexAttrib1d- : TglVertexAttrib1d;
  glVertexAttrib1dv- : TglVertexAttrib1dv;
  glVertexAttrib1f- : TglVertexAttrib1f;
  glVertexAttrib1fv- : TglVertexAttrib1fv;
  glVertexAttrib1s- : TglVertexAttrib1s;
  glVertexAttrib1sv- : TglVertexAttrib1sv;
  glVertexAttrib2d- : TglVertexAttrib2d;
  glVertexAttrib2dv- : TglVertexAttrib2dv;
  glVertexAttrib2f- : TglVertexAttrib2f;
  glVertexAttrib2fv- : TglVertexAttrib2fv;
  glVertexAttrib2s- : TglVertexAttrib2s;
  glVertexAttrib2sv- : TglVertexAttrib2sv;
  glVertexAttrib3d- : TglVertexAttrib3d;
  glVertexAttrib3dv- : TglVertexAttrib3dv;
  glVertexAttrib3f- : TglVertexAttrib3f;
  glVertexAttrib3fv- : TglVertexAttrib3fv;
  glVertexAttrib3s- : TglVertexAttrib3s;
  glVertexAttrib3sv- : TglVertexAttrib3sv;
  glVertexAttrib4Nbv- : TglVertexAttrib4Nbv;
  glVertexAttrib4Niv- : TglVertexAttrib4Niv;
  glVertexAttrib4Nsv- : TglVertexAttrib4Nsv;
  glVertexAttrib4Nub- : TglVertexAttrib4Nub;
  glVertexAttrib4Nubv- : TglVertexAttrib4Nubv;
  glVertexAttrib4Nuiv- : TglVertexAttrib4Nuiv;
  glVertexAttrib4Nusv- : TglVertexAttrib4Nusv;
  glVertexAttrib4bv- : TglVertexAttrib4bv;
  glVertexAttrib4d- : TglVertexAttrib4d;
  glVertexAttrib4dv- : TglVertexAttrib4dv;
  glVertexAttrib4f- : TglVertexAttrib4f;
  glVertexAttrib4fv- : TglVertexAttrib4fv;
  glVertexAttrib4iv- : TglVertexAttrib4iv;
  glVertexAttrib4s- : TglVertexAttrib4s;
  glVertexAttrib4sv- : TglVertexAttrib4sv;
  glVertexAttrib4ubv- : TglVertexAttrib4ubv;
  glVertexAttrib4uiv- : TglVertexAttrib4uiv;
  glVertexAttrib4usv- : TglVertexAttrib4usv;
  glVertexAttribPointer- : TglVertexAttribPointer;

  (*! GL_VERSION_2_1*)
  glUniformMatrix2x3fv- : TglUniformMatrix2x3fv;
  glUniformMatrix3x2fv- : TglUniformMatrix3x2fv;
  glUniformMatrix2x4fv- : TglUniformMatrix2x4fv;
  glUniformMatrix4x2fv- : TglUniformMatrix4x2fv;
  glUniformMatrix3x4fv- : TglUniformMatrix3x4fv;
  glUniformMatrix4x3fv- : TglUniformMatrix4x3fv;

  (*! GL_VERSION_3_0*)
  glColorMaski- : TglColorMaski;
  glGetBooleani_v- : TglGetBooleani_v;
  glGetIntegeri_v- : TglGetIntegeri_v;
  glEnablei- : TglEnablei;
  glDisablei- : TglDisablei;
  glIsEnabledi- : TglIsEnabledi;
  glBeginTransformFeedback- : TglBeginTransformFeedback;
  glEndTransformFeedback- : TglEndTransformFeedback;
  glBindBufferRange- : TglBindBufferRange;
  glBindBufferBase- : TglBindBufferBase;
  glTransformFeedbackVaryings- : TglTransformFeedbackVaryings;
  glGetTransformFeedbackVarying- : TglGetTransformFeedbackVarying;
  glClampColor- : TglClampColor;
  glBeginConditionalRender- : TglBeginConditionalRender;
  glEndConditionalRender- : TglEndConditionalRender;
  glVertexAttribI1i- : TglVertexAttribI1i;
  glVertexAttribI2i- : TglVertexAttribI2i;
  glVertexAttribI3i- : TglVertexAttribI3i;
  glVertexAttribI4i- : TglVertexAttribI4i;
  glVertexAttribI1ui- : TglVertexAttribI1ui;
  glVertexAttribI2ui- : TglVertexAttribI2ui;
  glVertexAttribI3ui- : TglVertexAttribI3ui;
  glVertexAttribI4ui- : TglVertexAttribI4ui;
  glVertexAttribI1iv- : TglVertexAttribI1iv;
  glVertexAttribI2iv- : TglVertexAttribI2iv;
  glVertexAttribI3iv- : TglVertexAttribI3iv;
  glVertexAttribI4iv- : TglVertexAttribI4iv;
  glVertexAttribI1uiv- : TglVertexAttribI1uiv;
  glVertexAttribI2uiv- : TglVertexAttribI2uiv;
  glVertexAttribI3uiv- : TglVertexAttribI3uiv;
  glVertexAttribI4uiv- : TglVertexAttribI4uiv;
  glVertexAttribI4bv- : TglVertexAttribI4bv;
  glVertexAttribI4sv- : TglVertexAttribI4sv;
  glVertexAttribI4ubv- : TglVertexAttribI4ubv;
  glVertexAttribI4usv- : TglVertexAttribI4usv;
  glVertexAttribIPointer- : TglVertexAttribIPointer;
  glGetVertexAttribIiv- : TglGetVertexAttribIiv;
  glGetVertexAttribIuiv- : TglGetVertexAttribIuiv;
  glGetUniformuiv- : TglGetUniformuiv;
  glBindFragDataLocation- : TglBindFragDataLocation;
  glGetFragDataLocation- : TglGetFragDataLocation;
  glUniform1ui- : TglUniform1ui;
  glUniform2ui- : TglUniform2ui;
  glUniform3ui- : TglUniform3ui;
  glUniform4ui- : TglUniform4ui;
  glUniform1uiv- : TglUniform1uiv;
  glUniform2uiv- : TglUniform2uiv;
  glUniform3uiv- : TglUniform3uiv;
  glUniform4uiv- : TglUniform4uiv;
  glTexParameterIiv- : TglTexParameterIiv;
  glTexParameterIuiv- : TglTexParameterIuiv;
  glGetTexParameterIiv- : TglGetTexParameterIiv;
  glGetTexParameterIuiv- : TglGetTexParameterIuiv;
  glClearBufferiv- : TglClearBufferiv;
  glClearBufferuiv- : TglClearBufferuiv;
  glClearBufferfv- : TglClearBufferfv;
  glClearBufferfi- : TglClearBufferfi;
  glGetStringi- : TglGetStringi;

  (*! GL_VERSION_3_1*)
  glDrawArraysInstanced- : TglDrawArraysInstanced;
  glDrawElementsInstanced- : TglDrawElementsInstanced;
  glTexBuffer- : TglTexBuffer;
  glPrimitiveRestartIndex- : TglPrimitiveRestartIndex;

  (*! GL_VERSION_3_2*)
  (*{ OpenGL 3.2 also reuses entry points from these extensions- : }
  { ARB_draw_elements_base_vertex }
  { ARB_provoking_vertex }
  { ARB_sync }
  { ARB_texture_multisample }*)
  glGetInteger64i_v- : TglGetInteger64i_v;
  glGetBufferParameteri64v- : TglGetBufferParameteri64v;
  glFramebufferTexture- : TglFramebufferTexture;

 (*! GL_VERSION_3_3 *)
  glVertexAttribDivisor- : TglVertexAttribDivisor;
 
  
  (*! GL_VERSION_4_0 *)
  (* OpenGL 4.0 also reuses entry points from these extensions: *)
  (* ARB_texture_query_lod (no entry points) *)
  (* ARB_draw_indirect *)
  (* ARB_gpu_shader5 (no entry points) *)
  (* ARB_gpu_shader_fp64 *)
  (* ARB_shader_subroutine *)
  (* ARB_tessellation_shader *)
  (* ARB_texture_buffer_object_rgb32 (no entry points) *)
  (* ARB_texture_cube_map_array (no entry points) *)
  (* ARB_texture_gather (no entry points) *)
  (* ARB_transform_feedback2 *)
  (* ARB_transform_feedback3 *)
  glMinSampleShading: TglMinSampleShading;
  glBlendEquationi: TglBlendEquationi;
  glBlendEquationSeparatei: TglBlendEquationSeparatei;
  glBlendFunci: TglBlendFunci;
  glBlendFuncSeparatei: TglBlendFuncSeparatei;
 
   
  (* GL_3DFX_tbuffer *)
  glTbufferMask3DFX- : TglTbufferMask3DFX;

(*
  (* GL_APPLE_element_array *)
  glElementPointerAPPLE- : TglElementPointerAPPLE;
  glDrawElementArrayAPPLE- : TglDrawElementArrayAPPLE;
  glDrawRangeElementArrayAPPLE- : TglDrawRangeElementArrayAPPLE;
  glMultiDrawElementArrayAPPLE- : TglMultiDrawElementArrayAPPLE;
  glMultiDrawRangeElementArrayAPPLE- : TglMultiDrawRangeElementArrayAPPLE;

  (*  GL_APPLE_fence *)
  glGenFencesAPPLE- : TglGenFencesAPPLE;
  glDeleteFencesAPPLE- : TglDeleteFencesAPPLE;
  glSetFenceAPPLE- : TglSetFenceAPPLE;
  glIsFenceAPPLE- : TglIsFenceAPPLE;
  glTestFenceAPPLE- : TglTestFenceAPPLE;
  glFinishFenceAPPLE- : TglFinishFenceAPPLE;
  glTestObjectAPPLE- : TglTestObjectAPPLE;
  glFinishObjectAPPLE- : TglFinishObjectAPPLE;

  (*  GL_APPLE_vertex_array_object *)
  glBindVertexArrayAPPLE- : TglBindVertexArrayAPPLE;
  glDeleteVertexArraysAPPLE- : TglDeleteVertexArraysAPPLE;
  glGenVertexArraysAPPLE- : TglGenVertexArraysAPPLE;
  glIsVertexArrayAPPLE- : TglIsVertexArrayAPPLE;

  (*  GL_APPLE_vertex_array_range *)
  glVertexArrayRangeAPPLE- : TglVertexArrayRangeAPPLE;
  glFlushVertexArrayRangeAPPLE- : TglFlushVertexArrayRangeAPPLE;
  glVertexArrayParameteriAPPLE- : TglVertexArrayParameteriAPPLE;

  (*  GL_APPLE_texture_range *)
  glTextureRangeAPPLE- : TglTextureRangeAPPLE;
  glGetTexParameterPointervAPPLE- : TglGetTexParameterPointervAPPLE;

  (*  GL_APPLE_vertex_program_evaluators *)
  glEnableVertexAttribAPPLE- : TglEnableVertexAttribAPPLE;
  glDisableVertexAttribAPPLE- : TglDisableVertexAttribAPPLE;
  glIsVertexAttribEnabledAPPLE- : TglIsVertexAttribEnabledAPPLE;
  glMapVertexAttrib1dAPPLE- : TglMapVertexAttrib1dAPPLE;
  glMapVertexAttrib1fAPPLE- : TglMapVertexAttrib1fAPPLE;
  glMapVertexAttrib2dAPPLE- : TglMapVertexAttrib2dAPPLE;
  glMapVertexAttrib2fAPPLE- : TglMapVertexAttrib2fAPPLE;

  (*  GL_APPLE_object_purgeable *)
  glObjectPurgeableAPPLE- : TglObjectPurgeableAPPLE;
  glObjectUnpurgeableAPPLE- : TglObjectUnpurgeableAPPLE;
  glGetObjectParameterivAPPLE- : TglGetObjectParameterivAPPLE;

*)

  (*  GL_ARB_matrix_palette *)
  glCurrentPaletteMatrixARB- : TglCurrentPaletteMatrixARB;
  glMatrixIndexubvARB- : TglMatrixIndexubvARB;
  glMatrixIndexusvARB- : TglMatrixIndexusvARB;
  glMatrixIndexuivARB- : TglMatrixIndexuivARB;
  glMatrixIndexPointerARB- : TglMatrixIndexPointerARB;

  (*  GL_ARB_multisample *)
  glSampleCoverageARB- : TglSampleCoverageARB;

  (*  GL_ARB_multitexture *)
  glActiveTextureARB- : TglActiveTextureARB;
  glClientActiveTextureARB- : TglClientActiveTextureARB;
  glMultiTexCoord1dARB- : TglMultiTexCoord1dARB;
  glMultiTexCoord1dvARB- : TglMultiTexCoord1dvARB;
  glMultiTexCoord1fARB- : TglMultiTexCoord1fARB;
  glMultiTexCoord1fvARB- : TglMultiTexCoord1fvARB;
  glMultiTexCoord1iARB- : TglMultiTexCoord1iARB;
  glMultiTexCoord1ivARB- : TglMultiTexCoord1ivARB;
  glMultiTexCoord1sARB- : TglMultiTexCoord1sARB;
  glMultiTexCoord1svARB- : TglMultiTexCoord1svARB;
  glMultiTexCoord2dARB- : TglMultiTexCoord2dARB;
  glMultiTexCoord2dvARB- : TglMultiTexCoord2dvARB;
  glMultiTexCoord2fARB- : TglMultiTexCoord2fARB;
  glMultiTexCoord2fvARB- : TglMultiTexCoord2fvARB;
  glMultiTexCoord2iARB- : TglMultiTexCoord2iARB;
  glMultiTexCoord2ivARB- : TglMultiTexCoord2ivARB;
  glMultiTexCoord2sARB- : TglMultiTexCoord2sARB;
  glMultiTexCoord2svARB- : TglMultiTexCoord2svARB;
  glMultiTexCoord3dARB- : TglMultiTexCoord3dARB;
  glMultiTexCoord3dvARB- : TglMultiTexCoord3dvARB;
  glMultiTexCoord3fARB- : TglMultiTexCoord3fARB;
  glMultiTexCoord3fvARB- : TglMultiTexCoord3fvARB;
  glMultiTexCoord3iARB- : TglMultiTexCoord3iARB;
  glMultiTexCoord3ivARB- : TglMultiTexCoord3ivARB;
  glMultiTexCoord3sARB- : TglMultiTexCoord3sARB;
  glMultiTexCoord3svARB- : TglMultiTexCoord3svARB;
  glMultiTexCoord4dARB- : TglMultiTexCoord4dARB;
  glMultiTexCoord4dvARB- : TglMultiTexCoord4dvARB;
  glMultiTexCoord4fARB- : TglMultiTexCoord4fARB;
  glMultiTexCoord4fvARB- : TglMultiTexCoord4fvARB;
  glMultiTexCoord4iARB- : TglMultiTexCoord4iARB;
  glMultiTexCoord4ivARB- : TglMultiTexCoord4ivARB;
  glMultiTexCoord4sARB- : TglMultiTexCoord4sARB;
  glMultiTexCoord4svARB- : TglMultiTexCoord4svARB;

  (*  GL_ARB_point_parameters *)
  glPointParameterfARB- : TglPointParameterfARB;
  glPointParameterfvARB- : TglPointParameterfvARB;

  (*  GL_ARB_texture_compression *)
  glCompressedTexImage3DARB- : TglCompressedTexImage3DARB;
  glCompressedTexImage2DARB- : TglCompressedTexImage2DARB;
  glCompressedTexImage1DARB- : TglCompressedTexImage1DARB;
  glCompressedTexSubImage3DARB- : TglCompressedTexSubImage3DARB;
  glCompressedTexSubImage2DARB- : TglCompressedTexSubImage2DARB;
  glCompressedTexSubImage1DARB- : TglCompressedTexSubImage1DARB;
  glGetCompressedTexImageARB- : TglGetCompressedTexImageARB;

  (*  GL_ARB_transpose_matrix *)
  glLoadTransposeMatrixfARB- : TglLoadTransposeMatrixfARB;
  glLoadTransposeMatrixdARB- : TglLoadTransposeMatrixdARB;
  glMultTransposeMatrixfARB- : TglMultTransposeMatrixfARB;
  glMultTransposeMatrixdARB- : TglMultTransposeMatrixdARB;

  (*  GL_ARB_vertex_blend *)
  glWeightbvARB- : TglWeightbvARB;
  glWeightsvARB- : TglWeightsvARB;
  glWeightivARB- : TglWeightivARB;
  glWeightfvARB- : TglWeightfvARB;
  glWeightdvARB- : TglWeightdvARB;
  glWeightubvARB- : TglWeightubvARB;
  glWeightusvARB- : TglWeightusvARB;
  glWeightuivARB- : TglWeightuivARB;
  glWeightPointerARB- : TglWeightPointerARB;
  glVertexBlendARB- : TglVertexBlendARB;

  (*  GL_ARB_vertex_buffer_object *)
  glBindBufferARB- : TglBindBufferARB;
  glDeleteBuffersARB- : TglDeleteBuffersARB;
  glGenBuffersARB- : TglGenBuffersARB;
  glIsBufferARB- : TglIsBufferARB;
  glBufferDataARB- : TglBufferDataARB;
  glBufferSubDataARB- : TglBufferSubData;
  glGetBufferSubDataARB- : TglGetBufferSubDataARB;
  glMapBufferARB- : TglMapBufferARB;
  glUnmapBufferARB- : TglUnmapBufferARB;
  glGetBufferParameterivARB- : TglGetBufferParameterivARB;
  glGetBufferPointervARB- : TglGetBufferPointervARB;

  (*  GL_ARB_vertex_program *)
  glVertexAttrib1dARB- : TglVertexAttrib1dARB;
  glVertexAttrib1dvARB- : TglVertexAttrib1dvARB;
  glVertexAttrib1fARB- : TglVertexAttrib1fARB;
  glVertexAttrib1fvARB- : TglVertexAttrib1fvARB;
  glVertexAttrib1sARB- : TglVertexAttrib1sARB;
  glVertexAttrib1svARB- : TglVertexAttrib1svARB;
  glVertexAttrib2dARB- : TglVertexAttrib2dARB;
  glVertexAttrib2dvARB- : TglVertexAttrib2dvARB;
  glVertexAttrib2fARB- : TglVertexAttrib2fARB;
  glVertexAttrib2fvARB- : TglVertexAttrib2fvARB;
  glVertexAttrib2sARB- : TglVertexAttrib2sARB;
  glVertexAttrib2svARB- : TglVertexAttrib2svARB;
  glVertexAttrib3dARB- : TglVertexAttrib3dARB;
  glVertexAttrib3dvARB- : TglVertexAttrib3dvARB;
  glVertexAttrib3fARB- : TglVertexAttrib3fARB;
  glVertexAttrib3fvARB- : TglVertexAttrib3fvARB;
  glVertexAttrib3sARB- : TglVertexAttrib3sARB;
  glVertexAttrib3svARB- : TglVertexAttrib3svARB;
  glVertexAttrib4NbvARB- : TglVertexAttrib4NbvARB;
  glVertexAttrib4NivARB- : TglVertexAttrib4NivARB;
  glVertexAttrib4NsvARB- : TglVertexAttrib4NsvARB;
  glVertexAttrib4NubARB- : TglVertexAttrib4NubARB;
  glVertexAttrib4NubvARB- : TglVertexAttrib4NubvARB;
  glVertexAttrib4NuivARB- : TglVertexAttrib4NuivARB;
  glVertexAttrib4NusvARB- : TglVertexAttrib4NusvARB;
  glVertexAttrib4bvARB- : TglVertexAttrib4bvARB;
  glVertexAttrib4dARB- : TglVertexAttrib4dARB;
  glVertexAttrib4dvARB- : TglVertexAttrib4dvARB;
  glVertexAttrib4fARB- : TglVertexAttrib4fARB;
  glVertexAttrib4fvARB- : TglVertexAttrib4fvARB;
  glVertexAttrib4ivARB- : TglVertexAttrib4ivARB;
  glVertexAttrib4sARB- : TglVertexAttrib4sARB;
  glVertexAttrib4svARB- : TglVertexAttrib4svARB;
  glVertexAttrib4ubvARB- : TglVertexAttrib4ubvARB;
  glVertexAttrib4uivARB- : TglVertexAttrib4uivARB;
  glVertexAttrib4usvARB- : TglVertexAttrib4usvARB;
  glVertexAttribPointerARB- : TglVertexAttribPointerARB;
  glEnableVertexAttribArrayARB- : TglEnableVertexAttribArrayARB;
  glDisableVertexAttribArrayARB- : TglDisableVertexAttribArrayARB;
  glProgramStringARB- : TglProgramStringARB;
  glBindProgramARB- : TglBindProgramARB;
  glDeleteProgramsARB- : TglDeleteProgramsARB;
  glGenProgramsARB- : TglGenProgramsARB;

  glProgramEnvParameter4dARB- : TglProgramEnvParameter4dARB;
  glProgramEnvParameter4dvARB- : TglProgramEnvParameter4dvARB;
  glProgramEnvParameter4fARB- : TglProgramEnvParameter4fARB;
  glProgramEnvParameter4fvARB- : TglProgramEnvParameter4fvARB;
  glProgramLocalParameter4dARB- : TglProgramLocalParameter4dARB;
  glProgramLocalParameter4dvARB- : TglProgramLocalParameter4dvARB;
  glProgramLocalParameter4fARB- : TglProgramLocalParameter4fARB;
  glProgramLocalParameter4fvARB- : TglProgramLocalParameter4fvARB;
  glGetProgramEnvParameterdvARB- : TglGetProgramEnvParameterdvARB;
  glGetProgramEnvParameterfvARB- : TglGetProgramEnvParameterfvARB;
  glGetProgramLocalParameterdvARB- : TglGetProgramLocalParameterdvARB;
  glGetProgramLocalParameterfvARB- : TglGetProgramLocalParameterfvARB;
  glGetProgramivARB- : TglGetProgramivARB;
  glGetProgramStringARB- : TglGetProgramStringARB;
  glGetVertexAttribdvARB- : TglGetVertexAttribdvARB;
  glGetVertexAttribfvARB- : TglGetVertexAttribfvARB;
  glGetVertexAttribivARB- : TglGetVertexAttribivARB;
  glGetVertexAttribPointervARB- : TglGetVertexAttribPointervARB;
  glIsProgramARB- : TglIsProgramARB;

  (*  GL_ARB_window_pos *)
  glWindowPos2dARB- : TglWindowPos2dARB;
  glWindowPos2dvARB- : TglWindowPos2dvARB;
  glWindowPos2fARB- : TglWindowPos2fARB;
  glWindowPos2fvARB- : TglWindowPos2fvARB;
  glWindowPos2iARB- : TglWindowPos2iARB;
  glWindowPos2ivARB- : TglWindowPos2ivARB;
  glWindowPos2sARB- : TglWindowPos2sARB;
  glWindowPos2svARB- : TglWindowPos2svARB;
  glWindowPos3dARB- : TglWindowPos3dARB;
  glWindowPos3dvARB- : TglWindowPos3dvARB;
  glWindowPos3fARB- : TglWindowPos3fARB;
  glWindowPos3fvARB- : TglWindowPos3fvARB;
  glWindowPos3iARB- : TglWindowPos3iARB;
  glWindowPos3ivARB- : TglWindowPos3ivARB;
  glWindowPos3sARB- : TglWindowPos3sARB;
  glWindowPos3svARB- : TglWindowPos3svARB;

  (*  GL_ARB_draw_buffers *)
  glDrawBuffersARB- : TglDrawBuffersARB;

  (*  GL_ARB_color_buffer_float *)
  glClampColorARB- : TglClampColorARB;

  (*  GL_ARB_vertex_shader *)
  glGetActiveAttribARB- : TglGetActiveAttribARB;
  glGetAttribLocationARB- : TglGetAttribLocationARB;
  glBindAttribLocationARB- : TglBindAttribLocationARB;

  (*  GL_ARB_shader_objects *)
  glDeleteObjectARB- : TglDeleteObjectARB;
  glGetHandleARB- : TglGetHandleARB;
  glDetachObjectARB- : TglDetachObjectARB;
  glCreateShaderObjectARB- : TglCreateShaderObjectARB;
  glShaderSourceARB- : TglShaderSourceARB;
  glCompileShaderARB- : TglCompileShaderARB;
  glCreateProgramObjectARB- : TglCreateProgramObjectARB;
  glAttachObjectARB- : TglAttachObjectARB;
  glLinkProgramARB- : TglLinkProgramARB;
  glUseProgramObjectARB- : TglUseProgramObjectARB;
  glValidateProgramARB- : TglValidateProgramARB;
  glUniform1fARB- : TglUniform1fARB;
  glUniform2fARB- : TglUniform2fARB;
  glUniform3fARB- : TglUniform3fARB;
  glUniform4fARB- : TglUniform4fARB;
  glUniform1iARB- : TglUniform1iARB;
  glUniform2iARB- : TglUniform2iARB;
  glUniform3iARB- : TglUniform3iARB;
  glUniform4iARB- : TglUniform4iARB;
  glUniform1fvARB- : TglUniform1fvARB;
  glUniform2fvARB- : TglUniform2fvARB;
  glUniform3fvARB- : TglUniform3fvARB;
  glUniform4fvARB- : TglUniform4fvARB;
  glUniform1ivARB- : TglUniform1ivARB;
  glUniform2ivARB- : TglUniform2ivARB;
  glUniform3ivARB- : TglUniform3ivARB;
  glUniform4ivARB- : TglUniform4ivARB;
  glUniformMatrix2fvARB- : TglUniformMatrix2fvARB;
  glUniformMatrix3fvARB- : TglUniformMatrix3fvARB;
  glUniformMatrix4fvARB- : TglUniformMatrix4fvARB;
  glGetObjectParameterfvARB- : TglGetObjectParameterfvARB;
  glGetObjectParameterivARB- : TglGetObjectParameterivARB;
  glGetInfoLogARB- : TglGetInfoLogARB;
  glGetAttachedObjectsARB- : TglGetAttachedObjectsARB;
  glGetUniformLocationARB- : TglGetUniformLocationARB;
  glGetActiveUniformARB- : TglGetActiveUniformARB;
  glGetUniformfvARB- : TglGetUniformfvARB;
  glGetUniformivARB- : TglGetUniformivARB;
  glGetShaderSourceARB- : TglGetShaderSourceARB;

  (*  GL_ARB_Occlusion_Query *)
  glGenQueriesARB- : TglGenQueriesARB;
  glDeleteQueriesARB- : TglDeleteQueriesARB;
  glIsQueryARB- : TglIsQueryARB;
  glBeginQueryARB- : TglBeginQueryARB;
  glEndQueryARB- : TglEndQueryARB;
  glGetQueryivARB- : TglGetQueryivARB;
  glGetQueryObjectivARB- : TglGetQueryObjectivARB;
  glGetQueryObjectuivARB- : TglGetQueryObjectuivARB;

  (*  GL_ARB_draw_instanced *)
  glDrawArraysInstancedARB- : TglDrawArraysInstancedARB;
  glDrawElementsInstancedARB- : TglDrawElementsInstancedARB;

  (*  GL_ARB_framebuffer_object *)
  glIsRenderbuffer- : TglIsRenderbuffer;
  glBindRenderbuffer- : TglBindRenderbuffer;
  glDeleteRenderbuffers- : TglDeleteRenderbuffers;
  glGenRenderbuffers- : TglGenRenderbuffers;
  glRenderbufferStorage- : TglRenderbufferStorage;
  glGetRenderbufferParameteriv- : TglGetRenderbufferParameteriv;
  glIsFramebuffer- : TglIsFramebuffer;
  glBindFramebuffer- : TglBindFramebuffer;
  glDeleteFramebuffers- : TglDeleteFramebuffers;
  glGenFramebuffers- : TglGenFramebuffers;
  glCheckFramebufferStatus- : TglCheckFramebufferStatus;
  glFramebufferTexture1D- : TglFramebufferTexture1D;
  glFramebufferTexture2D- : TglFramebufferTexture2D;
  glFramebufferTexture3D- : TglFramebufferTexture3D;
  glFramebufferRenderbuffer- : TglFramebufferRenderbuffer;
  glGetFramebufferAttachmentParameteriv- : TglGetFramebufferAttachmentParameteriv;
  glGenerateMipmap- : TglGenerateMipmap;
  glBlitFramebuffer- : TglBlitFramebuffer;
  glRenderbufferStorageMultisample- : TglRenderbufferStorageMultisample;
  glFramebufferTextureLayer- : TglFramebufferTextureLayer;

  (*  GL_ARB_geometry_shader4 *)
  glProgramParameteriARB- : TglProgramParameteriARB;
  glFramebufferTextureARB- : TglFramebufferTextureARB;
  glFramebufferTextureLayerARB- : TglFramebufferTextureLayerARB;
  glFramebufferTextureFaceARB- : TglFramebufferTextureFaceARB;

  (*  GL_ARB_instanced_arrays *)
  glVertexAttribDivisorARB- : TglVertexAttribDivisorARB;

  (*  GL_ARB_map_buffer_range *)
  glMapBufferRange- : TglMapBufferRange;
  glFlushMappedBufferRange- : TglFlushMappedBufferRange;

  (*  GL_ARB_texture_buffer_object *)
  glTexBufferARB- : TglTexBufferARB;

  (*  GL_ARB_vertex_array_object *)
  glBindVertexArray- : TglBindVertexArray;
  glDeleteVertexArrays- : TglDeleteVertexArrays;
  glGenVertexArrays- : TglGenVertexArrays;
  glIsVertexArray- : TglIsVertexArray;

  (*  GL_ARB_uniform_buffer_object *)
  glGetUniformIndices- : TglGetUniformIndices;
  glGetActiveUniformsiv- : TglGetActiveUniformsiv;
  glGetActiveUniformName- : TglGetActiveUniformName;
  glGetUniformBlockIndex- : TglGetUniformBlockIndex;
  glGetActiveUniformBlockiv- : TglGetActiveUniformBlockiv;
  glGetActiveUniformBlockName- : TglGetActiveUniformBlockName;
  glUniformBlockBinding- : TglUniformBlockBinding;

  (*  GL_ARB_copy_buffer *)
  glCopyBufferSubData- : TglCopyBufferSubData;

  (*  GL_ARB_draw_elements_base_vertex *)
  glDrawElementsBaseVertex- : TglDrawElementsBaseVertex;
  glDrawRangeElementsBaseVertex- : TglDrawRangeElementsBaseVertex;
  glDrawElementsInstancedBaseVertex- : TglDrawElementsInstancedBaseVertex;
  glMultiDrawElementsBaseVertex- : TglMultiDrawElementsBaseVertex;

  (*  GL_ARB_provoking_vertex *)
  glProvokingVertex- : TglProvokingVertex;

  (*  GL_ARB_sync *)
  glFenceSync- : TglFenceSync;
  glIsSync- : TglIsSync;
  glDeleteSync- : TglDeleteSync;
  glClientWaitSync- : TglClientWaitSync;
  glWaitSync- : TglWaitSync;
  glGetInteger64v- : TglGetInteger64v;
  glGetSynciv- : TglGetSynciv;

  (*  GL_ARB_texture_multisample *)
  glTexImage2DMultisample- : TglTexImage2DMultisample;
  glTexImage3DMultisample- : TglTexImage3DMultisample;
  glGetMultisamplefv- : TglGetMultisamplefv;
  glSampleMaski- : TglSampleMaski;

  (*  GL_ARB_draw_buffers_blend *)
  glBlendEquationiARB- : TglBlendEquationiARB;
  glBlendEquationSeparateiARB- : TglBlendEquationSeparateiARB;
  glBlendFunciARB- : TglBlendFunciARB;
  glBlendFuncSeparateiARB- : TglBlendFuncSeparateiARB;

  (*  GL_ARB_sample_shading *)
  glMinSampleShadingARB- : TglMinSampleShadingARB;

  (*  GL_ARB_shading_language_include *)
  glNamedStringARB- : TglNamedStringARB;
  glDeleteNamedStringARB- : TglDeleteNamedStringARB;
  glCompileShaderIncludeARB- : TglCompileShaderIncludeARB;
  glIsNamedStringARB- : TglIsNamedStringARB;
  glGetNamedStringARB- : TglGetNamedStringARB;
  glGetNamedStringivARB- : TglGetNamedStringivARB;

  (*  GL_ARB_blend_func_extended *)
  glBindFragDataLocationIndexed- : TglBindFragDataLocationIndexed;
  glGetFragDataIndex- : TglGetFragDataIndex;

  (*  GL_ARB_sampler_objects *)
  glGenSamplers- : TglGenSamplers;
  glDeleteSamplers- : TglDeleteSamplers;
  glIsSampler- : TglIsSampler;
  glBindSampler- : TglBindSampler;
  glSamplerParameteri- : TglSamplerParameteri;
  glSamplerParameteriv- : TglSamplerParameteriv;
  glSamplerParameterf- : TglSamplerParameterf;
  glSamplerParameterfv- : TglSamplerParameterfv;
  glSamplerParameterIiv- : TglSamplerParameterIiv;
  glSamplerParameterIuiv- : TglSamplerParameterIuiv;
  glGetSamplerParameteriv- : TglGetSamplerParameteriv;
  glGetSamplerParameterIiv- : TglGetSamplerParameterIiv;
  glGetSamplerParameterfv- : TglGetSamplerParameterfv;
  glGetSamplerParameterIuiv- : TglGetSamplerParameterIuiv;

  (*  GL_ARB_timer_query *)
  glQueryCounter- : TglQueryCounter;
  glGetQueryObjecti64v- : TglGetQueryObjecti64v;
  glGetQueryObjectui64v- : TglGetQueryObjectui64v;

  (*  GL_ARB_vertex_type_2_10_10_10_rev *)
  glVertexP2ui- : TglVertexP2ui;
  glVertexP2uiv- : TglVertexP2uiv;
  glVertexP3ui- : TglVertexP3ui;
  glVertexP3uiv- : TglVertexP3uiv;
  glVertexP4ui- : TglVertexP4ui;
  glVertexP4uiv- : TglVertexP4uiv;
  glTexCoordP1ui- : TglTexCoordP1ui;
  glTexCoordP1uiv- : TglTexCoordP1uiv;
  glTexCoordP2ui- : TglTexCoordP2ui;
  glTexCoordP2uiv- : TglTexCoordP2uiv;
  glTexCoordP3ui- : TglTexCoordP3ui;
  glTexCoordP3uiv- : TglTexCoordP3uiv;
  glTexCoordP4ui- : TglTexCoordP4ui;
  glTexCoordP4uiv- : TglTexCoordP4uiv;
  glMultiTexCoordP1ui- : TglMultiTexCoordP1ui;
  glMultiTexCoordP1uiv- : TglMultiTexCoordP1uiv;
  glMultiTexCoordP2ui- : TglMultiTexCoordP2ui;
  glMultiTexCoordP2uiv- : TglMultiTexCoordP2uiv;
  glMultiTexCoordP3ui- : TglMultiTexCoordP3ui;
  glMultiTexCoordP3uiv- : TglMultiTexCoordP3uiv;
  glMultiTexCoordP4ui- : TglMultiTexCoordP4ui;
  glMultiTexCoordP4uiv- : TglMultiTexCoordP4uiv;
  glNormalP3ui- : TglNormalP3ui;
  glNormalP3uiv- : TglNormalP3uiv;
  glColorP3ui- : TglColorP3ui;
  glColorP3uiv- : TglColorP3uiv;
  glColorP4ui- : TglColorP4ui;
  glColorP4uiv- : TglColorP4uiv;
  glSecondaryColorP3ui- : TglSecondaryColorP3ui;
  glSecondaryColorP3uiv- : TglSecondaryColorP3uiv;
  glVertexAttribP1ui- : TglVertexAttribP1ui;
  glVertexAttribP1uiv- : TglVertexAttribP1uiv;
  glVertexAttribP2ui- : TglVertexAttribP2ui;
  glVertexAttribP2uiv- : TglVertexAttribP2uiv;
  glVertexAttribP3ui- : TglVertexAttribP3ui;
  glVertexAttribP3uiv- : TglVertexAttribP3uiv;
  glVertexAttribP4ui- : TglVertexAttribP4ui;
  glVertexAttribP4uiv- : TglVertexAttribP4uiv;

  (*  GL_ARB_draw_indirect *)
  glDrawArraysIndirect- : TglDrawArraysIndirect;
  glDrawElementsIndirect- : TglDrawElementsIndirect;

  (*  GL_ARB_gpu_shader_fp64 *)
  glUniform1d- : TglUniform1d;
  glUniform2d- : TglUniform2d;
  glUniform3d- : TglUniform3d;
  glUniform4d- : TglUniform4d;
  glUniform1dv- : TglUniform1dv;
  glUniform2dv- : TglUniform2dv;
  glUniform3dv- : TglUniform3dv;
  glUniform4dv- : TglUniform4dv;
  glUniformMatrix2dv- : TglUniformMatrix2dv;
  glUniformMatrix3dv- : TglUniformMatrix3dv;
  glUniformMatrix4dv- : TglUniformMatrix4dv;
  glUniformMatrix2x3dv- : TglUniformMatrix2x3dv;
  glUniformMatrix2x4dv- : TglUniformMatrix2x4dv;
  glUniformMatrix3x2dv- : TglUniformMatrix3x2dv;
  glUniformMatrix3x4dv- : TglUniformMatrix3x4dv;
  glUniformMatrix4x2dv- : TglUniformMatrix4x2dv;
  glUniformMatrix4x3dv- : TglUniformMatrix4x3dv;
  glGetUniformdv- : TglGetUniformdv;

  (*  GL_ARB_shader_subroutine *)
  glGetSubroutineUniformLocation- : TglGetSubroutineUniformLocation;
  glGetSubroutineIndex- : TglGetSubroutineIndex;
  glGetActiveSubroutineUniformiv- : TglGetActiveSubroutineUniformiv;
  glGetActiveSubroutineUniformName- : TglGetActiveSubroutineUniformName;
  glGetActiveSubroutineName- : TglGetActiveSubroutineName;
  glUniformSubroutinesuiv- : TglUniformSubroutinesuiv;
  glGetUniformSubroutineuiv- : TglGetUniformSubroutineuiv;
  glGetProgramStageiv- : TglGetProgramStageiv;

  (*  GL_ARB_tessellation_shader *)
  glPatchParameteri- : TglPatchParameteri;
  glPatchParameterfv- : TglPatchParameterfv;

  (*  GL_ARB_transform_feedback2 *)
  glBindTransformFeedback- : TglBindTransformFeedback;
  glDeleteTransformFeedbacks- : TglDeleteTransformFeedbacks;
  glGenTransformFeedbacks- : TglGenTransformFeedbacks;
  glIsTransformFeedback- : TglIsTransformFeedback;
  glPauseTransformFeedback- : TglPauseTransformFeedback;
  glResumeTransformFeedback- : TglResumeTransformFeedback;
  glDrawTransformFeedback- : TglDrawTransformFeedback;

  (*  GL_ARB_transform_feedback3 *)
  glDrawTransformFeedbackStream- : TglDrawTransformFeedbackStream;
  glBeginQueryIndexed- : TglBeginQueryIndexed;
  glEndQueryIndexed- : TglEndQueryIndexed;
  glGetQueryIndexediv- : TglGetQueryIndexediv;

  (*  GL_ARB_ES2_compatibility *)
  glReleaseShaderCompiler- : TglReleaseShaderCompiler;
  glShaderBinary- : TglShaderBinary;
  glGetShaderPrecisionFormat- : TglGetShaderPrecisionFormat;
  glDepthRangef- : TglDepthRangef;
  glClearDepthf- : TglClearDepthf;

  (*  GL_ARB_get_program_binary *)
  glGetProgramBinary- : TglGetProgramBinary;
  glProgramBinary- : TglProgramBinary;
  glProgramParameteri- : TglProgramParameteri;
  
  (*  GL_ARB_separate_shader_objects *)
  glUseProgramStages- : TglUseProgramStages;
  glActiveShaderProgram- : TglActiveShaderProgram;
  glCreateShaderProgramv- : TglCreateShaderProgramv;
  glBindProgramPipeline- : TglBindProgramPipeline;
  glDeleteProgramPipelines- : TglDeleteProgramPipelines;
  glGenProgramPipelines- : TglGenProgramPipelines;
  glIsProgramPipeline- : TglIsProgramPipeline;
  glGetProgramPipelineiv- : TglGetProgramPipelineiv;
  glProgramUniform1i- : TglProgramUniform1i;
  glProgramUniform1iv- : TglProgramUniform1iv;
  glProgramUniform1f- : TglProgramUniform1f;
  glProgramUniform1fv- : TglProgramUniform1fv;
  glProgramUniform1d- : TglProgramUniform1d;
  glProgramUniform1dv- : TglProgramUniform1dv;
  glProgramUniform1ui- : TglProgramUniform1ui;
  glProgramUniform1uiv- : TglProgramUniform1uiv;
  glProgramUniform2i- : TglProgramUniform2i;
  glProgramUniform2iv- : TglProgramUniform2iv;
  glProgramUniform2f- : TglProgramUniform2f;
  glProgramUniform2fv- : TglProgramUniform2fv;
  glProgramUniform2d- : TglProgramUniform2d;
  glProgramUniform2dv- : TglProgramUniform2dv;
  glProgramUniform2ui- : TglProgramUniform2ui;
  glProgramUniform2uiv- : TglProgramUniform2uiv;
  glProgramUniform3i- : TglProgramUniform3i;
  glProgramUniform3iv- : TglProgramUniform3iv;
  glProgramUniform3f- : TglProgramUniform3f;
  glProgramUniform3fv- : TglProgramUniform3fv;
  glProgramUniform3d- : TglProgramUniform3d;
  glProgramUniform3dv- : TglProgramUniform3dv;
  glProgramUniform3ui- : TglProgramUniform3ui;
  glProgramUniform3uiv- : TglProgramUniform3uiv;
  glProgramUniform4i- : TglProgramUniform4i;
  glProgramUniform4iv- : TglProgramUniform4iv;
  glProgramUniform4f- : TglProgramUniform4f;
  glProgramUniform4fv- : TglProgramUniform4fv;
  glProgramUniform4d- : TglProgramUniform4d;
  glProgramUniform4dv- : TglProgramUniform4dv;
  glProgramUniform4ui- : TglProgramUniform4ui;
  glProgramUniform4uiv- : TglProgramUniform4uiv;
  glProgramUniformMatrix2fv- : TglProgramUniformMatrix2fv;
  glProgramUniformMatrix3fv- : TglProgramUniformMatrix3fv;
  glProgramUniformMatrix4fv- : TglProgramUniformMatrix4fv;
  glProgramUniformMatrix2dv- : TglProgramUniformMatrix2dv;
  glProgramUniformMatrix3dv- : TglProgramUniformMatrix3dv;
  glProgramUniformMatrix4dv- : TglProgramUniformMatrix4dv;
  glProgramUniformMatrix2x3fv- : TglProgramUniformMatrix2x3fv;
  glProgramUniformMatrix3x2fv- : TglProgramUniformMatrix3x2fv;
  glProgramUniformMatrix2x4fv- : TglProgramUniformMatrix2x4fv;
  glProgramUniformMatrix4x2fv- : TglProgramUniformMatrix4x2fv;
  glProgramUniformMatrix3x4fv- : TglProgramUniformMatrix3x4fv;
  glProgramUniformMatrix4x3fv- : TglProgramUniformMatrix4x3fv;
  glProgramUniformMatrix2x3dv- : TglProgramUniformMatrix2x3dv;
  glProgramUniformMatrix3x2dv- : TglProgramUniformMatrix3x2dv;
  glProgramUniformMatrix2x4dv- : TglProgramUniformMatrix2x4dv;
  glProgramUniformMatrix4x2dv- : TglProgramUniformMatrix4x2dv;
  glProgramUniformMatrix3x4dv- : TglProgramUniformMatrix3x4dv;
  glProgramUniformMatrix4x3dv- : TglProgramUniformMatrix4x3dv;
  glValidateProgramPipeline- : TglValidateProgramPipeline;
  glGetProgramPipelineInfoLog- : TglGetProgramPipelineInfoLog;

  (*  GL_ARB_vertex_attrib_64bit *)
  glVertexAttribL1d- : TglVertexAttribL1d;
  glVertexAttribL2d- : TglVertexAttribL2d;
  glVertexAttribL3d- : TglVertexAttribL3d;
  glVertexAttribL4d- : TglVertexAttribL4d;
  glVertexAttribL1dv- : TglVertexAttribL1dv;
  glVertexAttribL2dv- : TglVertexAttribL2dv;
  glVertexAttribL3dv- : TglVertexAttribL3dv;
  glVertexAttribL4dv- : TglVertexAttribL4dv;
  glVertexAttribLPointer- : TglVertexAttribLPointer;
  glGetVertexAttribLdv- : TglGetVertexAttribLdv;

  (*  GL_ARB_viewport_array *)
  glViewportArrayv- : TglViewportArrayv;
  glViewportIndexedf- : TglViewportIndexedf;
  glViewportIndexedfv- : TglViewportIndexedfv;
  glScissorArrayv- : TglScissorArrayv;
  glScissorIndexed- : TglScissorIndexed;
  glScissorIndexedv- : TglScissorIndexedv;
  glDepthRangeArrayv- : TglDepthRangeArrayv;
  glDepthRangeIndexed- : TglDepthRangeIndexed;
  glGetFloati_v- : TglGetFloati_v;
  glGetDoublei_v- : TglGetDoublei_v;

  (*  GL_ARB_cl_event *)
  glCreateSyncFromCLeventARB- : TglCreateSyncFromCLeventARB;

  (*  GL_ARB_debug_output *)
  glDebugMessageControlARB- : TglDebugMessageControlARB;
  glDebugMessageInsertARB- : TglDebugMessageInsertARB;
(*  glDebugMessageCallbackARB- : TglDebugMessageCallbackARB;*)
  glGetDebugMessageLogARB- : TglGetDebugMessageLogARB;

  (*  GL_ARB_robustness *)
  glGetGraphicsResetStatusARB- : TglGetGraphicsResetStatusARB;
  glGetnMapdvARB- : TglGetnMapdvARB;
  glGetnMapfvARB- : TglGetnMapfvARB;
  glGetnMapivARB- : TglGetnMapivARB;
  glGetnPixelMapfvARB- : TglGetnPixelMapfvARB;
  glGetnPixelMapuivARB- : TglGetnPixelMapuivARB;
  glGetnPixelMapusvARB- : TglGetnPixelMapusvARB;
  glGetnPolygonStippleARB- : TglGetnPolygonStippleARB;
  glGetnColorTableARB- : TglGetnColorTableARB;
  glGetnConvolutionFilterARB- : TglGetnConvolutionFilterARB;
  glGetnSeparableFilterARB- : TglGetnSeparableFilterARB;
  glGetnHistogramARB- : TglGetnHistogramARB;
  glGetnMinmaxARB- : TglGetnMinmaxARB;
  glGetnTexImageARB- : TglGetnTexImageARB;
  glReadnPixelsARB- : TglReadnPixelsARB;
  glGetnCompressedTexImageARB- : TglGetnCompressedTexImageARB;
  glGetnUniformfvARB- : TglGetnUniformfvARB;
  glGetnUniformivARB- : TglGetnUniformivARB;
  glGetnUniformuivARB- : TglGetnUniformuivARB;
  glGetnUniformdvARB- : TglGetnUniformdvARB;

  (*  GL_ATI_draw_buffers *)
  glDrawBuffersATI- : TglDrawBuffersATI;

  (*  GL_ATI_element_array *)
  glElementPointerATI- : TglElementPointerATI;
  glDrawElementArrayATI- : TglDrawElementArrayATI;
  glDrawRangeElementArrayATI- : TglDrawRangeElementArrayATI;

  (*  GL_ATI_envmap_bumpmap *)
  glTexBumpParameterivATI- : TglTexBumpParameterivATI;
  glTexBumpParameterfvATI- : TglTexBumpParameterfvATI;
  glGetTexBumpParameterivATI- : TglGetTexBumpParameterivATI;
  glGetTexBumpParameterfvATI- : TglGetTexBumpParameterfvATI;

  (*  GL_ATI_fragment_shader *)
  glGenFragmentShadersATI- : TglGenFragmentShadersATI;
  glBindFragmentShaderATI- : TglBindFragmentShaderATI;
  glDeleteFragmentShaderATI- : TglDeleteFragmentShaderATI;
  glBeginFragmentShaderATI- : TglBeginFragmentShaderATI;
  glEndFragmentShaderATI- : TglEndFragmentShaderATI;
  glPassTexCoordATI- : TglPassTexCoordATI;
  glSampleMapATI- : TglSampleMapATI;
  glColorFragmentOp1ATI- : TglColorFragmentOp1ATI;
  glColorFragmentOp2ATI- : TglColorFragmentOp2ATI;
  glColorFragmentOp3ATI- : TglColorFragmentOp3ATI;
  glAlphaFragmentOp1ATI- : TglAlphaFragmentOp1ATI;
  glAlphaFragmentOp2ATI- : TglAlphaFragmentOp2ATI;
  glAlphaFragmentOp3ATI- : TglAlphaFragmentOp3ATI;
  glSetFragmentShaderConstantATI- : TglSetFragmentShaderConstantATI;

  (*  GL_ATI_map_object_buffer *)
  glMapObjectBufferATI- : TglMapObjectBufferATI;
  glUnmapObjectBufferATI- : TglUnmapObjectBufferATI;

  (*  GL_ATI_pn_triangles *)
  glPNTrianglesiATI- : TglPNTrianglesiATI;
  glPNTrianglesfATI- : TglPNTrianglesfATI;

  (*  GL_ATI_separate_stencil *)
  glStencilOpSeparateATI- : TglStencilOpSeparateATI;
  glStencilFuncSeparateATI- : TglStencilFuncSeparateATI;

  (*  GL_ATI_vertex_array_object *)
  glNewObjectBufferATI- : TglNewObjectBufferATI;
  glIsObjectBufferATI- : TglIsObjectBufferATI;
  glUpdateObjectBufferATI- : TglUpdateObjectBufferATI;
  glGetObjectBufferfvATI- : TglGetObjectBufferfvATI;
  glGetObjectBufferivATI- : TglGetObjectBufferivATI;
  glFreeObjectBufferATI- : TglFreeObjectBufferATI;
  glArrayObjectATI- : TglArrayObjectATI;
  glGetArrayObjectfvATI- : TglGetArrayObjectfvATI;
  glGetArrayObjectivATI- : TglGetArrayObjectivATI;
  glVariantArrayObjectATI- : TglVariantArrayObjectATI;
  glGetVariantArrayObjectfvATI- : TglGetVariantArrayObjectfvATI;
  glGetVariantArrayObjectivATI- : TglGetVariantArrayObjectivATI;
  glVertexAttribArrayObjectATI- : TglVertexAttribArrayObjectATI;
  glGetVertexAttribArrayObjectfvATI- : TglGetVertexAttribArrayObjectfvATI;
  glGetVertexAttribArrayObjectivATI- : TglGetVertexAttribArrayObjectivATI;

  (*  GL_ATI_vertex_streams *)
  glVertexStream1sATI- : TglVertexStream1sATI;
  glVertexStream1svATI- : TglVertexStream1svATI;
  glVertexStream1iATI- : TglVertexStream1iATI;
  glVertexStream1ivATI- : TglVertexStream1ivATI;
  glVertexStream1fATI- : TglVertexStream1fATI;
  glVertexStream1fvATI- : TglVertexStream1fvATI;
  glVertexStream1dATI- : TglVertexStream1dATI;
  glVertexStream1dvATI- : TglVertexStream1dvATI;
  glVertexStream2sATI- : TglVertexStream2sATI;
  glVertexStream2svATI- : TglVertexStream2svATI;
  glVertexStream2iATI- : TglVertexStream2iATI;
  glVertexStream2ivATI- : TglVertexStream2ivATI;
  glVertexStream2fATI- : TglVertexStream2fATI;
  glVertexStream2fvATI- : TglVertexStream2fvATI;
  glVertexStream2dATI- : TglVertexStream2dATI;
  glVertexStream2dvATI- : TglVertexStream2dvATI;
  glVertexStream3sATI- : TglVertexStream3sATI;
  glVertexStream3svATI- : TglVertexStream3svATI;
  glVertexStream3iATI- : TglVertexStream3iATI;
  glVertexStream3ivATI- : TglVertexStream3ivATI;
  glVertexStream3fATI- : TglVertexStream3fATI;
  glVertexStream3fvATI- : TglVertexStream3fvATI;
  glVertexStream3dATI- : TglVertexStream3dATI;
  glVertexStream3dvATI- : TglVertexStream3dvATI;
  glVertexStream4sATI- : TglVertexStream4sATI;
  glVertexStream4svATI- : TglVertexStream4svATI;
  glVertexStream4iATI- : TglVertexStream4iATI;
  glVertexStream4ivATI- : TglVertexStream4ivATI;
  glVertexStream4fATI- : TglVertexStream4fATI;
  glVertexStream4fvATI- : TglVertexStream4fvATI;
  glVertexStream4dATI- : TglVertexStream4dATI;
  glVertexStream4dvATI- : TglVertexStream4dvATI;
  glNormalStream3bATI- : TglNormalStream3bATI;
  glNormalStream3bvATI- : TglNormalStream3bvATI;
  glNormalStream3sATI- : TglNormalStream3sATI;
  glNormalStream3svATI- : TglNormalStream3svATI;
  glNormalStream3iATI- : TglNormalStream3iATI;
  glNormalStream3ivATI- : TglNormalStream3ivATI;
  glNormalStream3fATI- : TglNormalStream3fATI;
  glNormalStream3fvATI- : TglNormalStream3fvATI;
  glNormalStream3dATI- : TglNormalStream3dATI;
  glNormalStream3dvATI- : TglNormalStream3dvATI;
  glClientActiveVertexStreamATI- : TglClientActiveVertexStreamATI;
  glVertexBlendEnviATI- : TglVertexBlendEnviATI;
  glVertexBlendEnvfATI- : TglVertexBlendEnvfATI;

  (*  GL_AMD_performance_monitor *)
  glGetPerfMonitorGroupsAMD- : TglGetPerfMonitorGroupsAMD;
  glGetPerfMonitorCountersAMD- : TglGetPerfMonitorCountersAMD;
  glGetPerfMonitorGroupStringAMD- : TglGetPerfMonitorGroupStringAMD;
  glGetPerfMonitorCounterStringAMD- : TglGetPerfMonitorCounterStringAMD;
  glGetPerfMonitorCounterInfoAMD- : TglGetPerfMonitorCounterInfoAMD;
  glGenPerfMonitorsAMD- : TglGenPerfMonitorsAMD;
  glDeletePerfMonitorsAMD- : TglDeletePerfMonitorsAMD;
  glSelectPerfMonitorCountersAMD- : TglSelectPerfMonitorCountersAMD;
  glBeginPerfMonitorAMD- : TglBeginPerfMonitorAMD;
  glEndPerfMonitorAMD- : TglEndPerfMonitorAMD;
  glGetPerfMonitorCounterDataAMD- : TglGetPerfMonitorCounterDataAMD;

  (*  GL_AMD_vertex_shader_tesselator *)
  glTessellationFactorAMD- : TglTessellationFactorAMD;
  glTessellationModeAMD- : TglTessellationModeAMD;
  
  (*  GL_AMD_draw_buffers_blend *)
  glBlendFuncIndexedAMD- : TglBlendFuncIndexedAMD;
  glBlendFuncSeparateIndexedAMD- : TglBlendFuncSeparateIndexedAMD;
  glBlendEquationIndexedAMD- : TglBlendEquationIndexedAMD;
  glBlendEquationSeparateIndexedAMD- : TglBlendEquationSeparateIndexedAMD;

  (*  GL_AMD_name_gen_delete *)
  glGenNamesAMD- : TglGenNamesAMD;
  glDeleteNamesAMD- : TglDeleteNamesAMD;
  glIsNameAMD- : TglIsNameAMD;

  (*  GL_AMD_debug_output *)
  glDebugMessageEnableAMD- : TglDebugMessageEnableAMD;
  glDebugMessageInsertAMD- : TglDebugMessageInsertAMD;
  (*glDebugMessageCallbackAMD- : TglDebugMessageCallbackAMD;*)
  glGetDebugMessageLogAMD- : TglGetDebugMessageLogAMD;

  (*  GL_EXT_blend_color *)
  glBlendColorEXT- : TglBlendColorEXT;

  (*  GL_EXT_blend_func_separate *)
  glBlendFuncSeparateEXT- : TglBlendFuncSeparateEXT;

  (*  GL_EXT_blend_minmax *)
  glBlendEquationEXT- : TglBlendEquationEXT;

  (*  GL_EXT_color_subtable *)
  glColorSubTableEXT- : TglColorSubTableEXT;
  glCopyColorSubTableEXT- : TglCopyColorSubTableEXT;

  (*  GL_EXT_compiled_vertex_array *)
  glLockArraysEXT- : TglLockArraysEXT;
  glUnlockArraysEXT- : TglUnlockArraysEXT;

  (*  GL_EXT_convolution *)
  glConvolutionFilter1DEXT- : TglConvolutionFilter1DEXT;
  glConvolutionFilter2DEXT- : TglConvolutionFilter2DEXT;
  glConvolutionParameterfEXT- : TglConvolutionParameterfEXT;
  glConvolutionParameterfvEXT- : TglConvolutionParameterfvEXT;
  glConvolutionParameteriEXT- : TglConvolutionParameteriEXT;
  glConvolutionParameterivEXT- : TglConvolutionParameterivEXT;
  glCopyConvolutionFilter1DEXT- : TglCopyConvolutionFilter1DEXT;
  glCopyConvolutionFilter2DEXT- : TglCopyConvolutionFilter2DEXT;
  glGetConvolutionFilterEXT- : TglGetConvolutionFilterEXT;
  glGetConvolutionParameterfvEXT- : TglGetConvolutionParameterfvEXT;
  glGetConvolutionParameterivEXT- : TglGetConvolutionParameterivEXT;
  glGetSeparableFilterEXT- : TglGetSeparableFilterEXT;
  glSeparableFilter2DEXT- : TglSeparableFilter2DEXT;

  (*  GL_EXT_coordinate_frame *)
  glTangent3bEXT- : TglTangent3bEXT;
  glTangent3bvEXT- : TglTangent3bvEXT;
  glTangent3dEXT- : TglTangent3dEXT;
  glTangent3dvEXT- : TglTangent3dvEXT;
  glTangent3fEXT- : TglTangent3fEXT;
  glTangent3fvEXT- : TglTangent3fvEXT;
  glTangent3iEXT- : TglTangent3iEXT;
  glTangent3ivEXT- : TglTangent3ivEXT;
  glTangent3sEXT- : TglTangent3sEXT;
  glTangent3svEXT- : TglTangent3svEXT;
  glBinormal3bEXT- : TglBinormal3bEXT;
  glBinormal3bvEXT- : TglBinormal3bvEXT;
  glBinormal3dEXT- : TglBinormal3dEXT;
  glBinormal3dvEXT- : TglBinormal3dvEXT;
  glBinormal3fEXT- : TglBinormal3fEXT;
  glBinormal3fvEXT- : TglBinormal3fvEXT;
  glBinormal3iEXT- : TglBinormal3iEXT;
  glBinormal3ivEXT- : TglBinormal3ivEXT;
  glBinormal3sEXT- : TglBinormal3sEXT;
  glBinormal3svEXT- : TglBinormal3svEXT;
  glTangentPointerEXT- : TglTangentPointerEXT;
  glBinormalPointerEXT- : TglBinormalPointerEXT;

  (*  GL_EXT_copy_texture *)
  glCopyTexImage1DEXT- : TglCopyTexImage1DEXT;
  glCopyTexImage2DEXT- : TglCopyTexImage2DEXT;
  glCopyTexSubImage1DEXT- : TglCopyTexSubImage1DEXT;
  glCopyTexSubImage2DEXT- : TglCopyTexSubImage2DEXT;
  glCopyTexSubImage3DEXT- : TglCopyTexSubImage3DEXT;

  (*  GL_EXT_cull_vertex *)
  glCullParameterdvEXT- : TglCullParameterdvEXT;
  glCullParameterfvEXT- : TglCullParameterfvEXT;

  (*  GL_EXT_draw_range_elements *)
  glDrawRangeElementsEXT- : TglDrawRangeElementsEXT;

  (*  GL_EXT_fog_coord *)
  glFogCoordfEXT- : TglFogCoordfEXT;
  glFogCoordfvEXT- : TglFogCoordfvEXT;
  glFogCoorddEXT- : TglFogCoorddEXT;
  glFogCoorddvEXT- : TglFogCoorddvEXT;
  glFogCoordPointerEXT- : TglFogCoordPointerEXT;

  (*  GL_EXT_framebuffer_object *)
  glIsRenderbufferEXT- : TglIsRenderbufferEXT;
  glBindRenderbufferEXT- : TglBindRenderbufferEXT;
  glDeleteRenderbuffersEXT- : TglDeleteRenderbuffersEXT;
  glGenRenderbuffersEXT- : TglGenRenderbuffersEXT;
  glRenderbufferStorageEXT- : TglRenderbufferStorageEXT;
  glGetRenderbufferParameterivEXT- : TglGetRenderbufferParameterivEXT;
  glIsFramebufferEXT- : TglIsFramebufferEXT;
  glBindFramebufferEXT- : TglBindFramebufferEXT;
  glDeleteFramebuffersEXT- : TglDeleteFramebuffersEXT;
  glGenFramebuffersEXT- : TglGenFramebuffersEXT;
  glCheckFramebufferStatusEXT- : TglCheckFramebufferStatusEXT;
  glFramebufferTexture1DEXT- : TglFramebufferTexture1DEXT;
  glFramebufferTexture2DEXT- : TglFramebufferTexture2DEXT;
  glFramebufferTexture3DEXT- : TglFramebufferTexture3DEXT;
  glFramebufferRenderbufferEXT- : TglFramebufferRenderbufferEXT;
  glGetFramebufferAttachmentParameterivEXT- : TglGetFramebufferAttachmentParameterivEXT;
  glGenerateMipmapEXT- : TglGenerateMipmapEXT;

  (*  GL_EXT_histogram *)
  glGetHistogramEXT- : TglGetHistogramEXT;
  glGetHistogramParameterfvEXT- : TglGetHistogramParameterfvEXT;
  glGetHistogramParameterivEXT- : TglGetHistogramParameterivEXT;
  glGetMinmaxEXT- : TglGetMinmaxEXT;
  glGetMinmaxParameterfvEXT- : TglGetMinmaxParameterfvEXT;
  glGetMinmaxParameterivEXT- : TglGetMinmaxParameterivEXT;
  glHistogramEXT- : TglHistogramEXT;
  glMinmaxEXT- : TglMinmaxEXT;
  glResetHistogramEXT- : TglResetHistogramEXT;
  glResetMinmaxEXT- : TglResetMinmaxEXT;

  (*  GL_EXT_index_func *)
  glIndexFuncEXT- : TglIndexFuncEXT;

  (*  GL_EXT_index_material *)
  glIndexMaterialEXT- : TglIndexMaterialEXT;

  (*  GL_EXT_light_texture *)
  glApplyTextureEXT- : TglApplyTextureEXT;
  glTextureLightEXT- : TglTextureLightEXT;
  glTextureMaterialEXT- : TglTextureMaterialEXT;

  (*  GL_EXT_multi_draw_arrays *)
  glMultiDrawArraysEXT- : TglMultiDrawArraysEXT;
  glMultiDrawElementsEXT- : TglMultiDrawElementsEXT;

  (*  GL_EXT_multisample *)
  glSampleMaskEXT- : TglSampleMaskEXT;
  glSamplePatternEXT- : TglSamplePatternEXT;

  (*  GL_EXT_paletted_texture *)
  glColorTableEXT- : TglColorTableEXT;
  glGetColorTableEXT- : TglGetColorTableEXT;
  glGetColorTableParameterivEXT- : TglGetColorTableParameterivEXT;
  glGetColorTableParameterfvEXT- : TglGetColorTableParameterfvEXT;

  (*  GL_EXT_pixel_transform *)
  glPixelTransformParameteriEXT- : TglPixelTransformParameteriEXT;
  glPixelTransformParameterfEXT- : TglPixelTransformParameterfEXT;
  glPixelTransformParameterivEXT- : TglPixelTransformParameterivEXT;
  glPixelTransformParameterfvEXT- : TglPixelTransformParameterfvEXT;

  (*  GL_EXT_point_parameters *)
  glPointParameterfEXT- : TglPointParameterfEXT;
  glPointParameterfvEXT- : TglPointParameterfvEXT;

  (*  GL_EXT_polygon_offset *)
  glPolygonOffsetEXT- : TglPolygonOffsetEXT;

  (*  GL_EXT_secondary_color *)
  glSecondaryColor3bEXT- : TglSecondaryColor3bEXT;
  glSecondaryColor3bvEXT- : TglSecondaryColor3bvEXT;
  glSecondaryColor3dEXT- : TglSecondaryColor3dEXT;
  glSecondaryColor3dvEXT- : TglSecondaryColor3dvEXT;
  glSecondaryColor3fEXT- : TglSecondaryColor3fEXT;
  glSecondaryColor3fvEXT- : TglSecondaryColor3fvEXT;
  glSecondaryColor3iEXT- : TglSecondaryColor3iEXT;
  glSecondaryColor3ivEXT- : TglSecondaryColor3ivEXT;
  glSecondaryColor3sEXT- : TglSecondaryColor3sEXT;
  glSecondaryColor3svEXT- : TglSecondaryColor3svEXT;
  glSecondaryColor3ubEXT- : TglSecondaryColor3ubEXT;
  glSecondaryColor3ubvEXT- : TglSecondaryColor3ubvEXT;
  glSecondaryColor3uiEXT- : TglSecondaryColor3uiEXT;
  glSecondaryColor3uivEXT- : TglSecondaryColor3uivEXT;
  glSecondaryColor3usEXT- : TglSecondaryColor3usEXT;
  glSecondaryColor3usvEXT- : TglSecondaryColor3usvEXT;
  glSecondaryColorPointerEXT- : TglSecondaryColorPointerEXT;

  (*  GL_EXT_stencil_two_side *)
  glActiveStencilFaceEXT- : TglActiveStencilFaceEXT;

  (*  GL_EXT_subtexture *)
  glTexSubImage1DEXT- : TglTexSubImage1DEXT;
  glTexSubImage2DEXT- : TglTexSubImage2DEXT;

  (*  GL_EXT_texture3D *)
  glTexImage3DEXT- : TglTexImage3DEXT;
  glTexSubImage3DEXT- : TglTexSubImage3DEXT;

  (*  GL_EXT_texture_object *)
  glAreTexturesResidentEXT- : TglAreTexturesResidentEXT;
  glBindTextureEXT- : TglBindTextureEXT;
  glDeleteTexturesEXT- : TglDeleteTexturesEXT;
  glGenTexturesEXT- : TglGenTexturesEXT;
  glIsTextureEXT- : TglIsTextureEXT;
  glPrioritizeTexturesEXT- : TglPrioritizeTexturesEXT;

  (*  GL_EXT_texture_perturb_normal *)
  glTextureNormalEXT- : TglTextureNormalEXT;

  (*  GL_EXT_vertex_array *)
  glArrayElementEXT- : TglArrayElementEXT;
  glColorPointerEXT- : TglColorPointerEXT;
  glDrawArraysEXT- : TglDrawArraysEXT;
  glEdgeFlagPointerEXT- : TglEdgeFlagPointerEXT;
  glGetPointervEXT- : TglGetPointervEXT;
  glIndexPointerEXT- : TglIndexPointerEXT;
  glNormalPointerEXT- : TglNormalPointerEXT;
  glTexCoordPointerEXT- : TglTexCoordPointerEXT;
  glVertexPointerEXT- : TglVertexPointerEXT;

  (*  GL_EXT_vertex_shader *)
  glBeginVertexShaderEXT- : TglBeginVertexShaderEXT;
  glEndVertexShaderEXT- : TglEndVertexShaderEXT;
  glBindVertexShaderEXT- : TglBindVertexShaderEXT;
  glGenVertexShadersEXT- : TglGenVertexShadersEXT;
  glDeleteVertexShaderEXT- : TglDeleteVertexShaderEXT;
  glShaderOp1EXT- : TglShaderOp1EXT;
  glShaderOp2EXT- : TglShaderOp2EXT;
  glShaderOp3EXT- : TglShaderOp3EXT;
  glSwizzleEXT- : TglSwizzleEXT;
  glWriteMaskEXT- : TglWriteMaskEXT;
  glInsertComponentEXT- : TglInsertComponentEXT;
  glExtractComponentEXT- : TglExtractComponentEXT;
  glGenSymbolsEXT- : TglGenSymbolsEXT;
  glSetInvariantEXT- : TglSetInvariantEXT;
  glSetLocalConstantEXT- : TglSetLocalConstantEXT;
  glVariantbvEXT- : TglVariantbvEXT;
  glVariantsvEXT- : TglVariantsvEXT;
  glVariantivEXT- : TglVariantivEXT;
  glVariantfvEXT- : TglVariantfvEXT;
  glVariantdvEXT- : TglVariantdvEXT;
  glVariantubvEXT- : TglVariantubvEXT;
  glVariantusvEXT- : TglVariantusvEXT;
  glVariantuivEXT- : TglVariantuivEXT;
  glVariantPointerEXT- : TglVariantPointerEXT;
  glEnableVariantClientStateEXT- : TglEnableVariantClientStateEXT;
  glDisableVariantClientStateEXT- : TglDisableVariantClientStateEXT;
  glBindLightParameterEXT- : TglBindLightParameterEXT;
  glBindMaterialParameterEXT- : TglBindMaterialParameterEXT;
  glBindTexGenParameterEXT- : TglBindTexGenParameterEXT;
  glBindTextureUnitParameterEXT- : TglBindTextureUnitParameterEXT;
  glBindParameterEXT- : TglBindParameterEXT;
  glIsVariantEnabledEXT- : TglIsVariantEnabledEXT;
  glGetVariantBooleanvEXT- : TglGetVariantBooleanvEXT;
  glGetVariantIntegervEXT- : TglGetVariantIntegervEXT;
  glGetVariantFloatvEXT- : TglGetVariantFloatvEXT;
  glGetVariantPointervEXT- : TglGetVariantPointervEXT;
  glGetInvariantBooleanvEXT- : TglGetInvariantBooleanvEXT;
  glGetInvariantIntegervEXT- : TglGetInvariantIntegervEXT;
  glGetInvariantFloatvEXT- : TglGetInvariantFloatvEXT;
  glGetLocalConstantBooleanvEXT- : TglGetLocalConstantBooleanvEXT;
  glGetLocalConstantIntegervEXT- : TglGetLocalConstantIntegervEXT;
  glGetLocalConstantFloatvEXT- : TglGetLocalConstantFloatvEXT;

  (*  GL_EXT_vertex_weighting *)
  glVertexWeightfEXT- : TglVertexWeightfEXT;
  glVertexWeightfvEXT- : TglVertexWeightfvEXT;
  glVertexWeightPointerEXT- : TglVertexWeightPointerEXT;

  (*  GL_EXT_stencil_clear_tag *)
  glStencilClearTagEXT- : TglStencilClearTagEXT;

  (*  GL_EXT_framebuffer_blit *)
  glBlitFramebufferEXT- : TglBlitFramebufferEXT;

  (*  GL_EXT_framebuffer_multisample *)
  glRenderbufferStorageMultisampleEXT- : TglRenderbufferStorageMultisampleEXT;

  (*  GL_EXT_timer_query *)
  glGetQueryObjecti64vEXT- : TglGetQueryObjecti64vEXT;
  glGetQueryObjectui64vEXT- : TglGetQueryObjectui64vEXT;

  (*  GL_EXT_gpu_program_parameters *)
  glProgramEnvParameters4fvEXT- : TglProgramEnvParameters4fvEXT;
  glProgramLocalParameters4fvEXT- : TglProgramLocalParameters4fvEXT;

  (*  GL_EXT_bindable_uniform *)
  glUniformBufferEXT- : TglUniformBufferEXT;
  glGetUniformBufferSizeEXT- : TglGetUniformBufferSizeEXT;
  glGetUniformOffsetEXT- : TglGetUniformOffsetEXT;

  (*  GL_EXT_draw_buffers2 *)
  glColorMaskIndexedEXT- : TglColorMaskIndexedEXT;
  glGetBooleanIndexedvEXT- : TglGetBooleanIndexedvEXT;
  glGetIntegerIndexedvEXT- : TglGetIntegerIndexedvEXT;
  glEnableIndexedEXT- : TglEnableIndexedEXT;
  glDisableIndexedEXT- : TglDisableIndexedEXT;
  glIsEnabledIndexedEXT- : TglIsEnabledIndexedEXT;

  (*  GL_EXT_draw_instanced *)
  glDrawArraysInstancedEXT- : TglDrawArraysInstancedEXT;
  glDrawElementsInstancedEXT- : TglDrawElementsInstancedEXT;

  (*  GL_EXT_geometry_shader4 *)
  glProgramParameteriEXT- : TglProgramParameteriEXT;
  glFramebufferTextureEXT- : TglFramebufferTextureEXT;
(*   glFramebufferTextureLayerEXT- : TglFramebufferTextureLayerEXT; *)
  glFramebufferTextureFaceEXT- : TglFramebufferTextureFaceEXT;

  (*  GL_EXT_gpu_shader4 *)
  glVertexAttribI1iEXT- : TglVertexAttribI1iEXT;
  glVertexAttribI2iEXT- : TglVertexAttribI2iEXT;
  glVertexAttribI3iEXT- : TglVertexAttribI3iEXT;
  glVertexAttribI4iEXT- : TglVertexAttribI4iEXT;
  glVertexAttribI1uiEXT- : TglVertexAttribI1uiEXT;
  glVertexAttribI2uiEXT- : TglVertexAttribI2uiEXT;
  glVertexAttribI3uiEXT- : TglVertexAttribI3uiEXT;
  glVertexAttribI4uiEXT- : TglVertexAttribI4uiEXT;
  glVertexAttribI1ivEXT- : TglVertexAttribI1ivEXT;
  glVertexAttribI2ivEXT- : TglVertexAttribI2ivEXT;
  glVertexAttribI3ivEXT- : TglVertexAttribI3ivEXT;
  glVertexAttribI4ivEXT- : TglVertexAttribI4ivEXT;
  glVertexAttribI1uivEXT- : TglVertexAttribI1uivEXT;
  glVertexAttribI2uivEXT- : TglVertexAttribI2uivEXT;
  glVertexAttribI3uivEXT- : TglVertexAttribI3uivEXT;
  glVertexAttribI4uivEXT- : TglVertexAttribI4uivEXT;
  glVertexAttribI4bvEXT- : TglVertexAttribI4bvEXT;
  glVertexAttribI4svEXT- : TglVertexAttribI4svEXT;
  glVertexAttribI4ubvEXT- : TglVertexAttribI4ubvEXT;
  glVertexAttribI4usvEXT- : TglVertexAttribI4usvEXT;
  glVertexAttribIPointerEXT- : TglVertexAttribIPointerEXT;
  glGetVertexAttribIivEXT- : TglGetVertexAttribIivEXT;
  glGetVertexAttribIuivEXT- : TglGetVertexAttribIuivEXT;
  glUniform1uiEXT- : TglUniform1uiEXT;
  glUniform2uiEXT- : TglUniform2uiEXT;
  glUniform3uiEXT- : TglUniform3uiEXT;
  glUniform4uiEXT- : TglUniform4uiEXT;
  glUniform1uivEXT- : TglUniform1uivEXT;
  glUniform2uivEXT- : TglUniform2uivEXT;
  glUniform3uivEXT- : TglUniform3uivEXT;
  glUniform4uivEXT- : TglUniform4uivEXT;
  glGetUniformuivEXT- : TglGetUniformuivEXT;
  glBindFragDataLocationEXT- : TglBindFragDataLocationEXT;
  glGetFragDataLocationEXT- : TglGetFragDataLocationEXT;

  (*  GL_EXT_texture_array *)
  glFramebufferTextureLayerEXT- : TglFramebufferTextureLayerEXT;

  (*  GL_EXT_texture_buffer_object *)
  glTexBufferEXT- : TglTexBufferEXT;

  (*  GL_EXT_texture_integer *)
  glClearColorIiEXT- : TglClearColorIiEXT;
  glClearColorIuiEXT- : TglClearColorIuiEXT;
  glTexParameterIivEXT- : TglTexParameterIivEXT;
  glTexParameterIuivEXT- : TglTexParameterIuivEXT;
  glGetTexParameterIivEXT- : TglGetTexParameterIivEXT;
  glGetTexParameterIiuvEXT- : TglGetTexParameterIiuvEXT;

  (*  GL_EXT_transform_feedback *)
  glBeginTransformFeedbackEXT- : TglBeginTransformFeedbackEXT;
  glEndTransformFeedbackEXT- : TglEndTransformFeedbackEXT;
  glBindBufferRangeEXT- : TglBindBufferRangeEXT;
  glBindBufferOffsetEXT- : TglBindBufferOffsetEXT;
  glBindBufferBaseEXT- : TglBindBufferBaseEXT;
  glTransformFeedbackVaryingsEXT- : TglTransformFeedbackVaryingsEXT;
  glGetTransformFeedbackVaryingEXT- : TglGetTransformFeedbackVaryingEXT;

  (*  GL_EXT_direct_state_access *)
  glClientAttribDefaultEXT- : TglClientAttribDefaultEXT;
  glPushClientAttribDefaultEXT- : TglPushClientAttribDefaultEXT;
  glMatrixLoadfEXT- : TglMatrixLoadfEXT;
  glMatrixLoaddEXT- : TglMatrixLoaddEXT;
  glMatrixMultfEXT- : TglMatrixMultfEXT;
  glMatrixMultdEXT- : TglMatrixMultdEXT;
  glMatrixLoadIdentityEXT- : TglMatrixLoadIdentityEXT;
  glMatrixRotatefEXT- : TglMatrixRotatefEXT;
  glMatrixRotatedEXT- : TglMatrixRotatedEXT;
  glMatrixScalefEXT- : TglMatrixScalefEXT;
  glMatrixScaledEXT- : TglMatrixScaledEXT;
  glMatrixTranslatefEXT- : TglMatrixTranslatefEXT;
  glMatrixTranslatedEXT- : TglMatrixTranslatedEXT;
  glMatrixFrustumEXT- : TglMatrixFrustumEXT;
  glMatrixOrthoEXT- : TglMatrixOrthoEXT;
  glMatrixPopEXT- : TglMatrixPopEXT;
  glMatrixPushEXT- : TglMatrixPushEXT;
  glMatrixLoadTransposefEXT- : TglMatrixLoadTransposefEXT;
  glMatrixLoadTransposedEXT- : TglMatrixLoadTransposedEXT;
  glMatrixMultTransposefEXT- : TglMatrixMultTransposefEXT;
  glMatrixMultTransposedEXT- : TglMatrixMultTransposedEXT;
  glTextureParameterfEXT- : TglTextureParameterfEXT;
  glTextureParameterfvEXT- : TglTextureParameterfvEXT;
  glTextureParameteriEXT- : TglTextureParameteriEXT;
  glTextureParameterivEXT- : TglTextureParameterivEXT;
  glTextureImage1DEXT- : TglTextureImage1DEXT;
  glTextureImage2DEXT- : TglTextureImage2DEXT;
  glTextureSubImage1DEXT- : TglTextureSubImage1DEXT;
  glTextureSubImage2DEXT- : TglTextureSubImage2DEXT;
  glCopyTextureImage1DEXT- : TglCopyTextureImage1DEXT;
  glCopyTextureImage2DEXT- : TglCopyTextureImage2DEXT;
  glCopyTextureSubImage1DEXT- : TglCopyTextureSubImage1DEXT;
  glCopyTextureSubImage2DEXT- : TglCopyTextureSubImage2DEXT;
  glGetTextureImageEXT- : TglGetTextureImageEXT;
  glGetTextureParameterfvEXT- : TglGetTextureParameterfvEXT;
  glGetTextureParameterivEXT- : TglGetTextureParameterivEXT;
  glGetTextureLevelParameterfvEXT- : TglGetTextureLevelParameterfvEXT;
  glGetTextureLevelParameterivEXT- : TglGetTextureLevelParameterivEXT;
  glTextureImage3DEXT- : TglTextureImage3DEXT;
  glTextureSubImage3DEXT- : TglTextureSubImage3DEXT;
  glCopyTextureSubImage3DEXT- : TglCopyTextureSubImage3DEXT;
  glMultiTexParameterfEXT- : TglMultiTexParameterfEXT;
  glMultiTexParameterfvEXT- : TglMultiTexParameterfvEXT;
  glMultiTexParameteriEXT- : TglMultiTexParameteriEXT;
  glMultiTexParameterivEXT- : TglMultiTexParameterivEXT;
  glMultiTexImage1DEXT- : TglMultiTexImage1DEXT;
  glMultiTexImage2DEXT- : TglMultiTexImage2DEXT;
  glMultiTexSubImage1DEXT- : TglMultiTexSubImage1DEXT;
  glMultiTexSubImage2DEXT- : TglMultiTexSubImage2DEXT;
  glCopyMultiTexImage1DEXT- : TglCopyMultiTexImage1DEXT;
  glCopyMultiTexImage2DEXT- : TglCopyMultiTexImage2DEXT;
  glCopyMultiTexSubImage1DEXT- : TglCopyMultiTexSubImage1DEXT;
  glCopyMultiTexSubImage2DEXT- : TglCopyMultiTexSubImage2DEXT;
  glGetMultiTexImageEXT- : TglGetMultiTexImageEXT;
  glGetMultiTexParameterfvEXT- : TglGetMultiTexParameterfvEXT;
  glGetMultiTexParameterivEXT- : TglGetMultiTexParameterivEXT;
  glGetMultiTexLevelParameterfvEXT- : TglGetMultiTexLevelParameterfvEXT;
  glGetMultiTexLevelParameterivEXT- : TglGetMultiTexLevelParameterivEXT;
  glMultiTexImage3DEXT- : TglMultiTexImage3DEXT;
  glMultiTexSubImage3DEXT- : TglMultiTexSubImage3DEXT;
  glCopyMultiTexSubImage3DEXT- : TglCopyMultiTexSubImage3DEXT;
  glBindMultiTextureEXT- : TglBindMultiTextureEXT;
  glEnableClientStateIndexedEXT- : TglEnableClientStateIndexedEXT;
  glDisableClientStateIndexedEXT- : TglDisableClientStateIndexedEXT;
  glMultiTexCoordPointerEXT- : TglMultiTexCoordPointerEXT;
  glMultiTexEnvfEXT- : TglMultiTexEnvfEXT;
  glMultiTexEnvfvEXT- : TglMultiTexEnvfvEXT;
  glMultiTexEnviEXT- : TglMultiTexEnviEXT;
  glMultiTexEnvivEXT- : TglMultiTexEnvivEXT;
  glMultiTexGendEXT- : TglMultiTexGendEXT;
  glMultiTexGendvEXT- : TglMultiTexGendvEXT;
  glMultiTexGenfEXT- : TglMultiTexGenfEXT;
  glMultiTexGenfvEXT- : TglMultiTexGenfvEXT;
  glMultiTexGeniEXT- : TglMultiTexGeniEXT;
  glMultiTexGenivEXT- : TglMultiTexGenivEXT;
  glGetMultiTexEnvfvEXT- : TglGetMultiTexEnvfvEXT;
  glGetMultiTexEnvivEXT- : TglGetMultiTexEnvivEXT;
  glGetMultiTexGendvEXT- : TglGetMultiTexGendvEXT;
  glGetMultiTexGenfvEXT- : TglGetMultiTexGenfvEXT;
  glGetMultiTexGenivEXT- : TglGetMultiTexGenivEXT;
  glGetFloatIndexedvEXT- : TglGetFloatIndexedvEXT;
  glGetDoubleIndexedvEXT- : TglGetDoubleIndexedvEXT;
  glGetPointerIndexedvEXT- : TglGetPointerIndexedvEXT;
  glCompressedTextureImage3DEXT- : TglCompressedTextureImage3DEXT;
  glCompressedTextureImage2DEXT- : TglCompressedTextureImage2DEXT;
  glCompressedTextureImage1DEXT- : TglCompressedTextureImage1DEXT;
  glCompressedTextureSubImage3DEXT- : TglCompressedTextureSubImage3DEXT;
  glCompressedTextureSubImage2DEXT- : TglCompressedTextureSubImage2DEXT;
  glCompressedTextureSubImage1DEXT- : TglCompressedTextureSubImage1DEXT;
  glGetCompressedTextureImageEXT- : TglGetCompressedTextureImageEXT;
  glCompressedMultiTexImage3DEXT- : TglCompressedMultiTexImage3DEXT;
  glCompressedMultiTexImage2DEXT- : TglCompressedMultiTexImage2DEXT;
  glCompressedMultiTexImage1DEXT- : TglCompressedMultiTexImage1DEXT;
  glCompressedMultiTexSubImage3DEXT- : TglCompressedMultiTexSubImage3DEXT;
  glCompressedMultiTexSubImage2DEXT- : TglCompressedMultiTexSubImage2DEXT;
  glCompressedMultiTexSubImage1DEXT- : TglCompressedMultiTexSubImage1DEXT;
  glGetCompressedMultiTexImageEXT- : TglGetCompressedMultiTexImageEXT;
  glNamedProgramStringEXT- : TglNamedProgramStringEXT;
  glNamedProgramLocalParameter4dEXT- : TglNamedProgramLocalParameter4dEXT;
  glNamedProgramLocalParameter4dvEXT- : TglNamedProgramLocalParameter4dvEXT;
  glNamedProgramLocalParameter4fEXT- : TglNamedProgramLocalParameter4fEXT;
  glNamedProgramLocalParameter4fvEXT- : TglNamedProgramLocalParameter4fvEXT;
  glGetNamedProgramLocalParameterdvEXT- : TglGetNamedProgramLocalParameterdvEXT;
  glGetNamedProgramLocalParameterfvEXT- : TglGetNamedProgramLocalParameterfvEXT;
  glGetNamedProgramivEXT- : TglGetNamedProgramivEXT;
  glGetNamedProgramStringEXT- : TglGetNamedProgramStringEXT;
  glNamedProgramLocalParameters4fvEXT- : TglNamedProgramLocalParameters4fvEXT;
  glNamedProgramLocalParameterI4iEXT- : TglNamedProgramLocalParameterI4iEXT;
  glNamedProgramLocalParameterI4ivEXT- : TglNamedProgramLocalParameterI4ivEXT;
  glNamedProgramLocalParametersI4ivEXT- : TglNamedProgramLocalParametersI4ivEXT;
  glNamedProgramLocalParameterI4uiEXT- : TglNamedProgramLocalParameterI4uiEXT;
  glNamedProgramLocalParameterI4uivEXT- : TglNamedProgramLocalParameterI4uivEXT;
  glNamedProgramLocalParametersI4uivEXT- : TglNamedProgramLocalParametersI4uivEXT;
  glGetNamedProgramLocalParameterIivEXT- : TglGetNamedProgramLocalParameterIivEXT;
  glGetNamedProgramLocalParameterIuivEXT- : TglGetNamedProgramLocalParameterIuivEXT;
  glTextureParameterIivEXT- : TglTextureParameterIivEXT;
  glTextureParameterIuivEXT- : TglTextureParameterIuivEXT;
  glGetTextureParameterIivEXT- : TglGetTextureParameterIivEXT;
  glGetTextureParameterIuivEXT- : TglGetTextureParameterIuivEXT;
  glMultiTexParameterIivEXT- : TglMultiTexParameterIivEXT;
  glMultiTexParameterIuivEXT- : TglMultiTexParameterIuivEXT;
  glGetMultiTexParameterIivEXT- : TglGetMultiTexParameterIivEXT;
  glGetMultiTexParameterIuivEXT- : TglGetMultiTexParameterIuivEXT;
  glProgramUniform1fEXT- : TglProgramUniform1fEXT;
  glProgramUniform2fEXT- : TglProgramUniform2fEXT;
  glProgramUniform3fEXT- : TglProgramUniform3fEXT;
  glProgramUniform4fEXT- : TglProgramUniform4fEXT;
  glProgramUniform1iEXT- : TglProgramUniform1iEXT;
  glProgramUniform2iEXT- : TglProgramUniform2iEXT;
  glProgramUniform3iEXT- : TglProgramUniform3iEXT;
  glProgramUniform4iEXT- : TglProgramUniform4iEXT;
  glProgramUniform1fvEXT- : TglProgramUniform1fvEXT;
  glProgramUniform2fvEXT- : TglProgramUniform2fvEXT;
  glProgramUniform3fvEXT- : TglProgramUniform3fvEXT;
  glProgramUniform4fvEXT- : TglProgramUniform4fvEXT;
  glProgramUniform1ivEXT- : TglProgramUniform1ivEXT;
  glProgramUniform2ivEXT- : TglProgramUniform2ivEXT;
  glProgramUniform3ivEXT- : TglProgramUniform3ivEXT;
  glProgramUniform4ivEXT- : TglProgramUniform4ivEXT;
  glProgramUniformMatrix2fvEXT- : TglProgramUniformMatrix2fvEXT;
  glProgramUniformMatrix3fvEXT- : TglProgramUniformMatrix3fvEXT;
  glProgramUniformMatrix4fvEXT- : TglProgramUniformMatrix4fvEXT;
  glProgramUniformMatrix2x3fvEXT- : TglProgramUniformMatrix2x3fvEXT;
  glProgramUniformMatrix3x2fvEXT- : TglProgramUniformMatrix3x2fvEXT;
  glProgramUniformMatrix2x4fvEXT- : TglProgramUniformMatrix2x4fvEXT;
  glProgramUniformMatrix4x2fvEXT- : TglProgramUniformMatrix4x2fvEXT;
  glProgramUniformMatrix3x4fvEXT- : TglProgramUniformMatrix3x4fvEXT;
  glProgramUniformMatrix4x3fvEXT- : TglProgramUniformMatrix4x3fvEXT;
  glProgramUniform1uiEXT- : TglProgramUniform1uiEXT;
  glProgramUniform2uiEXT- : TglProgramUniform2uiEXT;
  glProgramUniform3uiEXT- : TglProgramUniform3uiEXT;
  glProgramUniform4uiEXT- : TglProgramUniform4uiEXT;
  glProgramUniform1uivEXT- : TglProgramUniform1uivEXT;
  glProgramUniform2uivEXT- : TglProgramUniform2uivEXT;
  glProgramUniform3uivEXT- : TglProgramUniform3uivEXT;
  glProgramUniform4uivEXT- : TglProgramUniform4uivEXT;
  glNamedBufferDataEXT- : TglNamedBufferDataEXT;
  glNamedBufferSubDataEXT- : TglNamedBufferSubDataEXT;
  glMapNamedBufferEXT- : TglMapNamedBufferEXT;
  glUnmapNamedBufferEXT- : TglUnmapNamedBufferEXT;
  glMapNamedBufferRangeEXT- : TglMapNamedBufferRangeEXT;
  glFlushMappedNamedBufferRangeEXT- : TglFlushMappedNamedBufferRangeEXT;
  glNamedCopyBufferSubDataEXT- : TglNamedCopyBufferSubDataEXT;
  glGetNamedBufferParameterivEXT- : TglGetNamedBufferParameterivEXT;
  glGetNamedBufferPointervEXT- : TglGetNamedBufferPointervEXT;
  glGetNamedBufferSubDataEXT- : TglGetNamedBufferSubDataEXT;
  glTextureBufferEXT- : TglTextureBufferEXT;
  glMultiTexBufferEXT- : TglMultiTexBufferEXT;
  glNamedRenderbufferStorageEXT- : TglNamedRenderbufferStorageEXT;
  glGetNamedRenderbufferParameterivEXT- : TglGetNamedRenderbufferParameterivEXT;
  glCheckNamedFramebufferStatusEXT- : TglCheckNamedFramebufferStatusEXT;
  glNamedFramebufferTexture1DEXT- : TglNamedFramebufferTexture1DEXT;
  glNamedFramebufferTexture2DEXT- : TglNamedFramebufferTexture2DEXT;
  glNamedFramebufferTexture3DEXT- : TglNamedFramebufferTexture3DEXT;
  glNamedFramebufferRenderbufferEXT- : TglNamedFramebufferRenderbufferEXT;
  glGetNamedFramebufferAttachmentParameterivEXT- : TglGetNamedFramebufferAttachmentParameterivEXT;
  glGenerateTextureMipmapEXT- : TglGenerateTextureMipmapEXT;
  glGenerateMultiTexMipmapEXT- : TglGenerateMultiTexMipmapEXT;
  glFramebufferDrawBufferEXT- : TglFramebufferDrawBufferEXT;
  glFramebufferDrawBuffersEXT- : TglFramebufferDrawBuffersEXT;
  glFramebufferReadBufferEXT- : TglFramebufferReadBufferEXT;
  glGetFramebufferParameterivEXT- : TglGetFramebufferParameterivEXT;
  glNamedRenderbufferStorageMultisampleEXT- : TglNamedRenderbufferStorageMultisampleEXT;
  glNamedRenderbufferStorageMultisampleCoverageEXT- : TglNamedRenderbufferStorageMultisampleCoverageEXT;
  glNamedFramebufferTextureEXT- : TglNamedFramebufferTextureEXT;
  glNamedFramebufferTextureLayerEXT- : TglNamedFramebufferTextureLayerEXT;
  glNamedFramebufferTextureFaceEXT- : TglNamedFramebufferTextureFaceEXT;
  glTextureRenderbufferEXT- : TglTextureRenderbufferEXT;
  glMultiTexRenderbufferEXT- : TglMultiTexRenderbufferEXT;
  glProgramUniform1dEXT- : TglProgramUniform1dEXT;
  glProgramUniform2dEXT- : TglProgramUniform2dEXT;
  glProgramUniform3dEXT- : TglProgramUniform3dEXT;
  glProgramUniform4dEXT- : TglProgramUniform4dEXT;
  glProgramUniform1dvEXT- : TglProgramUniform1dvEXT;
  glProgramUniform2dvEXT- : TglProgramUniform2dvEXT;
  glProgramUniform3dvEXT- : TglProgramUniform3dvEXT;
  glProgramUniform4dvEXT- : TglProgramUniform4dvEXT;
  glProgramUniformMatrix2dvEXT- : TglProgramUniformMatrix2dvEXT;
  glProgramUniformMatrix3dvEXT- : TglProgramUniformMatrix3dvEXT;
  glProgramUniformMatrix4dvEXT- : TglProgramUniformMatrix4dvEXT;
  glProgramUniformMatrix2x3dvEXT- : TglProgramUniformMatrix2x3dvEXT;
  glProgramUniformMatrix2x4dvEXT- : TglProgramUniformMatrix2x4dvEXT;
  glProgramUniformMatrix3x2dvEXT- : TglProgramUniformMatrix3x2dvEXT;
  glProgramUniformMatrix3x4dvEXT- : TglProgramUniformMatrix3x4dvEXT;
  glProgramUniformMatrix4x2dvEXT- : TglProgramUniformMatrix4x2dvEXT;
  glProgramUniformMatrix4x3dvEXT- : TglProgramUniformMatrix4x3dvEXT;

  (*  GL_EXT_separate_shader_objects *)
  glUseShaderProgramEXT- : TglUseShaderProgramEXT;
  glActiveProgramEXT- : TglActiveProgramEXT;
  glCreateShaderProgramEXT- : TglCreateShaderProgramEXT;

  (*  GL_EXT_shader_image_load_store *)
  glBindImageTextureEXT- : TglBindImageTextureEXT;
  glMemoryBarrierEXT- : TglMemoryBarrierEXT;

  (*  GL_EXT_vertex_attrib_64bit *)
  glVertexAttribL1dEXT- : TglVertexAttribL1dEXT;
  glVertexAttribL2dEXT- : TglVertexAttribL2dEXT;
  glVertexAttribL3dEXT- : TglVertexAttribL3dEXT;
  glVertexAttribL4dEXT- : TglVertexAttribL4dEXT;
  glVertexAttribL1dvEXT- : TglVertexAttribL1dvEXT;
  glVertexAttribL2dvEXT- : TglVertexAttribL2dvEXT;
  glVertexAttribL3dvEXT- : TglVertexAttribL3dvEXT;
  glVertexAttribL4dvEXT- : TglVertexAttribL4dvEXT;
  glVertexAttribLPointerEXT- : TglVertexAttribLPointerEXT;
  glGetVertexAttribLdvEXT- : TglGetVertexAttribLdvEXT;
  glVertexArrayVertexAttribLOffsetEXT- : TglVertexArrayVertexAttribLOffsetEXT;
  
  (*  GL_HP_image_transform *)
  glImageTransformParameteriHP- : TglImageTransformParameteriHP;
  glImageTransformParameterfHP- : TglImageTransformParameterfHP;
  glImageTransformParameterivHP- : TglImageTransformParameterivHP;
  glImageTransformParameterfvHP- : TglImageTransformParameterfvHP;
  glGetImageTransformParameterivHP- : TglGetImageTransformParameterivHP;
  glGetImageTransformParameterfvHP- : TglGetImageTransformParameterfvHP;

  (*  GL_EXT_depth_bounds_test *)
  glDepthBoundsEXT- : TglDepthBoundsEXT;

  (*  GL_EXT_blend_equation_separate *)
  glBlendEquationSeparateEXT- : TglBlendEquationSeparateEXT;

(*
  (*  GL_IBM_multimode_draw_arrays *)
  glMultiModeDrawArraysIBM- : TglMultiModeDrawArraysIBM;
  glMultiModeDrawElementsIBM- : TglMultiModeDrawElementsIBM;

  (*  GL_IBM_vertex_array_lists *)
  glColorPointerListIBM- : TglColorPointerListIBM;
  glSecondaryColorPointerListIBM- : TglSecondaryColorPointerListIBM;
  glEdgeFlagPointerListIBM- : TglEdgeFlagPointerListIBM;
  glFogCoordPointerListIBM- : TglFogCoordPointerListIBM;
  glIndexPointerListIBM- : TglIndexPointerListIBM;
  glNormalPointerListIBM- : TglNormalPointerListIBM;
  glTexCoordPointerListIBM- : TglTexCoordPointerListIBM;
  glVertexPointerListIBM- : TglVertexPointerListIBM;

  (*  GL_INGR_blend_func_separate *)
  glBlendFuncSeparateINGR- : TglBlendFuncSeparateINGR;

  (*  GL_INTEL_parallel_arrays *)
  glVertexPointervINTEL- : TglVertexPointervINTEL;
  glNormalPointervINTEL- : TglNormalPointervINTEL;
  glColorPointervINTEL- : TglColorPointervINTEL;
  glTexCoordPointervINTEL- : TglTexCoordPointervINTEL;
*)
  (*  GL_MESA_resize_buffers *)
  glResizeBuffersMESA- : TglResizeBuffersMESA;

  (*  GL_MESA_window_pos *)
  glWindowPos2dMESA- : TglWindowPos2dMESA;
  glWindowPos2dvMESA- : TglWindowPos2dvMESA;
  glWindowPos2fMESA- : TglWindowPos2fMESA;
  glWindowPos2fvMESA- : TglWindowPos2fvMESA;
  glWindowPos2iMESA- : TglWindowPos2iMESA;
  glWindowPos2ivMESA- : TglWindowPos2ivMESA;
  glWindowPos2sMESA- : TglWindowPos2sMESA;
  glWindowPos2svMESA- : TglWindowPos2svMESA;
  glWindowPos3dMESA- : TglWindowPos3dMESA;
  glWindowPos3dvMESA- : TglWindowPos3dvMESA;
  glWindowPos3fMESA- : TglWindowPos3fMESA;
  glWindowPos3fvMESA- : TglWindowPos3fvMESA;
  glWindowPos3iMESA- : TglWindowPos3iMESA;
  glWindowPos3ivMESA- : TglWindowPos3ivMESA;
  glWindowPos3sMESA- : TglWindowPos3sMESA;
  glWindowPos3svMESA- : TglWindowPos3svMESA;
  glWindowPos4dMESA- : TglWindowPos4dMESA;
  glWindowPos4dvMESA- : TglWindowPos4dvMESA;
  glWindowPos4fMESA- : TglWindowPos4fMESA;
  glWindowPos4fvMESA- : TglWindowPos4fvMESA;
  glWindowPos4iMESA- : TglWindowPos4iMESA;
  glWindowPos4ivMESA- : TglWindowPos4ivMESA;
  glWindowPos4sMESA- : TglWindowPos4sMESA;
  glWindowPos4svMESA- : TglWindowPos4svMESA;

  (*  GL_NV_evaluators *)
  glMapControlPointsNV- : TglMapControlPointsNV;
  glMapParameterivNV- : TglMapParameterivNV;
  glMapParameterfvNV- : TglMapParameterfvNV;
  glGetMapControlPointsNV- : TglGetMapControlPointsNV;
  glGetMapParameterivNV- : TglGetMapParameterivNV;
  glGetMapParameterfvNV- : TglGetMapParameterfvNV;
  glGetMapAttribParameterivNV- : TglGetMapAttribParameterivNV;
  glGetMapAttribParameterfvNV- : TglGetMapAttribParameterfvNV;
  glEvalMapsNV- : TglEvalMapsNV;

  (*  GL_NV_fence *)
  glDeleteFencesNV- : TglDeleteFencesNV;
  glGenFencesNV- : TglGenFencesNV;
  glIsFenceNV- : TglIsFenceNV;
  glTestFenceNV- : TglTestFenceNV;
  glGetFenceivNV- : TglGetFenceivNV;
  glFinishFenceNV- : TglFinishFenceNV;
  glSetFenceNV- : TglSetFenceNV;

  (*  GL_NV_fragment_program *)
  glProgramNamedParameter4fNV- : TglProgramNamedParameter4fNV;
  glProgramNamedParameter4dNV- : TglProgramNamedParameter4dNV;
  glProgramNamedParameter4fvNV- : TglProgramNamedParameter4fvNV;
  glProgramNamedParameter4dvNV- : TglProgramNamedParameter4dvNV;
  glGetProgramNamedParameterfvNV- : TglGetProgramNamedParameterfvNV;
  glGetProgramNamedParameterdvNV- : TglGetProgramNamedParameterdvNV;

  (*  GL_NV_half_float *)
  glVertex2hNV- : TglVertex2hNV;
  glVertex2hvNV- : TglVertex2hvNV;
  glVertex3hNV- : TglVertex3hNV;
  glVertex3hvNV- : TglVertex3hvNV;
  glVertex4hNV- : TglVertex4hNV;
  glVertex4hvNV- : TglVertex4hvNV;
  glNormal3hNV- : TglNormal3hNV;
  glNormal3hvNV- : TglNormal3hvNV;
  glColor3hNV- : TglColor3hNV;
  glColor3hvNV- : TglColor3hvNV;
  glColor4hNV- : TglColor4hNV;
  glColor4hvNV- : TglColor4hvNV;
  glTexCoord1hNV- : TglTexCoord1hNV;
  glTexCoord1hvNV- : TglTexCoord1hvNV;
  glTexCoord2hNV- : TglTexCoord2hNV;
  glTexCoord2hvNV- : TglTexCoord2hvNV;
  glTexCoord3hNV- : TglTexCoord3hNV;
  glTexCoord3hvNV- : TglTexCoord3hvNV;
  glTexCoord4hNV- : TglTexCoord4hNV;
  glTexCoord4hvNV- : TglTexCoord4hvNV;
  glMultiTexCoord1hNV- : TglMultiTexCoord1hNV;
  glMultiTexCoord1hvNV- : TglMultiTexCoord1hvNV;
  glMultiTexCoord2hNV- : TglMultiTexCoord2hNV;
  glMultiTexCoord2hvNV- : TglMultiTexCoord2hvNV;
  glMultiTexCoord3hNV- : TglMultiTexCoord3hNV;
  glMultiTexCoord3hvNV- : TglMultiTexCoord3hvNV;
  glMultiTexCoord4hNV- : TglMultiTexCoord4hNV;
  glMultiTexCoord4hvNV- : TglMultiTexCoord4hvNV;
  glFogCoordhNV- : TglFogCoordhNV;
  glFogCoordhvNV- : TglFogCoordhvNV;
  glSecondaryColor3hNV- : TglSecondaryColor3hNV;
  glSecondaryColor3hvNV- : TglSecondaryColor3hvNV;
  glVertexWeighthNV- : TglVertexWeighthNV;
  glVertexWeighthvNV- : TglVertexWeighthvNV;
  glVertexAttrib1hNV- : TglVertexAttrib1hNV;
  glVertexAttrib1hvNV- : TglVertexAttrib1hvNV;
  glVertexAttrib2hNV- : TglVertexAttrib2hNV;
  glVertexAttrib2hvNV- : TglVertexAttrib2hvNV;
  glVertexAttrib3hNV- : TglVertexAttrib3hNV;
  glVertexAttrib3hvNV- : TglVertexAttrib3hvNV;
  glVertexAttrib4hNV- : TglVertexAttrib4hNV;
  glVertexAttrib4hvNV- : TglVertexAttrib4hvNV;
  glVertexAttribs1hvNV- : TglVertexAttribs1hvNV;
  glVertexAttribs2hvNV- : TglVertexAttribs2hvNV;
  glVertexAttribs3hvNV- : TglVertexAttribs3hvNV;
  glVertexAttribs4hvNV- : TglVertexAttribs4hvNV;

  (*  GL_NV_occlusion_query *)
  glGenOcclusionQueriesNV- : TglGenOcclusionQueriesNV;
  glDeleteOcclusionQueriesNV- : TglDeleteOcclusionQueriesNV;
  glIsOcclusionQueryNV- : TglIsOcclusionQueryNV;
  glBeginOcclusionQueryNV- : TglBeginOcclusionQueryNV;
  glEndOcclusionQueryNV- : TglEndOcclusionQueryNV;
  glGetOcclusionQueryivNV- : TglGetOcclusionQueryivNV;
  glGetOcclusionQueryuivNV- : TglGetOcclusionQueryuivNV;

  (*  GL_NV_pixel_data_range *)
  glPixelDataRangeNV- : TglPixelDataRangeNV;
  glFlushPixelDataRangeNV- : TglFlushPixelDataRangeNV;

  (*  GL_NV_point_sprite *)
  glPointParameteriNV- : TglPointParameteriNV;
  glPointParameterivNV- : TglPointParameterivNV;

  (*  GL_NV_primitive_restart *)
  glPrimitiveRestartNV- : TglPrimitiveRestartNV;
  glPrimitiveRestartIndexNV- : TglPrimitiveRestartIndexNV;

  (*  GL_NV_register_combiners *)
  glCombinerParameterfvNV- : TglCombinerParameterfvNV;
  glCombinerParameterfNV- : TglCombinerParameterfNV;
  glCombinerParameterivNV- : TglCombinerParameterivNV;
  glCombinerParameteriNV- : TglCombinerParameteriNV;
  glCombinerInputNV- : TglCombinerInputNV;
  glCombinerOutputNV- : TglCombinerOutputNV;
  glFinalCombinerInputNV- : TglFinalCombinerInputNV;
  glGetCombinerInputParameterfvNV- : TglGetCombinerInputParameterfvNV;
  glGetCombinerInputParameterivNV- : TglGetCombinerInputParameterivNV;
  glGetCombinerOutputParameterfvNV- : TglGetCombinerOutputParameterfvNV;
  glGetCombinerOutputParameterivNV- : TglGetCombinerOutputParameterivNV;
  glGetFinalCombinerInputParameterfvNV- : TglGetFinalCombinerInputParameterfvNV;
  glGetFinalCombinerInputParameterivNV- : TglGetFinalCombinerInputParameterivNV;

  (*  GL_NV_register_combiners2 *)
  glCombinerStageParameterfvNV- : TglCombinerStageParameterfvNV;
  glGetCombinerStageParameterfvNV- : TglGetCombinerStageParameterfvNV;

  (*  GL_NV_vertex_array_range *)
  glFlushVertexArrayRangeNV- : TglFlushVertexArrayRangeNV;
  glVertexArrayRangeNV- : TglVertexArrayRangeNV;

  (*  GL_NV_vertex_program *)
  glAreProgramsResidentNV- : TglAreProgramsResidentNV;
  glBindProgramNV- : TglBindProgramNV;
  glDeleteProgramsNV- : TglDeleteProgramsNV;
  glExecuteProgramNV- : TglExecuteProgramNV;
  glGenProgramsNV- : TglGenProgramsNV;
  glGetProgramParameterdvNV- : TglGetProgramParameterdvNV;
  glGetProgramParameterfvNV- : TglGetProgramParameterfvNV;
  glGetProgramivNV- : TglGetProgramivNV;
  glGetProgramStringNV- : TglGetProgramStringNV;
  glGetTrackMatrixivNV- : TglGetTrackMatrixivNV;
  glGetVertexAttribdvNV- : TglGetVertexAttribdvNV;
  glGetVertexAttribfvNV- : TglGetVertexAttribfvNV;
  glGetVertexAttribivNV- : TglGetVertexAttribivNV;
  glGetVertexAttribPointervNV- : TglGetVertexAttribPointervNV;
  glIsProgramNV- : TglIsProgramNV;
  glLoadProgramNV- : TglLoadProgramNV;
  glProgramParameter4dNV- : TglProgramParameter4dNV;
  glProgramParameter4dvNV- : TglProgramParameter4dvNV;
  glProgramParameter4fNV- : TglProgramParameter4fNV;
  glProgramParameter4fvNV- : TglProgramParameter4fvNV;
  glProgramParameters4dvNV- : TglProgramParameters4dvNV;
  glProgramParameters4fvNV- : TglProgramParameters4fvNV;
  glRequestResidentProgramsNV- : TglRequestResidentProgramsNV;
  glTrackMatrixNV- : TglTrackMatrixNV;
  glVertexAttribPointerNV- : TglVertexAttribPointerNV;
  glVertexAttrib1dNV- : TglVertexAttrib1dNV;
  glVertexAttrib1dvNV- : TglVertexAttrib1dvNV;
  glVertexAttrib1fNV- : TglVertexAttrib1fNV;
  glVertexAttrib1fvNV- : TglVertexAttrib1fvNV;
  glVertexAttrib1sNV- : TglVertexAttrib1sNV;
  glVertexAttrib1svNV- : TglVertexAttrib1svNV;
  glVertexAttrib2dNV- : TglVertexAttrib2dNV;
  glVertexAttrib2dvNV- : TglVertexAttrib2dvNV;
  glVertexAttrib2fNV- : TglVertexAttrib2fNV;
  glVertexAttrib2fvNV- : TglVertexAttrib2fvNV;
  glVertexAttrib2sNV- : TglVertexAttrib2sNV;
  glVertexAttrib2svNV- : TglVertexAttrib2svNV;
  glVertexAttrib3dNV- : TglVertexAttrib3dNV;
  glVertexAttrib3dvNV- : TglVertexAttrib3dvNV;
  glVertexAttrib3fNV- : TglVertexAttrib3fNV;
  glVertexAttrib3fvNV- : TglVertexAttrib3fvNV;
  glVertexAttrib3sNV- : TglVertexAttrib3sNV;
  glVertexAttrib3svNV- : TglVertexAttrib3svNV;
  glVertexAttrib4dNV- : TglVertexAttrib4dNV;
  glVertexAttrib4dvNV- : TglVertexAttrib4dvNV;
  glVertexAttrib4fNV- : TglVertexAttrib4fNV;
  glVertexAttrib4fvNV- : TglVertexAttrib4fvNV;
  glVertexAttrib4sNV- : TglVertexAttrib4sNV;
  glVertexAttrib4svNV- : TglVertexAttrib4svNV;
  glVertexAttrib4ubNV- : TglVertexAttrib4ubNV;
  glVertexAttrib4ubvNV- : TglVertexAttrib4ubvNV;
  glVertexAttribs1dvNV- : TglVertexAttribs1dvNV;
  glVertexAttribs1fvNV- : TglVertexAttribs1fvNV;
  glVertexAttribs1svNV- : TglVertexAttribs1svNV;
  glVertexAttribs2dvNV- : TglVertexAttribs2dvNV;
  glVertexAttribs2fvNV- : TglVertexAttribs2fvNV;
  glVertexAttribs2svNV- : TglVertexAttribs2svNV;
  glVertexAttribs3dvNV- : TglVertexAttribs3dvNV;
  glVertexAttribs3fvNV- : TglVertexAttribs3fvNV;
  glVertexAttribs3svNV- : TglVertexAttribs3svNV;
  glVertexAttribs4dvNV- : TglVertexAttribs4dvNV;
  glVertexAttribs4fvNV- : TglVertexAttribs4fvNV;
  glVertexAttribs4svNV- : TglVertexAttribs4svNV;
  glVertexAttribs4ubvNV- : TglVertexAttribs4ubvNV;

  (*  GL_NV_depth_buffer_float *)
  glDepthRangedNV- : TglDepthRangedNV;
  glClearDepthdNV- : TglClearDepthdNV;
  glDepthBoundsdNV- : TglDepthBoundsdNV;

  (*  GL_NV_framebuffer_multisample_coverage *)
  glRenderbufferStorageMultsampleCoverageNV- : TglRenderbufferStorageMultsampleCoverageNV;

  (*  GL_NV_geometry_program4 *)
  glProgramVertexLimitNV- : TglProgramVertexLimitNV;

  (*  GL_NV_gpu_program4 *)
  glProgramLocalParameterI4iNV- : TglProgramLocalParameterI4iNV;
  glProgramLocalParameterI4ivNV- : TglProgramLocalParameterI4ivNV;
  glProgramLocalParametersI4ivNV- : TglProgramLocalParametersI4ivNV;
  glProgramLocalParameterI4uiNV- : TglProgramLocalParameterI4uiNV;
  glProgramLocalParameterI4uivNV- : TglProgramLocalParameterI4uivNV;
  glProgramLocalParametersI4uivNV- : TglProgramLocalParametersI4uivNV;
  glProgramEnvParameterI4iNV- : TglProgramEnvParameterI4iNV;
  glProgramEnvParameterI4ivNV- : TglProgramEnvParameterI4ivNV;
  glProgramEnvParametersI4ivNV- : TglProgramEnvParametersI4ivNV;
  glProgramEnvParameterI4uiNV- : TglProgramEnvParameterI4uiNV;
  glProgramEnvParameterI4uivNV- : TglProgramEnvParameterI4uivNV;
  glProgramEnvParametersI4uivNV- : TglProgramEnvParametersI4uivNV;
  glGetProgramLocalParameterIivNV- : TglGetProgramLocalParameterIivNV;
  glGetProgramLocalParameterIuivNV- : TglGetProgramLocalParameterIuivNV;
  glGetProgramEnvParameterIivNV- : TglGetProgramEnvParameterIivNV;
  glGetProgramEnvParameterIuivNV- : TglGetProgramEnvParameterIuivNV;

  (*  GL_NV_parameter_buffer_object *)
  glProgramBufferParametersfvNV- : TglProgramBufferParametersfvNV;
  glProgramBufferParametersIivNV- : TglProgramBufferParametersIivNV;
  glProgramBufferParametersIuivNV- : TglProgramBufferParametersIuivNV;

  (*  GL_NV_transform_feedback *)
  glBeginTransformFeedbackNV- : TglBeginTransformFeedbackNV;
  glEndTransformFeedbackNV- : TglEndTransformFeedbackNV;
  glTransformFeedbackAttribsNV- : TglTransformFeedbackAttribsNV;
  glBindBufferRangeNV- : TglBindBufferRangeNV;
  glBindBufferOffsetNV- : TglBindBufferOffsetNV;
  glBindBufferBaseNV- : TglBindBufferBaseNV;
  glTransformFeedbackVaryingsNV- : TglTransformFeedbackVaryingsNV;
  glActiveVaryingNV- : TglActiveVaryingNV;
  glGetVaryingLocationNV- : TglGetVaryingLocationNV;
  glGetActiveVaryingNV- : TglGetActiveVaryingNV;
  glGetTransformFeedbackVaryingNV- : TglGetTransformFeedbackVaryingNV;
  glTransformFeedbackStreamAttribsNV- : TglTransformFeedbackStreamAttribsNV;

  (*  GL_NV_conditional_render *)
  glBeginConditionalRenderNV- : TglBeginConditionalRenderNV;
  glEndConditionalRenderNV- : TglEndConditionalRenderNV;

  (*  GL_NV_present_video *)
  glPresentFrameKeyedNV- : TglPresentFrameKeyedNV;
  glPresentFrameDualFillNV- : TglPresentFrameDualFillNV;
  glGetVideoivNV- : TglGetVideoivNV;
  glGetVideouivNV- : TglGetVideouivNV;
  glGetVideoi64vNV- : TglGetVideoi64vNV;
  glGetVideoui64vNV- : TglGetVideoui64vNV;
(*   glVideoParameterivNV- : TglVideoParameterivNV; *)

  (*  GL_NV_explicit_multisample *)
  glGetMultisamplefvNV- : TglGetMultisamplefvNV;
  glSampleMaskIndexedNV- : TglSampleMaskIndexedNV;
  glTexRenderbufferNV- : TglTexRenderbufferNV;

  (*  GL_NV_transform_feedback2 *)
  glBindTransformFeedbackNV- : TglBindTransformFeedbackNV;
  glDeleteTransformFeedbacksNV- : TglDeleteTransformFeedbacksNV;
  glGenTransformFeedbacksNV- : TglGenTransformFeedbacksNV;
  glIsTransformFeedbackNV- : TglIsTransformFeedbackNV;
  glPauseTransformFeedbackNV- : TglPauseTransformFeedbackNV;
  glResumeTransformFeedbackNV- : TglResumeTransformFeedbackNV;
  glDrawTransformFeedbackNV- : TglDrawTransformFeedbackNV;

  (*  GL_NV_video_capture *)
  glBeginVideoCaptureNV- : TglBeginVideoCaptureNV;
  glBindVideoCaptureStreamBufferNV- : TglBindVideoCaptureStreamBufferNV;
  glBindVideoCaptureStreamTextureNV- : TglBindVideoCaptureStreamTextureNV;
  glEndVideoCaptureNV- : TglEndVideoCaptureNV;
  glGetVideoCaptureivNV- : TglGetVideoCaptureivNV;
  glGetVideoCaptureStreamivNV- : TglGetVideoCaptureStreamivNV;
  glGetVideoCaptureStreamfvNV- : TglGetVideoCaptureStreamfvNV;
  glGetVideoCaptureStreamdvNV- : TglGetVideoCaptureStreamdvNV;
  glVideoCaptureNV- : TglVideoCaptureNV;
  glVideoCaptureStreamParameterivNV- : TglVideoCaptureStreamParameterivNV;
  glVideoCaptureStreamParameterfvNV- : TglVideoCaptureStreamParameterfvNV;
  glVideoCaptureStreamParameterdvNV- : TglVideoCaptureStreamParameterdvNV;

  (*  GL_NV_copy_image *)
  glCopyImageSubDataNV- : TglCopyImageSubDataNV;

  (*  GL_NV_shader_buffer_load *)
  glMakeBufferResidentNV- : TglMakeBufferResidentNV;
  glMakeBufferNonResidentNV- : TglMakeBufferNonResidentNV;
  glIsBufferResidentNV- : TglIsBufferResidentNV;
  glMakeNamedBufferResidentNV- : TglMakeNamedBufferResidentNV;
  glMakeNamedBufferNonResidentNV- : TglMakeNamedBufferNonResidentNV;
  glIsNamedBufferResidentNV- : TglIsNamedBufferResidentNV;
  glGetBufferParameterui64vNV- : TglGetBufferParameterui64vNV;
  glGetNamedBufferParameterui64vNV- : TglGetNamedBufferParameterui64vNV;
  glGetIntegerui64vNV- : TglGetIntegerui64vNV;
  glUniformui64NV- : TglUniformui64NV;
  glUniformui64vNV- : TglUniformui64vNV;
  glGetUniformui64vNV- : TglGetUniformui64vNV;
  glProgramUniformui64NV- : TglProgramUniformui64NV;
  glProgramUniformui64vNV- : TglProgramUniformui64vNV;

  (*  GL_NV_vertex_buffer_unified_memory *)
  glBufferAddressRangeNV- : TglBufferAddressRangeNV;
  glVertexFormatNV- : TglVertexFormatNV;
  glNormalFormatNV- : TglNormalFormatNV;
  glColorFormatNV- : TglColorFormatNV;
  glIndexFormatNV- : TglIndexFormatNV;
  glTexCoordFormatNV- : TglTexCoordFormatNV;
  glEdgeFlagFormatNV- : TglEdgeFlagFormatNV;
  glSecondaryColorFormatNV- : TglSecondaryColorFormatNV;
  glFogCoordFormatNV- : TglFogCoordFormatNV;
  glVertexAttribFormatNV- : TglVertexAttribFormatNV;
  glVertexAttribIFormatNV- : TglVertexAttribIFormatNV;
  glGetIntegerui64i_vNV- : TglGetIntegerui64i_vNV;

  (*  GL_NV_gpu_program5 *)
  glProgramSubroutineParametersuivNV- : TglProgramSubroutineParametersuivNV;
  glGetProgramSubroutineParameteruivNV- : TglGetProgramSubroutineParameteruivNV;

  (*  GL_NV_gpu_shader5 *)
  glUniform1i64NV- : TglUniform1i64NV;
  glUniform2i64NV- : TglUniform2i64NV;
  glUniform3i64NV- : TglUniform3i64NV;
  glUniform4i64NV- : TglUniform4i64NV;
  glUniform1i64vNV- : TglUniform1i64vNV;
  glUniform2i64vNV- : TglUniform2i64vNV;
  glUniform3i64vNV- : TglUniform3i64vNV;
  glUniform4i64vNV- : TglUniform4i64vNV;
  glUniform1ui64NV- : TglUniform1ui64NV;
  glUniform2ui64NV- : TglUniform2ui64NV;
  glUniform3ui64NV- : TglUniform3ui64NV;
  glUniform4ui64NV- : TglUniform4ui64NV;
  glUniform1ui64vNV- : TglUniform1ui64vNV;
  glUniform2ui64vNV- : TglUniform2ui64vNV;
  glUniform3ui64vNV- : TglUniform3ui64vNV;
  glUniform4ui64vNV- : TglUniform4ui64vNV;
  glGetUniformi64vNV- : TglGetUniformi64vNV;
  glProgramUniform1i64NV- : TglProgramUniform1i64NV;
  glProgramUniform2i64NV- : TglProgramUniform2i64NV;
  glProgramUniform3i64NV- : TglProgramUniform3i64NV;
  glProgramUniform4i64NV- : TglProgramUniform4i64NV;
  glProgramUniform1i64vNV- : TglProgramUniform1i64vNV;
  glProgramUniform2i64vNV- : TglProgramUniform2i64vNV;
  glProgramUniform3i64vNV- : TglProgramUniform3i64vNV;
  glProgramUniform4i64vNV- : TglProgramUniform4i64vNV;
  glProgramUniform1ui64NV- : TglProgramUniform1ui64NV;
  glProgramUniform2ui64NV- : TglProgramUniform2ui64NV;
  glProgramUniform3ui64NV- : TglProgramUniform3ui64NV;
  glProgramUniform4ui64NV- : TglProgramUniform4ui64NV;
  glProgramUniform1ui64vNV- : TglProgramUniform1ui64vNV;
  glProgramUniform2ui64vNV- : TglProgramUniform2ui64vNV;
  glProgramUniform3ui64vNV- : TglProgramUniform3ui64vNV;
  glProgramUniform4ui64vNV- : TglProgramUniform4ui64vNV;

  (*  GL_NV_vertex_attrib_integer_64bit *)
  glVertexAttribL1i64NV- : TglVertexAttribL1i64NV;
  glVertexAttribL2i64NV- : TglVertexAttribL2i64NV;
  glVertexAttribL3i64NV- : TglVertexAttribL3i64NV;
  glVertexAttribL4i64NV- : TglVertexAttribL4i64NV;
  glVertexAttribL1i64vNV- : TglVertexAttribL1i64vNV;
  glVertexAttribL2i64vNV- : TglVertexAttribL2i64vNV;
  glVertexAttribL3i64vNV- : TglVertexAttribL3i64vNV;
  glVertexAttribL4i64vNV- : TglVertexAttribL4i64vNV;
  glVertexAttribL1ui64NV- : TglVertexAttribL1ui64NV;
  glVertexAttribL2ui64NV- : TglVertexAttribL2ui64NV;
  glVertexAttribL3ui64NV- : TglVertexAttribL3ui64NV;
  glVertexAttribL4ui64NV- : TglVertexAttribL4ui64NV;
  glVertexAttribL1ui64vNV- : TglVertexAttribL1ui64vNV;
  glVertexAttribL2ui64vNV- : TglVertexAttribL2ui64vNV;
  glVertexAttribL3ui64vNV- : TglVertexAttribL3ui64vNV;
  glVertexAttribL4ui64vNV- : TglVertexAttribL4ui64vNV;
  glGetVertexAttribLi64vNV- : TglGetVertexAttribLi64vNV;
  glGetVertexAttribLui64vNV- : TglGetVertexAttribLui64vNV;
  glVertexAttribLFormatNV- : TglVertexAttribLFormatNV;

  (*  GL_NV_vdpau_interop *)
  glVDPAUInitNV- : TglVDPAUInitNV;
  glVDPAUFiniNV- : TglVDPAUFiniNV;
  glVDPAURegisterVideoSurfaceNV- : TglVDPAURegisterVideoSurfaceNV;
  glVDPAURegisterOutputSurfaceNV- : TglVDPAURegisterOutputSurfaceNV;
  glVDPAUIsSurfaceNV- : TglVDPAUIsSurfaceNV;
  glVDPAUUnregisterSurfaceNV- : TglVDPAUUnregisterSurfaceNV;
  glVDPAUGetSurfaceivNV- : TglVDPAUGetSurfaceivNV;
  glVDPAUSurfaceAccessNV- : TglVDPAUSurfaceAccessNV;
  glVDPAUMapSurfacesNV- : TglVDPAUMapSurfacesNV;
  glVDPAUUnmapSurfacesNV- : TglVDPAUUnmapSurfacesNV;

  (*  GL_NV_texture_barrier *)
  glTextureBarrierNV- : TglTextureBarrierNV;


(*! GLX_LINUX  *)
  glXChooseVisual- : TglXChooseVisual;
  glXCopyContext- : TglXCopyContext;
  glXCreateContext- : TglXCreateContext;
  glXCreateGLXPixmap- : TglXCreateGLXPixmap;
  glXDestroyContext- : TglXDestroyContext;
  glXDestroyGLXPixmap- : TglXDestroyGLXPixmap;
  glXGetConfig- : TglXGetConfig;
  glXGetCurrentContext- : TglXGetCurrentContext;
  glXGetCurrentDrawable- : TglXGetCurrentDrawable;
  glXIsDirect- : TglXIsDirect;
  glXMakeCurrent- : TglXMakeCurrent;
  glXQueryExtension- : TglXQueryExtension;
  glXQueryVersion- : TglXQueryVersion;
  glXSwapBuffers- : TglXSwapBuffers;
  glXUseXFont- : TglXUseXFont;
  glXWaitGL- : TglXWaitGL;
  glXWaitX- : TglXWaitX;

  glXGetClientString- : TglXGetClientString;
  glXQueryServerString- : TglXQueryServerString;
  glXQueryExtensionsString- : TglXQueryExtensionsString;

  (*! GLX_VERSION_1_3 *)
  glXGetFBConfigs- : TglXGetFBConfigs;
  glXChooseFBConfig- : TglXChooseFBConfig;
  glXGetFBConfigAttrib- : TglXGetFBConfigAttrib;
  glXGetVisualFromFBConfig- : TglXGetVisualFromFBConfig;
  glXCreateWindow- : TglXCreateWindow;
  glXDestroyWindow- : TglXDestroyWindow;
  glXCreatePixmap- : TglXCreatePixmap;

  glXDestroyPixmap- : TglXDestroyPixmap;
  glXCreatePbuffer- : TglXCreatePbuffer;
  glXDestroyPbuffer- : TglXDestroyPbuffer;
  glXQueryDrawable- : TglXQueryDrawable;
  glXCreateNewContext- : TglXCreateNewContext;
  glXMakeContextCurrent- : TglXMakeContextCurrent;
  glXGetCurrentReadDrawable- : TglXGetCurrentReadDrawable;
  glXGetCurrentDisplay- : TglXGetCurrentDisplay;

  glXQueryContext- : TglXQueryContext;
  glXSelectEvent- : TglXSelectEvent;
  glXGetSelectedEvent- : TglXGetSelectedEvent;

  (*! GLX_VERSION_1_4 *)
  glXGetProcAddress- : TglXGetProcAddress;

  (*  GLX_ARB_get_proc_address *)
  glXGetProcAddressARB- : TglXGetProcAddressARB;

  (* GLX_ARB_create_context *)
  glXCreateContextAttribsARB- : TglXCreateContextAttribsARB;
  
  (*  GLX_EXT_import_context *)
  glXGetCurrentDisplayEXT- : TglXGetCurrentDisplayEXT;
  glXQueryContextInfoEXT- : TglXQueryContextInfoEXT;
  glXGetContextIDEXT- : TglXGetContextIDEXT;
  glXImportContextEXT- : TglXImportContextEXT;
  glXFreeContextEXT- : TglXFreeContextEXT;
  
  (* GLX_EXT_texture_from_pixmap *)
  glXBindTexImageEXT- : TglXBindTexImageEXT;
  glXReleaseTexImageEXT- : TglXReleaseTexImageEXT;
(* ENDIF *)
  
PROCEDURE InitOpenGL*;
VAR 
  name: ARRAY 64 OF CHAR;
BEGIN {EXCLUSIVE}
 
   GL_LibHandle := Unix.Dlopen(GL_LibName,2);
  ASSERT(GL_LibHandle # 0,101);

  GLU_LibHandle := Unix.Dlopen(GLU_LibName,2);
  ASSERT(GLU_LibHandle # 0,102);	
  	  
  (* load GL functions*)
  IF (GL_LibHandle # 0) THEN
    (* GLX_VERSION_1_4 (needs to be first)*)
     Unix.Dlsym(GL_LibHandle, 'glXGetProcAddress', SYSTEM.VAL(ADDRESS, glXGetProcAddress));

      (* GLX_ARB_get_proc_address  (also needs to be first) *)
     Unix.Dlsym(GL_LibHandle, 'glXGetProcAddressARB', SYSTEM.VAL(ADDRESS, glXGetProcAddressARB));


 	Unix.Dlsym(GL_LibHandle, 'glXChooseVisual', SYSTEM.VAL(ADDRESS, glXChooseVisual));
	Unix.Dlsym(GL_LibHandle, 'glXCopyContext', SYSTEM.VAL(ADDRESS, glXCopyContext));
	Unix.Dlsym(GL_LibHandle, 'glXCreateContext', SYSTEM.VAL(ADDRESS, glXCreateContext));
	Unix.Dlsym(GL_LibHandle, 'glXCreateGLXPixmap', SYSTEM.VAL(ADDRESS, glXCreateGLXPixmap));
	Unix.Dlsym(GL_LibHandle, 'glXDestroyContext', SYSTEM.VAL(ADDRESS, glXDestroyContext));
	Unix.Dlsym(GL_LibHandle, 'glXDestroyGLXPixmap', SYSTEM.VAL(ADDRESS, glXDestroyGLXPixmap));
	Unix.Dlsym(GL_LibHandle, 'glXGetConfig', SYSTEM.VAL(ADDRESS, glXGetConfig));
	Unix.Dlsym(GL_LibHandle, 'glXGetCurrentContext', SYSTEM.VAL(ADDRESS, glXGetCurrentContext));
	Unix.Dlsym(GL_LibHandle, 'glXGetCurrentDrawable', SYSTEM.VAL(ADDRESS, glXGetCurrentDrawable));
	Unix.Dlsym(GL_LibHandle, 'glXIsDirect', SYSTEM.VAL(ADDRESS, glXIsDirect));

       Unix.Dlsym(GL_LibHandle, 'glXMakeCurrent', SYSTEM.VAL(ADDRESS, glXMakeCurrent ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryExtension', SYSTEM.VAL(ADDRESS,glXQueryExtension  ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryVersion', SYSTEM.VAL(ADDRESS, glXQueryVersion ));
       Unix.Dlsym(GL_LibHandle, 'glXSwapBuffers', SYSTEM.VAL(ADDRESS, glXSwapBuffers ));
       Unix.Dlsym(GL_LibHandle, 'glXUseXFont', SYSTEM.VAL(ADDRESS, glXUseXFont ));
       Unix.Dlsym(GL_LibHandle, 'glXWaitGL', SYSTEM.VAL(ADDRESS, glXWaitGL ));
       Unix.Dlsym(GL_LibHandle, 'glXWaitX', SYSTEM.VAL(ADDRESS, glXWaitX ));
       Unix.Dlsym(GL_LibHandle, 'glXGetClientString', SYSTEM.VAL(ADDRESS,glXGetClientString ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryServerString', SYSTEM.VAL(ADDRESS, glXQueryServerString ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryExtensionsString', SYSTEM.VAL(ADDRESS,glXQueryExtensionsString  ));

    (* GLX_VERSION_1_3 *)
       Unix.Dlsym(GL_LibHandle, 'glXGetFBConfigs', SYSTEM.VAL(ADDRESS, glXGetFBConfigs));
       Unix.Dlsym(GL_LibHandle, 'glXChooseFBConfig', SYSTEM.VAL(ADDRESS,glXChooseFBConfig));
       Unix.Dlsym(GL_LibHandle, 'glXGetFBConfigAttrib', SYSTEM.VAL(ADDRESS,glXGetFBConfigAttrib ));
       Unix.Dlsym(GL_LibHandle, 'glXGetVisualFromFBConfig', SYSTEM.VAL(ADDRESS,glXGetVisualFromFBConfig ));
       Unix.Dlsym(GL_LibHandle, 'glXCreateWindow', SYSTEM.VAL(ADDRESS,glXCreateWindow ));
       Unix.Dlsym(GL_LibHandle, 'glXDestroyWindow', SYSTEM.VAL(ADDRESS, glXDestroyWindow));
       Unix.Dlsym(GL_LibHandle, 'glXCreatePixmap', SYSTEM.VAL(ADDRESS, glXCreatePixmap));

       Unix.Dlsym(GL_LibHandle, 'glXDestroyPixmap', SYSTEM.VAL(ADDRESS,glXDestroyPixmap ));
       Unix.Dlsym(GL_LibHandle, 'glXCreatePbuffer', SYSTEM.VAL(ADDRESS,glXCreatePbuffer ));
       Unix.Dlsym(GL_LibHandle, 'glXDestroyPbuffer', SYSTEM.VAL(ADDRESS,glXDestroyPbuffer ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryDrawable', SYSTEM.VAL(ADDRESS,glXQueryDrawable ));
       Unix.Dlsym(GL_LibHandle, 'glXCreateNewContext', SYSTEM.VAL(ADDRESS, glXCreateNewContext));
       Unix.Dlsym(GL_LibHandle, 'glXMakeContextCurrent', SYSTEM.VAL(ADDRESS,glXMakeContextCurrent ));
       Unix.Dlsym(GL_LibHandle, 'glXGetCurrentReadDrawable', SYSTEM.VAL(ADDRESS, glXGetCurrentReadDrawable));
       Unix.Dlsym(GL_LibHandle, 'glXGetCurrentDisplay', SYSTEM.VAL(ADDRESS, glXGetCurrentDisplay));

       Unix.Dlsym(GL_LibHandle, 'glXQueryContext', SYSTEM.VAL(ADDRESS, glXQueryContext));
       Unix.Dlsym(GL_LibHandle, 'glXSelectEvent', SYSTEM.VAL(ADDRESS, glXSelectEvent));
       Unix.Dlsym(GL_LibHandle, 'glXGetSelectedEvent', SYSTEM.VAL(ADDRESS,glXGetSelectedEvent));

      (* GLX_ARB_create_context *)
       Unix.Dlsym(GL_LibHandle, 'glXCreateContextAttribsARB', SYSTEM.VAL(ADDRESS, glXCreateContextAttribsARB));

      (* GLX_EXT_import_context *)
       Unix.Dlsym(GL_LibHandle, 'glXGetCurrentDisplayEXT', SYSTEM.VAL(ADDRESS,glXGetCurrentDisplayEXT ));
       Unix.Dlsym(GL_LibHandle, 'glXQueryContextInfoEXT', SYSTEM.VAL(ADDRESS,glXQueryContextInfoEXT ));
       Unix.Dlsym(GL_LibHandle, 'glXGetContextIDEXT', SYSTEM.VAL(ADDRESS,glXGetContextIDEXT ));
       Unix.Dlsym(GL_LibHandle, 'glXImportContextEXT', SYSTEM.VAL(ADDRESS,glXImportContextEXT ));
       Unix.Dlsym(GL_LibHandle, 'glXFreeContextEXT', SYSTEM.VAL(ADDRESS, glXFreeContextEXT));
      
      (* GLX_EXT_texture_from_pixmap *)
       Unix.Dlsym(GL_LibHandle, 'glXBindTexImageEXT', SYSTEM.VAL(ADDRESS,glXBindTexImageEXT ));
       Unix.Dlsym(GL_LibHandle, 'glXReleaseTexImageEXT', SYSTEM.VAL(ADDRESS,glXReleaseTexImageEXT ));  

 (*! GL_VERSION_1_0*)
   glCullFace := SYSTEM.VAL(TglCullFace , glXGetProcAddress('glCullFace')  );
   glFrontFace := SYSTEM.VAL(TglFrontFace , glXGetProcAddress('glFrontFace')  );
   glHint := SYSTEM.VAL(TglHint , glXGetProcAddress('glHint')  );
   glLineWidth := SYSTEM.VAL(TglLineWidth , glXGetProcAddress('glLineWidth')  );
   glPointSize := SYSTEM.VAL(TglPointSize , glXGetProcAddress('glPointSize')  );
   glPolygonMode := SYSTEM.VAL(TglPolygonMode , glXGetProcAddress('glPolygonMode')  );
   glScissor := SYSTEM.VAL(TglScissor , glXGetProcAddress('glScissor')  );
   glTexParameterf := SYSTEM.VAL(TglTexParameterf , glXGetProcAddress('glTexParameterf')  );
   glTexParameterfv := SYSTEM.VAL(TglTexParameterfv , glXGetProcAddress('glTexParameterfv')  );
   glTexParameteri := SYSTEM.VAL(TglTexParameteri , glXGetProcAddress('glTexParameteri')  );
   glTexParameteriv := SYSTEM.VAL(TglTexParameteriv , glXGetProcAddress('glTexParameteriv')  );
   glTexImage1D := SYSTEM.VAL(TglTexImage1D , glXGetProcAddress('glTexImage1D')  );
   glTexImage2D := SYSTEM.VAL(TglTexImage2D , glXGetProcAddress('glTexImage2D')  );
   glDrawBuffer:= SYSTEM.VAL(TglDrawBuffer , glXGetProcAddress('glDrawBuffer')  );
   glClear := SYSTEM.VAL(TglClear , glXGetProcAddress('glClear')  );
   glClearColor := SYSTEM.VAL(TglClearColor , glXGetProcAddress('glClearColor')  );
   glClearStencil := SYSTEM.VAL(TglClearStencil , glXGetProcAddress('glClearStencil')  );
   glClearDepth := SYSTEM.VAL(TglClearDepth , glXGetProcAddress('glClearDepth')  );
   glStencilMask := SYSTEM.VAL(TglStencilMask , glXGetProcAddress('glStencilMask')  );
   glColorMask := SYSTEM.VAL(TglColorMask , glXGetProcAddress('glColorMask')  );
   glDepthMask := SYSTEM.VAL(TglDepthMask , glXGetProcAddress('glDepthMask')  );
   glDisable := SYSTEM.VAL(TglDisable , glXGetProcAddress('glDisable')  );
   glEnable := SYSTEM.VAL(TglEnable , glXGetProcAddress('glEnable')  );
   glFinish := SYSTEM.VAL(TglFinish , glXGetProcAddress('glFinish')  );
   glFlush := SYSTEM.VAL(TglFlush , glXGetProcAddress('glFlush')  );
   glBlendFunc := SYSTEM.VAL(TglBlendFunc , glXGetProcAddress('glBlendFunc')  );
   glLogicOp := SYSTEM.VAL(TglLogicOp , glXGetProcAddress('glLogicOp')  );
   glStencilFunc := SYSTEM.VAL(TglStencilFunc , glXGetProcAddress('glStencilFunc')  );
   glStencilOp := SYSTEM.VAL(TglStencilOp , glXGetProcAddress('glStencilOp')  );
   glDepthFunc := SYSTEM.VAL(TglDepthFunc , glXGetProcAddress('glDepthFunc')  );
   glPixelStoref := SYSTEM.VAL(TglPixelStoref , glXGetProcAddress('glPixelStoref')  );
   glPixelStorei := SYSTEM.VAL(TglPixelStorei , glXGetProcAddress('glPixelStorei')  );
   glReadBuffer := SYSTEM.VAL(TglReadBuffer , glXGetProcAddress('glReadBuffer')  );
   glReadPixels := SYSTEM.VAL(TglReadPixels , glXGetProcAddress('glReadPixels')  );
   glGetBooleanv := SYSTEM.VAL(TglGetBooleanv , glXGetProcAddress('glGetBooleanv')  );
   glGetDoublev := SYSTEM.VAL(TglGetDoublev , glXGetProcAddress('glGetDoublev')  );
   glGetError := SYSTEM.VAL(TglGetError , glXGetProcAddress('glGetError')  );
   glGetFloatv := SYSTEM.VAL(TglGetFloatv , glXGetProcAddress('glGetFloatv')  );
   glGetIntegerv := SYSTEM.VAL(TglGetIntegerv , glXGetProcAddress('glGetIntegerv')  );
   glGetString := SYSTEM.VAL(TglGetString , glXGetProcAddress('glGetString')  );
   glGetTexImage := SYSTEM.VAL(TglGetTexImage , glXGetProcAddress('glGetTexImage')  );
   glGetTexParameteriv:= SYSTEM.VAL(TglGetTexParameteriv , glXGetProcAddress('glGetTexParameteriv')  );
   glGetTexParameterfv := SYSTEM.VAL(TglGetTexParameterfv , glXGetProcAddress('glGetTexParameterfv')  );
   glGetTexLevelParameterfv := SYSTEM.VAL(TglGetTexLevelParameterfv , glXGetProcAddress('glGetTexLevelParameterfv')  );
   glGetTexLevelParameteriv := SYSTEM.VAL(TglGetTexLevelParameteriv , glXGetProcAddress('glGetTexLevelParameteriv')  );
   glIsEnabled := SYSTEM.VAL(TglIsEnabled , glXGetProcAddress('glIsEnabled')  );
   glDepthRange := SYSTEM.VAL(TglDepthRange , glXGetProcAddress('glDepthRange')  );
   glViewport := SYSTEM.VAL(TglViewport , glXGetProcAddress('glViewport')  );

  (*! GL_VERSION_1_1*)
   glDrawArrays:= SYSTEM.VAL(TglDrawArrays , glXGetProcAddress('glDrawArrays')  );
   glDrawElements := SYSTEM.VAL(TglDrawElements , glXGetProcAddress('glDrawElements')  );
   glGetPointerv := SYSTEM.VAL(TglGetPointerv , glXGetProcAddress('glGetPointerv')  );
   glPolygonOffset:= SYSTEM.VAL(TglPolygonOffset , glXGetProcAddress('glPolygonOffset')  );
   glCopyTexImage1D := SYSTEM.VAL(TglCopyTexImage1D , glXGetProcAddress('glCopyTexImage1D')  );
   glCopyTexImage2D := SYSTEM.VAL(TglCopyTexImage2D , glXGetProcAddress('glCopyTexImage2D') );
   glCopyTexSubImage1D := SYSTEM.VAL(TglCopyTexSubImage1D , glXGetProcAddress('glCopyTexSubImage1D'));
   glCopyTexSubImage2D := SYSTEM.VAL(TglCopyTexSubImage2D , glXGetProcAddress('glCopyTexSubImage2D'));
   glTexSubImage1D := SYSTEM.VAL(TglTexSubImage1D , glXGetProcAddress('glTexSubImage1D')  );
   glTexSubImage2D := SYSTEM.VAL(TglTexSubImage2D , glXGetProcAddress('glTexSubImage2D')  );
   glBindTexture := SYSTEM.VAL(TglBindTexture , glXGetProcAddress('glBindTexture')  );
   glDeleteTextures:= SYSTEM.VAL(TglDeleteTextures , glXGetProcAddress('glDeleteTextures')  );
   glGenTextures := SYSTEM.VAL(TglGenTextures , glXGetProcAddress('glGenTextures')  );

(*! ifdef DEPRECATED *)
   glAccum := SYSTEM.VAL(TglAccum , glXGetProcAddress('glAccum') );
    glAlphaFunc := SYSTEM.VAL(TglAlphaFunc , glXGetProcAddress('glAlphaFunc') );
    glAreTexturesResident := SYSTEM.VAL(TglAreTexturesResident , glXGetProcAddress('glAreTexturesResident') );
    glArrayElement := SYSTEM.VAL(TglArrayElement , glXGetProcAddress('glArrayElement') );
    glBegin := SYSTEM.VAL(TglBegin , glXGetProcAddress('glBegin') );
    glBitmap := SYSTEM.VAL(TglBitmap , glXGetProcAddress('glBitmap') );
    glCallList := SYSTEM.VAL(TglCallList , glXGetProcAddress('glCallList') );
    glCallLists := SYSTEM.VAL(TglCallLists , glXGetProcAddress('glCallLists') );
    glClearAccum := SYSTEM.VAL(TglClearAccum , glXGetProcAddress('glClearAccum') );
    glClearIndex := SYSTEM.VAL(TglClearIndex , glXGetProcAddress('glClearIndex') );
    glClipPlane := SYSTEM.VAL(TglClipPlane , glXGetProcAddress('glClipPlane') );
    glColor3b := SYSTEM.VAL(TglColor3b , glXGetProcAddress('glColor3b') );
    glColor3bv := SYSTEM.VAL(TglColor3bv , glXGetProcAddress('glColor3bv') );
    glColor3d := SYSTEM.VAL(TglColor3d , glXGetProcAddress('glColor3d') );
    glColor3dv := SYSTEM.VAL(TglColor3dv , glXGetProcAddress('glColor3dv') );
    glColor3f := SYSTEM.VAL(TglColor3f , glXGetProcAddress('glColor3f') );
    glColor3fv := SYSTEM.VAL(TglColor3fv , glXGetProcAddress('glColor3fv') );
    glColor3i := SYSTEM.VAL(TglColor3i , glXGetProcAddress('glColor3i') );
    glColor3iv := SYSTEM.VAL(TglColor3iv , glXGetProcAddress('glColor3iv') );
    glColor3s := SYSTEM.VAL(TglColor3s , glXGetProcAddress('glColor3s') );
    glColor3sv := SYSTEM.VAL(TglColor3sv , glXGetProcAddress('glColor3sv') );
    glColor3ub := SYSTEM.VAL(TglColor3ub , glXGetProcAddress('glColor3ub') );
    glColor3ubv := SYSTEM.VAL(TglColor3ubv , glXGetProcAddress('glColor3ubv') );
    glColor3ui := SYSTEM.VAL(TglColor3ui , glXGetProcAddress('glColor3ui') );
    glColor3uiv := SYSTEM.VAL(TglColor3uiv , glXGetProcAddress('glColor3uiv') );
    glColor3us := SYSTEM.VAL(TglColor3us , glXGetProcAddress('glColor3us') );
    glColor3usv := SYSTEM.VAL(TglColor3usv , glXGetProcAddress('glColor3usv') );
    glColor4b := SYSTEM.VAL(TglColor4b , glXGetProcAddress('glColor4b') );
    glColor4bv := SYSTEM.VAL(TglColor4bv , glXGetProcAddress('glColor4bv') );
    glColor4d := SYSTEM.VAL(TglColor4d , glXGetProcAddress('glColor4d') );
    glColor4dv := SYSTEM.VAL(TglColor4dv , glXGetProcAddress('glColor4dv') );
 glColor4f := SYSTEM.VAL(TglColor4f, glXGetProcAddress('glColor4f'));
glColor4fv := SYSTEM.VAL(TglColor4fv, glXGetProcAddress('glColor4fv'));
glColor4i := SYSTEM.VAL(TglColor4i, glXGetProcAddress('glColor4i'));
glColor4iv := SYSTEM.VAL(TglColor4iv, glXGetProcAddress('glColor4iv'));
glColor4s := SYSTEM.VAL(TglColor4s, glXGetProcAddress('glColor4s'));
glColor4sv := SYSTEM.VAL(TglColor4sv, glXGetProcAddress('glColor4sv'));
glColor4ub := SYSTEM.VAL(TglColor4ub, glXGetProcAddress('glColor4ub'));
glColor4ubv := SYSTEM.VAL(TglColor4ubv, glXGetProcAddress('glColor4ubv'));
glColor4ui := SYSTEM.VAL(TglColor4ui, glXGetProcAddress('glColor4ui'));
glColor4uiv := SYSTEM.VAL(TglColor4uiv, glXGetProcAddress('glColor4uiv'));
glColor4us := SYSTEM.VAL(TglColor4us, glXGetProcAddress('glColor4us'));
glColor4usv := SYSTEM.VAL(TglColor4usv, glXGetProcAddress('glColor4usv'));
glColorMaterial := SYSTEM.VAL(TglColorMaterial, glXGetProcAddress('glColorMaterial'));
glColorPointer := SYSTEM.VAL(TglColorPointer, glXGetProcAddress('glColorPointer'));
glCopyPixels := SYSTEM.VAL(TglCopyPixels, glXGetProcAddress('glCopyPixels'));
glDeleteLists := SYSTEM.VAL(TglDeleteLists, glXGetProcAddress('glDeleteLists'));
glDisableClientState := SYSTEM.VAL(TglDisableClientState, glXGetProcAddress('glDisableClientState'));
glDrawPixels := SYSTEM.VAL(TglDrawPixels, glXGetProcAddress('glDrawPixels'));
glEdgeFlag := SYSTEM.VAL(TglEdgeFlag, glXGetProcAddress('glEdgeFlag'));
glEdgeFlagPointer := SYSTEM.VAL(TglEdgeFlagPointer, glXGetProcAddress('glEdgeFlagPointer'));
glEdgeFlagv := SYSTEM.VAL(TglEdgeFlagv, glXGetProcAddress('glEdgeFlagv'));
glEnableClientState := SYSTEM.VAL(TglEnableClientState, glXGetProcAddress('glEnableClientState'));
glEnd := SYSTEM.VAL(TglEnd, glXGetProcAddress('glEnd'));
glEndList := SYSTEM.VAL(TglEndList, glXGetProcAddress('glEndList'));
glEvalCoord1d := SYSTEM.VAL(TglEvalCoord1d, glXGetProcAddress('glEvalCoord1d'));
glEvalCoord1dv := SYSTEM.VAL(TglEvalCoord1dv, glXGetProcAddress('glEvalCoord1dv'));
glEvalCoord1f := SYSTEM.VAL(TglEvalCoord1f, glXGetProcAddress('glEvalCoord1f'));
glEvalCoord1fv := SYSTEM.VAL(TglEvalCoord1fv, glXGetProcAddress('glEvalCoord1fv'));
glEvalCoord2d := SYSTEM.VAL(TglEvalCoord2d, glXGetProcAddress('glEvalCoord2d'));
glEvalCoord2dv := SYSTEM.VAL(TglEvalCoord2dv, glXGetProcAddress('glEvalCoord2dv'));
glEvalCoord2f := SYSTEM.VAL(TglEvalCoord2f, glXGetProcAddress('glEvalCoord2f'));
glEvalCoord2fv := SYSTEM.VAL(TglEvalCoord2fv, glXGetProcAddress('glEvalCoord2fv'));
glEvalMesh1 := SYSTEM.VAL(TglEvalMesh1, glXGetProcAddress('glEvalMesh1'));
glEvalMesh2 := SYSTEM.VAL(TglEvalMesh2, glXGetProcAddress('glEvalMesh2'));
glEvalPoint1 := SYSTEM.VAL(TglEvalPoint1, glXGetProcAddress('glEvalPoint1'));
glEvalPoint2 := SYSTEM.VAL(TglEvalPoint2, glXGetProcAddress('glEvalPoint2'));
glFeedbackBuffer := SYSTEM.VAL(TglFeedbackBuffer, glXGetProcAddress('glFeedbackBuffer'));
glFogf := SYSTEM.VAL(TglFogf, glXGetProcAddress('glFogf'));
glFogfv := SYSTEM.VAL(TglFogfv, glXGetProcAddress('glFogfv'));
glFogi := SYSTEM.VAL(TglFogi, glXGetProcAddress('glFogi'));
glFogiv := SYSTEM.VAL(TglFogiv, glXGetProcAddress('glFogiv'));
glFrustum := SYSTEM.VAL(TglFrustum, glXGetProcAddress('glFrustum'));
glGenLists := SYSTEM.VAL(TglGenLists, glXGetProcAddress('glGenLists'));
glGetClipPlane := SYSTEM.VAL(TglGetClipPlane, glXGetProcAddress('glGetClipPlane'));
glGetLightfv := SYSTEM.VAL(TglGetLightfv, glXGetProcAddress('glGetLightfv'));
glGetLightiv := SYSTEM.VAL(TglGetLightiv, glXGetProcAddress('glGetLightiv'));
glGetMapdv := SYSTEM.VAL(TglGetMapdv, glXGetProcAddress('glGetMapdv'));
glGetMapfv := SYSTEM.VAL(TglGetMapfv, glXGetProcAddress('glGetMapfv'));
glGetMapiv := SYSTEM.VAL(TglGetMapiv, glXGetProcAddress('glGetMapiv'));
glGetMaterialfv := SYSTEM.VAL(TglGetMaterialfv, glXGetProcAddress('glGetMaterialfv'));
glGetMaterialiv := SYSTEM.VAL(TglGetMaterialiv, glXGetProcAddress('glGetMaterialiv'));
glGetPixelMapfv := SYSTEM.VAL(TglGetPixelMapfv, glXGetProcAddress('glGetPixelMapfv'));
glGetPixelMapuiv := SYSTEM.VAL(TglGetPixelMapuiv, glXGetProcAddress('glGetPixelMapuiv'));
glGetPixelMapusv := SYSTEM.VAL(TglGetPixelMapusv, glXGetProcAddress('glGetPixelMapusv'));
glGetPolygonStipple := SYSTEM.VAL(TglGetPolygonStipple, glXGetProcAddress('glGetPolygonStipple'));
glGetTexEnvfv := SYSTEM.VAL(TglGetTexEnvfv, glXGetProcAddress('glGetTexEnvfv'));
glGetTexEnviv := SYSTEM.VAL(TglGetTexEnviv, glXGetProcAddress('glGetTexEnviv'));
glGetTexGendv := SYSTEM.VAL(TglGetTexGendv, glXGetProcAddress('glGetTexGendv'));
glGetTexGenfv := SYSTEM.VAL(TglGetTexGenfv, glXGetProcAddress('glGetTexGenfv'));
glGetTexGeniv := SYSTEM.VAL(TglGetTexGeniv, glXGetProcAddress('glGetTexGeniv'));
glIndexMask := SYSTEM.VAL(TglIndexMask, glXGetProcAddress('glIndexMask'));
glIndexPointer := SYSTEM.VAL(TglIndexPointer, glXGetProcAddress('glIndexPointer'));
glIndexd := SYSTEM.VAL(TglIndexd, glXGetProcAddress('glIndexd'));
glIndexdv := SYSTEM.VAL(TglIndexdv, glXGetProcAddress('glIndexdv'));
glIndexf := SYSTEM.VAL(TglIndexf, glXGetProcAddress('glIndexf'));
glIndexfv := SYSTEM.VAL(TglIndexfv, glXGetProcAddress('glIndexfv'));
glIndexi := SYSTEM.VAL(TglIndexi, glXGetProcAddress('glIndexi'));
glIndexiv := SYSTEM.VAL(TglIndexiv, glXGetProcAddress('glIndexiv'));
glIndexs := SYSTEM.VAL(TglIndexs, glXGetProcAddress('glIndexs'));
glIndexsv := SYSTEM.VAL(TglIndexsv, glXGetProcAddress('glIndexsv'));
glIndexub := SYSTEM.VAL(TglIndexub, glXGetProcAddress('glIndexub'));
glIndexubv := SYSTEM.VAL(TglIndexubv, glXGetProcAddress('glIndexubv'));
glInitNames := SYSTEM.VAL(TglInitNames, glXGetProcAddress('glInitNames'));
glInterleavedArrays := SYSTEM.VAL(TglInterleavedArrays, glXGetProcAddress('glInterleavedArrays'));
glIsList := SYSTEM.VAL(TglIsList, glXGetProcAddress('glIsList'));
glIsTexture := SYSTEM.VAL(TglIsTexture, glXGetProcAddress('glIsTexture'));
glLightModelf := SYSTEM.VAL(TglLightModelf, glXGetProcAddress('glLightModelf'));
glLightModelfv := SYSTEM.VAL(TglLightModelfv, glXGetProcAddress('glLightModelfv'));
glLightModeli := SYSTEM.VAL(TglLightModeli, glXGetProcAddress('glLightModeli'));
glLightModeliv := SYSTEM.VAL(TglLightModeliv, glXGetProcAddress('glLightModeliv'));
glLightf := SYSTEM.VAL(TglLightf, glXGetProcAddress('glLightf'));
glLightfv := SYSTEM.VAL(TglLightfv, glXGetProcAddress('glLightfv'));
glLighti := SYSTEM.VAL(TglLighti, glXGetProcAddress('glLighti'));
glLightiv := SYSTEM.VAL(TglLightiv, glXGetProcAddress('glLightiv'));
glLineStipple := SYSTEM.VAL(TglLineStipple, glXGetProcAddress('glLineStipple'));
glListBase := SYSTEM.VAL(TglListBase, glXGetProcAddress('glListBase'));
glLoadIdentity := SYSTEM.VAL(TglLoadIdentity, glXGetProcAddress('glLoadIdentity'));
glLoadMatrixd := SYSTEM.VAL(TglLoadMatrixd, glXGetProcAddress('glLoadMatrixd'));
glLoadMatrixf := SYSTEM.VAL(TglLoadMatrixf, glXGetProcAddress('glLoadMatrixf'));
glLoadName := SYSTEM.VAL(TglLoadName, glXGetProcAddress('glLoadName'));
glMap1d := SYSTEM.VAL(TglMap1d, glXGetProcAddress('glMap1d'));
glMap1f := SYSTEM.VAL(TglMap1f, glXGetProcAddress('glMap1f'));
glMap2d := SYSTEM.VAL(TglMap2d, glXGetProcAddress('glMap2d'));
glMap2f := SYSTEM.VAL(TglMap2f, glXGetProcAddress('glMap2f'));
glMapGrid1d := SYSTEM.VAL(TglMapGrid1d, glXGetProcAddress('glMapGrid1d'));
glMapGrid1f := SYSTEM.VAL(TglMapGrid1f, glXGetProcAddress('glMapGrid1f'));
glMapGrid2d := SYSTEM.VAL(TglMapGrid2d, glXGetProcAddress('glMapGrid2d'));
glMapGrid2f := SYSTEM.VAL(TglMapGrid2f, glXGetProcAddress('glMapGrid2f'));
glMaterialf := SYSTEM.VAL(TglMaterialf, glXGetProcAddress('glMaterialf'));
glMaterialfv := SYSTEM.VAL(TglMaterialfv, glXGetProcAddress('glMaterialfv'));
glMateriali := SYSTEM.VAL(TglMateriali, glXGetProcAddress('glMateriali'));
glMaterialiv := SYSTEM.VAL(TglMaterialiv, glXGetProcAddress('glMaterialiv'));
glMatrixMode := SYSTEM.VAL(TglMatrixMode, glXGetProcAddress('glMatrixMode'));
glMultMatrixd := SYSTEM.VAL(TglMultMatrixd, glXGetProcAddress('glMultMatrixd'));
glMultMatrixf := SYSTEM.VAL(TglMultMatrixf, glXGetProcAddress('glMultMatrixf'));
glNewList := SYSTEM.VAL(TglNewList, glXGetProcAddress('glNewList'));
glNormal3b := SYSTEM.VAL(TglNormal3b, glXGetProcAddress('glNormal3b'));
glNormal3bv := SYSTEM.VAL(TglNormal3bv, glXGetProcAddress('glNormal3bv'));
glNormal3d := SYSTEM.VAL(TglNormal3d, glXGetProcAddress('glNormal3d'));
glNormal3dv := SYSTEM.VAL(TglNormal3dv, glXGetProcAddress('glNormal3dv'));
glNormal3f := SYSTEM.VAL(TglNormal3f, glXGetProcAddress('glNormal3f'));
glNormal3fv := SYSTEM.VAL(TglNormal3fv, glXGetProcAddress('glNormal3fv'));
glNormal3i := SYSTEM.VAL(TglNormal3i, glXGetProcAddress('glNormal3i'));
glNormal3iv := SYSTEM.VAL(TglNormal3iv, glXGetProcAddress('glNormal3iv'));
glNormal3s := SYSTEM.VAL(TglNormal3s, glXGetProcAddress('glNormal3s'));
glNormal3sv := SYSTEM.VAL(TglNormal3sv, glXGetProcAddress('glNormal3sv'));
glNormalPointer := SYSTEM.VAL(TglNormalPointer, glXGetProcAddress('glNormalPointer'));
glOrtho := SYSTEM.VAL(TglOrtho, glXGetProcAddress('glOrtho'));
glPassThrough := SYSTEM.VAL(TglPassThrough, glXGetProcAddress('glPassThrough'));
glPixelMapfv := SYSTEM.VAL(TglPixelMapfv, glXGetProcAddress('glPixelMapfv'));
glPixelMapuiv := SYSTEM.VAL(TglPixelMapuiv, glXGetProcAddress('glPixelMapuiv'));
glPixelMapusv := SYSTEM.VAL(TglPixelMapusv, glXGetProcAddress('glPixelMapusv'));
glPixelTransferf := SYSTEM.VAL(TglPixelTransferf, glXGetProcAddress('glPixelTransferf'));
glPixelTransferi := SYSTEM.VAL(TglPixelTransferi, glXGetProcAddress('glPixelTransferi'));
glPixelZoom := SYSTEM.VAL(TglPixelZoom, glXGetProcAddress('glPixelZoom'));
glPolygonStipple := SYSTEM.VAL(TglPolygonStipple, glXGetProcAddress('glPolygonStipple'));
glPopAttrib := SYSTEM.VAL(TglPopAttrib, glXGetProcAddress('glPopAttrib'));
glPopClientAttrib := SYSTEM.VAL(TglPopClientAttrib, glXGetProcAddress('glPopClientAttrib'));
glPopMatrix := SYSTEM.VAL(TglPopMatrix, glXGetProcAddress('glPopMatrix'));
glPopName := SYSTEM.VAL(TglPopName, glXGetProcAddress('glPopName'));
glPrioritizeTextures := SYSTEM.VAL(TglPrioritizeTextures, glXGetProcAddress('glPrioritizeTextures'));
glPushAttrib := SYSTEM.VAL(TglPushAttrib, glXGetProcAddress('glPushAttrib'));
glPushClientAttrib := SYSTEM.VAL(TglPushClientAttrib, glXGetProcAddress('glPushClientAttrib'));
glPushMatrix := SYSTEM.VAL(TglPushMatrix, glXGetProcAddress('glPushMatrix'));
glPushName := SYSTEM.VAL(TglPushName, glXGetProcAddress('glPushName'));
glRasterPos2d := SYSTEM.VAL(TglRasterPos2d, glXGetProcAddress('glRasterPos2d'));
glRasterPos2dv := SYSTEM.VAL(TglRasterPos2dv, glXGetProcAddress('glRasterPos2dv'));
glRasterPos2f := SYSTEM.VAL(TglRasterPos2f, glXGetProcAddress('glRasterPos2f'));
glRasterPos2fv := SYSTEM.VAL(TglRasterPos2fv, glXGetProcAddress('glRasterPos2fv'));
glRasterPos2i := SYSTEM.VAL(TglRasterPos2i, glXGetProcAddress('glRasterPos2i'));
glRasterPos2iv := SYSTEM.VAL(TglRasterPos2iv, glXGetProcAddress('glRasterPos2iv'));
glRasterPos2s := SYSTEM.VAL(TglRasterPos2s, glXGetProcAddress('glRasterPos2s'));
glRasterPos2sv := SYSTEM.VAL(TglRasterPos2sv, glXGetProcAddress('glRasterPos2sv'));
glRasterPos3d := SYSTEM.VAL(TglRasterPos3d, glXGetProcAddress('glRasterPos3d'));
glRasterPos3dv := SYSTEM.VAL(TglRasterPos3dv, glXGetProcAddress('glRasterPos3dv'));
glRasterPos3f := SYSTEM.VAL(TglRasterPos3f, glXGetProcAddress('glRasterPos3f'));
glRasterPos3fv := SYSTEM.VAL(TglRasterPos3fv, glXGetProcAddress('glRasterPos3fv'));
glRasterPos3i := SYSTEM.VAL(TglRasterPos3i, glXGetProcAddress('glRasterPos3i'));
glRasterPos3iv := SYSTEM.VAL(TglRasterPos3iv, glXGetProcAddress('glRasterPos3iv'));
glRasterPos3s := SYSTEM.VAL(TglRasterPos3s, glXGetProcAddress('glRasterPos3s'));
glRasterPos3sv := SYSTEM.VAL(TglRasterPos3sv, glXGetProcAddress('glRasterPos3sv'));
glRasterPos4d := SYSTEM.VAL(TglRasterPos4d, glXGetProcAddress('glRasterPos4d'));
glRasterPos4dv := SYSTEM.VAL(TglRasterPos4dv, glXGetProcAddress('glRasterPos4dv'));
glRasterPos4f := SYSTEM.VAL(TglRasterPos4f, glXGetProcAddress('glRasterPos4f'));
glRasterPos4fv := SYSTEM.VAL(TglRasterPos4fv, glXGetProcAddress('glRasterPos4fv'));
glRasterPos4i := SYSTEM.VAL(TglRasterPos4i, glXGetProcAddress('glRasterPos4i'));
glRasterPos4iv := SYSTEM.VAL(TglRasterPos4iv, glXGetProcAddress('glRasterPos4iv'));
glRasterPos4s := SYSTEM.VAL(TglRasterPos4s, glXGetProcAddress('glRasterPos4s'));
glRasterPos4sv := SYSTEM.VAL(TglRasterPos4sv, glXGetProcAddress('glRasterPos4sv'));
glRectd := SYSTEM.VAL(TglRectd, glXGetProcAddress('glRectd'));
glRectdv := SYSTEM.VAL(TglRectdv, glXGetProcAddress('glRectdv'));
glRectf := SYSTEM.VAL(TglRectf, glXGetProcAddress('glRectf'));
glRectfv := SYSTEM.VAL(TglRectfv, glXGetProcAddress('glRectfv'));
glRecti := SYSTEM.VAL(TglRecti, glXGetProcAddress('glRecti'));
glRectiv := SYSTEM.VAL(TglRectiv, glXGetProcAddress('glRectiv'));
glRects := SYSTEM.VAL(TglRects, glXGetProcAddress('glRects'));
glRectsv := SYSTEM.VAL(TglRectsv, glXGetProcAddress('glRectsv'));
glRenderMode := SYSTEM.VAL(TglRenderMode, glXGetProcAddress('glRenderMode'));
glRotated := SYSTEM.VAL(TglRotated, glXGetProcAddress('glRotated'));
glRotatef := SYSTEM.VAL(TglRotatef, glXGetProcAddress('glRotatef'));
glScaled := SYSTEM.VAL(TglScaled, glXGetProcAddress('glScaled'));
glScalef := SYSTEM.VAL(TglScalef, glXGetProcAddress('glScalef'));
glSelectBuffer := SYSTEM.VAL(TglSelectBuffer, glXGetProcAddress('glSelectBuffer'));
glShadeModel := SYSTEM.VAL(TglShadeModel, glXGetProcAddress('glShadeModel'));
glTexCoord1d := SYSTEM.VAL(TglTexCoord1d, glXGetProcAddress('glTexCoord1d'));
glTexCoord1dv := SYSTEM.VAL(TglTexCoord1dv, glXGetProcAddress('glTexCoord1dv'));
glTexCoord1f := SYSTEM.VAL(TglTexCoord1f, glXGetProcAddress('glTexCoord1f'));
glTexCoord1fv := SYSTEM.VAL(TglTexCoord1fv, glXGetProcAddress('glTexCoord1fv'));
glTexCoord1i := SYSTEM.VAL(TglTexCoord1i, glXGetProcAddress('glTexCoord1i'));
glTexCoord1iv := SYSTEM.VAL(TglTexCoord1iv, glXGetProcAddress('glTexCoord1iv'));
glTexCoord1s := SYSTEM.VAL(TglTexCoord1s, glXGetProcAddress('glTexCoord1s'));
glTexCoord1sv := SYSTEM.VAL(TglTexCoord1sv, glXGetProcAddress('glTexCoord1sv'));
glTexCoord2d := SYSTEM.VAL(TglTexCoord2d, glXGetProcAddress('glTexCoord2d'));
glTexCoord2dv := SYSTEM.VAL(TglTexCoord2dv, glXGetProcAddress('glTexCoord2dv'));
glTexCoord2f := SYSTEM.VAL(TglTexCoord2f, glXGetProcAddress('glTexCoord2f'));
glTexCoord2fv := SYSTEM.VAL(TglTexCoord2fv, glXGetProcAddress('glTexCoord2fv'));
glTexCoord2i := SYSTEM.VAL(TglTexCoord2i, glXGetProcAddress('glTexCoord2i'));
glTexCoord2iv := SYSTEM.VAL(TglTexCoord2iv, glXGetProcAddress('glTexCoord2iv'));
glTexCoord2s := SYSTEM.VAL(TglTexCoord2s, glXGetProcAddress('glTexCoord2s'));
glTexCoord2sv := SYSTEM.VAL(TglTexCoord2sv, glXGetProcAddress('glTexCoord2sv'));
glTexCoord3d := SYSTEM.VAL(TglTexCoord3d, glXGetProcAddress('glTexCoord3d'));
glTexCoord3dv := SYSTEM.VAL(TglTexCoord3dv, glXGetProcAddress('glTexCoord3dv'));
glTexCoord3f := SYSTEM.VAL(TglTexCoord3f, glXGetProcAddress('glTexCoord3f'));
glTexCoord3fv := SYSTEM.VAL(TglTexCoord3fv, glXGetProcAddress('glTexCoord3fv'));
glTexCoord3i := SYSTEM.VAL(TglTexCoord3i, glXGetProcAddress('glTexCoord3i'));
glTexCoord3iv := SYSTEM.VAL(TglTexCoord3iv, glXGetProcAddress('glTexCoord3iv'));
glTexCoord3s := SYSTEM.VAL(TglTexCoord3s, glXGetProcAddress('glTexCoord3s'));
glTexCoord3sv := SYSTEM.VAL(TglTexCoord3sv, glXGetProcAddress('glTexCoord3sv'));
glTexCoord4d := SYSTEM.VAL(TglTexCoord4d, glXGetProcAddress('glTexCoord4d'));
glTexCoord4dv := SYSTEM.VAL(TglTexCoord4dv, glXGetProcAddress('glTexCoord4dv'));
glTexCoord4f := SYSTEM.VAL(TglTexCoord4f, glXGetProcAddress('glTexCoord4f'));
glTexCoord4fv := SYSTEM.VAL(TglTexCoord4fv, glXGetProcAddress('glTexCoord4fv'));
glTexCoord4i := SYSTEM.VAL(TglTexCoord4i, glXGetProcAddress('glTexCoord4i'));
glTexCoord4iv := SYSTEM.VAL(TglTexCoord4iv, glXGetProcAddress('glTexCoord4iv'));
glTexCoord4s := SYSTEM.VAL(TglTexCoord4s, glXGetProcAddress('glTexCoord4s'));
glTexCoord4sv := SYSTEM.VAL(TglTexCoord4sv, glXGetProcAddress('glTexCoord4sv'));
glTexCoordPointer := SYSTEM.VAL(TglTexCoordPointer, glXGetProcAddress('glTexCoordPointer'));
glTexEnvf := SYSTEM.VAL(TglTexEnvf, glXGetProcAddress('glTexEnvf'));
glTexEnvfv := SYSTEM.VAL(TglTexEnvfv, glXGetProcAddress('glTexEnvfv'));
glTexEnvi := SYSTEM.VAL(TglTexEnvi, glXGetProcAddress('glTexEnvi'));
glTexEnviv := SYSTEM.VAL(TglTexEnviv, glXGetProcAddress('glTexEnviv'));
glTexGend := SYSTEM.VAL(TglTexGend, glXGetProcAddress('glTexGend'));
glTexGendv := SYSTEM.VAL(TglTexGendv, glXGetProcAddress('glTexGendv'));
glTexGenf := SYSTEM.VAL(TglTexGenf, glXGetProcAddress('glTexGenf'));
glTexGenfv := SYSTEM.VAL(TglTexGenfv, glXGetProcAddress('glTexGenfv'));
glTexGeni := SYSTEM.VAL(TglTexGeni, glXGetProcAddress('glTexGeni'));
glTexGeniv := SYSTEM.VAL(TglTexGeniv, glXGetProcAddress('glTexGeniv'));
glTranslated := SYSTEM.VAL(TglTranslated, glXGetProcAddress('glTranslated'));
glTranslatef := SYSTEM.VAL(TglTranslatef, glXGetProcAddress('glTranslatef'));
glVertex2d := SYSTEM.VAL(TglVertex2d, glXGetProcAddress('glVertex2d'));
glVertex2dv := SYSTEM.VAL(TglVertex2dv, glXGetProcAddress('glVertex2dv'));
glVertex2f := SYSTEM.VAL(TglVertex2f, glXGetProcAddress('glVertex2f'));
glVertex2fv := SYSTEM.VAL(TglVertex2fv, glXGetProcAddress('glVertex2fv'));
glVertex2i := SYSTEM.VAL(TglVertex2i, glXGetProcAddress('glVertex2i'));
glVertex2iv := SYSTEM.VAL(TglVertex2iv, glXGetProcAddress('glVertex2iv'));
glVertex2s := SYSTEM.VAL(TglVertex2s, glXGetProcAddress('glVertex2s'));
glVertex2sv := SYSTEM.VAL(TglVertex2sv, glXGetProcAddress('glVertex2sv'));
glVertex3d := SYSTEM.VAL(TglVertex3d, glXGetProcAddress('glVertex3d'));
glVertex3dv := SYSTEM.VAL(TglVertex3dv, glXGetProcAddress('glVertex3dv'));
glVertex3f := SYSTEM.VAL(TglVertex3f, glXGetProcAddress('glVertex3f'));
glVertex3fv := SYSTEM.VAL(TglVertex3fv, glXGetProcAddress('glVertex3fv'));
glVertex3i := SYSTEM.VAL(TglVertex3i, glXGetProcAddress('glVertex3i'));
glVertex3iv := SYSTEM.VAL(TglVertex3iv, glXGetProcAddress('glVertex3iv'));
glVertex3s := SYSTEM.VAL(TglVertex3s, glXGetProcAddress('glVertex3s'));
glVertex3sv := SYSTEM.VAL(TglVertex3sv, glXGetProcAddress('glVertex3sv'));
glVertex4d := SYSTEM.VAL(TglVertex4d, glXGetProcAddress('glVertex4d'));
glVertex4dv := SYSTEM.VAL(TglVertex4dv, glXGetProcAddress('glVertex4dv'));
glVertex4f := SYSTEM.VAL(TglVertex4f, glXGetProcAddress('glVertex4f'));
glVertex4fv := SYSTEM.VAL(TglVertex4fv, glXGetProcAddress('glVertex4fv'));
glVertex4i := SYSTEM.VAL(TglVertex4i, glXGetProcAddress('glVertex4i'));
glVertex4iv := SYSTEM.VAL(TglVertex4iv, glXGetProcAddress('glVertex4iv'));
glVertex4s := SYSTEM.VAL(TglVertex4s, glXGetProcAddress('glVertex4s'));
glVertex4sv := SYSTEM.VAL(TglVertex4sv, glXGetProcAddress('glVertex4sv'));
glVertexPointer := SYSTEM.VAL(TglVertexPointer, glXGetProcAddress('glVertexPointer'));
(* endif *)

      Trace.String(GL_LibName); Trace.StringLn(" loaded."); 
  END;

  (* load GLU functions *)
  IF GLU_LibHandle # 0 THEN
    (* GLU ======================================================================== *)
     Unix.Dlsym(GLU_LibHandle,  'gluBeginCurve', SYSTEM.VAL(ADDRESS, gluBeginCurve ));
     Unix.Dlsym(GLU_LibHandle,  'gluBeginPolygon', SYSTEM.VAL(ADDRESS, gluBeginPolygon ));
     Unix.Dlsym(GLU_LibHandle,  'gluBeginSurface', SYSTEM.VAL(ADDRESS, gluBeginSurface ));
     Unix.Dlsym(GLU_LibHandle,  'gluBeginTrim', SYSTEM.VAL(ADDRESS,  gluBeginTrim));
     Unix.Dlsym(GLU_LibHandle,  'gluBuild1DMipmaps', SYSTEM.VAL(ADDRESS, gluBuild1DMipmaps ));
     Unix.Dlsym(GLU_LibHandle,  'gluBuild2DMipmaps', SYSTEM.VAL(ADDRESS, gluBuild2DMipmaps ));
     Unix.Dlsym(GLU_LibHandle,  'gluCylinder', SYSTEM.VAL(ADDRESS, gluCylinder ));
     Unix.Dlsym(GLU_LibHandle,  'gluDeleteNurbsRenderer', SYSTEM.VAL(ADDRESS, gluDeleteNurbsRenderer ));
     Unix.Dlsym(GLU_LibHandle,  'gluDeleteQuadric', SYSTEM.VAL(ADDRESS, gluDeleteQuadric ));
     Unix.Dlsym(GLU_LibHandle,  'gluDeleteTess', SYSTEM.VAL(ADDRESS, gluDeleteTess ));
     Unix.Dlsym(GLU_LibHandle,  'gluDisk', SYSTEM.VAL(ADDRESS, gluDisk ));
     Unix.Dlsym(GLU_LibHandle,  'gluEndCurve', SYSTEM.VAL(ADDRESS, gluEndCurve ));
     Unix.Dlsym(GLU_LibHandle,  'gluEndPolygon', SYSTEM.VAL(ADDRESS, gluEndPolygon ));
     Unix.Dlsym(GLU_LibHandle,  'gluEndSurface', SYSTEM.VAL(ADDRESS, gluEndSurface ));
     Unix.Dlsym(GLU_LibHandle,  'gluEndTrim', SYSTEM.VAL(ADDRESS, gluEndTrim ));
     Unix.Dlsym(GLU_LibHandle,  'gluErrorString', SYSTEM.VAL(ADDRESS, gluErrorString ));
     Unix.Dlsym(GLU_LibHandle,  'gluGetNurbsProperty', SYSTEM.VAL(ADDRESS, gluGetNurbsProperty ));
     Unix.Dlsym(GLU_LibHandle,  'gluGetString', SYSTEM.VAL(ADDRESS, gluGetString ));
     Unix.Dlsym(GLU_LibHandle,  'gluGetTessProperty', SYSTEM.VAL(ADDRESS, gluGetTessProperty ));
     Unix.Dlsym(GLU_LibHandle,  'gluLoadSamplingMatrices', SYSTEM.VAL(ADDRESS, gluLoadSamplingMatrices ));
     Unix.Dlsym(GLU_LibHandle,  'gluLookAt', SYSTEM.VAL(ADDRESS, gluLookAt ));
     Unix.Dlsym(GLU_LibHandle,  'gluNewNurbsRenderer', SYSTEM.VAL(ADDRESS, gluNewNurbsRenderer ));
     Unix.Dlsym(GLU_LibHandle,  'gluNewQuadric', SYSTEM.VAL(ADDRESS, gluNewQuadric ));
     Unix.Dlsym(GLU_LibHandle,  'gluNewTess', SYSTEM.VAL(ADDRESS, gluNewTess ));
     Unix.Dlsym(GLU_LibHandle,  'gluNextContour', SYSTEM.VAL(ADDRESS, gluNextContour ));
     Unix.Dlsym(GLU_LibHandle,  'gluNurbsCallback', SYSTEM.VAL(ADDRESS, gluNurbsCallback ));
     Unix.Dlsym(GLU_LibHandle,  'gluNurbsCurve', SYSTEM.VAL(ADDRESS, gluNurbsCurve ));
     Unix.Dlsym(GLU_LibHandle,  'gluNurbsProperty', SYSTEM.VAL(ADDRESS, gluNurbsProperty ));
     Unix.Dlsym(GLU_LibHandle,  'gluNurbsSurface', SYSTEM.VAL(ADDRESS, gluNurbsSurface ));
     Unix.Dlsym(GLU_LibHandle,  'gluOrtho2D', SYSTEM.VAL(ADDRESS, gluOrtho2D ));
     Unix.Dlsym(GLU_LibHandle,  'gluPartialDisk', SYSTEM.VAL(ADDRESS, gluPartialDisk ));
     Unix.Dlsym(GLU_LibHandle,  'gluPerspective', SYSTEM.VAL(ADDRESS, gluPerspective ));
     Unix.Dlsym(GLU_LibHandle,  'gluPickMatrix', SYSTEM.VAL(ADDRESS, gluPickMatrix ));
     Unix.Dlsym(GLU_LibHandle,  'gluProject', SYSTEM.VAL(ADDRESS, gluProject ));
     Unix.Dlsym(GLU_LibHandle,  'gluPwlCurve', SYSTEM.VAL(ADDRESS, gluPwlCurve ));
     Unix.Dlsym(GLU_LibHandle,  'gluQuadricCallback', SYSTEM.VAL(ADDRESS, gluQuadricCallback ));
     Unix.Dlsym(GLU_LibHandle,  'gluQuadricDrawStyle', SYSTEM.VAL(ADDRESS, gluQuadricDrawStyle ));
     Unix.Dlsym(GLU_LibHandle,  'gluQuadricNormals', SYSTEM.VAL(ADDRESS, gluQuadricNormals ));
     Unix.Dlsym(GLU_LibHandle,  'gluQuadricOrientation', SYSTEM.VAL(ADDRESS, gluQuadricOrientation ));
     Unix.Dlsym(GLU_LibHandle,  'gluQuadricTexture', SYSTEM.VAL(ADDRESS, gluQuadricTexture ));
     Unix.Dlsym(GLU_LibHandle,  'gluScaleImage', SYSTEM.VAL(ADDRESS, gluScaleImage ));
     Unix.Dlsym(GLU_LibHandle,  'gluSphere', SYSTEM.VAL(ADDRESS, gluSphere ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessBeginContour', SYSTEM.VAL(ADDRESS, gluTessBeginContour ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessBeginPolygon', SYSTEM.VAL(ADDRESS, gluTessBeginPolygon ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessCallback', SYSTEM.VAL(ADDRESS, gluTessCallback ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessEndContour', SYSTEM.VAL(ADDRESS, gluTessEndContour ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessEndPolygon', SYSTEM.VAL(ADDRESS, gluTessEndPolygon ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessNormal', SYSTEM.VAL(ADDRESS, gluTessNormal ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessProperty', SYSTEM.VAL(ADDRESS, gluTessProperty ));
     Unix.Dlsym(GLU_LibHandle,  'gluTessVertex', SYSTEM.VAL(ADDRESS, gluTessVertex ));
     Unix.Dlsym(GLU_LibHandle,  'gluUnProject', SYSTEM.VAL(ADDRESS, gluUnProject ));
     
      Trace.String(GLU_LibName); Trace.StringLn(" loaded.");  

  END;
END InitOpenGL;


PROCEDURE ReadOpenGLCore*;
BEGIN
  Trace.String(" ReadOpenGLCore .."); 	

  (* GL_VERSION_1_2 *)
    glBlendColor := SYSTEM.VAL(TglBlendColor, glXGetProcAddress('glBlendColor')); 
    glBlendEquation := SYSTEM.VAL(TglBlendEquation, glXGetProcAddress('glBlendEquation'));
    glDrawRangeElements := SYSTEM.VAL(TglDrawRangeElements, glXGetProcAddress('glDrawRangeElements'));
    glTexImage3D := SYSTEM.VAL( TglTexImage3D, glXGetProcAddress('glTexImage3D'));
    glTexSubImage3D := SYSTEM.VAL(TglTexSubImage3D, glXGetProcAddress('glTexSubImage3D'));
    glCopyTexSubImage3D := SYSTEM.VAL(TglCopyTexSubImage3D, glXGetProcAddress('glCopyTexSubImage3D'));

  (* GL_VERSION_1_3 *)
   glActiveTexture := SYSTEM.VAL( TglActiveTexture, glXGetProcAddress('glActiveTexture'));
   glSampleCoverage := SYSTEM.VAL(TglSampleCoverage, glXGetProcAddress('glSampleCoverage'));
   glCompressedTexImage3D := SYSTEM.VAL(TglCompressedTexImage3D, glXGetProcAddress('glCompressedTexImage3D'));
   glCompressedTexImage2D := SYSTEM.VAL(TglCompressedTexImage2D, glXGetProcAddress('glCompressedTexImage2D'));
   glCompressedTexImage1D := SYSTEM.VAL(TglCompressedTexImage1D, glXGetProcAddress('glCompressedTexImage1D'));
   glCompressedTexSubImage3D := SYSTEM.VAL(TglCompressedTexSubImage3D, glXGetProcAddress('glCompressedTexSubImage3D'));
   glCompressedTexSubImage2D := SYSTEM.VAL(TglCompressedTexSubImage2D, glXGetProcAddress('glCompressedTexSubImage2D'));
   glCompressedTexSubImage1D := SYSTEM.VAL(TglCompressedTexSubImage1D, glXGetProcAddress('glCompressedTexSubImage1D'));
   glGetCompressedTexImage := SYSTEM.VAL(TglGetCompressedTexImage, glXGetProcAddress('glGetCompressedTexImage'));

  (* GL_VERSION_1_4 *)
   glBlendFuncSeparate := SYSTEM.VAL(TglBlendFuncSeparate  , glXGetProcAddress('glBlendFuncSeparate'));
   glMultiDrawArrays := SYSTEM.VAL(TglMultiDrawArrays  , glXGetProcAddress('glMultiDrawArrays'));
   glMultiDrawElements := SYSTEM.VAL(TglMultiDrawElements  , glXGetProcAddress('glMultiDrawElements'));
   glPointParameterf := SYSTEM.VAL(TglPointParameterf  , glXGetProcAddress('glPointParameterf'));
   glPointParameterfv := SYSTEM.VAL(TglPointParameterfv  , glXGetProcAddress('glPointParameterfv'));
   glPointParameteri := SYSTEM.VAL(TglPointParameteri  , glXGetProcAddress('glPointParameteri'));
   glPointParameteriv := SYSTEM.VAL(TglPointParameteriv  , glXGetProcAddress('glPointParameteriv'));

  (* GL_VERSION_1_5 *)
   glGenQueries := SYSTEM.VAL(TglGenQueries  , glXGetProcAddress('glGenQueries'));
   glDeleteQueries := SYSTEM.VAL(TglDeleteQueries  , glXGetProcAddress('glDeleteQueries'));
   glIsQuery := SYSTEM.VAL(TglIsQuery  , glXGetProcAddress('glIsQuery'));
   glBeginQuery := SYSTEM.VAL(TglBeginQuery  , glXGetProcAddress('glBeginQuery'));
   glEndQuery := SYSTEM.VAL(TglEndQuery  , glXGetProcAddress('glEndQuery'));
   glGetQueryiv := SYSTEM.VAL(TglGetQueryiv  , glXGetProcAddress('glGetQueryiv'));
   glGetQueryObjectiv := SYSTEM.VAL(TglGetQueryObjectiv  , glXGetProcAddress('glGetQueryObjectiv'));
   glGetQueryObjectuiv := SYSTEM.VAL(TglGetQueryObjectuiv  , glXGetProcAddress('glGetQueryObjectuiv'));
   glBindBuffer := SYSTEM.VAL(TglBindBuffer  , glXGetProcAddress('glBindBuffer'));
   glDeleteBuffers := SYSTEM.VAL(TglDeleteBuffers  , glXGetProcAddress('glDeleteBuffers'));
   glGenBuffers := SYSTEM.VAL(TglGenBuffers  , glXGetProcAddress('glGenBuffers'));
   glIsBuffer := SYSTEM.VAL(TglIsBuffer  , glXGetProcAddress('glIsBuffer'));
   glBufferData := SYSTEM.VAL(TglBufferData  , glXGetProcAddress('glBufferData'));
   glBufferSubData := SYSTEM.VAL(TglBufferSubData  , glXGetProcAddress('glBufferSubData'));
   glGetBufferSubData := SYSTEM.VAL(TglGetBufferSubData  , glXGetProcAddress('glGetBufferSubData'));
   glMapBuffer := SYSTEM.VAL(TglMapBuffer  , glXGetProcAddress('glMapBuffer'));
   glUnmapBuffer := SYSTEM.VAL(TglUnmapBuffer  , glXGetProcAddress('glUnmapBuffer'));
   glGetBufferParameteriv := SYSTEM.VAL(TglGetBufferParameteriv  , glXGetProcAddress('glGetBufferParameteriv'));
   glGetBufferPointerv := SYSTEM.VAL(TglGetBufferPointerv  , glXGetProcAddress('glGetBufferPointerv'));

  (* GL_VERSION_2_0 *)
   glBlendEquationSeparate := SYSTEM.VAL(TglBlendEquationSeparate  , glXGetProcAddress('glBlendEquationSeparate'));
   glDrawBuffers := SYSTEM.VAL(TglDrawBuffers  , glXGetProcAddress('glDrawBuffers'));
   glStencilOpSeparate := SYSTEM.VAL(TglStencilOpSeparate  , glXGetProcAddress('glStencilOpSeparate'));
   glStencilFuncSeparate := SYSTEM.VAL(TglStencilFuncSeparate  , glXGetProcAddress('glStencilFuncSeparate'));
   glStencilMaskSeparate := SYSTEM.VAL(TglStencilMaskSeparate  , glXGetProcAddress('glStencilMaskSeparate'));
   glAttachShader := SYSTEM.VAL(TglAttachShader  , glXGetProcAddress('glAttachShader'));
   glBindAttribLocation := SYSTEM.VAL(TglBindAttribLocation  , glXGetProcAddress('glBindAttribLocation'));
   glCompileShader := SYSTEM.VAL(TglCompileShader  , glXGetProcAddress('glCompileShader'));
   glCreateProgram := SYSTEM.VAL(TglCreateProgram  , glXGetProcAddress('glCreateProgram'));
   glCreateShader := SYSTEM.VAL(TglCreateShader  , glXGetProcAddress('glCreateShader'));
   glDeleteProgram := SYSTEM.VAL(TglDeleteProgram  , glXGetProcAddress('glDeleteProgram'));
   glDeleteShader := SYSTEM.VAL(TglDeleteShader  , glXGetProcAddress('glDeleteShader'));
   glDetachShader := SYSTEM.VAL(TglDetachShader  , glXGetProcAddress('glDetachShader'));
   glDisableVertexAttribArray := SYSTEM.VAL(TglDisableVertexAttribArray  , glXGetProcAddress('glDisableVertexAttribArray'));
   glEnableVertexAttribArray := SYSTEM.VAL(TglEnableVertexAttribArray  , glXGetProcAddress('glEnableVertexAttribArray'));
   glGetActiveAttrib := SYSTEM.VAL(TglGetActiveAttrib  , glXGetProcAddress('glGetActiveAttrib'));
   glGetActiveUniform := SYSTEM.VAL(TglGetActiveUniform  , glXGetProcAddress('glGetActiveUniform'));
   glGetAttachedShaders := SYSTEM.VAL(TglGetAttachedShaders  , glXGetProcAddress('glGetAttachedShaders'));
   glGetAttribLocation := SYSTEM.VAL(TglGetAttribLocation  , glXGetProcAddress('glGetAttribLocation'));
   glGetProgramiv := SYSTEM.VAL(TglGetProgramiv  , glXGetProcAddress('glGetProgramiv'));
   glGetProgramInfoLog := SYSTEM.VAL(TglGetProgramInfoLog  , glXGetProcAddress('glGetProgramInfoLog'));
   glGetShaderiv := SYSTEM.VAL(TglGetShaderiv  , glXGetProcAddress('glGetShaderiv'));
   glGetShaderInfoLog := SYSTEM.VAL(TglGetShaderInfoLog  , glXGetProcAddress('glGetShaderInfoLog'));
   glGetShaderSource := SYSTEM.VAL(TglGetShaderSource  , glXGetProcAddress('glGetShaderSource'));
   glGetUniformLocation := SYSTEM.VAL(TglGetUniformLocation  , glXGetProcAddress('glGetUniformLocation'));
   glGetUniformfv := SYSTEM.VAL(TglGetUniformfv  , glXGetProcAddress('glGetUniformfv'));
   glGetUniformiv := SYSTEM.VAL(TglGetUniformiv  , glXGetProcAddress('glGetUniformiv'));
   glGetVertexAttribfv := SYSTEM.VAL(TglGetVertexAttribfv  , glXGetProcAddress('glGetVertexAttribfv'));
   glGetVertexAttribiv := SYSTEM.VAL(TglGetVertexAttribiv  , glXGetProcAddress('glGetVertexAttribiv'));
   glGetVertexAttribPointerv := SYSTEM.VAL(TglGetVertexAttribPointerv  , glXGetProcAddress('glGetVertexAttribPointerv'));
   glIsProgram := SYSTEM.VAL(TglIsProgram  , glXGetProcAddress('glIsProgram'));
   glIsShader := SYSTEM.VAL(TglIsShader  , glXGetProcAddress('glIsShader'));
   glLinkProgram := SYSTEM.VAL(TglLinkProgram  , glXGetProcAddress('glLinkProgram'));
   glShaderSource := SYSTEM.VAL(TglShaderSource  , glXGetProcAddress('glShaderSource'));
   glUseProgram := SYSTEM.VAL(TglUseProgram  , glXGetProcAddress('glUseProgram'));
   glUniform1f := SYSTEM.VAL(TglUniform1f  , glXGetProcAddress('glUniform1f'));
   glUniform2f := SYSTEM.VAL(TglUniform2f  , glXGetProcAddress('glUniform2f'));
   glUniform3f := SYSTEM.VAL(TglUniform3f  , glXGetProcAddress('glUniform3f'));
   glUniform4f := SYSTEM.VAL(TglUniform4f  , glXGetProcAddress('glUniform4f'));
   glUniform1i := SYSTEM.VAL(TglUniform1i  , glXGetProcAddress('glUniform1i'));
   glUniform2i := SYSTEM.VAL(TglUniform2i  , glXGetProcAddress('glUniform2i'));
   glUniform3i := SYSTEM.VAL(TglUniform3i  , glXGetProcAddress('glUniform3i'));
   glUniform4i := SYSTEM.VAL(TglUniform4i  , glXGetProcAddress('glUniform4i'));
   glUniform1fv := SYSTEM.VAL(TglUniform1fv  , glXGetProcAddress('glUniform1fv'));
   glUniform2fv := SYSTEM.VAL(TglUniform2fv  , glXGetProcAddress('glUniform2fv'));
   glUniform3fv := SYSTEM.VAL(TglUniform3fv  , glXGetProcAddress('glUniform3fv'));
   glUniform4fv := SYSTEM.VAL(TglUniform4fv  , glXGetProcAddress('glUniform4fv'));
   glUniform1iv := SYSTEM.VAL(TglUniform1iv  , glXGetProcAddress('glUniform1iv'));
   glUniform2iv := SYSTEM.VAL(TglUniform2iv  , glXGetProcAddress('glUniform2iv'));
   glUniform3iv := SYSTEM.VAL(TglUniform3iv  , glXGetProcAddress('glUniform3iv'));
   glUniform4iv := SYSTEM.VAL(TglUniform4iv  , glXGetProcAddress('glUniform4iv'));
   glUniformMatrix2fv := SYSTEM.VAL(TglUniformMatrix2fv  , glXGetProcAddress('glUniformMatrix2fv'));
   glUniformMatrix3fv := SYSTEM.VAL(TglUniformMatrix3fv  , glXGetProcAddress('glUniformMatrix3fv'));
   glUniformMatrix4fv := SYSTEM.VAL(TglUniformMatrix4fv  , glXGetProcAddress('glUniformMatrix4fv'));
   glValidateProgram := SYSTEM.VAL(TglValidateProgram  , glXGetProcAddress('glValidateProgram'));
   glVertexAttrib1d := SYSTEM.VAL(TglVertexAttrib1d  , glXGetProcAddress('glVertexAttrib1d'));
   glVertexAttrib1dv := SYSTEM.VAL(TglVertexAttrib1dv  , glXGetProcAddress('glVertexAttrib1dv'));
   glVertexAttrib1f := SYSTEM.VAL(TglVertexAttrib1f  , glXGetProcAddress('glVertexAttrib1f'));
   glVertexAttrib1fv := SYSTEM.VAL(TglVertexAttrib1fv  , glXGetProcAddress('glVertexAttrib1fv'));
   glVertexAttrib1s := SYSTEM.VAL(TglVertexAttrib1s  , glXGetProcAddress('glVertexAttrib1s'));
   glVertexAttrib1sv := SYSTEM.VAL(TglVertexAttrib1sv  , glXGetProcAddress('glVertexAttrib1sv'));
   glVertexAttrib2d := SYSTEM.VAL(TglVertexAttrib2d  , glXGetProcAddress('glVertexAttrib2d'));
   glVertexAttrib2dv := SYSTEM.VAL(TglVertexAttrib2dv  , glXGetProcAddress('glVertexAttrib2dv'));
   glVertexAttrib2f := SYSTEM.VAL(TglVertexAttrib2f  , glXGetProcAddress('glVertexAttrib2f'));
   glVertexAttrib2fv := SYSTEM.VAL(TglVertexAttrib2fv  , glXGetProcAddress('glVertexAttrib2fv'));
   glVertexAttrib2s := SYSTEM.VAL(TglVertexAttrib2s  , glXGetProcAddress('glVertexAttrib2s'));
   glVertexAttrib2sv := SYSTEM.VAL(TglVertexAttrib2sv  , glXGetProcAddress('glVertexAttrib2sv'));
   glVertexAttrib3d := SYSTEM.VAL(TglVertexAttrib3d  , glXGetProcAddress('glVertexAttrib3d'));
   glVertexAttrib3dv := SYSTEM.VAL(TglVertexAttrib3dv  , glXGetProcAddress('glVertexAttrib3dv'));
   glVertexAttrib3f := SYSTEM.VAL(TglVertexAttrib3f  , glXGetProcAddress('glVertexAttrib3f'));
   glVertexAttrib3fv := SYSTEM.VAL(TglVertexAttrib3fv  , glXGetProcAddress('glVertexAttrib3fv'));
   glVertexAttrib3s := SYSTEM.VAL(TglVertexAttrib3s  , glXGetProcAddress('glVertexAttrib3s'));
   glVertexAttrib3sv := SYSTEM.VAL(TglVertexAttrib3sv  , glXGetProcAddress('glVertexAttrib3sv'));
   glVertexAttrib4Nbv := SYSTEM.VAL(TglVertexAttrib4Nbv  , glXGetProcAddress('glVertexAttrib4Nbv'));
   glVertexAttrib4Niv := SYSTEM.VAL(TglVertexAttrib4Niv  , glXGetProcAddress('glVertexAttrib4Niv'));
   glVertexAttrib4Nsv := SYSTEM.VAL(TglVertexAttrib4Nsv  , glXGetProcAddress('glVertexAttrib4Nsv'));
   glVertexAttrib4Nub := SYSTEM.VAL(TglVertexAttrib4Nub  , glXGetProcAddress('glVertexAttrib4Nub'));
   glVertexAttrib4Nubv := SYSTEM.VAL(TglVertexAttrib4Nubv  , glXGetProcAddress('glVertexAttrib4Nubv'));
   glVertexAttrib4Nuiv := SYSTEM.VAL(TglVertexAttrib4Nuiv  , glXGetProcAddress('glVertexAttrib4Nuiv'));
   glVertexAttrib4Nusv := SYSTEM.VAL(TglVertexAttrib4Nusv  , glXGetProcAddress('glVertexAttrib4Nusv'));
   glVertexAttrib4bv := SYSTEM.VAL(TglVertexAttrib4bv  , glXGetProcAddress('glVertexAttrib4bv'));
   glVertexAttrib4d := SYSTEM.VAL(TglVertexAttrib4d  , glXGetProcAddress('glVertexAttrib4d'));
   glVertexAttrib4dv := SYSTEM.VAL(TglVertexAttrib4dv  , glXGetProcAddress('glVertexAttrib4dv'));
   glVertexAttrib4f := SYSTEM.VAL(TglVertexAttrib4f  , glXGetProcAddress('glVertexAttrib4f'));
   glVertexAttrib4fv := SYSTEM.VAL(TglVertexAttrib4fv  , glXGetProcAddress('glVertexAttrib4fv'));
   glVertexAttrib4iv := SYSTEM.VAL(TglVertexAttrib4iv  , glXGetProcAddress('glVertexAttrib4iv'));
   glVertexAttrib4s := SYSTEM.VAL(TglVertexAttrib4s  , glXGetProcAddress('glVertexAttrib4s'));
   glVertexAttrib4sv := SYSTEM.VAL(TglVertexAttrib4sv  , glXGetProcAddress('glVertexAttrib4sv'));
   glVertexAttrib4ubv := SYSTEM.VAL(TglVertexAttrib4ubv  , glXGetProcAddress('glVertexAttrib4ubv'));
   glVertexAttrib4uiv := SYSTEM.VAL(TglVertexAttrib4uiv  , glXGetProcAddress('glVertexAttrib4uiv'));
   glVertexAttrib4usv := SYSTEM.VAL(TglVertexAttrib4usv  , glXGetProcAddress('glVertexAttrib4usv'));
   glVertexAttribPointer := SYSTEM.VAL(TglVertexAttribPointer  , glXGetProcAddress('glVertexAttribPointer'));

  (* GL_VERSION_2_1 *)
   glUniformMatrix2x3fv := SYSTEM.VAL(TglUniformMatrix2x3fv  , glXGetProcAddress('glUniformMatrix2x3fv'));
   glUniformMatrix3x2fv := SYSTEM.VAL(TglUniformMatrix3x2fv  , glXGetProcAddress('glUniformMatrix3x2fv'));
   glUniformMatrix2x4fv := SYSTEM.VAL(TglUniformMatrix2x4fv  , glXGetProcAddress('glUniformMatrix2x4fv'));
   glUniformMatrix4x2fv := SYSTEM.VAL(TglUniformMatrix4x2fv  , glXGetProcAddress('glUniformMatrix4x2fv'));
   glUniformMatrix3x4fv := SYSTEM.VAL(TglUniformMatrix3x4fv  , glXGetProcAddress('glUniformMatrix3x4fv'));
   glUniformMatrix4x3fv := SYSTEM.VAL(TglUniformMatrix4x3fv  , glXGetProcAddress('glUniformMatrix4x3fv'));
  
  (* GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions: *)
  Read_GL_ARB_framebuffer_object;
  Read_GL_ARB_map_buffer_range;
  Read_GL_ARB_vertex_array_object;

   glColorMaski := SYSTEM.VAL(TglColorMaski  , glXGetProcAddress('glColorMaski'));
   glGetBooleani_v := SYSTEM.VAL(TglGetBooleani_v  , glXGetProcAddress('glGetBooleani_v'));
   glGetIntegeri_v := SYSTEM.VAL(TglGetIntegeri_v  , glXGetProcAddress('glGetIntegeri_v'));
   glEnablei := SYSTEM.VAL(TglEnablei  , glXGetProcAddress('glEnablei'));
   glDisablei := SYSTEM.VAL(TglDisablei  , glXGetProcAddress('glDisablei'));
   glIsEnabledi := SYSTEM.VAL(TglIsEnabledi  , glXGetProcAddress('glIsEnabledi'));
   glBeginTransformFeedback := SYSTEM.VAL(TglBeginTransformFeedback  , glXGetProcAddress('glBeginTransformFeedback'));
   glEndTransformFeedback := SYSTEM.VAL(TglEndTransformFeedback  , glXGetProcAddress('glEndTransformFeedback'));
   glBindBufferRange := SYSTEM.VAL(TglBindBufferRange  , glXGetProcAddress('glBindBufferRange'));
   glBindBufferBase := SYSTEM.VAL(TglBindBufferBase  , glXGetProcAddress('glBindBufferBase'));
   glTransformFeedbackVaryings := SYSTEM.VAL(TglTransformFeedbackVaryings  , glXGetProcAddress('glTransformFeedbackVaryings'));
   glGetTransformFeedbackVarying := SYSTEM.VAL(TglGetTransformFeedbackVarying  , glXGetProcAddress('glGetTransformFeedbackVarying'));
   glClampColor := SYSTEM.VAL(TglClampColor  , glXGetProcAddress('glClampColor'));
   glBeginConditionalRender := SYSTEM.VAL(TglBeginConditionalRender  , glXGetProcAddress('glBeginConditionalRender'));
   glEndConditionalRender := SYSTEM.VAL(TglEndConditionalRender  , glXGetProcAddress('glEndConditionalRender'));
   glVertexAttribI1i := SYSTEM.VAL(TglVertexAttribI1i  , glXGetProcAddress('glVertexAttribI1i'));
   glVertexAttribI2i := SYSTEM.VAL(TglVertexAttribI2i  , glXGetProcAddress('glVertexAttribI2i'));
   glVertexAttribI3i := SYSTEM.VAL(TglVertexAttribI3i  , glXGetProcAddress('glVertexAttribI3i'));
   glVertexAttribI4i := SYSTEM.VAL(TglVertexAttribI4i  , glXGetProcAddress('glVertexAttribI4i'));
   glVertexAttribI1ui := SYSTEM.VAL(TglVertexAttribI1ui  , glXGetProcAddress('glVertexAttribI1ui'));
   glVertexAttribI2ui := SYSTEM.VAL(TglVertexAttribI2ui  , glXGetProcAddress('glVertexAttribI2ui'));
   glVertexAttribI3ui := SYSTEM.VAL(TglVertexAttribI3ui  , glXGetProcAddress('glVertexAttribI3ui'));
   glVertexAttribI4ui := SYSTEM.VAL(TglVertexAttribI4ui  , glXGetProcAddress('glVertexAttribI4ui'));
   glVertexAttribI1iv := SYSTEM.VAL(TglVertexAttribI1iv  , glXGetProcAddress('glVertexAttribI1iv'));
   glVertexAttribI2iv := SYSTEM.VAL(TglVertexAttribI2iv  , glXGetProcAddress('glVertexAttribI2iv'));
   glVertexAttribI3iv := SYSTEM.VAL(TglVertexAttribI3iv  , glXGetProcAddress('glVertexAttribI3iv'));
   glVertexAttribI4iv := SYSTEM.VAL(TglVertexAttribI4iv  , glXGetProcAddress('glVertexAttribI4iv'));
   glVertexAttribI1uiv := SYSTEM.VAL(TglVertexAttribI1uiv  , glXGetProcAddress('glVertexAttribI1uiv'));
   glVertexAttribI2uiv := SYSTEM.VAL(TglVertexAttribI2uiv  , glXGetProcAddress('glVertexAttribI2uiv'));
   glVertexAttribI3uiv := SYSTEM.VAL(TglVertexAttribI3uiv  , glXGetProcAddress('glVertexAttribI3uiv'));
   glVertexAttribI4uiv := SYSTEM.VAL(TglVertexAttribI4uiv  , glXGetProcAddress('glVertexAttribI4uiv'));
   glVertexAttribI4bv := SYSTEM.VAL(TglVertexAttribI4bv  , glXGetProcAddress('glVertexAttribI4bv'));
   glVertexAttribI4sv := SYSTEM.VAL(TglVertexAttribI4sv  , glXGetProcAddress('glVertexAttribI4sv'));
   glVertexAttribI4ubv := SYSTEM.VAL(TglVertexAttribI4ubv  , glXGetProcAddress('glVertexAttribI4ubv'));
   glVertexAttribI4usv := SYSTEM.VAL(TglVertexAttribI4usv  , glXGetProcAddress('glVertexAttribI4usv'));
   glVertexAttribIPointer := SYSTEM.VAL(TglVertexAttribIPointer  , glXGetProcAddress('glVertexAttribIPointer'));
   glGetVertexAttribIiv := SYSTEM.VAL(TglGetVertexAttribIiv  , glXGetProcAddress('glGetVertexAttribIiv'));
   glGetVertexAttribIuiv := SYSTEM.VAL(TglGetVertexAttribIuiv  , glXGetProcAddress('glGetVertexAttribIuiv'));
   glGetUniformuiv := SYSTEM.VAL(TglGetUniformuiv  , glXGetProcAddress('glGetUniformuiv'));
   glBindFragDataLocation := SYSTEM.VAL(TglBindFragDataLocation  , glXGetProcAddress('glBindFragDataLocation'));
   glGetFragDataLocation := SYSTEM.VAL(TglGetFragDataLocation  , glXGetProcAddress('glGetFragDataLocation'));
   glUniform1ui := SYSTEM.VAL(TglUniform1ui  , glXGetProcAddress('glUniform1ui'));
   glUniform2ui := SYSTEM.VAL(TglUniform2ui  , glXGetProcAddress('glUniform2ui'));
   glUniform3ui := SYSTEM.VAL(TglUniform3ui  , glXGetProcAddress('glUniform3ui'));
   glUniform4ui := SYSTEM.VAL(TglUniform4ui  , glXGetProcAddress('glUniform4ui'));
   glUniform1uiv := SYSTEM.VAL(TglUniform1uiv  , glXGetProcAddress('glUniform1uiv'));
   glUniform2uiv := SYSTEM.VAL(TglUniform2uiv  , glXGetProcAddress('glUniform2uiv'));
   glUniform3uiv := SYSTEM.VAL(TglUniform3uiv  , glXGetProcAddress('glUniform3uiv'));
   glUniform4uiv := SYSTEM.VAL(TglUniform4uiv  , glXGetProcAddress('glUniform4uiv'));
   glTexParameterIiv := SYSTEM.VAL(TglTexParameterIiv  , glXGetProcAddress('glTexParameterIiv'));
   glTexParameterIuiv := SYSTEM.VAL(TglTexParameterIuiv  , glXGetProcAddress('glTexParameterIuiv'));
   glGetTexParameterIiv := SYSTEM.VAL(TglGetTexParameterIiv  , glXGetProcAddress('glGetTexParameterIiv'));
   glGetTexParameterIuiv := SYSTEM.VAL(TglGetTexParameterIuiv  , glXGetProcAddress('glGetTexParameterIuiv'));
   glClearBufferiv := SYSTEM.VAL(TglClearBufferiv  , glXGetProcAddress('glClearBufferiv'));
   glClearBufferuiv := SYSTEM.VAL(TglClearBufferuiv  , glXGetProcAddress('glClearBufferuiv'));
   glClearBufferfv := SYSTEM.VAL(TglClearBufferfv  , glXGetProcAddress('glClearBufferfv'));
   glClearBufferfi := SYSTEM.VAL(TglClearBufferfi  , glXGetProcAddress('glClearBufferfi'));
   glGetStringi := SYSTEM.VAL(TglGetStringi  , glXGetProcAddress('glGetStringi'));

  (* GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions: *)
  Read_GL_ARB_copy_buffer;
  Read_GL_ARB_uniform_buffer_object;

   glDrawArraysInstanced := SYSTEM.VAL(TglDrawArraysInstanced  , glXGetProcAddress('glDrawArraysInstanced'));
   glDrawElementsInstanced := SYSTEM.VAL(TglDrawElementsInstanced  , glXGetProcAddress('glDrawElementsInstanced'));
   glTexBuffer := SYSTEM.VAL(TglTexBuffer  , glXGetProcAddress('glTexBuffer'));
   glPrimitiveRestartIndex := SYSTEM.VAL(TglPrimitiveRestartIndex  , glXGetProcAddress('glPrimitiveRestartIndex'));

  (* GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions: *)
  Read_GL_ARB_draw_elements_base_vertex;
  Read_GL_ARB_provoking_vertex;
  Read_GL_ARB_sync;
  Read_GL_ARB_texture_multisample;

   glGetInteger64i_v  := SYSTEM.VAL(TglGetInteger64i_v  , glXGetProcAddress('glGetInteger64i_v'));
   glGetBufferParameteri64v := SYSTEM.VAL(TglGetBufferParameteri64v  , glXGetProcAddress('glGetBufferParameteri64v'));
   glProgramParameteri := SYSTEM.VAL(TglProgramParameteri  , glXGetProcAddress('glProgramParameteri'));
   glFramebufferTexture := SYSTEM.VAL(TglFramebufferTexture  , glXGetProcAddress('glFramebufferTexture'));
  
  	(* GL_VERSION_3_3 *)
  	(* OpenGL 3.3 also reuses entry points from these extensions: *)
  	Read_GL_ARB_blend_func_extended;
  	Read_GL_ARB_sampler_objects;
  	(* ARB_explicit_attrib_location, but it has none *)
  	(* ARB_occlusion_query2 (no entry points) *)
  	(* ARB_shader_bit_encoding (no entry points) *)
  	(* ARB_texture_rgb10_a2ui (no entry points) *)
  	(* ARB_texture_swizzle (no entry points) *)
  	Read_GL_ARB_timer_query;
  	Read_GL_ARB_vertex_type_2_10_10_10_rev;
     glVertexAttribDivisor := SYSTEM.VAL(TglVertexAttribDivisor, glXGetProcAddress('glVertexAttribDivisor'));
     
  	(* GL_VERSION_4_0 *)
  	(* OpenGL 4.0 also reuses entry points from these extensions: *)
  	(* ARB_texture_query_lod (no entry points) *)
  	Read_GL_ARB_draw_indirect;
  	(* ARB_gpu_shader5 (no entry points) *)
  	Read_GL_ARB_gpu_shader_fp64;
  	Read_GL_ARB_shader_subroutine;
  	Read_GL_ARB_tessellation_shader;
  	(* ARB_texture_buffer_object_rgb32 (no entry points)  *)
  	(* ARB_texture_cube_map_array (no entry points) *)
  	(* ARB_texture_gather (no entry points) *)
  	Read_GL_ARB_transform_feedback2;
  	Read_GL_ARB_transform_feedback3;
     glMinSampleShading := SYSTEM.VAL(TglMinSampleShading, glXGetProcAddress('glMinSampleShading'));
     glBlendEquationi := SYSTEM.VAL(TglBlendEquationi, glXGetProcAddress('glBlendEquationi'));
     glBlendEquationSeparatei := SYSTEM.VAL(TglBlendEquationSeparatei, glXGetProcAddress('glBlendEquationSeparatei'));
     glBlendFunci := SYSTEM.VAL(TglBlendFunci, glXGetProcAddress('glBlendFunci'));
     glBlendFuncSeparatei := SYSTEM.VAL(TglBlendFuncSeparatei, glXGetProcAddress('glBlendFuncSeparatei'));

 (* GL_VERSION_4_1 *)
 	(* OpenGL 4.1 also reuses entry points from these extensions: *)
  	Read_GL_ARB_ES2_compatibility;
  	Read_GL_ARB_get_program_binary;
  	Read_GL_ARB_separate_shader_objects;
  	(* ARB_shader_precision (no entry points) *)
  	Read_GL_ARB_vertex_attrib_64bit;
  	Read_GL_ARB_viewport_array;
 
   Trace.String(" Ok.");  Trace.Ln; 
END ReadOpenGLCore;


PROCEDURE Read_GL_3DFX_tbuffer;
BEGIN
     glTbufferMask3DFX := SYSTEM.VAL(TglTbufferMask3DFX, glXGetProcAddress('glTbufferMask3DFX'));
END Read_GL_3DFX_tbuffer;

PROCEDURE Read_GL_APPLE_element_array;
BEGIN
 (*    glElementPointerAPPLE := SYSTEM.VAL(TglElementPointerAPPLE, glXGetProcAddress('glElementPointerAPPLE'));
     glDrawElementArrayAPPLE := SYSTEM.VAL(TglDrawElementArrayAPPLE, glXGetProcAddress('glDrawElementArrayAPPLE'));
     glDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglDrawRangeElementArrayAPPLE, glXGetProcAddress('glDrawRangeElementArrayAPPLE'));
     glMultiDrawElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawElementArrayAPPLE, glXGetProcAddress('glMultiDrawElementArrayAPPLE'));
     glMultiDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawRangeElementArrayAPPLE, glXGetProcAddress('glMultiDrawRangeElementArrayAPPLE'));
 *)    
END Read_GL_APPLE_element_array;

PROCEDURE Read_GL_APPLE_fence;
BEGIN
(*     glGenFencesAPPLE := SYSTEM.VAL(TglGenFencesAPPLE, glXGetProcAddress('glGenFencesAPPLE'));
     glDeleteFencesAPPLE := SYSTEM.VAL(TglDeleteFencesAPPLE, glXGetProcAddress('glDeleteFencesAPPLE'));
     glSetFenceAPPLE := SYSTEM.VAL(TglSetFenceAPPLE, glXGetProcAddress('glSetFenceAPPLE'));
     glIsFenceAPPLE := SYSTEM.VAL(TglIsFenceAPPLE, glXGetProcAddress('glIsFenceAPPLE'));
     glTestFenceAPPLE := SYSTEM.VAL(TglTestFenceAPPLE, glXGetProcAddress('glTestFenceAPPLE'));
     glFinishFenceAPPLE := SYSTEM.VAL(TglFinishFenceAPPLE, glXGetProcAddress('glFinishFenceAPPLE'));
     glTestObjectAPPLE := SYSTEM.VAL(TglTestObjectAPPLE, glXGetProcAddress('glTestObjectAPPLE'));
     glFinishObjectAPPLE := SYSTEM.VAL(TglFinishObjectAPPLE, glXGetProcAddress('glFinishObjectAPPLE'));
*)     
END Read_GL_APPLE_fence;

PROCEDURE Read_GL_APPLE_vertex_array_object;
BEGIN
(*     glBindVertexArrayAPPLE := SYSTEM.VAL(TglBindVertexArrayAPPLE, glXGetProcAddress('glBindVertexArrayAPPLE'));
     glDeleteVertexArraysAPPLE := SYSTEM.VAL(TglDeleteVertexArraysAPPLE, glXGetProcAddress('glDeleteVertexArraysAPPLE'));
     glGenVertexArraysAPPLE := SYSTEM.VAL(TglGenVertexArraysAPPLE, glXGetProcAddress('glGenVertexArraysAPPLE'));
     glIsVertexArrayAPPLE := SYSTEM.VAL(TglIsVertexArrayAPPLE, glXGetProcAddress('glIsVertexArrayAPPLE'));
*)     
END Read_GL_APPLE_vertex_array_object;

PROCEDURE Read_GL_APPLE_vertex_array_range;
BEGIN
(*     glVertexArrayRangeAPPLE := SYSTEM.VAL(TglVertexArrayRangeAPPLE, glXGetProcAddress('glVertexArrayRangeAPPLE'));
     glFlushVertexArrayRangeAPPLE := SYSTEM.VAL(TglFlushVertexArrayRangeAPPLE, glXGetProcAddress('glFlushVertexArrayRangeAPPLE'));
     glVertexArrayParameteriAPPLE := SYSTEM.VAL(TglVertexArrayParameteriAPPLE, glXGetProcAddress('glVertexArrayParameteriAPPLE'));
*)
END Read_GL_APPLE_vertex_array_range;

PROCEDURE Read_GL_APPLE_texture_range;
BEGIN
(*     glTextureRangeAPPLE := SYSTEM.VAL(TglTextureRangeAPPLE, glXGetProcAddress('glTextureRangeAPPLE'));
     glGetTexParameterPointervAPPLE := SYSTEM.VAL(TglGetTexParameterPointervAPPLE, glXGetProcAddress('glGetTexParameterPointervAPPLE'));
*)
END Read_GL_APPLE_texture_range;

PROCEDURE Read_GL_APPLE_vertex_program_evaluators;
BEGIN
(*     glEnableVertexAttribAPPLE := SYSTEM.VAL(TglEnableVertexAttribAPPLE, glXGetProcAddress('glEnableVertexAttribAPPLE'));
     glDisableVertexAttribAPPLE := SYSTEM.VAL(TglDisableVertexAttribAPPLE, glXGetProcAddress('glDisableVertexAttribAPPLE'));
     glIsVertexAttribEnabledAPPLE := SYSTEM.VAL(TglIsVertexAttribEnabledAPPLE, glXGetProcAddress('glIsVertexAttribEnabledAPPLE'));
     glMapVertexAttrib1dAPPLE := SYSTEM.VAL(TglMapVertexAttrib1dAPPLE, glXGetProcAddress('glMapVertexAttrib1dAPPLE'));
     glMapVertexAttrib1fAPPLE := SYSTEM.VAL(TglMapVertexAttrib1fAPPLE, glXGetProcAddress('glMapVertexAttrib1fAPPLE'));
     glMapVertexAttrib2dAPPLE := SYSTEM.VAL(TglMapVertexAttrib2dAPPLE, glXGetProcAddress('glMapVertexAttrib2dAPPLE'));
     glMapVertexAttrib2fAPPLE := SYSTEM.VAL(TglMapVertexAttrib2fAPPLE, glXGetProcAddress('glMapVertexAttrib2fAPPLE'));
*)
END Read_GL_APPLE_vertex_program_evaluators;

PROCEDURE Read_GL_APPLE_object_purgeable;
BEGIN
(*     glObjectPurgeableAPPLE := SYSTEM.VAL(TglObjectPurgeableAPPLE, glXGetProcAddress('glObjectPurgeableAPPLE'));
     glObjectUnpurgeableAPPLE := SYSTEM.VAL(TglObjectUnpurgeableAPPLE, glXGetProcAddress('glObjectUnpurgeableAPPLE'));
     glGetObjectParameterivAPPLE := SYSTEM.VAL(TglGetObjectParameterivAPPLE, glXGetProcAddress('glGetObjectParameterivAPPLE'));
*)
END Read_GL_APPLE_object_purgeable;

PROCEDURE Read_GL_ARB_matrix_palette;
BEGIN
     glCurrentPaletteMatrixARB := SYSTEM.VAL(TglCurrentPaletteMatrixARB, glXGetProcAddress('glCurrentPaletteMatrixARB'));
     glMatrixIndexubvARB := SYSTEM.VAL(TglMatrixIndexubvARB, glXGetProcAddress('glMatrixIndexubvARB'));
     glMatrixIndexusvARB := SYSTEM.VAL(TglMatrixIndexusvARB, glXGetProcAddress('glMatrixIndexusvARB'));
     glMatrixIndexuivARB := SYSTEM.VAL(TglMatrixIndexuivARB, glXGetProcAddress('glMatrixIndexuivARB'));
     glMatrixIndexPointerARB := SYSTEM.VAL(TglMatrixIndexPointerARB, glXGetProcAddress('glMatrixIndexPointerARB'));
END Read_GL_ARB_matrix_palette;

PROCEDURE Read_GL_ARB_multisample;
BEGIN
     glSampleCoverageARB := SYSTEM.VAL(TglSampleCoverageARB, glXGetProcAddress('glSampleCoverageARB'));
END Read_GL_ARB_multisample;

PROCEDURE Read_GL_ARB_multitexture;
BEGIN
     glActiveTextureARB := SYSTEM.VAL(TglActiveTextureARB, glXGetProcAddress('glActiveTextureARB'));
     glClientActiveTextureARB := SYSTEM.VAL(TglClientActiveTextureARB, glXGetProcAddress('glClientActiveTextureARB'));
     glMultiTexCoord1dARB := SYSTEM.VAL(TglMultiTexCoord1dARB, glXGetProcAddress('glMultiTexCoord1dARB'));
     glMultiTexCoord1dvARB := SYSTEM.VAL(TglMultiTexCoord1dvARB, glXGetProcAddress('glMultiTexCoord1dvARB'));
     glMultiTexCoord1fARB := SYSTEM.VAL(TglMultiTexCoord1fARB, glXGetProcAddress('glMultiTexCoord1fARB'));
     glMultiTexCoord1fvARB := SYSTEM.VAL(TglMultiTexCoord1fvARB, glXGetProcAddress('glMultiTexCoord1fvARB'));
     glMultiTexCoord1iARB := SYSTEM.VAL(TglMultiTexCoord1iARB, glXGetProcAddress('glMultiTexCoord1iARB'));
     glMultiTexCoord1ivARB := SYSTEM.VAL(TglMultiTexCoord1ivARB, glXGetProcAddress('glMultiTexCoord1ivARB'));
     glMultiTexCoord1sARB := SYSTEM.VAL(TglMultiTexCoord1sARB, glXGetProcAddress('glMultiTexCoord1sARB'));
     glMultiTexCoord1svARB := SYSTEM.VAL(TglMultiTexCoord1svARB, glXGetProcAddress('glMultiTexCoord1svARB'));
     glMultiTexCoord2dARB := SYSTEM.VAL(TglMultiTexCoord2dARB, glXGetProcAddress('glMultiTexCoord2dARB'));
     glMultiTexCoord2dvARB := SYSTEM.VAL(TglMultiTexCoord2dvARB, glXGetProcAddress('glMultiTexCoord2dvARB'));
     glMultiTexCoord2fARB := SYSTEM.VAL(TglMultiTexCoord2fARB, glXGetProcAddress('glMultiTexCoord2fARB'));
     glMultiTexCoord2fvARB := SYSTEM.VAL(TglMultiTexCoord2fvARB, glXGetProcAddress('glMultiTexCoord2fvARB'));
     glMultiTexCoord2iARB := SYSTEM.VAL(TglMultiTexCoord2iARB, glXGetProcAddress('glMultiTexCoord2iARB'));
     glMultiTexCoord2ivARB := SYSTEM.VAL(TglMultiTexCoord2ivARB, glXGetProcAddress('glMultiTexCoord2ivARB'));
     glMultiTexCoord2sARB := SYSTEM.VAL(TglMultiTexCoord2sARB, glXGetProcAddress('glMultiTexCoord2sARB'));
     glMultiTexCoord2svARB := SYSTEM.VAL(TglMultiTexCoord2svARB, glXGetProcAddress('glMultiTexCoord2svARB'));
     glMultiTexCoord3dARB := SYSTEM.VAL(TglMultiTexCoord3dARB, glXGetProcAddress('glMultiTexCoord3dARB'));
     glMultiTexCoord3dvARB := SYSTEM.VAL(TglMultiTexCoord3dvARB, glXGetProcAddress('glMultiTexCoord3dvARB'));
     glMultiTexCoord3fARB := SYSTEM.VAL(TglMultiTexCoord3fARB, glXGetProcAddress('glMultiTexCoord3fARB'));
     glMultiTexCoord3fvARB := SYSTEM.VAL(TglMultiTexCoord3fvARB, glXGetProcAddress('glMultiTexCoord3fvARB'));
     glMultiTexCoord3iARB := SYSTEM.VAL(TglMultiTexCoord3iARB, glXGetProcAddress('glMultiTexCoord3iARB'));
     glMultiTexCoord3ivARB := SYSTEM.VAL(TglMultiTexCoord3ivARB, glXGetProcAddress('glMultiTexCoord3ivARB'));
     glMultiTexCoord3sARB := SYSTEM.VAL(TglMultiTexCoord3sARB, glXGetProcAddress('glMultiTexCoord3sARB'));
     glMultiTexCoord3svARB := SYSTEM.VAL(TglMultiTexCoord3svARB, glXGetProcAddress('glMultiTexCoord3svARB'));
     glMultiTexCoord4dARB := SYSTEM.VAL(TglMultiTexCoord4dARB, glXGetProcAddress('glMultiTexCoord4dARB'));
     glMultiTexCoord4dvARB := SYSTEM.VAL(TglMultiTexCoord4dvARB, glXGetProcAddress('glMultiTexCoord4dvARB'));
     glMultiTexCoord4fARB := SYSTEM.VAL(TglMultiTexCoord4fARB, glXGetProcAddress('glMultiTexCoord4fARB'));
     glMultiTexCoord4fvARB := SYSTEM.VAL(TglMultiTexCoord4fvARB, glXGetProcAddress('glMultiTexCoord4fvARB'));
     glMultiTexCoord4iARB := SYSTEM.VAL(TglMultiTexCoord4iARB, glXGetProcAddress('glMultiTexCoord4iARB'));
     glMultiTexCoord4ivARB := SYSTEM.VAL(TglMultiTexCoord4ivARB, glXGetProcAddress('glMultiTexCoord4ivARB'));
     glMultiTexCoord4sARB := SYSTEM.VAL(TglMultiTexCoord4sARB, glXGetProcAddress('glMultiTexCoord4sARB'));
     glMultiTexCoord4svARB := SYSTEM.VAL(TglMultiTexCoord4svARB, glXGetProcAddress('glMultiTexCoord4svARB'));
END Read_GL_ARB_multitexture;

PROCEDURE Read_GL_ARB_point_parameters;
BEGIN
     glPointParameterfARB := SYSTEM.VAL(TglPointParameterfARB, glXGetProcAddress('glPointParameterfARB'));
     glPointParameterfvARB := SYSTEM.VAL(TglPointParameterfvARB, glXGetProcAddress('glPointParameterfvARB'));
END Read_GL_ARB_point_parameters;

PROCEDURE Read_GL_ARB_texture_compression;
BEGIN
     glCompressedTexImage3DARB := SYSTEM.VAL(TglCompressedTexImage3DARB, glXGetProcAddress('glCompressedTexImage3DARB'));
     glCompressedTexImage2DARB := SYSTEM.VAL(TglCompressedTexImage2DARB, glXGetProcAddress('glCompressedTexImage2DARB'));
     glCompressedTexImage1DARB := SYSTEM.VAL(TglCompressedTexImage1DARB, glXGetProcAddress('glCompressedTexImage1DARB'));
     glCompressedTexSubImage3DARB := SYSTEM.VAL(TglCompressedTexSubImage3DARB, glXGetProcAddress('glCompressedTexSubImage3DARB'));
     glCompressedTexSubImage2DARB := SYSTEM.VAL(TglCompressedTexSubImage2DARB, glXGetProcAddress('glCompressedTexSubImage2DARB'));
     glCompressedTexSubImage1DARB := SYSTEM.VAL(TglCompressedTexSubImage1DARB, glXGetProcAddress('glCompressedTexSubImage1DARB'));
     glGetCompressedTexImageARB := SYSTEM.VAL(TglGetCompressedTexImageARB, glXGetProcAddress('glGetCompressedTexImageARB'));
END Read_GL_ARB_texture_compression;

PROCEDURE Read_GL_ARB_transpose_matrix;
BEGIN
     glLoadTransposeMatrixfARB := SYSTEM.VAL(TglLoadTransposeMatrixfARB, glXGetProcAddress('glLoadTransposeMatrixfARB'));
     glLoadTransposeMatrixdARB := SYSTEM.VAL(TglLoadTransposeMatrixdARB, glXGetProcAddress('glLoadTransposeMatrixdARB'));
     glMultTransposeMatrixfARB := SYSTEM.VAL(TglMultTransposeMatrixfARB, glXGetProcAddress('glMultTransposeMatrixfARB'));
     glMultTransposeMatrixdARB := SYSTEM.VAL(TglMultTransposeMatrixdARB, glXGetProcAddress('glMultTransposeMatrixdARB'));
END Read_GL_ARB_transpose_matrix;

PROCEDURE Read_GL_ARB_vertex_blend;
BEGIN
     glWeightbvARB := SYSTEM.VAL(TglWeightbvARB, glXGetProcAddress('glWeightbvARB'));
     glWeightsvARB := SYSTEM.VAL(TglWeightsvARB, glXGetProcAddress('glWeightsvARB'));
     glWeightivARB := SYSTEM.VAL(TglWeightivARB, glXGetProcAddress('glWeightivARB'));
     glWeightfvARB := SYSTEM.VAL(TglWeightfvARB, glXGetProcAddress('glWeightfvARB'));
     glWeightdvARB := SYSTEM.VAL(TglWeightdvARB, glXGetProcAddress('glWeightdvARB'));
     glWeightubvARB := SYSTEM.VAL(TglWeightubvARB, glXGetProcAddress('glWeightubvARB'));
     glWeightusvARB := SYSTEM.VAL(TglWeightusvARB, glXGetProcAddress('glWeightusvARB'));
     glWeightuivARB := SYSTEM.VAL(TglWeightuivARB, glXGetProcAddress('glWeightuivARB'));
     glWeightPointerARB := SYSTEM.VAL(TglWeightPointerARB, glXGetProcAddress('glWeightPointerARB'));
     glVertexBlendARB := SYSTEM.VAL(TglVertexBlendARB, glXGetProcAddress('glVertexBlendARB'));
END Read_GL_ARB_vertex_blend;

PROCEDURE Read_GL_ARB_vertex_buffer_object;
BEGIN
     glBindBufferARB := SYSTEM.VAL(TglBindBufferARB, glXGetProcAddress('glBindBufferARB'));
     glDeleteBuffersARB := SYSTEM.VAL(TglDeleteBuffersARB, glXGetProcAddress('glDeleteBuffersARB'));
     glGenBuffersARB := SYSTEM.VAL(TglGenBuffersARB, glXGetProcAddress('glGenBuffersARB'));
     glIsBufferARB := SYSTEM.VAL(TglIsBufferARB, glXGetProcAddress('glIsBufferARB'));
     glBufferDataARB := SYSTEM.VAL(TglBufferDataARB, glXGetProcAddress('glBufferDataARB'));
     glBufferSubDataARB := SYSTEM.VAL(TglBufferSubData, glXGetProcAddress('glBufferSubDataARB'));
     glGetBufferSubDataARB := SYSTEM.VAL(TglGetBufferSubDataARB, glXGetProcAddress('glGetBufferSubDataARB'));
     glMapBufferARB := SYSTEM.VAL(TglMapBufferARB, glXGetProcAddress('glMapBufferARB'));
     glUnmapBufferARB := SYSTEM.VAL(TglUnmapBufferARB, glXGetProcAddress('glUnmapBufferARB'));
     glGetBufferParameterivARB := SYSTEM.VAL(TglGetBufferParameterivARB, glXGetProcAddress('glGetBufferParameterivARB'));
     glGetBufferPointervARB := SYSTEM.VAL(TglGetBufferPointervARB, glXGetProcAddress('glGetBufferPointervARB'));
END Read_GL_ARB_vertex_buffer_object;

PROCEDURE Read_GL_ARB_vertex_program;
BEGIN
     glVertexAttrib1dARB := SYSTEM.VAL(TglVertexAttrib1dARB, glXGetProcAddress('glVertexAttrib1dARB'));
     glVertexAttrib1dvARB := SYSTEM.VAL(TglVertexAttrib1dvARB, glXGetProcAddress('glVertexAttrib1dvARB'));
     glVertexAttrib1fARB := SYSTEM.VAL(TglVertexAttrib1fARB, glXGetProcAddress('glVertexAttrib1fARB'));
     glVertexAttrib1fvARB := SYSTEM.VAL(TglVertexAttrib1fvARB, glXGetProcAddress('glVertexAttrib1fvARB'));
     glVertexAttrib1sARB := SYSTEM.VAL(TglVertexAttrib1sARB, glXGetProcAddress('glVertexAttrib1sARB'));
     glVertexAttrib1svARB := SYSTEM.VAL(TglVertexAttrib1svARB, glXGetProcAddress('glVertexAttrib1svARB'));
     glVertexAttrib2dARB := SYSTEM.VAL(TglVertexAttrib2dARB, glXGetProcAddress('glVertexAttrib2dARB'));
     glVertexAttrib2dvARB := SYSTEM.VAL(TglVertexAttrib2dvARB, glXGetProcAddress('glVertexAttrib2dvARB'));
     glVertexAttrib2fARB := SYSTEM.VAL(TglVertexAttrib2fARB, glXGetProcAddress('glVertexAttrib2fARB'));
     glVertexAttrib2fvARB := SYSTEM.VAL(TglVertexAttrib2fvARB, glXGetProcAddress('glVertexAttrib2fvARB'));
     glVertexAttrib2sARB := SYSTEM.VAL(TglVertexAttrib2sARB, glXGetProcAddress('glVertexAttrib2sARB'));
     glVertexAttrib2svARB := SYSTEM.VAL(TglVertexAttrib2svARB, glXGetProcAddress('glVertexAttrib2svARB'));
     glVertexAttrib3dARB := SYSTEM.VAL(TglVertexAttrib3dARB, glXGetProcAddress('glVertexAttrib3dARB'));
     glVertexAttrib3dvARB := SYSTEM.VAL(TglVertexAttrib3dvARB, glXGetProcAddress('glVertexAttrib3dvARB'));
     glVertexAttrib3fARB := SYSTEM.VAL(TglVertexAttrib3fARB, glXGetProcAddress('glVertexAttrib3fARB'));
     glVertexAttrib3fvARB := SYSTEM.VAL(TglVertexAttrib3fvARB, glXGetProcAddress('glVertexAttrib3fvARB'));
     glVertexAttrib3sARB := SYSTEM.VAL(TglVertexAttrib3sARB, glXGetProcAddress('glVertexAttrib3sARB'));
     glVertexAttrib3svARB := SYSTEM.VAL(TglVertexAttrib3svARB, glXGetProcAddress('glVertexAttrib3svARB'));
     glVertexAttrib4NbvARB := SYSTEM.VAL(TglVertexAttrib4NbvARB, glXGetProcAddress('glVertexAttrib4NbvARB'));
     glVertexAttrib4NivARB := SYSTEM.VAL(TglVertexAttrib4NivARB, glXGetProcAddress('glVertexAttrib4NivARB'));
     glVertexAttrib4NsvARB := SYSTEM.VAL(TglVertexAttrib4NsvARB, glXGetProcAddress('glVertexAttrib4NsvARB'));
     glVertexAttrib4NubARB := SYSTEM.VAL(TglVertexAttrib4NubARB, glXGetProcAddress('glVertexAttrib4NubARB'));
     glVertexAttrib4NubvARB := SYSTEM.VAL(TglVertexAttrib4NubvARB, glXGetProcAddress('glVertexAttrib4NubvARB'));
     glVertexAttrib4NuivARB := SYSTEM.VAL(TglVertexAttrib4NuivARB, glXGetProcAddress('glVertexAttrib4NuivARB'));
     glVertexAttrib4NusvARB := SYSTEM.VAL(TglVertexAttrib4NusvARB, glXGetProcAddress('glVertexAttrib4NusvARB'));
     glVertexAttrib4bvARB := SYSTEM.VAL(TglVertexAttrib4bvARB, glXGetProcAddress('glVertexAttrib4bvARB'));
     glVertexAttrib4dARB := SYSTEM.VAL(TglVertexAttrib4dARB, glXGetProcAddress('glVertexAttrib4dARB'));
     glVertexAttrib4dvARB := SYSTEM.VAL(TglVertexAttrib4dvARB, glXGetProcAddress('glVertexAttrib4dvARB'));
     glVertexAttrib4fARB := SYSTEM.VAL(TglVertexAttrib4fARB, glXGetProcAddress('glVertexAttrib4fARB'));
     glVertexAttrib4fvARB := SYSTEM.VAL(TglVertexAttrib4fvARB, glXGetProcAddress('glVertexAttrib4fvARB'));
     glVertexAttrib4ivARB := SYSTEM.VAL(TglVertexAttrib4ivARB, glXGetProcAddress('glVertexAttrib4ivARB'));
     glVertexAttrib4sARB := SYSTEM.VAL(TglVertexAttrib4sARB, glXGetProcAddress('glVertexAttrib4sARB'));
     glVertexAttrib4svARB := SYSTEM.VAL(TglVertexAttrib4svARB, glXGetProcAddress('glVertexAttrib4svARB'));
     glVertexAttrib4ubvARB := SYSTEM.VAL(TglVertexAttrib4ubvARB, glXGetProcAddress('glVertexAttrib4ubvARB'));
     glVertexAttrib4uivARB := SYSTEM.VAL(TglVertexAttrib4uivARB, glXGetProcAddress('glVertexAttrib4uivARB'));
     glVertexAttrib4usvARB := SYSTEM.VAL(TglVertexAttrib4usvARB, glXGetProcAddress('glVertexAttrib4usvARB'));
     glVertexAttribPointerARB := SYSTEM.VAL(TglVertexAttribPointerARB, glXGetProcAddress('glVertexAttribPointerARB'));
     glEnableVertexAttribArrayARB := SYSTEM.VAL(TglEnableVertexAttribArrayARB, glXGetProcAddress('glEnableVertexAttribArrayARB'));
     glDisableVertexAttribArrayARB := SYSTEM.VAL(TglDisableVertexAttribArrayARB, glXGetProcAddress('glDisableVertexAttribArrayARB'));
     glProgramStringARB := SYSTEM.VAL(TglProgramStringARB, glXGetProcAddress('glProgramStringARB'));
     glBindProgramARB := SYSTEM.VAL(TglBindProgramARB, glXGetProcAddress('glBindProgramARB'));
     glDeleteProgramsARB := SYSTEM.VAL(TglDeleteProgramsARB, glXGetProcAddress('glDeleteProgramsARB'));
     glGenProgramsARB := SYSTEM.VAL(TglGenProgramsARB, glXGetProcAddress('glGenProgramsARB'));
     glProgramEnvParameter4dARB := SYSTEM.VAL(TglProgramEnvParameter4dARB, glXGetProcAddress('glProgramEnvParameter4dARB'));
     glProgramEnvParameter4dvARB := SYSTEM.VAL(TglProgramEnvParameter4dvARB, glXGetProcAddress('glProgramEnvParameter4dvARB'));
     glProgramEnvParameter4fARB := SYSTEM.VAL(TglProgramEnvParameter4fARB, glXGetProcAddress('glProgramEnvParameter4fARB'));
     glProgramEnvParameter4fvARB := SYSTEM.VAL(TglProgramEnvParameter4fvARB, glXGetProcAddress('glProgramEnvParameter4fvARB'));
     glProgramLocalParameter4dARB := SYSTEM.VAL(TglProgramLocalParameter4dARB, glXGetProcAddress('glProgramLocalParameter4dARB'));
     glProgramLocalParameter4dvARB := SYSTEM.VAL(TglProgramLocalParameter4dvARB, glXGetProcAddress('glProgramLocalParameter4dvARB'));
     glProgramLocalParameter4fARB := SYSTEM.VAL(TglProgramLocalParameter4fARB, glXGetProcAddress('glProgramLocalParameter4fARB'));
     glProgramLocalParameter4fvARB := SYSTEM.VAL(TglProgramLocalParameter4fvARB, glXGetProcAddress('glProgramLocalParameter4fvARB'));
     glGetProgramEnvParameterdvARB := SYSTEM.VAL(TglGetProgramEnvParameterdvARB, glXGetProcAddress('glGetProgramEnvParameterdvARB'));
     glGetProgramEnvParameterfvARB := SYSTEM.VAL(TglGetProgramEnvParameterfvARB, glXGetProcAddress('glGetProgramEnvParameterfvARB'));
     glGetProgramLocalParameterdvARB := SYSTEM.VAL(TglGetProgramLocalParameterdvARB, glXGetProcAddress('glGetProgramLocalParameterdvARB'));
     glGetProgramLocalParameterfvARB := SYSTEM.VAL(TglGetProgramLocalParameterfvARB, glXGetProcAddress('glGetProgramLocalParameterfvARB'));
     glGetProgramivARB := SYSTEM.VAL(TglGetProgramivARB, glXGetProcAddress('glGetProgramivARB'));
     glGetProgramStringARB := SYSTEM.VAL(TglGetProgramStringARB, glXGetProcAddress('glGetProgramStringARB'));
     glGetVertexAttribdvARB := SYSTEM.VAL(TglGetVertexAttribdvARB, glXGetProcAddress('glGetVertexAttribdvARB'));
     glGetVertexAttribfvARB := SYSTEM.VAL(TglGetVertexAttribfvARB, glXGetProcAddress('glGetVertexAttribfvARB'));
     glGetVertexAttribivARB := SYSTEM.VAL(TglGetVertexAttribivARB, glXGetProcAddress('glGetVertexAttribivARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, glXGetProcAddress('glGetVertexAttribPointervARB'));
     glIsProgramARB := SYSTEM.VAL(TglIsProgramARB, glXGetProcAddress('glIsProgramARB'));
END Read_GL_ARB_vertex_program;

PROCEDURE Read_GL_ARB_window_pos;
BEGIN
     glWindowPos2dARB := SYSTEM.VAL(TglWindowPos2dARB, glXGetProcAddress('glWindowPos2dARB'));
     glWindowPos2dvARB := SYSTEM.VAL(TglWindowPos2dvARB, glXGetProcAddress('glWindowPos2dvARB'));
     glWindowPos2fARB := SYSTEM.VAL(TglWindowPos2fARB, glXGetProcAddress('glWindowPos2fARB'));
     glWindowPos2fvARB := SYSTEM.VAL(TglWindowPos2fvARB, glXGetProcAddress('glWindowPos2fvARB'));
     glWindowPos2iARB := SYSTEM.VAL(TglWindowPos2iARB, glXGetProcAddress('glWindowPos2iARB'));
     glWindowPos2ivARB := SYSTEM.VAL(TglWindowPos2ivARB, glXGetProcAddress('glWindowPos2ivARB'));
     glWindowPos2sARB := SYSTEM.VAL(TglWindowPos2sARB, glXGetProcAddress('glWindowPos2sARB'));
     glWindowPos2svARB := SYSTEM.VAL(TglWindowPos2svARB, glXGetProcAddress('glWindowPos2svARB'));
     glWindowPos3dARB := SYSTEM.VAL(TglWindowPos3dARB, glXGetProcAddress('glWindowPos3dARB'));
     glWindowPos3dvARB := SYSTEM.VAL(TglWindowPos3dvARB, glXGetProcAddress('glWindowPos3dvARB'));
     glWindowPos3fARB := SYSTEM.VAL(TglWindowPos3fARB, glXGetProcAddress('glWindowPos3fARB'));
     glWindowPos3fvARB := SYSTEM.VAL(TglWindowPos3fvARB, glXGetProcAddress('glWindowPos3fvARB'));
     glWindowPos3iARB := SYSTEM.VAL(TglWindowPos3iARB, glXGetProcAddress('glWindowPos3iARB'));
     glWindowPos3ivARB := SYSTEM.VAL(TglWindowPos3ivARB, glXGetProcAddress('glWindowPos3ivARB'));
     glWindowPos3sARB := SYSTEM.VAL(TglWindowPos3sARB, glXGetProcAddress('glWindowPos3sARB'));
     glWindowPos3svARB := SYSTEM.VAL(TglWindowPos3svARB, glXGetProcAddress('glWindowPos3svARB'));
END Read_GL_ARB_window_pos;

PROCEDURE Read_GL_ARB_draw_buffers;
BEGIN
     glDrawBuffersARB := SYSTEM.VAL(TglDrawBuffersARB, glXGetProcAddress('glDrawBuffersARB'));
END Read_GL_ARB_draw_buffers;

PROCEDURE Read_GL_ARB_color_buffer_float;
BEGIN
     glClampColorARB := SYSTEM.VAL(TglClampColorARB, glXGetProcAddress('glClampColorARB'));
END Read_GL_ARB_color_buffer_float;

PROCEDURE Read_GL_ARB_Shader_Objects;
BEGIN
(*  GL_ARB_Shader_Objects *)
     glCreateShaderObjectARB := SYSTEM.VAL(TglCreateShaderObjectARB, glXGetProcAddress('glCreateShaderObjectARB'));
     glShaderSourceARB := SYSTEM.VAL(TglShaderSourceARB, glXGetProcAddress('glShaderSourceARB'));
     glCompileShaderARB := SYSTEM.VAL(TglCompileShaderARB, glXGetProcAddress('glCompileShaderARB'));
     glDeleteObjectARB := SYSTEM.VAL(TglDeleteObjectARB, glXGetProcAddress('glDeleteObjectARB'));
     glGetHandleARB := SYSTEM.VAL(TglGetHandleARB, glXGetProcAddress('glGetHandleARB'));
     glDetachObjectARB := SYSTEM.VAL(TglDetachObjectARB, glXGetProcAddress('glDetachObjectARB'));
     glCreateProgramObjectARB := SYSTEM.VAL(TglCreateProgramObjectARB, glXGetProcAddress('glCreateProgramObjectARB'));
     glAttachObjectARB := SYSTEM.VAL(TglAttachObjectARB, glXGetProcAddress('glAttachObjectARB'));
     glLinkProgramARB := SYSTEM.VAL(TglLinkProgramARB, glXGetProcAddress('glLinkProgramARB'));
     glUseProgramObjectARB := SYSTEM.VAL(TglUseProgramObjectARB, glXGetProcAddress('glUseProgramObjectARB'));
     glValidateProgramARB := SYSTEM.VAL(TglValidateProgramARB, glXGetProcAddress('glValidateProgramARB'));
     glGetObjectParameterfvARB := SYSTEM.VAL(TglGetObjectParameterfvARB, glXGetProcAddress('glGetObjectParameterfvARB'));
     glGetObjectParameterivARB := SYSTEM.VAL(TglGetObjectParameterivARB, glXGetProcAddress('glGetObjectParameterivARB'));
     glGetActiveUniformARB := SYSTEM.VAL(TglGetActiveUniformARB, glXGetProcAddress('glGetActiveUniformARB'));
     glGetAttachedObjectsARB := SYSTEM.VAL(TglGetAttachedObjectsARB, glXGetProcAddress('glGetAttachedObjectsARB'));
     glGetShaderSourceARB := SYSTEM.VAL(TglGetShaderSourceARB, glXGetProcAddress('glGetShaderSourceARB'));
     glGetUniformfvARB := SYSTEM.VAL(TglGetUniformfvARB, glXGetProcAddress('glGetUniformfvARB'));
     glGetUniformivARB := SYSTEM.VAL(TglGetUniformivARB, glXGetProcAddress('glGetUniformivARB'));
     glGetUniformLocationARB := SYSTEM.VAL(TglGetUniformLocationARB, glXGetProcAddress('glGetUniformLocationARB'));
     glGetInfoLogARB := SYSTEM.VAL(TglGetInfoLogARB, glXGetProcAddress('glGetInfoLogARB'));
     glUniform1fARB := SYSTEM.VAL(TglUniform1fARB, glXGetProcAddress('glUniform1fARB'));
     glUniform2fARB := SYSTEM.VAL(TglUniform2fARB, glXGetProcAddress('glUniform2fARB'));
     glUniform3fARB := SYSTEM.VAL(TglUniform3fARB, glXGetProcAddress('glUniform3fARB'));
     glUniform4fARB := SYSTEM.VAL(TglUniform4fARB, glXGetProcAddress('glUniform4fARB'));
     glUniform1iARB := SYSTEM.VAL(TglUniform1iARB, glXGetProcAddress('glUniform1iARB'));
     glUniform2iARB := SYSTEM.VAL(TglUniform2iARB, glXGetProcAddress('glUniform2iARB'));
     glUniform3iARB := SYSTEM.VAL(TglUniform3iARB, glXGetProcAddress('glUniform3iARB'));
     glUniform4iARB := SYSTEM.VAL(TglUniform4iARB, glXGetProcAddress('glUniform4iARB'));
     glUniform1fvARB := SYSTEM.VAL(TglUniform1fvARB, glXGetProcAddress('glUniform1fvARB'));
     glUniform2fvARB := SYSTEM.VAL(TglUniform2fvARB, glXGetProcAddress('glUniform2fvARB'));
     glUniform3fvARB := SYSTEM.VAL(TglUniform3fvARB, glXGetProcAddress('glUniform3fvARB'));
     glUniform4fvARB := SYSTEM.VAL(TglUniform4fvARB, glXGetProcAddress('glUniform4fvARB'));
     glUniform1ivARB := SYSTEM.VAL(TglUniform1ivARB, glXGetProcAddress('glUniform1ivARB'));
     glUniform2ivARB := SYSTEM.VAL(TglUniform2ivARB, glXGetProcAddress('glUniform2ivARB'));
     glUniform3ivARB := SYSTEM.VAL(TglUniform3ivARB, glXGetProcAddress('glUniform3ivARB'));
     glUniform4ivARB := SYSTEM.VAL(TglUniform4ivARB, glXGetProcAddress('glUniform4ivARB'));
     glUniformMatrix2fvARB := SYSTEM.VAL(TglUniformMatrix2fvARB, glXGetProcAddress('glUniformMatrix2fvARB'));
     glUniformMatrix3fvARB := SYSTEM.VAL(TglUniformMatrix3fvARB, glXGetProcAddress('glUniformMatrix3fvARB'));
     glUniformMatrix4fvARB := SYSTEM.VAL(TglUniformMatrix4fvARB, glXGetProcAddress('glUniformMatrix4fvARB'));
     
	(* GL_ARB_vertex_shader *)
     glGetActiveAttribARB := SYSTEM.VAL(TglGetActiveAttribARB, glXGetProcAddress('glGetActiveAttribARB'));
     glGetAttribLocationARB := SYSTEM.VAL(TglGetAttribLocationARB, glXGetProcAddress('glGetAttribLocationARB'));
     glBindAttribLocationARB := SYSTEM.VAL(TglBindAttribLocationARB, glXGetProcAddress('glBindAttribLocationARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, glXGetProcAddress('glGetVertexAttribPointervARB'));
END Read_GL_ARB_Shader_Objects;

PROCEDURE Read_GL_ARB_occlusion_query;
BEGIN
     glGenQueriesARB := SYSTEM.VAL(TglGenQueriesARB, glXGetProcAddress('glGenQueriesARB'));
     glDeleteQueriesARB := SYSTEM.VAL(TglDeleteQueriesARB, glXGetProcAddress('glDeleteQueriesARB'));
     glIsQueryARB := SYSTEM.VAL(TglIsQueryARB, glXGetProcAddress('glIsQueryARB'));
     glBeginQueryARB := SYSTEM.VAL(TglBeginQueryARB, glXGetProcAddress('glBeginQueryARB'));
     glEndQueryARB := SYSTEM.VAL(TglEndQueryARB, glXGetProcAddress('glEndQueryARB'));
     glGetQueryivARB := SYSTEM.VAL(TglGetQueryivARB, glXGetProcAddress('glGetQueryivARB'));
     glGetQueryObjectivARB := SYSTEM.VAL(TglGetQueryObjectivARB, glXGetProcAddress('glGetQueryObjectivARB'));
     glGetQueryObjectuivARB := SYSTEM.VAL(TglGetQueryObjectuivARB, glXGetProcAddress('glGetQueryObjectuivARB'));
END Read_GL_ARB_occlusion_query;

PROCEDURE Read_GL_ARB_draw_instanced;
BEGIN
     glDrawArraysInstancedARB := SYSTEM.VAL(TglDrawArraysInstancedARB, glXGetProcAddress('glDrawArraysInstancedARB'));
     glDrawElementsInstancedARB := SYSTEM.VAL(TglDrawElementsInstancedARB, glXGetProcAddress('glDrawElementsInstancedARB'));
END Read_GL_ARB_draw_instanced;

PROCEDURE Read_GL_ARB_framebuffer_object;
BEGIN
     glIsRenderbuffer := SYSTEM.VAL(TglIsRenderbuffer, glXGetProcAddress('glIsRenderbuffer'));
     glBindRenderbuffer := SYSTEM.VAL(TglBindRenderbuffer, glXGetProcAddress('glBindRenderbuffer'));
     glDeleteRenderbuffers := SYSTEM.VAL(TglDeleteRenderbuffers, glXGetProcAddress('glDeleteRenderbuffers'));
     glGenRenderbuffers := SYSTEM.VAL(TglGenRenderbuffers, glXGetProcAddress('glGenRenderbuffers'));
     glRenderbufferStorage := SYSTEM.VAL(TglRenderbufferStorage, glXGetProcAddress('glRenderbufferStorage'));
     glGetRenderbufferParameteriv := SYSTEM.VAL(TglGetRenderbufferParameteriv, glXGetProcAddress('glGetRenderbufferParameteriv'));
     glIsFramebuffer := SYSTEM.VAL(TglIsFramebuffer, glXGetProcAddress('glIsFramebuffer'));
     glBindFramebuffer := SYSTEM.VAL(TglBindFramebuffer, glXGetProcAddress('glBindFramebuffer'));
     glDeleteFramebuffers := SYSTEM.VAL(TglDeleteFramebuffers, glXGetProcAddress('glDeleteFramebuffers'));
     glGenFramebuffers := SYSTEM.VAL(TglGenFramebuffers, glXGetProcAddress('glGenFramebuffers'));
     glCheckFramebufferStatus := SYSTEM.VAL(TglCheckFramebufferStatus, glXGetProcAddress('glCheckFramebufferStatus'));
     glFramebufferTexture1D := SYSTEM.VAL(TglFramebufferTexture1D, glXGetProcAddress('glFramebufferTexture1D'));
     glFramebufferTexture2D := SYSTEM.VAL(TglFramebufferTexture2D, glXGetProcAddress('glFramebufferTexture2D'));
     glFramebufferTexture3D := SYSTEM.VAL(TglFramebufferTexture3D, glXGetProcAddress('glFramebufferTexture3D'));
     glFramebufferRenderbuffer := SYSTEM.VAL(TglFramebufferRenderbuffer, glXGetProcAddress('glFramebufferRenderbuffer'));
     glGetFramebufferAttachmentParameteriv := SYSTEM.VAL(TglGetFramebufferAttachmentParameteriv, glXGetProcAddress('glGetFramebufferAttachmentParameteriv'));
     glGenerateMipmap := SYSTEM.VAL(TglGenerateMipmap, glXGetProcAddress('glGenerateMipmap'));
     glBlitFramebuffer := SYSTEM.VAL(TglBlitFramebuffer, glXGetProcAddress('glBlitFramebuffer'));
     glRenderbufferStorageMultisample := SYSTEM.VAL(TglRenderbufferStorageMultisample, glXGetProcAddress('glRenderbufferStorageMultisample'));
     glFramebufferTextureLayer := SYSTEM.VAL(TglFramebufferTextureLayer, glXGetProcAddress('glFramebufferTextureLayer'));
END Read_GL_ARB_framebuffer_object;

PROCEDURE Read_GL_ARB_geometry_shader4;
BEGIN
     glProgramParameteriARB := SYSTEM.VAL(TglProgramParameteriARB, glXGetProcAddress('glProgramParameteriARB'));
     glFramebufferTextureARB := SYSTEM.VAL(TglFramebufferTextureARB, glXGetProcAddress('glFramebufferTextureARB'));
     glFramebufferTextureLayerARB := SYSTEM.VAL(TglFramebufferTextureLayerARB, glXGetProcAddress('glFramebufferTextureLayerARB'));
     glFramebufferTextureFaceARB := SYSTEM.VAL(TglFramebufferTextureFaceARB, glXGetProcAddress('glFramebufferTextureFaceARB'));
END Read_GL_ARB_geometry_shader4;

PROCEDURE Read_GL_ARB_instanced_arrays;
BEGIN
     glVertexAttribDivisorARB := SYSTEM.VAL(TglVertexAttribDivisorARB, glXGetProcAddress('glVertexAttribDivisorARB'));
END Read_GL_ARB_instanced_arrays;

PROCEDURE Read_GL_ARB_map_buffer_range;
BEGIN
     glMapBufferRange := SYSTEM.VAL(TglMapBufferRange, glXGetProcAddress('glMapBufferRange'));
     glFlushMappedBufferRange := SYSTEM.VAL(TglFlushMappedBufferRange, glXGetProcAddress('glFlushMappedBufferRange'));
END Read_GL_ARB_map_buffer_range;

PROCEDURE Read_GL_ARB_texture_buffer_object;
BEGIN
     glTexBufferARB := SYSTEM.VAL(TglTexBufferARB, glXGetProcAddress('glTexBufferARB'));
END Read_GL_ARB_texture_buffer_object;

PROCEDURE Read_GL_ARB_vertex_array_object;
BEGIN
     glBindVertexArray := SYSTEM.VAL(TglBindVertexArray, glXGetProcAddress('glBindVertexArray'));
     glDeleteVertexArrays := SYSTEM.VAL(TglDeleteVertexArrays, glXGetProcAddress('glDeleteVertexArrays'));
     glGenVertexArrays := SYSTEM.VAL(TglGenVertexArrays, glXGetProcAddress('glGenVertexArrays'));
     glIsVertexArray := SYSTEM.VAL(TglIsVertexArray, glXGetProcAddress('glIsVertexArray'));
END Read_GL_ARB_vertex_array_object;

PROCEDURE Read_GL_ARB_uniform_buffer_object;
BEGIN
     glGetUniformIndices := SYSTEM.VAL(TglGetUniformIndices, glXGetProcAddress('glGetUniformIndices'));
     glGetActiveUniformsiv := SYSTEM.VAL(TglGetActiveUniformsiv, glXGetProcAddress('glGetActiveUniformsiv'));
     glGetActiveUniformName := SYSTEM.VAL(TglGetActiveUniformName, glXGetProcAddress('glGetActiveUniformName'));
     glGetUniformBlockIndex := SYSTEM.VAL(TglGetUniformBlockIndex, glXGetProcAddress('glGetUniformBlockIndex'));
     glGetActiveUniformBlockiv := SYSTEM.VAL(TglGetActiveUniformBlockiv, glXGetProcAddress('glGetActiveUniformBlockiv'));
     glGetActiveUniformBlockName := SYSTEM.VAL(TglGetActiveUniformBlockName, glXGetProcAddress('glGetActiveUniformBlockName'));
     glUniformBlockBinding := SYSTEM.VAL(TglUniformBlockBinding, glXGetProcAddress('glUniformBlockBinding'));
END Read_GL_ARB_uniform_buffer_object;

PROCEDURE Read_GL_ARB_copy_buffer;
BEGIN
     glCopyBufferSubData := SYSTEM.VAL(TglCopyBufferSubData, glXGetProcAddress('glCopyBufferSubData'));
END Read_GL_ARB_copy_buffer;

PROCEDURE Read_GL_ARB_draw_elements_base_vertex;
BEGIN
     glDrawElementsBaseVertex := SYSTEM.VAL(TglDrawElementsBaseVertex, glXGetProcAddress('glDrawElementsBaseVertex'));
     glDrawRangeElementsBaseVertex := SYSTEM.VAL(TglDrawRangeElementsBaseVertex, glXGetProcAddress('glDrawRangeElementsBaseVertex'));
     glDrawElementsInstancedBaseVertex := SYSTEM.VAL(TglDrawElementsInstancedBaseVertex, glXGetProcAddress('glDrawElementsInstancedBaseVertex'));
     glMultiDrawElementsBaseVertex := SYSTEM.VAL(TglMultiDrawElementsBaseVertex, glXGetProcAddress('glMultiDrawElementsBaseVertex'));
END Read_GL_ARB_draw_elements_base_vertex;

PROCEDURE Read_GL_ARB_provoking_vertex;
BEGIN
     glProvokingVertex := SYSTEM.VAL(TglProvokingVertex, glXGetProcAddress('glProvokingVertex'));
END Read_GL_ARB_provoking_vertex;

PROCEDURE Read_GL_ARB_sync;
BEGIN
     glFenceSync := SYSTEM.VAL(TglFenceSync, glXGetProcAddress('glFenceSync'));
     glIsSync := SYSTEM.VAL(TglIsSync, glXGetProcAddress('glIsSync'));
     glDeleteSync := SYSTEM.VAL(TglDeleteSync, glXGetProcAddress('glDeleteSync'));
     glClientWaitSync := SYSTEM.VAL(TglClientWaitSync, glXGetProcAddress('glClientWaitSync'));
     glWaitSync := SYSTEM.VAL(TglWaitSync, glXGetProcAddress('glWaitSync'));
     glGetInteger64v := SYSTEM.VAL(TglGetInteger64v, glXGetProcAddress('glGetInteger64v'));
     glGetSynciv := SYSTEM.VAL(TglGetSynciv, glXGetProcAddress('glGetSynciv'));
END Read_GL_ARB_sync;

PROCEDURE Read_GL_ARB_texture_multisample;
BEGIN
     glTexImage2DMultisample := SYSTEM.VAL(TglTexImage2DMultisample, glXGetProcAddress('glTexImage2DMultisample'));
     glTexImage3DMultisample := SYSTEM.VAL(TglTexImage3DMultisample, glXGetProcAddress('glTexImage3DMultisample'));
     glGetMultisamplefv := SYSTEM.VAL(TglGetMultisamplefv, glXGetProcAddress('glGetMultisamplefv'));
     glSampleMaski := SYSTEM.VAL(TglSampleMaski, glXGetProcAddress('glSampleMaski'));
END Read_GL_ARB_texture_multisample;

PROCEDURE Read_GL_ARB_draw_buffers_blend;
BEGIN
     glBlendEquationiARB := SYSTEM.VAL(TglBlendEquationiARB, glXGetProcAddress('glBlendEquationiARB'));
     glBlendEquationSeparateiARB := SYSTEM.VAL(TglBlendEquationSeparateiARB, glXGetProcAddress('glBlendEquationSeparateiARB'));
     glBlendFunciARB := SYSTEM.VAL(TglBlendFunciARB, glXGetProcAddress('glBlendFunciARB'));
     glBlendFuncSeparateiARB := SYSTEM.VAL(TglBlendFuncSeparateiARB, glXGetProcAddress('glBlendFuncSeparateiARB'));
END Read_GL_ARB_draw_buffers_blend;

PROCEDURE Read_GL_ARB_sample_shading;
BEGIN
     glMinSampleShadingARB := SYSTEM.VAL(TglMinSampleShadingARB, glXGetProcAddress('glMinSampleShadingARB'));
END Read_GL_ARB_sample_shading;

PROCEDURE Read_GL_ARB_shading_language_include;
BEGIN
     glNamedStringARB := SYSTEM.VAL(TglNamedStringARB, glXGetProcAddress('glNamedStringARB'));
     glDeleteNamedStringARB := SYSTEM.VAL(TglDeleteNamedStringARB, glXGetProcAddress('glDeleteNamedStringARB'));
     glCompileShaderIncludeARB := SYSTEM.VAL(TglCompileShaderIncludeARB, glXGetProcAddress('glCompileShaderIncludeARB'));
     glIsNamedStringARB := SYSTEM.VAL(TglIsNamedStringARB, glXGetProcAddress('glIsNamedStringARB'));
     glGetNamedStringARB := SYSTEM.VAL(TglGetNamedStringARB, glXGetProcAddress('glGetNamedStringARB'));
     glGetNamedStringivARB := SYSTEM.VAL(TglGetNamedStringivARB, glXGetProcAddress('glGetNamedStringivARB'));
END Read_GL_ARB_shading_language_include;

PROCEDURE Read_GL_ARB_blend_func_extended;
BEGIN
     glBindFragDataLocationIndexed := SYSTEM.VAL(TglBindFragDataLocationIndexed, glXGetProcAddress('glBindFragDataLocationIndexed'));
     glGetFragDataIndex := SYSTEM.VAL(TglGetFragDataIndex, glXGetProcAddress('glGetFragDataIndex'));
END Read_GL_ARB_blend_func_extended;

PROCEDURE Read_GL_ARB_sampler_objects;
BEGIN
     glGenSamplers := SYSTEM.VAL(TglGenSamplers, glXGetProcAddress('glGenSamplers'));
     glDeleteSamplers := SYSTEM.VAL(TglDeleteSamplers, glXGetProcAddress('glDeleteSamplers'));
     glIsSampler := SYSTEM.VAL(TglIsSampler, glXGetProcAddress('glIsSampler'));
     glBindSampler := SYSTEM.VAL(TglBindSampler, glXGetProcAddress('glBindSampler'));
     glSamplerParameteri := SYSTEM.VAL(TglSamplerParameteri, glXGetProcAddress('glSamplerParameteri'));
     glSamplerParameteriv := SYSTEM.VAL(TglSamplerParameteriv, glXGetProcAddress('glSamplerParameteriv'));
     glSamplerParameterf := SYSTEM.VAL(TglSamplerParameterf, glXGetProcAddress('glSamplerParameterf'));
     glSamplerParameterfv := SYSTEM.VAL(TglSamplerParameterfv, glXGetProcAddress('glSamplerParameterfv'));
     glSamplerParameterIiv := SYSTEM.VAL(TglSamplerParameterIiv, glXGetProcAddress('glSamplerParameterIiv'));
     glSamplerParameterIuiv := SYSTEM.VAL(TglSamplerParameterIuiv, glXGetProcAddress('glSamplerParameterIuiv'));
     glGetSamplerParameteriv := SYSTEM.VAL(TglGetSamplerParameteriv, glXGetProcAddress('glGetSamplerParameteriv'));
     glGetSamplerParameterIiv := SYSTEM.VAL(TglGetSamplerParameterIiv, glXGetProcAddress('glGetSamplerParameterIiv'));
     glGetSamplerParameterfv := SYSTEM.VAL(TglGetSamplerParameterfv, glXGetProcAddress('glGetSamplerParameterfv'));
     glGetSamplerParameterIuiv := SYSTEM.VAL(TglGetSamplerParameterIuiv, glXGetProcAddress('glGetSamplerParameterIuiv'));
END Read_GL_ARB_sampler_objects;

PROCEDURE Read_GL_ARB_timer_query;
BEGIN
     glQueryCounter := SYSTEM.VAL(TglQueryCounter, glXGetProcAddress('glQueryCounter'));
     glGetQueryObjecti64v := SYSTEM.VAL(TglGetQueryObjecti64v, glXGetProcAddress('glGetQueryObjecti64v'));
     glGetQueryObjectui64v := SYSTEM.VAL(TglGetQueryObjectui64v, glXGetProcAddress('glGetQueryObjectui64v'));
END Read_GL_ARB_timer_query;

PROCEDURE Read_GL_ARB_vertex_type_2_10_10_10_rev;
BEGIN
     glVertexP2ui := SYSTEM.VAL(TglVertexP2ui, glXGetProcAddress('glVertexP2ui'));
     glVertexP2uiv := SYSTEM.VAL(TglVertexP2uiv, glXGetProcAddress('glVertexP2uiv'));
     glVertexP3ui := SYSTEM.VAL(TglVertexP3ui, glXGetProcAddress('glVertexP3ui'));
     glVertexP3uiv := SYSTEM.VAL(TglVertexP3uiv, glXGetProcAddress('glVertexP3uiv'));
     glVertexP4ui := SYSTEM.VAL(TglVertexP4ui, glXGetProcAddress('glVertexP4ui'));
     glVertexP4uiv := SYSTEM.VAL(TglVertexP4uiv, glXGetProcAddress('glVertexP4uiv'));
     glTexCoordP1ui := SYSTEM.VAL(TglTexCoordP1ui, glXGetProcAddress('glTexCoordP1ui'));
     glTexCoordP1uiv := SYSTEM.VAL(TglTexCoordP1uiv, glXGetProcAddress('glTexCoordP1uiv'));
     glTexCoordP2ui := SYSTEM.VAL(TglTexCoordP2ui, glXGetProcAddress('glTexCoordP2ui'));
     glTexCoordP2uiv := SYSTEM.VAL(TglTexCoordP2uiv, glXGetProcAddress('glTexCoordP2uiv'));
     glTexCoordP3ui := SYSTEM.VAL(TglTexCoordP3ui, glXGetProcAddress('glTexCoordP3ui'));
     glTexCoordP3uiv := SYSTEM.VAL(TglTexCoordP3uiv, glXGetProcAddress('glTexCoordP3uiv'));
     glTexCoordP4ui := SYSTEM.VAL(TglTexCoordP4ui, glXGetProcAddress('glTexCoordP4ui'));
     glTexCoordP4uiv := SYSTEM.VAL(TglTexCoordP4uiv, glXGetProcAddress('glTexCoordP4uiv'));
     glMultiTexCoordP1ui := SYSTEM.VAL(TglMultiTexCoordP1ui, glXGetProcAddress('glMultiTexCoordP1ui'));
     glMultiTexCoordP1uiv := SYSTEM.VAL(TglMultiTexCoordP1uiv, glXGetProcAddress('glMultiTexCoordP1uiv'));
     glMultiTexCoordP2ui := SYSTEM.VAL(TglMultiTexCoordP2ui, glXGetProcAddress('glMultiTexCoordP2ui'));
     glMultiTexCoordP2uiv := SYSTEM.VAL(TglMultiTexCoordP2uiv, glXGetProcAddress('glMultiTexCoordP2uiv'));
     glMultiTexCoordP3ui := SYSTEM.VAL(TglMultiTexCoordP3ui, glXGetProcAddress('glMultiTexCoordP3ui'));
     glMultiTexCoordP3uiv := SYSTEM.VAL(TglMultiTexCoordP3uiv, glXGetProcAddress('glMultiTexCoordP3uiv'));
     glMultiTexCoordP4ui := SYSTEM.VAL(TglMultiTexCoordP4ui, glXGetProcAddress('glMultiTexCoordP4ui'));
     glMultiTexCoordP4uiv := SYSTEM.VAL(TglMultiTexCoordP4uiv, glXGetProcAddress('glMultiTexCoordP4uiv'));
     glNormalP3ui := SYSTEM.VAL(TglNormalP3ui, glXGetProcAddress('glNormalP3ui'));
     glNormalP3uiv := SYSTEM.VAL(TglNormalP3uiv, glXGetProcAddress('glNormalP3uiv'));
     glColorP3ui := SYSTEM.VAL(TglColorP3ui, glXGetProcAddress('glColorP3ui'));
     glColorP3uiv := SYSTEM.VAL(TglColorP3uiv, glXGetProcAddress('glColorP3uiv'));
     glColorP4ui := SYSTEM.VAL(TglColorP4ui, glXGetProcAddress('glColorP4ui'));
     glColorP4uiv := SYSTEM.VAL(TglColorP4uiv, glXGetProcAddress('glColorP4uiv'));
     glSecondaryColorP3ui := SYSTEM.VAL(TglSecondaryColorP3ui, glXGetProcAddress('glSecondaryColorP3ui'));
     glSecondaryColorP3uiv := SYSTEM.VAL(TglSecondaryColorP3uiv, glXGetProcAddress('glSecondaryColorP3uiv'));
     glVertexAttribP1ui := SYSTEM.VAL(TglVertexAttribP1ui, glXGetProcAddress('glVertexAttribP1ui'));
     glVertexAttribP1uiv := SYSTEM.VAL(TglVertexAttribP1uiv, glXGetProcAddress('glVertexAttribP1uiv'));
     glVertexAttribP2ui := SYSTEM.VAL(TglVertexAttribP2ui, glXGetProcAddress('glVertexAttribP2ui'));
     glVertexAttribP2uiv := SYSTEM.VAL(TglVertexAttribP2uiv, glXGetProcAddress('glVertexAttribP2uiv'));
     glVertexAttribP3ui := SYSTEM.VAL(TglVertexAttribP3ui, glXGetProcAddress('glVertexAttribP3ui'));
     glVertexAttribP3uiv := SYSTEM.VAL(TglVertexAttribP3uiv, glXGetProcAddress('glVertexAttribP3uiv'));
     glVertexAttribP4ui := SYSTEM.VAL(TglVertexAttribP4ui, glXGetProcAddress('glVertexAttribP4ui'));
     glVertexAttribP4uiv := SYSTEM.VAL(TglVertexAttribP4uiv, glXGetProcAddress('glVertexAttribP4uiv'));
END Read_GL_ARB_vertex_type_2_10_10_10_rev;

PROCEDURE Read_GL_ARB_draw_indirect;
BEGIN
     glDrawArraysIndirect := SYSTEM.VAL(TglDrawArraysIndirect, glXGetProcAddress('glDrawArraysIndirect'));
     glDrawElementsIndirect := SYSTEM.VAL(TglDrawElementsIndirect, glXGetProcAddress('glDrawElementsIndirect'));
END Read_GL_ARB_draw_indirect;

PROCEDURE Read_GL_ARB_gpu_shader_fp64;
BEGIN
     glUniform1d := SYSTEM.VAL(TglUniform1d, glXGetProcAddress('glUniform1d'));
     glUniform2d := SYSTEM.VAL(TglUniform2d, glXGetProcAddress('glUniform2d'));
     glUniform3d := SYSTEM.VAL(TglUniform3d, glXGetProcAddress('glUniform3d'));
     glUniform4d := SYSTEM.VAL(TglUniform4d, glXGetProcAddress('glUniform4d'));
     glUniform1dv := SYSTEM.VAL(TglUniform1dv, glXGetProcAddress('glUniform1dv'));
     glUniform2dv := SYSTEM.VAL(TglUniform2dv, glXGetProcAddress('glUniform2dv'));
     glUniform3dv := SYSTEM.VAL(TglUniform3dv, glXGetProcAddress('glUniform3dv'));
     glUniform4dv := SYSTEM.VAL(TglUniform4dv, glXGetProcAddress('glUniform4dv'));
     glUniformMatrix2dv := SYSTEM.VAL(TglUniformMatrix2dv, glXGetProcAddress('glUniformMatrix2dv'));
     glUniformMatrix3dv := SYSTEM.VAL(TglUniformMatrix3dv, glXGetProcAddress('glUniformMatrix3dv'));
     glUniformMatrix4dv := SYSTEM.VAL(TglUniformMatrix4dv, glXGetProcAddress('glUniformMatrix4dv'));
     glUniformMatrix2x3dv := SYSTEM.VAL(TglUniformMatrix2x3dv, glXGetProcAddress('glUniformMatrix2x3dv'));
     glUniformMatrix2x4dv := SYSTEM.VAL(TglUniformMatrix2x4dv, glXGetProcAddress('glUniformMatrix2x4dv'));
     glUniformMatrix3x2dv := SYSTEM.VAL(TglUniformMatrix3x2dv, glXGetProcAddress('glUniformMatrix3x2dv'));
     glUniformMatrix3x4dv := SYSTEM.VAL(TglUniformMatrix3x4dv, glXGetProcAddress('glUniformMatrix3x4dv'));
     glUniformMatrix4x2dv := SYSTEM.VAL(TglUniformMatrix4x2dv, glXGetProcAddress('glUniformMatrix4x2dv'));
     glUniformMatrix4x3dv := SYSTEM.VAL(TglUniformMatrix4x3dv, glXGetProcAddress('glUniformMatrix4x3dv'));
     glGetUniformdv := SYSTEM.VAL(TglGetUniformdv, glXGetProcAddress('glGetUniformdv'));
END Read_GL_ARB_gpu_shader_fp64;

PROCEDURE Read_GL_ARB_shader_subroutine;
BEGIN
     glGetSubroutineUniformLocation := SYSTEM.VAL(TglGetSubroutineUniformLocation, glXGetProcAddress('glGetSubroutineUniformLocation'));
     glGetSubroutineIndex := SYSTEM.VAL(TglGetSubroutineIndex, glXGetProcAddress('glGetSubroutineIndex'));
     glGetActiveSubroutineUniformiv := SYSTEM.VAL(TglGetActiveSubroutineUniformiv, glXGetProcAddress('glGetActiveSubroutineUniformiv'));
     glGetActiveSubroutineUniformName := SYSTEM.VAL(TglGetActiveSubroutineUniformName, glXGetProcAddress('glGetActiveSubroutineUniformName'));
     glGetActiveSubroutineName := SYSTEM.VAL(TglGetActiveSubroutineName, glXGetProcAddress('glGetActiveSubroutineName'));
     glUniformSubroutinesuiv := SYSTEM.VAL(TglUniformSubroutinesuiv, glXGetProcAddress('glUniformSubroutinesuiv'));
     glGetUniformSubroutineuiv := SYSTEM.VAL(TglGetUniformSubroutineuiv, glXGetProcAddress('glGetUniformSubroutineuiv'));
     glGetProgramStageiv := SYSTEM.VAL(TglGetProgramStageiv, glXGetProcAddress('glGetProgramStageiv'));
END Read_GL_ARB_shader_subroutine;

PROCEDURE Read_GL_ARB_tessellation_shader;
BEGIN
     glPatchParameteri := SYSTEM.VAL(TglPatchParameteri, glXGetProcAddress('glPatchParameteri'));
     glPatchParameterfv := SYSTEM.VAL(TglPatchParameterfv, glXGetProcAddress('glPatchParameterfv'));
END Read_GL_ARB_tessellation_shader;

PROCEDURE Read_GL_ARB_transform_feedback2;
BEGIN
     glBindTransformFeedback := SYSTEM.VAL(TglBindTransformFeedback, glXGetProcAddress('glBindTransformFeedback'));
     glDeleteTransformFeedbacks := SYSTEM.VAL(TglDeleteTransformFeedbacks, glXGetProcAddress('glDeleteTransformFeedbacks'));
     glGenTransformFeedbacks := SYSTEM.VAL(TglGenTransformFeedbacks, glXGetProcAddress('glGenTransformFeedbacks'));
     glIsTransformFeedback := SYSTEM.VAL(TglIsTransformFeedback, glXGetProcAddress('glIsTransformFeedback'));
     glPauseTransformFeedback := SYSTEM.VAL(TglPauseTransformFeedback, glXGetProcAddress('glPauseTransformFeedback'));
     glResumeTransformFeedback := SYSTEM.VAL(TglResumeTransformFeedback, glXGetProcAddress('glResumeTransformFeedback'));
     glDrawTransformFeedback := SYSTEM.VAL(TglDrawTransformFeedback, glXGetProcAddress('glDrawTransformFeedback'));
END Read_GL_ARB_transform_feedback2;

PROCEDURE Read_GL_ARB_transform_feedback3;
BEGIN
     glDrawTransformFeedbackStream := SYSTEM.VAL(TglDrawTransformFeedbackStream, glXGetProcAddress('glDrawTransformFeedbackStream'));
     glBeginQueryIndexed := SYSTEM.VAL(TglBeginQueryIndexed, glXGetProcAddress('glBeginQueryIndexed'));
     glEndQueryIndexed := SYSTEM.VAL(TglEndQueryIndexed, glXGetProcAddress('glEndQueryIndexed'));
     glGetQueryIndexediv := SYSTEM.VAL(TglGetQueryIndexediv, glXGetProcAddress('glGetQueryIndexediv'));
END Read_GL_ARB_transform_feedback3;

PROCEDURE Read_GL_ARB_ES2_compatibility;
BEGIN
     glReleaseShaderCompiler := SYSTEM.VAL(TglReleaseShaderCompiler, glXGetProcAddress('glReleaseShaderCompiler'));
     glShaderBinary := SYSTEM.VAL(TglShaderBinary, glXGetProcAddress('glShaderBinary'));
     glGetShaderPrecisionFormat := SYSTEM.VAL(TglGetShaderPrecisionFormat, glXGetProcAddress('glGetShaderPrecisionFormat'));
     glDepthRangef := SYSTEM.VAL(TglDepthRangef, glXGetProcAddress('glDepthRangef'));
     glClearDepthf := SYSTEM.VAL(TglClearDepthf, glXGetProcAddress('glClearDepthf'));
END Read_GL_ARB_ES2_compatibility;

PROCEDURE Read_GL_ARB_get_program_binary;
BEGIN
     glGetProgramBinary := SYSTEM.VAL(TglGetProgramBinary, glXGetProcAddress('glGetProgramBinary'));
     glProgramBinary := SYSTEM.VAL(TglProgramBinary, glXGetProcAddress('glProgramBinary'));
     glProgramParameteri := SYSTEM.VAL(TglProgramParameteri, glXGetProcAddress('glProgramParameteri'));
END Read_GL_ARB_get_program_binary;

PROCEDURE Read_GL_ARB_separate_shader_objects;
BEGIN
     glUseProgramStages := SYSTEM.VAL(TglUseProgramStages, glXGetProcAddress('glUseProgramStages'));
     glActiveShaderProgram := SYSTEM.VAL(TglActiveShaderProgram, glXGetProcAddress('glActiveShaderProgram'));
     glCreateShaderProgramv := SYSTEM.VAL(TglCreateShaderProgramv, glXGetProcAddress('glCreateShaderProgramv'));
     glBindProgramPipeline := SYSTEM.VAL(TglBindProgramPipeline, glXGetProcAddress('glBindProgramPipeline'));
     glDeleteProgramPipelines := SYSTEM.VAL(TglDeleteProgramPipelines, glXGetProcAddress('glDeleteProgramPipelines'));
     glGenProgramPipelines := SYSTEM.VAL(TglGenProgramPipelines, glXGetProcAddress('glGenProgramPipelines'));
     glIsProgramPipeline := SYSTEM.VAL(TglIsProgramPipeline, glXGetProcAddress('glIsProgramPipeline'));
     glGetProgramPipelineiv := SYSTEM.VAL(TglGetProgramPipelineiv, glXGetProcAddress('glGetProgramPipelineiv'));
     glProgramUniform1i := SYSTEM.VAL(TglProgramUniform1i, glXGetProcAddress('glProgramUniform1i'));
     glProgramUniform1iv := SYSTEM.VAL(TglProgramUniform1iv, glXGetProcAddress('glProgramUniform1iv'));
     glProgramUniform1f := SYSTEM.VAL(TglProgramUniform1f, glXGetProcAddress('glProgramUniform1f'));
     glProgramUniform1fv := SYSTEM.VAL(TglProgramUniform1fv, glXGetProcAddress('glProgramUniform1fv'));
     glProgramUniform1d := SYSTEM.VAL(TglProgramUniform1d, glXGetProcAddress('glProgramUniform1d'));
     glProgramUniform1dv := SYSTEM.VAL(TglProgramUniform1dv, glXGetProcAddress('glProgramUniform1dv'));
     glProgramUniform1ui := SYSTEM.VAL(TglProgramUniform1ui, glXGetProcAddress('glProgramUniform1ui'));
     glProgramUniform1uiv := SYSTEM.VAL(TglProgramUniform1uiv, glXGetProcAddress('glProgramUniform1uiv'));
     glProgramUniform2i := SYSTEM.VAL(TglProgramUniform2i, glXGetProcAddress('glProgramUniform2i'));
     glProgramUniform2iv := SYSTEM.VAL(TglProgramUniform2iv, glXGetProcAddress('glProgramUniform2iv'));
     glProgramUniform2f := SYSTEM.VAL(TglProgramUniform2f, glXGetProcAddress('glProgramUniform2f'));
     glProgramUniform2fv := SYSTEM.VAL(TglProgramUniform2fv, glXGetProcAddress('glProgramUniform2fv'));
     glProgramUniform2d := SYSTEM.VAL(TglProgramUniform2d, glXGetProcAddress('glProgramUniform2d'));
     glProgramUniform2dv := SYSTEM.VAL(TglProgramUniform2dv, glXGetProcAddress('glProgramUniform2dv'));
     glProgramUniform2ui := SYSTEM.VAL(TglProgramUniform2ui, glXGetProcAddress('glProgramUniform2ui'));
     glProgramUniform2uiv := SYSTEM.VAL(TglProgramUniform2uiv, glXGetProcAddress('glProgramUniform2uiv'));
     glProgramUniform3i := SYSTEM.VAL(TglProgramUniform3i, glXGetProcAddress('glProgramUniform3i'));
     glProgramUniform3iv := SYSTEM.VAL(TglProgramUniform3iv, glXGetProcAddress('glProgramUniform3iv'));
     glProgramUniform3f := SYSTEM.VAL(TglProgramUniform3f, glXGetProcAddress('glProgramUniform3f'));
     glProgramUniform3fv := SYSTEM.VAL(TglProgramUniform3fv, glXGetProcAddress('glProgramUniform3fv'));
     glProgramUniform3d := SYSTEM.VAL(TglProgramUniform3d, glXGetProcAddress('glProgramUniform3d'));
     glProgramUniform3dv := SYSTEM.VAL(TglProgramUniform3dv, glXGetProcAddress('glProgramUniform3dv'));
     glProgramUniform3ui := SYSTEM.VAL(TglProgramUniform3ui, glXGetProcAddress('glProgramUniform3ui'));
     glProgramUniform3uiv := SYSTEM.VAL(TglProgramUniform3uiv, glXGetProcAddress('glProgramUniform3uiv'));
     glProgramUniform4i := SYSTEM.VAL(TglProgramUniform4i, glXGetProcAddress('glProgramUniform4i'));
     glProgramUniform4iv := SYSTEM.VAL(TglProgramUniform4iv, glXGetProcAddress('glProgramUniform4iv'));
     glProgramUniform4f := SYSTEM.VAL(TglProgramUniform4f, glXGetProcAddress('glProgramUniform4f'));
     glProgramUniform4fv := SYSTEM.VAL(TglProgramUniform4fv, glXGetProcAddress('glProgramUniform4fv'));
     glProgramUniform4d := SYSTEM.VAL(TglProgramUniform4d, glXGetProcAddress('glProgramUniform4d'));
     glProgramUniform4dv := SYSTEM.VAL(TglProgramUniform4dv, glXGetProcAddress('glProgramUniform4dv'));
     glProgramUniform4ui := SYSTEM.VAL(TglProgramUniform4ui, glXGetProcAddress('glProgramUniform4ui'));
     glProgramUniform4uiv := SYSTEM.VAL(TglProgramUniform4uiv, glXGetProcAddress('glProgramUniform4uiv'));
     glProgramUniformMatrix2fv := SYSTEM.VAL(TglProgramUniformMatrix2fv, glXGetProcAddress('glProgramUniformMatrix2fv'));
     glProgramUniformMatrix3fv := SYSTEM.VAL(TglProgramUniformMatrix3fv, glXGetProcAddress('glProgramUniformMatrix3fv'));
     glProgramUniformMatrix4fv := SYSTEM.VAL(TglProgramUniformMatrix4fv, glXGetProcAddress('glProgramUniformMatrix4fv'));
     glProgramUniformMatrix2dv := SYSTEM.VAL(TglProgramUniformMatrix2dv, glXGetProcAddress('glProgramUniformMatrix2dv'));
     glProgramUniformMatrix3dv := SYSTEM.VAL(TglProgramUniformMatrix3dv, glXGetProcAddress('glProgramUniformMatrix3dv'));
     glProgramUniformMatrix4dv := SYSTEM.VAL(TglProgramUniformMatrix4dv, glXGetProcAddress('glProgramUniformMatrix4dv'));
     glProgramUniformMatrix2x3fv := SYSTEM.VAL(TglProgramUniformMatrix2x3fv, glXGetProcAddress('glProgramUniformMatrix2x3fv'));
     glProgramUniformMatrix3x2fv := SYSTEM.VAL(TglProgramUniformMatrix3x2fv, glXGetProcAddress('glProgramUniformMatrix3x2fv'));
     glProgramUniformMatrix2x4fv := SYSTEM.VAL(TglProgramUniformMatrix2x4fv, glXGetProcAddress('glProgramUniformMatrix2x4fv'));
     glProgramUniformMatrix4x2fv := SYSTEM.VAL(TglProgramUniformMatrix4x2fv, glXGetProcAddress('glProgramUniformMatrix4x2fv'));
     glProgramUniformMatrix3x4fv := SYSTEM.VAL(TglProgramUniformMatrix3x4fv, glXGetProcAddress('glProgramUniformMatrix3x4fv'));
     glProgramUniformMatrix4x3fv := SYSTEM.VAL(TglProgramUniformMatrix4x3fv, glXGetProcAddress('glProgramUniformMatrix4x3fv'));
     glProgramUniformMatrix2x3dv := SYSTEM.VAL(TglProgramUniformMatrix2x3dv, glXGetProcAddress('glProgramUniformMatrix2x3dv'));
     glProgramUniformMatrix3x2dv := SYSTEM.VAL(TglProgramUniformMatrix3x2dv, glXGetProcAddress('glProgramUniformMatrix3x2dv'));
     glProgramUniformMatrix2x4dv := SYSTEM.VAL(TglProgramUniformMatrix2x4dv, glXGetProcAddress('glProgramUniformMatrix2x4dv'));
     glProgramUniformMatrix4x2dv := SYSTEM.VAL(TglProgramUniformMatrix4x2dv, glXGetProcAddress('glProgramUniformMatrix4x2dv'));
     glProgramUniformMatrix3x4dv := SYSTEM.VAL(TglProgramUniformMatrix3x4dv, glXGetProcAddress('glProgramUniformMatrix3x4dv'));
     glProgramUniformMatrix4x3dv := SYSTEM.VAL(TglProgramUniformMatrix4x3dv, glXGetProcAddress('glProgramUniformMatrix4x3dv'));
     glValidateProgramPipeline := SYSTEM.VAL(TglValidateProgramPipeline, glXGetProcAddress('glValidateProgramPipeline'));
     glGetProgramPipelineInfoLog := SYSTEM.VAL(TglGetProgramPipelineInfoLog, glXGetProcAddress('glGetProgramPipelineInfoLog'));
END Read_GL_ARB_separate_shader_objects;

PROCEDURE Read_GL_ARB_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1d := SYSTEM.VAL(TglVertexAttribL1d, glXGetProcAddress('glVertexAttribL1d'));
     glVertexAttribL2d := SYSTEM.VAL(TglVertexAttribL2d, glXGetProcAddress('glVertexAttribL2d'));
     glVertexAttribL3d := SYSTEM.VAL(TglVertexAttribL3d, glXGetProcAddress('glVertexAttribL3d'));
     glVertexAttribL4d := SYSTEM.VAL(TglVertexAttribL4d, glXGetProcAddress('glVertexAttribL4d'));
     glVertexAttribL1dv := SYSTEM.VAL(TglVertexAttribL1dv, glXGetProcAddress('glVertexAttribL1dv'));
     glVertexAttribL2dv := SYSTEM.VAL(TglVertexAttribL2dv, glXGetProcAddress('glVertexAttribL2dv'));
     glVertexAttribL3dv := SYSTEM.VAL(TglVertexAttribL3dv, glXGetProcAddress('glVertexAttribL3dv'));
     glVertexAttribL4dv := SYSTEM.VAL(TglVertexAttribL4dv, glXGetProcAddress('glVertexAttribL4dv'));
     glVertexAttribLPointer := SYSTEM.VAL(TglVertexAttribLPointer, glXGetProcAddress('glVertexAttribLPointer'));
     glGetVertexAttribLdv := SYSTEM.VAL(TglGetVertexAttribLdv, glXGetProcAddress('glGetVertexAttribLdv'));
END Read_GL_ARB_vertex_attrib_64bit;

PROCEDURE Read_GL_ARB_viewport_array;
BEGIN
     glViewportArrayv := SYSTEM.VAL(TglViewportArrayv, glXGetProcAddress('glViewportArrayv'));
     glViewportIndexedf := SYSTEM.VAL(TglViewportIndexedf, glXGetProcAddress('glViewportIndexedf'));
     glViewportIndexedfv := SYSTEM.VAL(TglViewportIndexedfv, glXGetProcAddress('glViewportIndexedfv'));
     glScissorArrayv := SYSTEM.VAL(TglScissorArrayv, glXGetProcAddress('glScissorArrayv'));
     glScissorIndexed := SYSTEM.VAL(TglScissorIndexed, glXGetProcAddress('glScissorIndexed'));
     glScissorIndexedv := SYSTEM.VAL(TglScissorIndexedv, glXGetProcAddress('glScissorIndexedv'));
     glDepthRangeArrayv := SYSTEM.VAL(TglDepthRangeArrayv, glXGetProcAddress('glDepthRangeArrayv'));
     glDepthRangeIndexed := SYSTEM.VAL(TglDepthRangeIndexed, glXGetProcAddress('glDepthRangeIndexed'));
     glGetFloati_v := SYSTEM.VAL(TglGetFloati_v, glXGetProcAddress('glGetFloati_v'));
     glGetDoublei_v := SYSTEM.VAL(TglGetDoublei_v, glXGetProcAddress('glGetDoublei_v'));
END Read_GL_ARB_viewport_array;

PROCEDURE Read_GL_ARB_cl_event;
BEGIN
     glCreateSyncFromCLeventARB := SYSTEM.VAL(TglCreateSyncFromCLeventARB, glXGetProcAddress('glCreateSyncFromCLeventARB'));
END Read_GL_ARB_cl_event;

PROCEDURE Read_GL_ARB_debug_output;
BEGIN
     glDebugMessageControlARB := SYSTEM.VAL(TglDebugMessageControlARB, glXGetProcAddress('glDebugMessageControlARB'));
     glDebugMessageInsertARB := SYSTEM.VAL(TglDebugMessageInsertARB, glXGetProcAddress('glDebugMessageInsertARB'));
(*     glDebugMessageCallbackARB := SYSTEM.VAL(TglDebugMessageCallbackARB, glXGetProcAddress('glDebugMessageCallbackARB')); *)
     glGetDebugMessageLogARB := SYSTEM.VAL(TglGetDebugMessageLogARB, glXGetProcAddress('glGetDebugMessageLogARB'));
END Read_GL_ARB_debug_output;

PROCEDURE Read_GL_ARB_robustness;
BEGIN
     glGetGraphicsResetStatusARB := SYSTEM.VAL(TglGetGraphicsResetStatusARB, glXGetProcAddress('glGetGraphicsResetStatusARB'));
     glGetnMapdvARB := SYSTEM.VAL(TglGetnMapdvARB, glXGetProcAddress('glGetnMapdvARB'));
     glGetnMapfvARB := SYSTEM.VAL(TglGetnMapfvARB, glXGetProcAddress('glGetnMapfvARB'));
     glGetnMapivARB := SYSTEM.VAL(TglGetnMapivARB, glXGetProcAddress('glGetnMapivARB'));
     glGetnPixelMapfvARB := SYSTEM.VAL(TglGetnPixelMapfvARB, glXGetProcAddress('glGetnPixelMapfvARB'));
     glGetnPixelMapuivARB := SYSTEM.VAL(TglGetnPixelMapuivARB, glXGetProcAddress('glGetnPixelMapuivARB'));
     glGetnPixelMapusvARB := SYSTEM.VAL(TglGetnPixelMapusvARB, glXGetProcAddress('glGetnPixelMapusvARB'));
     glGetnPolygonStippleARB := SYSTEM.VAL(TglGetnPolygonStippleARB, glXGetProcAddress('glGetnPolygonStippleARB'));
     glGetnColorTableARB := SYSTEM.VAL(TglGetnColorTableARB, glXGetProcAddress('glGetnColorTableARB'));
     glGetnConvolutionFilterARB := SYSTEM.VAL(TglGetnConvolutionFilterARB, glXGetProcAddress('glGetnConvolutionFilterARB'));
     glGetnSeparableFilterARB := SYSTEM.VAL(TglGetnSeparableFilterARB, glXGetProcAddress('glGetnSeparableFilterARB'));
     glGetnHistogramARB := SYSTEM.VAL(TglGetnHistogramARB, glXGetProcAddress('glGetnHistogramARB'));
     glGetnMinmaxARB := SYSTEM.VAL(TglGetnMinmaxARB, glXGetProcAddress('glGetnMinmaxARB'));
     glGetnTexImageARB := SYSTEM.VAL(TglGetnTexImageARB, glXGetProcAddress('glGetnTexImageARB'));
     glReadnPixelsARB := SYSTEM.VAL(TglReadnPixelsARB, glXGetProcAddress('glReadnPixelsARB'));
     glGetnCompressedTexImageARB := SYSTEM.VAL(TglGetnCompressedTexImageARB, glXGetProcAddress('glGetnCompressedTexImageARB'));
     glGetnUniformfvARB := SYSTEM.VAL(TglGetnUniformfvARB, glXGetProcAddress('glGetnUniformfvARB'));
     glGetnUniformivARB := SYSTEM.VAL(TglGetnUniformivARB, glXGetProcAddress('glGetnUniformivARB'));
     glGetnUniformuivARB := SYSTEM.VAL(TglGetnUniformuivARB, glXGetProcAddress('glGetnUniformuivARB'));
     glGetnUniformdvARB := SYSTEM.VAL(TglGetnUniformdvARB, glXGetProcAddress('glGetnUniformdvARB'));
END Read_GL_ARB_robustness;

PROCEDURE Read_GL_ATI_draw_buffers;
BEGIN
     glDrawBuffersATI := SYSTEM.VAL(TglDrawBuffersATI, glXGetProcAddress('glDrawBuffersATI'));
END Read_GL_ATI_draw_buffers;

PROCEDURE Read_GL_ATI_element_array;
BEGIN
     glElementPointerATI := SYSTEM.VAL(TglElementPointerATI, glXGetProcAddress('glElementPointerATI'));
     glDrawElementArrayATI := SYSTEM.VAL(TglDrawElementArrayATI, glXGetProcAddress('glDrawElementArrayATI'));
     glDrawRangeElementArrayATI := SYSTEM.VAL(TglDrawRangeElementArrayATI, glXGetProcAddress('glDrawRangeElementArrayATI'));
END Read_GL_ATI_element_array;

PROCEDURE Read_GL_ATI_envmap_bumpmap;
BEGIN
     glTexBumpParameterivATI := SYSTEM.VAL(TglTexBumpParameterivATI, glXGetProcAddress('glTexBumpParameterivATI'));
     glTexBumpParameterfvATI := SYSTEM.VAL(TglTexBumpParameterfvATI, glXGetProcAddress('glTexBumpParameterfvATI'));
     glGetTexBumpParameterivATI := SYSTEM.VAL(TglGetTexBumpParameterivATI, glXGetProcAddress('glGetTexBumpParameterivATI'));
     glGetTexBumpParameterfvATI := SYSTEM.VAL(TglGetTexBumpParameterfvATI, glXGetProcAddress('glGetTexBumpParameterfvATI'));
END Read_GL_ATI_envmap_bumpmap;

PROCEDURE Read_GL_ATI_fragment_shader;
BEGIN
     glGenFragmentShadersATI := SYSTEM.VAL(TglGenFragmentShadersATI, glXGetProcAddress('glGenFragmentShadersATI'));
     glBindFragmentShaderATI := SYSTEM.VAL(TglBindFragmentShaderATI, glXGetProcAddress('glBindFragmentShaderATI'));
     glDeleteFragmentShaderATI := SYSTEM.VAL(TglDeleteFragmentShaderATI, glXGetProcAddress('glDeleteFragmentShaderATI'));
     glBeginFragmentShaderATI := SYSTEM.VAL(TglBeginFragmentShaderATI, glXGetProcAddress('glBeginFragmentShaderATI'));
     glEndFragmentShaderATI := SYSTEM.VAL(TglEndFragmentShaderATI, glXGetProcAddress('glEndFragmentShaderATI'));
     glPassTexCoordATI := SYSTEM.VAL(TglPassTexCoordATI, glXGetProcAddress('glPassTexCoordATI'));
     glSampleMapATI := SYSTEM.VAL(TglSampleMapATI, glXGetProcAddress('glSampleMapATI'));
     glColorFragmentOp1ATI := SYSTEM.VAL(TglColorFragmentOp1ATI, glXGetProcAddress('glColorFragmentOp1ATI'));
     glColorFragmentOp2ATI := SYSTEM.VAL(TglColorFragmentOp2ATI, glXGetProcAddress('glColorFragmentOp2ATI'));
     glColorFragmentOp3ATI := SYSTEM.VAL(TglColorFragmentOp3ATI, glXGetProcAddress('glColorFragmentOp3ATI'));
     glAlphaFragmentOp1ATI := SYSTEM.VAL(TglAlphaFragmentOp1ATI, glXGetProcAddress('glAlphaFragmentOp1ATI'));
     glAlphaFragmentOp2ATI := SYSTEM.VAL(TglAlphaFragmentOp2ATI, glXGetProcAddress('glAlphaFragmentOp2ATI'));
     glAlphaFragmentOp3ATI := SYSTEM.VAL(TglAlphaFragmentOp3ATI, glXGetProcAddress('glAlphaFragmentOp3ATI'));
     glSetFragmentShaderConstantATI := SYSTEM.VAL(TglSetFragmentShaderConstantATI, glXGetProcAddress('glSetFragmentShaderConstantATI'));
END Read_GL_ATI_fragment_shader;

PROCEDURE Read_GL_ATI_map_object_buffer;
BEGIN
     glMapObjectBufferATI := SYSTEM.VAL(TglMapObjectBufferATI, glXGetProcAddress('glMapObjectBufferATI'));
     glUnmapObjectBufferATI := SYSTEM.VAL(TglUnmapObjectBufferATI, glXGetProcAddress('glUnmapObjectBufferATI'));
END Read_GL_ATI_map_object_buffer;

PROCEDURE Read_GL_ATI_pn_triangles;
BEGIN
     glPNTrianglesiATI := SYSTEM.VAL(TglPNTrianglesiATI, glXGetProcAddress('glPNTrianglesiATI'));
     glPNTrianglesfATI := SYSTEM.VAL(TglPNTrianglesfATI, glXGetProcAddress('glPNTrianglesfATI'));
END Read_GL_ATI_pn_triangles;

PROCEDURE Read_GL_ATI_separate_stencil;
BEGIN
     glStencilOpSeparateATI := SYSTEM.VAL(TglStencilOpSeparateATI, glXGetProcAddress('glStencilOpSeparateATI'));
     glStencilFuncSeparateATI := SYSTEM.VAL(TglStencilFuncSeparateATI, glXGetProcAddress('glStencilFuncSeparateATI'));
END Read_GL_ATI_separate_stencil;

PROCEDURE Read_GL_ATI_vertex_array_object;
BEGIN
     glNewObjectBufferATI := SYSTEM.VAL(TglNewObjectBufferATI, glXGetProcAddress('glNewObjectBufferATI'));
     glIsObjectBufferATI := SYSTEM.VAL(TglIsObjectBufferATI, glXGetProcAddress('glIsObjectBufferATI'));
     glUpdateObjectBufferATI := SYSTEM.VAL(TglUpdateObjectBufferATI, glXGetProcAddress('glUpdateObjectBufferATI'));
     glGetObjectBufferfvATI := SYSTEM.VAL(TglGetObjectBufferfvATI, glXGetProcAddress('glGetObjectBufferfvATI'));
     glGetObjectBufferivATI := SYSTEM.VAL(TglGetObjectBufferivATI, glXGetProcAddress('glGetObjectBufferivATI'));
     glFreeObjectBufferATI := SYSTEM.VAL(TglFreeObjectBufferATI, glXGetProcAddress('glFreeObjectBufferATI'));
     glArrayObjectATI := SYSTEM.VAL(TglArrayObjectATI, glXGetProcAddress('glArrayObjectATI'));
     glGetArrayObjectfvATI := SYSTEM.VAL(TglGetArrayObjectfvATI, glXGetProcAddress('glGetArrayObjectfvATI'));
     glGetArrayObjectivATI := SYSTEM.VAL(TglGetArrayObjectivATI, glXGetProcAddress('glGetArrayObjectivATI'));
     glVariantArrayObjectATI := SYSTEM.VAL(TglVariantArrayObjectATI, glXGetProcAddress('glVariantArrayObjectATI'));
     glGetVariantArrayObjectfvATI := SYSTEM.VAL(TglGetVariantArrayObjectfvATI, glXGetProcAddress('glGetVariantArrayObjectfvATI'));
     glGetVariantArrayObjectivATI := SYSTEM.VAL(TglGetVariantArrayObjectivATI, glXGetProcAddress('glGetVariantArrayObjectivATI'));
END Read_GL_ATI_vertex_array_object;

PROCEDURE Read_GL_ATI_vertex_attrib_array_object;
BEGIN
     glVertexAttribArrayObjectATI := SYSTEM.VAL(TglVertexAttribArrayObjectATI, glXGetProcAddress('glVertexAttribArrayObjectATI'));
     glGetVertexAttribArrayObjectfvATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectfvATI, glXGetProcAddress('glGetVertexAttribArrayObjectfvATI'));
     glGetVertexAttribArrayObjectivATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectivATI, glXGetProcAddress('glGetVertexAttribArrayObjectivATI'));
END Read_GL_ATI_vertex_attrib_array_object;

PROCEDURE Read_GL_ATI_vertex_streams;
BEGIN
     glVertexStream1sATI := SYSTEM.VAL(TglVertexStream1sATI, glXGetProcAddress('glVertexStream1sATI'));
     glVertexStream1svATI := SYSTEM.VAL(TglVertexStream1svATI, glXGetProcAddress('glVertexStream1svATI'));
     glVertexStream1iATI := SYSTEM.VAL(TglVertexStream1iATI, glXGetProcAddress('glVertexStream1iATI'));
     glVertexStream1ivATI := SYSTEM.VAL(TglVertexStream1ivATI, glXGetProcAddress('glVertexStream1ivATI'));
     glVertexStream1fATI := SYSTEM.VAL(TglVertexStream1fATI, glXGetProcAddress('glVertexStream1fATI'));
     glVertexStream1fvATI := SYSTEM.VAL(TglVertexStream1fvATI, glXGetProcAddress('glVertexStream1fvATI'));
     glVertexStream1dATI := SYSTEM.VAL(TglVertexStream1dATI, glXGetProcAddress('glVertexStream1dATI'));
     glVertexStream1dvATI := SYSTEM.VAL(TglVertexStream1dvATI, glXGetProcAddress('glVertexStream1dvATI'));
     glVertexStream2sATI := SYSTEM.VAL(TglVertexStream2sATI, glXGetProcAddress('glVertexStream2sATI'));
     glVertexStream2svATI := SYSTEM.VAL(TglVertexStream2svATI, glXGetProcAddress('glVertexStream2svATI'));
     glVertexStream2iATI := SYSTEM.VAL(TglVertexStream2iATI, glXGetProcAddress('glVertexStream2iATI'));
     glVertexStream2ivATI := SYSTEM.VAL(TglVertexStream2ivATI, glXGetProcAddress('glVertexStream2ivATI'));
     glVertexStream2fATI := SYSTEM.VAL(TglVertexStream2fATI, glXGetProcAddress('glVertexStream2fATI'));
     glVertexStream2fvATI := SYSTEM.VAL(TglVertexStream2fvATI, glXGetProcAddress('glVertexStream2fvATI'));
     glVertexStream2dATI := SYSTEM.VAL(TglVertexStream2dATI, glXGetProcAddress('glVertexStream2dATI'));
     glVertexStream2dvATI := SYSTEM.VAL(TglVertexStream2dvATI, glXGetProcAddress('glVertexStream2dvATI'));
     glVertexStream3sATI := SYSTEM.VAL(TglVertexStream3sATI, glXGetProcAddress('glVertexStream3sATI'));
     glVertexStream3svATI := SYSTEM.VAL(TglVertexStream3svATI, glXGetProcAddress('glVertexStream3svATI'));
     glVertexStream3iATI := SYSTEM.VAL(TglVertexStream3iATI, glXGetProcAddress('glVertexStream3iATI'));
     glVertexStream3ivATI := SYSTEM.VAL(TglVertexStream3ivATI, glXGetProcAddress('glVertexStream3ivATI'));
     glVertexStream3fATI := SYSTEM.VAL(TglVertexStream3fATI, glXGetProcAddress('glVertexStream3fATI'));
     glVertexStream3fvATI := SYSTEM.VAL(TglVertexStream3fvATI, glXGetProcAddress('glVertexStream3fvATI'));
     glVertexStream3dATI := SYSTEM.VAL(TglVertexStream3dATI, glXGetProcAddress('glVertexStream3dATI'));
     glVertexStream3dvATI := SYSTEM.VAL(TglVertexStream3dvATI, glXGetProcAddress('glVertexStream3dvATI'));
     glVertexStream4sATI := SYSTEM.VAL(TglVertexStream4sATI, glXGetProcAddress('glVertexStream4sATI'));
     glVertexStream4svATI := SYSTEM.VAL(TglVertexStream4svATI, glXGetProcAddress('glVertexStream4svATI'));
     glVertexStream4iATI := SYSTEM.VAL(TglVertexStream4iATI, glXGetProcAddress('glVertexStream4iATI'));
     glVertexStream4ivATI := SYSTEM.VAL(TglVertexStream4ivATI, glXGetProcAddress('glVertexStream4ivATI'));
     glVertexStream4fATI := SYSTEM.VAL(TglVertexStream4fATI, glXGetProcAddress('glVertexStream4fATI'));
     glVertexStream4fvATI := SYSTEM.VAL(TglVertexStream4fvATI, glXGetProcAddress('glVertexStream4fvATI'));
     glVertexStream4dATI := SYSTEM.VAL(TglVertexStream4dATI, glXGetProcAddress('glVertexStream4dATI'));
     glVertexStream4dvATI := SYSTEM.VAL(TglVertexStream4dvATI, glXGetProcAddress('glVertexStream4dvATI'));
     glNormalStream3bATI := SYSTEM.VAL(TglNormalStream3bATI, glXGetProcAddress('glNormalStream3bATI'));
     glNormalStream3bvATI := SYSTEM.VAL(TglNormalStream3bvATI, glXGetProcAddress('glNormalStream3bvATI'));
     glNormalStream3sATI := SYSTEM.VAL(TglNormalStream3sATI, glXGetProcAddress('glNormalStream3sATI'));
     glNormalStream3svATI := SYSTEM.VAL(TglNormalStream3svATI, glXGetProcAddress('glNormalStream3svATI'));
     glNormalStream3iATI := SYSTEM.VAL(TglNormalStream3iATI, glXGetProcAddress('glNormalStream3iATI'));
     glNormalStream3ivATI := SYSTEM.VAL(TglNormalStream3ivATI, glXGetProcAddress('glNormalStream3ivATI'));
     glNormalStream3fATI := SYSTEM.VAL(TglNormalStream3fATI, glXGetProcAddress('glNormalStream3fATI'));
     glNormalStream3fvATI := SYSTEM.VAL(TglNormalStream3fvATI, glXGetProcAddress('glNormalStream3fvATI'));
     glNormalStream3dATI := SYSTEM.VAL(TglNormalStream3dATI, glXGetProcAddress('glNormalStream3dATI'));
     glNormalStream3dvATI := SYSTEM.VAL(TglNormalStream3dvATI, glXGetProcAddress('glNormalStream3dvATI'));
     glClientActiveVertexStreamATI := SYSTEM.VAL(TglClientActiveVertexStreamATI, glXGetProcAddress('glClientActiveVertexStreamATI'));
     glVertexBlendEnviATI := SYSTEM.VAL(TglVertexBlendEnviATI, glXGetProcAddress('glVertexBlendEnviATI'));
     glVertexBlendEnvfATI := SYSTEM.VAL(TglVertexBlendEnvfATI, glXGetProcAddress('glVertexBlendEnvfATI'));
END Read_GL_ATI_vertex_streams;

PROCEDURE Read_GL_AMD_performance_monitor;
BEGIN
     glGetPerfMonitorGroupsAMD := SYSTEM.VAL(TglGetPerfMonitorGroupsAMD, glXGetProcAddress('glGetPerfMonitorGroupsAMD'));
     glGetPerfMonitorCountersAMD := SYSTEM.VAL(TglGetPerfMonitorCountersAMD, glXGetProcAddress('glGetPerfMonitorCountersAMD'));
     glGetPerfMonitorGroupStringAMD := SYSTEM.VAL(TglGetPerfMonitorGroupStringAMD, glXGetProcAddress('glGetPerfMonitorGroupStringAMD'));
     glGetPerfMonitorCounterStringAMD := SYSTEM.VAL(TglGetPerfMonitorCounterStringAMD, glXGetProcAddress('glGetPerfMonitorCounterStringAMD'));
     glGetPerfMonitorCounterInfoAMD := SYSTEM.VAL(TglGetPerfMonitorCounterInfoAMD, glXGetProcAddress('glGetPerfMonitorCounterInfoAMD'));
     glGenPerfMonitorsAMD := SYSTEM.VAL(TglGenPerfMonitorsAMD, glXGetProcAddress('glGenPerfMonitorsAMD'));
     glDeletePerfMonitorsAMD := SYSTEM.VAL(TglDeletePerfMonitorsAMD, glXGetProcAddress('glDeletePerfMonitorsAMD'));
     glSelectPerfMonitorCountersAMD := SYSTEM.VAL(TglSelectPerfMonitorCountersAMD, glXGetProcAddress('glSelectPerfMonitorCountersAMD'));
     glBeginPerfMonitorAMD := SYSTEM.VAL(TglBeginPerfMonitorAMD, glXGetProcAddress('glBeginPerfMonitorAMD'));
     glEndPerfMonitorAMD := SYSTEM.VAL(TglEndPerfMonitorAMD, glXGetProcAddress('glEndPerfMonitorAMD'));
     glGetPerfMonitorCounterDataAMD := SYSTEM.VAL(TglGetPerfMonitorCounterDataAMD, glXGetProcAddress('glGetPerfMonitorCounterDataAMD'));
END Read_GL_AMD_performance_monitor;

PROCEDURE Read_GL_AMD_vertex_shader_tesselator;
BEGIN
     glTessellationFactorAMD := SYSTEM.VAL(TglTessellationFactorAMD, glXGetProcAddress('glTessellationFactorAMD'));
     glTessellationModeAMD := SYSTEM.VAL(TglTessellationModeAMD, glXGetProcAddress('glTessellationModeAMD'));
END Read_GL_AMD_vertex_shader_tesselator;

PROCEDURE Read_GL_AMD_draw_buffers_blend;
BEGIN
     glBlendFuncIndexedAMD := SYSTEM.VAL(TglBlendFuncIndexedAMD, glXGetProcAddress('glBlendFuncIndexedAMD'));
     glBlendFuncSeparateIndexedAMD := SYSTEM.VAL(TglBlendFuncSeparateIndexedAMD, glXGetProcAddress('glBlendFuncSeparateIndexedAMD'));
     glBlendEquationIndexedAMD := SYSTEM.VAL(TglBlendEquationIndexedAMD, glXGetProcAddress('glBlendEquationIndexedAMD'));
     glBlendEquationSeparateIndexedAMD := SYSTEM.VAL(TglBlendEquationSeparateIndexedAMD, glXGetProcAddress('glBlendEquationSeparateIndexedAMD'));
END Read_GL_AMD_draw_buffers_blend;

PROCEDURE Read_GL_AMD_name_gen_delete;
BEGIN
     glGenNamesAMD := SYSTEM.VAL(TglGenNamesAMD, glXGetProcAddress('glGenNamesAMD'));
     glDeleteNamesAMD := SYSTEM.VAL(TglDeleteNamesAMD, glXGetProcAddress('glDeleteNamesAMD'));
     glIsNameAMD := SYSTEM.VAL(TglIsNameAMD, glXGetProcAddress('glIsNameAMD'));
END Read_GL_AMD_name_gen_delete;

PROCEDURE Read_GL_AMD_debug_output;
BEGIN
     glDebugMessageEnableAMD := SYSTEM.VAL(TglDebugMessageEnableAMD, glXGetProcAddress('glDebugMessageEnableAMD'));
     glDebugMessageInsertAMD := SYSTEM.VAL(TglDebugMessageInsertAMD, glXGetProcAddress('glDebugMessageInsertAMD'));
(*     glDebugMessageCallbackAMD := SYSTEM.VAL(TglDebugMessageCallbackAMD, glXGetProcAddress('glDebugMessageCallbackAMD')); *)
     glGetDebugMessageLogAMD := SYSTEM.VAL(TglGetDebugMessageLogAMD, glXGetProcAddress('glGetDebugMessageLogAMD'));
END Read_GL_AMD_debug_output;

PROCEDURE Read_GL_EXT_blend_color;
BEGIN
     glBlendColorEXT := SYSTEM.VAL(TglBlendColorEXT, glXGetProcAddress('glBlendColorEXT'));
END Read_GL_EXT_blend_color;

PROCEDURE Read_GL_EXT_blend_func_separate;
BEGIN
     glBlendFuncSeparateEXT := SYSTEM.VAL(TglBlendFuncSeparateEXT, glXGetProcAddress('glBlendFuncSeparateEXT'));
END Read_GL_EXT_blend_func_separate;

PROCEDURE Read_GL_EXT_blend_minmax;
BEGIN
     glBlendEquationEXT := SYSTEM.VAL(TglBlendEquationEXT, glXGetProcAddress('glBlendEquationEXT'));
END Read_GL_EXT_blend_minmax;

PROCEDURE Read_GL_EXT_color_subtable;
BEGIN
     glColorSubTableEXT := SYSTEM.VAL(TglColorSubTableEXT, glXGetProcAddress('glColorSubTableEXT'));
     glCopyColorSubTableEXT := SYSTEM.VAL(TglCopyColorSubTableEXT, glXGetProcAddress('glCopyColorSubTableEXT'));
END Read_GL_EXT_color_subtable;

PROCEDURE Read_GL_EXT_compiled_vertex_array;
BEGIN
     glLockArraysEXT := SYSTEM.VAL(TglLockArraysEXT, glXGetProcAddress('glLockArraysEXT'));
     glUnlockArraysEXT := SYSTEM.VAL(TglUnlockArraysEXT, glXGetProcAddress('glUnlockArraysEXT'));
END Read_GL_EXT_compiled_vertex_array;

PROCEDURE Read_GL_EXT_convolution;
BEGIN
     glConvolutionFilter1DEXT := SYSTEM.VAL(TglConvolutionFilter1DEXT, glXGetProcAddress('glConvolutionFilter1DEXT'));
     glConvolutionFilter2DEXT := SYSTEM.VAL(TglConvolutionFilter2DEXT, glXGetProcAddress('glConvolutionFilter2DEXT'));
     glConvolutionParameterfEXT := SYSTEM.VAL(TglConvolutionParameterfEXT, glXGetProcAddress('glConvolutionParameterfEXT'));
     glConvolutionParameterfvEXT := SYSTEM.VAL(TglConvolutionParameterfvEXT, glXGetProcAddress('glConvolutionParameterfvEXT'));
     glConvolutionParameteriEXT := SYSTEM.VAL(TglConvolutionParameteriEXT, glXGetProcAddress('glConvolutionParameteriEXT'));
     glConvolutionParameterivEXT := SYSTEM.VAL(TglConvolutionParameterivEXT, glXGetProcAddress('glConvolutionParameterivEXT'));
     glCopyConvolutionFilter1DEXT := SYSTEM.VAL(TglCopyConvolutionFilter1DEXT, glXGetProcAddress('glCopyConvolutionFilter1DEXT'));
     glCopyConvolutionFilter2DEXT := SYSTEM.VAL(TglCopyConvolutionFilter2DEXT, glXGetProcAddress('glCopyConvolutionFilter2DEXT'));
     glGetConvolutionFilterEXT := SYSTEM.VAL(TglGetConvolutionFilterEXT, glXGetProcAddress('glGetConvolutionFilterEXT'));
     glGetConvolutionParameterfvEXT := SYSTEM.VAL(TglGetConvolutionParameterfvEXT, glXGetProcAddress('glGetConvolutionParameterfvEXT'));
     glGetConvolutionParameterivEXT := SYSTEM.VAL(TglGetConvolutionParameterivEXT, glXGetProcAddress('glGetConvolutionParameterivEXT'));
     glGetSeparableFilterEXT := SYSTEM.VAL(TglGetSeparableFilterEXT, glXGetProcAddress('glGetSeparableFilterEXT'));
     glSeparableFilter2DEXT := SYSTEM.VAL(TglSeparableFilter2DEXT, glXGetProcAddress('glSeparableFilter2DEXT'));
END Read_GL_EXT_convolution;

PROCEDURE Read_GL_EXT_coordinate_frame;
BEGIN
     glTangent3bEXT := SYSTEM.VAL(TglTangent3bEXT, glXGetProcAddress('glTangent3bEXT'));
     glTangent3bvEXT := SYSTEM.VAL(TglTangent3bvEXT, glXGetProcAddress('glTangent3bvEXT'));
     glTangent3dEXT := SYSTEM.VAL(TglTangent3dEXT, glXGetProcAddress('glTangent3dEXT'));
     glTangent3dvEXT := SYSTEM.VAL(TglTangent3dvEXT, glXGetProcAddress('glTangent3dvEXT'));
     glTangent3fEXT := SYSTEM.VAL(TglTangent3fEXT, glXGetProcAddress('glTangent3fEXT'));
     glTangent3fvEXT := SYSTEM.VAL(TglTangent3fvEXT, glXGetProcAddress('glTangent3fvEXT'));
     glTangent3iEXT := SYSTEM.VAL(TglTangent3iEXT, glXGetProcAddress('glTangent3iEXT'));
     glTangent3ivEXT := SYSTEM.VAL(TglTangent3ivEXT, glXGetProcAddress('glTangent3ivEXT'));
     glTangent3sEXT := SYSTEM.VAL(TglTangent3sEXT, glXGetProcAddress('glTangent3sEXT'));
     glTangent3svEXT := SYSTEM.VAL(TglTangent3svEXT, glXGetProcAddress('glTangent3svEXT'));
     glBinormal3bEXT := SYSTEM.VAL(TglBinormal3bEXT, glXGetProcAddress('glBinormal3bEXT'));
     glBinormal3bvEXT := SYSTEM.VAL(TglBinormal3bvEXT, glXGetProcAddress('glBinormal3bvEXT'));
     glBinormal3dEXT := SYSTEM.VAL(TglBinormal3dEXT, glXGetProcAddress('glBinormal3dEXT'));
     glBinormal3dvEXT := SYSTEM.VAL(TglBinormal3dvEXT, glXGetProcAddress('glBinormal3dvEXT'));
     glBinormal3fEXT := SYSTEM.VAL(TglBinormal3fEXT, glXGetProcAddress('glBinormal3fEXT'));
     glBinormal3fvEXT := SYSTEM.VAL(TglBinormal3fvEXT, glXGetProcAddress('glBinormal3fvEXT'));
     glBinormal3iEXT := SYSTEM.VAL(TglBinormal3iEXT, glXGetProcAddress('glBinormal3iEXT'));
     glBinormal3ivEXT := SYSTEM.VAL(TglBinormal3ivEXT, glXGetProcAddress('glBinormal3ivEXT'));
     glBinormal3sEXT := SYSTEM.VAL(TglBinormal3sEXT, glXGetProcAddress('glBinormal3sEXT'));
     glBinormal3svEXT := SYSTEM.VAL(TglBinormal3svEXT, glXGetProcAddress('glBinormal3svEXT'));
     glTangentPointerEXT := SYSTEM.VAL(TglTangentPointerEXT, glXGetProcAddress('glTangentPointerEXT'));
     glBinormalPointerEXT := SYSTEM.VAL(TglBinormalPointerEXT, glXGetProcAddress('glBinormalPointerEXT'));
END Read_GL_EXT_coordinate_frame;

PROCEDURE Read_GL_EXT_copy_texture;
BEGIN
     glCopyTexImage1DEXT := SYSTEM.VAL(TglCopyTexImage1DEXT, glXGetProcAddress('glCopyTexImage1DEXT'));
     glCopyTexImage2DEXT := SYSTEM.VAL(TglCopyTexImage2DEXT, glXGetProcAddress('glCopyTexImage2DEXT'));
     glCopyTexSubImage1DEXT := SYSTEM.VAL(TglCopyTexSubImage1DEXT, glXGetProcAddress('glCopyTexSubImage1DEXT'));
     glCopyTexSubImage2DEXT := SYSTEM.VAL(TglCopyTexSubImage2DEXT, glXGetProcAddress('glCopyTexSubImage2DEXT'));
     glCopyTexSubImage3DEXT := SYSTEM.VAL(TglCopyTexSubImage3DEXT, glXGetProcAddress('glCopyTexSubImage3DEXT'));
END Read_GL_EXT_copy_texture;

PROCEDURE Read_GL_EXT_cull_vertex;
BEGIN
     glCullParameterdvEXT := SYSTEM.VAL(TglCullParameterdvEXT, glXGetProcAddress('glCullParameterdvEXT'));
     glCullParameterfvEXT := SYSTEM.VAL(TglCullParameterfvEXT, glXGetProcAddress('glCullParameterfvEXT'));
END Read_GL_EXT_cull_vertex;

PROCEDURE Read_GL_EXT_draw_range_elements;
BEGIN
     glDrawRangeElementsEXT := SYSTEM.VAL(TglDrawRangeElementsEXT, glXGetProcAddress('glDrawRangeElementsEXT'));
END Read_GL_EXT_draw_range_elements;

PROCEDURE Read_GL_EXT_fog_coord;
BEGIN
     glFogCoordfEXT := SYSTEM.VAL(TglFogCoordfEXT, glXGetProcAddress('glFogCoordfEXT'));
     glFogCoordfvEXT := SYSTEM.VAL(TglFogCoordfvEXT, glXGetProcAddress('glFogCoordfvEXT'));
     glFogCoorddEXT := SYSTEM.VAL(TglFogCoorddEXT, glXGetProcAddress('glFogCoorddEXT'));
     glFogCoorddvEXT := SYSTEM.VAL(TglFogCoorddvEXT, glXGetProcAddress('glFogCoorddvEXT'));
     glFogCoordPointerEXT := SYSTEM.VAL(TglFogCoordPointerEXT, glXGetProcAddress('glFogCoordPointerEXT'));
END Read_GL_EXT_fog_coord;

PROCEDURE Read_GL_EXT_framebuffer_object;
BEGIN
     glIsRenderbufferEXT := SYSTEM.VAL(TglIsRenderbufferEXT, glXGetProcAddress('glIsRenderbufferEXT'));
     glBindRenderbufferEXT := SYSTEM.VAL(TglBindRenderbufferEXT, glXGetProcAddress('glBindRenderbufferEXT'));
     glDeleteRenderbuffersEXT := SYSTEM.VAL(TglDeleteRenderbuffersEXT, glXGetProcAddress('glDeleteRenderbuffersEXT'));
     glGenRenderbuffersEXT := SYSTEM.VAL(TglGenRenderbuffersEXT, glXGetProcAddress('glGenRenderbuffersEXT'));
     glRenderbufferStorageEXT := SYSTEM.VAL(TglRenderbufferStorageEXT, glXGetProcAddress('glRenderbufferStorageEXT'));
     glGetRenderbufferParameterivEXT := SYSTEM.VAL(TglGetRenderbufferParameterivEXT, glXGetProcAddress('glGetRenderbufferParameterivEXT'));
     glIsFramebufferEXT := SYSTEM.VAL(TglIsFramebufferEXT, glXGetProcAddress('glIsFramebufferEXT'));
     glBindFramebufferEXT := SYSTEM.VAL(TglBindFramebufferEXT, glXGetProcAddress('glBindFramebufferEXT'));
     glDeleteFramebuffersEXT := SYSTEM.VAL(TglDeleteFramebuffersEXT, glXGetProcAddress('glDeleteFramebuffersEXT'));
     glGenFramebuffersEXT := SYSTEM.VAL(TglGenFramebuffersEXT, glXGetProcAddress('glGenFramebuffersEXT'));
     glCheckFramebufferStatusEXT := SYSTEM.VAL(TglCheckFramebufferStatusEXT, glXGetProcAddress('glCheckFramebufferStatusEXT'));
     glFramebufferTexture1DEXT := SYSTEM.VAL(TglFramebufferTexture1DEXT, glXGetProcAddress('glFramebufferTexture1DEXT'));
     glFramebufferTexture2DEXT := SYSTEM.VAL(TglFramebufferTexture2DEXT, glXGetProcAddress('glFramebufferTexture2DEXT'));
     glFramebufferTexture3DEXT := SYSTEM.VAL(TglFramebufferTexture3DEXT, glXGetProcAddress('glFramebufferTexture3DEXT'));
     glFramebufferRenderbufferEXT := SYSTEM.VAL(TglFramebufferRenderbufferEXT, glXGetProcAddress('glFramebufferRenderbufferEXT'));
     glGetFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetFramebufferAttachmentParameterivEXT, glXGetProcAddress('glGetFramebufferAttachmentParameterivEXT'));
     glGenerateMipmapEXT := SYSTEM.VAL(TglGenerateMipmapEXT, glXGetProcAddress('glGenerateMipmapEXT'));
END Read_GL_EXT_framebuffer_object;

PROCEDURE Read_GL_EXT_histogram;
BEGIN
     glGetHistogramEXT := SYSTEM.VAL(TglGetHistogramEXT, glXGetProcAddress('glGetHistogramEXT'));
     glGetHistogramParameterfvEXT := SYSTEM.VAL(TglGetHistogramParameterfvEXT, glXGetProcAddress('glGetHistogramParameterfvEXT'));
     glGetHistogramParameterivEXT := SYSTEM.VAL(TglGetHistogramParameterivEXT, glXGetProcAddress('glGetHistogramParameterivEXT'));
     glGetMinmaxEXT := SYSTEM.VAL(TglGetMinmaxEXT, glXGetProcAddress('glGetMinmaxEXT'));
     glGetMinmaxParameterfvEXT := SYSTEM.VAL(TglGetMinmaxParameterfvEXT, glXGetProcAddress('glGetMinmaxParameterfvEXT'));
     glGetMinmaxParameterivEXT := SYSTEM.VAL(TglGetMinmaxParameterivEXT, glXGetProcAddress('glGetMinmaxParameterivEXT'));
     glHistogramEXT := SYSTEM.VAL(TglHistogramEXT, glXGetProcAddress('glHistogramEXT'));
     glMinmaxEXT := SYSTEM.VAL(TglMinmaxEXT, glXGetProcAddress('glMinmaxEXT'));
     glResetHistogramEXT := SYSTEM.VAL(TglResetHistogramEXT, glXGetProcAddress('glResetHistogramEXT'));
     glResetMinmaxEXT := SYSTEM.VAL(TglResetMinmaxEXT, glXGetProcAddress('glResetMinmaxEXT'));
END Read_GL_EXT_histogram;

PROCEDURE Read_GL_EXT_index_func;
BEGIN
     glIndexFuncEXT := SYSTEM.VAL(TglIndexFuncEXT, glXGetProcAddress('glIndexFuncEXT'));
END Read_GL_EXT_index_func;

PROCEDURE Read_GL_EXT_index_material;
BEGIN
     glIndexMaterialEXT := SYSTEM.VAL(TglIndexMaterialEXT, glXGetProcAddress('glIndexMaterialEXT'));
END Read_GL_EXT_index_material;

PROCEDURE Read_GL_EXT_light_texture;
BEGIN
     glApplyTextureEXT := SYSTEM.VAL(TglApplyTextureEXT, glXGetProcAddress('glApplyTextureEXT'));
     glTextureLightEXT := SYSTEM.VAL(TglTextureLightEXT, glXGetProcAddress('glTextureLightEXT'));
     glTextureMaterialEXT := SYSTEM.VAL(TglTextureMaterialEXT, glXGetProcAddress('glTextureMaterialEXT'));
END Read_GL_EXT_light_texture;

PROCEDURE Read_GL_EXT_multi_draw_arrays;
BEGIN
     glMultiDrawArraysEXT := SYSTEM.VAL(TglMultiDrawArraysEXT, glXGetProcAddress('glMultiDrawArraysEXT'));
     glMultiDrawElementsEXT := SYSTEM.VAL(TglMultiDrawElementsEXT, glXGetProcAddress('glMultiDrawElementsEXT'));
END Read_GL_EXT_multi_draw_arrays;

PROCEDURE Read_GL_EXT_multisample;
BEGIN
     glSampleMaskEXT := SYSTEM.VAL(TglSampleMaskEXT, glXGetProcAddress('glSampleMaskEXT'));
     glSamplePatternEXT := SYSTEM.VAL(TglSamplePatternEXT, glXGetProcAddress('glSamplePatternEXT'));
END Read_GL_EXT_multisample;

PROCEDURE Read_GL_EXT_paletted_texture;
BEGIN
     glColorTableEXT := SYSTEM.VAL(TglColorTableEXT, glXGetProcAddress('glColorTableEXT'));
     glGetColorTableEXT := SYSTEM.VAL(TglGetColorTableEXT, glXGetProcAddress('glGetColorTableEXT'));
     glGetColorTableParameterivEXT := SYSTEM.VAL(TglGetColorTableParameterivEXT, glXGetProcAddress('glGetColorTableParameterivEXT'));
     glGetColorTableParameterfvEXT := SYSTEM.VAL(TglGetColorTableParameterfvEXT, glXGetProcAddress('glGetColorTableParameterfvEXT'));
END Read_GL_EXT_paletted_texture;

PROCEDURE Read_GL_EXT_pixel_transform;
BEGIN
     glPixelTransformParameteriEXT := SYSTEM.VAL(TglPixelTransformParameteriEXT, glXGetProcAddress('glPixelTransformParameteriEXT'));
     glPixelTransformParameterfEXT := SYSTEM.VAL(TglPixelTransformParameterfEXT, glXGetProcAddress('glPixelTransformParameterfEXT'));
     glPixelTransformParameterivEXT := SYSTEM.VAL(TglPixelTransformParameterivEXT, glXGetProcAddress('glPixelTransformParameterivEXT'));
     glPixelTransformParameterfvEXT := SYSTEM.VAL(TglPixelTransformParameterfvEXT, glXGetProcAddress('glPixelTransformParameterfvEXT'));
END Read_GL_EXT_pixel_transform;

PROCEDURE Read_GL_EXT_point_parameters;
BEGIN
     glPointParameterfEXT := SYSTEM.VAL(TglPointParameterfEXT, glXGetProcAddress('glPointParameterfEXT'));
     glPointParameterfvEXT := SYSTEM.VAL(TglPointParameterfvEXT, glXGetProcAddress('glPointParameterfvEXT'));
END Read_GL_EXT_point_parameters;

PROCEDURE Read_GL_EXT_polygon_offset;
BEGIN
     glPolygonOffsetEXT := SYSTEM.VAL(TglPolygonOffsetEXT, glXGetProcAddress('glPolygonOffsetEXT'));
END Read_GL_EXT_polygon_offset;

PROCEDURE Read_GL_EXT_secondary_color;
BEGIN
     glSecondaryColor3bEXT := SYSTEM.VAL(TglSecondaryColor3bEXT, glXGetProcAddress('glSecondaryColor3bEXT'));
     glSecondaryColor3bvEXT := SYSTEM.VAL(TglSecondaryColor3bvEXT, glXGetProcAddress('glSecondaryColor3bvEXT'));
     glSecondaryColor3dEXT := SYSTEM.VAL(TglSecondaryColor3dEXT, glXGetProcAddress('glSecondaryColor3dEXT'));
     glSecondaryColor3dvEXT := SYSTEM.VAL(TglSecondaryColor3dvEXT, glXGetProcAddress('glSecondaryColor3dvEXT'));
     glSecondaryColor3fEXT := SYSTEM.VAL(TglSecondaryColor3fEXT, glXGetProcAddress('glSecondaryColor3fEXT'));
     glSecondaryColor3fvEXT := SYSTEM.VAL(TglSecondaryColor3fvEXT, glXGetProcAddress('glSecondaryColor3fvEXT'));
     glSecondaryColor3iEXT := SYSTEM.VAL(TglSecondaryColor3iEXT, glXGetProcAddress('glSecondaryColor3iEXT'));
     glSecondaryColor3ivEXT := SYSTEM.VAL(TglSecondaryColor3ivEXT, glXGetProcAddress('glSecondaryColor3ivEXT'));
     glSecondaryColor3sEXT := SYSTEM.VAL(TglSecondaryColor3sEXT, glXGetProcAddress('glSecondaryColor3sEXT'));
     glSecondaryColor3svEXT := SYSTEM.VAL(TglSecondaryColor3svEXT, glXGetProcAddress('glSecondaryColor3svEXT'));
     glSecondaryColor3ubEXT := SYSTEM.VAL(TglSecondaryColor3ubEXT, glXGetProcAddress('glSecondaryColor3ubEXT'));
     glSecondaryColor3ubvEXT := SYSTEM.VAL(TglSecondaryColor3ubvEXT, glXGetProcAddress('glSecondaryColor3ubvEXT'));
     glSecondaryColor3uiEXT := SYSTEM.VAL(TglSecondaryColor3uiEXT, glXGetProcAddress('glSecondaryColor3uiEXT'));
     glSecondaryColor3uivEXT := SYSTEM.VAL(TglSecondaryColor3uivEXT, glXGetProcAddress('glSecondaryColor3uivEXT'));
     glSecondaryColor3usEXT := SYSTEM.VAL(TglSecondaryColor3usEXT, glXGetProcAddress('glSecondaryColor3usEXT'));
     glSecondaryColor3usvEXT := SYSTEM.VAL(TglSecondaryColor3usvEXT, glXGetProcAddress('glSecondaryColor3usvEXT'));
     glSecondaryColorPointerEXT := SYSTEM.VAL(TglSecondaryColorPointerEXT, glXGetProcAddress('glSecondaryColorPointerEXT'));
END Read_GL_EXT_secondary_color;

PROCEDURE Read_GL_EXT_stencil_two_side;
BEGIN
     glActiveStencilFaceEXT := SYSTEM.VAL(TglActiveStencilFaceEXT, glXGetProcAddress('glActiveStencilFaceEXT'));
END Read_GL_EXT_stencil_two_side;

PROCEDURE Read_GL_EXT_subtexture;
BEGIN
     glTexSubImage1DEXT := SYSTEM.VAL(TglTexSubImage1DEXT, glXGetProcAddress('glTexSubImage1DEXT'));
     glTexSubImage2DEXT := SYSTEM.VAL(TglTexSubImage2DEXT, glXGetProcAddress('glTexSubImage2DEXT'));
END Read_GL_EXT_subtexture;

PROCEDURE Read_GL_EXT_texture3D;
BEGIN
     glTexImage3DEXT := SYSTEM.VAL(TglTexImage3DEXT, glXGetProcAddress('glTexImage3DEXT'));
     glTexSubImage3DEXT := SYSTEM.VAL(TglTexSubImage3DEXT, glXGetProcAddress('glTexSubImage3DEXT'));
END Read_GL_EXT_texture3D;

PROCEDURE Read_GL_EXT_texture_object;
BEGIN
     glAreTexturesResidentEXT := SYSTEM.VAL(TglAreTexturesResidentEXT, glXGetProcAddress('glAreTexturesResidentEXT'));
     glBindTextureEXT := SYSTEM.VAL(TglBindTextureEXT, glXGetProcAddress('glBindTextureEXT'));
     glDeleteTexturesEXT := SYSTEM.VAL(TglDeleteTexturesEXT, glXGetProcAddress('glDeleteTexturesEXT'));
     glGenTexturesEXT := SYSTEM.VAL(TglGenTexturesEXT, glXGetProcAddress('glGenTexturesEXT'));
     glIsTextureEXT := SYSTEM.VAL(TglIsTextureEXT, glXGetProcAddress('glIsTextureEXT'));
     glPrioritizeTexturesEXT := SYSTEM.VAL(TglPrioritizeTexturesEXT, glXGetProcAddress('glPrioritizeTexturesEXT'));
END Read_GL_EXT_texture_object;

PROCEDURE Read_GL_EXT_texture_perturb_normal;
BEGIN
     glTextureNormalEXT := SYSTEM.VAL(TglTextureNormalEXT, glXGetProcAddress('glTextureNormalEXT'));
END Read_GL_EXT_texture_perturb_normal;

PROCEDURE Read_GL_EXT_vertex_array;
BEGIN
     glArrayElementEXT := SYSTEM.VAL(TglArrayElementEXT, glXGetProcAddress('glArrayElementEXT'));
     glColorPointerEXT := SYSTEM.VAL(TglColorPointerEXT, glXGetProcAddress('glColorPointerEXT'));
     glDrawArraysEXT := SYSTEM.VAL(TglDrawArraysEXT, glXGetProcAddress('glDrawArraysEXT'));
     glEdgeFlagPointerEXT := SYSTEM.VAL(TglEdgeFlagPointerEXT, glXGetProcAddress('glEdgeFlagPointerEXT'));
     glGetPointervEXT := SYSTEM.VAL(TglGetPointervEXT, glXGetProcAddress('glGetPointervEXT'));
     glIndexPointerEXT := SYSTEM.VAL(TglIndexPointerEXT, glXGetProcAddress('glIndexPointerEXT'));
     glNormalPointerEXT := SYSTEM.VAL(TglNormalPointerEXT, glXGetProcAddress('glNormalPointerEXT'));
     glTexCoordPointerEXT := SYSTEM.VAL(TglTexCoordPointerEXT, glXGetProcAddress('glTexCoordPointerEXT'));
     glVertexPointerEXT := SYSTEM.VAL(TglVertexPointerEXT, glXGetProcAddress('glVertexPointerEXT'));
END Read_GL_EXT_vertex_array;

PROCEDURE Read_GL_EXT_vertex_shader;
BEGIN
     glBeginVertexShaderEXT := SYSTEM.VAL(TglBeginVertexShaderEXT, glXGetProcAddress('glBeginVertexShaderEXT'));
     glEndVertexShaderEXT := SYSTEM.VAL(TglEndVertexShaderEXT, glXGetProcAddress('glEndVertexShaderEXT'));
     glBindVertexShaderEXT := SYSTEM.VAL(TglBindVertexShaderEXT, glXGetProcAddress('glBindVertexShaderEXT'));
     glGenVertexShadersEXT := SYSTEM.VAL(TglGenVertexShadersEXT, glXGetProcAddress('glGenVertexShadersEXT'));
     glDeleteVertexShaderEXT := SYSTEM.VAL(TglDeleteVertexShaderEXT, glXGetProcAddress('glDeleteVertexShaderEXT'));
     glShaderOp1EXT := SYSTEM.VAL(TglShaderOp1EXT, glXGetProcAddress('glShaderOp1EXT'));
     glShaderOp2EXT := SYSTEM.VAL(TglShaderOp2EXT, glXGetProcAddress('glShaderOp2EXT'));
     glShaderOp3EXT := SYSTEM.VAL(TglShaderOp3EXT, glXGetProcAddress('glShaderOp3EXT'));
     glSwizzleEXT := SYSTEM.VAL(TglSwizzleEXT, glXGetProcAddress('glSwizzleEXT'));
     glWriteMaskEXT := SYSTEM.VAL(TglWriteMaskEXT, glXGetProcAddress('glWriteMaskEXT'));
     glInsertComponentEXT := SYSTEM.VAL(TglInsertComponentEXT, glXGetProcAddress('glInsertComponentEXT'));
     glExtractComponentEXT := SYSTEM.VAL(TglExtractComponentEXT, glXGetProcAddress('glExtractComponentEXT'));
     glGenSymbolsEXT := SYSTEM.VAL(TglGenSymbolsEXT, glXGetProcAddress('glGenSymbolsEXT'));
     glSetInvariantEXT := SYSTEM.VAL(TglSetInvariantEXT, glXGetProcAddress('glSetInvariantEXT'));
     glSetLocalConstantEXT := SYSTEM.VAL(TglSetLocalConstantEXT, glXGetProcAddress('glSetLocalConstantEXT'));
     glVariantbvEXT := SYSTEM.VAL(TglVariantbvEXT, glXGetProcAddress('glVariantbvEXT'));
     glVariantsvEXT := SYSTEM.VAL(TglVariantsvEXT, glXGetProcAddress('glVariantsvEXT'));
     glVariantivEXT := SYSTEM.VAL(TglVariantivEXT, glXGetProcAddress('glVariantivEXT'));
     glVariantfvEXT := SYSTEM.VAL(TglVariantfvEXT, glXGetProcAddress('glVariantfvEXT'));
     glVariantdvEXT := SYSTEM.VAL(TglVariantdvEXT, glXGetProcAddress('glVariantdvEXT'));
     glVariantubvEXT := SYSTEM.VAL(TglVariantubvEXT, glXGetProcAddress('glVariantubvEXT'));
     glVariantusvEXT := SYSTEM.VAL(TglVariantusvEXT, glXGetProcAddress('glVariantusvEXT'));
     glVariantuivEXT := SYSTEM.VAL(TglVariantuivEXT, glXGetProcAddress('glVariantuivEXT'));
     glVariantPointerEXT := SYSTEM.VAL(TglVariantPointerEXT, glXGetProcAddress('glVariantPointerEXT'));
     glEnableVariantClientStateEXT := SYSTEM.VAL(TglEnableVariantClientStateEXT, glXGetProcAddress('glEnableVariantClientStateEXT'));
     glDisableVariantClientStateEXT := SYSTEM.VAL(TglDisableVariantClientStateEXT, glXGetProcAddress('glDisableVariantClientStateEXT'));
     glBindLightParameterEXT := SYSTEM.VAL(TglBindLightParameterEXT, glXGetProcAddress('glBindLightParameterEXT'));
     glBindMaterialParameterEXT := SYSTEM.VAL(TglBindMaterialParameterEXT, glXGetProcAddress('glBindMaterialParameterEXT'));
     glBindTexGenParameterEXT := SYSTEM.VAL(TglBindTexGenParameterEXT, glXGetProcAddress('glBindTexGenParameterEXT'));
     glBindTextureUnitParameterEXT := SYSTEM.VAL(TglBindTextureUnitParameterEXT, glXGetProcAddress('glBindTextureUnitParameterEXT'));
     glBindParameterEXT := SYSTEM.VAL(TglBindParameterEXT, glXGetProcAddress('glBindParameterEXT'));
     glIsVariantEnabledEXT := SYSTEM.VAL(TglIsVariantEnabledEXT, glXGetProcAddress('glIsVariantEnabledEXT'));
     glGetVariantBooleanvEXT := SYSTEM.VAL(TglGetVariantBooleanvEXT, glXGetProcAddress('glGetVariantBooleanvEXT'));
     glGetVariantIntegervEXT := SYSTEM.VAL(TglGetVariantIntegervEXT, glXGetProcAddress('glGetVariantIntegervEXT'));
     glGetVariantFloatvEXT := SYSTEM.VAL(TglGetVariantFloatvEXT, glXGetProcAddress('glGetVariantFloatvEXT'));
     glGetVariantPointervEXT := SYSTEM.VAL(TglGetVariantPointervEXT, glXGetProcAddress('glGetVariantPointervEXT'));
     glGetInvariantBooleanvEXT := SYSTEM.VAL(TglGetInvariantBooleanvEXT, glXGetProcAddress('glGetInvariantBooleanvEXT'));
     glGetInvariantIntegervEXT := SYSTEM.VAL(TglGetInvariantIntegervEXT, glXGetProcAddress('glGetInvariantIntegervEXT'));
     glGetInvariantFloatvEXT := SYSTEM.VAL(TglGetInvariantFloatvEXT, glXGetProcAddress('glGetInvariantFloatvEXT'));
     glGetLocalConstantBooleanvEXT := SYSTEM.VAL(TglGetLocalConstantBooleanvEXT, glXGetProcAddress('glGetLocalConstantBooleanvEXT'));
     glGetLocalConstantIntegervEXT := SYSTEM.VAL(TglGetLocalConstantIntegervEXT, glXGetProcAddress('glGetLocalConstantIntegervEXT'));
     glGetLocalConstantFloatvEXT := SYSTEM.VAL(TglGetLocalConstantFloatvEXT, glXGetProcAddress('glGetLocalConstantFloatvEXT'));
END Read_GL_EXT_vertex_shader;

PROCEDURE Read_GL_EXT_vertex_weighting;
BEGIN
     glVertexWeightfEXT := SYSTEM.VAL(TglVertexWeightfEXT, glXGetProcAddress('glVertexWeightfEXT'));
     glVertexWeightfvEXT := SYSTEM.VAL(TglVertexWeightfvEXT, glXGetProcAddress('glVertexWeightfvEXT'));
     glVertexWeightPointerEXT := SYSTEM.VAL(TglVertexWeightPointerEXT, glXGetProcAddress('glVertexWeightPointerEXT'));
END Read_GL_EXT_vertex_weighting;

PROCEDURE Read_GL_EXT_depth_bounds_test;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, glXGetProcAddress('glImageTransformParameteriHP'));
     glDepthBoundsEXT := SYSTEM.VAL(TglDepthBoundsEXT, glXGetProcAddress('glDepthBoundsEXT'));
END Read_GL_EXT_depth_bounds_test;

PROCEDURE Read_GL_EXT_blend_equation_separate;
BEGIN
     glBlendEquationSeparateEXT := SYSTEM.VAL(TglBlendEquationSeparateEXT, glXGetProcAddress('glBlendEquationSeparateEXT'));
END Read_GL_EXT_blend_equation_separate;

PROCEDURE Read_GL_EXT_stencil_clear_tag;
BEGIN
     glStencilClearTagEXT := SYSTEM.VAL(TglStencilClearTagEXT, glXGetProcAddress('glStencilClearTagEXT'));
END Read_GL_EXT_stencil_clear_tag;

PROCEDURE Read_GL_EXT_framebuffer_blit;
BEGIN
     glBlitFramebufferEXT := SYSTEM.VAL(TglBlitFramebufferEXT, glXGetProcAddress('glBlitFramebufferEXT'));
END Read_GL_EXT_framebuffer_blit;

PROCEDURE Read_GL_EXT_framebuffer_multisample;
BEGIN
     glRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglRenderbufferStorageMultisampleEXT, glXGetProcAddress('glRenderbufferStorageMultisampleEXT'));
END Read_GL_EXT_framebuffer_multisample;

PROCEDURE Read_GL_EXT_timer_query;
BEGIN
     glGetQueryObjecti64vEXT := SYSTEM.VAL(TglGetQueryObjecti64vEXT, glXGetProcAddress('glGetQueryObjecti64vEXT'));
     glGetQueryObjectui64vEXT := SYSTEM.VAL(TglGetQueryObjectui64vEXT, glXGetProcAddress('glGetQueryObjectui64vEXT'));
END Read_GL_EXT_timer_query;

PROCEDURE Read_GL_EXT_gpu_program_parameters;
BEGIN
     glProgramEnvParameters4fvEXT := SYSTEM.VAL(TglProgramEnvParameters4fvEXT, glXGetProcAddress('glProgramEnvParameters4fvEXT'));
     glProgramLocalParameters4fvEXT := SYSTEM.VAL(TglProgramLocalParameters4fvEXT, glXGetProcAddress('glProgramLocalParameters4fvEXT'));
END Read_GL_EXT_gpu_program_parameters;

PROCEDURE Read_GL_EXT_bindable_uniform;
BEGIN
     glUniformBufferEXT := SYSTEM.VAL(TglUniformBufferEXT, glXGetProcAddress('glUniformBufferEXT'));
     glGetUniformBufferSizeEXT := SYSTEM.VAL(TglGetUniformBufferSizeEXT, glXGetProcAddress('glGetUniformBufferSizeEXT'));
     glGetUniformOffsetEXT := SYSTEM.VAL(TglGetUniformOffsetEXT, glXGetProcAddress('glGetUniformOffsetEXT'));
END Read_GL_EXT_bindable_uniform;

PROCEDURE Read_GL_EXT_draw_buffers2;
BEGIN
     glColorMaskIndexedEXT := SYSTEM.VAL(TglColorMaskIndexedEXT, glXGetProcAddress('glColorMaskIndexedEXT'));
     glGetBooleanIndexedvEXT := SYSTEM.VAL(TglGetBooleanIndexedvEXT, glXGetProcAddress('glGetBooleanIndexedvEXT'));
     glGetIntegerIndexedvEXT := SYSTEM.VAL(TglGetIntegerIndexedvEXT, glXGetProcAddress('glGetIntegerIndexedvEXT'));
     glEnableIndexedEXT := SYSTEM.VAL(TglEnableIndexedEXT, glXGetProcAddress('glEnableIndexedEXT'));
     glDisableIndexedEXT := SYSTEM.VAL(TglDisableIndexedEXT, glXGetProcAddress('glDisableIndexedEXT'));
     glIsEnabledIndexedEXT := SYSTEM.VAL(TglIsEnabledIndexedEXT, glXGetProcAddress('glIsEnabledIndexedEXT'));
END Read_GL_EXT_draw_buffers2;

PROCEDURE Read_GL_EXT_draw_instanced;
BEGIN
     glDrawArraysInstancedEXT := SYSTEM.VAL(TglDrawArraysInstancedEXT, glXGetProcAddress('glDrawArraysInstancedEXT'));
     glDrawElementsInstancedEXT := SYSTEM.VAL(TglDrawElementsInstancedEXT, glXGetProcAddress('glDrawElementsInstancedEXT'));
END Read_GL_EXT_draw_instanced;

PROCEDURE Read_GL_EXT_geometry_shader4;
BEGIN
     glProgramParameteriEXT := SYSTEM.VAL(TglProgramParameteriEXT, glXGetProcAddress('glProgramParameteriEXT'));
     glFramebufferTextureEXT := SYSTEM.VAL(TglFramebufferTextureEXT, glXGetProcAddress('glFramebufferTextureEXT'));
     glFramebufferTextureFaceEXT := SYSTEM.VAL(TglFramebufferTextureFaceEXT, glXGetProcAddress('glFramebufferTextureFaceEXT'));
END Read_GL_EXT_geometry_shader4;

PROCEDURE Read_GL_EXT_gpu_shader4;
BEGIN
     glVertexAttribI1iEXT := SYSTEM.VAL(TglVertexAttribI1iEXT, glXGetProcAddress('glVertexAttribI1iEXT'));
     glVertexAttribI2iEXT := SYSTEM.VAL(TglVertexAttribI2iEXT, glXGetProcAddress('glVertexAttribI2iEXT'));
     glVertexAttribI3iEXT := SYSTEM.VAL(TglVertexAttribI3iEXT, glXGetProcAddress('glVertexAttribI3iEXT'));
     glVertexAttribI4iEXT := SYSTEM.VAL(TglVertexAttribI4iEXT, glXGetProcAddress('glVertexAttribI4iEXT'));
     glVertexAttribI1uiEXT := SYSTEM.VAL(TglVertexAttribI1uiEXT, glXGetProcAddress('glVertexAttribI1uiEXT'));
     glVertexAttribI2uiEXT := SYSTEM.VAL(TglVertexAttribI2uiEXT, glXGetProcAddress('glVertexAttribI2uiEXT'));
     glVertexAttribI3uiEXT := SYSTEM.VAL(TglVertexAttribI3uiEXT, glXGetProcAddress('glVertexAttribI3uiEXT'));
     glVertexAttribI4uiEXT := SYSTEM.VAL(TglVertexAttribI4uiEXT, glXGetProcAddress('glVertexAttribI4uiEXT'));
     glVertexAttribI1ivEXT := SYSTEM.VAL(TglVertexAttribI1ivEXT, glXGetProcAddress('glVertexAttribI1ivEXT'));
     glVertexAttribI2ivEXT := SYSTEM.VAL(TglVertexAttribI2ivEXT, glXGetProcAddress('glVertexAttribI2ivEXT'));
     glVertexAttribI3ivEXT := SYSTEM.VAL(TglVertexAttribI3ivEXT, glXGetProcAddress('glVertexAttribI3ivEXT'));
     glVertexAttribI4ivEXT := SYSTEM.VAL(TglVertexAttribI4ivEXT, glXGetProcAddress('glVertexAttribI4ivEXT'));
     glVertexAttribI1uivEXT := SYSTEM.VAL(TglVertexAttribI1uivEXT, glXGetProcAddress('glVertexAttribI1uivEXT'));
     glVertexAttribI2uivEXT := SYSTEM.VAL(TglVertexAttribI2uivEXT, glXGetProcAddress('glVertexAttribI2uivEXT'));
     glVertexAttribI3uivEXT := SYSTEM.VAL(TglVertexAttribI3uivEXT, glXGetProcAddress('glVertexAttribI3uivEXT'));
     glVertexAttribI4uivEXT := SYSTEM.VAL(TglVertexAttribI4uivEXT, glXGetProcAddress('glVertexAttribI4uivEXT'));
     glVertexAttribI4bvEXT := SYSTEM.VAL(TglVertexAttribI4bvEXT, glXGetProcAddress('glVertexAttribI4bvEXT'));
     glVertexAttribI4svEXT := SYSTEM.VAL(TglVertexAttribI4svEXT, glXGetProcAddress('glVertexAttribI4svEXT'));
     glVertexAttribI4ubvEXT := SYSTEM.VAL(TglVertexAttribI4ubvEXT, glXGetProcAddress('glVertexAttribI4ubvEXT'));
     glVertexAttribI4usvEXT := SYSTEM.VAL(TglVertexAttribI4usvEXT, glXGetProcAddress('glVertexAttribI4usvEXT'));
     glVertexAttribIPointerEXT := SYSTEM.VAL(TglVertexAttribIPointerEXT, glXGetProcAddress('glVertexAttribIPointerEXT'));
     glGetVertexAttribIivEXT := SYSTEM.VAL(TglGetVertexAttribIivEXT, glXGetProcAddress('glGetVertexAttribIivEXT'));
     glGetVertexAttribIuivEXT := SYSTEM.VAL(TglGetVertexAttribIuivEXT, glXGetProcAddress('glGetVertexAttribIuivEXT'));
     glUniform1uiEXT := SYSTEM.VAL(TglUniform1uiEXT, glXGetProcAddress('glUniform1uiEXT'));
     glUniform2uiEXT := SYSTEM.VAL(TglUniform2uiEXT, glXGetProcAddress('glUniform2uiEXT'));
     glUniform3uiEXT := SYSTEM.VAL(TglUniform3uiEXT, glXGetProcAddress('glUniform3uiEXT'));
     glUniform4uiEXT := SYSTEM.VAL(TglUniform4uiEXT, glXGetProcAddress('glUniform4uiEXT'));
     glUniform1uivEXT := SYSTEM.VAL(TglUniform1uivEXT, glXGetProcAddress('glUniform1uivEXT'));
     glUniform2uivEXT := SYSTEM.VAL(TglUniform2uivEXT, glXGetProcAddress('glUniform2uivEXT'));
     glUniform3uivEXT := SYSTEM.VAL(TglUniform3uivEXT, glXGetProcAddress('glUniform3uivEXT'));
     glUniform4uivEXT := SYSTEM.VAL(TglUniform4uivEXT, glXGetProcAddress('glUniform4uivEXT'));
     glGetUniformuivEXT := SYSTEM.VAL(TglGetUniformuivEXT, glXGetProcAddress('glGetUniformuivEXT'));
     glBindFragDataLocationEXT := SYSTEM.VAL(TglBindFragDataLocationEXT, glXGetProcAddress('glBindFragDataLocationEXT'));
     glGetFragDataLocationEXT := SYSTEM.VAL(TglGetFragDataLocationEXT, glXGetProcAddress('glGetFragDataLocationEXT'));
END Read_GL_EXT_gpu_shader4;

PROCEDURE Read_GL_EXT_texture_array;
BEGIN
     glFramebufferTextureLayerEXT := SYSTEM.VAL(TglFramebufferTextureLayerEXT, glXGetProcAddress('glFramebufferTextureLayerEXT'));
END Read_GL_EXT_texture_array;

PROCEDURE Read_GL_EXT_texture_buffer_object;
BEGIN
     glTexBufferEXT := SYSTEM.VAL(TglTexBufferEXT, glXGetProcAddress('glTexBufferEXT'));
END Read_GL_EXT_texture_buffer_object;

PROCEDURE Read_GL_EXT_texture_integer;
BEGIN
     glClearColorIiEXT := SYSTEM.VAL(TglClearColorIiEXT, glXGetProcAddress('glClearColorIiEXT'));
     glClearColorIuiEXT := SYSTEM.VAL(TglClearColorIuiEXT, glXGetProcAddress('glClearColorIuiEXT'));
     glTexParameterIivEXT := SYSTEM.VAL(TglTexParameterIivEXT, glXGetProcAddress('glTexParameterIivEXT'));
     glTexParameterIuivEXT := SYSTEM.VAL(TglTexParameterIuivEXT, glXGetProcAddress('glTexParameterIuivEXT'));
     glGetTexParameterIivEXT := SYSTEM.VAL(TglGetTexParameterIivEXT, glXGetProcAddress('glGetTexParameterIivEXT'));
     glGetTexParameterIiuvEXT := SYSTEM.VAL(TglGetTexParameterIiuvEXT, glXGetProcAddress('glGetTexParameterIiuvEXT'));
END Read_GL_EXT_texture_integer;

PROCEDURE Read_GL_EXT_transform_feedback;
BEGIN
     glBeginTransformFeedbackEXT := SYSTEM.VAL(TglBeginTransformFeedbackEXT, glXGetProcAddress('glBeginTransformFeedbackEXT'));
     glEndTransformFeedbackEXT := SYSTEM.VAL(TglEndTransformFeedbackEXT, glXGetProcAddress('glEndTransformFeedbackEXT'));
     glBindBufferRangeEXT := SYSTEM.VAL(TglBindBufferRangeEXT, glXGetProcAddress('glBindBufferRangeEXT'));
     glBindBufferOffsetEXT := SYSTEM.VAL(TglBindBufferOffsetEXT, glXGetProcAddress('glBindBufferOffsetEXT'));
     glBindBufferBaseEXT := SYSTEM.VAL(TglBindBufferBaseEXT, glXGetProcAddress('glBindBufferBaseEXT'));
     glTransformFeedbackVaryingsEXT := SYSTEM.VAL(TglTransformFeedbackVaryingsEXT, glXGetProcAddress('glTransformFeedbackVaryingsEXT'));
     glGetTransformFeedbackVaryingEXT := SYSTEM.VAL(TglGetTransformFeedbackVaryingEXT, glXGetProcAddress('glGetTransformFeedbackVaryingEXT'));
END Read_GL_EXT_transform_feedback;

PROCEDURE Read_GL_EXT_direct_state_access;
BEGIN
     glClientAttribDefaultEXT := SYSTEM.VAL(TglClientAttribDefaultEXT, glXGetProcAddress('glClientAttribDefaultEXT'));
     glPushClientAttribDefaultEXT := SYSTEM.VAL(TglPushClientAttribDefaultEXT, glXGetProcAddress('glPushClientAttribDefaultEXT'));
     glMatrixLoadfEXT := SYSTEM.VAL(TglMatrixLoadfEXT, glXGetProcAddress('glMatrixLoadfEXT'));
     glMatrixLoaddEXT := SYSTEM.VAL(TglMatrixLoaddEXT, glXGetProcAddress('glMatrixLoaddEXT'));
     glMatrixMultfEXT := SYSTEM.VAL(TglMatrixMultfEXT, glXGetProcAddress('glMatrixMultfEXT'));
     glMatrixMultdEXT := SYSTEM.VAL(TglMatrixMultdEXT, glXGetProcAddress('glMatrixMultdEXT'));
     glMatrixLoadIdentityEXT := SYSTEM.VAL(TglMatrixLoadIdentityEXT, glXGetProcAddress('glMatrixLoadIdentityEXT'));
     glMatrixRotatefEXT := SYSTEM.VAL(TglMatrixRotatefEXT, glXGetProcAddress('glMatrixRotatefEXT'));
     glMatrixRotatedEXT := SYSTEM.VAL(TglMatrixRotatedEXT, glXGetProcAddress('glMatrixRotatedEXT'));
     glMatrixScalefEXT := SYSTEM.VAL(TglMatrixScalefEXT, glXGetProcAddress('glMatrixScalefEXT'));
     glMatrixScaledEXT := SYSTEM.VAL(TglMatrixScaledEXT, glXGetProcAddress('glMatrixScaledEXT'));
     glMatrixTranslatefEXT := SYSTEM.VAL(TglMatrixTranslatefEXT, glXGetProcAddress('glMatrixTranslatefEXT'));
     glMatrixTranslatedEXT := SYSTEM.VAL(TglMatrixTranslatedEXT, glXGetProcAddress('glMatrixTranslatedEXT'));
     glMatrixFrustumEXT := SYSTEM.VAL(TglMatrixFrustumEXT, glXGetProcAddress('glMatrixFrustumEXT'));
     glMatrixOrthoEXT := SYSTEM.VAL(TglMatrixOrthoEXT, glXGetProcAddress('glMatrixOrthoEXT'));
     glMatrixPopEXT := SYSTEM.VAL(TglMatrixPopEXT, glXGetProcAddress('glMatrixPopEXT'));
     glMatrixPushEXT := SYSTEM.VAL(TglMatrixPushEXT, glXGetProcAddress('glMatrixPushEXT'));
     glMatrixLoadTransposefEXT := SYSTEM.VAL(TglMatrixLoadTransposefEXT, glXGetProcAddress('glMatrixLoadTransposefEXT'));
     glMatrixLoadTransposedEXT := SYSTEM.VAL(TglMatrixLoadTransposedEXT, glXGetProcAddress('glMatrixLoadTransposedEXT'));
     glMatrixMultTransposefEXT := SYSTEM.VAL(TglMatrixMultTransposefEXT, glXGetProcAddress('glMatrixMultTransposefEXT'));
     glMatrixMultTransposedEXT := SYSTEM.VAL(TglMatrixMultTransposedEXT, glXGetProcAddress('glMatrixMultTransposedEXT'));
     glTextureParameterfEXT := SYSTEM.VAL(TglTextureParameterfEXT, glXGetProcAddress('glTextureParameterfEXT'));
     glTextureParameterfvEXT := SYSTEM.VAL(TglTextureParameterfvEXT, glXGetProcAddress('glTextureParameterfvEXT'));
     glTextureParameteriEXT := SYSTEM.VAL(TglTextureParameteriEXT, glXGetProcAddress('glTextureParameteriEXT'));
     glTextureParameterivEXT := SYSTEM.VAL(TglTextureParameterivEXT, glXGetProcAddress('glTextureParameterivEXT'));
     glTextureImage1DEXT := SYSTEM.VAL(TglTextureImage1DEXT, glXGetProcAddress('glTextureImage1DEXT'));
     glTextureImage2DEXT := SYSTEM.VAL(TglTextureImage2DEXT, glXGetProcAddress('glTextureImage2DEXT'));
     glTextureSubImage1DEXT := SYSTEM.VAL(TglTextureSubImage1DEXT, glXGetProcAddress('glTextureSubImage1DEXT'));
     glTextureSubImage2DEXT := SYSTEM.VAL(TglTextureSubImage2DEXT, glXGetProcAddress('glTextureSubImage2DEXT'));
     glCopyTextureImage1DEXT := SYSTEM.VAL(TglCopyTextureImage1DEXT, glXGetProcAddress('glCopyTextureImage1DEXT'));
     glCopyTextureImage2DEXT := SYSTEM.VAL(TglCopyTextureImage2DEXT, glXGetProcAddress('glCopyTextureImage2DEXT'));
     glCopyTextureSubImage1DEXT := SYSTEM.VAL(TglCopyTextureSubImage1DEXT, glXGetProcAddress('glCopyTextureSubImage1DEXT'));
     glCopyTextureSubImage2DEXT := SYSTEM.VAL(TglCopyTextureSubImage2DEXT, glXGetProcAddress('glCopyTextureSubImage2DEXT'));
     glGetTextureImageEXT := SYSTEM.VAL(TglGetTextureImageEXT, glXGetProcAddress('glGetTextureImageEXT'));
     glGetTextureParameterfvEXT := SYSTEM.VAL(TglGetTextureParameterfvEXT, glXGetProcAddress('glGetTextureParameterfvEXT'));
     glGetTextureParameterivEXT := SYSTEM.VAL(TglGetTextureParameterivEXT, glXGetProcAddress('glGetTextureParameterivEXT'));
     glGetTextureLevelParameterfvEXT := SYSTEM.VAL(TglGetTextureLevelParameterfvEXT, glXGetProcAddress('glGetTextureLevelParameterfvEXT'));
     glGetTextureLevelParameterivEXT := SYSTEM.VAL(TglGetTextureLevelParameterivEXT, glXGetProcAddress('glGetTextureLevelParameterivEXT'));
     glTextureImage3DEXT := SYSTEM.VAL(TglTextureImage3DEXT, glXGetProcAddress('glTextureImage3DEXT'));
     glTextureSubImage3DEXT := SYSTEM.VAL(TglTextureSubImage3DEXT, glXGetProcAddress('glTextureSubImage3DEXT'));
     glCopyTextureSubImage3DEXT := SYSTEM.VAL(TglCopyTextureSubImage3DEXT, glXGetProcAddress('glCopyTextureSubImage3DEXT'));
     glMultiTexParameterfEXT := SYSTEM.VAL(TglMultiTexParameterfEXT, glXGetProcAddress('glMultiTexParameterfEXT'));
     glMultiTexParameterfvEXT := SYSTEM.VAL(TglMultiTexParameterfvEXT, glXGetProcAddress('glMultiTexParameterfvEXT'));
     glMultiTexParameteriEXT := SYSTEM.VAL(TglMultiTexParameteriEXT, glXGetProcAddress('glMultiTexParameteriEXT'));
     glMultiTexParameterivEXT := SYSTEM.VAL(TglMultiTexParameterivEXT, glXGetProcAddress('glMultiTexParameterivEXT'));
     glMultiTexImage1DEXT := SYSTEM.VAL(TglMultiTexImage1DEXT, glXGetProcAddress('glMultiTexImage1DEXT'));
     glMultiTexImage2DEXT := SYSTEM.VAL(TglMultiTexImage2DEXT, glXGetProcAddress('glMultiTexImage2DEXT'));
     glMultiTexSubImage1DEXT := SYSTEM.VAL(TglMultiTexSubImage1DEXT, glXGetProcAddress('glMultiTexSubImage1DEXT'));
     glMultiTexSubImage2DEXT := SYSTEM.VAL(TglMultiTexSubImage2DEXT, glXGetProcAddress('glMultiTexSubImage2DEXT'));
     glCopyMultiTexImage1DEXT := SYSTEM.VAL(TglCopyMultiTexImage1DEXT, glXGetProcAddress('glCopyMultiTexImage1DEXT'));
     glCopyMultiTexImage2DEXT := SYSTEM.VAL(TglCopyMultiTexImage2DEXT, glXGetProcAddress('glCopyMultiTexImage2DEXT'));
     glCopyMultiTexSubImage1DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage1DEXT, glXGetProcAddress('glCopyMultiTexSubImage1DEXT'));
     glCopyMultiTexSubImage2DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage2DEXT, glXGetProcAddress('glCopyMultiTexSubImage2DEXT'));
     glGetMultiTexImageEXT := SYSTEM.VAL(TglGetMultiTexImageEXT, glXGetProcAddress('glGetMultiTexImageEXT'));
     glGetMultiTexParameterfvEXT := SYSTEM.VAL(TglGetMultiTexParameterfvEXT, glXGetProcAddress('glGetMultiTexParameterfvEXT'));
     glGetMultiTexParameterivEXT := SYSTEM.VAL(TglGetMultiTexParameterivEXT, glXGetProcAddress('glGetMultiTexParameterivEXT'));
     glGetMultiTexLevelParameterfvEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterfvEXT, glXGetProcAddress('glGetMultiTexLevelParameterfvEXT'));
     glGetMultiTexLevelParameterivEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterivEXT, glXGetProcAddress('glGetMultiTexLevelParameterivEXT'));
     glMultiTexImage3DEXT := SYSTEM.VAL(TglMultiTexImage3DEXT, glXGetProcAddress('glMultiTexImage3DEXT'));
     glMultiTexSubImage3DEXT := SYSTEM.VAL(TglMultiTexSubImage3DEXT, glXGetProcAddress('glMultiTexSubImage3DEXT'));
     glCopyMultiTexSubImage3DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage3DEXT, glXGetProcAddress('glCopyMultiTexSubImage3DEXT'));
     glBindMultiTextureEXT := SYSTEM.VAL(TglBindMultiTextureEXT, glXGetProcAddress('glBindMultiTextureEXT'));
     glEnableClientStateIndexedEXT := SYSTEM.VAL(TglEnableClientStateIndexedEXT, glXGetProcAddress('glEnableClientStateIndexedEXT'));
     glDisableClientStateIndexedEXT := SYSTEM.VAL(TglDisableClientStateIndexedEXT, glXGetProcAddress('glDisableClientStateIndexedEXT'));
     glMultiTexCoordPointerEXT := SYSTEM.VAL(TglMultiTexCoordPointerEXT, glXGetProcAddress('glMultiTexCoordPointerEXT'));
     glMultiTexEnvfEXT := SYSTEM.VAL(TglMultiTexEnvfEXT, glXGetProcAddress('glMultiTexEnvfEXT'));
     glMultiTexEnvfvEXT := SYSTEM.VAL(TglMultiTexEnvfvEXT, glXGetProcAddress('glMultiTexEnvfvEXT'));
     glMultiTexEnviEXT := SYSTEM.VAL(TglMultiTexEnviEXT, glXGetProcAddress('glMultiTexEnviEXT'));
     glMultiTexEnvivEXT := SYSTEM.VAL(TglMultiTexEnvivEXT, glXGetProcAddress('glMultiTexEnvivEXT'));
     glMultiTexGendEXT := SYSTEM.VAL(TglMultiTexGendEXT, glXGetProcAddress('glMultiTexGendEXT'));
     glMultiTexGendvEXT := SYSTEM.VAL(TglMultiTexGendvEXT, glXGetProcAddress('glMultiTexGendvEXT'));
     glMultiTexGenfEXT := SYSTEM.VAL(TglMultiTexGenfEXT, glXGetProcAddress('glMultiTexGenfEXT'));
     glMultiTexGenfvEXT := SYSTEM.VAL(TglMultiTexGenfvEXT, glXGetProcAddress('glMultiTexGenfvEXT'));
     glMultiTexGeniEXT := SYSTEM.VAL(TglMultiTexGeniEXT, glXGetProcAddress('glMultiTexGeniEXT'));
     glMultiTexGenivEXT := SYSTEM.VAL(TglMultiTexGenivEXT, glXGetProcAddress('glMultiTexGenivEXT'));
     glGetMultiTexEnvfvEXT := SYSTEM.VAL(TglGetMultiTexEnvfvEXT, glXGetProcAddress('glGetMultiTexEnvfvEXT'));
     glGetMultiTexEnvivEXT := SYSTEM.VAL(TglGetMultiTexEnvivEXT, glXGetProcAddress('glGetMultiTexEnvivEXT'));
     glGetMultiTexGendvEXT := SYSTEM.VAL(TglGetMultiTexGendvEXT, glXGetProcAddress('glGetMultiTexGendvEXT'));
     glGetMultiTexGenfvEXT := SYSTEM.VAL(TglGetMultiTexGenfvEXT, glXGetProcAddress('glGetMultiTexGenfvEXT'));
     glGetMultiTexGenivEXT := SYSTEM.VAL(TglGetMultiTexGenivEXT, glXGetProcAddress('glGetMultiTexGenivEXT'));
     glGetFloatIndexedvEXT := SYSTEM.VAL(TglGetFloatIndexedvEXT, glXGetProcAddress('glGetFloatIndexedvEXT'));
     glGetDoubleIndexedvEXT := SYSTEM.VAL(TglGetDoubleIndexedvEXT, glXGetProcAddress('glGetDoubleIndexedvEXT'));
     glGetPointerIndexedvEXT := SYSTEM.VAL(TglGetPointerIndexedvEXT, glXGetProcAddress('glGetPointerIndexedvEXT'));
     glCompressedTextureImage3DEXT := SYSTEM.VAL(TglCompressedTextureImage3DEXT, glXGetProcAddress('glCompressedTextureImage3DEXT'));
     glCompressedTextureImage2DEXT := SYSTEM.VAL(TglCompressedTextureImage2DEXT, glXGetProcAddress('glCompressedTextureImage2DEXT'));
     glCompressedTextureImage1DEXT := SYSTEM.VAL(TglCompressedTextureImage1DEXT, glXGetProcAddress('glCompressedTextureImage1DEXT'));
     glCompressedTextureSubImage3DEXT := SYSTEM.VAL(TglCompressedTextureSubImage3DEXT, glXGetProcAddress('glCompressedTextureSubImage3DEXT'));
     glCompressedTextureSubImage2DEXT := SYSTEM.VAL(TglCompressedTextureSubImage2DEXT, glXGetProcAddress('glCompressedTextureSubImage2DEXT'));
     glCompressedTextureSubImage1DEXT := SYSTEM.VAL(TglCompressedTextureSubImage1DEXT, glXGetProcAddress('glCompressedTextureSubImage1DEXT'));
     glGetCompressedTextureImageEXT := SYSTEM.VAL(TglGetCompressedTextureImageEXT, glXGetProcAddress('glGetCompressedTextureImageEXT'));
     glCompressedMultiTexImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexImage3DEXT, glXGetProcAddress('glCompressedMultiTexImage3DEXT'));
     glCompressedMultiTexImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexImage2DEXT, glXGetProcAddress('glCompressedMultiTexImage2DEXT'));
     glCompressedMultiTexImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexImage1DEXT, glXGetProcAddress('glCompressedMultiTexImage1DEXT'));
     glCompressedMultiTexSubImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage3DEXT, glXGetProcAddress('glCompressedMultiTexSubImage3DEXT'));
     glCompressedMultiTexSubImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage2DEXT, glXGetProcAddress('glCompressedMultiTexSubImage2DEXT'));
     glCompressedMultiTexSubImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage1DEXT, glXGetProcAddress('glCompressedMultiTexSubImage1DEXT'));
     glGetCompressedMultiTexImageEXT := SYSTEM.VAL(TglGetCompressedMultiTexImageEXT, glXGetProcAddress('glGetCompressedMultiTexImageEXT'));
     glNamedProgramStringEXT := SYSTEM.VAL(TglNamedProgramStringEXT, glXGetProcAddress('glNamedProgramStringEXT'));
     glNamedProgramLocalParameter4dEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dEXT, glXGetProcAddress('glNamedProgramLocalParameter4dEXT'));
     glNamedProgramLocalParameter4dvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dvEXT, glXGetProcAddress('glNamedProgramLocalParameter4dvEXT'));
     glNamedProgramLocalParameter4fEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fEXT, glXGetProcAddress('glNamedProgramLocalParameter4fEXT'));
     glNamedProgramLocalParameter4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fvEXT, glXGetProcAddress('glNamedProgramLocalParameter4fvEXT'));
     glGetNamedProgramLocalParameterdvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterdvEXT, glXGetProcAddress('glGetNamedProgramLocalParameterdvEXT'));
     glGetNamedProgramLocalParameterfvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterfvEXT, glXGetProcAddress('glGetNamedProgramLocalParameterfvEXT'));
     glGetNamedProgramivEXT := SYSTEM.VAL(TglGetNamedProgramivEXT, glXGetProcAddress('glGetNamedProgramivEXT'));
     glGetNamedProgramStringEXT := SYSTEM.VAL(TglGetNamedProgramStringEXT, glXGetProcAddress('glGetNamedProgramStringEXT'));
     glNamedProgramLocalParameters4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameters4fvEXT, glXGetProcAddress('glNamedProgramLocalParameters4fvEXT'));
     glNamedProgramLocalParameterI4iEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4iEXT, glXGetProcAddress('glNamedProgramLocalParameterI4iEXT'));
     glNamedProgramLocalParameterI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4ivEXT, glXGetProcAddress('glNamedProgramLocalParameterI4ivEXT'));
     glNamedProgramLocalParametersI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4ivEXT, glXGetProcAddress('glNamedProgramLocalParametersI4ivEXT'));
     glNamedProgramLocalParameterI4uiEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uiEXT, glXGetProcAddress('glNamedProgramLocalParameterI4uiEXT'));
     glNamedProgramLocalParameterI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uivEXT, glXGetProcAddress('glNamedProgramLocalParameterI4uivEXT'));
     glNamedProgramLocalParametersI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4uivEXT, glXGetProcAddress('glNamedProgramLocalParametersI4uivEXT'));
     glGetNamedProgramLocalParameterIivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIivEXT, glXGetProcAddress('glGetNamedProgramLocalParameterIivEXT'));
     glGetNamedProgramLocalParameterIuivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIuivEXT, glXGetProcAddress('glGetNamedProgramLocalParameterIuivEXT'));
     glTextureParameterIivEXT := SYSTEM.VAL(TglTextureParameterIivEXT, glXGetProcAddress('glTextureParameterIivEXT'));
     glTextureParameterIuivEXT := SYSTEM.VAL(TglTextureParameterIuivEXT, glXGetProcAddress('glTextureParameterIuivEXT'));
     glGetTextureParameterIivEXT := SYSTEM.VAL(TglGetTextureParameterIivEXT, glXGetProcAddress('glGetTextureParameterIivEXT'));
     glGetTextureParameterIuivEXT := SYSTEM.VAL(TglGetTextureParameterIuivEXT, glXGetProcAddress('glGetTextureParameterIuivEXT'));
     glMultiTexParameterIivEXT := SYSTEM.VAL(TglMultiTexParameterIivEXT, glXGetProcAddress('glMultiTexParameterIivEXT'));
     glMultiTexParameterIuivEXT := SYSTEM.VAL(TglMultiTexParameterIuivEXT, glXGetProcAddress('glMultiTexParameterIuivEXT'));
     glGetMultiTexParameterIivEXT := SYSTEM.VAL(TglGetMultiTexParameterIivEXT, glXGetProcAddress('glGetMultiTexParameterIivEXT'));
     glGetMultiTexParameterIuivEXT := SYSTEM.VAL(TglGetMultiTexParameterIuivEXT, glXGetProcAddress('glGetMultiTexParameterIuivEXT'));
     glProgramUniform1fEXT := SYSTEM.VAL(TglProgramUniform1fEXT, glXGetProcAddress('glProgramUniform1fEXT'));
     glProgramUniform2fEXT := SYSTEM.VAL(TglProgramUniform2fEXT, glXGetProcAddress('glProgramUniform2fEXT'));
     glProgramUniform3fEXT := SYSTEM.VAL(TglProgramUniform3fEXT, glXGetProcAddress('glProgramUniform3fEXT'));
     glProgramUniform4fEXT := SYSTEM.VAL(TglProgramUniform4fEXT, glXGetProcAddress('glProgramUniform4fEXT'));
     glProgramUniform1iEXT := SYSTEM.VAL(TglProgramUniform1iEXT, glXGetProcAddress('glProgramUniform1iEXT'));
     glProgramUniform2iEXT := SYSTEM.VAL(TglProgramUniform2iEXT, glXGetProcAddress('glProgramUniform2iEXT'));
     glProgramUniform3iEXT := SYSTEM.VAL(TglProgramUniform3iEXT, glXGetProcAddress('glProgramUniform3iEXT'));
     glProgramUniform4iEXT := SYSTEM.VAL(TglProgramUniform4iEXT, glXGetProcAddress('glProgramUniform4iEXT'));
     glProgramUniform1fvEXT := SYSTEM.VAL(TglProgramUniform1fvEXT, glXGetProcAddress('glProgramUniform1fvEXT'));
     glProgramUniform2fvEXT := SYSTEM.VAL(TglProgramUniform2fvEXT, glXGetProcAddress('glProgramUniform2fvEXT'));
     glProgramUniform3fvEXT := SYSTEM.VAL(TglProgramUniform3fvEXT, glXGetProcAddress('glProgramUniform3fvEXT'));
     glProgramUniform4fvEXT := SYSTEM.VAL(TglProgramUniform4fvEXT, glXGetProcAddress('glProgramUniform4fvEXT'));
     glProgramUniform1ivEXT := SYSTEM.VAL(TglProgramUniform1ivEXT, glXGetProcAddress('glProgramUniform1ivEXT'));
     glProgramUniform2ivEXT := SYSTEM.VAL(TglProgramUniform2ivEXT, glXGetProcAddress('glProgramUniform2ivEXT'));
     glProgramUniform3ivEXT := SYSTEM.VAL(TglProgramUniform3ivEXT, glXGetProcAddress('glProgramUniform3ivEXT'));
     glProgramUniform4ivEXT := SYSTEM.VAL(TglProgramUniform4ivEXT, glXGetProcAddress('glProgramUniform4ivEXT'));
     glProgramUniformMatrix2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2fvEXT, glXGetProcAddress('glProgramUniformMatrix2fvEXT'));
     glProgramUniformMatrix3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3fvEXT, glXGetProcAddress('glProgramUniformMatrix3fvEXT'));
     glProgramUniformMatrix4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4fvEXT, glXGetProcAddress('glProgramUniformMatrix4fvEXT'));
     glProgramUniformMatrix2x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3fvEXT, glXGetProcAddress('glProgramUniformMatrix2x3fvEXT'));
     glProgramUniformMatrix3x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2fvEXT, glXGetProcAddress('glProgramUniformMatrix3x2fvEXT'));
     glProgramUniformMatrix2x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4fvEXT, glXGetProcAddress('glProgramUniformMatrix2x4fvEXT'));
     glProgramUniformMatrix4x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2fvEXT, glXGetProcAddress('glProgramUniformMatrix4x2fvEXT'));
     glProgramUniformMatrix3x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4fvEXT, glXGetProcAddress('glProgramUniformMatrix3x4fvEXT'));
     glProgramUniformMatrix4x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3fvEXT, glXGetProcAddress('glProgramUniformMatrix4x3fvEXT'));
     glProgramUniform1uiEXT := SYSTEM.VAL(TglProgramUniform1uiEXT, glXGetProcAddress('glProgramUniform1uiEXT'));
     glProgramUniform2uiEXT := SYSTEM.VAL(TglProgramUniform2uiEXT, glXGetProcAddress('glProgramUniform2uiEXT'));
     glProgramUniform3uiEXT := SYSTEM.VAL(TglProgramUniform3uiEXT, glXGetProcAddress('glProgramUniform3uiEXT'));
     glProgramUniform4uiEXT := SYSTEM.VAL(TglProgramUniform4uiEXT, glXGetProcAddress('glProgramUniform4uiEXT'));
     glProgramUniform1uivEXT := SYSTEM.VAL(TglProgramUniform1uivEXT, glXGetProcAddress('glProgramUniform1uivEXT'));
     glProgramUniform2uivEXT := SYSTEM.VAL(TglProgramUniform2uivEXT, glXGetProcAddress('glProgramUniform2uivEXT'));
     glProgramUniform3uivEXT := SYSTEM.VAL(TglProgramUniform3uivEXT, glXGetProcAddress('glProgramUniform3uivEXT'));
     glProgramUniform4uivEXT := SYSTEM.VAL(TglProgramUniform4uivEXT, glXGetProcAddress('glProgramUniform4uivEXT'));
     glNamedBufferDataEXT := SYSTEM.VAL(TglNamedBufferDataEXT, glXGetProcAddress('glNamedBufferDataEXT'));
     glNamedBufferSubDataEXT := SYSTEM.VAL(TglNamedBufferSubDataEXT, glXGetProcAddress('glNamedBufferSubDataEXT'));
     glMapNamedBufferEXT := SYSTEM.VAL(TglMapNamedBufferEXT, glXGetProcAddress('glMapNamedBufferEXT'));
     glUnmapNamedBufferEXT := SYSTEM.VAL(TglUnmapNamedBufferEXT, glXGetProcAddress('glUnmapNamedBufferEXT'));
     glMapNamedBufferRangeEXT := SYSTEM.VAL(TglMapNamedBufferRangeEXT, glXGetProcAddress('glMapNamedBufferRangeEXT'));
     glFlushMappedNamedBufferRangeEXT := SYSTEM.VAL(TglFlushMappedNamedBufferRangeEXT, glXGetProcAddress('glFlushMappedNamedBufferRangeEXT'));
     glNamedCopyBufferSubDataEXT := SYSTEM.VAL(TglNamedCopyBufferSubDataEXT, glXGetProcAddress('glNamedCopyBufferSubDataEXT'));
     glGetNamedBufferParameterivEXT := SYSTEM.VAL(TglGetNamedBufferParameterivEXT, glXGetProcAddress('glGetNamedBufferParameterivEXT'));
     glGetNamedBufferPointervEXT := SYSTEM.VAL(TglGetNamedBufferPointervEXT, glXGetProcAddress('glGetNamedBufferPointervEXT'));
     glGetNamedBufferSubDataEXT := SYSTEM.VAL(TglGetNamedBufferSubDataEXT, glXGetProcAddress('glGetNamedBufferSubDataEXT'));
     glTextureBufferEXT := SYSTEM.VAL(TglTextureBufferEXT, glXGetProcAddress('glTextureBufferEXT'));
     glMultiTexBufferEXT := SYSTEM.VAL(TglMultiTexBufferEXT, glXGetProcAddress('glMultiTexBufferEXT'));
     glNamedRenderbufferStorageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageEXT, glXGetProcAddress('glNamedRenderbufferStorageEXT'));
     glGetNamedRenderbufferParameterivEXT := SYSTEM.VAL(TglGetNamedRenderbufferParameterivEXT, glXGetProcAddress('glGetNamedRenderbufferParameterivEXT'));
     glCheckNamedFramebufferStatusEXT := SYSTEM.VAL(TglCheckNamedFramebufferStatusEXT, glXGetProcAddress('glCheckNamedFramebufferStatusEXT'));
     glNamedFramebufferTexture1DEXT := SYSTEM.VAL(TglNamedFramebufferTexture1DEXT, glXGetProcAddress('glNamedFramebufferTexture1DEXT'));
     glNamedFramebufferTexture2DEXT := SYSTEM.VAL(TglNamedFramebufferTexture2DEXT, glXGetProcAddress('glNamedFramebufferTexture2DEXT'));
     glNamedFramebufferTexture3DEXT := SYSTEM.VAL(TglNamedFramebufferTexture3DEXT, glXGetProcAddress('glNamedFramebufferTexture3DEXT'));
     glNamedFramebufferRenderbufferEXT := SYSTEM.VAL(TglNamedFramebufferRenderbufferEXT, glXGetProcAddress('glNamedFramebufferRenderbufferEXT'));
     glGetNamedFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetNamedFramebufferAttachmentParameterivEXT, glXGetProcAddress('glGetNamedFramebufferAttachmentParameterivEXT'));
     glGenerateTextureMipmapEXT := SYSTEM.VAL(TglGenerateTextureMipmapEXT, glXGetProcAddress('glGenerateTextureMipmapEXT'));
     glGenerateMultiTexMipmapEXT := SYSTEM.VAL(TglGenerateMultiTexMipmapEXT, glXGetProcAddress('glGenerateMultiTexMipmapEXT'));
     glFramebufferDrawBufferEXT := SYSTEM.VAL(TglFramebufferDrawBufferEXT, glXGetProcAddress('glFramebufferDrawBufferEXT'));
     glFramebufferDrawBuffersEXT := SYSTEM.VAL(TglFramebufferDrawBuffersEXT, glXGetProcAddress('glFramebufferDrawBuffersEXT'));
     glFramebufferReadBufferEXT := SYSTEM.VAL(TglFramebufferReadBufferEXT, glXGetProcAddress('glFramebufferReadBufferEXT'));
     glGetFramebufferParameterivEXT := SYSTEM.VAL(TglGetFramebufferParameterivEXT, glXGetProcAddress('glGetFramebufferParameterivEXT'));
     glNamedRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleEXT, glXGetProcAddress('glNamedRenderbufferStorageMultisampleEXT'));
     glNamedRenderbufferStorageMultisampleCoverageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleCoverageEXT, glXGetProcAddress('glNamedRenderbufferStorageMultisampleCoverageEXT'));
     glNamedFramebufferTextureEXT := SYSTEM.VAL(TglNamedFramebufferTextureEXT, glXGetProcAddress('glNamedFramebufferTextureEXT'));
     glNamedFramebufferTextureLayerEXT := SYSTEM.VAL(TglNamedFramebufferTextureLayerEXT, glXGetProcAddress('glNamedFramebufferTextureLayerEXT'));
     glNamedFramebufferTextureFaceEXT := SYSTEM.VAL(TglNamedFramebufferTextureFaceEXT, glXGetProcAddress('glNamedFramebufferTextureFaceEXT'));
     glTextureRenderbufferEXT := SYSTEM.VAL(TglTextureRenderbufferEXT, glXGetProcAddress('glTextureRenderbufferEXT'));
     glMultiTexRenderbufferEXT := SYSTEM.VAL(TglMultiTexRenderbufferEXT, glXGetProcAddress('glMultiTexRenderbufferEXT'));
     glProgramUniform1dEXT := SYSTEM.VAL(TglProgramUniform1dEXT, glXGetProcAddress('glProgramUniform1dEXT'));
     glProgramUniform2dEXT := SYSTEM.VAL(TglProgramUniform2dEXT, glXGetProcAddress('glProgramUniform2dEXT'));
     glProgramUniform3dEXT := SYSTEM.VAL(TglProgramUniform3dEXT, glXGetProcAddress('glProgramUniform3dEXT'));
     glProgramUniform4dEXT := SYSTEM.VAL(TglProgramUniform4dEXT, glXGetProcAddress('glProgramUniform4dEXT'));
     glProgramUniform1dvEXT := SYSTEM.VAL(TglProgramUniform1dvEXT, glXGetProcAddress('glProgramUniform1dvEXT'));
     glProgramUniform2dvEXT := SYSTEM.VAL(TglProgramUniform2dvEXT, glXGetProcAddress('glProgramUniform2dvEXT'));
     glProgramUniform3dvEXT := SYSTEM.VAL(TglProgramUniform3dvEXT, glXGetProcAddress('glProgramUniform3dvEXT'));
     glProgramUniform4dvEXT := SYSTEM.VAL(TglProgramUniform4dvEXT, glXGetProcAddress('glProgramUniform4dvEXT'));
     glProgramUniformMatrix2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2dvEXT, glXGetProcAddress('glProgramUniformMatrix2dvEXT'));
     glProgramUniformMatrix3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3dvEXT, glXGetProcAddress('glProgramUniformMatrix3dvEXT'));
     glProgramUniformMatrix4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4dvEXT, glXGetProcAddress('glProgramUniformMatrix4dvEXT'));
     glProgramUniformMatrix2x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3dvEXT, glXGetProcAddress('glProgramUniformMatrix2x3dvEXT'));
     glProgramUniformMatrix2x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4dvEXT, glXGetProcAddress('glProgramUniformMatrix2x4dvEXT'));
     glProgramUniformMatrix3x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2dvEXT, glXGetProcAddress('glProgramUniformMatrix3x2dvEXT'));
     glProgramUniformMatrix3x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4dvEXT, glXGetProcAddress('glProgramUniformMatrix3x4dvEXT'));
     glProgramUniformMatrix4x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2dvEXT, glXGetProcAddress('glProgramUniformMatrix4x2dvEXT'));
     glProgramUniformMatrix4x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3dvEXT, glXGetProcAddress('glProgramUniformMatrix4x3dvEXT'));
END Read_GL_EXT_direct_state_access;

PROCEDURE Read_GL_EXT_separate_shader_objects;
BEGIN
     glUseShaderProgramEXT := SYSTEM.VAL(TglUseShaderProgramEXT, glXGetProcAddress('glUseShaderProgramEXT'));
     glActiveProgramEXT := SYSTEM.VAL(TglActiveProgramEXT, glXGetProcAddress('glActiveProgramEXT'));
     glCreateShaderProgramEXT := SYSTEM.VAL(TglCreateShaderProgramEXT, glXGetProcAddress('glCreateShaderProgramEXT'));
END Read_GL_EXT_separate_shader_objects;

PROCEDURE Read_GL_EXT_shader_image_load_store;
BEGIN
     glBindImageTextureEXT := SYSTEM.VAL(TglBindImageTextureEXT, glXGetProcAddress('glBindImageTextureEXT'));
     glMemoryBarrierEXT := SYSTEM.VAL(TglMemoryBarrierEXT, glXGetProcAddress('glMemoryBarrierEXT'));
END Read_GL_EXT_shader_image_load_store;

PROCEDURE Read_GL_EXT_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1dEXT := SYSTEM.VAL(TglVertexAttribL1dEXT, glXGetProcAddress('glVertexAttribL1dEXT'));
     glVertexAttribL2dEXT := SYSTEM.VAL(TglVertexAttribL2dEXT, glXGetProcAddress('glVertexAttribL2dEXT'));
     glVertexAttribL3dEXT := SYSTEM.VAL(TglVertexAttribL3dEXT, glXGetProcAddress('glVertexAttribL3dEXT'));
     glVertexAttribL4dEXT := SYSTEM.VAL(TglVertexAttribL4dEXT, glXGetProcAddress('glVertexAttribL4dEXT'));
     glVertexAttribL1dvEXT := SYSTEM.VAL(TglVertexAttribL1dvEXT, glXGetProcAddress('glVertexAttribL1dvEXT'));
     glVertexAttribL2dvEXT := SYSTEM.VAL(TglVertexAttribL2dvEXT, glXGetProcAddress('glVertexAttribL2dvEXT'));
     glVertexAttribL3dvEXT := SYSTEM.VAL(TglVertexAttribL3dvEXT, glXGetProcAddress('glVertexAttribL3dvEXT'));
     glVertexAttribL4dvEXT := SYSTEM.VAL(TglVertexAttribL4dvEXT, glXGetProcAddress('glVertexAttribL4dvEXT'));
     glVertexAttribLPointerEXT := SYSTEM.VAL(TglVertexAttribLPointerEXT, glXGetProcAddress('glVertexAttribLPointerEXT'));
     glGetVertexAttribLdvEXT := SYSTEM.VAL(TglGetVertexAttribLdvEXT, glXGetProcAddress('glGetVertexAttribLdvEXT'));
     glVertexArrayVertexAttribLOffsetEXT := SYSTEM.VAL(TglVertexArrayVertexAttribLOffsetEXT, glXGetProcAddress('glVertexArrayVertexAttribLOffsetEXT'));
END Read_GL_EXT_vertex_attrib_64bit;

PROCEDURE Read_GL_HP_image_transform;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, glXGetProcAddress('glImageTransformParameteriHP'));
     glImageTransformParameterfHP := SYSTEM.VAL(TglImageTransformParameterfHP, glXGetProcAddress('glImageTransformParameterfHP'));
     glImageTransformParameterivHP := SYSTEM.VAL(TglImageTransformParameterivHP, glXGetProcAddress('glImageTransformParameterivHP'));
     glImageTransformParameterfvHP := SYSTEM.VAL(TglImageTransformParameterfvHP, glXGetProcAddress('glImageTransformParameterfvHP'));
     glGetImageTransformParameterivHP := SYSTEM.VAL(TglGetImageTransformParameterivHP, glXGetProcAddress('glGetImageTransformParameterivHP'));
     glGetImageTransformParameterfvHP := SYSTEM.VAL(TglGetImageTransformParameterfvHP, glXGetProcAddress('glGetImageTransformParameterfvHP'));
END Read_GL_HP_image_transform;

PROCEDURE Read_GL_IBM_multimode_draw_arrays;
BEGIN
(*     glMultiModeDrawArraysIBM := SYSTEM.VAL(TglMultiModeDrawArraysIBM, glXGetProcAddress('glMultiModeDrawArraysIBM'));
     glMultiModeDrawElementsIBM := SYSTEM.VAL(TglMultiModeDrawElementsIBM, glXGetProcAddress('glMultiModeDrawElementsIBM'));
*)
END Read_GL_IBM_multimode_draw_arrays;

PROCEDURE Read_GL_IBM_vertex_array_lists;
BEGIN
(*     glColorPointerListIBM := SYSTEM.VAL(TglColorPointerListIBM, glXGetProcAddress('glColorPointerListIBM'));
     glSecondaryColorPointerListIBM := SYSTEM.VAL(TglSecondaryColorPointerListIBM, glXGetProcAddress('glSecondaryColorPointerListIBM'));
     glEdgeFlagPointerListIBM := SYSTEM.VAL(TglEdgeFlagPointerListIBM, glXGetProcAddress('glEdgeFlagPointerListIBM'));
     glFogCoordPointerListIBM := SYSTEM.VAL(TglFogCoordPointerListIBM, glXGetProcAddress('glFogCoordPointerListIBM'));
     glIndexPointerListIBM := SYSTEM.VAL(TglIndexPointerListIBM, glXGetProcAddress('glIndexPointerListIBM'));
     glNormalPointerListIBM := SYSTEM.VAL(TglNormalPointerListIBM, glXGetProcAddress('glNormalPointerListIBM'));
     glTexCoordPointerListIBM := SYSTEM.VAL(TglTexCoordPointerListIBM, glXGetProcAddress('glTexCoordPointerListIBM'));
     glVertexPointerListIBM := SYSTEM.VAL(TglVertexPointerListIBM, glXGetProcAddress('glVertexPointerListIBM'));
*)
END Read_GL_IBM_vertex_array_lists;

PROCEDURE Read_GL_INGR_blend_func_separate;
BEGIN
(*     glBlendFuncSeparateINGR := SYSTEM.VAL(TglBlendFuncSeparateINGR, glXGetProcAddress('glBlendFuncSeparateINGR'));
*)
END Read_GL_INGR_blend_func_separate;

PROCEDURE Read_GL_INTEL_parallel_arrays;
BEGIN
(*     glVertexPointervINTEL := SYSTEM.VAL(TglVertexPointervINTEL, glXGetProcAddress('glVertexPointervINTEL'));
     glNormalPointervINTEL := SYSTEM.VAL(TglNormalPointervINTEL, glXGetProcAddress('glNormalPointervINTEL'));
     glColorPointervINTEL := SYSTEM.VAL(TglColorPointervINTEL, glXGetProcAddress('glColorPointervINTEL'));
     glTexCoordPointervINTEL := SYSTEM.VAL(TglTexCoordPointervINTEL, glXGetProcAddress('glTexCoordPointervINTEL'));
*)
END Read_GL_INTEL_parallel_arrays;

PROCEDURE Read_GL_MESA_resize_buffers;
BEGIN
     glResizeBuffersMESA := SYSTEM.VAL(TglResizeBuffersMESA, glXGetProcAddress('glResizeBuffersMESA'));
END Read_GL_MESA_resize_buffers;

PROCEDURE Read_GL_MESA_window_pos;
BEGIN
     glWindowPos2dMESA := SYSTEM.VAL(TglWindowPos2dMESA, glXGetProcAddress('glWindowPos2dMESA'));
     glWindowPos2dvMESA := SYSTEM.VAL(TglWindowPos2dvMESA, glXGetProcAddress('glWindowPos2dvMESA'));
     glWindowPos2fMESA := SYSTEM.VAL(TglWindowPos2fMESA, glXGetProcAddress('glWindowPos2fMESA'));
     glWindowPos2fvMESA := SYSTEM.VAL(TglWindowPos2fvMESA, glXGetProcAddress('glWindowPos2fvMESA'));
     glWindowPos2iMESA := SYSTEM.VAL(TglWindowPos2iMESA, glXGetProcAddress('glWindowPos2iMESA'));
     glWindowPos2ivMESA := SYSTEM.VAL(TglWindowPos2ivMESA, glXGetProcAddress('glWindowPos2ivMESA'));
     glWindowPos2sMESA := SYSTEM.VAL(TglWindowPos2sMESA, glXGetProcAddress('glWindowPos2sMESA'));
     glWindowPos2svMESA := SYSTEM.VAL(TglWindowPos2svMESA, glXGetProcAddress('glWindowPos2svMESA'));
     glWindowPos3dMESA := SYSTEM.VAL(TglWindowPos3dMESA, glXGetProcAddress('glWindowPos3dMESA'));
     glWindowPos3dvMESA := SYSTEM.VAL(TglWindowPos3dvMESA, glXGetProcAddress('glWindowPos3dvMESA'));
     glWindowPos3fMESA := SYSTEM.VAL(TglWindowPos3fMESA, glXGetProcAddress('glWindowPos3fMESA'));
     glWindowPos3fvMESA := SYSTEM.VAL(TglWindowPos3fvMESA, glXGetProcAddress('glWindowPos3fvMESA'));
     glWindowPos3iMESA := SYSTEM.VAL(TglWindowPos3iMESA, glXGetProcAddress('glWindowPos3iMESA'));
     glWindowPos3ivMESA := SYSTEM.VAL(TglWindowPos3ivMESA, glXGetProcAddress('glWindowPos3ivMESA'));
     glWindowPos3sMESA := SYSTEM.VAL(TglWindowPos3sMESA, glXGetProcAddress('glWindowPos3sMESA'));
     glWindowPos3svMESA := SYSTEM.VAL(TglWindowPos3svMESA, glXGetProcAddress('glWindowPos3svMESA'));
     glWindowPos4dMESA := SYSTEM.VAL(TglWindowPos4dMESA, glXGetProcAddress('glWindowPos4dMESA'));
     glWindowPos4dvMESA := SYSTEM.VAL(TglWindowPos4dvMESA, glXGetProcAddress('glWindowPos4dvMESA'));
     glWindowPos4fMESA := SYSTEM.VAL(TglWindowPos4fMESA, glXGetProcAddress('glWindowPos4fMESA'));
     glWindowPos4fvMESA := SYSTEM.VAL(TglWindowPos4fvMESA, glXGetProcAddress('glWindowPos4fvMESA'));
     glWindowPos4iMESA := SYSTEM.VAL(TglWindowPos4iMESA, glXGetProcAddress('glWindowPos4iMESA'));
     glWindowPos4ivMESA := SYSTEM.VAL(TglWindowPos4ivMESA, glXGetProcAddress('glWindowPos4ivMESA'));
     glWindowPos4sMESA := SYSTEM.VAL(TglWindowPos4sMESA, glXGetProcAddress('glWindowPos4sMESA'));
     glWindowPos4svMESA := SYSTEM.VAL(TglWindowPos4svMESA, glXGetProcAddress('glWindowPos4svMESA'));
END Read_GL_MESA_window_pos;

PROCEDURE Read_GL_NV_evaluators;
BEGIN
     glMapControlPointsNV := SYSTEM.VAL(TglMapControlPointsNV, glXGetProcAddress('glMapControlPointsNV'));
     glMapParameterivNV := SYSTEM.VAL(TglMapParameterivNV, glXGetProcAddress('glMapParameterivNV'));
     glMapParameterfvNV := SYSTEM.VAL(TglMapParameterfvNV, glXGetProcAddress('glMapParameterfvNV'));
     glGetMapControlPointsNV := SYSTEM.VAL(TglGetMapControlPointsNV, glXGetProcAddress('glGetMapControlPointsNV'));
     glGetMapParameterivNV := SYSTEM.VAL(TglGetMapParameterivNV, glXGetProcAddress('glGetMapParameterivNV'));
     glGetMapParameterfvNV := SYSTEM.VAL(TglGetMapParameterfvNV, glXGetProcAddress('glGetMapParameterfvNV'));
     glGetMapAttribParameterivNV := SYSTEM.VAL(TglGetMapAttribParameterivNV, glXGetProcAddress('glGetMapAttribParameterivNV'));
     glGetMapAttribParameterfvNV := SYSTEM.VAL(TglGetMapAttribParameterfvNV, glXGetProcAddress('glGetMapAttribParameterfvNV'));
     glEvalMapsNV := SYSTEM.VAL(TglEvalMapsNV, glXGetProcAddress('glEvalMapsNV'));
END Read_GL_NV_evaluators;

PROCEDURE Read_GL_NV_fence;
BEGIN
     glDeleteFencesNV := SYSTEM.VAL(TglDeleteFencesNV, glXGetProcAddress('glDeleteFencesNV'));
     glGenFencesNV := SYSTEM.VAL(TglGenFencesNV, glXGetProcAddress('glGenFencesNV'));
     glIsFenceNV := SYSTEM.VAL(TglIsFenceNV, glXGetProcAddress('glIsFenceNV'));
     glTestFenceNV := SYSTEM.VAL(TglTestFenceNV, glXGetProcAddress('glTestFenceNV'));
     glGetFenceivNV := SYSTEM.VAL(TglGetFenceivNV, glXGetProcAddress('glGetFenceivNV'));
     glFinishFenceNV := SYSTEM.VAL(TglFinishFenceNV, glXGetProcAddress('glFinishFenceNV'));
     glSetFenceNV := SYSTEM.VAL(TglSetFenceNV, glXGetProcAddress('glSetFenceNV'));
END Read_GL_NV_fence;

PROCEDURE Read_GL_NV_fragment_program;
BEGIN
     glProgramNamedParameter4fNV := SYSTEM.VAL(TglProgramNamedParameter4fNV, glXGetProcAddress('glProgramNamedParameter4fNV'));
     glProgramNamedParameter4dNV := SYSTEM.VAL(TglProgramNamedParameter4dNV, glXGetProcAddress('glProgramNamedParameter4dNV'));
     glProgramNamedParameter4fvNV := SYSTEM.VAL(TglProgramNamedParameter4fvNV, glXGetProcAddress('glProgramNamedParameter4fvNV'));
     glProgramNamedParameter4dvNV := SYSTEM.VAL(TglProgramNamedParameter4dvNV, glXGetProcAddress('glProgramNamedParameter4dvNV'));
     glGetProgramNamedParameterfvNV := SYSTEM.VAL(TglGetProgramNamedParameterfvNV, glXGetProcAddress('glGetProgramNamedParameterfvNV'));
     glGetProgramNamedParameterdvNV := SYSTEM.VAL(TglGetProgramNamedParameterdvNV, glXGetProcAddress('glGetProgramNamedParameterdvNV'));
END Read_GL_NV_fragment_program;

PROCEDURE Read_GL_NV_half_float;
BEGIN
     glVertex2hNV := SYSTEM.VAL(TglVertex2hNV, glXGetProcAddress('glVertex2hNV'));
     glVertex2hvNV := SYSTEM.VAL(TglVertex2hvNV, glXGetProcAddress('glVertex2hvNV'));
     glVertex3hNV := SYSTEM.VAL(TglVertex3hNV, glXGetProcAddress('glVertex3hNV'));
     glVertex3hvNV := SYSTEM.VAL(TglVertex3hvNV, glXGetProcAddress('glVertex3hvNV'));
     glVertex4hNV := SYSTEM.VAL(TglVertex4hNV, glXGetProcAddress('glVertex4hNV'));
     glVertex4hvNV := SYSTEM.VAL(TglVertex4hvNV, glXGetProcAddress('glVertex4hvNV'));
     glNormal3hNV := SYSTEM.VAL(TglNormal3hNV, glXGetProcAddress('glNormal3hNV'));
     glNormal3hvNV := SYSTEM.VAL(TglNormal3hvNV, glXGetProcAddress('glNormal3hvNV'));
     glColor3hNV := SYSTEM.VAL(TglColor3hNV, glXGetProcAddress('glColor3hNV'));
     glColor3hvNV := SYSTEM.VAL(TglColor3hvNV, glXGetProcAddress('glColor3hvNV'));
     glColor4hNV := SYSTEM.VAL(TglColor4hNV, glXGetProcAddress('glColor4hNV'));
     glColor4hvNV := SYSTEM.VAL(TglColor4hvNV, glXGetProcAddress('glColor4hvNV'));
     glTexCoord1hNV := SYSTEM.VAL(TglTexCoord1hNV, glXGetProcAddress('glTexCoord1hNV'));
     glTexCoord1hvNV := SYSTEM.VAL(TglTexCoord1hvNV, glXGetProcAddress('glTexCoord1hvNV'));
     glTexCoord2hNV := SYSTEM.VAL(TglTexCoord2hNV, glXGetProcAddress('glTexCoord2hNV'));
     glTexCoord2hvNV := SYSTEM.VAL(TglTexCoord2hvNV, glXGetProcAddress('glTexCoord2hvNV'));
     glTexCoord3hNV := SYSTEM.VAL(TglTexCoord3hNV, glXGetProcAddress('glTexCoord3hNV'));
     glTexCoord3hvNV := SYSTEM.VAL(TglTexCoord3hvNV, glXGetProcAddress('glTexCoord3hvNV'));
     glTexCoord4hNV := SYSTEM.VAL(TglTexCoord4hNV, glXGetProcAddress('glTexCoord4hNV'));
     glTexCoord4hvNV := SYSTEM.VAL(TglTexCoord4hvNV, glXGetProcAddress('glTexCoord4hvNV'));
     glMultiTexCoord1hNV := SYSTEM.VAL(TglMultiTexCoord1hNV, glXGetProcAddress('glMultiTexCoord1hNV'));
     glMultiTexCoord1hvNV := SYSTEM.VAL(TglMultiTexCoord1hvNV, glXGetProcAddress('glMultiTexCoord1hvNV'));
     glMultiTexCoord2hNV := SYSTEM.VAL(TglMultiTexCoord2hNV, glXGetProcAddress('glMultiTexCoord2hNV'));
     glMultiTexCoord2hvNV := SYSTEM.VAL(TglMultiTexCoord2hvNV, glXGetProcAddress('glMultiTexCoord2hvNV'));
     glMultiTexCoord3hNV := SYSTEM.VAL(TglMultiTexCoord3hNV, glXGetProcAddress('glMultiTexCoord3hNV'));
     glMultiTexCoord3hvNV := SYSTEM.VAL(TglMultiTexCoord3hvNV, glXGetProcAddress('glMultiTexCoord3hvNV'));
     glMultiTexCoord4hNV := SYSTEM.VAL(TglMultiTexCoord4hNV, glXGetProcAddress('glMultiTexCoord4hNV'));
     glMultiTexCoord4hvNV := SYSTEM.VAL(TglMultiTexCoord4hvNV, glXGetProcAddress('glMultiTexCoord4hvNV'));
     glFogCoordhNV := SYSTEM.VAL(TglFogCoordhNV, glXGetProcAddress('glFogCoordhNV'));
     glFogCoordhvNV := SYSTEM.VAL(TglFogCoordhvNV, glXGetProcAddress('glFogCoordhvNV'));
     glSecondaryColor3hNV := SYSTEM.VAL(TglSecondaryColor3hNV, glXGetProcAddress('glSecondaryColor3hNV'));
     glSecondaryColor3hvNV := SYSTEM.VAL(TglSecondaryColor3hvNV, glXGetProcAddress('glSecondaryColor3hvNV'));
     glVertexWeighthNV := SYSTEM.VAL(TglVertexWeighthNV, glXGetProcAddress('glVertexWeighthNV'));
     glVertexWeighthvNV := SYSTEM.VAL(TglVertexWeighthvNV, glXGetProcAddress('glVertexWeighthvNV'));
     glVertexAttrib1hNV := SYSTEM.VAL(TglVertexAttrib1hNV, glXGetProcAddress('glVertexAttrib1hNV'));
     glVertexAttrib1hvNV := SYSTEM.VAL(TglVertexAttrib1hvNV, glXGetProcAddress('glVertexAttrib1hvNV'));
     glVertexAttrib2hNV := SYSTEM.VAL(TglVertexAttrib2hNV, glXGetProcAddress('glVertexAttrib2hNV'));
     glVertexAttrib2hvNV := SYSTEM.VAL(TglVertexAttrib2hvNV, glXGetProcAddress('glVertexAttrib2hvNV'));
     glVertexAttrib3hNV := SYSTEM.VAL(TglVertexAttrib3hNV, glXGetProcAddress('glVertexAttrib3hNV'));
     glVertexAttrib3hvNV := SYSTEM.VAL(TglVertexAttrib3hvNV, glXGetProcAddress('glVertexAttrib3hvNV'));
     glVertexAttrib4hNV := SYSTEM.VAL(TglVertexAttrib4hNV, glXGetProcAddress('glVertexAttrib4hNV'));
     glVertexAttrib4hvNV := SYSTEM.VAL(TglVertexAttrib4hvNV, glXGetProcAddress('glVertexAttrib4hvNV'));
     glVertexAttribs1hvNV := SYSTEM.VAL(TglVertexAttribs1hvNV, glXGetProcAddress('glVertexAttribs1hvNV'));
     glVertexAttribs2hvNV := SYSTEM.VAL(TglVertexAttribs2hvNV, glXGetProcAddress('glVertexAttribs2hvNV'));
     glVertexAttribs3hvNV := SYSTEM.VAL(TglVertexAttribs3hvNV, glXGetProcAddress('glVertexAttribs3hvNV'));
     glVertexAttribs4hvNV := SYSTEM.VAL(TglVertexAttribs4hvNV, glXGetProcAddress('glVertexAttribs4hvNV'));
END Read_GL_NV_half_float;

PROCEDURE Read_GL_NV_occlusion_query;
BEGIN
     glGenOcclusionQueriesNV := SYSTEM.VAL(TglGenOcclusionQueriesNV, glXGetProcAddress('glGenOcclusionQueriesNV'));
     glDeleteOcclusionQueriesNV := SYSTEM.VAL(TglDeleteOcclusionQueriesNV, glXGetProcAddress('glDeleteOcclusionQueriesNV'));
     glIsOcclusionQueryNV := SYSTEM.VAL(TglIsOcclusionQueryNV, glXGetProcAddress('glIsOcclusionQueryNV'));
     glBeginOcclusionQueryNV := SYSTEM.VAL(TglBeginOcclusionQueryNV, glXGetProcAddress('glBeginOcclusionQueryNV'));
     glEndOcclusionQueryNV := SYSTEM.VAL(TglEndOcclusionQueryNV, glXGetProcAddress('glEndOcclusionQueryNV'));
     glGetOcclusionQueryivNV := SYSTEM.VAL(TglGetOcclusionQueryivNV, glXGetProcAddress('glGetOcclusionQueryivNV'));
     glGetOcclusionQueryuivNV := SYSTEM.VAL(TglGetOcclusionQueryuivNV, glXGetProcAddress('glGetOcclusionQueryuivNV'));
END Read_GL_NV_occlusion_query;

PROCEDURE Read_GL_NV_pixel_data_range;
BEGIN
     glPixelDataRangeNV := SYSTEM.VAL(TglPixelDataRangeNV, glXGetProcAddress('glPixelDataRangeNV'));
     glFlushPixelDataRangeNV := SYSTEM.VAL(TglFlushPixelDataRangeNV, glXGetProcAddress('glFlushPixelDataRangeNV'));
END Read_GL_NV_pixel_data_range;

PROCEDURE Read_GL_NV_point_sprite;
BEGIN
     glPointParameteriNV := SYSTEM.VAL(TglPointParameteriNV, glXGetProcAddress('glPointParameteriNV'));
     glPointParameterivNV := SYSTEM.VAL(TglPointParameterivNV, glXGetProcAddress('glPointParameterivNV'));
END Read_GL_NV_point_sprite;

PROCEDURE Read_GL_NV_primitive_restart;
BEGIN
     glPrimitiveRestartNV := SYSTEM.VAL(TglPrimitiveRestartNV, glXGetProcAddress('glPrimitiveRestartNV'));
     glPrimitiveRestartIndexNV := SYSTEM.VAL(TglPrimitiveRestartIndexNV, glXGetProcAddress('glPrimitiveRestartIndexNV'));
END Read_GL_NV_primitive_restart;

PROCEDURE Read_GL_NV_register_combiners;
BEGIN
     glCombinerParameterfvNV := SYSTEM.VAL(TglCombinerParameterfvNV, glXGetProcAddress('glCombinerParameterfvNV'));
     glCombinerParameterfNV := SYSTEM.VAL(TglCombinerParameterfNV, glXGetProcAddress('glCombinerParameterfNV'));
     glCombinerParameterivNV := SYSTEM.VAL(TglCombinerParameterivNV, glXGetProcAddress('glCombinerParameterivNV'));
     glCombinerParameteriNV := SYSTEM.VAL(TglCombinerParameteriNV, glXGetProcAddress('glCombinerParameteriNV'));
     glCombinerInputNV := SYSTEM.VAL(TglCombinerInputNV, glXGetProcAddress('glCombinerInputNV'));
     glCombinerOutputNV := SYSTEM.VAL(TglCombinerOutputNV, glXGetProcAddress('glCombinerOutputNV'));
     glFinalCombinerInputNV := SYSTEM.VAL(TglFinalCombinerInputNV, glXGetProcAddress('glFinalCombinerInputNV'));
     glGetCombinerInputParameterfvNV := SYSTEM.VAL(TglGetCombinerInputParameterfvNV, glXGetProcAddress('glGetCombinerInputParameterfvNV'));
     glGetCombinerInputParameterivNV := SYSTEM.VAL(TglGetCombinerInputParameterivNV, glXGetProcAddress('glGetCombinerInputParameterivNV'));
     glGetCombinerOutputParameterfvNV := SYSTEM.VAL(TglGetCombinerOutputParameterfvNV, glXGetProcAddress('glGetCombinerOutputParameterfvNV'));
     glGetCombinerOutputParameterivNV := SYSTEM.VAL(TglGetCombinerOutputParameterivNV, glXGetProcAddress('glGetCombinerOutputParameterivNV'));
     glGetFinalCombinerInputParameterfvNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterfvNV, glXGetProcAddress('glGetFinalCombinerInputParameterfvNV'));
     glGetFinalCombinerInputParameterivNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterivNV, glXGetProcAddress('glGetFinalCombinerInputParameterivNV'));
END Read_GL_NV_register_combiners;

PROCEDURE Read_GL_NV_register_combiners2;
BEGIN
     glCombinerStageParameterfvNV := SYSTEM.VAL(TglCombinerStageParameterfvNV, glXGetProcAddress('glCombinerStageParameterfvNV'));
     glGetCombinerStageParameterfvNV := SYSTEM.VAL(TglGetCombinerStageParameterfvNV, glXGetProcAddress('glGetCombinerStageParameterfvNV'));
END Read_GL_NV_register_combiners2;

PROCEDURE Read_GL_NV_vertex_array_range;
BEGIN
     glFlushVertexArrayRangeNV := SYSTEM.VAL(TglFlushVertexArrayRangeNV, glXGetProcAddress('glFlushVertexArrayRangeNV'));
     glVertexArrayRangeNV := SYSTEM.VAL(TglVertexArrayRangeNV, glXGetProcAddress('glVertexArrayRangeNV'));
END Read_GL_NV_vertex_array_range;

PROCEDURE Read_GL_NV_vertex_program;
BEGIN
     glAreProgramsResidentNV := SYSTEM.VAL(TglAreProgramsResidentNV, glXGetProcAddress('glAreProgramsResidentNV'));
     glBindProgramNV := SYSTEM.VAL(TglBindProgramNV, glXGetProcAddress('glBindProgramNV'));
     glDeleteProgramsNV := SYSTEM.VAL(TglDeleteProgramsNV, glXGetProcAddress('glDeleteProgramsNV'));
     glExecuteProgramNV := SYSTEM.VAL(TglExecuteProgramNV, glXGetProcAddress('glExecuteProgramNV'));
     glGenProgramsNV := SYSTEM.VAL(TglGenProgramsNV, glXGetProcAddress('glGenProgramsNV'));
     glGetProgramParameterdvNV := SYSTEM.VAL(TglGetProgramParameterdvNV, glXGetProcAddress('glGetProgramParameterdvNV'));
     glGetProgramParameterfvNV := SYSTEM.VAL(TglGetProgramParameterfvNV, glXGetProcAddress('glGetProgramParameterfvNV'));
     glGetProgramivNV := SYSTEM.VAL(TglGetProgramivNV, glXGetProcAddress('glGetProgramivNV'));
     glGetProgramStringNV := SYSTEM.VAL(TglGetProgramStringNV, glXGetProcAddress('glGetProgramStringNV'));
     glGetTrackMatrixivNV := SYSTEM.VAL(TglGetTrackMatrixivNV, glXGetProcAddress('glGetTrackMatrixivNV'));
     glGetVertexAttribdvNV := SYSTEM.VAL(TglGetVertexAttribdvNV, glXGetProcAddress('glGetVertexAttribdvNV'));
     glGetVertexAttribfvNV := SYSTEM.VAL(TglGetVertexAttribfvNV, glXGetProcAddress('glGetVertexAttribfvNV'));
     glGetVertexAttribivNV := SYSTEM.VAL(TglGetVertexAttribivNV, glXGetProcAddress('glGetVertexAttribivNV'));
     glGetVertexAttribPointervNV := SYSTEM.VAL(TglGetVertexAttribPointervNV, glXGetProcAddress('glGetVertexAttribPointervNV'));
     glIsProgramNV := SYSTEM.VAL(TglIsProgramNV, glXGetProcAddress('glIsProgramNV'));
     glLoadProgramNV := SYSTEM.VAL(TglLoadProgramNV, glXGetProcAddress('glLoadProgramNV'));
     glProgramParameter4dNV := SYSTEM.VAL(TglProgramParameter4dNV, glXGetProcAddress('glProgramParameter4dNV'));
     glProgramParameter4dvNV := SYSTEM.VAL(TglProgramParameter4dvNV, glXGetProcAddress('glProgramParameter4dvNV'));
     glProgramParameter4fNV := SYSTEM.VAL(TglProgramParameter4fNV, glXGetProcAddress('glProgramParameter4fNV'));
     glProgramParameter4fvNV := SYSTEM.VAL(TglProgramParameter4fvNV, glXGetProcAddress('glProgramParameter4fvNV'));
     glProgramParameters4dvNV := SYSTEM.VAL(TglProgramParameters4dvNV, glXGetProcAddress('glProgramParameters4dvNV'));
     glProgramParameters4fvNV := SYSTEM.VAL(TglProgramParameters4fvNV, glXGetProcAddress('glProgramParameters4fvNV'));
     glRequestResidentProgramsNV := SYSTEM.VAL(TglRequestResidentProgramsNV, glXGetProcAddress('glRequestResidentProgramsNV'));
     glTrackMatrixNV := SYSTEM.VAL(TglTrackMatrixNV, glXGetProcAddress('glTrackMatrixNV'));
     glVertexAttribPointerNV := SYSTEM.VAL(TglVertexAttribPointerNV, glXGetProcAddress('glVertexAttribPointerNV'));
     glVertexAttrib1dNV := SYSTEM.VAL(TglVertexAttrib1dNV, glXGetProcAddress('glVertexAttrib1dNV'));
     glVertexAttrib1dvNV := SYSTEM.VAL(TglVertexAttrib1dvNV, glXGetProcAddress('glVertexAttrib1dvNV'));
     glVertexAttrib1fNV := SYSTEM.VAL(TglVertexAttrib1fNV, glXGetProcAddress('glVertexAttrib1fNV'));
     glVertexAttrib1fvNV := SYSTEM.VAL(TglVertexAttrib1fvNV, glXGetProcAddress('glVertexAttrib1fvNV'));
     glVertexAttrib1sNV := SYSTEM.VAL(TglVertexAttrib1sNV, glXGetProcAddress('glVertexAttrib1sNV'));
     glVertexAttrib1svNV := SYSTEM.VAL(TglVertexAttrib1svNV, glXGetProcAddress('glVertexAttrib1svNV'));
     glVertexAttrib2dNV := SYSTEM.VAL(TglVertexAttrib2dNV, glXGetProcAddress('glVertexAttrib2dNV'));
     glVertexAttrib2dvNV := SYSTEM.VAL(TglVertexAttrib2dvNV, glXGetProcAddress('glVertexAttrib2dvNV'));
     glVertexAttrib2fNV := SYSTEM.VAL(TglVertexAttrib2fNV, glXGetProcAddress('glVertexAttrib2fNV'));
     glVertexAttrib2fvNV := SYSTEM.VAL(TglVertexAttrib2fvNV, glXGetProcAddress('glVertexAttrib2fvNV'));
     glVertexAttrib2sNV := SYSTEM.VAL(TglVertexAttrib2sNV, glXGetProcAddress('glVertexAttrib2sNV'));
     glVertexAttrib2svNV := SYSTEM.VAL(TglVertexAttrib2svNV, glXGetProcAddress('glVertexAttrib2svNV'));
     glVertexAttrib3dNV := SYSTEM.VAL(TglVertexAttrib3dNV, glXGetProcAddress('glVertexAttrib3dNV'));
     glVertexAttrib3dvNV := SYSTEM.VAL(TglVertexAttrib3dvNV, glXGetProcAddress('glVertexAttrib3dvNV'));
     glVertexAttrib3fNV := SYSTEM.VAL(TglVertexAttrib3fNV, glXGetProcAddress('glVertexAttrib3fNV'));
     glVertexAttrib3fvNV := SYSTEM.VAL(TglVertexAttrib3fvNV, glXGetProcAddress('glVertexAttrib3fvNV'));
     glVertexAttrib3sNV := SYSTEM.VAL(TglVertexAttrib3sNV, glXGetProcAddress('glVertexAttrib3sNV'));
     glVertexAttrib3svNV := SYSTEM.VAL(TglVertexAttrib3svNV, glXGetProcAddress('glVertexAttrib3svNV'));
     glVertexAttrib4dNV := SYSTEM.VAL(TglVertexAttrib4dNV, glXGetProcAddress('glVertexAttrib4dNV'));
     glVertexAttrib4dvNV := SYSTEM.VAL(TglVertexAttrib4dvNV, glXGetProcAddress('glVertexAttrib4dvNV'));
     glVertexAttrib4fNV := SYSTEM.VAL(TglVertexAttrib4fNV, glXGetProcAddress('glVertexAttrib4fNV'));
     glVertexAttrib4fvNV := SYSTEM.VAL(TglVertexAttrib4fvNV, glXGetProcAddress('glVertexAttrib4fvNV'));
     glVertexAttrib4sNV := SYSTEM.VAL(TglVertexAttrib4sNV, glXGetProcAddress('glVertexAttrib4sNV'));
     glVertexAttrib4svNV := SYSTEM.VAL(TglVertexAttrib4svNV, glXGetProcAddress('glVertexAttrib4svNV'));
     glVertexAttrib4ubNV := SYSTEM.VAL(TglVertexAttrib4ubNV, glXGetProcAddress('glVertexAttrib4ubNV'));
     glVertexAttrib4ubvNV := SYSTEM.VAL(TglVertexAttrib4ubvNV, glXGetProcAddress('glVertexAttrib4ubvNV'));
     glVertexAttribs1dvNV := SYSTEM.VAL(TglVertexAttribs1dvNV, glXGetProcAddress('glVertexAttribs1dvNV'));
     glVertexAttribs1fvNV := SYSTEM.VAL(TglVertexAttribs1fvNV, glXGetProcAddress('glVertexAttribs1fvNV'));
     glVertexAttribs1svNV := SYSTEM.VAL(TglVertexAttribs1svNV, glXGetProcAddress('glVertexAttribs1svNV'));
     glVertexAttribs2dvNV := SYSTEM.VAL(TglVertexAttribs2dvNV, glXGetProcAddress('glVertexAttribs2dvNV'));
     glVertexAttribs2fvNV := SYSTEM.VAL(TglVertexAttribs2fvNV, glXGetProcAddress('glVertexAttribs2fvNV'));
     glVertexAttribs2svNV := SYSTEM.VAL(TglVertexAttribs2svNV, glXGetProcAddress('glVertexAttribs2svNV'));
     glVertexAttribs3dvNV := SYSTEM.VAL(TglVertexAttribs3dvNV, glXGetProcAddress('glVertexAttribs3dvNV'));
     glVertexAttribs3fvNV := SYSTEM.VAL(TglVertexAttribs3fvNV, glXGetProcAddress('glVertexAttribs3fvNV'));
     glVertexAttribs3svNV := SYSTEM.VAL(TglVertexAttribs3svNV, glXGetProcAddress('glVertexAttribs3svNV'));
     glVertexAttribs4dvNV := SYSTEM.VAL(TglVertexAttribs4dvNV, glXGetProcAddress('glVertexAttribs4dvNV'));
     glVertexAttribs4fvNV := SYSTEM.VAL(TglVertexAttribs4fvNV, glXGetProcAddress('glVertexAttribs4fvNV'));
     glVertexAttribs4svNV := SYSTEM.VAL(TglVertexAttribs4svNV, glXGetProcAddress('glVertexAttribs4svNV'));
     glVertexAttribs4ubvNV := SYSTEM.VAL(TglVertexAttribs4ubvNV, glXGetProcAddress('glVertexAttribs4ubvNV'));
END Read_GL_NV_vertex_program;

PROCEDURE Read_GL_NV_depth_buffer_float;
BEGIN
     glDepthRangedNV := SYSTEM.VAL(TglDepthRangedNV, glXGetProcAddress('glDepthRangedNV'));
     glClearDepthdNV := SYSTEM.VAL(TglClearDepthdNV, glXGetProcAddress('glClearDepthdNV'));
     glDepthBoundsdNV := SYSTEM.VAL(TglDepthBoundsdNV, glXGetProcAddress('glDepthBoundsdNV'));
END Read_GL_NV_depth_buffer_float;

PROCEDURE Read_GL_NV_framebuffer_multisample_coverage;
BEGIN
     glRenderbufferStorageMultsampleCoverageNV := SYSTEM.VAL(TglRenderbufferStorageMultsampleCoverageNV, glXGetProcAddress('glRenderbufferStorageMultsampleCoverageNV'));
END Read_GL_NV_framebuffer_multisample_coverage;

PROCEDURE Read_GL_NV_geometry_program4;
BEGIN
     glProgramVertexLimitNV := SYSTEM.VAL(TglProgramVertexLimitNV, glXGetProcAddress('glProgramVertexLimitNV'));
END Read_GL_NV_geometry_program4;

PROCEDURE Read_GL_NV_gpu_program4;
BEGIN
     glProgramLocalParameterI4iNV := SYSTEM.VAL(TglProgramLocalParameterI4iNV, glXGetProcAddress('glProgramLocalParameterI4iNV'));
     glProgramLocalParameterI4ivNV := SYSTEM.VAL(TglProgramLocalParameterI4ivNV, glXGetProcAddress('glProgramLocalParameterI4ivNV'));
     glProgramLocalParametersI4ivNV := SYSTEM.VAL(TglProgramLocalParametersI4ivNV, glXGetProcAddress('glProgramLocalParametersI4ivNV'));
     glProgramLocalParameterI4uiNV := SYSTEM.VAL(TglProgramLocalParameterI4uiNV, glXGetProcAddress('glProgramLocalParameterI4uiNV'));
     glProgramLocalParameterI4uivNV := SYSTEM.VAL(TglProgramLocalParameterI4uivNV, glXGetProcAddress('glProgramLocalParameterI4uivNV'));
     glProgramLocalParametersI4uivNV := SYSTEM.VAL(TglProgramLocalParametersI4uivNV, glXGetProcAddress('glProgramLocalParametersI4uivNV'));
     glProgramEnvParameterI4iNV := SYSTEM.VAL(TglProgramEnvParameterI4iNV, glXGetProcAddress('glProgramEnvParameterI4iNV'));
     glProgramEnvParameterI4ivNV := SYSTEM.VAL(TglProgramEnvParameterI4ivNV, glXGetProcAddress('glProgramEnvParameterI4ivNV'));
     glProgramEnvParametersI4ivNV := SYSTEM.VAL(TglProgramEnvParametersI4ivNV, glXGetProcAddress('glProgramEnvParametersI4ivNV'));
     glProgramEnvParameterI4uiNV := SYSTEM.VAL(TglProgramEnvParameterI4uiNV, glXGetProcAddress('glProgramEnvParameterI4uiNV'));
     glProgramEnvParameterI4uivNV := SYSTEM.VAL(TglProgramEnvParameterI4uivNV, glXGetProcAddress('glProgramEnvParameterI4uivNV'));
     glProgramEnvParametersI4uivNV := SYSTEM.VAL(TglProgramEnvParametersI4uivNV, glXGetProcAddress('glProgramEnvParametersI4uivNV'));
     glGetProgramLocalParameterIivNV := SYSTEM.VAL(TglGetProgramLocalParameterIivNV, glXGetProcAddress('glGetProgramLocalParameterIivNV'));
     glGetProgramLocalParameterIuivNV := SYSTEM.VAL(TglGetProgramLocalParameterIuivNV, glXGetProcAddress('glGetProgramLocalParameterIuivNV'));
     glGetProgramEnvParameterIivNV := SYSTEM.VAL(TglGetProgramEnvParameterIivNV, glXGetProcAddress('glGetProgramEnvParameterIivNV'));
     glGetProgramEnvParameterIuivNV := SYSTEM.VAL(TglGetProgramEnvParameterIuivNV, glXGetProcAddress('glGetProgramEnvParameterIuivNV'));
END Read_GL_NV_gpu_program4;

PROCEDURE Read_GL_NV_parameter_buffer_object;
BEGIN
     glProgramBufferParametersfvNV := SYSTEM.VAL(TglProgramBufferParametersfvNV, glXGetProcAddress('glProgramBufferParametersfvNV'));
     glProgramBufferParametersIivNV := SYSTEM.VAL(TglProgramBufferParametersIivNV, glXGetProcAddress('glProgramBufferParametersIivNV'));
     glProgramBufferParametersIuivNV := SYSTEM.VAL(TglProgramBufferParametersIuivNV, glXGetProcAddress('glProgramBufferParametersIuivNV'));
END Read_GL_NV_parameter_buffer_object;

PROCEDURE Read_GL_NV_transform_feedback;
BEGIN
     glBeginTransformFeedbackNV := SYSTEM.VAL(TglBeginTransformFeedbackNV, glXGetProcAddress('glBeginTransformFeedbackNV'));
     glEndTransformFeedbackNV := SYSTEM.VAL(TglEndTransformFeedbackNV, glXGetProcAddress('glEndTransformFeedbackNV'));
     glTransformFeedbackAttribsNV := SYSTEM.VAL(TglTransformFeedbackAttribsNV, glXGetProcAddress('glTransformFeedbackAttribsNV'));
     glBindBufferRangeNV := SYSTEM.VAL(TglBindBufferRangeNV, glXGetProcAddress('glBindBufferRangeNV'));
     glBindBufferOffsetNV := SYSTEM.VAL(TglBindBufferOffsetNV, glXGetProcAddress('glBindBufferOffsetNV'));
     glBindBufferBaseNV := SYSTEM.VAL(TglBindBufferBaseNV, glXGetProcAddress('glBindBufferBaseNV'));
     glTransformFeedbackVaryingsNV := SYSTEM.VAL(TglTransformFeedbackVaryingsNV, glXGetProcAddress('glTransformFeedbackVaryingsNV'));
     glActiveVaryingNV := SYSTEM.VAL(TglActiveVaryingNV, glXGetProcAddress('glActiveVaryingNV'));
     glGetVaryingLocationNV := SYSTEM.VAL(TglGetVaryingLocationNV, glXGetProcAddress('glGetVaryingLocationNV'));
     glGetActiveVaryingNV := SYSTEM.VAL(TglGetActiveVaryingNV, glXGetProcAddress('glGetActiveVaryingNV'));
     glGetTransformFeedbackVaryingNV := SYSTEM.VAL(TglGetTransformFeedbackVaryingNV, glXGetProcAddress('glGetTransformFeedbackVaryingNV'));
     glTransformFeedbackStreamAttribsNV := SYSTEM.VAL(TglTransformFeedbackStreamAttribsNV, glXGetProcAddress('glTransformFeedbackStreamAttribsNV'));
END Read_GL_NV_transform_feedback;

PROCEDURE Read_GL_NV_conditional_render;
BEGIN
     glBeginConditionalRenderNV := SYSTEM.VAL(TglBeginConditionalRenderNV, glXGetProcAddress('glBeginConditionalRenderNV'));
     glEndConditionalRenderNV := SYSTEM.VAL(TglEndConditionalRenderNV, glXGetProcAddress('glEndConditionalRenderNV'));
END Read_GL_NV_conditional_render;

PROCEDURE Read_GL_NV_present_video;
BEGIN
     glPresentFrameKeyedNV := SYSTEM.VAL(TglPresentFrameKeyedNV, glXGetProcAddress('glPresentFrameKeyedNV'));
     glPresentFrameDualFillNV := SYSTEM.VAL(TglPresentFrameDualFillNV, glXGetProcAddress('glPresentFrameDualFillNV'));
     glGetVideoivNV := SYSTEM.VAL(TglGetVideoivNV, glXGetProcAddress('glGetVideoivNV'));
     glGetVideouivNV := SYSTEM.VAL(TglGetVideouivNV, glXGetProcAddress('glGetVideouivNV'));
     glGetVideoi64vNV := SYSTEM.VAL(TglGetVideoi64vNV, glXGetProcAddress('glGetVideoi64vNV'));
     glGetVideoui64vNV := SYSTEM.VAL(TglGetVideoui64vNV, glXGetProcAddress('glGetVideoui64vNV'));
END Read_GL_NV_present_video;

PROCEDURE Read_GL_NV_explicit_multisample;
BEGIN
     glGetMultisamplefvNV := SYSTEM.VAL(TglGetMultisamplefvNV, glXGetProcAddress('glGetMultisamplefvNV'));
     glSampleMaskIndexedNV := SYSTEM.VAL(TglSampleMaskIndexedNV, glXGetProcAddress('glSampleMaskIndexedNV'));
     glTexRenderbufferNV := SYSTEM.VAL(TglTexRenderbufferNV, glXGetProcAddress('glTexRenderbufferNV'));
END Read_GL_NV_explicit_multisample;

PROCEDURE Read_GL_NV_transform_feedback2;
BEGIN
     glBindTransformFeedbackNV := SYSTEM.VAL(TglBindTransformFeedbackNV, glXGetProcAddress('glBindTransformFeedbackNV'));
     glDeleteTransformFeedbacksNV := SYSTEM.VAL(TglDeleteTransformFeedbacksNV, glXGetProcAddress('glDeleteTransformFeedbacksNV'));
     glGenTransformFeedbacksNV := SYSTEM.VAL(TglGenTransformFeedbacksNV, glXGetProcAddress('glGenTransformFeedbacksNV'));
     glIsTransformFeedbackNV := SYSTEM.VAL(TglIsTransformFeedbackNV, glXGetProcAddress('glIsTransformFeedbackNV'));
     glPauseTransformFeedbackNV := SYSTEM.VAL(TglPauseTransformFeedbackNV, glXGetProcAddress('glPauseTransformFeedbackNV'));
     glResumeTransformFeedbackNV := SYSTEM.VAL(TglResumeTransformFeedbackNV, glXGetProcAddress('glResumeTransformFeedbackNV'));
     glDrawTransformFeedbackNV := SYSTEM.VAL(TglDrawTransformFeedbackNV, glXGetProcAddress('glDrawTransformFeedbackNV'));
END Read_GL_NV_transform_feedback2;

PROCEDURE Read_GL_NV_video_capture;
BEGIN
     glBeginVideoCaptureNV := SYSTEM.VAL(TglBeginVideoCaptureNV, glXGetProcAddress('glBeginVideoCaptureNV'));
     glBindVideoCaptureStreamBufferNV := SYSTEM.VAL(TglBindVideoCaptureStreamBufferNV, glXGetProcAddress('glBindVideoCaptureStreamBufferNV'));
     glBindVideoCaptureStreamTextureNV := SYSTEM.VAL(TglBindVideoCaptureStreamTextureNV, glXGetProcAddress('glBindVideoCaptureStreamTextureNV'));
     glEndVideoCaptureNV := SYSTEM.VAL(TglEndVideoCaptureNV, glXGetProcAddress('glEndVideoCaptureNV'));
     glGetVideoCaptureivNV := SYSTEM.VAL(TglGetVideoCaptureivNV, glXGetProcAddress('glGetVideoCaptureivNV'));
     glGetVideoCaptureStreamivNV := SYSTEM.VAL(TglGetVideoCaptureStreamivNV, glXGetProcAddress('glGetVideoCaptureStreamivNV'));
     glGetVideoCaptureStreamfvNV := SYSTEM.VAL(TglGetVideoCaptureStreamfvNV, glXGetProcAddress('glGetVideoCaptureStreamfvNV'));
     glGetVideoCaptureStreamdvNV := SYSTEM.VAL(TglGetVideoCaptureStreamdvNV, glXGetProcAddress('glGetVideoCaptureStreamdvNV'));
     glVideoCaptureNV := SYSTEM.VAL(TglVideoCaptureNV, glXGetProcAddress('glVideoCaptureNV'));
     glVideoCaptureStreamParameterivNV := SYSTEM.VAL(TglVideoCaptureStreamParameterivNV, glXGetProcAddress('glVideoCaptureStreamParameterivNV'));
     glVideoCaptureStreamParameterfvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterfvNV, glXGetProcAddress('glVideoCaptureStreamParameterfvNV'));
     glVideoCaptureStreamParameterdvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterdvNV, glXGetProcAddress('glVideoCaptureStreamParameterdvNV'));
END Read_GL_NV_video_capture;

PROCEDURE Read_GL_NV_copy_image;
BEGIN
     glCopyImageSubDataNV := SYSTEM.VAL(TglCopyImageSubDataNV, glXGetProcAddress('glCopyImageSubDataNV'));
END Read_GL_NV_copy_image;

PROCEDURE Read_GL_NV_shader_buffer_load;
BEGIN
     glMakeBufferResidentNV := SYSTEM.VAL(TglMakeBufferResidentNV, glXGetProcAddress('glMakeBufferResidentNV'));
     glMakeBufferNonResidentNV := SYSTEM.VAL(TglMakeBufferNonResidentNV, glXGetProcAddress('glMakeBufferNonResidentNV'));
     glIsBufferResidentNV := SYSTEM.VAL(TglIsBufferResidentNV, glXGetProcAddress('glIsBufferResidentNV'));
     glMakeNamedBufferResidentNV := SYSTEM.VAL(TglMakeNamedBufferResidentNV, glXGetProcAddress('glMakeNamedBufferResidentNV'));
     glMakeNamedBufferNonResidentNV := SYSTEM.VAL(TglMakeNamedBufferNonResidentNV, glXGetProcAddress('glMakeNamedBufferNonResidentNV'));
     glIsNamedBufferResidentNV := SYSTEM.VAL(TglIsNamedBufferResidentNV, glXGetProcAddress('glIsNamedBufferResidentNV'));
     glGetBufferParameterui64vNV := SYSTEM.VAL(TglGetBufferParameterui64vNV, glXGetProcAddress('glGetBufferParameterui64vNV'));
     glGetNamedBufferParameterui64vNV := SYSTEM.VAL(TglGetNamedBufferParameterui64vNV, glXGetProcAddress('glGetNamedBufferParameterui64vNV'));
     glGetIntegerui64vNV := SYSTEM.VAL(TglGetIntegerui64vNV, glXGetProcAddress('glGetIntegerui64vNV'));
     glUniformui64NV := SYSTEM.VAL(TglUniformui64NV, glXGetProcAddress('glUniformui64NV'));
     glUniformui64vNV := SYSTEM.VAL(TglUniformui64vNV, glXGetProcAddress('glUniformui64vNV'));
     glGetUniformui64vNV := SYSTEM.VAL(TglGetUniformui64vNV, glXGetProcAddress('glGetUniformui64vNV'));
     glProgramUniformui64NV := SYSTEM.VAL(TglProgramUniformui64NV, glXGetProcAddress('glProgramUniformui64NV'));
     glProgramUniformui64vNV := SYSTEM.VAL(TglProgramUniformui64vNV, glXGetProcAddress('glProgramUniformui64vNV'));
END Read_GL_NV_shader_buffer_load;

PROCEDURE Read_GL_NV_vertex_buffer_unified_memory;
BEGIN
     glBufferAddressRangeNV := SYSTEM.VAL(TglBufferAddressRangeNV, glXGetProcAddress('glBufferAddressRangeNV'));
     glVertexFormatNV := SYSTEM.VAL(TglVertexFormatNV, glXGetProcAddress('glVertexFormatNV'));
     glNormalFormatNV := SYSTEM.VAL(TglNormalFormatNV, glXGetProcAddress('glNormalFormatNV'));
     glColorFormatNV := SYSTEM.VAL(TglColorFormatNV, glXGetProcAddress('glColorFormatNV'));
     glIndexFormatNV := SYSTEM.VAL(TglIndexFormatNV, glXGetProcAddress('glIndexFormatNV'));
     glTexCoordFormatNV := SYSTEM.VAL(TglTexCoordFormatNV, glXGetProcAddress('glTexCoordFormatNV'));
     glEdgeFlagFormatNV := SYSTEM.VAL(TglEdgeFlagFormatNV, glXGetProcAddress('glEdgeFlagFormatNV'));
     glSecondaryColorFormatNV := SYSTEM.VAL(TglSecondaryColorFormatNV, glXGetProcAddress('glSecondaryColorFormatNV'));
     glFogCoordFormatNV := SYSTEM.VAL(TglFogCoordFormatNV, glXGetProcAddress('glFogCoordFormatNV'));
     glVertexAttribFormatNV := SYSTEM.VAL(TglVertexAttribFormatNV, glXGetProcAddress('glVertexAttribFormatNV'));
     glVertexAttribIFormatNV := SYSTEM.VAL(TglVertexAttribIFormatNV, glXGetProcAddress('glVertexAttribIFormatNV'));
     glGetIntegerui64i_vNV := SYSTEM.VAL(TglGetIntegerui64i_vNV, glXGetProcAddress('glGetIntegerui64i_vNV'));
END Read_GL_NV_vertex_buffer_unified_memory;

PROCEDURE Read_GL_NV_gpu_program5;
BEGIN
     glProgramSubroutineParametersuivNV := SYSTEM.VAL(TglProgramSubroutineParametersuivNV, glXGetProcAddress('glProgramSubroutineParametersuivNV'));
     glGetProgramSubroutineParameteruivNV := SYSTEM.VAL(TglGetProgramSubroutineParameteruivNV, glXGetProcAddress('glGetProgramSubroutineParameteruivNV'));
END Read_GL_NV_gpu_program5;

PROCEDURE Read_GL_NV_gpu_shader5;
BEGIN
     glUniform1i64NV := SYSTEM.VAL(TglUniform1i64NV, glXGetProcAddress('glUniform1i64NV'));
     glUniform2i64NV := SYSTEM.VAL(TglUniform2i64NV, glXGetProcAddress('glUniform2i64NV'));
     glUniform3i64NV := SYSTEM.VAL(TglUniform3i64NV, glXGetProcAddress('glUniform3i64NV'));
     glUniform4i64NV := SYSTEM.VAL(TglUniform4i64NV, glXGetProcAddress('glUniform4i64NV'));
     glUniform1i64vNV := SYSTEM.VAL(TglUniform1i64vNV, glXGetProcAddress('glUniform1i64vNV'));
     glUniform2i64vNV := SYSTEM.VAL(TglUniform2i64vNV, glXGetProcAddress('glUniform2i64vNV'));
     glUniform3i64vNV := SYSTEM.VAL(TglUniform3i64vNV, glXGetProcAddress('glUniform3i64vNV'));
     glUniform4i64vNV := SYSTEM.VAL(TglUniform4i64vNV, glXGetProcAddress('glUniform4i64vNV'));
     glUniform1ui64NV := SYSTEM.VAL(TglUniform1ui64NV, glXGetProcAddress('glUniform1ui64NV'));
     glUniform2ui64NV := SYSTEM.VAL(TglUniform2ui64NV, glXGetProcAddress('glUniform2ui64NV'));
     glUniform3ui64NV := SYSTEM.VAL(TglUniform3ui64NV, glXGetProcAddress('glUniform3ui64NV'));
     glUniform4ui64NV := SYSTEM.VAL(TglUniform4ui64NV, glXGetProcAddress('glUniform4ui64NV'));
     glUniform1ui64vNV := SYSTEM.VAL(TglUniform1ui64vNV, glXGetProcAddress('glUniform1ui64vNV'));
     glUniform2ui64vNV := SYSTEM.VAL(TglUniform2ui64vNV, glXGetProcAddress('glUniform2ui64vNV'));
     glUniform3ui64vNV := SYSTEM.VAL(TglUniform3ui64vNV, glXGetProcAddress('glUniform3ui64vNV'));
     glUniform4ui64vNV := SYSTEM.VAL(TglUniform4ui64vNV, glXGetProcAddress('glUniform4ui64vNV'));
     glGetUniformi64vNV := SYSTEM.VAL(TglGetUniformi64vNV, glXGetProcAddress('glGetUniformi64vNV'));
     glProgramUniform1i64NV := SYSTEM.VAL(TglProgramUniform1i64NV, glXGetProcAddress('glProgramUniform1i64NV'));
     glProgramUniform2i64NV := SYSTEM.VAL(TglProgramUniform2i64NV, glXGetProcAddress('glProgramUniform2i64NV'));
     glProgramUniform3i64NV := SYSTEM.VAL(TglProgramUniform3i64NV, glXGetProcAddress('glProgramUniform3i64NV'));
     glProgramUniform4i64NV := SYSTEM.VAL(TglProgramUniform4i64NV, glXGetProcAddress('glProgramUniform4i64NV'));
     glProgramUniform1i64vNV := SYSTEM.VAL(TglProgramUniform1i64vNV, glXGetProcAddress('glProgramUniform1i64vNV'));
     glProgramUniform2i64vNV := SYSTEM.VAL(TglProgramUniform2i64vNV, glXGetProcAddress('glProgramUniform2i64vNV'));
     glProgramUniform3i64vNV := SYSTEM.VAL(TglProgramUniform3i64vNV, glXGetProcAddress('glProgramUniform3i64vNV'));
     glProgramUniform4i64vNV := SYSTEM.VAL(TglProgramUniform4i64vNV, glXGetProcAddress('glProgramUniform4i64vNV'));
     glProgramUniform1ui64NV := SYSTEM.VAL(TglProgramUniform1ui64NV, glXGetProcAddress('glProgramUniform1ui64NV'));
     glProgramUniform2ui64NV := SYSTEM.VAL(TglProgramUniform2ui64NV, glXGetProcAddress('glProgramUniform2ui64NV'));
     glProgramUniform3ui64NV := SYSTEM.VAL(TglProgramUniform3ui64NV, glXGetProcAddress('glProgramUniform3ui64NV'));
     glProgramUniform4ui64NV := SYSTEM.VAL(TglProgramUniform4ui64NV, glXGetProcAddress('glProgramUniform4ui64NV'));
     glProgramUniform1ui64vNV := SYSTEM.VAL(TglProgramUniform1ui64vNV, glXGetProcAddress('glProgramUniform1ui64vNV'));
     glProgramUniform2ui64vNV := SYSTEM.VAL(TglProgramUniform2ui64vNV, glXGetProcAddress('glProgramUniform2ui64vNV'));
     glProgramUniform3ui64vNV := SYSTEM.VAL(TglProgramUniform3ui64vNV, glXGetProcAddress('glProgramUniform3ui64vNV'));
     glProgramUniform4ui64vNV := SYSTEM.VAL(TglProgramUniform4ui64vNV, glXGetProcAddress('glProgramUniform4ui64vNV'));
END Read_GL_NV_gpu_shader5;

PROCEDURE Read_GL_NV_vertex_attrib_integer_64bit;
BEGIN
     glVertexAttribL1i64NV := SYSTEM.VAL(TglVertexAttribL1i64NV, glXGetProcAddress('glVertexAttribL1i64NV'));
     glVertexAttribL2i64NV := SYSTEM.VAL(TglVertexAttribL2i64NV, glXGetProcAddress('glVertexAttribL2i64NV'));
     glVertexAttribL3i64NV := SYSTEM.VAL(TglVertexAttribL3i64NV, glXGetProcAddress('glVertexAttribL3i64NV'));
     glVertexAttribL4i64NV := SYSTEM.VAL(TglVertexAttribL4i64NV, glXGetProcAddress('glVertexAttribL4i64NV'));
     glVertexAttribL1i64vNV := SYSTEM.VAL(TglVertexAttribL1i64vNV, glXGetProcAddress('glVertexAttribL1i64vNV'));
     glVertexAttribL2i64vNV := SYSTEM.VAL(TglVertexAttribL2i64vNV, glXGetProcAddress('glVertexAttribL2i64vNV'));
     glVertexAttribL3i64vNV := SYSTEM.VAL(TglVertexAttribL3i64vNV, glXGetProcAddress('glVertexAttribL3i64vNV'));
     glVertexAttribL4i64vNV := SYSTEM.VAL(TglVertexAttribL4i64vNV, glXGetProcAddress('glVertexAttribL4i64vNV'));
     glVertexAttribL1ui64NV := SYSTEM.VAL(TglVertexAttribL1ui64NV, glXGetProcAddress('glVertexAttribL1ui64NV'));
     glVertexAttribL2ui64NV := SYSTEM.VAL(TglVertexAttribL2ui64NV, glXGetProcAddress('glVertexAttribL2ui64NV'));
     glVertexAttribL3ui64NV := SYSTEM.VAL(TglVertexAttribL3ui64NV, glXGetProcAddress('glVertexAttribL3ui64NV'));
     glVertexAttribL4ui64NV := SYSTEM.VAL(TglVertexAttribL4ui64NV, glXGetProcAddress('glVertexAttribL4ui64NV'));
     glVertexAttribL1ui64vNV := SYSTEM.VAL(TglVertexAttribL1ui64vNV, glXGetProcAddress('glVertexAttribL1ui64vNV'));
     glVertexAttribL2ui64vNV := SYSTEM.VAL(TglVertexAttribL2ui64vNV, glXGetProcAddress('glVertexAttribL2ui64vNV'));
     glVertexAttribL3ui64vNV := SYSTEM.VAL(TglVertexAttribL3ui64vNV, glXGetProcAddress('glVertexAttribL3ui64vNV'));
     glVertexAttribL4ui64vNV := SYSTEM.VAL(TglVertexAttribL4ui64vNV, glXGetProcAddress('glVertexAttribL4ui64vNV'));
     glGetVertexAttribLi64vNV := SYSTEM.VAL(TglGetVertexAttribLi64vNV, glXGetProcAddress('glGetVertexAttribLi64vNV'));
     glGetVertexAttribLui64vNV := SYSTEM.VAL(TglGetVertexAttribLui64vNV, glXGetProcAddress('glGetVertexAttribLui64vNV'));
     glVertexAttribLFormatNV := SYSTEM.VAL(TglVertexAttribLFormatNV, glXGetProcAddress('glVertexAttribLFormatNV'));
END Read_GL_NV_vertex_attrib_integer_64bit;

PROCEDURE Read_GL_NV_vdpau_interop;
BEGIN
     glVDPAUInitNV := SYSTEM.VAL(TglVDPAUInitNV, glXGetProcAddress('glVDPAUInitNV'));
     glVDPAUFiniNV := SYSTEM.VAL(TglVDPAUFiniNV, glXGetProcAddress('glVDPAUFiniNV'));
     glVDPAURegisterVideoSurfaceNV := SYSTEM.VAL(TglVDPAURegisterVideoSurfaceNV, glXGetProcAddress('glVDPAURegisterVideoSurfaceNV'));
     glVDPAURegisterOutputSurfaceNV := SYSTEM.VAL(TglVDPAURegisterOutputSurfaceNV, glXGetProcAddress('glVDPAURegisterOutputSurfaceNV'));
     glVDPAUIsSurfaceNV := SYSTEM.VAL(TglVDPAUIsSurfaceNV, glXGetProcAddress('glVDPAUIsSurfaceNV'));
     glVDPAUUnregisterSurfaceNV := SYSTEM.VAL(TglVDPAUUnregisterSurfaceNV, glXGetProcAddress('glVDPAUUnregisterSurfaceNV'));
     glVDPAUGetSurfaceivNV := SYSTEM.VAL(TglVDPAUGetSurfaceivNV, glXGetProcAddress('glVDPAUGetSurfaceivNV'));
     glVDPAUSurfaceAccessNV := SYSTEM.VAL(TglVDPAUSurfaceAccessNV, glXGetProcAddress('glVDPAUSurfaceAccessNV'));
     glVDPAUMapSurfacesNV := SYSTEM.VAL(TglVDPAUMapSurfacesNV, glXGetProcAddress('glVDPAUMapSurfacesNV'));
     glVDPAUUnmapSurfacesNV := SYSTEM.VAL(TglVDPAUUnmapSurfacesNV, glXGetProcAddress('glVDPAUUnmapSurfacesNV'));
END Read_GL_NV_vdpau_interop;

PROCEDURE Read_GL_NV_texture_barrier;
BEGIN
     glTextureBarrierNV := SYSTEM.VAL(TglTextureBarrierNV, glXGetProcAddress('glTextureBarrierNV'));
END Read_GL_NV_texture_barrier;

PROCEDURE Read_GL_PGI_misc_hints;
BEGIN
(*     glHintPGI := SYSTEM.VAL(TglHintPGI, glXGetProcAddress('glHintPGI'));
*)
END Read_GL_PGI_misc_hints;

PROCEDURE Read_GL_SGIS_detail_texture;
BEGIN
(*     glDetailTexFuncSGIS := SYSTEM.VAL(TglDetailTexFuncSGIS, glXGetProcAddress('glDetailTexFuncSGIS'));
     glGetDetailTexFuncSGIS := SYSTEM.VAL(TglGetDetailTexFuncSGIS, glXGetProcAddress('glGetDetailTexFuncSGIS'));
*)
END Read_GL_SGIS_detail_texture;

PROCEDURE Read_GL_SGIS_fog_function;
BEGIN
(*     glFogFuncSGIS := SYSTEM.VAL(TglFogFuncSGIS, glXGetProcAddress('glFogFuncSGIS'));
     glGetFogFuncSGIS := SYSTEM.VAL(TglGetFogFuncSGIS, glXGetProcAddress('glGetFogFuncSGIS'));
*)
END Read_GL_SGIS_fog_function;

PROCEDURE Read_GL_SGIS_multisample;
BEGIN
(*     glSampleMaskSGIS := SYSTEM.VAL(TglSampleMaskSGIS, glXGetProcAddress('glSampleMaskSGIS'));
     glSamplePatternSGIS := SYSTEM.VAL(TglSamplePatternSGIS, glXGetProcAddress('glSamplePatternSGIS'));
*)
END Read_GL_SGIS_multisample;

PROCEDURE Read_GL_SGIS_pixel_texture;
BEGIN
(*     glPixelTexGenParameteriSGIS := SYSTEM.VAL(TglPixelTexGenParameteriSGIS, glXGetProcAddress('glPixelTexGenParameteriSGIS'));
     glPixelTexGenParameterivSGIS := SYSTEM.VAL(TglPixelTexGenParameterivSGIS, glXGetProcAddress('glPixelTexGenParameterivSGIS'));
     glPixelTexGenParameterfSGIS := SYSTEM.VAL(TglPixelTexGenParameterfSGIS, glXGetProcAddress('glPixelTexGenParameterfSGIS'));
     glPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglPixelTexGenParameterfvSGIS, glXGetProcAddress('glPixelTexGenParameterfvSGIS'));
     glGetPixelTexGenParameterivSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterivSGIS, glXGetProcAddress('glGetPixelTexGenParameterivSGIS'));
     glGetPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterfvSGIS, glXGetProcAddress('glGetPixelTexGenParameterfvSGIS'));
*)
END Read_GL_SGIS_pixel_texture;

PROCEDURE Read_GL_SGIS_point_parameters;
BEGIN
(*     glPointParameterfSGIS := SYSTEM.VAL(TglPointParameterfSGIS, glXGetProcAddress('glPointParameterfSGIS'));
     glPointParameterfvSGIS := SYSTEM.VAL(TglPointParameterfvSGIS, glXGetProcAddress('glPointParameterfvSGIS'));
*)
END Read_GL_SGIS_point_parameters;

PROCEDURE Read_GL_SGIS_sharpen_texture;
BEGIN
(*     glSharpenTexFuncSGIS := SYSTEM.VAL(TglSharpenTexFuncSGIS, glXGetProcAddress('glSharpenTexFuncSGIS'));
     glGetSharpenTexFuncSGIS := SYSTEM.VAL(TglGetSharpenTexFuncSGIS, glXGetProcAddress('glGetSharpenTexFuncSGIS'));
*)
END Read_GL_SGIS_sharpen_texture;

PROCEDURE Read_GL_SGIS_texture4D;
BEGIN
(*     glTexImage4DSGIS := SYSTEM.VAL(TglTexImage4DSGIS, glXGetProcAddress('glTexImage4DSGIS'));
     glTexSubImage4DSGIS := SYSTEM.VAL(TglTexSubImage4DSGIS, glXGetProcAddress('glTexSubImage4DSGIS'));
*)
END Read_GL_SGIS_texture4D;

PROCEDURE Read_GL_SGIS_texture_color_mask;
BEGIN
(*     glTextureColorMaskSGIS := SYSTEM.VAL(TglTextureColorMaskSGIS, glXGetProcAddress('glTextureColorMaskSGIS'));
*)
END Read_GL_SGIS_texture_color_mask;

PROCEDURE Read_GL_SGIS_texture_filter4;
BEGIN
(*     glGetTexFilterFuncSGIS := SYSTEM.VAL(TglGetTexFilterFuncSGIS, glXGetProcAddress('glGetTexFilterFuncSGIS'));
     glTexFilterFuncSGIS := SYSTEM.VAL(TglTexFilterFuncSGIS, glXGetProcAddress('glTexFilterFuncSGIS'));
*)
END Read_GL_SGIS_texture_filter4;

PROCEDURE Read_GL_SGIX_async;
BEGIN
(*     glAsyncMarkerSGIX := SYSTEM.VAL(TglAsyncMarkerSGIX, glXGetProcAddress('glAsyncMarkerSGIX'));
     glFinishAsyncSGIX := SYSTEM.VAL(TglFinishAsyncSGIX, glXGetProcAddress('glFinishAsyncSGIX'));
     glPollAsyncSGIX := SYSTEM.VAL(TglPollAsyncSGIX, glXGetProcAddress('glPollAsyncSGIX'));
     glGenAsyncMarkersSGIX := SYSTEM.VAL(TglGenAsyncMarkersSGIX, glXGetProcAddress('glGenAsyncMarkersSGIX'));
     glDeleteAsyncMarkersSGIX := SYSTEM.VAL(TglDeleteAsyncMarkersSGIX, glXGetProcAddress('glDeleteAsyncMarkersSGIX'));
     glIsAsyncMarkerSGIX := SYSTEM.VAL(TglIsAsyncMarkerSGIX, glXGetProcAddress('glIsAsyncMarkerSGIX'));
*)
END Read_GL_SGIX_async;

PROCEDURE Read_GL_SGIX_flush_raster;
BEGIN
(*     glFlushRasterSGIX := SYSTEM.VAL(TglFlushRasterSGIX, glXGetProcAddress('glFlushRasterSGIX'));
*)
END Read_GL_SGIX_flush_raster;

PROCEDURE Read_GL_SGIX_fragment_lighting;
BEGIN
(*     glFragmentColorMaterialSGIX := SYSTEM.VAL(TglFragmentColorMaterialSGIX, glXGetProcAddress('glFragmentColorMaterialSGIX'));
     glFragmentLightfSGIX := SYSTEM.VAL(TglFragmentLightfSGIX, glXGetProcAddress('glFragmentLightfSGIX'));
     glFragmentLightfvSGIX := SYSTEM.VAL(TglFragmentLightfvSGIX, glXGetProcAddress('glFragmentLightfvSGIX'));
     glFragmentLightiSGIX := SYSTEM.VAL(TglFragmentLightiSGIX, glXGetProcAddress('glFragmentLightiSGIX'));
     glFragmentLightivSGIX := SYSTEM.VAL(TglFragmentLightivSGIX, glXGetProcAddress('glFragmentLightivSGIX'));
     glFragmentLightModelfSGIX := SYSTEM.VAL(TglFragmentLightModelfSGIX, glXGetProcAddress('glFragmentLightModelfSGIX'));
     glFragmentLightModelfvSGIX := SYSTEM.VAL(TglFragmentLightModelfvSGIX, glXGetProcAddress('glFragmentLightModelfvSGIX'));
     glFragmentLightModeliSGIX := SYSTEM.VAL(TglFragmentLightModeliSGIX, glXGetProcAddress('glFragmentLightModeliSGIX'));
     glFragmentLightModelivSGIX := SYSTEM.VAL(TglFragmentLightModelivSGIX, glXGetProcAddress('glFragmentLightModelivSGIX'));
     glFragmentMaterialfSGIX := SYSTEM.VAL(TglFragmentMaterialfSGIX, glXGetProcAddress('glFragmentMaterialfSGIX'));
     glFragmentMaterialfvSGIX := SYSTEM.VAL(TglFragmentMaterialfvSGIX, glXGetProcAddress('glFragmentMaterialfvSGIX'));
     glFragmentMaterialiSGIX := SYSTEM.VAL(TglFragmentMaterialiSGIX, glXGetProcAddress('glFragmentMaterialiSGIX'));
     glFragmentMaterialivSGIX := SYSTEM.VAL(TglFragmentMaterialivSGIX, glXGetProcAddress('glFragmentMaterialivSGIX'));
     glGetFragmentLightfvSGIX := SYSTEM.VAL(TglGetFragmentLightfvSGIX, glXGetProcAddress('glGetFragmentLightfvSGIX'));
     glGetFragmentLightivSGIX := SYSTEM.VAL(TglGetFragmentLightivSGIX, glXGetProcAddress('glGetFragmentLightivSGIX'));
     glGetFragmentMaterialfvSGIX := SYSTEM.VAL(TglGetFragmentMaterialfvSGIX, glXGetProcAddress('glGetFragmentMaterialfvSGIX'));
     glGetFragmentMaterialivSGIX := SYSTEM.VAL(TglGetFragmentMaterialivSGIX, glXGetProcAddress('glGetFragmentMaterialivSGIX'));
     glLightEnviSGIX := SYSTEM.VAL(TglLightEnviSGIX, glXGetProcAddress('glLightEnviSGIX'));
*)
END Read_GL_SGIX_fragment_lighting;

PROCEDURE Read_GL_SGIX_framezoom;
BEGIN
(*     glFrameZoomSGIX := SYSTEM.VAL(TglFrameZoomSGIX, glXGetProcAddress('glFrameZoomSGIX'));
*)
END Read_GL_SGIX_framezoom;

PROCEDURE Read_GL_SGIX_igloo_interface;
BEGIN
(*     glIglooInterfaceSGIX := SYSTEM.VAL(TglIglooInterfaceSGIX, glXGetProcAddress('glIglooInterfaceSGIX'));
*)
END Read_GL_SGIX_igloo_interface;

PROCEDURE Read_GL_SGIX_instruments;
BEGIN
(*     glGetInstrumentsSGIX := SYSTEM.VAL(TglGetInstrumentsSGIX, glXGetProcAddress('glGetInstrumentsSGIX'));
     glInstrumentsBufferSGIX := SYSTEM.VAL(TglInstrumentsBufferSGIX, glXGetProcAddress('glInstrumentsBufferSGIX'));
     glPollInstrumentsSGIX := SYSTEM.VAL(TglPollInstrumentsSGIX, glXGetProcAddress('glPollInstrumentsSGIX'));
     glReadInstrumentsSGIX := SYSTEM.VAL(TglReadInstrumentsSGIX, glXGetProcAddress('glReadInstrumentsSGIX'));
     glStartInstrumentsSGIX := SYSTEM.VAL(TglStartInstrumentsSGIX, glXGetProcAddress('glStartInstrumentsSGIX'));
     glStopInstrumentsSGIX := SYSTEM.VAL(TglStopInstrumentsSGIX, glXGetProcAddress('glStopInstrumentsSGIX'));
*)
END Read_GL_SGIX_instruments;

PROCEDURE Read_GL_SGIX_list_priority;
BEGIN
(*     glGetListParameterfvSGIX := SYSTEM.VAL(TglGetListParameterfvSGIX, glXGetProcAddress('glGetListParameterfvSGIX'));
     glGetListParameterivSGIX := SYSTEM.VAL(TglGetListParameterivSGIX, glXGetProcAddress('glGetListParameterivSGIX'));
     glListParameterfSGIX := SYSTEM.VAL(TglListParameterfSGIX, glXGetProcAddress('glListParameterfSGIX'));
     glListParameterfvSGIX := SYSTEM.VAL(TglListParameterfvSGIX, glXGetProcAddress('glListParameterfvSGIX'));
     glListParameteriSGIX := SYSTEM.VAL(TglListParameteriSGIX, glXGetProcAddress('glListParameteriSGIX'));
     glListParameterivSGIX := SYSTEM.VAL(TglListParameterivSGIX, glXGetProcAddress('glListParameterivSGIX'));
*)
END Read_GL_SGIX_list_priority;

PROCEDURE Read_GL_SGIX_pixel_texture;
BEGIN
(*     glPixelTexGenSGIX := SYSTEM.VAL(TglPixelTexGenSGIX, glXGetProcAddress('glPixelTexGenSGIX'));
*)
END Read_GL_SGIX_pixel_texture;

PROCEDURE Read_GL_SGIX_polynomial_ffd;
BEGIN
(*     glDeformationMap3dSGIX := SYSTEM.VAL(TglDeformationMap3dSGIX, glXGetProcAddress('glDeformationMap3dSGIX'));
     glDeformationMap3fSGIX := SYSTEM.VAL(TglDeformationMap3fSGIX, glXGetProcAddress('glDeformationMap3fSGIX'));
     glDeformSGIX := SYSTEM.VAL(TglDeformSGIX, glXGetProcAddress('glDeformSGIX'));
     glLoadIdentityDeformationMapSGIX := SYSTEM.VAL(TglLoadIdentityDeformationMapSGIX, glXGetProcAddress('glLoadIdentityDeformationMapSGIX'));
*)
END Read_GL_SGIX_polynomial_ffd;

PROCEDURE Read_GL_SGIX_reference_plane;
BEGIN
(*     glReferencePlaneSGIX := SYSTEM.VAL(TglReferencePlaneSGIX, glXGetProcAddress('glReferencePlaneSGIX'));
*)
END Read_GL_SGIX_reference_plane;

PROCEDURE Read_GL_SGIX_sprite;
BEGIN
(*     glSpriteParameterfSGIX := SYSTEM.VAL(TglSpriteParameterfSGIX, glXGetProcAddress('glSpriteParameterfSGIX'));
     glSpriteParameterfvSGIX := SYSTEM.VAL(TglSpriteParameterfvSGIX, glXGetProcAddress('glSpriteParameterfvSGIX'));
     glSpriteParameteriSGIX := SYSTEM.VAL(TglSpriteParameteriSGIX, glXGetProcAddress('glSpriteParameteriSGIX'));
     glSpriteParameterivSGIX := SYSTEM.VAL(TglSpriteParameterivSGIX, glXGetProcAddress('glSpriteParameterivSGIX'));
*)
END Read_GL_SGIX_sprite;

PROCEDURE Read_GL_SGIX_tag_sample_buffer;
BEGIN
(*     glTagSampleBufferSGIX := SYSTEM.VAL(TglTagSampleBufferSGIX, glXGetProcAddress('glTagSampleBufferSGIX'));
*)
END Read_GL_SGIX_tag_sample_buffer;

PROCEDURE Read_GL_SGI_color_table;
BEGIN
(*     glColorTableSGI := SYSTEM.VAL(TglColorTableSGI, glXGetProcAddress('glColorTableSGI'));
     glColorTableParameterfvSGI := SYSTEM.VAL(TglColorTableParameterfvSGI, glXGetProcAddress('glColorTableParameterfvSGI'));
     glColorTableParameterivSGI := SYSTEM.VAL(TglColorTableParameterivSGI, glXGetProcAddress('glColorTableParameterivSGI'));
     glCopyColorTableSGI := SYSTEM.VAL(TglCopyColorTableSGI, glXGetProcAddress('glCopyColorTableSGI'));
     glGetColorTableSGI := SYSTEM.VAL(TglGetColorTableSGI, glXGetProcAddress('glGetColorTableSGI'));
     glGetColorTableParameterfvSGI := SYSTEM.VAL(TglGetColorTableParameterfvSGI, glXGetProcAddress('glGetColorTableParameterfvSGI'));
     glGetColorTableParameterivSGI := SYSTEM.VAL(TglGetColorTableParameterivSGI, glXGetProcAddress('glGetColorTableParameterivSGI'));
*)
END Read_GL_SGI_color_table;

PROCEDURE Read_GL_SUNX_constant_data;
BEGIN
(*     glFinishTextureSUNX := SYSTEM.VAL(TglFinishTextureSUNX, glXGetProcAddress('glFinishTextureSUNX'));
*)
END Read_GL_SUNX_constant_data;

PROCEDURE Read_GL_SUN_global_alpha;
BEGIN
(*     glGlobalAlphaFactorbSUN := SYSTEM.VAL(TglGlobalAlphaFactorbSUN, glXGetProcAddress('glGlobalAlphaFactorbSUN'));
     glGlobalAlphaFactorsSUN := SYSTEM.VAL(TglGlobalAlphaFactorsSUN, glXGetProcAddress('glGlobalAlphaFactorsSUN'));
     glGlobalAlphaFactoriSUN := SYSTEM.VAL(TglGlobalAlphaFactoriSUN, glXGetProcAddress('glGlobalAlphaFactoriSUN'));
     glGlobalAlphaFactorfSUN := SYSTEM.VAL(TglGlobalAlphaFactorfSUN, glXGetProcAddress('glGlobalAlphaFactorfSUN'));
     glGlobalAlphaFactordSUN := SYSTEM.VAL(TglGlobalAlphaFactordSUN, glXGetProcAddress('glGlobalAlphaFactordSUN'));
     glGlobalAlphaFactorubSUN := SYSTEM.VAL(TglGlobalAlphaFactorubSUN, glXGetProcAddress('glGlobalAlphaFactorubSUN'));
     glGlobalAlphaFactorusSUN := SYSTEM.VAL(TglGlobalAlphaFactorusSUN, glXGetProcAddress('glGlobalAlphaFactorusSUN'));
     glGlobalAlphaFactoruiSUN := SYSTEM.VAL(TglGlobalAlphaFactoruiSUN, glXGetProcAddress('glGlobalAlphaFactoruiSUN'));
*)
END Read_GL_SUN_global_alpha;

PROCEDURE Read_GL_SUN_mesh_array;
BEGIN
(*     glDrawMeshArraysSUN := SYSTEM.VAL(TglDrawMeshArraysSUN, glXGetProcAddress('glDrawMeshArraysSUN'));
*)
END Read_GL_SUN_mesh_array;

PROCEDURE Read_GL_SUN_triangle_list;
BEGIN
(*     glReplacementCodeuiSUN := SYSTEM.VAL(TglReplacementCodeuiSUN, glXGetProcAddress('glReplacementCodeuiSUN'));
     glReplacementCodeusSUN := SYSTEM.VAL(TglReplacementCodeusSUN, glXGetProcAddress('glReplacementCodeusSUN'));
     glReplacementCodeubSUN := SYSTEM.VAL(TglReplacementCodeubSUN, glXGetProcAddress('glReplacementCodeubSUN'));
     glReplacementCodeuivSUN := SYSTEM.VAL(TglReplacementCodeuivSUN, glXGetProcAddress('glReplacementCodeuivSUN'));
     glReplacementCodeusvSUN := SYSTEM.VAL(TglReplacementCodeusvSUN, glXGetProcAddress('glReplacementCodeusvSUN'));
     glReplacementCodeubvSUN := SYSTEM.VAL(TglReplacementCodeubvSUN, glXGetProcAddress('glReplacementCodeubvSUN'));
     glReplacementCodePointerSUN := SYSTEM.VAL(TglReplacementCodePointerSUN, glXGetProcAddress('glReplacementCodePointerSUN'));
*)
END Read_GL_SUN_triangle_list;

PROCEDURE Read_GL_SUN_vertex;
BEGIN
(*     glColor4ubVertex2fSUN := SYSTEM.VAL(TglColor4ubVertex2fSUN, glXGetProcAddress('glColor4ubVertex2fSUN'));
     glColor4ubVertex2fvSUN := SYSTEM.VAL(TglColor4ubVertex2fvSUN, glXGetProcAddress('glColor4ubVertex2fvSUN'));
     glColor4ubVertex3fSUN := SYSTEM.VAL(TglColor4ubVertex3fSUN, glXGetProcAddress('glColor4ubVertex3fSUN'));
     glColor4ubVertex3fvSUN := SYSTEM.VAL(TglColor4ubVertex3fvSUN, glXGetProcAddress('glColor4ubVertex3fvSUN'));
     glColor3fVertex3fSUN := SYSTEM.VAL(TglColor3fVertex3fSUN, glXGetProcAddress('glColor3fVertex3fSUN'));
     glColor3fVertex3fvSUN := SYSTEM.VAL(TglColor3fVertex3fvSUN, glXGetProcAddress('glColor3fVertex3fvSUN'));
     glNormal3fVertex3fSUN := SYSTEM.VAL(TglNormal3fVertex3fSUN, glXGetProcAddress('glNormal3fVertex3fSUN'));
     glNormal3fVertex3fvSUN := SYSTEM.VAL(TglNormal3fVertex3fvSUN, glXGetProcAddress('glNormal3fVertex3fvSUN'));
     glColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fSUN, glXGetProcAddress('glColor4fNormal3fVertex3fSUN'));
     glColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fvSUN, glXGetProcAddress('glColor4fNormal3fVertex3fvSUN'));
     glTexCoord2fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fVertex3fSUN, glXGetProcAddress('glTexCoord2fVertex3fSUN'));
     glTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fVertex3fvSUN, glXGetProcAddress('glTexCoord2fVertex3fvSUN'));
     glTexCoord4fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fVertex4fSUN, glXGetProcAddress('glTexCoord4fVertex4fSUN'));
     glTexCoord4fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fVertex4fvSUN, glXGetProcAddress('glTexCoord4fVertex4fvSUN'));
     glTexCoord2fColor4ubVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fSUN, glXGetProcAddress('glTexCoord2fColor4ubVertex3fSUN'));
     glTexCoord2fColor4ubVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fvSUN, glXGetProcAddress('glTexCoord2fColor4ubVertex3fvSUN'));
     glTexCoord2fColor3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fSUN, glXGetProcAddress('glTexCoord2fColor3fVertex3fSUN'));
     glTexCoord2fColor3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fvSUN, glXGetProcAddress('glTexCoord2fColor3fVertex3fvSUN'));
     glTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fSUN, glXGetProcAddress('glTexCoord2fNormal3fVertex3fSUN'));
     glTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fvSUN, glXGetProcAddress('glTexCoord2fNormal3fVertex3fvSUN'));
     glTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fSUN, glXGetProcAddress('glTexCoord2fColor4fNormal3fVertex3fSUN'));
     glTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fvSUN, glXGetProcAddress('glTexCoord2fColor4fNormal3fVertex3fvSUN'));
     glTexCoord4fColor4fNormal3fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fSUN, glXGetProcAddress('glTexCoord4fColor4fNormal3fVertex4fSUN'));
     glTexCoord4fColor4fNormal3fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fvSUN, glXGetProcAddress('glTexCoord4fColor4fNormal3fVertex4fvSUN'));
     glReplacementCodeuiVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fSUN, glXGetProcAddress('glReplacementCodeuiVertex3fSUN'));
     glReplacementCodeuiVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiVertex3fvSUN'));
     glReplacementCodeuiColor4ubVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fSUN, glXGetProcAddress('glReplacementCodeuiColor4ubVertex3fSUN'));
     glReplacementCodeuiColor4ubVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiColor4ubVertex3fvSUN'));
     glReplacementCodeuiColor3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiColor3fVertex3fSUN'));
     glReplacementCodeuiColor3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiColor3fVertex3fvSUN'));
     glReplacementCodeuiNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiNormal3fVertex3fSUN'));
     glReplacementCodeuiNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiNormal3fVertex3fvSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN, glXGetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN'));
*)
END Read_GL_SUN_vertex;


(***********************)

PROCEDURE ReadExtensions*;
BEGIN
    
	ReadOpenGLCore;
	   Trace.String(" ReadExtensions ");
 Read_GL_3DFX_tbuffer;
  Read_GL_APPLE_element_array;
  Read_GL_APPLE_fence;
  Read_GL_APPLE_vertex_array_object;
  Read_GL_APPLE_vertex_array_range;
  Read_GL_APPLE_texture_range;
  Read_GL_APPLE_vertex_program_evaluators;
  Read_GL_APPLE_object_purgeable;
  Read_GL_ARB_matrix_palette;
  Read_GL_ARB_multitexture;
  Read_GL_ARB_point_parameters;
  Read_GL_ARB_texture_compression;
  Read_GL_ARB_transpose_matrix;
  Read_GL_ARB_vertex_blend;
  Read_GL_ARB_vertex_buffer_object;
  Read_GL_ARB_vertex_program;
  Read_GL_ARB_window_pos;
  Read_GL_ARB_color_buffer_float;
  Read_GL_ARB_Shader_Objects;
  Read_GL_ARB_occlusion_query;
  Read_GL_ARB_draw_instanced;
  Read_GL_ARB_framebuffer_object;
  Read_GL_ARB_geometry_shader4;
  Read_GL_ARB_instanced_arrays;
  Read_GL_ARB_map_buffer_range;
  Read_GL_ARB_texture_buffer_object;
  Read_GL_ARB_vertex_array_object;
  Read_GL_ARB_uniform_buffer_object;
  Read_GL_ARB_copy_buffer;
  Read_GL_ARB_draw_elements_base_vertex;
  Read_GL_ARB_provoking_vertex;
  Read_GL_ARB_sync;
  Read_GL_ARB_texture_multisample;
  Read_GL_ARB_draw_buffers_blend;
  Read_GL_ARB_sample_shading;
  Read_GL_ARB_shading_language_include;
  Read_GL_ARB_blend_func_extended;
  Read_GL_ARB_sampler_objects;
  Read_GL_ARB_timer_query;
  Read_GL_ARB_vertex_type_2_10_10_10_rev;
  Read_GL_ARB_draw_indirect;
  Read_GL_ARB_gpu_shader_fp64;
  Read_GL_ARB_shader_subroutine;
  Read_GL_ARB_tessellation_shader;
  Read_GL_ARB_transform_feedback2;
  Read_GL_ARB_transform_feedback3;
  Read_GL_ARB_ES2_compatibility;
  Read_GL_ARB_get_program_binary;
  Read_GL_ARB_separate_shader_objects;
  Read_GL_ARB_vertex_attrib_64bit;
  Read_GL_ARB_viewport_array;
  Read_GL_ARB_cl_event;
  Read_GL_ARB_debug_output;
  Read_GL_ARB_robustness;
  Read_GL_ATI_draw_buffers;
  Read_GL_ATI_element_array;
  Read_GL_ATI_envmap_bumpmap;
  Read_GL_ATI_fragment_shader;
  Read_GL_ATI_map_object_buffer;
  Read_GL_ATI_pn_triangles;
  Read_GL_ATI_separate_stencil;
  Read_GL_ATI_vertex_array_object;
  Read_GL_ATI_vertex_attrib_array_object;
  Read_GL_ATI_vertex_streams;
  Read_GL_AMD_performance_monitor;
  Read_GL_AMD_vertex_shader_tesselator;
  Read_GL_AMD_draw_buffers_blend;
  Read_GL_AMD_name_gen_delete;
  Read_GL_AMD_debug_output;
  Read_GL_EXT_blend_color;
  Read_GL_EXT_blend_func_separate;
  Read_GL_EXT_blend_minmax;
  Read_GL_EXT_color_subtable;
  Read_GL_EXT_compiled_vertex_array;
  Read_GL_EXT_convolution;
  Read_GL_EXT_coordinate_frame;
  Read_GL_EXT_copy_texture;
  Read_GL_EXT_cull_vertex;
  Read_GL_EXT_draw_range_elements;
  Read_GL_EXT_fog_coord;
  Read_GL_EXT_framebuffer_object;
  Read_GL_EXT_histogram;
  Read_GL_EXT_index_func;
  Read_GL_EXT_index_material;
  Read_GL_EXT_multi_draw_arrays;
  Read_GL_EXT_multisample;
  Read_GL_EXT_paletted_texture;
  Read_GL_EXT_pixel_transform;
  Read_GL_EXT_point_parameters;
  Read_GL_EXT_polygon_offset;
  Read_GL_EXT_secondary_color;
  Read_GL_EXT_stencil_two_side;
  Read_GL_EXT_subtexture;
  Read_GL_EXT_texture3D;
  Read_GL_EXT_texture_object;
  Read_GL_EXT_texture_perturb_normal;
  Read_GL_EXT_vertex_array;
  Read_GL_EXT_vertex_shader;
  Read_GL_EXT_vertex_weighting;
  Read_GL_EXT_depth_bounds_test;
  Read_GL_EXT_blend_equation_separate;
  Read_GL_EXT_stencil_clear_tag;
  Read_GL_EXT_framebuffer_blit;
  Read_GL_EXT_framebuffer_multisample;
  Read_GL_EXT_timer_query;
  Read_GL_EXT_gpu_program_parameters;
  Read_GL_EXT_bindable_uniform;
  Read_GL_EXT_draw_buffers2;
  Read_GL_EXT_draw_instanced;
  Read_GL_EXT_geometry_shader4;
  Read_GL_EXT_gpu_shader4;
  Read_GL_EXT_texture_array;
  Read_GL_EXT_texture_buffer_object;
  Read_GL_EXT_texture_integer;
  Read_GL_EXT_transform_feedback;
  Read_GL_EXT_direct_state_access;
  Read_GL_EXT_separate_shader_objects;
  Read_GL_EXT_shader_image_load_store;
  Read_GL_EXT_vertex_attrib_64bit;
  Read_GL_HP_image_transform;
  Read_GL_IBM_multimode_draw_arrays;
  Read_GL_IBM_vertex_array_lists;
  Read_GL_INGR_blend_func_separate;
  Read_GL_INTEL_parallel_arrays;
  Read_GL_MESA_resize_buffers;
  Read_GL_MESA_window_pos;
  Read_GL_NV_evaluators;
  Read_GL_NV_fence;
  Read_GL_NV_fragment_program;
  Read_GL_NV_half_float;
  Read_GL_NV_occlusion_query;
  Read_GL_NV_pixel_data_range;
  Read_GL_NV_point_sprite;
  Read_GL_NV_primitive_restart;
  Read_GL_NV_register_combiners;
  Read_GL_NV_register_combiners2;
  Read_GL_NV_vertex_array_range;
  Read_GL_NV_vertex_program;
  Read_GL_NV_depth_buffer_float;
  Read_GL_NV_framebuffer_multisample_coverage;
  Read_GL_NV_geometry_program4;
  Read_GL_NV_gpu_program4;
  Read_GL_NV_parameter_buffer_object;
  Read_GL_NV_transform_feedback;
  Read_GL_NV_conditional_render;
  Read_GL_NV_present_video;
  Read_GL_NV_explicit_multisample;
  Read_GL_NV_transform_feedback2;
  Read_GL_NV_video_capture;
  Read_GL_NV_copy_image;
  Read_GL_NV_shader_buffer_load;
  Read_GL_NV_vertex_buffer_unified_memory;
  Read_GL_NV_gpu_program5;
  Read_GL_NV_gpu_shader5;
  Read_GL_NV_vertex_attrib_integer_64bit;
  Read_GL_NV_vdpau_interop;
  Read_GL_NV_texture_barrier;
  Read_GL_PGI_misc_hints;
  Read_GL_SGIS_detail_texture;
  Read_GL_SGIS_fog_function;
  Read_GL_SGIS_multisample;
  Read_GL_SGIS_pixel_texture;
  Read_GL_SGIS_point_parameters;
  Read_GL_SGIS_sharpen_texture;
  Read_GL_SGIS_texture4D;
  Read_GL_SGIS_texture_color_mask;
  Read_GL_SGIS_texture_filter4;
  Read_GL_SGIX_async;
  Read_GL_SGIX_flush_raster;
  Read_GL_SGIX_fragment_lighting;
  Read_GL_SGIX_framezoom;
  Read_GL_SGIX_igloo_interface;
  Read_GL_SGIX_instruments;
  Read_GL_SGIX_list_priority;
  Read_GL_SGIX_pixel_texture;
  Read_GL_SGIX_polynomial_ffd;
  Read_GL_SGIX_reference_plane;
  Read_GL_SGIX_sprite;
  Read_GL_SGIX_tag_sample_buffer;
  Read_GL_SGI_color_table;
  Read_GL_SUNX_constant_data;
  Read_GL_SUN_global_alpha;
  Read_GL_SUN_mesh_array;
  Read_GL_SUN_triangle_list;
  Read_GL_SUN_vertex;

Trace.String(" Ok. ");  Trace.Ln; 
END ReadExtensions;



(* utilities *)
(* Get string from address *)
PROCEDURE GetStringFromAddr(adr: LONGINT): Strings.String;
VAR  sadr, sadr1: LONGINT;
		i, cnt: LONGINT;
		ch: CHAR;
		s: Strings.String;
BEGIN
	sadr := adr;
	
	(* find length *)
	cnt :=0;
	sadr1 := sadr;
	IF sadr1 # 0 THEN 
		SYSTEM.GET(sadr1,ch);
		WHILE (ch # 0X) DO  INC(cnt); INC(sadr1); SYSTEM.GET(sadr1,ch); END;
	END;
	
	IF cnt = 0 THEN  (* empty string *)	
		NEW(s,1); s[0]:=0X; 	RETURN s
	END; 

	NEW(s, cnt+1);
	i:=0;
	sadr1 := sadr;
	SYSTEM.GET(sadr1,ch);
	WHILE (i< cnt) & (ch # 0X) DO
		s^[i] := ch; INC(i); INC(sadr1);
		SYSTEM.GET(sadr1,ch);
	END;
	RETURN s;	
	
END GetStringFromAddr;

PROCEDURE GLGetString*(name: GLenum): Strings.String;
VAR  sadr: LONGINT;
BEGIN 
	sadr := glGetString(name);
	RETURN GetStringFromAddr(sadr);	
END GLGetString;

PROCEDURE GLUGetString*(name: GLenum): Strings.String;
VAR  sadr: LONGINT;
BEGIN 
  	sadr := gluGetString(name); 
	RETURN GetStringFromAddr(sadr);	
END GLUGetString;


PROCEDURE ReadCoreVersion;
VAR
  Buffer: Strings.String;
  MajorVersion, MinorVersion: LONGINT;

	PROCEDURE isNumber(ch: CHAR): BOOLEAN;
	VAR 
	      val: LONGINT;
	      res: BOOLEAN;
	BEGIN
		res := FALSE;
		val := ORD(ch);
		IF (val >= ORD("0")) & (val<=ORD("9")) THEN res := TRUE; END;
		RETURN res;
	END isNumber;
  

	PROCEDURE TrimAndSplitVersionString(CONST buffer: ARRAY OF CHAR; VAR Max, Min: LONGINT);
	 VAR
	    separator,i : LONGINT;
	BEGIN
	i := 0;
	separator := Strings.Pos('.', buffer);
	(* At least one number must be before and one after the dot. *)
	IF (separator > 0) & (separator < Strings.Length(buffer)) & ((isNumber(buffer[separator - 1])) &
	      isNumber(buffer[separator + 1])) THEN
	      Max := ORD(buffer[separator + 1]);
	      Min := ORD(buffer[separator - 1]);
	ELSE
	      Max := 0;
	      Min := 0;
	END;      
	END TrimAndSplitVersionString;

BEGIN
  (* determine version of implementation
   GL *)
  IF glGetString = NIL THEN
    Unix.Dlsym(GL_LibHandle, "glGetString", SYSTEM.VAL(ADDRESS,glGetString));
  END; 
   Buffer := GLGetString(GLC.GL_VERSION );
  TrimAndSplitVersionString(Buffer^, MajorVersion, MinorVersion);

  GL_VERSION_1_0 := TRUE;
  GL_VERSION_1_1 := FALSE;
  GL_VERSION_1_2 := FALSE;
  GL_VERSION_1_3 := FALSE;
  GL_VERSION_1_4 := FALSE;
  GL_VERSION_1_5 := FALSE;
  GL_VERSION_2_0 := FALSE;
  GL_VERSION_2_1 := FALSE;
  GL_VERSION_3_0 := FALSE;
  GL_VERSION_3_1 := FALSE;
  GL_VERSION_3_2 := FALSE;
  GL_VERSION_3_3 := FALSE;
  GL_VERSION_4_0 := FALSE;
  GL_VERSION_4_1 := FALSE;

  IF MajorVersion = 1 THEN
  
    IF MinorVersion >= 1 THEN GL_VERSION_1_1 := TRUE; END;
    IF MinorVersion >= 2 THEN GL_VERSION_1_2 := TRUE; END;
    IF MinorVersion >= 3 THEN GL_VERSION_1_3 := TRUE; END;
    IF MinorVersion >= 4 THEN GL_VERSION_1_4 := TRUE; END;
    IF MinorVersion >= 5 THEN GL_VERSION_1_5 := TRUE; END;
  END;

  IF MajorVersion >= 2 THEN
    GL_VERSION_1_1 := TRUE;
    GL_VERSION_1_2 := TRUE;
    GL_VERSION_1_3 := TRUE;
    GL_VERSION_1_4 := TRUE;
    GL_VERSION_1_5 := TRUE;
    GL_VERSION_2_0 := TRUE;

    IF MinorVersion >= 1 THEN GL_VERSION_2_1 := TRUE; END;
  END;

  IF MajorVersion >= 3 THEN
    GL_VERSION_2_1 := TRUE;
    GL_VERSION_3_0 := TRUE;
    
    IF MinorVersion >= 1 THEN GL_VERSION_3_1 := TRUE; END;
    IF MinorVersion >= 2 THEN GL_VERSION_3_2 := TRUE; END;
    IF MinorVersion >= 3 THEN GL_VERSION_3_3 := TRUE; END;
  END;

  IF MajorVersion >= 4 THEN

    GL_VERSION_3_1 := TRUE;
    GL_VERSION_3_2 := TRUE;
    GL_VERSION_3_3 := TRUE;
    GL_VERSION_4_0 := TRUE;

    IF MinorVersion >= 1 THEN GL_VERSION_4_1 := TRUE; END;
  END;

  (* GLU *)
  GLU_VERSION_1_1 := FALSE;
  GLU_VERSION_1_2 := FALSE;
  GLU_VERSION_1_3 := FALSE;

  IF gluGetString # NIL THEN
    Buffer := GLUGetString(GLC.GLU_VERSION);
    
    TrimAndSplitVersionString(Buffer^, MajorVersion, MinorVersion);

    GLU_VERSION_1_1 := TRUE;

    IF MinorVersion >= 2 THEN GLU_VERSION_1_2 := TRUE; END;

    IF MinorVersion >= 3 THEN GLU_VERSION_1_3 := TRUE; END;
  END;
END ReadCoreVersion;


PROCEDURE Int_GetExtensionString(): Strings.String;
VAR 
	buffer0 : Strings.String;
	len0 : LONGINT;
BEGIN
  (* generel extension string *)
	IF glGetString = NIL THEN
		Unix.Dlsym(GL_LibHandle, "glGetString", SYSTEM.VAL(ADDRESS,glGetString));
	END;  
  
	IF glGetString # NIL THEN
		buffer0 := GLGetString(GLC.GL_EXTENSIONS);
		len0 := Strings.Length(buffer0^)
	END;
  
RETURN buffer0;
END Int_GetExtensionString;


PROCEDURE Int_CheckExtension( allextensions: Strings.String; CONST thisextension: ARRAY OF CHAR): BOOLEAN;
BEGIN
  RETURN Strings.Pos(thisextension, allextensions^) > 0;
END Int_CheckExtension;

(** check wether extension available *)
PROCEDURE CheckExtension*(CONST extension: ARRAY OF CHAR): BOOLEAN;
VAR
  allextensions: Strings.String;
BEGIN 
   allextensions := Int_GetExtensionString();
  RETURN Int_CheckExtension(allextensions, extension);
END CheckExtension;

PROCEDURE  ReadImplementationProperties*;
VAR 
  Buffer: Strings.String;

BEGIN 
  ReadCoreVersion;

  (* Check all extensions *)
  Buffer := Int_GetExtensionString();

  (* === 3DFX ====================================================================*)
  GL_3DFX_multisample := Int_CheckExtension(Buffer, 'GL_3DFX_multisample');
  GL_3DFX_tbuffer := Int_CheckExtension(Buffer, 'GL_3DFX_tbuffer');
  GL_3DFX_texture_compression_FXT1 := Int_CheckExtension(Buffer, 'GL_3DFX_texture_compression_FXT1');

  (* === APPLE =================================================================== *)
  GL_APPLE_client_storage := Int_CheckExtension(Buffer, 'GL_APPLE_client_storage');
  GL_APPLE_element_array := Int_CheckExtension(Buffer, 'GL_APPLE_element_array');
  GL_APPLE_fence := Int_CheckExtension(Buffer, 'GL_APPLE_fence');
  GL_APPLE_specular_vector := Int_CheckExtension(Buffer, 'GL_APPLE_specular_vector');
  GL_APPLE_transform_hint := Int_CheckExtension(Buffer, 'GL_APPLE_transform_hint');
  GL_APPLE_vertex_array_object := Int_CheckExtension(Buffer, 'GL_APPLE_vertex_array_object');
  GL_APPLE_vertex_array_range := Int_CheckExtension(Buffer, 'GL_APPLE_vertex_array_range');
  GL_APPLE_ycbcr_422 := Int_CheckExtension(Buffer, 'GL_APPLE_ycbcr_422');
  GL_APPLE_texture_range := Int_CheckExtension(Buffer, 'GL_APPLE_texture_range');
  GL_APPLE_float_pixels := Int_CheckExtension(Buffer, 'GL_APPLE_float_pixels');
  GL_APPLE_vertex_program_evaluators := Int_CheckExtension(Buffer, 'GL_APPLE_vertex_program_evaluators');
  GL_APPLE_aux_depth_stencil := Int_CheckExtension(Buffer, 'GL_APPLE_aux_depth_stencil');
  GL_APPLE_object_purgeable := Int_CheckExtension(Buffer, 'GL_APPLE_object_purgeable');
  GL_APPLE_row_bytes := Int_CheckExtension(Buffer, 'GL_APPLE_row_bytes');
  GL_APPLE_rgb_422 := Int_CheckExtension(Buffer, 'GL_APPLE_rgb_422');

  (* === ARB ===================================================================== *)
  GL_ARB_depth_texture := Int_CheckExtension(Buffer, 'GL_ARB_depth_texture');
  GL_ARB_fragment_program := Int_CheckExtension(Buffer, 'GL_ARB_fragment_program');
  GL_ARB_imaging := Int_CheckExtension(Buffer, 'GL_ARB_imaging');
  GL_ARB_matrix_palette := Int_CheckExtension(Buffer, 'GL_ARB_matrix_palette');
  GL_ARB_multisample := Int_CheckExtension(Buffer, 'GL_ARB_multisample');
  GL_ARB_multitexture := Int_CheckExtension(Buffer, 'GL_ARB_multitexture');
  GL_ARB_point_parameters := Int_CheckExtension(Buffer, 'GL_ARB_point_parameters');
  GL_ARB_shadow := Int_CheckExtension(Buffer, 'GL_ARB_shadow');
  GL_ARB_shadow_ambient := Int_CheckExtension(Buffer, 'GL_ARB_shadow_ambient');
  GL_ARB_texture_border_clamp := Int_CheckExtension(Buffer, 'GL_ARB_texture_border_clamp');
  GL_ARB_texture_compression := Int_CheckExtension(Buffer, 'GL_ARB_texture_compression');
  GL_ARB_texture_cube_map := Int_CheckExtension(Buffer, 'GL_ARB_texture_cube_map');
  GL_ARB_texture_env_add := Int_CheckExtension(Buffer, 'GL_ARB_texture_env_add');
  GL_ARB_texture_env_combine := Int_CheckExtension(Buffer, 'GL_ARB_texture_env_combine');
  GL_ARB_texture_env_crossbar := Int_CheckExtension(Buffer, 'GL_ARB_texture_env_crossbar');
  GL_ARB_texture_env_dot3 := Int_CheckExtension(Buffer, 'GL_ARB_texture_env_dot3');
  GL_ARB_texture_mirrored_repeat := Int_CheckExtension(Buffer, 'GL_ARB_texture_mirrored_repeat');
  GL_ARB_transpose_matrix := Int_CheckExtension(Buffer, 'GL_ARB_transpose_matrix');
  GL_ARB_vertex_blend := Int_CheckExtension(Buffer, 'GL_ARB_vertex_blend');
  GL_ARB_vertex_buffer_object := Int_CheckExtension(Buffer, 'GL_ARB_vertex_buffer_object');
  GL_ARB_vertex_program := Int_CheckExtension(Buffer, 'GL_ARB_vertex_program');
  GL_ARB_window_pos := Int_CheckExtension(Buffer, 'GL_ARB_window_pos');
  GL_ARB_shader_objects := Int_CheckExtension(Buffer, 'GL_ARB_shader_objects');
  GL_ARB_vertex_shader := Int_CheckExtension(Buffer, 'GL_ARB_vertex_shader');
  GL_ARB_fragment_shader := Int_CheckExtension(Buffer, 'GL_ARB_fragment_shader');
  GL_ARB_occlusion_query := Int_CheckExtension(Buffer, 'GL_ARB_occlusion_query');
  GL_ARB_shading_language_100 := Int_CheckExtension(Buffer, 'GL_ARB_shading_language_100');
  GL_ARB_point_sprite := Int_CheckExtension(Buffer, 'GL_ARB_point_sprite');
  GL_ARB_texture_non_power_of_two := Int_CheckExtension(Buffer, 'GL_ARB_texture_non_power_of_two');
  GL_ARB_fragment_program_shadow := Int_CheckExtension(Buffer, 'GL_ARB_fragment_program_shadow');
  GL_ARB_draw_buffers := Int_CheckExtension(Buffer, 'GL_ARB_draw_buffers');
  GL_ARB_texture_rectangle := Int_CheckExtension(Buffer, 'GL_ARB_texture_rectangle');
  GL_ARB_color_buffer_float := Int_CheckExtension(Buffer, 'GL_ARB_color_buffer_float');
  GL_ARB_half_float_pixel := Int_CheckExtension(Buffer, 'GL_ARB_half_float_pixel');
  GL_ARB_texture_float := Int_CheckExtension(Buffer, 'GL_ARB_texture_float');
  GL_ARB_pixel_buffer_object := Int_CheckExtension(Buffer, 'GL_ARB_pixel_buffer_object');
  GL_ARB_depth_buffer_float := Int_CheckExtension(Buffer, 'GL_ARB_depth_buffer_float');
  GL_ARB_draw_instanced := Int_CheckExtension(Buffer, 'GL_ARB_draw_instanced');
  GL_ARB_framebuffer_object := Int_CheckExtension(Buffer, 'GL_ARB_framebuffer_object');
  GL_ARB_framebuffer_sRGB := Int_CheckExtension(Buffer, 'GL_ARB_framebuffer_sRGB');
  GL_ARB_geometry_shader4 := Int_CheckExtension(Buffer, 'GL_ARB_geometry_shader4');
  GL_ARB_half_float_vertex := Int_CheckExtension(Buffer, 'GL_ARB_half_float_vertex');
  GL_ARB_instanced_arrays := Int_CheckExtension(Buffer, 'GL_ARB_instanced_arrays');
  GL_ARB_map_buffer_range := Int_CheckExtension(Buffer, 'GL_ARB_map_buffer_range');
  GL_ARB_texture_buffer_object := Int_CheckExtension(Buffer, 'GL_ARB_texture_buffer_object');
  GL_ARB_texture_compression_rgtc := Int_CheckExtension(Buffer, 'GL_ARB_texture_compression_rgtc');
  GL_ARB_texture_rg := Int_CheckExtension(Buffer, 'GL_ARB_texture_rg');
  GL_ARB_vertex_array_object := Int_CheckExtension(Buffer, 'GL_ARB_vertex_array_object');
  GL_ARB_uniform_buffer_object := Int_CheckExtension(Buffer, 'GL_ARB_uniform_buffer_object');
  GL_ARB_compatibility := Int_CheckExtension(Buffer, 'GL_ARB_compatibility');
  GL_ARB_copy_buffer := Int_CheckExtension(Buffer, 'GL_ARB_copy_buffer');
  GL_ARB_shader_texture_lod := Int_CheckExtension(Buffer, 'GL_ARB_shader_texture_lod');
  GL_ARB_depth_clamp := Int_CheckExtension(Buffer, 'GL_ARB_depth_clamp');
  GL_ARB_draw_elements_base_vertex := Int_CheckExtension(Buffer, 'GL_ARB_draw_elements_base_vertex');
  GL_ARB_fragment_coord_conventions := Int_CheckExtension(Buffer, 'GL_ARB_fragment_coord_conventions');
  GL_ARB_provoking_vertex := Int_CheckExtension(Buffer, 'GL_ARB_provoking_vertex');
  GL_ARB_seamless_cube_map := Int_CheckExtension(Buffer, 'GL_ARB_seamless_cube_map');
  GL_ARB_sync := Int_CheckExtension(Buffer, 'GL_ARB_sync');
  GL_ARB_texture_multisample := Int_CheckExtension(Buffer, 'GL_ARB_texture_multisample');
  GL_ARB_vertex_array_bgra := Int_CheckExtension(Buffer, 'GL_ARB_vertex_array_bgra');
  GL_ARB_draw_buffers_blend := Int_CheckExtension(Buffer, 'GL_ARB_draw_buffers_blend');
  GL_ARB_sample_shading := Int_CheckExtension(Buffer, 'GL_ARB_sample_shading');
  GL_ARB_texture_cube_map_array := Int_CheckExtension(Buffer, 'GL_ARB_texture_cube_map_array');
  GL_ARB_texture_gather := Int_CheckExtension(Buffer, 'GL_ARB_texture_gather');
  GL_ARB_texture_query_lod := Int_CheckExtension(Buffer, 'GL_ARB_texture_query_lod');
  GL_ARB_shading_language_include := Int_CheckExtension(Buffer, 'GL_ARB_shading_language_include');
  GL_ARB_texture_compression_bptc := Int_CheckExtension(Buffer, 'GL_ARB_texture_compression_bptc');
  GL_ARB_blend_func_extended := Int_CheckExtension(Buffer, 'GL_ARB_blend_func_extended');
  GL_ARB_explicit_attrib_location := Int_CheckExtension(Buffer, 'GL_ARB_explicit_attrib_location');
  GL_ARB_occlusion_query2 := Int_CheckExtension(Buffer, 'GL_ARB_occlusion_query2');
  GL_ARB_sampler_objects := Int_CheckExtension(Buffer, 'GL_ARB_sampler_objects');
  GL_ARB_shader_bit_encoding := Int_CheckExtension(Buffer, 'GL_ARB_shader_bit_encoding');
  GL_ARB_texture_rgb10_a2ui := Int_CheckExtension(Buffer, 'GL_ARB_texture_rgb10_a2ui');
  GL_ARB_texture_swizzle := Int_CheckExtension(Buffer, 'GL_ARB_texture_swizzle');
  GL_ARB_timer_query := Int_CheckExtension(Buffer, 'GL_ARB_timer_query');
  GL_ARB_vertex_type_2_10_10_10_rev := Int_CheckExtension(Buffer, 'GL_ARB_vertex_type_2_10_10_10_rev');
  GL_ARB_draw_indirect := Int_CheckExtension(Buffer, 'GL_ARB_draw_indirect');
  GL_ARB_gpu_shader5 := Int_CheckExtension(Buffer, 'GL_ARB_gpu_shader5');
  GL_ARB_gpu_shader_fp64 := Int_CheckExtension(Buffer, 'GL_ARB_gpu_shader_fp64');
  GL_ARB_shader_subroutine := Int_CheckExtension(Buffer, 'GL_ARB_shader_subroutine');
  GL_ARB_tessellation_shader := Int_CheckExtension(Buffer, 'GL_ARB_tessellation_shader');
  GL_ARB_texture_buffer_object_rgb32 := Int_CheckExtension(Buffer, 'GL_ARB_texture_buffer_object_rgb32');
  GL_ARB_transform_feedback2 := Int_CheckExtension(Buffer, 'GL_ARB_transform_feedback2');
  GL_ARB_transform_feedback3 := Int_CheckExtension(Buffer, 'GL_ARB_transform_feedback3');
  GL_ARB_ES2_compatibility := Int_CheckExtension(Buffer, 'GL_ARB_ES2_compatibility');
  GL_ARB_get_program_binary := Int_CheckExtension(Buffer, 'GL_ARB_get_program_binary');
  GL_ARB_separate_shader_objects := Int_CheckExtension(Buffer, 'GL_ARB_separate_shader_objects');
  GL_ARB_shader_precision := Int_CheckExtension(Buffer, 'GL_ARB_shader_precision');
  GL_ARB_vertex_attrib_64bit := Int_CheckExtension(Buffer, 'GL_ARB_vertex_attrib_64bit');
  GL_ARB_viewport_array := Int_CheckExtension(Buffer, 'GL_ARB_viewport_array');
  GL_ARB_cl_event := Int_CheckExtension(Buffer, 'GL_ARB_cl_event');
  GL_ARB_debug_output := Int_CheckExtension(Buffer, 'GL_ARB_debug_output');
  GL_ARB_robustness := Int_CheckExtension(Buffer, 'GL_ARB_robustness');
  GL_ARB_shader_stencil_export := Int_CheckExtension(Buffer, 'GL_ARB_shader_stencil_export');
  
  (* === ATI/AMD ================================================================= *)
  GL_ATI_draw_buffers := Int_CheckExtension(Buffer, 'GL_ATI_draw_buffers');
  GL_ATI_element_array := Int_CheckExtension(Buffer, 'GL_ATI_element_array');
  GL_ATI_envmap_bumpmap := Int_CheckExtension(Buffer, 'GL_ATI_envmap_bumpmap');
  GL_ATI_fragment_shader := Int_CheckExtension(Buffer, 'GL_ATI_fragment_shader');
  GL_ATI_map_object_buffer := Int_CheckExtension(Buffer, 'GL_ATI_map_object_buffer');
  GL_ATI_pn_triangles := Int_CheckExtension(Buffer, 'GL_ATI_pn_triangles');
  GL_ATI_separate_stencil := Int_CheckExtension(Buffer, 'GL_ATI_separate_stencil');
  GL_ATI_text_fragment_shader := Int_CheckExtension(Buffer, 'GL_ATI_text_fragment_shader');
  GL_ATI_texture_env_combine3 := Int_CheckExtension(Buffer, 'GL_ATI_texture_env_combine3');
  GL_ATI_texture_float := Int_CheckExtension(Buffer, 'GL_ATI_texture_float');
  GL_ATI_texture_mirror_once := Int_CheckExtension(Buffer, 'GL_ATI_texture_mirror_once');
  GL_ATI_vertex_array_object := Int_CheckExtension(Buffer, 'GL_ATI_vertex_array_object');
  GL_ATI_vertex_attrib_array_object := Int_CheckExtension(Buffer, 'GL_ATI_vertex_attrib_array_object');
  GL_ATI_vertex_streams := Int_CheckExtension(Buffer, 'GL_ATI_vertex_streams');
  GL_ATI_meminfo := Int_CheckExtension(Buffer, 'GL_ATI_meminfo');
  GL_AMD_performance_monitor := Int_CheckExtension(Buffer, 'GL_AMD_performance_monitor');
  GL_AMD_texture_texture4 := Int_CheckExtension(Buffer, 'GL_AMD_texture_texture4');
  GL_AMD_vertex_shader_tesselator := Int_CheckExtension(Buffer, 'GL_AMD_vertex_shader_tesselator');
  GL_AMD_draw_buffers_blend := Int_CheckExtension(Buffer, 'GL_AMD_draw_buffers_blend');
  GL_AMD_shader_stencil_export := Int_CheckExtension(Buffer, 'GL_AMD_shader_stencil_export');
  GL_AMD_seamless_cubemap_per_texture := Int_CheckExtension(Buffer, 'GL_AMD_seamless_cubemap_per_texture');
  GL_AMD_conservative_depth := Int_CheckExtension(Buffer, 'GL_AMD_conservative_depth');
  GL_AMD_name_gen_delete := Int_CheckExtension(Buffer, 'GL_AMD_name_gen_delete');
  GL_AMD_debug_output := Int_CheckExtension(Buffer, 'GL_AMD_debug_output');
  GL_AMD_transform_feedback3_lines_triangles := Int_CheckExtension(Buffer, 'GL_AMD_transform_feedback3_lines_triangles');
  GL_AMD_depth_clamp_separate := Int_CheckExtension(Buffer, 'GL_AMD_depth_clamp_separate');

  (* === EXT ===================================================================== *)
  GL_EXT_422_pixels := Int_CheckExtension(Buffer, 'GL_EXT_422_pixels');
  GL_EXT_abgr := Int_CheckExtension(Buffer, 'GL_EXT_abgr');
  GL_EXT_bgra := Int_CheckExtension(Buffer, 'GL_EXT_bgra');
  GL_EXT_blend_color := Int_CheckExtension(Buffer, 'GL_EXT_blend_color');
  GL_EXT_blend_func_separate := Int_CheckExtension(Buffer, 'GL_EXT_blend_func_separate');
  GL_EXT_blend_logic_op := Int_CheckExtension(Buffer, 'GL_EXT_blend_logic_op');
  GL_EXT_blend_minmax := Int_CheckExtension(Buffer, 'GL_EXT_blend_minmax');
  GL_EXT_blend_subtract := Int_CheckExtension(Buffer, 'GL_EXT_blend_subtract');
  GL_EXT_clip_volume_hint := Int_CheckExtension(Buffer, 'GL_EXT_clip_volume_hint');
  GL_EXT_cmyka := Int_CheckExtension(Buffer, 'GL_EXT_cmyka');
  GL_EXT_color_matrix := Int_CheckExtension(Buffer, 'GL_EXT_color_matrix');
  GL_EXT_color_subtable := Int_CheckExtension(Buffer, 'GL_EXT_color_subtable');
  GL_EXT_compiled_vertex_array := Int_CheckExtension(Buffer, 'GL_EXT_compiled_vertex_array');
  GL_EXT_convolution := Int_CheckExtension(Buffer, 'GL_EXT_convolution');
  GL_EXT_coordinate_frame := Int_CheckExtension(Buffer, 'GL_EXT_coordinate_frame');
  GL_EXT_copy_texture := Int_CheckExtension(Buffer, 'GL_EXT_copy_texture');
  GL_EXT_cull_vertex := Int_CheckExtension(Buffer, 'GL_EXT_cull_vertex');
  GL_EXT_draw_range_elements := Int_CheckExtension(Buffer, 'GL_EXT_draw_range_elements');
  GL_EXT_fog_coord := Int_CheckExtension(Buffer, 'GL_EXT_fog_coord');
  GL_EXT_framebuffer_object := Int_CheckExtension(Buffer, 'GL_EXT_framebuffer_object');
  GL_EXT_histogram := Int_CheckExtension(Buffer, 'GL_EXT_histogram');
  GL_EXT_index_array_formats := Int_CheckExtension(Buffer, 'GL_EXT_index_array_formats');
  GL_EXT_index_func := Int_CheckExtension(Buffer, 'GL_EXT_index_func');
  GL_EXT_index_material := Int_CheckExtension(Buffer, 'GL_EXT_index_material');
  GL_EXT_index_texture := Int_CheckExtension(Buffer, 'GL_EXT_index_texture');
  GL_EXT_light_texture := Int_CheckExtension(Buffer, 'GL_EXT_light_texture');
  GL_EXT_misc_attribute := Int_CheckExtension(Buffer, 'GL_EXT_misc_attribute');
  GL_EXT_multi_draw_arrays := Int_CheckExtension(Buffer, 'GL_EXT_multi_draw_arrays');
  GL_EXT_multisample := Int_CheckExtension(Buffer, 'GL_EXT_multisample');
  GL_EXT_packed_pixels := Int_CheckExtension(Buffer, 'GL_EXT_packed_pixels');
  GL_EXT_paletted_texture := Int_CheckExtension(Buffer, 'GL_EXT_paletted_texture');
  GL_EXT_pixel_transform := Int_CheckExtension(Buffer, 'GL_EXT_pixel_transform');
  GL_EXT_pixel_transform_color_table := Int_CheckExtension(Buffer, 'GL_EXT_pixel_transform_color_table');
  GL_EXT_point_parameters := Int_CheckExtension(Buffer, 'GL_EXT_point_parameters');
  GL_EXT_polygon_offset := Int_CheckExtension(Buffer, 'GL_EXT_polygon_offset');
  GL_EXT_rescale_normal := Int_CheckExtension(Buffer, 'GL_EXT_rescale_normal');
  GL_EXT_secondary_color := Int_CheckExtension(Buffer, 'GL_EXT_secondary_color');
  GL_EXT_separate_specular_color := Int_CheckExtension(Buffer, 'GL_EXT_separate_specular_color');
  GL_EXT_shadow_funcs := Int_CheckExtension(Buffer, 'GL_EXT_shadow_funcs');
  GL_EXT_shared_texture_palette := Int_CheckExtension(Buffer, 'GL_EXT_shared_texture_palette');
  GL_EXT_stencil_two_side := Int_CheckExtension(Buffer, 'GL_EXT_stencil_two_side');
  GL_EXT_stencil_wrap := Int_CheckExtension(Buffer, 'GL_EXT_stencil_wrap');
  GL_EXT_subtexture := Int_CheckExtension(Buffer, 'GL_EXT_subtexture');
  GL_EXT_texture := Int_CheckExtension(Buffer, 'GL_EXT_texture');
  GL_EXT_texture3D := Int_CheckExtension(Buffer, 'GL_EXT_texture3D');
  GL_EXT_texture_compression_s3tc := Int_CheckExtension(Buffer, 'GL_EXT_texture_compression_s3tc');
  GL_EXT_texture_cube_map := Int_CheckExtension(Buffer, 'GL_EXT_texture_cube_map');
  GL_EXT_texture_edge_clamp := Int_CheckExtension(Buffer, 'GL_EXT_texture_edge_clamp');
  GL_EXT_texture_env_add := Int_CheckExtension(Buffer, 'GL_EXT_texture_env_add');
  GL_EXT_texture_env_combine := Int_CheckExtension(Buffer, 'GL_EXT_texture_env_combine');
  GL_EXT_texture_env_dot3 := Int_CheckExtension(Buffer, 'GL_EXT_texture_env_dot3');
  GL_EXT_texture_filter_anisotropic := Int_CheckExtension(Buffer, 'GL_EXT_texture_filter_anisotropic');
  GL_EXT_texture_lod_bias := Int_CheckExtension(Buffer, 'GL_EXT_texture_lod_bias');
  GL_EXT_texture_object := Int_CheckExtension(Buffer, 'GL_EXT_texture_object');
  GL_EXT_texture_perturb_normal := Int_CheckExtension(Buffer, 'GL_EXT_texture_perturb_normal');
  GL_EXT_texture_rectangle := Int_CheckExtension(Buffer, 'GL_EXT_texture_rectangle');
  GL_EXT_vertex_array := Int_CheckExtension(Buffer, 'GL_EXT_vertex_array');
  GL_EXT_vertex_shader := Int_CheckExtension(Buffer, 'GL_EXT_vertex_shader');
  GL_EXT_vertex_weighting := Int_CheckExtension(Buffer, 'GL_EXT_vertex_weighting');
  GL_EXT_depth_bounds_test := Int_CheckExtension(Buffer, 'GL_EXT_depth_bounds_test');
  GL_EXT_texture_mirror_clamp := Int_CheckExtension(Buffer, 'GL_EXT_texture_mirror_clamp');
  GL_EXT_blend_equation_separate := Int_CheckExtension(Buffer, 'GL_EXT_blend_equation_separate');
  GL_EXT_pixel_buffer_object := Int_CheckExtension(Buffer, 'GL_EXT_pixel_buffer_object');
  GL_EXT_texture_compression_dxt1 := Int_CheckExtension(Buffer, 'GL_EXT_texture_compression_dxt1');
  GL_EXT_stencil_clear_tag := Int_CheckExtension(Buffer, 'GL_EXT_stencil_clear_tag');
  GL_EXT_packed_depth_stencil := Int_CheckExtension(Buffer, 'GL_EXT_packed_depth_stencil');
  GL_EXT_texture_sRGB := Int_CheckExtension(Buffer, 'GL_EXT_texture_sRGB');
  GL_EXT_framebuffer_blit := Int_CheckExtension(Buffer, 'GL_EXT_framebuffer_blit');
  GL_EXT_framebuffer_multisample := Int_CheckExtension(Buffer, 'GL_EXT_framebuffer_multisample');
  GL_EXT_timer_query := Int_CheckExtension(Buffer, 'GL_EXT_timer_query');
  GL_EXT_gpu_program_parameters := Int_CheckExtension(Buffer, 'GL_EXT_gpu_program_parameters');
  GL_EXT_bindable_uniform := Int_CheckExtension(Buffer, 'GL_EXT_bindable_uniform');
  GL_EXT_draw_buffers2 := Int_CheckExtension(Buffer, 'GL_EXT_draw_buffers2');
  GL_EXT_draw_instanced := Int_CheckExtension(Buffer, 'GL_EXT_draw_instanced');
  GL_EXT_framebuffer_sRGB := Int_CheckExtension(Buffer, 'GL_EXT_framebuffer_sRGB');
  GL_EXT_geometry_shader4 := Int_CheckExtension(Buffer, 'GL_EXT_geometry_shader4');
  GL_EXT_gpu_shader4 := Int_CheckExtension(Buffer, 'GL_EXT_gpu_shader4');
  GL_EXT_packed_float := Int_CheckExtension(Buffer, 'GL_EXT_packed_float');
  GL_EXT_texture_array := Int_CheckExtension(Buffer, 'GL_EXT_texture_array');
  GL_EXT_texture_buffer_object := Int_CheckExtension(Buffer, 'GL_EXT_texture_buffer_object');
  GL_EXT_texture_compression_latc := Int_CheckExtension(Buffer, 'GL_EXT_texture_compression_latc');
  GL_EXT_texture_compression_rgtc := Int_CheckExtension(Buffer, 'GL_EXT_texture_compression_rgtc');
  GL_EXT_texture_integer := Int_CheckExtension(Buffer, 'GL_EXT_texture_integer');
  GL_EXT_texture_shared_exponent := Int_CheckExtension(Buffer, 'GL_EXT_texture_shared_exponent');
  GL_EXT_transform_feedback := Int_CheckExtension(Buffer, 'GL_EXT_transform_feedback');
  GL_EXT_direct_state_access := Int_CheckExtension(Buffer, 'GL_EXT_direct_state_access');
  GL_EXT_vertex_array_bgra := Int_CheckExtension(Buffer, 'GL_EXT_vertex_array_bgra');
  GL_EXT_texture_swizzle := Int_CheckExtension(Buffer, 'GL_EXT_texture_swizzle');
  GL_EXT_provoking_vertex := Int_CheckExtension(Buffer, 'GL_EXT_provoking_vertex');
  GL_EXT_texture_snorm := Int_CheckExtension(Buffer, 'GL_EXT_texture_snorm');
  GL_EXT_separate_shader_objects := Int_CheckExtension(Buffer, 'GL_EXT_separate_shader_objects');
  GL_EXT_shader_image_load_store := Int_CheckExtension(Buffer, 'GL_EXT_shader_image_load_store');
  GL_EXT_vertex_attrib_64bit := Int_CheckExtension(Buffer, 'GL_EXT_vertex_attrib_64bit');
  GL_EXT_texture_sRGB_decode := Int_CheckExtension(Buffer, 'GL_EXT_texture_sRGB_decode');
  
  (* === HP ====================================================================== *)
  GL_HP_convolution_border_modes := Int_CheckExtension(Buffer, 'GL_HP_convolution_border_modes');
  GL_HP_image_transform := Int_CheckExtension(Buffer, 'GL_HP_image_transform');
  GL_HP_occlusion_test := Int_CheckExtension(Buffer, 'GL_HP_occlusion_test');
  GL_HP_texture_lighting := Int_CheckExtension(Buffer, 'GL_HP_texture_lighting');

  (* === IBM ===================================================================== *)
  GL_IBM_cull_vertex := Int_CheckExtension(Buffer, 'GL_IBM_cull_vertex');
  GL_IBM_multimode_draw_arrays := Int_CheckExtension(Buffer, 'GL_IBM_multimode_draw_arrays');
  GL_IBM_rasterpos_clip := Int_CheckExtension(Buffer, 'GL_IBM_rasterpos_clip');
  GL_IBM_texture_mirrored_repeat := Int_CheckExtension(Buffer, 'GL_IBM_texture_mirrored_repeat');
  GL_IBM_vertex_array_lists := Int_CheckExtension(Buffer, 'GL_IBM_vertex_array_lists');

  (* === INGR ==================================================================== *)
  GL_INGR_blend_func_separate := Int_CheckExtension(Buffer, 'GL_INGR_blend_func_separate');
  GL_INGR_color_clamp := Int_CheckExtension(Buffer, 'GL_INGR_color_clamp');
  GL_INGR_interlace_read := Int_CheckExtension(Buffer, 'GL_INGR_interlace_read');
  GL_INGR_palette_buffer := Int_CheckExtension(Buffer, 'GL_INGR_palette_buffer');

  (* === INTEL =================================================================== *)
  GL_INTEL_parallel_arrays := Int_CheckExtension(Buffer, 'GL_INTEL_parallel_arrays');
  GL_INTEL_texture_scissor := Int_CheckExtension(Buffer, 'GL_INTEL_texture_scissor');

  (* === MESA ==================================================================== *)
  GL_MESA_resize_buffers := Int_CheckExtension(Buffer, 'GL_MESA_resize_buffers');
  GL_MESA_window_pos := Int_CheckExtension(Buffer, 'GL_MESA_window_pos');

  (* === NVIDIA ================================================================== *)
  GL_NV_blend_square := Int_CheckExtension(Buffer, 'GL_NV_blend_square');
  GL_NV_copy_depth_to_color := Int_CheckExtension(Buffer, 'GL_NV_copy_depth_to_color');
  GL_NV_depth_clamp := Int_CheckExtension(Buffer, 'GL_NV_depth_clamp');
  GL_NV_evaluators := Int_CheckExtension(Buffer, 'GL_NV_evaluators');
  GL_NV_fence := Int_CheckExtension(Buffer, 'GL_NV_fence');
  GL_NV_float_buffer := Int_CheckExtension(Buffer, 'GL_NV_float_buffer');
  GL_NV_fog_distance := Int_CheckExtension(Buffer, 'GL_NV_fog_distance');
  GL_NV_fragment_program := Int_CheckExtension(Buffer, 'GL_NV_fragment_program');
  GL_NV_half_float := Int_CheckExtension(Buffer, 'GL_NV_half_float');
  GL_NV_light_max_exponent := Int_CheckExtension(Buffer, 'GL_NV_light_max_exponent');
  GL_NV_multisample_filter_hint := Int_CheckExtension(Buffer, 'GL_NV_multisample_filter_hint');
  GL_NV_occlusion_query := Int_CheckExtension(Buffer, 'GL_NV_occlusion_query');
  GL_NV_packed_depth_stencil := Int_CheckExtension(Buffer, 'GL_NV_packed_depth_stencil');
  GL_NV_pixel_data_range := Int_CheckExtension(Buffer, 'GL_NV_pixel_data_range');
  GL_NV_point_sprite := Int_CheckExtension(Buffer, 'GL_NV_point_sprite');
  GL_NV_primitive_restart := Int_CheckExtension(Buffer, 'GL_NV_primitive_restart');
  GL_NV_register_combiners := Int_CheckExtension(Buffer, 'GL_NV_register_combiners');
  GL_NV_register_combiners2 := Int_CheckExtension(Buffer, 'GL_NV_register_combiners2');
  GL_NV_texgen_emboss := Int_CheckExtension(Buffer, 'GL_NV_texgen_emboss');
  GL_NV_texgen_reflection := Int_CheckExtension(Buffer, 'GL_NV_texgen_reflection');
  GL_NV_texture_compression_vtc := Int_CheckExtension(Buffer, 'GL_NV_texture_compression_vtc');
  GL_NV_texture_env_combine4 := Int_CheckExtension(Buffer, 'GL_NV_texture_env_combine4');
  GL_NV_texture_expand_normal := Int_CheckExtension(Buffer, 'GL_NV_texture_expand_normal');
  GL_NV_texture_rectangle := Int_CheckExtension(Buffer, 'GL_NV_texture_rectangle');
  GL_NV_texture_shader := Int_CheckExtension(Buffer, 'GL_NV_texture_shader');
  GL_NV_texture_shader2 := Int_CheckExtension(Buffer, 'GL_NV_texture_shader2');
  GL_NV_texture_shader3 := Int_CheckExtension(Buffer, 'GL_NV_texture_shader3');
  GL_NV_vertex_array_range := Int_CheckExtension(Buffer, 'GL_NV_vertex_array_range');
  GL_NV_vertex_array_range2 := Int_CheckExtension(Buffer, 'GL_NV_vertex_array_range2');
  GL_NV_vertex_program := Int_CheckExtension(Buffer, 'GL_NV_vertex_program');
  GL_NV_vertex_program1_1 := Int_CheckExtension(Buffer, 'GL_NV_vertex_program1_1');
  GL_NV_vertex_program2 := Int_CheckExtension(Buffer, 'GL_NV_vertex_program2');
  GL_NV_fragment_program_option := Int_CheckExtension(Buffer, 'GL_NV_fragment_program_option');
  GL_NV_fragment_program2 := Int_CheckExtension(Buffer, 'GL_NV_fragment_program2');
  GL_NV_vertex_program2_option := Int_CheckExtension(Buffer, 'GL_NV_vertex_program2_option');
  GL_NV_vertex_program3 := Int_CheckExtension(Buffer, 'GL_NV_vertex_program3');
  GL_NV_depth_buffer_float := Int_CheckExtension(Buffer, 'GL_NV_depth_buffer_float');
  GL_NV_fragment_program4 := Int_CheckExtension(Buffer, 'GL_NV_fragment_program4');
  GL_NV_framebuffer_multisample_coverage := Int_CheckExtension(Buffer, 'GL_NV_framebuffer_multisample_coverage');
  GL_NV_geometry_program4 := Int_CheckExtension(Buffer, 'GL_NV_geometry_program4');
  GL_NV_gpu_program4 := Int_CheckExtension(Buffer, 'GL_NV_gpu_program4');
  GL_NV_parameter_buffer_object := Int_CheckExtension(Buffer, 'GL_NV_parameter_buffer_object');
  GL_NV_transform_feedback := Int_CheckExtension(Buffer, 'GL_NV_transform_feedback');
  GL_NV_vertex_program4 := Int_CheckExtension(Buffer, 'GL_NV_vertex_program4');
  GL_NV_conditional_render := Int_CheckExtension(Buffer, 'GL_NV_conditional_render');
  GL_NV_present_video := Int_CheckExtension(Buffer, 'GL_NV_present_video');
  GL_NV_explicit_multisample := Int_CheckExtension(Buffer, 'GL_NV_explicit_multisample');
  GL_NV_transform_feedback2 := Int_CheckExtension(Buffer, 'GL_NV_transform_feedback2');
  GL_NV_video_capture := Int_CheckExtension(Buffer, 'GL_NV_video_capture');
  GL_NV_copy_image := Int_CheckExtension(Buffer, 'GL_NV_copy_image');
  GL_NV_parameter_buffer_object2 := Int_CheckExtension(Buffer, 'GL_NV_parameter_buffer_object2');
  GL_NV_shader_buffer_load := Int_CheckExtension(Buffer, 'GL_NV_shader_buffer_load');
  GL_NV_vertex_buffer_unified_memory := Int_CheckExtension(Buffer, 'GL_NV_vertex_buffer_unified_memory');
  GL_NV_gpu_program5 := Int_CheckExtension(Buffer, 'GL_NV_gpu_program5');
  GL_NV_gpu_shader5 := Int_CheckExtension(Buffer, 'GL_NV_gpu_shader5');
  GL_NV_shader_buffer_store := Int_CheckExtension(Buffer, 'GL_NV_shader_buffer_store');
  GL_NV_tessellation_program5 := Int_CheckExtension(Buffer, 'GL_NV_tessellation_program5');
  GL_NV_vertex_attrib_integer_64bit := Int_CheckExtension(Buffer, 'GL_NV_vertex_attrib_integer_64bit');
  GL_NV_multisample_coverage := Int_CheckExtension(Buffer, 'GL_NV_multisample_coverage');
  GL_NV_vdpau_interop := Int_CheckExtension(Buffer, 'GL_NV_vdpau_interop');
  GL_NV_texture_barrier := Int_CheckExtension(Buffer, 'GL_NV_texture_barrier');

  (* === OML ===================================================================== *)
  GL_OML_interlace := Int_CheckExtension(Buffer, 'GL_OML_interlace');
  GL_OML_resample := Int_CheckExtension(Buffer, 'GL_OML_resample');
  GL_OML_subsample := Int_CheckExtension(Buffer, 'GL_OML_subsample');

  (* === PGI ===================================================================== *)
  GL_PGI_misc_hints := Int_CheckExtension(Buffer, 'GL_PGI_misc_hints');
  GL_PGI_vertex_hints := Int_CheckExtension(Buffer, 'GL_PGI_vertex_hints');

  (* === REND ==================================================================== *)
  GL_REND_screen_coordinates := Int_CheckExtension(Buffer, 'GL_REND_screen_coordinates');

  (* === S3 ====================================================================== *)
  GL_S3_s3tc := Int_CheckExtension(Buffer, 'GL_S3_s3tc');

  (* === SGIS ==================================================================== *)
  GL_SGIS_detail_texture := Int_CheckExtension(Buffer, 'GL_SGIS_detail_texture');
  GL_SGIS_fog_function := Int_CheckExtension(Buffer, 'GL_SGIS_fog_function');
  GL_SGIS_generate_mipmap := Int_CheckExtension(Buffer, 'GL_SGIS_generate_mipmap');
  GL_SGIS_multisample := Int_CheckExtension(Buffer, 'GL_SGIS_multisample');
  GL_SGIS_pixel_texture := Int_CheckExtension(Buffer, 'GL_SGIS_pixel_texture');
  GL_SGIS_point_line_texgen := Int_CheckExtension(Buffer, 'GL_SGIS_point_line_texgen');
  GL_SGIS_point_parameters := Int_CheckExtension(Buffer, 'GL_SGIS_point_parameters');
  GL_SGIS_sharpen_texture := Int_CheckExtension(Buffer, 'GL_SGIS_sharpen_texture');
  GL_SGIS_texture4D := Int_CheckExtension(Buffer, 'GL_SGIS_texture4D');
  GL_SGIS_texture_border_clamp := Int_CheckExtension(Buffer, 'GL_SGIS_texture_border_clamp');
  GL_SGIS_texture_color_mask := Int_CheckExtension(Buffer, 'GL_SGIS_texture_color_mask');
  GL_SGIS_texture_edge_clamp := Int_CheckExtension(Buffer, 'GL_SGIS_texture_edge_clamp');
  GL_SGIS_texture_filter4 := Int_CheckExtension(Buffer, 'GL_SGIS_texture_filter4');
  GL_SGIS_texture_lod := Int_CheckExtension(Buffer, 'GL_SGIS_texture_lod');
  GL_SGIS_texture_select := Int_CheckExtension(Buffer, 'GL_SGIS_texture_select');

  (* === SGIX ==================================================================== *)
  GL_FfdMaskSGIX := Int_CheckExtension(Buffer, 'GL_FfdMaskSGIX');
  GL_SGIX_async := Int_CheckExtension(Buffer, 'GL_SGIX_async');
  GL_SGIX_async_histogram := Int_CheckExtension(Buffer, 'GL_SGIX_async_histogram');
  GL_SGIX_async_pixel := Int_CheckExtension(Buffer, 'GL_SGIX_async_pixel');
  GL_SGIX_blend_alpha_minmax := Int_CheckExtension(Buffer, 'GL_SGIX_blend_alpha_minmax');
  GL_SGIX_calligraphic_fragment := Int_CheckExtension(Buffer, 'GL_SGIX_calligraphic_fragment');
  GL_SGIX_clipmap := Int_CheckExtension(Buffer, 'GL_SGIX_clipmap');
  GL_SGIX_convolution_accuracy := Int_CheckExtension(Buffer, 'GL_SGIX_convolution_accuracy');
  GL_SGIX_depth_pass_instrument := Int_CheckExtension(Buffer, 'GL_SGIX_depth_pass_instrument');
  GL_SGIX_depth_texture := Int_CheckExtension(Buffer, 'GL_SGIX_depth_texture');
  GL_SGIX_flush_raster := Int_CheckExtension(Buffer, 'GL_SGIX_flush_raster');
  GL_SGIX_fog_offset := Int_CheckExtension(Buffer, 'GL_SGIX_fog_offset');
  GL_SGIX_fog_scale := Int_CheckExtension(Buffer, 'GL_SGIX_fog_scale');
  GL_SGIX_fragment_lighting := Int_CheckExtension(Buffer, 'GL_SGIX_fragment_lighting');
  GL_SGIX_framezoom := Int_CheckExtension(Buffer, 'GL_SGIX_framezoom');
  GL_SGIX_igloo_interface := Int_CheckExtension(Buffer, 'GL_SGIX_igloo_interface');
  GL_SGIX_impact_pixel_texture := Int_CheckExtension(Buffer, 'GL_SGIX_impact_pixel_texture');
  GL_SGIX_instruments := Int_CheckExtension(Buffer, 'GL_SGIX_instruments');
  GL_SGIX_interlace := Int_CheckExtension(Buffer, 'GL_SGIX_interlace');
  GL_SGIX_ir_instrument1 := Int_CheckExtension(Buffer, 'GL_SGIX_ir_instrument1');
  GL_SGIX_list_priority := Int_CheckExtension(Buffer, 'GL_SGIX_list_priority');
  GL_SGIX_pixel_texture := Int_CheckExtension(Buffer, 'GL_SGIX_pixel_texture');
  GL_SGIX_pixel_tiles := Int_CheckExtension(Buffer, 'GL_SGIX_pixel_tiles');
  GL_SGIX_polynomial_ffd := Int_CheckExtension(Buffer, 'GL_SGIX_polynomial_ffd');
  GL_SGIX_reference_plane := Int_CheckExtension(Buffer, 'GL_SGIX_reference_plane');
  GL_SGIX_resample := Int_CheckExtension(Buffer, 'GL_SGIX_resample');
  GL_SGIX_scalebias_hint := Int_CheckExtension(Buffer, 'GL_SGIX_scalebias_hint');
  GL_SGIX_shadow := Int_CheckExtension(Buffer, 'GL_SGIX_shadow');
  GL_SGIX_shadow_ambient := Int_CheckExtension(Buffer, 'GL_SGIX_shadow_ambient');
  GL_SGIX_sprite := Int_CheckExtension(Buffer, 'GL_SGIX_sprite');
  GL_SGIX_subsample := Int_CheckExtension(Buffer, 'GL_SGIX_subsample');
  GL_SGIX_tag_sample_buffer := Int_CheckExtension(Buffer, 'GL_SGIX_tag_sample_buffer');
  GL_SGIX_texture_add_env := Int_CheckExtension(Buffer, 'GL_SGIX_texture_add_env');
  GL_SGIX_texture_coordinate_clamp := Int_CheckExtension(Buffer, 'GL_SGIX_texture_coordinate_clamp');
  GL_SGIX_texture_lod_bias := Int_CheckExtension(Buffer, 'GL_SGIX_texture_lod_bias');
  GL_SGIX_texture_multi_buffer := Int_CheckExtension(Buffer, 'GL_SGIX_texture_multi_buffer');
  GL_SGIX_texture_scale_bias := Int_CheckExtension(Buffer, 'GL_SGIX_texture_scale_bias');
  GL_SGIX_texture_select := Int_CheckExtension(Buffer, 'GL_SGIX_texture_select');
  GL_SGIX_vertex_preclip := Int_CheckExtension(Buffer, 'GL_SGIX_vertex_preclip');
  GL_SGIX_ycrcb := Int_CheckExtension(Buffer, 'GL_SGIX_ycrcb');
  GL_SGIX_ycrcb_subsample := Int_CheckExtension(Buffer, 'GL_SGIX_ycrcb_subsample');
  GL_SGIX_ycrcba := Int_CheckExtension(Buffer, 'GL_SGIX_ycrcba');

  (* === SGI ===================================================================== *)
  GL_SGI_color_matrix := Int_CheckExtension(Buffer, 'GL_SGI_color_matrix');
  GL_SGI_color_table := Int_CheckExtension(Buffer, 'GL_SGI_color_table');
  GL_SGI_depth_pass_instrument := Int_CheckExtension(Buffer, 'GL_SGI_depth_pass_instrument');
  GL_SGI_texture_color_table := Int_CheckExtension(Buffer, 'GL_SGI_texture_color_table');

  (* === SUN ===================================================================== *)
  GL_SUNX_constant_data := Int_CheckExtension(Buffer, 'GL_SUNX_constant_data');
  GL_SUN_convolution_border_modes := Int_CheckExtension(Buffer, 'GL_SUN_convolution_border_modes');
  GL_SUN_global_alpha := Int_CheckExtension(Buffer, 'GL_SUN_global_alpha');
  GL_SUN_mesh_array := Int_CheckExtension(Buffer, 'GL_SUN_mesh_array');
  GL_SUN_slice_accum := Int_CheckExtension(Buffer, 'GL_SUN_slice_accum');
  GL_SUN_triangle_list := Int_CheckExtension(Buffer, 'GL_SUN_triangle_list');
  GL_SUN_vertex := Int_CheckExtension(Buffer, 'GL_SUN_vertex');

  (* === WIN ===================================================================== *)
  GL_WIN_phong_shading := Int_CheckExtension(Buffer, 'GL_WIN_phong_shading');
  GL_WIN_specular_fog := Int_CheckExtension(Buffer, 'GL_WIN_specular_fog');

 
  (* LINUX *)
  (* === GLX ===================================================================== *)
  GLX_ARB_multisample := Int_CheckExtension(Buffer, 'GLX_ARB_multisample');
  GLX_ARB_fbconfig_float := Int_CheckExtension(Buffer, 'GLX_ARB_fbconfig_float');
  GLX_ARB_get_proc_address := Int_CheckExtension(Buffer, 'GLX_ARB_get_proc_address');
  GLX_ARB_create_context := Int_CheckExtension(Buffer, 'GLX_ARB_create_context');
  GLX_ARB_create_context_profile := Int_CheckExtension(Buffer, 'GLX_ARB_create_context_profile');
  GLX_ARB_vertex_buffer_object := Int_CheckExtension(Buffer, 'GLX_ARB_vertex_buffer_object');
  GLX_ARB_framebuffer_sRGB := Int_CheckExtension(Buffer, 'GLX_ARB_framebuffer_sRGB');
  GLX_ARB_create_context_robustness := Int_CheckExtension(Buffer, 'GLX_ARB_create_context_robustness');
  GLX_EXT_visual_info := Int_CheckExtension(Buffer, 'GLX_EXT_visual_info');
  GLX_EXT_visual_rating := Int_CheckExtension(Buffer, 'GLX_EXT_visual_rating');
  GLX_EXT_import_context := Int_CheckExtension(Buffer, 'GLX_EXT_import_context');
  GLX_EXT_fbconfig_packed_float := Int_CheckExtension(Buffer, 'GLX_EXT_fbconfig_packed_float');
  GLX_EXT_framebuffer_sRGB := Int_CheckExtension(Buffer, 'GLX_EXT_framebuffer_sRGB');
  GLX_EXT_texture_from_pixmap := Int_CheckExtension(Buffer, 'GLX_EXT_texture_from_pixmap');
  GLX_EXT_swap_control := Int_CheckExtension(Buffer, 'GLX_EXT_swap_control');
  GLX_EXT_create_context_es2_profile := Int_CheckExtension(Buffer, 'GLX_EXT_create_context_es2_profile');
  
  (* ImplementationRead := TRUE; *)
END ReadImplementationProperties;

PROCEDURE OnClose;
BEGIN {EXCLUSIVE}
DelFCR();

IF GL_LibHandle # 0 THEN
      Unix.Dlclose(GL_LibHandle);
       Trace.String(GL_LibName); Trace.String(" unloaded."); Trace.Ln; 
END;


IF GLU_LibHandle # 0 THEN
       Unix.Dlclose(GLU_LibHandle);
       Trace.String(GLU_LibName); Trace.String(" unloaded."); Trace.Ln; 
END;	 

END OnClose;

	(** -- Processor initialization --  from Unix.386.Machine *)
	(* default for UixAos: fcr := (FCR() - {0,2,3,10,11}) + {0..5,8,9};	(* default FCR RC=00B *) *)
	PROCEDURE -SetFCR0( s: SET );
	CODE {SYSTEM.i386, SYSTEM.FPU}
		FLDCW	[ESP]	;  parameter s
		POP	EAX
	END SetFCR0;

	PROCEDURE -FCR( ): SET;
	CODE {SYSTEM.i386, SYSTEM.FPU}
		PUSH	0
		FNSTCW	[ESP]
		FWAIT
		POP	EAX
	END FCR;

	PROCEDURE -InitFPU;
	CODE {SYSTEM.i386, SYSTEM.FPU}
		FNINIT
	END InitFPU;

	(** Setup FPU control word of current processor. *)
	PROCEDURE Set8087CW(fcr: SET): SET;
	VAR oldfcr: SET;
	BEGIN
		InitFPU;  
		oldfcr := FCR();
		SetFCR0( fcr );
		RETURN oldfcr;
	END Set8087CW;
	
PROCEDURE SetFCR*;
BEGIN
 oldfcr := Set8087CW(newfcr);
END SetFCR;

PROCEDURE DelFCR*;
BEGIN
 newfcr := Set8087CW(oldfcr);
END DelFCR;

BEGIN
 Modules.InstallTermHandler(OnClose);
 
 (*  
 	133FH= {0..5, 8..9,12}
 	oldfcr = {0..6, 8..9}  ,  LinuxAos
 *)
 oldfcr := FCR();
 newfcr := SYSTEM.VAL(SET, 133FH);

END OpenGL.

