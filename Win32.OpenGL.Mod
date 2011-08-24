MODULE OpenGL; (** AUTHOR "fnecati"; PURPOSE "OpenGL binding for WinAos"; *)
IMPORT SYSTEM, Kernel32, Modules,  Strings, GLC := OpenGLConst, KernelLog;
(* Compiler.Compile  Win32.OpenGL.Mod~ 
Compiler.Compile opengloberon/OpenGLConst.Mod Win32.OpenGL.Mod opengloberon/WinApi.Mod  opengloberon/Win32.GLContext.Mod ~
*)

VAR
	 (* handle to library *)
 	GL_LibHandle-: LONGINT;
	GLU_LibHandle-:LONGINT;
	oldfcr-, newfcr-: SET;  (* for FPU Control registers *)
		
CONST 


  GL_LibName = 'opengl32.dll';
  GLU_LibName = 'glu32.dll';

TYPE
  HDC * = Kernel32.HANDLE;	
  HGLRC * = Kernel32.HANDLE;
  
  (* Needed for Delphi 6 and less (defined in system.pas for Delphi 7)*)
  ADDRESS * = Kernel32.ADDRESS;
  AnsiChar* = POINTER TO ARRAY OF CHAR;	
  PAnsiChar * = POINTER TO ARRAY OF AnsiChar;
  THandle * = LONGINT;
  
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

 PGLboolean * = ADDRESS;
  PGLbyte * = ADDRESS;
  PGLshort * = ADDRESS;
  PGLint * =  ADDRESS; (* POINTER TO ARRAY OF GLint; *)
  PGLsizei * = ADDRESS;
  PGLubyte * = ADDRESS;
  PGLushort * = ADDRESS;
  PGLuint * = ADDRESS; (*POINTER TO ARRAY OF GLuint;*)
  PGLclampf * = ADDRESS;
  PGLfloat * =  ADDRESS; (*POINTER TO ARRAY OF GLfloat; *)
  PGLdouble * = ADDRESS; (* POINTER TO ARRAY OF GLdouble;*)
  PGLclampd * = ADDRESS;
  PGLenum * =  ADDRESS;
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
  TglDebugProcARB = PROCEDURE { WINAPI } (source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST message_: PGLchar; userParam: PGLvoid); 

  (* GL_AMD_debug_output *)
  TglDebugProcAMD = PROCEDURE { WINAPI } (id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; CONST message_: PGLchar; userParam: PGLvoid); 
  
 (* GL_NV_vdpau_interop *)
  GLvdpauSurfaceNV = GLintptr;
  PGLvdpauSurfaceNV =  POINTER TO ARRAY OF GLvdpauSurfaceNV;
  
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
  TGLUQuadricErrorProc * = PROCEDURE { WINAPI }(errorCode: GLenum); 
  (* GLUTessCallback *)
  TGLUTessBeginProc * = PROCEDURE { WINAPI }(AType: GLenum); 
  TGLUTessEdgeFlagProc * = PROCEDURE { WINAPI } (Flag: GLboolean); 
  TGLUTessVertexProc * = PROCEDURE { WINAPI } (VertexData: Pointer); 
  TGLUTessEndProc * = PROCEDURE { WINAPI }; 
  TGLUTessErrorProc * = PROCEDURE { WINAPI }(ErrNo: GLenum); 
  TGLUTessCombineProc * = PROCEDURE { WINAPI }(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer); 
  TGLUTessBeginDataProc * = PROCEDURE { WINAPI } (AType: GLenum; UserData: Pointer); 
  TGLUTessEdgeFlagDataProc * = PROCEDURE { WINAPI }(Flag: GLboolean; UserData: Pointer); 
  TGLUTessVertexDataProc * = PROCEDURE { WINAPI }(VertexData: Pointer; UserData: Pointer); 
  TGLUTessEndDataProc * = PROCEDURE { WINAPI }(UserData: Pointer); 
  TGLUTessErrorDataProc * = PROCEDURE { WINAPI }(ErrNo: GLenum; UserData: Pointer); 
  TGLUTessCombineDataProc * = PROCEDURE { WINAPI }(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer; UserData: Pointer); 
  (* GLUNurbsCallback *)
  TGLUNurbsErrorProc * = PROCEDURE { WINAPI } (ErrorCode: TGLenum);

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
  WGL_ARB_extensionsxstring* ,
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
  WGL_EXT_extensionsxstring* ,
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
  WIN_swap_hint* : BOOLEAN;

TYPE

  (*! GL_VERSION_1_0 *)
  TglCullFace = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglFrontFace = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglHint = PROCEDURE { WINAPI }(target: TGLenum; mode: TGLenum); 
  TglLineWidth = PROCEDURE { WINAPI }(width: TGLfloat); 
  TglPointSize = PROCEDURE { WINAPI }(size: TGLfloat); 
  TglPolygonMode = PROCEDURE { WINAPI }(face: TGLenum; mode: TGLenum); 
  TglScissor = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglTexParameterf = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexParameterfv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexParameteri = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexParameteriv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglTexImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglDrawBuffer = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglClear = PROCEDURE { WINAPI }(mask: TGLbitfield); 
  TglClearColor = PROCEDURE { WINAPI }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 
  TglClearStencil = PROCEDURE { WINAPI }(s: TGLint); 
  TglClearDepth = PROCEDURE { WINAPI }(depth: TGLclampd); 
  TglStencilMask = PROCEDURE { WINAPI }(mask: TGLuint); 
  TglColorMask = PROCEDURE { WINAPI }(red: TGLboolean; green: TGLboolean; blue: TGLboolean; alpha: TGLboolean); 
  TglDepthMask = PROCEDURE { WINAPI }(flag: TGLboolean); 
  TglDisable = PROCEDURE { WINAPI }(cap: TGLenum); 
  TglEnable = PROCEDURE { WINAPI }(cap: TGLenum); 
  TglFinish = PROCEDURE { WINAPI }(); 
  TglFlush = PROCEDURE { WINAPI }(); 
  TglBlendFunc = PROCEDURE { WINAPI }(sfactor: TGLenum; dfactor: TGLenum); 
  TglLogicOp = PROCEDURE { WINAPI }(opcode: TGLenum); 
  TglStencilFunc = PROCEDURE { WINAPI }(func: TGLenum; ref: TGLint; mask: TGLuint); 
  TglStencilOp = PROCEDURE { WINAPI }(fail: TGLenum; zfail: TGLenum; zpass: TGLenum); 
  TglDepthFunc = PROCEDURE { WINAPI }(func: TGLenum); 
  TglPixelStoref = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglPixelStorei = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglReadBuffer = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglReadPixels = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; pixels: PGLvoid); 
  TglGetBooleanv = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLboolean); 
  TglGetDoublev = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLdouble); 
  TglGetError = PROCEDURE { WINAPI }(): TGLenum; 
  TglGetFloatv = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLfloat); 
  TglGetIntegerv* = PROCEDURE { WINAPI }(pname: TGLenum; params: ADDRESS (*PGLint*)); 
  TglGetString* =  PROCEDURE { WINAPI }(name: TGLenum): ADDRESS; 
  TglGetTexImage = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; format: TGLenum; _type: TGLenum; pixels: PGLvoid); 
  TglGetTexParameteriv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexParameterfv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexLevelParameterfv = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLfloat); 
  TglGetTexLevelParameteriv = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; pname: TGLenum; params: PGLint); 
  TglIsEnabled =  PROCEDURE { WINAPI }(cap: TGLenum): TGLboolean; 
  TglDepthRange = PROCEDURE { WINAPI }(zNear: TGLclampd; zFar: TGLclampd); 
  TglViewport = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

  (*! GL_VERSION_1_1 *)
  TglDrawArrays = PROCEDURE { WINAPI }(mode: TGLenum; first: TGLint; count: TGLsizei); 
  TglDrawElements = PROCEDURE { WINAPI }(mode: TGLenum; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 
  TglGetPointerv = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLvoid); 
  TglPolygonOffset = PROCEDURE { WINAPI }(factor: TGLfloat; units: TGLfloat); 
  TglCopyTexImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalFormat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; border: TGLint); 
  TglCopyTexImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalFormat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint); 
  TglCopyTexSubImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyTexSubImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglTexSubImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglBindTexture = PROCEDURE { WINAPI }(target: TGLenum; texture: TGLuint); 
  TglDeleteTextures = PROCEDURE { WINAPI }(n: TGLsizei; CONST textures: PGLuint); 
  TglGenTextures = PROCEDURE { WINAPI }(n: TGLsizei; textures: PGLuint); 
  
(*! ifdef DEPRECATED *)
  TglAccum = PROCEDURE { WINAPI }(op: TGLenum; value: TGLfloat); 
  TglAlphaFunc = PROCEDURE { WINAPI }(func: TGLenum; ref: TGLclampf); 
  TglAreTexturesResident =  PROCEDURE { WINAPI }(n: TGLsizei; CONST textures: PGLuint; residences: PGLboolean): TGLboolean; 
  TglArrayElement = PROCEDURE { WINAPI }(i: TGLint); 
  TglBegin = PROCEDURE { WINAPI }(mode: TGLenum);
  TglBitmap = PROCEDURE { WINAPI }(width: TGLsizei; height: TGLsizei; xorig: TGLfloat; yorig: TGLfloat; xmove: TGLfloat; ymove: TGLfloat; CONST bitmap: PGLubyte); 
  TglCallList = PROCEDURE { WINAPI }(list: TGLuint); 
  TglCallLists = PROCEDURE { WINAPI }(n: TGLsizei; _type: TGLenum; CONST lists: PGLvoid); 
  TglClearAccum = PROCEDURE { WINAPI }(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); 
  TglClearIndex = PROCEDURE { WINAPI }(c: TGLfloat); 
  TglClipPlane = PROCEDURE { WINAPI }(plane: TGLenum; CONST equation: PGLdouble); 
  TglColor3b = PROCEDURE { WINAPI }(red: TGLbyte; green: TGLbyte; blue: TGLbyte); 
  TglColor3bv = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglColor3d = PROCEDURE { WINAPI }(red: TGLdouble; green: TGLdouble; blue: TGLdouble); 
  TglColor3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglColor3f = PROCEDURE { WINAPI }(red: TGLfloat; green: TGLfloat; blue: TGLfloat); 
  TglColor3fv = PROCEDURE { WINAPI }( v: ADDRESS (*PGLfloat*)); 
  TglColor3i = PROCEDURE { WINAPI }(red: TGLint; green: TGLint; blue: TGLint); 
  TglColor3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglColor3s = PROCEDURE { WINAPI }(red: TGLshort; green: TGLshort; blue: TGLshort); 
  TglColor3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglColor3ub = PROCEDURE { WINAPI }(red: TGLubyte; green: TGLubyte; blue: TGLubyte); 
  TglColor3ubv = PROCEDURE { WINAPI }(CONST v: PGLubyte); 
  TglColor3ui = PROCEDURE { WINAPI }(red: TGLuint; green: TGLuint; blue: TGLuint); 
  TglColor3uiv = PROCEDURE { WINAPI }(CONST v: PGLuint); 
  TglColor3us = PROCEDURE { WINAPI }(red: TGLushort; green: TGLushort; blue: TGLushort); 
  TglColor3usv = PROCEDURE { WINAPI }(CONST v: PGLushort); 
  TglColor4b = PROCEDURE { WINAPI }(red: TGLbyte; green: TGLbyte; blue: TGLbyte; alpha: TGLbyte); 
  TglColor4bv = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglColor4d = PROCEDURE { WINAPI }(red: TGLdouble; green: TGLdouble; blue: TGLdouble; alpha: TGLdouble); 
  TglColor4dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglColor4f = PROCEDURE { WINAPI }(red: TGLfloat; green: TGLfloat; blue: TGLfloat; alpha: TGLfloat); 
  TglColor4fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglColor4i = PROCEDURE { WINAPI }(red: TGLint; green: TGLint; blue: TGLint; alpha: TGLint); 
  TglColor4iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglColor4s = PROCEDURE { WINAPI }(red: TGLshort; green: TGLshort; blue: TGLshort; alpha: TGLshort); 
  TglColor4sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglColor4ub = PROCEDURE { WINAPI }(red: TGLubyte; green: TGLubyte; blue: TGLubyte; alpha: TGLubyte); 
  TglColor4ubv = PROCEDURE { WINAPI }(CONST v: PGLubyte); 
  TglColor4ui = PROCEDURE { WINAPI }(red: TGLuint; green: TGLuint; blue: TGLuint; alpha: TGLuint); 
  TglColor4uiv = PROCEDURE { WINAPI }(CONST v: PGLuint); 
  TglColor4us = PROCEDURE { WINAPI }(red: TGLushort; green: TGLushort; blue: TGLushort; alpha: TGLushort); 
  TglColor4usv = PROCEDURE { WINAPI }(CONST v: PGLushort); 
  TglColorMaterial = PROCEDURE { WINAPI }(face: TGLenum; mode: TGLenum); 
  TglColorPointer = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglCopyPixels = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; _type: TGLenum); 
  TglDeleteLists = PROCEDURE { WINAPI }(list: TGLuint; range: TGLsizei); 
  TglDisableClientState = PROCEDURE { WINAPI }(_array: TGLenum); 
  TglDrawPixels = PROCEDURE { WINAPI }(width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglEdgeFlag = PROCEDURE { WINAPI }(flag: TGLboolean); 
  TglEdgeFlagPointer = PROCEDURE { WINAPI }(stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglEdgeFlagv = PROCEDURE { WINAPI }(CONST flag: PGLboolean); 
  TglEnableClientState = PROCEDURE { WINAPI }(_array: TGLenum); 
  TglEnd = PROCEDURE { WINAPI }(); 
  TglEndList = PROCEDURE { WINAPI }(); 
  TglEvalCoord1d = PROCEDURE { WINAPI }(u: TGLdouble); 
  TglEvalCoord1dv = PROCEDURE { WINAPI }(CONST u: PGLdouble); 
  TglEvalCoord1f = PROCEDURE { WINAPI }(u: TGLfloat); 
  TglEvalCoord1fv = PROCEDURE { WINAPI }(CONST u: PGLfloat); 
  TglEvalCoord2d = PROCEDURE { WINAPI }(u: TGLdouble; v: TGLdouble); 
  TglEvalCoord2dv = PROCEDURE { WINAPI }(CONST u: PGLdouble); 
  TglEvalCoord2f = PROCEDURE { WINAPI }(u: TGLfloat; v: TGLfloat); 
  TglEvalCoord2fv = PROCEDURE { WINAPI }(CONST u: PGLfloat); 
  TglEvalMesh1 = PROCEDURE { WINAPI }(mode: TGLenum; i1: TGLint; i2: TGLint); 
  TglEvalMesh2 = PROCEDURE { WINAPI }(mode: TGLenum; i1: TGLint; i2: TGLint; j1: TGLint; j2: TGLint); 
  TglEvalPoint1 = PROCEDURE { WINAPI }(i: TGLint); 
  TglEvalPoint2 = PROCEDURE { WINAPI }(i: TGLint; j: TGLint); 
  TglFeedbackBuffer = PROCEDURE { WINAPI }(size: TGLsizei; _type: TGLenum; buffer: PGLfloat); 
  TglFogf = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglFogfv = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLfloat); 
  TglFogi = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglFogiv = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLint); 
  TglFrustum = PROCEDURE { WINAPI }(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; zNear: TGLdouble; zFar: TGLdouble); 
  TglGenLists =  PROCEDURE { WINAPI }(range: TGLsizei): TGLuint; 
  TglGetClipPlane = PROCEDURE { WINAPI }(plane: TGLenum; equation: PGLdouble); 
  TglGetLightfv = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetLightiv = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMapdv = PROCEDURE { WINAPI }(target: TGLenum; query: TGLenum; v: PGLdouble); 
  TglGetMapfv = PROCEDURE { WINAPI }(target: TGLenum; query: TGLenum; v: PGLfloat); 
  TglGetMapiv = PROCEDURE { WINAPI }(target: TGLenum; query: TGLenum; v: PGLint); 
  TglGetMaterialfv = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMaterialiv = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetPixelMapfv = PROCEDURE { WINAPI }(map: TGLenum; values: PGLfloat); 
  TglGetPixelMapuiv = PROCEDURE { WINAPI }(map: TGLenum; values: PGLuint); 
  TglGetPixelMapusv = PROCEDURE { WINAPI }(map: TGLenum; values: PGLushort); 
  TglGetPolygonStipple = PROCEDURE { WINAPI }(mask: PGLubyte); 
  TglGetTexEnvfv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexEnviv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexGendv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; params: PGLdouble); 
  TglGetTexGenfv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetTexGeniv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; params: PGLint); 
  TglIndexMask = PROCEDURE { WINAPI }(mask: TGLuint); 
  TglIndexPointer = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglIndexd = PROCEDURE { WINAPI }(c: TGLdouble); 
  TglIndexdv = PROCEDURE { WINAPI }(CONST c: PGLdouble); 
  TglIndexf = PROCEDURE { WINAPI }(c: TGLfloat); 
  TglIndexfv = PROCEDURE { WINAPI }(CONST c: PGLfloat); 
  TglIndexi = PROCEDURE { WINAPI }(c: TGLint); 
  TglIndexiv = PROCEDURE { WINAPI }(CONST c: PGLint); 
  TglIndexs = PROCEDURE { WINAPI }(c: TGLshort); 
  TglIndexsv = PROCEDURE { WINAPI }(CONST c: PGLshort); 
  TglIndexub = PROCEDURE { WINAPI }(c: TGLubyte); 
  TglIndexubv = PROCEDURE { WINAPI }(CONST c: PGLubyte); 
  TglInitNames = PROCEDURE { WINAPI }(); 
  TglInterleavedArrays = PROCEDURE { WINAPI }(format: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglIsList =  PROCEDURE { WINAPI } (list: TGLuint): BOOLEAN; 
  TglIsTexture =  PROCEDURE { WINAPI } (texture: TGLuint): BOOLEAN; 
  TglLightModelf = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglLightModelfv = PROCEDURE { WINAPI }(pname: TGLenum;  params: ADDRESS (*PGLfloat*)); 
  TglLightModeli = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglLightModeliv = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLint); 
  TglLightf = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglLightfv = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum;   params: ADDRESS(*GLfloat*));
  TglLighti = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum; param: TGLint); 
  TglLightiv = PROCEDURE { WINAPI }(light: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglLineStipple = PROCEDURE { WINAPI }(factor: TGLint; pattern: TGLushort); 
  TglListBase = PROCEDURE { WINAPI }(base: TGLuint); 
  TglLoadIdentity = PROCEDURE { WINAPI }(); 
  TglLoadMatrixd = PROCEDURE { WINAPI }(CONST m: PGLdouble); 
  TglLoadMatrixf = PROCEDURE { WINAPI }(CONST m: PGLfloat); 
  TglLoadName = PROCEDURE { WINAPI }(name: TGLuint); 
  TglMap1d = PROCEDURE { WINAPI }(target: TGLenum; u1: TGLdouble; u2: TGLdouble; stride: TGLint; order: TGLint; CONST points: PGLdouble); 
  TglMap1f = PROCEDURE { WINAPI }(target: TGLenum; u1: TGLfloat; u2: TGLfloat; stride: TGLint; order: TGLint; CONST points: PGLfloat); 
  TglMap2d = PROCEDURE { WINAPI }(target: TGLenum; u1: TGLdouble; u2: TGLdouble; ustride: TGLint; uorder: TGLint; v1: TGLdouble; v2: TGLdouble; vstride: TGLint; vorder: TGLint; CONST points: PGLdouble); 
  TglMap2f = PROCEDURE { WINAPI }(target: TGLenum; u1: TGLfloat; u2: TGLfloat; ustride: TGLint; uorder: TGLint; v1: TGLfloat; v2: TGLfloat; vstride: TGLint; vorder: TGLint; points: ADDRESS (*CONST points: PGLfloat*)); 
  TglMapGrid1d = PROCEDURE { WINAPI }(un: TGLint; u1: TGLdouble; u2: TGLdouble); 
  TglMapGrid1f = PROCEDURE { WINAPI }(un: TGLint; u1: TGLfloat; u2: TGLfloat); 
  TglMapGrid2d = PROCEDURE { WINAPI }(un: TGLint; u1: TGLdouble; u2: TGLdouble; vn: TGLint; v1: TGLdouble; v2: TGLdouble); 
  TglMapGrid2f = PROCEDURE { WINAPI }(un: TGLint; u1: TGLfloat; u2: TGLfloat; vn: TGLint; v1: TGLfloat; v2: TGLfloat); 
  TglMaterialf = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglMaterialfv = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum;  params:  ADDRESS(*GLfloat*)); 
  TglMateriali = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum; param: TGLint); 
  TglMaterialiv = PROCEDURE { WINAPI }(face: TGLenum; pname: TGLenum;  params: PGLint); 
  TglMatrixMode = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglMultMatrixd = PROCEDURE { WINAPI }(CONST m: PGLdouble); 
  TglMultMatrixf = PROCEDURE { WINAPI }(CONST m: PGLfloat); 
  TglNewList = PROCEDURE { WINAPI }(list: TGLuint; mode: TGLenum); 
  TglNormal3b = PROCEDURE { WINAPI }(nx: TGLbyte; ny: TGLbyte; nz: TGLbyte); 
  TglNormal3bv = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglNormal3d = PROCEDURE { WINAPI }(nx: TGLdouble; ny: TGLdouble; nz: TGLdouble); 
  TglNormal3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglNormal3f = PROCEDURE { WINAPI }(nx: TGLfloat; ny: TGLfloat; nz: TGLfloat); 
  TglNormal3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglNormal3i = PROCEDURE { WINAPI }(nx: TGLint; ny: TGLint; nz: TGLint); 
  TglNormal3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglNormal3s = PROCEDURE { WINAPI }(nx: TGLshort; ny: TGLshort; nz: TGLshort); 
  TglNormal3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglNormalPointer = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglOrtho = PROCEDURE { WINAPI }(left: TGLdouble; right: TGLdouble; bottom: TGLdouble; top: TGLdouble; zNear: TGLdouble; zFar: TGLdouble); 
  TglPassThrough = PROCEDURE { WINAPI }(token: TGLfloat); 
  TglPixelMapfv = PROCEDURE { WINAPI }(map: TGLenum; mapsize: TGLsizei; CONST values: PGLfloat); 
  TglPixelMapuiv = PROCEDURE { WINAPI }(map: TGLenum; mapsize: TGLsizei; CONST values: PGLuint); 
  TglPixelMapusv = PROCEDURE { WINAPI }(map: TGLenum; mapsize: TGLsizei; CONST values: PGLushort); 
  TglPixelTransferf = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglPixelTransferi = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglPixelZoom = PROCEDURE { WINAPI }(xfactor: TGLfloat; yfactor: TGLfloat); 
  TglPolygonStipple = PROCEDURE { WINAPI }(CONST mask: PGLubyte); 
  TglPopAttrib = PROCEDURE { WINAPI }(); 
  TglPopClientAttrib = PROCEDURE { WINAPI }(); 
  TglPopMatrix = PROCEDURE { WINAPI }(); 
  TglPopName = PROCEDURE { WINAPI }(); 
  TglPrioritizeTextures = PROCEDURE { WINAPI }(n: TGLsizei; CONST textures: PGLuint; CONST priorities: PGLclampf); 
  TglPushAttrib = PROCEDURE { WINAPI }(mask: TGLbitfield); 
  TglPushClientAttrib = PROCEDURE { WINAPI }(mask: TGLbitfield); 
  TglPushMatrix = PROCEDURE { WINAPI }(); 
  TglPushName = PROCEDURE { WINAPI }(name: TGLuint); 
  TglRasterPos2d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble); 
  TglRasterPos2dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglRasterPos2f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat); 
  TglRasterPos2fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglRasterPos2i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint); 
  TglRasterPos2iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglRasterPos2s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort); 
  TglRasterPos2sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglRasterPos3d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglRasterPos3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglRasterPos3f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglRasterPos3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglRasterPos3i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint); 
  TglRasterPos3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglRasterPos3s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglRasterPos3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglRasterPos4d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglRasterPos4dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglRasterPos4f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglRasterPos4fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglRasterPos4i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglRasterPos4iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglRasterPos4s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglRasterPos4sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglRectd = PROCEDURE { WINAPI }(x1: TGLdouble; y1: TGLdouble; x2: TGLdouble; y2: TGLdouble); 
  TglRectdv = PROCEDURE { WINAPI }(CONST v1: PGLdouble; CONST v2: PGLdouble); 
  TglRectf = PROCEDURE { WINAPI }(x1: TGLfloat; y1: TGLfloat; x2: TGLfloat; y2: TGLfloat); 
  TglRectfv = PROCEDURE { WINAPI }(CONST v1: PGLfloat; CONST v2: PGLfloat); 
  TglRecti = PROCEDURE { WINAPI }(x1: TGLint; y1: TGLint; x2: TGLint; y2: TGLint); 
  TglRectiv = PROCEDURE { WINAPI }(CONST v1: PGLint; CONST v2: PGLint); 
  TglRects = PROCEDURE { WINAPI }(x1: TGLshort; y1: TGLshort; x2: TGLshort; y2: TGLshort); 
  TglRectsv = PROCEDURE { WINAPI }(CONST v1: PGLshort; CONST v2: PGLshort); 
  TglRenderMode =  PROCEDURE { WINAPI } (mode: TGLenum): TGLint; 
  TglRotated = PROCEDURE { WINAPI }(anTgle: TGLdouble; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglRotatef = PROCEDURE { WINAPI }(anTgle: TGLfloat; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglScaled = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglScalef = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglSelectBuffer = PROCEDURE { WINAPI }(size: TGLsizei; buffer: PGLuint); 
  TglShadeModel = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglTexCoord1d = PROCEDURE { WINAPI }(s: TGLdouble); 
  TglTexCoord1dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglTexCoord1f = PROCEDURE { WINAPI }(s: TGLfloat); 
  TglTexCoord1fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglTexCoord1i = PROCEDURE { WINAPI }(s: TGLint); 
  TglTexCoord1iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglTexCoord1s = PROCEDURE { WINAPI }(s: TGLshort); 
  TglTexCoord1sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglTexCoord2d = PROCEDURE { WINAPI }(s: TGLdouble; t: TGLdouble); 
  TglTexCoord2dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglTexCoord2f = PROCEDURE { WINAPI }(s: TGLfloat; t: TGLfloat); 
  TglTexCoord2fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglTexCoord2i = PROCEDURE { WINAPI }(s: TGLint; t: TGLint); 
  TglTexCoord2iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglTexCoord2s = PROCEDURE { WINAPI }(s: TGLshort; t: TGLshort); 
  TglTexCoord2sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglTexCoord3d = PROCEDURE { WINAPI }(s: TGLdouble; t: TGLdouble; r: TGLdouble); 
  TglTexCoord3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglTexCoord3f = PROCEDURE { WINAPI }(s: TGLfloat; t: TGLfloat; r: TGLfloat); 
  TglTexCoord3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglTexCoord3i = PROCEDURE { WINAPI }(s: TGLint; t: TGLint; r: TGLint); 
  TglTexCoord3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglTexCoord3s = PROCEDURE { WINAPI }(s: TGLshort; t: TGLshort; r: TGLshort); 
  TglTexCoord3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglTexCoord4d = PROCEDURE { WINAPI }(s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); 
  TglTexCoord4dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglTexCoord4f = PROCEDURE { WINAPI }(s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); 
  TglTexCoord4fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglTexCoord4i = PROCEDURE { WINAPI }(s: TGLint; t: TGLint; r: TGLint; q: TGLint); 
  TglTexCoord4iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglTexCoord4s = PROCEDURE { WINAPI }(s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); 
  TglTexCoord4sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglTexCoordPointer = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglTexEnvf = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexEnvfv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexEnvi = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexEnviv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglTexGend = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; param: TGLdouble); 
  TglTexGendv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; CONST params: PGLdouble); 
  TglTexGenf = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglTexGenfv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglTexGeni = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; param: TGLint); 
  TglTexGeniv = PROCEDURE { WINAPI }(coord: TGLenum; pname: TGLenum; CONST params: PGLint); 


  TglTranslated = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglTranslatef = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertex2d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble); 
  TglVertex2dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglVertex2f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat); 
  TglVertex2fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglVertex2i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint); 
  TglVertex2iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglVertex2s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort); 
  TglVertex2sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglVertex3d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertex3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglVertex3f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertex3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglVertex3i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint); 
  TglVertex3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglVertex3s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertex3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglVertex4d = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertex4dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglVertex4f = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertex4fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglVertex4i = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertex4iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglVertex4s = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertex4sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglVertexPointer = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
(*! endif *)

  (*! GL_VERSION_1_2 *)
  TglBlendColor* = PROCEDURE { WINAPI }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 
  TglBlendEquation = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglDrawRangeElements = PROCEDURE { WINAPI }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 
  TglTexImage3D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage3D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglCopyTexSubImage3D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

 (*! ifdef DEPRECATED 1.2 *)
  TglColorTable = PROCEDURE {WINAPI } (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; CONST table: PGLvoid);  
  TglColorTableParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglColorTableParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglCopyColorTable = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);  
  TglGetColorTable = PROCEDURE {WINAPI }(target: GLenum; format: GLenum; _type: GLenum; table: PGLvoid);  
  TglGetColorTableParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetColorTableParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLint);  
  TglColorSubTable = PROCEDURE {WINAPI }(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; _type: GLenum; CONST data: PGLvoid);  
  TglCopyColorSubTable = PROCEDURE {WINAPI }(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);  
  TglConvolutionFilter1D = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; _type: GLenum; CONST image: PGLvoid);  
  TglConvolutionFilter2D = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; CONST image: PGLvoid);  
  TglConvolutionParameterf = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: GLfloat);  
  TglConvolutionParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglConvolutionParameteri = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: GLint);  
  TglConvolutionParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglCopyConvolutionFilter1D = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);  
  TglCopyConvolutionFilter2D = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetConvolutionFilter = PROCEDURE {WINAPI }(target: GLenum; format: GLenum; _type: GLenum; image: PGLvoid);  
  TglGetConvolutionParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetConvolutionParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLint);  
  TglGetSeparableFilter = PROCEDURE {WINAPI }(target: GLenum; format: GLenum; _type: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);  
  TglSeparableFilter2D = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; _type: GLenum; CONST row: PGLvoid; CONST column: PGLvoid);  
  TglGetHistogram = PROCEDURE {WINAPI }(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid);  
  TglGetHistogramParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetHistogramParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMinmax = PROCEDURE {WINAPI }(target: GLenum; reset: GLboolean; format: GLenum; _type: GLenum; values: PGLvoid);  
  TglGetMinmaxParameterfv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMinmaxParameteriv = PROCEDURE {WINAPI }(target: GLenum; pname: GLenum; params: PGLint);  
  TglHistogram = PROCEDURE {WINAPI }(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);  
  TglMinmax = PROCEDURE {WINAPI }(target: GLenum; internalformat: GLenum; sink: GLboolean);  
  TglResetHistogram = PROCEDURE {WINAPI }(target: GLenum);  
  TglResetMinmax = PROCEDURE {WINAPI }(target: GLenum);  
(*! endif *)
  
  (*! GL_VERSION_1_3 *)
  TglActiveTexture = PROCEDURE { WINAPI }(texture: TGLenum); 
  TglSampleCoverage = PROCEDURE { WINAPI }(value: TGLclampf; invert: TGLboolean); 
  TglCompressedTexImage3D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage3D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage2D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage1D = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglGetCompressedTexImage = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; img: PGLvoid); 

(*! ifdef DEPRECATED 1.3 *)
  TglClientActiveTexture = PROCEDURE {WINAPI }(texture: GLenum);  
  TglMultiTexCoord1d = PROCEDURE {WINAPI }(target: GLenum; s: GLdouble);  
  TglMultiTexCoord1dv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord1f = PROCEDURE {WINAPI }(target: GLenum; s: GLfloat);  
  TglMultiTexCoord1fv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord1i = PROCEDURE {WINAPI }(target: GLenum; s: GLint);  
  TglMultiTexCoord1iv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord1s = PROCEDURE {WINAPI }(target: GLenum; s: GLshort);  
  TglMultiTexCoord1sv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord2d = PROCEDURE {WINAPI }(target: GLenum; s: GLdouble; t: GLdouble);  
  TglMultiTexCoord2dv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord2f = PROCEDURE {WINAPI }(target: GLenum; s: GLfloat; t: GLfloat);  
  TglMultiTexCoord2fv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord2i = PROCEDURE {WINAPI }(target: GLenum; s: GLint; t: GLint);  
  TglMultiTexCoord2iv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord2s = PROCEDURE {WINAPI }(target: GLenum; s: GLshort; t: GLshort);  
  TglMultiTexCoord2sv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord3d = PROCEDURE {WINAPI }(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);  
  TglMultiTexCoord3dv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord3f = PROCEDURE {WINAPI }(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);  
  TglMultiTexCoord3fv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord3i = PROCEDURE {WINAPI }(target: GLenum; s: GLint; t: GLint; r: GLint);  
  TglMultiTexCoord3iv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord3s = PROCEDURE {WINAPI }(target: GLenum; s: GLshort; t: GLshort; r: GLshort);  
  TglMultiTexCoord3sv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLshort);  
  TglMultiTexCoord4d = PROCEDURE {WINAPI }(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);  
  TglMultiTexCoord4dv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLdouble);  
  TglMultiTexCoord4f = PROCEDURE {WINAPI }(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);  
  TglMultiTexCoord4fv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLfloat);  
  TglMultiTexCoord4i = PROCEDURE {WINAPI }(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);  
  TglMultiTexCoord4iv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLint);  
  TglMultiTexCoord4s = PROCEDURE {WINAPI }(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);  
  TglMultiTexCoord4sv = PROCEDURE {WINAPI }(target: GLenum; CONST v: PGLshort);  
  TglLoadTransposeMatrixf = PROCEDURE {WINAPI }(CONST m: PGLfloat);  
  TglLoadTransposeMatrixd = PROCEDURE {WINAPI }(CONST m: PGLdouble);  
  TglMultTransposeMatrixf = PROCEDURE {WINAPI }(CONST m: PGLfloat);  
  TglMultTransposeMatrixd = PROCEDURE {WINAPI }(CONST m: PGLdouble);  
(*! endif *)

  
  (*! GL_VERSION_1_4 *)
  TglBlendFuncSeparate = PROCEDURE { WINAPI }(sfactorRGB: TGLenum; dfactorRGB: TGLenum; sfactorAlpha: TGLenum; dfactorAlpha: TGLenum); 
  TglMultiDrawArrays = PROCEDURE { WINAPI }(mode: TGLenum; first: PGLint; count: PGLsizei; primcount: TGLsizei); 
  TglMultiDrawElements = PROCEDURE { WINAPI }(mode: TGLenum; CONST count: PGLsizei; _type: TGLenum; CONST indices: PGLvoid; primcount: TGLsizei); 
  TglPointParameterf = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfv = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLfloat); 
  TglPointParameteri = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglPointParameteriv = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLint); 

  (*! ifdef DEPRECATED 1.4 *)
  TglFogCoordf = PROCEDURE { WINAPI }(coord: GLfloat); 
  TglFogCoordfv = PROCEDURE { WINAPI }(CONST coord: PGLfloat); 
  TglFogCoordd = PROCEDURE { WINAPI }(coord: GLdouble); 
  TglFogCoorddv = PROCEDURE { WINAPI }(CONST coord: PGLdouble); 
  TglFogCoordPointer = PROCEDURE { WINAPI }(_type: GLenum; stride: GLsizei; CONST _pointer: PGLvoid); 
  TglSecondaryColor3b = PROCEDURE { WINAPI }(red: GLbyte; green: GLbyte; blue: GLbyte); 
  TglSecondaryColor3bv = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglSecondaryColor3d = PROCEDURE { WINAPI }(red: GLdouble; green: GLdouble; blue: GLdouble); 
  TglSecondaryColor3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglSecondaryColor3f = PROCEDURE { WINAPI }(red: GLfloat; green: GLfloat; blue: GLfloat); 
  TglSecondaryColor3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglSecondaryColor3i = PROCEDURE { WINAPI }(red: GLint; green: GLint; blue: GLint); 
  TglSecondaryColor3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglSecondaryColor3s = PROCEDURE { WINAPI }(red: GLshort; green: GLshort; blue: GLshort); 
  TglSecondaryColor3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglSecondaryColor3ub = PROCEDURE { WINAPI }(red: GLubyte; green: GLubyte; blue: GLubyte); 
  TglSecondaryColor3ubv = PROCEDURE { WINAPI }(CONST v: PGLubyte); 
  TglSecondaryColor3ui = PROCEDURE { WINAPI }(red: GLuint; green: GLuint; blue: GLuint); 
  TglSecondaryColor3uiv = PROCEDURE { WINAPI }(CONST v: PGLuint); 
  TglSecondaryColor3us = PROCEDURE { WINAPI }(red: GLushort; green: GLushort; blue: GLushort); 
  TglSecondaryColor3usv = PROCEDURE { WINAPI }(CONST v: PGLushort); 
  TglSecondaryColorPointer = PROCEDURE { WINAPI }(size: GLint; _type: GLenum; stride: GLsizei; CONST _pointer: PGLvoid); 
  TglWindowPos2d = PROCEDURE { WINAPI }(x: GLdouble; y: GLdouble); 
  TglWindowPos2dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos2f = PROCEDURE { WINAPI }(x: GLfloat; y: GLfloat); 
  TglWindowPos2fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos2i = PROCEDURE { WINAPI }(x: GLint; y: GLint); 
  TglWindowPos2iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos2s = PROCEDURE { WINAPI }(x: GLshort; y: GLshort); 
  TglWindowPos2sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglWindowPos3d = PROCEDURE { WINAPI }(x: GLdouble; y: GLdouble; z: GLdouble); 
  TglWindowPos3dv = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos3f = PROCEDURE { WINAPI }(x: GLfloat; y: GLfloat; z: GLfloat); 
  TglWindowPos3fv = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos3i = PROCEDURE { WINAPI }(x: GLint; y: GLint; z: GLint); 
  TglWindowPos3iv = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos3s = PROCEDURE { WINAPI }(x: GLshort; y: GLshort; z: GLshort); 
  TglWindowPos3sv = PROCEDURE { WINAPI }(CONST v: PGLshort); 
(*! endif *)

  (*! GL_VERSION_1_5 *)
  TglGenQueries = PROCEDURE { WINAPI }(n: GLsizei; ids: PGLuint); 
  TglDeleteQueries = PROCEDURE { WINAPI }(n: GLsizei; CONST ids: PGLuint); 
  TglIsQuery = PROCEDURE { WINAPI } (id: GLuint): BOOLEAN; 
  TglBeginQuery = PROCEDURE { WINAPI }(target: GLenum; id: GLuint); 
  TglEndQuery = PROCEDURE { WINAPI }(target: GLenum); 
  TglGetQueryiv = PROCEDURE { WINAPI }(target, pname: GLenum; params: PGLint); 
  TglGetQueryObjectiv = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLint); 
  TglGetQueryObjectuiv = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLuint); 
  TglBindBuffer = PROCEDURE { WINAPI }(target: TGLenum; buffer: TGLuint); 
  TglDeleteBuffers = PROCEDURE { WINAPI }(n: TGLsizei;  buffers: PGLuint); 
  TglGenBuffers = PROCEDURE { WINAPI }(n: TGLsizei;  buffers: PGLuint); 
  TglIsBuffer = PROCEDURE { WINAPI } (buffer: TGLuint): TGLboolean; 
  TglBufferData = PROCEDURE { WINAPI }(target: TGLenum; size: TGLsizei;  data: ADDRESS; usage: TGLenum); 
  TglBufferSubData = PROCEDURE { WINAPI }(target: TGLenum; offset: TGLsizei; size: TGLsizei; CONST data: PGLvoid); 
  TglGetBufferSubData = PROCEDURE { WINAPI }(target: TGLenum; offset: TGLsizei; size: TGLsizei; data: PGLvoid); 
  TglMapBuffer = PROCEDURE { WINAPI } (target: TGLenum; access: TGLenum): PGLvoid; 
  TglUnmapBuffer = PROCEDURE { WINAPI } (target: TGLenum): TGLboolean; 
  TglGetBufferParameteriv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetBufferPointerv = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLvoid); 

  (*! GL_VERSION_2_0 *)
  TglBlendEquationSeparate = PROCEDURE { WINAPI }(modeRGB: GLenum; modeAlpha: GLenum); 
  TglDrawBuffers = PROCEDURE { WINAPI }(n: GLsizei; CONST bufs: PGLenum); 
  TglStencilOpSeparate = PROCEDURE { WINAPI }(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum); 
  TglStencilFuncSeparate = PROCEDURE { WINAPI }(frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint); 
  TglStencilMaskSeparate = PROCEDURE { WINAPI }(face: GLenum; mask: GLuint); 
  TglAttachShader = PROCEDURE { WINAPI }(programObj, shaderObj: GLHandle); 
  TglBindAttribLocation = PROCEDURE { WINAPI }(programObj: GLHandle; index: GLuint; name: PGLchar); 
  TglCompileShader = PROCEDURE { WINAPI }(shaderObj: GLHandle); 
  TglCreateProgram = PROCEDURE { WINAPI }(): GLHandle; 
  TglCreateShader = PROCEDURE { WINAPI } (shaderType: GLenum): GLHandle; 
  TglDeleteProgram = PROCEDURE { WINAPI }(programObj: GLHandle); 
  TglDeleteShader = PROCEDURE { WINAPI }(shaderObj: GLHandle); 
  TglDetachShader = PROCEDURE { WINAPI }(programObj, shaderObj: GLHandle); 
  TglDisableVertexAttribArray = PROCEDURE { WINAPI }(index: GLuint); 
  TglEnableVertexAttribArray = PROCEDURE { WINAPI }(index: GLuint); 
  TglGetActiveAttrib = PROCEDURE { WINAPI }(programObj: GLHandle; index: GLuint; maxlength: GLsizei; VAR length: GLint; VAR size: GLint; VAR _type: GLenum; name: PGLchar); 
  TglGetActiveUniform = PROCEDURE { WINAPI }(programObj: GLHandle; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLchar); 
  TglGetAttachedShaders = PROCEDURE { WINAPI }(programObj: GLHandle; MaxCount: GLsizei; VAR Count: GLint; shaders: PGLuint); 
  TglGetAttribLocation = PROCEDURE { WINAPI } (programObj: GLHandle; CONST chars: ARRAY OF CHAR): GLint; 
  TglGetProgramiv = PROCEDURE { WINAPI }(programObj: GLHandle; pname: TGLenum; params: PGLint); 
  TglGetProgramInfoLog = PROCEDURE { WINAPI }(programObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: ADDRESS(* PGLchar *)); 
  TglGetShaderiv = PROCEDURE { WINAPI }(shaderObj: GLHandle; pname: TGLenum; params: PGLint); 
  TglGetShaderInfoLog = PROCEDURE { WINAPI }(shaderObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: ADDRESS(* PGLchar *)); 
  TglGetShaderSource = PROCEDURE { WINAPI }(shaderObj: GLHandle; maxlength: GLsizei; VAR length: GLsizei; source: PGLchar); 
  TglGetUniformLocation = PROCEDURE { WINAPI } (programObj: GLHandle; CONST chars: ARRAY OF CHAR): GLint; 
  TglGetUniformfv = PROCEDURE { WINAPI }(programObj: GLHandle; location: GLint; params: PGLfloat); 
  TglGetUniformiv = PROCEDURE { WINAPI }(programObj: GLHandle; location: GLint; params: PGLint); 
  TglGetVertexAttribfv = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetVertexAttribiv = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLint); 
  TglGetVertexAttribPointerv = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; _pointer: PGLvoid); 
  TglIsProgram = PROCEDURE { WINAPI } (programObj: GLHandle) : TGLboolean; 
  TglIsShader = PROCEDURE { WINAPI } (shaderObj: GLHandle) : TGLboolean; 
  TglLinkProgram = PROCEDURE { WINAPI }(programObj: GLHandle); 
  TglShaderSource = PROCEDURE { WINAPI }(shaderObj: GLHandle; count: GLsizei; xstring: ADDRESS(* PPGLchar *); lengths: PGLint); 
  TglUseProgram = PROCEDURE { WINAPI }(programObj: GLHandle); 
  TglUniform1f = PROCEDURE { WINAPI }(location: GLint; v0: GLfloat); 
  TglUniform2f = PROCEDURE { WINAPI }(location: GLint; v0, v1: GLfloat); 
  TglUniform3f = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2: GLfloat); 
  TglUniform4f = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2, v3: GLfloat); 
  TglUniform1i = PROCEDURE { WINAPI }(location: GLint; v0: GLint); 
  TglUniform2i = PROCEDURE { WINAPI }(location: GLint; v0, v1: GLint); 
  TglUniform3i = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2: GLint); 
  TglUniform4i = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2, v3: GLint); 
  TglUniform1fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform2fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform3fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform4fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform1iv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform2iv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform3iv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform4iv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniformMatrix2fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglValidateProgram = PROCEDURE { WINAPI }(programObj: GLHandle); 
  TglVertexAttrib1d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble); 
  TglVertexAttrib1dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib1f = PROCEDURE { WINAPI }(index: GLuint; x: GLfloat); 
  TglVertexAttrib1fv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib1s = PROCEDURE { WINAPI }(index: GLuint; x: GLshort); 
  TglVertexAttrib1sv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib2d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble); 
  TglVertexAttrib2dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib2f = PROCEDURE { WINAPI }(index: GLuint; x: GLfloat; y: GLfloat); 
  TglVertexAttrib2fv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib2s = PROCEDURE { WINAPI }(index: GLuint; x: GLshort; y: GLshort); 
  TglVertexAttrib2sv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib3d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglVertexAttrib3dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib3f = PROCEDURE { WINAPI }(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat); 
  TglVertexAttrib3fv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib3s = PROCEDURE { WINAPI }(index: GLuint; x: GLshort; y: GLshort; z: GLshort); 
  TglVertexAttrib3sv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4Nbv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLbyte); 
  TglVertexAttrib4Niv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint); 
  TglVertexAttrib4Nsv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4Nub = PROCEDURE { WINAPI }(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte); 
  TglVertexAttrib4Nubv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLubyte); 
  TglVertexAttrib4Nuiv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint); 
  TglVertexAttrib4Nusv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLushort); 
  TglVertexAttrib4bv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLbyte); 
  TglVertexAttrib4d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglVertexAttrib4dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttrib4f = PROCEDURE { WINAPI }(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat); 
  TglVertexAttrib4fv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLfloat); 
  TglVertexAttrib4iv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint); 
  TglVertexAttrib4s = PROCEDURE { WINAPI }(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort); 
  TglVertexAttrib4sv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLubyte); 
  TglVertexAttrib4uiv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint); 
  TglVertexAttrib4usv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLushort); 
  TglVertexAttribPointer = PROCEDURE { WINAPI }(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei; CONST _pointer: PGLvoid); 

  (*! GL_VERSION_2_1 *)
  TglUniformMatrix2x3fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3x2fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix2x4fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4x2fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3x4fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4x3fv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 

  (*! GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions: 
   ARB_framebuffer_object 
   ARB_map_buffer_range 
   ARB_vertex_array_object  *)
  TglColorMaski = PROCEDURE { WINAPI }(index_: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean); 
  TglGetBooleani_v = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PGLboolean); 
  TglGetIntegeri_v = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PGLint); 
  TglEnablei = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint); 
  TglDisablei = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint); 
  TglIsEnabledi = PROCEDURE { WINAPI } (target: GLenum; index_: GLuint): GLboolean; 
  TglBeginTransformFeedback = PROCEDURE { WINAPI }(primitiveMode: GLenum); 
  TglEndTransformFeedback = PROCEDURE { WINAPI }(); 
  TglBindBufferRange = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei); 
  TglBindBufferBase = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryings = PROCEDURE { WINAPI }(program_: GLuint; count: GLsizei; CONST varyings: PPGLchar; bufferMode: GLenum); 
  TglGetTransformFeedbackVarying = PROCEDURE { WINAPI }(program_: GLuint; index_: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; type_: PGLsizei; name: PGLchar); 
  TglClampColor = PROCEDURE { WINAPI }(targe: GLenum; clamp: GLenum); 
  TglBeginConditionalRender = PROCEDURE { WINAPI }(id: GLuint; mode: GLenum); 
  TglEndConditionalRender = PROCEDURE { WINAPI }(); 
  TglVertexAttribIPointer = PROCEDURE { WINAPI }(index_: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid); 
  TglGetVertexAttribIiv = PROCEDURE { WINAPI }(index_: GLuint; pname: GLenum; params: PGLint); 
  TglGetVertexAttribIuiv = PROCEDURE { WINAPI }(index_: GLuint; pname: GLenum; params: PGLuint); 
  TglVertexAttribI1i = PROCEDURE { WINAPI }(index_: GLuint; x: GLint); 
  TglVertexAttribI2i = PROCEDURE { WINAPI }(index_: GLuint; x: GLint; y: GLint); 
  TglVertexAttribI3i = PROCEDURE { WINAPI }(index_: GLuint; x: GLint; y: GLint; z: GLint); 
  TglVertexAttribI4i = PROCEDURE { WINAPI }(index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint); 
  TglVertexAttribI1ui = PROCEDURE { WINAPI }(index_: GLuint; x: GLuint); 
  TglVertexAttribI2ui = PROCEDURE { WINAPI }(index_: GLuint; x: GLuint; y: GLuint); 
  TglVertexAttribI3ui = PROCEDURE { WINAPI }(index_: GLuint; x: GLuint; y: GLuint; z: GLuint); 
  TglVertexAttribI4ui = PROCEDURE { WINAPI }(index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint); 
  TglVertexAttribI1iv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI2iv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI3iv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI4iv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLint); 
  TglVertexAttribI1uiv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI2uiv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI3uiv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI4uiv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLuint); 
  TglVertexAttribI4bv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLbyte); 
  TglVertexAttribI4sv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLshort); 
  TglVertexAttribI4ubv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLubyte); 
  TglVertexAttribI4usv = PROCEDURE { WINAPI }(index_: GLuint; CONST v: PGLushort); 
  TglGetUniformuiv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; params: PGLuint); 
  TglBindFragDataLocation = PROCEDURE { WINAPI }(program_: GLuint; color: GLuint; CONST name: ARRAY OF CHAR); 
  TglGetFragDataLocation = PROCEDURE { WINAPI } (program_: GLuint; CONST name: PGLchar): GLint; 
  TglUniform1ui = PROCEDURE { WINAPI }(location: GLint; v0: GLuint); 
  TglUniform2ui = PROCEDURE { WINAPI }(location: GLint; v0: GLuint; v1: GLuint); 
  TglUniform3ui = PROCEDURE { WINAPI }(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); 
  TglUniform4ui = PROCEDURE { WINAPI }(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); 
  TglUniform1uiv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform2uiv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform3uiv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglUniform4uiv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglTexParameterIiv = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLint); 
  TglTexParameterIuiv = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; CONST params: PGLuint); 
  TglGetTexParameterIiv = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; params: PGLint); 
  TglGetTexParameterIuiv = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; params: PGLuint); 
  TglClearBufferiv = PROCEDURE { WINAPI }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLint); 
  TglClearBufferuiv = PROCEDURE { WINAPI }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLuint); 
  TglClearBufferfv = PROCEDURE { WINAPI }(buffer: GLenum; drawbuffer: GLint; CONST value: PGLfloat); 
  TglClearBufferfi = PROCEDURE { WINAPI }(buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint); 
  TglGetStringi = PROCEDURE { WINAPI } (name: GLenum; index: GLuint): PGLubyte; 

  (*! GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions: 
   ARB_copy_buffer 
   ARB_uniform_buffer_object  *)
  TglDrawArraysInstanced = PROCEDURE { WINAPI }(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); 
  TglDrawElementsInstanced = PROCEDURE { WINAPI }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei); 
  TglTexBuffer = PROCEDURE { WINAPI }(target: GLenum; internalformat: GLenum; buffer: GLuint); 
  TglPrimitiveRestartIndex = PROCEDURE { WINAPI }(index_: GLuint); 

  (*! GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions: 
   ARB_draw_elements_base_vertex 
   ARB_provoking_vertex 
   ARB_sync 
   ARB_texture_multisample  *)
  TglGetInteger64i_v = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PGLint64); 
  TglGetBufferParameteri64v = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; params: PGLint64); 
  TglFramebufferTexture = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTextureFace = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); 
  
 
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
  TglVertexAttribDivisor = PROCEDURE { WINAPI } (index: GLuint; divisor: GLuint); 
 
 
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
  TglMinSampleShading = PROCEDURE {WINAPI }(value: GLclampf); 
  TglBlendEquationi = PROCEDURE {WINAPI }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparatei = PROCEDURE {WINAPI }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 
  TglBlendFunci = PROCEDURE {WINAPI }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparatei = PROCEDURE {WINAPI }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 

  (*! GL_VERSION_4_1 *)
  (* OpenGL 4.1 also reuses entry points from these extensions: *)
  (* ARB_ES2_compatibility *)
  (* ARB_get_program_binary *)
  (* ARB_separate_shader_objects *)
  (* ARB_shader_precision (no entry points) *)
  (* ARB_vertex_attrib_64bit *)
  (* ARB_viewport_array *)

   
 (* GL_3DFX_tbuffer *)
  TglTbufferMask3DFX = PROCEDURE { WINAPI }(mask: TGLuint); 


  (* GL_ARB_matrix_palette *)
  TglCurrentPaletteMatrixARB = PROCEDURE { WINAPI }(index: TGLint); 
  TglMatrixIndexubvARB = PROCEDURE { WINAPI }(size: TGLint; CONST indices: PGLubyte); 
  TglMatrixIndexusvARB = PROCEDURE { WINAPI }(size: TGLint; CONST indices: PGLushort); 
  TglMatrixIndexuivARB = PROCEDURE { WINAPI }(size: TGLint; CONST indices: PGLuint); 
  TglMatrixIndexPointerARB = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_ARB_multisample *)
  TglSampleCoverageARB = PROCEDURE { WINAPI }(value: TGLclampf; invert: TGLboolean); 

  (* GL_ARB_multitexture *)
  TglActiveTextureARB = PROCEDURE { WINAPI }(texture: TGLenum); 
  TglClientActiveTextureARB = PROCEDURE { WINAPI }(texture: TGLenum); 
  TglMultiTexCoord1dARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLdouble); 
  TglMultiTexCoord1dvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord1fARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLfloat); 
  TglMultiTexCoord1fvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord1iARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLint); 
  TglMultiTexCoord1ivARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord1sARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLshort); 
  TglMultiTexCoord1svARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord2dARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLdouble; t: TGLdouble); 
  TglMultiTexCoord2dvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord2fARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLfloat; t: TGLfloat); 
  TglMultiTexCoord2fvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord2iARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLint; t: TGLint); 
  TglMultiTexCoord2ivARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord2sARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLshort; t: TGLshort); 
  TglMultiTexCoord2svARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord3dARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble); 
  TglMultiTexCoord3dvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord3fARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat); 
  TglMultiTexCoord3fvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord3iARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLint; t: TGLint; r: TGLint); 
  TglMultiTexCoord3ivARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord3sARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort); 
  TglMultiTexCoord3svARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLshort); 
  TglMultiTexCoord4dARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLdouble; t: TGLdouble; r: TGLdouble; q: TGLdouble); 
  TglMultiTexCoord4dvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLdouble); 
  TglMultiTexCoord4fARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLfloat; t: TGLfloat; r: TGLfloat; q: TGLfloat); 
  TglMultiTexCoord4fvARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLfloat); 
  TglMultiTexCoord4iARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLint; t: TGLint; r: TGLint; q: TGLint); 
  TglMultiTexCoord4ivARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLint); 
  TglMultiTexCoord4sARB = PROCEDURE { WINAPI }(target: TGLenum; s: TGLshort; t: TGLshort; r: TGLshort; q: TGLshort); 
  TglMultiTexCoord4svARB = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLshort); 

  (* GL_ARB_point_parameters *)
  TglPointParameterfARB = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfvARB = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLfloat); 

  (* GL_ARB_texture_compression *)
  TglCompressedTexImage3DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage2DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexImage1DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; border: TGLint; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage3DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage2DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglCompressedTexSubImage1DARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; imageSize: TGLsizei; CONST data: PGLvoid); 
  TglGetCompressedTexImageARB = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; img: PGLvoid); 

  (* GL_ARB_transpose_matrix *)
  TglLoadTransposeMatrixfARB = PROCEDURE { WINAPI }(CONST m: PGLfloat); 
  TglLoadTransposeMatrixdARB = PROCEDURE { WINAPI }(CONST m: PGLdouble); 
  TglMultTransposeMatrixfARB = PROCEDURE { WINAPI }(CONST m: PGLfloat); 
  TglMultTransposeMatrixdARB = PROCEDURE { WINAPI }(CONST m: PGLdouble); 

  (* GL_ARB_vertex_blend *)
  TglWeightbvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLbyte); 
  TglWeightsvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLshort); 
  TglWeightivARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLint); 
  TglWeightfvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLfloat); 
  TglWeightdvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLdouble); 
  TglWeightubvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLubyte); 
  TglWeightusvARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLushort); 
  TglWeightuivARB = PROCEDURE { WINAPI }(size: TGLint; CONST weights: PGLuint); 
  TglWeightPointerARB = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexBlendARB = PROCEDURE { WINAPI }(count: TGLint); 

  (* GL_ARB_vertex_buffer_object *)
  TglBindBufferARB = PROCEDURE { WINAPI }(target: TGLenum; buffer: TGLuint); 
  TglDeleteBuffersARB = PROCEDURE { WINAPI }(n: TGLsizei; CONST buffers: PGLuint); 
  TglGenBuffersARB = PROCEDURE { WINAPI }(n: TGLsizei; buffers: ADDRESS (*PGLuint*)); 
  TglIsBufferARB = PROCEDURE { WINAPI } (buffer: TGLuint): TGLboolean; 
  TglBufferDataARB = PROCEDURE { WINAPI }(target: TGLenum; size: TGLsizei; CONST data: PGLvoid; usage: TGLenum); 
  TglBufferSubDataARB = PROCEDURE { WINAPI }(target: TGLenum; offset: TGLsizei; size: TGLsizei; CONST data: PGLvoid); 
  TglGetBufferSubDataARB = PROCEDURE { WINAPI }(target: TGLenum; offset: TGLsizei; size: TGLsizei; data: PGLvoid); 
  TglMapBufferARB = PROCEDURE { WINAPI } (target: TGLenum; access: TGLenum): PGLvoid; 
  TglUnmapBufferARB = PROCEDURE { WINAPI }( target: TGLenum): TGLboolean; 
  TglGetBufferParameterivARB = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetBufferPointervARB = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLvoid); 

  (* GL_ARB_vertex_program *)
  TglVertexAttrib1dARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble); 
  TglVertexAttrib1dvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib1fARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat); 
  TglVertexAttrib1fvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib1sARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort); 
  TglVertexAttrib1svARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib2dARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble); 
  TglVertexAttrib2dvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib2fARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat); 
  TglVertexAttrib2fvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib2sARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort); 
  TglVertexAttrib2svARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib3dARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexAttrib3dvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib3fARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexAttrib3fvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib3sARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexAttrib3svARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4NbvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttrib4NivARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttrib4NsvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4NubARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLubyte; y: TGLubyte; z: TGLubyte; w: TGLubyte); 
  TglVertexAttrib4NubvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttrib4NuivARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttrib4NusvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttrib4bvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttrib4dARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexAttrib4dvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib4fARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexAttrib4fvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib4ivARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttrib4sARB = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexAttrib4svARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttrib4uivARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttrib4usvARB = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttribPointerARB = PROCEDURE { WINAPI }(index: TGLuint; size: TGLint; _type: TGLenum; normalized: TGLboolean; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglEnableVertexAttribArrayARB = PROCEDURE { WINAPI }(index: TGLuint); 
  TglDisableVertexAttribArrayARB = PROCEDURE { WINAPI }(index: TGLuint); 
  TglProgramStringARB = PROCEDURE { WINAPI }(target: TGLenum; format: TGLenum; len: TGLsizei; CONST xstring: PGLvoid); 
  TglBindProgramARB = PROCEDURE { WINAPI }(target: TGLenum; _program: TGLuint); 
  TglDeleteProgramsARB = PROCEDURE { WINAPI }(n: TGLsizei; CONST programs: PGLuint); 
  TglGenProgramsARB = PROCEDURE { WINAPI }(n: TGLsizei; programs: PGLuint); 
  TglProgramEnvParameter4dARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramEnvParameter4dvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLdouble); 
  TglProgramEnvParameter4fARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramEnvParameter4fvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLfloat); 
  TglProgramLocalParameter4dARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramLocalParameter4dvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLdouble); 
  TglProgramLocalParameter4fARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramLocalParameter4fvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLfloat); 
  TglGetProgramEnvParameterdvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLdouble); 
  TglGetProgramEnvParameterfvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLfloat); 
  TglGetProgramLocalParameterdvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLdouble); 
  TglGetProgramLocalParameterfvARB = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLfloat); 
  TglGetProgramivARB = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetProgramStringARB = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; xstring: PGLvoid); 
  TglGetVertexAttribdvARB = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetVertexAttribfvARB = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribivARB = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribPointervARB = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; _pointer: PGLvoid); 
  TglIsProgramARB = PROCEDURE { WINAPI } (_program: TGLuint): TGLboolean; 

  (* GL_ARB_window_pos *)
  TglWindowPos2dARB = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble); 
  TglWindowPos2dvARB = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos2fARB = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat); 
  TglWindowPos2fvARB = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos2iARB = PROCEDURE { WINAPI }(x: TGLint; y: TGLint); 
  TglWindowPos2ivARB = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos2sARB = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort); 
  TglWindowPos2svARB = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglWindowPos3dARB = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglWindowPos3dvARB = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos3fARB = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglWindowPos3fvARB = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos3iARB = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint); 
  TglWindowPos3ivARB = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos3sARB = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglWindowPos3svARB = PROCEDURE { WINAPI }(CONST v: PGLshort); 

  (* GL_ARB_draw_buffers *)
  TglDrawBuffersARB = PROCEDURE { WINAPI }(n: TGLsizei; bufs: PGLenum); 

  (* GL_ARB_color_buffer_float *)
  TglClampColorARB = PROCEDURE { WINAPI }(target: TGLenum; clamp: TGLenum); 

  (* GL_ARB_vertex_shader *)
  TglGetActiveAttribARB = PROCEDURE { WINAPI }(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLcharARB); 
  TglGetAttribLocationARB = PROCEDURE { WINAPI } (programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint; 
  TglBindAttribLocationARB = PROCEDURE { WINAPI }(programObj: GLHandleARB; index: GLuint; CONST name: PGLcharARB); 

  (* GL_ARB_shader_objects *)
  TglDeleteObjectARB = PROCEDURE { WINAPI }(Obj: GLHandleARB); 
  TglGetHandleARB = PROCEDURE { WINAPI } (pname: GLenum): GLHandleARB; 
  TglDetachObjectARB = PROCEDURE { WINAPI }(container, attached: GLHandleARB); 
  TglCreateShaderObjectARB = PROCEDURE { WINAPI } (shaderType: GLenum): GLHandleARB; 
  TglShaderSourceARB = PROCEDURE { WINAPI }(shaderObj: GLHandleARB; count: GLsizei; xstring: ADDRESS (*PPGLcharARB*); lengths: PGLint); 
  TglCompileShaderARB = PROCEDURE { WINAPI }(shaderObj: GLHandleARB); 
  TglCreateProgramObjectARB = PROCEDURE { WINAPI }(): GLHandleARB; 
  TglAttachObjectARB = PROCEDURE { WINAPI }(programObj, shaderObj: GLHandleARB); 
  TglLinkProgramARB = PROCEDURE { WINAPI }(programObj: GLHandleARB); 
  TglUseProgramObjectARB = PROCEDURE { WINAPI }(programObj: GLHandleARB); 
  TglValidateProgramARB = PROCEDURE { WINAPI }(programObj: GLHandleARB); 
  TglUniform1fARB = PROCEDURE { WINAPI }(location: GLint; v0: GLfloat); 
  TglUniform2fARB = PROCEDURE { WINAPI }(location: GLint; v0, v1: GLfloat); 
  TglUniform3fARB = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2: GLfloat); 
  TglUniform4fARB = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2, v3: GLfloat); 
  TglUniform1iARB = PROCEDURE { WINAPI }(location: GLint; v0: GLint); 
  TglUniform2iARB = PROCEDURE { WINAPI }(location: GLint; v0, v1: GLint); 
  TglUniform3iARB = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2: GLint); 
  TglUniform4iARB = PROCEDURE { WINAPI }(location: GLint; v0, v1, v2, v3: GLint); 
  TglUniform1fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform2fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform3fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform4fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLfloat); 
  TglUniform1ivARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform2ivARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform3ivARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniform4ivARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; value: PGLint); 
  TglUniformMatrix2fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix3fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglUniformMatrix4fvARB = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat); 
  TglGetObjectParameterfvARB = PROCEDURE { WINAPI }(Obj: GLHandleARB; pname: GLenum; params: PGLfloat); 
  TglGetObjectParameterivARB = PROCEDURE { WINAPI }(Obj: GLHandleARB; pname: GLenum; params: PGLint); 
  TglGetInfoLogARB = PROCEDURE { WINAPI }(shaderObj: GLHandleARB; maxLength: GLsizei; VAR length: GLint; infoLog: ADDRESS (*PGLcharARB*)); 
  TglGetAttachedObjectsARB = PROCEDURE { WINAPI }(programobj: GLHandleARB; maxCount: GLsizei; VAR count: GLsizei; objects: PGLHandleARB); 
  TglGetUniformLocationARB = PROCEDURE { WINAPI } (programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint; 
  TglGetActiveUniformARB = PROCEDURE { WINAPI }(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR _type: GLenum; name: PGLcharARB); 
  TglGetUniformfvARB = PROCEDURE { WINAPI }(programObj: GLHandleARB; location: GLint; params: PGLfloat); 
  TglGetUniformivARB = PROCEDURE { WINAPI }(programObj: GLHandleARB; location: GLint; params: PGLint); 
  TglGetShaderSourceARB = PROCEDURE { WINAPI }(shader: GLHandleARB; maxLength: GLsizei; VAR length: GLsizei; source: PGLcharARB); 

  (* GL_ARB_Occlusion_Query *)
  TglGenQueriesARB = PROCEDURE { WINAPI }(n: GLsizei; ids: PGLuint); 
  TglDeleteQueriesARB = PROCEDURE { WINAPI }(n: GLsizei; CONST ids: PGLuint); 
  TglIsQueryARB = PROCEDURE { WINAPI } (id: GLuint): BOOLEAN; 
  TglBeginQueryARB = PROCEDURE { WINAPI }(target: GLenum; id: GLuint); 
  TglEndQueryARB = PROCEDURE { WINAPI }(target: GLenum); 
  TglGetQueryivARB = PROCEDURE { WINAPI }(target, pname: GLenum; params: PGLint); 
  TglGetQueryObjectivARB = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLint); 
  TglGetQueryObjectuivARB = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLuint); 

  (* GL_ARB_draw_instanced *)
  TglDrawArraysInstancedARB = PROCEDURE { WINAPI }(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei); 
  TglDrawElementsInstancedARB = PROCEDURE { WINAPI }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei); 

  (* GL_ARB_framebuffer_object *)
  TglIsRenderbuffer = PROCEDURE { WINAPI } (renderbuffer: GLuint): GLboolean; 
  TglBindRenderbuffer = PROCEDURE { WINAPI }(target: GLenum; renderbuffer: GLuint); 
  TglDeleteRenderbuffers = PROCEDURE { WINAPI }(n: GLsizei; CONST renderbuffers: PGLuint); 
  TglGenRenderbuffers = PROCEDURE { WINAPI }(n: GLsizei; renderbuffers: PGLuint); 
  TglRenderbufferStorage = PROCEDURE { WINAPI }(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei); 
  TglGetRenderbufferParameteriv = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; params: PGLint); 
  TglIsFramebuffer = PROCEDURE { WINAPI } (framebuffer: GLuint): GLboolean; 
  TglBindFramebuffer = PROCEDURE { WINAPI }(target: GLenum; framebuffer: GLuint); 
  TglDeleteFramebuffers = PROCEDURE { WINAPI }(n: GLsizei; CONST framebuffers: PGLuint); 
  TglGenFramebuffers = PROCEDURE { WINAPI }(n: GLsizei; framebuffers: PGLuint); 
  TglCheckFramebufferStatus = PROCEDURE { WINAPI } (target: GLenum): GLenum; 
  TglFramebufferTexture1D = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTexture2D = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTexture3D = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint); 
  TglFramebufferRenderbuffer = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint); 
  TglGetFramebufferAttachmentParameteriv = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint); 
  TglGenerateMipmap = PROCEDURE { WINAPI }(target: GLenum); 
  TglBlitFramebuffer = PROCEDURE { WINAPI }(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); 
  TglRenderbufferStorageMultisample = PROCEDURE { WINAPI }(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei); 
  TglFramebufferTextureLayer = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); 

  (* GL_ARB_geometry_shader4 *)
  TglProgramParameteriARB = PROCEDURE { WINAPI }(program_: GLuint; pname: GLenum; value: GLint); 
  TglFramebufferTextureARB = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint); 
  TglFramebufferTextureLayerARB = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint); 
  TglFramebufferTextureFaceARB = PROCEDURE { WINAPI }(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); 

  (* GL_ARB_instanced_arrays *)
  TglVertexAttribDivisorARB = PROCEDURE { WINAPI }(index_: GLuint; divisor: GLuint); 

  (* GL_ARB_map_buffer_range *)
  TglMapBufferRange = PROCEDURE { WINAPI } (target: GLenum; offset: GLsizei; length: GLsizei; access: GLbitfield): PGLvoid; 
  TglFlushMappedBufferRange = PROCEDURE { WINAPI }(target: GLenum; offset: GLsizei; length: GLsizei); 

  (* GL_ARB_texture_buffer_object *)
  TglTexBufferARB = PROCEDURE { WINAPI }(target: GLenum; internalformat: GLenum; buffer: GLuint); 

  (* GL_ARB_vertex_array_object *)
  TglBindVertexArray = PROCEDURE { WINAPI }(array_: GLuint); 
  TglDeleteVertexArrays = PROCEDURE { WINAPI }(n: GLsizei; CONST arrays: PGLuint); 
  TglGenVertexArrays = PROCEDURE { WINAPI }(n: GLsizei; arrays: PGLuint); 
  TglIsVertexArray = PROCEDURE { WINAPI } (array_: GLuint): GLboolean; 

  (* GL_ARB_uniform_buffer_object *)
  TglGetUniformIndices = PROCEDURE { WINAPI }(program_: GLuint; uniformCount: GLsizei; CONST uniformNames: PPGLchar; uniformIndices: PGLuint); 
  TglGetActiveUniformsiv = PROCEDURE { WINAPI }(program_: GLuint; uniformCount: GLsizei; CONST uniformIndices: PGLuint; pname: GLenum; params: PGLint); 
  TglGetActiveUniformName = PROCEDURE { WINAPI }(program_: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar); 
  TglGetUniformBlockIndex = PROCEDURE { WINAPI } (program_: GLuint; CONST uniformBlockName: PGLchar): GLuint; 
  TglGetActiveUniformBlockiv = PROCEDURE { WINAPI }(program_: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint); 
  TglGetActiveUniformBlockName = PROCEDURE { WINAPI }(program_: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar); 
  TglUniformBlockBinding = PROCEDURE { WINAPI }(program_: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint); 

  (* GL_ARB_copy_buffer *)
  TglCopyBufferSubData = PROCEDURE { WINAPI }(readTarget: GLenum; writeTarget: GLenum; readOffset: GLint; writeOffset: GLint; size: GLsizei); 

  (* GL_ARB_draw_elements_base_vertex *)
  TglDrawElementsBaseVertex = PROCEDURE { WINAPI }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; basevertex: GLint); 
  TglDrawRangeElementsBaseVertex = PROCEDURE { WINAPI }(mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; basevertex: GLint); 
  TglDrawElementsInstancedBaseVertex = PROCEDURE { WINAPI }(mode: GLenum; count: GLsizei; type_: GLenum; CONST indices: PGLvoid; primcount: GLsizei; basevertex: GLint); 
  TglMultiDrawElementsBaseVertex = PROCEDURE { WINAPI }(mode: GLenum; CONST count: PGLsizei; type_: GLenum; CONST indices: PPGLvoid; primcount: GLsizei; CONST basevertex: PGLint); 

  (* GL_ARB_provoking_vertex *)
  TglProvokingVertex = PROCEDURE { WINAPI }(mode: GLenum); 

  (* GL_ARB_sync *)
  TglFenceSync = PROCEDURE { WINAPI } (condition: GLenum; flags: GLbitfield): GLsync; 
  TglIsSync = PROCEDURE { WINAPI } (sync: GLsync): GLboolean; 
  TglDeleteSync = PROCEDURE { WINAPI }(sync: GLsync); 
  TglClientWaitSync = PROCEDURE { WINAPI } (sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum; 
  TglWaitSync = PROCEDURE { WINAPI }(sync: GLsync; flags: GLbitfield; timeout: GLuint64); 
  TglGetInteger64v = PROCEDURE { WINAPI }(pname: GLenum; params: PGLint64); 
  TglGetSynciv = PROCEDURE { WINAPI }(sync: GLsync; pname: GLenum; butSize: GLsizei; length: PGLsizei; values: PGLint); 

  (* GL_ARB_texture_multisample *)
  TglTexImage2DMultisample = PROCEDURE { WINAPI }(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean); 
  TglTexImage3DMultisample = PROCEDURE { WINAPI }(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean); 
  TglGetMultisamplefv = PROCEDURE { WINAPI }(pname: GLenum; index_: GLuint; val: PGLfloat); 
  TglSampleMaski = PROCEDURE { WINAPI }(index_: GLuint; mask: GLbitfield); 

  (* GL_ARB_draw_buffers_blend *)
  TglBlendEquationiARB = PROCEDURE { WINAPI }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparateiARB = PROCEDURE { WINAPI }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 
  TglBlendFunciARB = PROCEDURE { WINAPI }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparateiARB = PROCEDURE { WINAPI }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 

  (* GL_ARB_sample_shading *)
  TglMinSampleShadingARB = PROCEDURE { WINAPI }(value: GLclampf); 
 
    (*  GL_ARB_shading_language_include *)
  TglNamedStringARB = PROCEDURE { WINAPI }(type_: GLenum; namelen: GLint; CONST name: PGLchar; stringlen: GLint; CONST string_: PGLchar); 
  TglDeleteNamedStringARB = PROCEDURE { WINAPI }(namelen: GLint; CONST name: PGLchar); 
  TglCompileShaderIncludeARB = PROCEDURE { WINAPI } (shader: GLuint; count: GLsizei; CONST path: PPGLchar; CONST length: PGLint); 
  TglIsNamedStringARB = PROCEDURE { WINAPI }(namelen: GLint; CONST name: PGLchar): GLboolean; 
  TglGetNamedStringARB = PROCEDURE { WINAPI }(namelen: GLint; CONST name: PGLchar; bufSize: GLsizei; stringlen: GLint; string_: PGLchar); 
  TglGetNamedStringivARB = PROCEDURE { WINAPI }(namelen: GLint; CONST name: PGLchar; pname: GLenum; params: PGLint); 

  (*  GL_ARB_blend_func_extended *)
  TglBindFragDataLocationIndexed = PROCEDURE { WINAPI }(program_: GLuint; colorNumber: GLuint; index: GLuint; CONST name: ARRAY OF CHAR); 
  TglGetFragDataIndex = PROCEDURE { WINAPI }(program_: GLuint; CONST name: PGLchar): GLint; 

  (*  GL_ARB_sampler_objects *)
  TglGenSamplers = PROCEDURE { WINAPI }(count: GLsizei; samplers: PGLuint); 
  TglDeleteSamplers = PROCEDURE { WINAPI }(count: GLsizei; CONST samplers: PGLuint); 
  TglIsSampler = PROCEDURE { WINAPI }(sampler: GLuint): GLboolean; 
  TglBindSampler = PROCEDURE { WINAPI }(unit_: GLuint; sampler: GLuint); 
  TglSamplerParameteri = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; param: GLint); 
  TglSamplerParameteriv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; CONST param: PGLint); 
  TglSamplerParameterf = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; param: GLfloat); 
  TglSamplerParameterfv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; CONST param: PGLfloat); 
  TglSamplerParameterIiv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; CONST param: PGLint); 
  TglSamplerParameterIuiv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; CONST param: PGLuint); 
  TglGetSamplerParameteriv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; params: PGLint); 
  TglGetSamplerParameterIiv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; params: PGLint); 
  TglGetSamplerParameterfv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetSamplerParameterIuiv = PROCEDURE { WINAPI }(sampler: GLuint; pname: GLenum; params: PGLuint); 

  (*  GL_ARB_timer_query *)
  TglQueryCounter = PROCEDURE { WINAPI }(id: GLuint; target: GLenum); 
  TglGetQueryObjecti64v = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLint64); 
  TglGetQueryObjectui64v = PROCEDURE { WINAPI }(id: GLuint; pname: GLenum; params: PGLuint64); 

  (*  GL_ARB_vertex_type_2_10_10_10_rev *)
  TglVertexP2ui = PROCEDURE { WINAPI }(type_: GLenum; value: GLuint); 
  TglVertexP2uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST value: PGLuint); 
  TglVertexP3ui = PROCEDURE { WINAPI }(type_: GLenum; value: GLuint); 
  TglVertexP3uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST value: PGLuint); 
  TglVertexP4ui = PROCEDURE { WINAPI }(type_: GLenum; value: GLuint); 
  TglVertexP4uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST value: PGLuint); 
  TglTexCoordP1ui = PROCEDURE { WINAPI }(type_: GLenum; coords: GLuint); 
  TglTexCoordP1uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP2ui = PROCEDURE { WINAPI }(type_: GLenum; coords: GLuint); 
  TglTexCoordP2uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP3ui = PROCEDURE { WINAPI }(type_: GLenum; coords: GLuint); 
  TglTexCoordP3uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST coords: PGLuint); 
  TglTexCoordP4ui = PROCEDURE { WINAPI }(type_: GLenum; coords: GLuint); 
  TglTexCoordP4uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP1ui = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP1uiv = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; CONST coords: GLuint); 
  TglMultiTexCoordP2ui = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP2uiv = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP3ui = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP3uiv = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglMultiTexCoordP4ui = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; coords: GLuint); 
  TglMultiTexCoordP4uiv = PROCEDURE { WINAPI }(texture: GLenum; type_: GLenum; CONST coords: PGLuint); 
  TglNormalP3ui = PROCEDURE { WINAPI }(type_: GLenum; coords: GLuint); 
  TglNormalP3uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST coords: PGLuint); 
  TglColorP3ui = PROCEDURE { WINAPI }(type_: GLenum; color: GLuint); 
  TglColorP3uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST color: PGLuint); 
  TglColorP4ui = PROCEDURE { WINAPI }(type_: GLenum; color: GLuint); 
  TglColorP4uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST color: GLuint); 
  TglSecondaryColorP3ui = PROCEDURE { WINAPI }(type_: GLenum; color: GLuint); 
  TglSecondaryColorP3uiv = PROCEDURE { WINAPI }(type_: GLenum; CONST color: PGLuint); 
  TglVertexAttribP1ui = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP1uiv = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP2ui = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP2uiv = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP3ui = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP3uiv = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 
  TglVertexAttribP4ui = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint); 
  TglVertexAttribP4uiv = PROCEDURE { WINAPI }(index: GLuint; type_: GLenum; normalized: GLboolean; CONST value: PGLuint); 

  (*  GL_ARB_draw_indirect *)
  TglDrawArraysIndirect = PROCEDURE { WINAPI }(mode: GLenum; CONST indirect: PGLvoid); 
  TglDrawElementsIndirect = PROCEDURE { WINAPI }(mode: GLenum; type_: GLenum; CONST indirect: PGLvoid); 

  (*  GL_ARB_gpu_shader_fp64 *)
  TglUniform1d = PROCEDURE { WINAPI }(location: GLint; x: GLdouble); 
  TglUniform2d = PROCEDURE { WINAPI }(location: GLint; x: GLdouble; y: GLdouble); 
  TglUniform3d = PROCEDURE { WINAPI }(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglUniform4d = PROCEDURE { WINAPI }(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglUniform1dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform2dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform3dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniform4dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglUniformMatrix2dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix2x3dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix2x4dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3x2dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix3x4dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4x2dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglUniformMatrix4x3dv = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglGetUniformdv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; params: PGLdouble); 

  (*  GL_ARB_shader_subroutine *)
  TglGetSubroutineUniformLocation = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; CONST name: PGLchar): GLint; 
  TglGetSubroutineIndex = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; CONST name: PGLchar): GLuint; 
  TglGetActiveSubroutineUniformiv = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint); 
  TglGetActiveSubroutineUniformName = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); 
  TglGetActiveSubroutineName = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar); 
  TglUniformSubroutinesuiv = PROCEDURE { WINAPI }(shadertype: GLenum; count: GLsizei; CONST indices: PGLuint); 
  TglGetUniformSubroutineuiv = PROCEDURE { WINAPI }(shadertype: GLenum; location: GLint; params: PGLuint); 
  TglGetProgramStageiv = PROCEDURE { WINAPI }(program_: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint); 

  (*  GL_ARB_tessellation_shader *)
  TglPatchParameteri = PROCEDURE { WINAPI }(pname: GLenum; value: GLint); 
  TglPatchParameterfv = PROCEDURE { WINAPI }(pname: GLenum; CONST values: PGLfloat); 

  (*  GL_ARB_transform_feedback2 *)
  TglBindTransformFeedback = PROCEDURE { WINAPI }(target: GLenum; id: GLuint); 
  TglDeleteTransformFeedbacks = PROCEDURE { WINAPI }(n: GLsizei; CONST ids: PGLuint); 
  TglGenTransformFeedbacks = PROCEDURE { WINAPI }(n: GLsizei; ids: PGLuint); 
  TglIsTransformFeedback = PROCEDURE { WINAPI }(id: GLuint): GLboolean; 
  TglPauseTransformFeedback = PROCEDURE { WINAPI }(); 
  TglResumeTransformFeedback = PROCEDURE { WINAPI }(); 
  TglDrawTransformFeedback = PROCEDURE { WINAPI }(mode: GLenum; id: GLuint); 

  (*  GL_ARB_transform_feedback3 *)
  TglDrawTransformFeedbackStream = PROCEDURE { WINAPI }(mode: GLenum; id: GLuint; stream: GLuint); 
  TglBeginQueryIndexed = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; id: GLuint); 
  TglEndQueryIndexed = PROCEDURE { WINAPI }(target: GLenum; index: GLuint); 
  TglGetQueryIndexediv = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; pname: GLenum; params: PGLint); 

  (*  GL_ARB_ES2_compatibility *)
  TglReleaseShaderCompiler = PROCEDURE { WINAPI }(); 
  TglShaderBinary = PROCEDURE { WINAPI }(count: GLsizei; CONST shaders: PGLuint; binaryformat: GLenum; CONST binary: PGLvoid; length: GLsizei); 
  TglGetShaderPrecisionFormat = PROCEDURE { WINAPI }(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint); 
  TglDepthRangef = PROCEDURE { WINAPI }(n: GLclampf; f: GLclampf); 
  TglClearDepthf = PROCEDURE { WINAPI }(d: GLclampf); 

  (* GL_ARB_get_program_binary *)
  TglGetProgramBinary = PROCEDURE { WINAPI }(program_: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid); 
  TglProgramBinary = PROCEDURE { WINAPI }(program_: GLuint; binaryFormat: GLenum; CONST binary: PGLvoid; length: GLsizei); 
  TglProgramParameteri = PROCEDURE { WINAPI }(program_: GLuint; pname: GLenum; value: GLint); 
  
  (* GL_ARB_separate_shader_objects*)
  TglUseProgramStages = PROCEDURE { WINAPI }(pipeline: GLuint; stages: GLbitfield; program_: GLuint); 
  TglActiveShaderProgram = PROCEDURE { WINAPI }(pipeline: GLuint; program_: GLuint); 
  TglCreateShaderProgramv = PROCEDURE { WINAPI }(type_: GLenum; count: GLsizei; CONST strings: PPGLchar): GLuint; 
  TglBindProgramPipeline = PROCEDURE { WINAPI }(pipeline: GLuint); 
  TglDeleteProgramPipelines = PROCEDURE { WINAPI }(n: GLsizei; CONST pipelines: PGLuint); 
  TglGenProgramPipelines = PROCEDURE { WINAPI }(n: GLsizei; pipelines: PGLuint); 
  TglIsProgramPipeline = PROCEDURE { WINAPI }(pipeline: GLuint): GLboolean; 
  TglGetProgramPipelineiv = PROCEDURE { WINAPI }(pipeline: GLuint; pname: GLenum; params: PGLint); 
  TglProgramUniform1i = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint); 
  TglProgramUniform1iv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform1f = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat); 
  TglProgramUniform1fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform1d = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLdouble); 
  TglProgramUniform1dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform1ui = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint); 
  TglProgramUniform1uiv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform2i = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint); 
  TglProgramUniform2iv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform2f = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat); 
  TglProgramUniform2fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform2d = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble); 
  TglProgramUniform2dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform2ui = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint); 
  TglProgramUniform2uiv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform3i = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint); 
  TglProgramUniform3iv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform3f = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat); 
  TglProgramUniform3fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform3d = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble); 
  TglProgramUniform3dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform3ui = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint); 
  TglProgramUniform3uiv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniform4i = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint); 
  TglProgramUniform4iv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint); 
  TglProgramUniform4f = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat); 
  TglProgramUniform4fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat); 
  TglProgramUniform4d = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble); 
  TglProgramUniform4dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble); 
  TglProgramUniform4ui = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint); 
  TglProgramUniform4uiv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint); 
  TglProgramUniformMatrix2fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix2x3fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3x2fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2x4fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4x2fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix3x4fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix4x3fv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat); 
  TglProgramUniformMatrix2x3dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3x2dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix2x4dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4x2dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix3x4dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglProgramUniformMatrix4x3dv = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble); 
  TglValidateProgramPipeline = PROCEDURE { WINAPI }(pipeline: GLuint); 
  TglGetProgramPipelineInfoLog = PROCEDURE { WINAPI }(pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar); 

  (* GL_ARB_vertex_attrib_64bit *)
  TglVertexAttribL1d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble); 
  TglVertexAttribL2d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble); 
  TglVertexAttribL3d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble); 
  TglVertexAttribL4d = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble); 
  TglVertexAttribL1dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL2dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL3dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribL4dv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble); 
  TglVertexAttribLPointer = PROCEDURE { WINAPI }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid); 
  TglGetVertexAttribLdv = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLdouble); 

  (* GL_ARB_viewport_array*)
  TglViewportArrayv = PROCEDURE { WINAPI }(first: GLuint; count: GLsizei; CONST v: PGLfloat); 
  TglViewportIndexedf = PROCEDURE { WINAPI }(index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat); 
  TglViewportIndexedfv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLfloat); 
  TglScissorArrayv = PROCEDURE { WINAPI }(first: GLuint; count: GLsizei; CONST v: PGLint); 
  TglScissorIndexed = PROCEDURE { WINAPI }(index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei); 
  TglScissorIndexedv = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint); 
  TglDepthRangeArrayv = PROCEDURE { WINAPI }(first: GLuint; count: GLsizei; CONST v: PGLclampd); 
  TglDepthRangeIndexed = PROCEDURE { WINAPI }(index: GLuint; n: GLclampd; f: GLclampd); 
  TglGetFloati_v = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; data: PGLfloat); 
  TglGetDoublei_v = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; data: PGLdouble); 

  (* GL_ARB_cl_event *)
  TglCreateSyncFromCLeventARB = PROCEDURE { WINAPI }(context: p_cl_context; event: p_cl_event; flags: GLbitfield): GLsync; 

  (* GL_ARB_debug_output*)
  TglDebugMessageControlARB = PROCEDURE { WINAPI }(source: GLenum; type_: GLenum; severity: GLenum; count: GLsizei; CONST ids: PGLuint; enabled: GLboolean); 
  TglDebugMessageInsertARB = PROCEDURE { WINAPI }(source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST buf: PGLchar); 
 (* TglDebugMessageCallbackARB = PROCEDURE { WINAPI }(callback: TglDebugProcARB; CONST userParam: PGLvoid); *)
  TglGetDebugMessageLogARB = PROCEDURE { WINAPI }(count: GLuint; bufsize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint; 

  (* GL_ARB_robustness*)
  TglGetGraphicsResetStatusARB = PROCEDURE { WINAPI }(): GLenum; 
  TglGetnMapdvARB = PROCEDURE { WINAPI }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble); 
  TglGetnMapfvARB = PROCEDURE { WINAPI }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat); 
  TglGetnMapivARB = PROCEDURE { WINAPI }(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint); 
  TglGetnPixelMapfvARB = PROCEDURE { WINAPI }(map: GLenum; bufSize: GLsizei; values: PGLfloat); 
  TglGetnPixelMapuivARB = PROCEDURE { WINAPI }(map: GLenum; bufSize: GLsizei; values: PGLuint); 
  TglGetnPixelMapusvARB = PROCEDURE { WINAPI }(map: GLenum; bufSize: GLsizei; values: PGLushort); 
  TglGetnPolygonStippleARB = PROCEDURE { WINAPI }(bufSize: GLsizei; pattern: PGLubyte); 
  TglGetnColorTableARB = PROCEDURE { WINAPI }(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; table: PGLvoid); 
  TglGetnConvolutionFilterARB = PROCEDURE { WINAPI }(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; image: PGLvoid); 
  TglGetnSeparableFilterARB = PROCEDURE { WINAPI }(target: GLenum; format: GLenum; type_: GLenum; rowBufSize: GLsizei; row: PGLvoid; columnBufSize: GLsizei; column: PGLvoid; span: PGLvoid); 
  TglGetnHistogramARB = PROCEDURE { WINAPI }(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid); 
  TglGetnMinmaxARB = PROCEDURE { WINAPI }(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid); 
  TglGetnTexImageARB = PROCEDURE { WINAPI }(target: GLenum; level: GLint; format: GLenum; type_: GLenum; bufSize: GLsizei; img: PGLvoid); 
  TglReadnPixelsARB = PROCEDURE { WINAPI }(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; bufSize: GLsizei; data: PGLvoid); 
  TglGetnCompressedTexImageARB = PROCEDURE { WINAPI }(target: GLenum; lod: GLint; bufSize: GLsizei; img: PGLvoid); 
  TglGetnUniformfvARB = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat); 
  TglGetnUniformivARB = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLint); 
  TglGetnUniformuivARB = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint); 
  TglGetnUniformdvARB = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble); 
 
  (* GL_ATI_draw_buffers *)
  TglDrawBuffersATI = PROCEDURE { WINAPI }(n: TGLsizei; CONST bufs: PGLenum); 

  (* GL_ATI_element_array *)
  TglElementPointerATI = PROCEDURE { WINAPI }(_type: TGLenum; CONST _pointer: PGLvoid); 
  TglDrawElementArrayATI = PROCEDURE { WINAPI }(mode: TGLenum; count: TGLsizei); 
  TglDrawRangeElementArrayATI = PROCEDURE { WINAPI }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei); 

  (* GL_ATI_envmap_bumpmap *)
  TglTexBumpParameterivATI = PROCEDURE { WINAPI }(pname: TGLenum; CONST param: PGLint); 
  TglTexBumpParameterfvATI = PROCEDURE { WINAPI }(pname: TGLenum; CONST param: PGLfloat); 
  TglGetTexBumpParameterivATI = PROCEDURE { WINAPI }(pname: TGLenum; param: PGLint); 
  TglGetTexBumpParameterfvATI = PROCEDURE { WINAPI }(pname: TGLenum; param: PGLfloat); 

  (* GL_ATI_fragment_shader *)
  TglGenFragmentShadersATI = PROCEDURE { WINAPI } (range: TGLuint): TGLuint; 
  TglBindFragmentShaderATI = PROCEDURE { WINAPI }(id: TGLuint); 
  TglDeleteFragmentShaderATI = PROCEDURE { WINAPI }(id: TGLuint); 
  TglBeginFragmentShaderATI = PROCEDURE { WINAPI }(); 
  TglEndFragmentShaderATI = PROCEDURE { WINAPI }(); 
  TglPassTexCoordATI = PROCEDURE { WINAPI }(dst: TGLuint; coord: TGLuint; swizzle: TGLenum); 
  TglSampleMapATI = PROCEDURE { WINAPI }(dst: TGLuint; interp: TGLuint; swizzle: TGLenum); 
  TglColorFragmentOp1ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint); 
  TglColorFragmentOp2ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint); 
  TglColorFragmentOp3ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMask: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint; arg3: TGLuint; arg3Rep: TGLuint; arg3Mod: TGLuint); 
  TglAlphaFragmentOp1ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint); 
  TglAlphaFragmentOp2ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint); 
  TglAlphaFragmentOp3ATI = PROCEDURE { WINAPI }(op: TGLenum; dst: TGLuint; dstMod: TGLuint; arg1: TGLuint; arg1Rep: TGLuint; arg1Mod: TGLuint; arg2: TGLuint; arg2Rep: TGLuint; arg2Mod: TGLuint; arg3: TGLuint; arg3Rep: TGLuint; arg3Mod: TGLuint); 
  TglSetFragmentShaderConstantATI = PROCEDURE { WINAPI }(dst: TGLuint; CONST value: PGLfloat); 

  (* GL_ATI_map_object_buffer *)
  TglMapObjectBufferATI = PROCEDURE { WINAPI } (buffer: TGLuint): PGLvoid; 
  TglUnmapObjectBufferATI = PROCEDURE { WINAPI }(buffer: TGLuint); 

  (* GL_ATI_pn_triangles *)
  TglPNTrianglesiATI = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglPNTrianglesfATI = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 

  (* GL_ATI_separate_stencil *)
  TglStencilOpSeparateATI = PROCEDURE { WINAPI }(face: TGLenum; sfail: TGLenum; dpfail: TGLenum; dppass: TGLenum); 
  TglStencilFuncSeparateATI = PROCEDURE { WINAPI }(frontfunc: TGLenum; backfunc: TGLenum; ref: TGLint; mask: TGLuint); 

  (* GL_ATI_vertex_array_object *)
  TglNewObjectBufferATI = PROCEDURE { WINAPI } (size: TGLsizei; CONST _pointer: PGLvoid; usage: TGLenum): TGLuint; 
  TglIsObjectBufferATI = PROCEDURE { WINAPI } (buffer: TGLuint): TGLboolean; 
  TglUpdateObjectBufferATI = PROCEDURE { WINAPI }(buffer: TGLuint; offset: TGLuint; size: TGLsizei; CONST _pointer: PGLvoid; preserve: TGLenum); 
  TglGetObjectBufferfvATI = PROCEDURE { WINAPI }(buffer: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetObjectBufferivATI = PROCEDURE { WINAPI }(buffer: TGLuint; pname: TGLenum; params: PGLint); 
  TglFreeObjectBufferATI = PROCEDURE { WINAPI }(buffer: TGLuint); 
  TglArrayObjectATI = PROCEDURE { WINAPI }(_array: TGLenum; size: TGLint; _type: TGLenum; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetArrayObjectfvATI = PROCEDURE { WINAPI }(_array: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetArrayObjectivATI = PROCEDURE { WINAPI }(_array: TGLenum; pname: TGLenum; params: PGLint); 
  TglVariantArrayObjectATI = PROCEDURE { WINAPI }(id: TGLuint; _type: TGLenum; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetVariantArrayObjectfvATI = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVariantArrayObjectivATI = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLint); 

  (* GL_ATI_vertex_attrib_array_object *)
  TglVertexAttribArrayObjectATI = PROCEDURE { WINAPI }(index: TGLuint; size: TGLint; _type: TGLenum; normalized: TGLboolean; stride: TGLsizei; buffer: TGLuint; offset: TGLuint); 
  TglGetVertexAttribArrayObjectfvATI = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribArrayObjectivATI = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLint); 

  (* GL_ATI_vertex_streams *)
  TglVertexStream1sATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLshort); 
  TglVertexStream1svATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream1iATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLint); 
  TglVertexStream1ivATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream1fATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLfloat); 
  TglVertexStream1fvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream1dATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLdouble); 
  TglVertexStream1dvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream2sATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLshort; y: TGLshort); 
  TglVertexStream2svATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream2iATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLint; y: TGLint); 
  TglVertexStream2ivATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream2fATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLfloat; y: TGLfloat); 
  TglVertexStream2fvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream2dATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLdouble; y: TGLdouble); 
  TglVertexStream2dvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream3sATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexStream3svATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream3iATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLint; y: TGLint; z: TGLint); 
  TglVertexStream3ivATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream3fATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexStream3fvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream3dATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexStream3dvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLdouble); 
  TglVertexStream4sATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexStream4svATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLshort); 
  TglVertexStream4iATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertexStream4ivATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLint); 
  TglVertexStream4fATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexStream4fvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLfloat); 
  TglVertexStream4dATI = PROCEDURE { WINAPI }(stream: TGLenum; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexStream4dvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLdouble); 
  TglNormalStream3bATI = PROCEDURE { WINAPI }(stream: TGLenum; nx: TGLbyte; ny: TGLbyte; nz: TGLbyte); 
  TglNormalStream3bvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLbyte); 
  TglNormalStream3sATI = PROCEDURE { WINAPI }(stream: TGLenum; nx: TGLshort; ny: TGLshort; nz: TGLshort); 
  TglNormalStream3svATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLshort); 
  TglNormalStream3iATI = PROCEDURE { WINAPI }(stream: TGLenum; nx: TGLint; ny: TGLint; nz: TGLint); 
  TglNormalStream3ivATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLint); 
  TglNormalStream3fATI = PROCEDURE { WINAPI }(stream: TGLenum; nx: TGLfloat; ny: TGLfloat; nz: TGLfloat); 
  TglNormalStream3fvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLfloat); 
  TglNormalStream3dATI = PROCEDURE { WINAPI }(stream: TGLenum; nx: TGLdouble; ny: TGLdouble; nz: TGLdouble); 
  TglNormalStream3dvATI = PROCEDURE { WINAPI }(stream: TGLenum; CONST coords: PGLdouble); 
  TglClientActiveVertexStreamATI = PROCEDURE { WINAPI }(stream: TGLenum); 
  TglVertexBlendEnviATI = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglVertexBlendEnvfATI = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 

  (* GL_AMD_performance_monitor *)
  TglGetPerfMonitorGroupsAMD = PROCEDURE { WINAPI }(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint); 
  TglGetPerfMonitorCountersAMD = PROCEDURE { WINAPI }(group: GLuint; numCounters: PGLint; maxActiveCouters: PGLint; counterSize: GLsizei; counters: PGLuint); 
  TglGetPerfMonitorGroupStringAMD = PROCEDURE { WINAPI }(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar); 
  TglGetPerfMonitorCounterStringAMD = PROCEDURE { WINAPI }(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar); 
  TglGetPerfMonitorCounterInfoAMD = PROCEDURE { WINAPI }(group: GLuint; counter: GLuint; pname: GLenum; data: Pointer); 
  TglGenPerfMonitorsAMD = PROCEDURE { WINAPI }(n: GLsizei; monitors: PGLuint); 
  TglDeletePerfMonitorsAMD = PROCEDURE { WINAPI }(n: GLsizei; monitors: PGLuint); 
  TglSelectPerfMonitorCountersAMD = PROCEDURE { WINAPI }(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; counterList: PGLuint); 
  TglBeginPerfMonitorAMD = PROCEDURE { WINAPI }(monitor: GLuint); 
  TglEndPerfMonitorAMD = PROCEDURE { WINAPI }(monitor: GLuint); 
  TglGetPerfMonitorCounterDataAMD = PROCEDURE { WINAPI }(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint); 

  (* GL_AMD_vertex_shader_tesselator *)
  TglTessellationFactorAMD = PROCEDURE { WINAPI }(factor: GLfloat); 
  TglTessellationModeAMD = PROCEDURE { WINAPI }(mode: GLenum); 

  (* GL_AMD_draw_buffers_blend *)
  TglBlendFuncIndexedAMD = PROCEDURE { WINAPI }(buf: GLuint; src: GLenum; dst: GLenum); 
  TglBlendFuncSeparateIndexedAMD = PROCEDURE { WINAPI }(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum); 
  TglBlendEquationIndexedAMD = PROCEDURE { WINAPI }(buf: GLuint; mode: GLenum); 
  TglBlendEquationSeparateIndexedAMD = PROCEDURE { WINAPI }(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum); 

  (* GL_AMD_name_gen_delete *)
  TglGenNamesAMD = PROCEDURE { WINAPI }(identifier: GLenum; num: GLuint; names: PGLuint); 
  TglDeleteNamesAMD = PROCEDURE { WINAPI }(identifier: GLenum; num: GLuint; CONST names: PGLuint); 
  TglIsNameAMD = PROCEDURE { WINAPI }(identifier: GLenum; name: GLuint): GLboolean; 

  (* GL_AMD_debug_output *)
  TglDebugMessageEnableAMD = PROCEDURE { WINAPI }(category: GLenum; severity: GLenum; count: GLsizei; CONST ids: PGLuint; enabled: GLboolean); 
  TglDebugMessageInsertAMD = PROCEDURE { WINAPI }(category: GLenum; severity: GLenum; id: GLuint; length: GLsizei; CONST buf: PGLchar); 
 (* TglDebugMessageCallbackAMD = PROCEDURE { WINAPI }(callback: TGLDebugProcAMD; userParam: PGLvoid);  *)
  TglGetDebugMessageLogAMD = PROCEDURE { WINAPI }(count: GLuint; bufsize: GLsizei; categories: PGLenum; severities: PGLuint; ids: PGLuint; lengths: PGLsizei; message: PGLchar): GLuint; 
 
  (* GL_EXT_blend_color *)
  TglBlendColorEXT = PROCEDURE { WINAPI }(red: TGLclampf; green: TGLclampf; blue: TGLclampf; alpha: TGLclampf); 

  (* GL_EXT_blend_func_separate *)
  TglBlendFuncSeparateEXT = PROCEDURE { WINAPI }(sfactorRGB: TGLenum; dfactorRGB: TGLenum; sfactorAlpha: TGLenum; dfactorAlpha: TGLenum); 

  (* GL_EXT_blend_minmax *)
  TglBlendEquationEXT = PROCEDURE { WINAPI }(mode: TGLenum); 

  (* GL_EXT_color_subtable *)
  TglColorSubTableEXT = PROCEDURE { WINAPI }(target: TGLenum; start: TGLsizei; count: TGLsizei; format: TGLenum; _type: TGLenum; CONST data: PGLvoid); 
  TglCopyColorSubTableEXT = PROCEDURE { WINAPI }(target: TGLenum; start: TGLsizei; x: TGLint; y: TGLint; width: TGLsizei); 

  (* GL_EXT_compiled_vertex_array *)
  TglLockArraysEXT = PROCEDURE { WINAPI }(first: TGLint; count: TGLsizei); 
  TglUnlockArraysEXT = PROCEDURE { WINAPI }(); 

  (* GL_EXT_convolution *)
  TglConvolutionFilter1DEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST image: PGLvoid); 
  TglConvolutionFilter2DEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST image: PGLvoid); 
  TglConvolutionParameterfEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: TGLfloat); 
  TglConvolutionParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglConvolutionParameteriEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: TGLint); 
  TglConvolutionParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglCopyConvolutionFilter1DEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyConvolutionFilter2DEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglGetConvolutionFilterEXT = PROCEDURE { WINAPI }(target: TGLenum; format: TGLenum; _type: TGLenum; image: PGLvoid); 
  TglGetConvolutionParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetConvolutionParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetSeparableFilterEXT = PROCEDURE { WINAPI }(target: TGLenum; format: TGLenum; _type: TGLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid); 
  TglSeparableFilter2DEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST row: PGLvoid; CONST column: PGLvoid); 

  (* GL_EXT_coordinate_frame *)
  TglTangent3bEXT = PROCEDURE { WINAPI }(tx: TGLbyte; ty: TGLbyte; tz: TGLbyte); 
  TglTangent3bvEXT = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglTangent3dEXT = PROCEDURE { WINAPI }(tx: TGLdouble; ty: TGLdouble; tz: TGLdouble); 
  TglTangent3dvEXT = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglTangent3fEXT = PROCEDURE { WINAPI }(tx: TGLfloat; ty: TGLfloat; tz: TGLfloat); 
  TglTangent3fvEXT = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglTangent3iEXT = PROCEDURE { WINAPI }(tx: TGLint; ty: TGLint; tz: TGLint); 
  TglTangent3ivEXT = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglTangent3sEXT = PROCEDURE { WINAPI }(tx: TGLshort; ty: TGLshort; tz: TGLshort); 
  TglTangent3svEXT = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglBinormal3bEXT = PROCEDURE { WINAPI }(bx: TGLbyte; by: TGLbyte; bz: TGLbyte); 
  TglBinormal3bvEXT = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglBinormal3dEXT = PROCEDURE { WINAPI }(bx: TGLdouble; by: TGLdouble; bz: TGLdouble); 
  TglBinormal3dvEXT = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglBinormal3fEXT = PROCEDURE { WINAPI }(bx: TGLfloat; by: TGLfloat; bz: TGLfloat); 
  TglBinormal3fvEXT = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglBinormal3iEXT = PROCEDURE { WINAPI }(bx: TGLint; by: TGLint; bz: TGLint); 
  TglBinormal3ivEXT = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglBinormal3sEXT = PROCEDURE { WINAPI }(bx: TGLshort; by: TGLshort; bz: TGLshort); 
  TglBinormal3svEXT = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglTangentPointerEXT = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglBinormalPointerEXT = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_copy_texture *)
  TglCopyTexImage1DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; border: TGLint); 
  TglCopyTexImage2DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei; border: TGLint); 
  TglCopyTexSubImage1DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei); 
  TglCopyTexSubImage2DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
  TglCopyTexSubImage3DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 

  (* GL_EXT_cull_vertex *)
  TglCullParameterdvEXT = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLdouble); 
  TglCullParameterfvEXT = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_draw_range_elements *)
  TglDrawRangeElementsEXT = PROCEDURE { WINAPI }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 

  (* GL_EXT_fog_coord *)
  TglFogCoordfEXT = PROCEDURE { WINAPI }(coord: TGLfloat); 
  TglFogCoordfvEXT = PROCEDURE { WINAPI }(CONST coord: PGLfloat); 
  TglFogCoorddEXT = PROCEDURE { WINAPI }(coord: TGLdouble); 
  TglFogCoorddvEXT = PROCEDURE { WINAPI }(CONST coord: PGLdouble); 
  TglFogCoordPointerEXT = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_framebuffer_object *)
  TglIsRenderbufferEXT = PROCEDURE { WINAPI } (renderbuffer: TGLuint): BOOLEAN; 
  TglBindRenderbufferEXT = PROCEDURE { WINAPI }(target: TGLenum; renderbuffer: TGLuint); 
  TglDeleteRenderbuffersEXT = PROCEDURE { WINAPI }(n: TGLsizei; CONST renderbuffers: PGLuint); 
  TglGenRenderbuffersEXT = PROCEDURE { WINAPI }(n: TGLsizei; renderbuffers: PGLuint); 
  TglRenderbufferStorageEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 
  TglGetRenderbufferParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglIsFramebufferEXT = PROCEDURE { WINAPI } (framebuffer: TGLuint): BOOLEAN; 
  TglBindFramebufferEXT = PROCEDURE { WINAPI }(target: TGLenum; framebuffer: TGLuint); 
  TglDeleteFramebuffersEXT = PROCEDURE { WINAPI }(n: TGLsizei; CONST framebuffers: PGLuint); 
  TglGenFramebuffersEXT = PROCEDURE { WINAPI }(n: TGLsizei; framebuffers: PGLuint); 
  TglCheckFramebufferStatusEXT = PROCEDURE { WINAPI } (target: TGLenum): TGLenum; 
  TglFramebufferTexture1DEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint); 
  TglFramebufferTexture2DEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint); 
  TglFramebufferTexture3DEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; textarget: TGLenum; texture: TGLuint; level: TGLint; zoffset: TGLint); 
  TglFramebufferRenderbufferEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; renderbuffertarget: TGLenum; renderbuffer: TGLuint); 
  TglGetFramebufferAttachmentParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; pname: TGLenum; params: PGLint); 
  TglGenerateMipmapEXT = PROCEDURE { WINAPI }(target: TGLenum); 

  (* GL_EXT_histogram *)
  TglGetHistogramEXT = PROCEDURE { WINAPI }(target: TGLenum; reset: TGLboolean; format: TGLenum; _type: TGLenum; values: PGLvoid); 
  TglGetHistogramParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetHistogramParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMinmaxEXT = PROCEDURE { WINAPI }(target: TGLenum; reset: TGLboolean; format: TGLenum; _type: TGLenum; values: PGLvoid); 
  TglGetMinmaxParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMinmaxParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglHistogramEXT = PROCEDURE { WINAPI }(target: TGLenum; width: TGLsizei; internalformat: TGLenum; sink: TGLboolean); 
  TglMinmaxEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; sink: TGLboolean); 
  TglResetHistogramEXT = PROCEDURE { WINAPI }(target: TGLenum); 
  TglResetMinmaxEXT = PROCEDURE { WINAPI }(target: TGLenum); 

  (* GL_EXT_index_func *)
  TglIndexFuncEXT = PROCEDURE { WINAPI }(func: TGLenum; ref: TGLclampf); 

  (* GL_EXT_index_material *)
  TglIndexMaterialEXT = PROCEDURE { WINAPI }(face: TGLenum; mode: TGLenum); 

  (* GL_EXT_light_texture *)
  TglApplyTextureEXT = PROCEDURE { WINAPI }(mode: TGLenum); 
  TglTextureLightEXT = PROCEDURE { WINAPI }(pname: TGLenum); 
  TglTextureMaterialEXT = PROCEDURE { WINAPI }(face: TGLenum; mode: TGLenum); 

  (* GL_EXT_multi_draw_arrays *)
  TglMultiDrawArraysEXT = PROCEDURE { WINAPI }(mode: TGLenum; first: PGLint; count: PGLsizei; primcount: TGLsizei); 
  TglMultiDrawElementsEXT = PROCEDURE { WINAPI }(mode: TGLenum; CONST count: PGLsizei; _type: TGLenum; CONST indices: PGLvoid; primcount: TGLsizei); 

  (* GL_EXT_multisample *)
  TglSampleMaskEXT = PROCEDURE { WINAPI }(value: TGLclampf; invert: TGLboolean); 
  TglSamplePatternEXT = PROCEDURE { WINAPI }(pattern: TGLenum); 

  (* GL_EXT_paletted_texture *)
  TglColorTableEXT = PROCEDURE { WINAPI }(target: TGLenum; internalFormat: TGLenum; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST table: PGLvoid); 
  TglGetColorTableEXT = PROCEDURE { WINAPI }(target: TGLenum; format: TGLenum; _type: TGLenum; data: PGLvoid); 
  TglGetColorTableParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetColorTableParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_pixel_transform *)
  TglPixelTransformParameteriEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglPixelTransformParameterfEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglPixelTransformParameterivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglPixelTransformParameterfvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 

  (* GL_EXT_point_parameters *)
  TglPointParameterfEXT = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglPointParameterfvEXT = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLfloat); 

  (* GL_EXT_polygon_offset *)
  TglPolygonOffsetEXT = PROCEDURE { WINAPI }(factor: TGLfloat; bias: TGLfloat); 

  (* GL_EXT_secondary_color *)
  TglSecondaryColor3bEXT = PROCEDURE { WINAPI }(red: TGLbyte; green: TGLbyte; blue: TGLbyte); 
  TglSecondaryColor3bvEXT = PROCEDURE { WINAPI }(CONST v: PGLbyte); 
  TglSecondaryColor3dEXT = PROCEDURE { WINAPI }(red: TGLdouble; green: TGLdouble; blue: TGLdouble); 
  TglSecondaryColor3dvEXT = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglSecondaryColor3fEXT = PROCEDURE { WINAPI }(red: TGLfloat; green: TGLfloat; blue: TGLfloat); 
  TglSecondaryColor3fvEXT = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglSecondaryColor3iEXT = PROCEDURE { WINAPI }(red: TGLint; green: TGLint; blue: TGLint); 
  TglSecondaryColor3ivEXT = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglSecondaryColor3sEXT = PROCEDURE { WINAPI }(red: TGLshort; green: TGLshort; blue: TGLshort); 
  TglSecondaryColor3svEXT = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglSecondaryColor3ubEXT = PROCEDURE { WINAPI }(red: TGLubyte; green: TGLubyte; blue: TGLubyte); 
  TglSecondaryColor3ubvEXT = PROCEDURE { WINAPI }(CONST v: PGLubyte); 
  TglSecondaryColor3uiEXT = PROCEDURE { WINAPI }(red: TGLuint; green: TGLuint; blue: TGLuint); 
  TglSecondaryColor3uivEXT = PROCEDURE { WINAPI }(CONST v: PGLuint); 
  TglSecondaryColor3usEXT = PROCEDURE { WINAPI }(red: TGLushort; green: TGLushort; blue: TGLushort); 
  TglSecondaryColor3usvEXT = PROCEDURE { WINAPI }(CONST v: PGLushort); 
  TglSecondaryColorPointerEXT = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_stencil_two_side *)
  TglActiveStencilFaceEXT = PROCEDURE { WINAPI }(face: TGLenum); 

  (* GL_EXT_subtexture *)
  TglTexSubImage1DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; width: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage2DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; width: TGLsizei; height: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 

  (* GL_EXT_texture3D *)
  TglTexImage3DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; internalformat: TGLenum; width: TGLsizei; height: TGLsizei; depth: TGLsizei; border: TGLint; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 
  TglTexSubImage3DEXT = PROCEDURE { WINAPI }(target: TGLenum; level: TGLint; xoffset: TGLint; yoffset: TGLint; zoffset: TGLint; width: TGLsizei; height: TGLsizei; depth: TGLsizei; format: TGLenum; _type: TGLenum; CONST pixels: PGLvoid); 

  (* GL_EXT_texture_object *)
  TglAreTexturesResidentEXT = PROCEDURE { WINAPI } (n: TGLsizei; CONST textures: PGLuint; residences: PGLboolean): TGLboolean; 
  TglBindTextureEXT = PROCEDURE { WINAPI }(target: TGLenum; texture: TGLuint); 
  TglDeleteTexturesEXT = PROCEDURE { WINAPI }(n: TGLsizei; CONST textures: PGLuint); 
  TglGenTexturesEXT = PROCEDURE { WINAPI }(n: TGLsizei; textures: PGLuint); 
  TglIsTextureEXT = PROCEDURE { WINAPI } (texture: TGLuint): TGLboolean; 
  TglPrioritizeTexturesEXT = PROCEDURE { WINAPI }(n: TGLsizei; CONST textures: PGLuint; CONST priorities: PGLclampf); 

  (* GL_EXT_texture_perturb_normal *)
  TglTextureNormalEXT = PROCEDURE { WINAPI }(mode: TGLenum); 

  (* GL_EXT_vertex_array *)
  TglArrayElementEXT = PROCEDURE { WINAPI }(i: TGLint); 
  TglColorPointerEXT = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglDrawArraysEXT = PROCEDURE { WINAPI }(mode: TGLenum; first: TGLint; count: TGLsizei); 
  TglEdgeFlagPointerEXT = PROCEDURE { WINAPI }(stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLboolean); 
  TglGetPointervEXT = PROCEDURE { WINAPI }(pname: TGLenum; params: PGLvoid); 
  TglIndexPointerEXT = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglNormalPointerEXT = PROCEDURE { WINAPI }(_type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglTexCoordPointerEXT = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexPointerEXT = PROCEDURE { WINAPI }(size: TGLint; _type: TGLenum; stride: TGLsizei; count: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_vertex_shader *)
  TglBeginVertexShaderEXT = PROCEDURE { WINAPI }(); 
  TglEndVertexShaderEXT = PROCEDURE { WINAPI }(); 
  TglBindVertexShaderEXT = PROCEDURE { WINAPI }(id: TGLuint); 
  TglGenVertexShadersEXT = PROCEDURE { WINAPI } (range: TGLuint): TGLuint; 
  TglDeleteVertexShaderEXT = PROCEDURE { WINAPI }(id: TGLuint); 
  TglShaderOp1EXT = PROCEDURE { WINAPI }(op: TGLenum; res: TGLuint; arg1: TGLuint); 
  TglShaderOp2EXT = PROCEDURE { WINAPI }(op: TGLenum; res: TGLuint; arg1: TGLuint; arg2: TGLuint); 
  TglShaderOp3EXT = PROCEDURE { WINAPI }(op: TGLenum; res: TGLuint; arg1: TGLuint; arg2: TGLuint; arg3: TGLuint); 
  TglSwizzleEXT = PROCEDURE { WINAPI }(res: TGLuint; _in: TGLuint; outX: TGLenum; outY: TGLenum; outZ: TGLenum; outW: TGLenum); 
  TglWriteMaskEXT = PROCEDURE { WINAPI }(res: TGLuint; _in: TGLuint; outX: TGLenum; outY: TGLenum; outZ: TGLenum; outW: TGLenum); 
  TglInsertComponentEXT = PROCEDURE { WINAPI }(res: TGLuint; src: TGLuint; num: TGLuint); 
  TglExtractComponentEXT = PROCEDURE { WINAPI }(res: TGLuint; src: TGLuint; num: TGLuint); 
  TglGenSymbolsEXT = PROCEDURE { WINAPI } (datatype: TGLenum; storagetype: TGLenum; range: TGLenum; components: TGLuint): TGLuint; 
  TglSetInvariantEXT = PROCEDURE { WINAPI }(id: TGLuint; _type: TGLenum; CONST addr: PGLvoid); 
  TglSetLocalConstantEXT = PROCEDURE { WINAPI }(id: TGLuint; _type: TGLenum; CONST addr: PGLvoid); 
  TglVariantbvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLbyte); 
  TglVariantsvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLshort); 
  TglVariantivEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLint); 
  TglVariantfvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLfloat); 
  TglVariantdvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLdouble); 
  TglVariantubvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLubyte); 
  TglVariantusvEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLushort); 
  TglVariantuivEXT = PROCEDURE { WINAPI }(id: TGLuint; CONST addr: PGLuint); 
  TglVariantPointerEXT = PROCEDURE { WINAPI }(id: TGLuint; _type: TGLenum; stride: TGLuint; CONST addr: PGLvoid); 
  TglEnableVariantClientStateEXT = PROCEDURE { WINAPI }(id: TGLuint); 
  TglDisableVariantClientStateEXT = PROCEDURE { WINAPI }(id: TGLuint); 
  TglBindLightParameterEXT = PROCEDURE { WINAPI } (light: TGLenum; value: TGLenum): TGLuint; 
  TglBindMaterialParameterEXT = PROCEDURE { WINAPI } (face: TGLenum; value: TGLenum): TGLuint; 
  TglBindTexGenParameterEXT = PROCEDURE { WINAPI } (_unit: TGLenum; coord: TGLenum; value: TGLenum): TGLuint; 
  TglBindTextureUnitParameterEXT = PROCEDURE { WINAPI } ( _unit: TGLenum; value: TGLenum): TGLuint; 
  TglBindParameterEXT = PROCEDURE { WINAPI } (value: TGLenum): TGLuint; 
  TglIsVariantEnabledEXT = PROCEDURE { WINAPI } (id: TGLuint; cap: TGLenum): TGLboolean; 
  TglGetVariantBooleanvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetVariantIntegervEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetVariantFloatvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLfloat); 
  TglGetVariantPointervEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLvoid); 
  TglGetInvariantBooleanvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetInvariantIntegervEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetInvariantFloatvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLfloat); 
  TglGetLocalConstantBooleanvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLboolean); 
  TglGetLocalConstantIntegervEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLint); 
  TglGetLocalConstantFloatvEXT = PROCEDURE { WINAPI }(id: TGLuint; value: TGLenum; data: PGLfloat); 

  (* GL_EXT_vertex_weighting *)
  TglVertexWeightfEXT = PROCEDURE { WINAPI }(weight: TGLfloat); 
  TglVertexWeightfvEXT = PROCEDURE { WINAPI }(CONST weight: PGLfloat); 
  TglVertexWeightPointerEXT = PROCEDURE { WINAPI }(size: TGLsizei; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_EXT_stencil_clear_tag *)
  TglStencilClearTagEXT = PROCEDURE { WINAPI }(stencilTagBits: TGLsizei; stencilClearTag: TGLuint); 

  (* GL_EXT_framebuffer_blit *)
  TglBlitFramebufferEXT = PROCEDURE { WINAPI }(srcX0: TGLint; srcY0: TGLint; srcX1: TGLint; srcY1: TGLint; dstX0: TGLint; dstY0: TGLint; dstX1: TGLint; dstY1: TGLint; mask: TGLbitfield; filter: TGLenum); 

  (* GL_EXT_framebuffer_multisample *)
  TglRenderbufferStorageMultisampleEXT = PROCEDURE { WINAPI }(target: TGLenum; samples: TGLsizei; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 

  (* GL_EXT_timer_query *)
  TglGetQueryObjecti64vEXT = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLint64EXT); 
  TglGetQueryObjectui64vEXT = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLuint64EXT); 

  (* GL_EXT_gpu_program_parameters *)
  TglProgramEnvParameters4fvEXT = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 
  TglProgramLocalParameters4fvEXT = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 

  (* GL_EXT_bindable_uniform *)
  TglUniformBufferEXT = PROCEDURE { WINAPI }(_program: TGLuint; location: TGLint; buffer: TGLuint); 
  TglGetUniformBufferSizeEXT = PROCEDURE { WINAPI } (_program: TGLuint; location: TGLint): TGLint; 
  TglGetUniformOffsetEXT = PROCEDURE { WINAPI }( _program: TGLuint; location: TGLint): PGLint; 

  (* GL_EXT_draw_buffers2 *)
  TglColorMaskIndexedEXT = PROCEDURE { WINAPI }(buf: TGLuint; r: TGLboolean; g: TGLboolean; b: TGLboolean; a: TGLboolean); 
  TglGetBooleanIndexedvEXT = PROCEDURE { WINAPI }(value: TGLenum; index: TGLuint; data: PGLboolean); 
  TglGetIntegerIndexedvEXT = PROCEDURE { WINAPI }(value: TGLenum; index: TGLuint; data: PGLint); 
  TglEnableIndexedEXT = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint); 
  TglDisableIndexedEXT = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint); 
  TglIsEnabledIndexedEXT = PROCEDURE { WINAPI } (target: TGLenum; index: TGLuint): TGLboolean; 

  (* GL_EXT_draw_instanced *)
  TglDrawArraysInstancedEXT = PROCEDURE { WINAPI }(mode: TGLenum; first: TGLint; count: TGLsizei; primcount: TGLsizei); 
  TglDrawElementsInstancedEXT = PROCEDURE { WINAPI }(mode: TGLenum; count: TGLsizei; _type: TGLenum; CONST indices: Pointer; primcount: TGLsizei); 

  (* GL_EXT_geometry_shader4 *)
  TglProgramParameteriEXT = PROCEDURE { WINAPI } (_program: TGLuint; pname: TGLenum; value: TGLint); 
  TglFramebufferTextureEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint); 
(*  TglFramebufferTextureLayerEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; layer: TGLint);  *)
  TglFramebufferTextureFaceEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; face: TGLenum); 

  (* GL_EXT_gpu_shader4 *)
  TglVertexAttribI1iEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLint); 
  TglVertexAttribI2iEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLint; y: TGLint); 
  TglVertexAttribI3iEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLint; y: TGLint; z: TGLint); 
  TglVertexAttribI4iEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglVertexAttribI1uiEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLuint); 
  TglVertexAttribI2uiEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLuint; y: TGLuint); 
  TglVertexAttribI3uiEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint); 
  TglVertexAttribI4uiEXT = PROCEDURE { WINAPI }(index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglVertexAttribI1ivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI2ivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI3ivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI4ivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLint); 
  TglVertexAttribI1uivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI2uivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI3uivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI4uivEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLuint); 
  TglVertexAttribI4bvEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLbyte); 
  TglVertexAttribI4svEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttribI4ubvEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttribI4usvEXT = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLushort); 
  TglVertexAttribIPointerEXT = PROCEDURE { WINAPI }(index: TGLuint; size: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: Pointer); 
  TglGetVertexAttribIivEXT = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribIuivEXT = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLuint); 
  TglUniform1uiEXT = PROCEDURE { WINAPI }(location: TGLint; v0: TGLuint); 
  TglUniform2uiEXT = PROCEDURE { WINAPI }(location: TGLint; v0: TGLuint; v1: TGLuint); 
  TglUniform3uiEXT = PROCEDURE { WINAPI }(location: TGLint; v0: TGLuint; v1: TGLuint; v2: TGLuint); 
  TglUniform4uiEXT = PROCEDURE { WINAPI }(location: TGLint; v0: TGLuint; v1: TGLuint; v2: TGLuint; v3: TGLuint); 
  TglUniform1uivEXT = PROCEDURE { WINAPI }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform2uivEXT = PROCEDURE { WINAPI }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform3uivEXT = PROCEDURE { WINAPI }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglUniform4uivEXT = PROCEDURE { WINAPI }(location: TGLint; count: TGLsizei; CONST value: PGLuint); 
  TglGetUniformuivEXT = PROCEDURE { WINAPI }(_program: TGLuint; location: TGLint; params: PGLuint); 
  TglBindFragDataLocationEXT = PROCEDURE { WINAPI }(_program: TGLuint; colorNumber: TGLuint; CONST name: PGLchar); 
  TglGetFragDataLocationEXT = PROCEDURE { WINAPI } (_program: TGLuint; CONST name: ARRAY OF CHAR): TGLint;

  (* GL_EXT_texture_array *)
  TglFramebufferTextureLayerEXT = PROCEDURE { WINAPI }(target: TGLenum; attachment: TGLenum; texture: TGLuint; level: TGLint; layer: TGLint); 

  (* GL_EXT_texture_buffer_object *)
  TglTexBufferEXT = PROCEDURE { WINAPI }(target: TGLenum; internalformat: TGLenum; buffer: TGLuint); 

  (* GL_EXT_texture_integer *)
  TglClearColorIiEXT = PROCEDURE { WINAPI }(r: TGLint; g: TGLint; b: TGLint; a: TGLint); 
  TglClearColorIuiEXT = PROCEDURE { WINAPI }(r: TGLuint; g: TGLuint; b: TGLuint; a: TGLuint); 
  TglTexParameterIivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglTexParameterIuivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLuint); 
  TglGetTexParameterIivEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetTexParameterIiuvEXT = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLuint); 

  (* GL_HP_image_transform *)
  TglImageTransformParameteriHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLint); 
  TglImageTransformParameterfHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; param: TGLfloat); 
  TglImageTransformParameterivHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglImageTransformParameterfvHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetImageTransformParameterivHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetImageTransformParameterfvHP = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_EXT_depth_bounds_test *)
  TglDepthBoundsEXT = PROCEDURE { WINAPI }(zmin: TGLclampd; zmax: TGLclampd); 

  (* GL_EXT_blend_equation_separate *)
  TglBlendEquationSeparateEXT = PROCEDURE { WINAPI }(modeRGB: TGLenum; modeAlpha: TGLenum); 

  (* GL_EXT_transform_feedback *)
  TglBeginTransformFeedbackEXT = PROCEDURE { WINAPI }(primitiveMode: GLenum); 
  TglEndTransformFeedbackEXT = PROCEDURE { WINAPI }(); 
  TglBindBufferRangeEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei); 
  TglBindBufferOffsetEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei); 
  TglBindBufferBaseEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryingsEXT = PROCEDURE { WINAPI }(program_: GLuint; count: GLsizei; CONST locations: PGLint; bufferMode: GLenum); 
  TglGetTransformFeedbackVaryingEXT = PROCEDURE { WINAPI }(program_: GLuint; index_: GLuint; location: PGLint); 

  (* GL_EXT_direct_state_access *)
  TglClientAttribDefaultEXT = PROCEDURE { WINAPI }(mask: GLbitfield);  
  TglPushClientAttribDefaultEXT = PROCEDURE { WINAPI }(mask: GLbitfield);  
  TglMatrixLoadfEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixLoaddEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixMultfEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixMultdEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixLoadIdentityEXT = PROCEDURE { WINAPI }(mode: GLenum);  
  TglMatrixRotatefEXT = PROCEDURE { WINAPI }(mode: GLenum; angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixRotatedEXT = PROCEDURE { WINAPI }(mode: GLenum; angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixScalefEXT = PROCEDURE { WINAPI }(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixScaledEXT = PROCEDURE { WINAPI }(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixTranslatefEXT = PROCEDURE { WINAPI }(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);  
  TglMatrixTranslatedEXT = PROCEDURE { WINAPI }(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglMatrixFrustumEXT = PROCEDURE { WINAPI }(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);  
  TglMatrixOrthoEXT = PROCEDURE { WINAPI }(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);  
  TglMatrixPopEXT = PROCEDURE { WINAPI }(mode: GLenum);  
  TglMatrixPushEXT = PROCEDURE { WINAPI }(mode: GLenum);  
  TglMatrixLoadTransposefEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixLoadTransposedEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLdouble);  
  TglMatrixMultTransposefEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLfloat);  
  TglMatrixMultTransposedEXT = PROCEDURE { WINAPI }(mode: GLenum; CONST m: PGLdouble);  
  TglTextureParameterfEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; param: GLfloat);  
  TglTextureParameterfvEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglTextureParameteriEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; param: GLint);  
  TglTextureParameterivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglTextureImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyTextureImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);  
  TglCopyTextureImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);  
  TglCopyTextureSubImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);  
  TglCopyTextureSubImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetTextureImageEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);  
  TglGetTextureParameterfvEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetTextureParameterivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetTextureLevelParameterfvEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);  
  TglGetTextureLevelParameterivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: GLint);  
  TglTextureImage3DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglTextureSubImage3DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyTextureSubImage3DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglMultiTexParameterfEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexParameterfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexParameteriEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexParameterivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglCopyMultiTexImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);  
  TglCopyMultiTexImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);  
  TglCopyMultiTexSubImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);  
  TglCopyMultiTexSubImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglGetMultiTexImageEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);  
  TglGetMultiTexParameterfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexParameterivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexLevelParameterfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexLevelParameterivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLint);  
  TglMultiTexImage3DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum; CONST pixels: PGLvoid);  
  TglMultiTexSubImage3DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum; CONST pixels:PGLvoid);  
  TglCopyMultiTexSubImage3DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);  
  TglBindMultiTextureEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; texture: GLuint);  
  TglEnableClientStateIndexedEXT = PROCEDURE { WINAPI }(array_: GLenum; index_: GLuint);  
  TglDisableClientStateIndexedEXT = PROCEDURE { WINAPI }(array_: GLenum; index_: GLuint);  
  TglMultiTexCoordPointerEXT = PROCEDURE { WINAPI }(texunit: GLenum; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid);  
  TglMultiTexEnvfEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexEnvfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexEnviEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexEnvivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexGendEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLdouble);  
  TglMultiTexGendvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLdouble);  
  TglMultiTexGenfEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);  
  TglMultiTexGenfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLfloat);  
  TglMultiTexGeniEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);  
  TglMultiTexGenivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglGetMultiTexEnvfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexEnvivEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexGendvEXT = PROCEDURE { WINAPI }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLdouble);  
  TglGetMultiTexGenfvEXT = PROCEDURE { WINAPI }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLfloat);  
  TglGetMultiTexGenivEXT = PROCEDURE { WINAPI }(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLint);  
  TglGetFloatIndexedvEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PGLfloat);  
  TglGetDoubleIndexedvEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PGLdouble);  
  TglGetPointerIndexedvEXT = PROCEDURE { WINAPI }(target: GLenum; index_: GLuint; data: PPGLvoid);  
  TglCompressedTextureImage3DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage3DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage2DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedTextureSubImage1DEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglGetCompressedTextureImageEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; lod: GLint; img: PGLvoid);  
  TglCompressedMultiTexImage3DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage3DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage2DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglCompressedMultiTexSubImage1DEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei; CONST bits: PGLvoid);  
  TglGetCompressedMultiTexImageEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; lod: GLint; img: PGLvoid);  
  TglNamedProgramStringEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; format: GLenum; len: GLsizei; CONST string_: PGLvoid);  
  TglNamedProgramLocalParameter4dEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglNamedProgramLocalParameter4dvEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLdouble);  
  TglNamedProgramLocalParameter4fEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);  
  TglNamedProgramLocalParameter4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLfloat);  
  TglGetNamedProgramLocalParameterdvEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLdouble);  
  TglGetNamedProgramLocalParameterfvEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLfloat);  
  TglGetNamedProgramivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetNamedProgramStringEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; pname: GLenum; string_: PGLvoid);  
  TglNamedProgramLocalParameters4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLfloat);  
  TglNamedProgramLocalParameterI4iEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);  
  TglNamedProgramLocalParameterI4ivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLint);  
  TglNamedProgramLocalParametersI4ivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLint);  
  TglNamedProgramLocalParameterI4uiEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);  
  TglNamedProgramLocalParameterI4uivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; CONST params: PGLuint);  
  TglNamedProgramLocalParametersI4uivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; count: GLsizei; CONST params: PGLuint);  
  TglGetNamedProgramLocalParameterIivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLint);  
  TglGetNamedProgramLocalParameterIuivEXT = PROCEDURE { WINAPI }(program_: GLuint; target: GLenum; index_: GLuint; params: PGLuint);  
  TglTextureParameterIivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglTextureParameterIuivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLuint);  
  TglGetTextureParameterIivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetTextureParameterIuivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);  
  TglMultiTexParameterIivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLint);  
  TglMultiTexParameterIuivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; CONST params: PGLuint);  
  TglGetMultiTexParameterIivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);  
  TglGetMultiTexParameterIuivEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);  
  TglProgramUniform1fEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat);  
  TglProgramUniform2fEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);  
  TglProgramUniform3fEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);  
  TglProgramUniform4fEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);  
  TglProgramUniform1iEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint);  
  TglProgramUniform2iEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint);  
  TglProgramUniform3iEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);  
  TglProgramUniform4iEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);  
  TglProgramUniform1fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform2fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform3fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLfloat);  
  TglProgramUniform1ivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform2ivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform3ivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniform4ivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint);  
  TglProgramUniformMatrix2fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix2x3fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3x2fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix2x4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4x2fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix3x4fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniformMatrix4x3fvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLfloat);  
  TglProgramUniform1uiEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint);  
  TglProgramUniform2uiEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint);  
  TglProgramUniform3uiEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);  
  TglProgramUniform4uiEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);  
  TglProgramUniform1uivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform2uivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform3uivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglProgramUniform4uivEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint);  
  TglNamedBufferDataEXT = PROCEDURE { WINAPI }(buffer: GLuint; size: GLsizei; CONST data: PGLvoid; usage: GLenum);  
  TglNamedBufferSubDataEXT = PROCEDURE { WINAPI }(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; CONST data: PGLvoid);  
  TglMapNamedBufferEXT = PROCEDURE { WINAPI }(buffer: GLuint; access: GLenum): PGLvoid;  
  TglUnmapNamedBufferEXT = PROCEDURE { WINAPI }(buffer: GLuint): GLboolean;  
  TglMapNamedBufferRangeEXT = PROCEDURE { WINAPI }(buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): PGLvoid;  
  TglFlushMappedNamedBufferRangeEXT = PROCEDURE { WINAPI }(buffer: GLuint; offset: GLintptr; length: GLsizeiptr);  
  TglNamedCopyBufferSubDataEXT = PROCEDURE { WINAPI }(readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr);  
  TglGetNamedBufferParameterivEXT = PROCEDURE { WINAPI }(buffer: GLuint; pname: GLenum; params: PGLint);  
  TglGetNamedBufferPointervEXT = PROCEDURE { WINAPI }(buffer: GLuint; pname: GLenum; params: PPGLvoid);  
  TglGetNamedBufferSubDataEXT = PROCEDURE { WINAPI }(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: PGLvoid);  
  TglTextureBufferEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint);  
  TglMultiTexBufferEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; interformat: GLenum; buffer: GLuint);  
  TglNamedRenderbufferStorageEXT = PROCEDURE { WINAPI }(renderbuffer: GLuint; interformat: GLenum; width: GLsizei; height: GLsizei);  
  TglGetNamedRenderbufferParameterivEXT = PROCEDURE { WINAPI }(renderbuffer: GLuint; pname: GLenum; params: PGLint);  
  TglCheckNamedFramebufferStatusEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; target: GLenum): GLenum;  
  TglNamedFramebufferTexture1DEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTexture2DEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTexture3DEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);  
  TglNamedFramebufferRenderbufferEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);  
  TglGetNamedFramebufferAttachmentParameterivEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint);  
  TglGenerateTextureMipmapEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum);  
  TglGenerateMultiTexMipmapEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum);  
  TglFramebufferDrawBufferEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; mode: GLenum);  
  TglFramebufferDrawBuffersEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; n: GLsizei; CONST bufs: PGLenum);  
  TglFramebufferReadBufferEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; mode: GLenum);  
  TglGetFramebufferParameterivEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; pname: GLenum; params: PGLint);  
  TglNamedRenderbufferStorageMultisampleEXT = PROCEDURE { WINAPI }(renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);  
  TglNamedRenderbufferStorageMultisampleCoverageEXT = PROCEDURE { WINAPI }(renderbuffer: GLuint; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);  
  TglNamedFramebufferTextureEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint);  
  TglNamedFramebufferTextureLayerEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);  
  TglNamedFramebufferTextureFaceEXT = PROCEDURE { WINAPI }(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);  
  TglTextureRenderbufferEXT = PROCEDURE { WINAPI }(texture: GLuint; target: GLenum; renderbuffer: GLuint);  
  TglMultiTexRenderbufferEXT = PROCEDURE { WINAPI }(texunit: GLenum; target: GLenum; renderbuffer: GLuint);  
  TglProgramUniform1dEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLdouble);  
  TglProgramUniform2dEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble);  
  TglProgramUniform3dEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglProgramUniform4dEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglProgramUniform1dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform2dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform3dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniform4dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLdouble);  
  TglProgramUniformMatrix2dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix2x3dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix2x4dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3x2dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix3x4dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4x2dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  
  TglProgramUniformMatrix4x3dvEXT = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; transpose: GLboolean; CONST value: PGLdouble);  

  (* GL_EXT_separate_shader_objects *)
  TglUseShaderProgramEXT = PROCEDURE { WINAPI }(_type: GLenum; _program: GLuint); 
  TglActiveProgramEXT = PROCEDURE { WINAPI }(_program: GLuint); 
  TglCreateShaderProgramEXT = PROCEDURE { WINAPI } (_type: GLenum; CONST xstring: PGLchar): GLuint; 

   (* GL_EXT_shader_image_load_store *)
  TglBindImageTextureEXT = PROCEDURE { WINAPI }(index: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLint);  
  TglMemoryBarrierEXT = PROCEDURE { WINAPI }(barriers: GLbitfield);  

  (* GL_EXT_vertex_attrib_64bit *)
  TglVertexAttribL1dEXT = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble);  
  TglVertexAttribL2dEXT = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble);  
  TglVertexAttribL3dEXT = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);  
  TglVertexAttribL4dEXT = PROCEDURE { WINAPI }(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);  
  TglVertexAttribL1dvEXT = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL2dvEXT = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL3dvEXT = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribL4dvEXT = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLdouble);  
  TglVertexAttribLPointerEXT = PROCEDURE { WINAPI }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; CONST pointer: PGLvoid);  
  TglGetVertexAttribLdvEXT = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLdouble);  
  TglVertexArrayVertexAttribLOffsetEXT = PROCEDURE { WINAPI }(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; offset: GLintptr);  
  
  (*  GL_MESA_resize_buffers *)
  TglResizeBuffersMESA = PROCEDURE { WINAPI }(); 

  (* GL_MESA_window_pos *)
  TglWindowPos2dMESA = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble); 
  TglWindowPos2dvMESA = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos2fMESA = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat); 
  TglWindowPos2fvMESA = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos2iMESA = PROCEDURE { WINAPI }(x: TGLint; y: TGLint); 
  TglWindowPos2ivMESA = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos2sMESA = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort); 
  TglWindowPos2svMESA = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglWindowPos3dMESA = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglWindowPos3dvMESA = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos3fMESA = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglWindowPos3fvMESA = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos3iMESA = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint); 
  TglWindowPos3ivMESA = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos3sMESA = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort); 
  TglWindowPos3svMESA = PROCEDURE { WINAPI }(CONST v: PGLshort); 
  TglWindowPos4dMESA = PROCEDURE { WINAPI }(x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglWindowPos4dvMESA = PROCEDURE { WINAPI }(CONST v: PGLdouble); 
  TglWindowPos4fMESA = PROCEDURE { WINAPI }(x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglWindowPos4fvMESA = PROCEDURE { WINAPI }(CONST v: PGLfloat); 
  TglWindowPos4iMESA = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglWindowPos4ivMESA = PROCEDURE { WINAPI }(CONST v: PGLint); 
  TglWindowPos4sMESA = PROCEDURE { WINAPI }(x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglWindowPos4svMESA = PROCEDURE { WINAPI }(CONST v: PGLshort); 

  (* GL_NV_evaluators *)
  TglMapControlPointsNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; _type: TGLenum; ustride: TGLsizei; vstride: TGLsizei; uorder: TGLint; vorder: TGLint; _packed: TGLboolean; CONST points: PGLvoid); 
  TglMapParameterivNV = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLint); 
  TglMapParameterfvNV = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetMapControlPointsNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; _type: TGLenum; ustride: TGLsizei; vstride: TGLsizei; _packed: TGLboolean; points: PGLvoid); 
  TglGetMapParameterivNV = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetMapParameterfvNV = PROCEDURE { WINAPI }(target: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetMapAttribParameterivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetMapAttribParameterfvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglEvalMapsNV = PROCEDURE { WINAPI }(target: TGLenum; mode: TGLenum); 

  (* GL_NV_fence *)
  TglDeleteFencesNV = PROCEDURE { WINAPI }(n: TGLsizei; CONST fences: PGLuint); 
  TglGenFencesNV = PROCEDURE { WINAPI }(n: TGLsizei; fences: PGLuint); 
  TglIsFenceNV = PROCEDURE { WINAPI } (fence: TGLuint): TGLboolean; 
  TglTestFenceNV = PROCEDURE { WINAPI } (fence: TGLuint): TGLboolean; 
  TglGetFenceivNV = PROCEDURE { WINAPI }(fence: TGLuint; pname: TGLenum; params: PGLint); 
  TglFinishFenceNV = PROCEDURE { WINAPI }(fence: TGLuint); 
  TglSetFenceNV = PROCEDURE { WINAPI }(fence: TGLuint; condition: TGLenum); 

  (* GL_NV_fragment_program *)
  TglProgramNamedParameter4fNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramNamedParameter4dNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramNamedParameter4fvNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; CONST v: PGLfloat); 
  TglProgramNamedParameter4dvNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; CONST v: PGLdouble); 
  TglGetProgramNamedParameterfvNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; params: PGLfloat); 
  TglGetProgramNamedParameterdvNV = PROCEDURE { WINAPI }(id: TGLuint; len: TGLsizei; CONST name: PGLubyte; params: PGLdouble); 

  (* GL_NV_half_float *)
  TglVertex2hNV = PROCEDURE { WINAPI }(x: TGLhalfNV; y: TGLhalfNV); 
  TglVertex2hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglVertex3hNV = PROCEDURE { WINAPI }(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV); 
  TglVertex3hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglVertex4hNV = PROCEDURE { WINAPI }(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV); 
  TglVertex4hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglNormal3hNV = PROCEDURE { WINAPI }(nx: TGLhalfNV; ny: TGLhalfNV; nz: TGLhalfNV); 
  TglNormal3hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglColor3hNV = PROCEDURE { WINAPI }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV); 
  TglColor3hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglColor4hNV = PROCEDURE { WINAPI }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV; alpha: TGLhalfNV); 
  TglColor4hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglTexCoord1hNV = PROCEDURE { WINAPI }(s: TGLhalfNV); 
  TglTexCoord1hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglTexCoord2hNV = PROCEDURE { WINAPI }(s: TGLhalfNV; t: TGLhalfNV); 
  TglTexCoord2hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglTexCoord3hNV = PROCEDURE { WINAPI }(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV); 
  TglTexCoord3hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglTexCoord4hNV = PROCEDURE { WINAPI }(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV); 
  TglTexCoord4hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglMultiTexCoord1hNV = PROCEDURE { WINAPI }(target: TGLenum; s: TGLhalfNV); 
  TglMultiTexCoord1hvNV = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord2hNV = PROCEDURE { WINAPI }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV); 
  TglMultiTexCoord2hvNV = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord3hNV = PROCEDURE { WINAPI }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV); 
  TglMultiTexCoord3hvNV = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLhalfNV); 
  TglMultiTexCoord4hNV = PROCEDURE { WINAPI }(target: TGLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV); 
  TglMultiTexCoord4hvNV = PROCEDURE { WINAPI }(target: TGLenum; CONST v: PGLhalfNV); 
  TglFogCoordhNV = PROCEDURE { WINAPI }(fog: TGLhalfNV); 
  TglFogCoordhvNV = PROCEDURE { WINAPI }(CONST fog: PGLhalfNV); 
  TglSecondaryColor3hNV = PROCEDURE { WINAPI }(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV); 
  TglSecondaryColor3hvNV = PROCEDURE { WINAPI }(CONST v: PGLhalfNV); 
  TglVertexWeighthNV = PROCEDURE { WINAPI }(weight: TGLhalfNV); 
  TglVertexWeighthvNV = PROCEDURE { WINAPI }(CONST weight: PGLhalfNV); 
  TglVertexAttrib1hNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLhalfNV); 
  TglVertexAttrib1hvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib2hNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV); 
  TglVertexAttrib2hvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib3hNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV); 
  TglVertexAttrib3hvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttrib4hNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV); 
  TglVertexAttrib4hvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLhalfNV); 
  TglVertexAttribs1hvNV = PROCEDURE { WINAPI }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs2hvNV = PROCEDURE { WINAPI }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs3hvNV = PROCEDURE { WINAPI }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 
  TglVertexAttribs4hvNV = PROCEDURE { WINAPI }(index: TGLuint; n: TGLsizei; CONST v: PGLhalfNV); 

  (* GL_NV_occlusion_query *)
  TglGenOcclusionQueriesNV = PROCEDURE { WINAPI }(n: TGLsizei; ids: PGLuint); 
  TglDeleteOcclusionQueriesNV = PROCEDURE { WINAPI }(n: TGLsizei; CONST ids: PGLuint); 
  TglIsOcclusionQueryNV = PROCEDURE { WINAPI } (id: TGLuint): TGLboolean; 
  TglBeginOcclusionQueryNV = PROCEDURE { WINAPI }(id: TGLuint); 
  TglEndOcclusionQueryNV = PROCEDURE { WINAPI }(); 
  TglGetOcclusionQueryivNV = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetOcclusionQueryuivNV = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLuint); 

  (* GL_NV_pixel_data_range *)
  TglPixelDataRangeNV = PROCEDURE { WINAPI }(target: TGLenum; length: TGLsizei; _pointer: PGLvoid); 
  TglFlushPixelDataRangeNV = PROCEDURE { WINAPI }(target: TGLenum); 

  (* GL_NV_point_sprite *)
  TglPointParameteriNV = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglPointParameterivNV = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLint); 

  (* GL_NV_primitive_restart *)
  TglPrimitiveRestartNV = PROCEDURE { WINAPI }(); 
  TglPrimitiveRestartIndexNV = PROCEDURE { WINAPI }(index: TGLuint); 

  (* GL_NV_register_combiners *)
  TglCombinerParameterfvNV = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLfloat); 
  TglCombinerParameterfNV = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLfloat); 
  TglCombinerParameterivNV = PROCEDURE { WINAPI }(pname: TGLenum; CONST params: PGLint); 
  TglCombinerParameteriNV = PROCEDURE { WINAPI }(pname: TGLenum; param: TGLint); 
  TglCombinerInputNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; variable: TGLenum; input: TGLenum; mapping: TGLenum; componentUsage: TGLenum); 
  TglCombinerOutputNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; abOutput: TGLenum; cdOutput: TGLenum; sumOutput: TGLenum; scale: TGLenum; bias: TGLenum; abDotProduct: TGLboolean; cdDotProduct: TGLboolean; muxSum: TGLboolean); 
  TglFinalCombinerInputNV = PROCEDURE { WINAPI }(variable: TGLenum; input: TGLenum; mapping: TGLenum; componentUsage: TGLenum); 
  TglGetCombinerInputParameterfvNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; variable: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetCombinerInputParameterivNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; variable: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetCombinerOutputParameterfvNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetCombinerOutputParameterivNV = PROCEDURE { WINAPI }(stage: TGLenum; portion: TGLenum; pname: TGLenum; params: PGLint); 
  TglGetFinalCombinerInputParameterfvNV = PROCEDURE { WINAPI }(variable: TGLenum; pname: TGLenum; params: PGLfloat); 
  TglGetFinalCombinerInputParameterivNV = PROCEDURE { WINAPI }(variable: TGLenum; pname: TGLenum; params: PGLint); 

  (* GL_NV_register_combiners2*)
  TglCombinerStageParameterfvNV = PROCEDURE { WINAPI }(stage: TGLenum; pname: TGLenum; CONST params: PGLfloat); 
  TglGetCombinerStageParameterfvNV = PROCEDURE { WINAPI }(stage: TGLenum; pname: TGLenum; params: PGLfloat); 

  (* GL_NV_vertex_array_range *)
  TglFlushVertexArrayRangeNV = PROCEDURE { WINAPI }(); 
  TglVertexArrayRangeNV = PROCEDURE { WINAPI }(length: TGLsizei; CONST _pointer: PGLvoid); 

  (* GL_NV_vertex_program *)
  TglAreProgramsResidentNV = PROCEDURE { WINAPI } (n: TGLsizei; CONST programs: PGLuint; residences: PGLboolean): TGLboolean; 
  TglBindProgramNV = PROCEDURE { WINAPI }(target: TGLenum; id: TGLuint); 
  TglDeleteProgramsNV = PROCEDURE { WINAPI }(n: TGLsizei; CONST programs: PGLuint); 
  TglExecuteProgramNV = PROCEDURE { WINAPI }(target: TGLenum; id: TGLuint; CONST params: PGLfloat); 
  TglGenProgramsNV = PROCEDURE { WINAPI }(n: TGLsizei; programs: PGLuint); 
  TglGetProgramParameterdvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetProgramParameterfvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetProgramivNV = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetProgramStringNV = PROCEDURE { WINAPI }(id: TGLuint; pname: TGLenum; _program: PGLubyte); 
  TglGetTrackMatrixivNV = PROCEDURE { WINAPI }(target: TGLenum; address: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribdvNV = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLdouble); 
  TglGetVertexAttribfvNV = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLfloat); 
  TglGetVertexAttribivNV = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; params: PGLint); 
  TglGetVertexAttribPointervNV = PROCEDURE { WINAPI }(index: TGLuint; pname: TGLenum; _pointer: PGLvoid); 
  TglIsProgramNV = PROCEDURE { WINAPI } (id: TGLuint): TGLboolean; 
  TglLoadProgramNV = PROCEDURE { WINAPI }(target: TGLenum; id: TGLuint; len: TGLsizei; CONST _program: PGLubyte); 
  TglProgramParameter4dNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglProgramParameter4dvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST v: PGLdouble); 
  TglProgramParameter4fNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglProgramParameter4fvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST v: PGLfloat); 
  TglProgramParameters4dvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLuint; CONST v: PGLdouble); 
  TglProgramParameters4fvNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLuint; CONST v: PGLfloat); 
  TglRequestResidentProgramsNV = PROCEDURE { WINAPI }(n: TGLsizei; CONST programs: PGLuint); 
  TglTrackMatrixNV = PROCEDURE { WINAPI }(target: TGLenum; address: TGLuint; matrix: TGLenum; transform: TGLenum); 
  TglVertexAttribPointerNV = PROCEDURE { WINAPI }(index: TGLuint; fsize: TGLint; _type: TGLenum; stride: TGLsizei; CONST _pointer: PGLvoid); 
  TglVertexAttrib1dNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble); 
  TglVertexAttrib1dvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib1fNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat); 
  TglVertexAttrib1fvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib1sNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort); 
  TglVertexAttrib1svNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib2dNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble); 
  TglVertexAttrib2dvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib2fNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat); 
  TglVertexAttrib2fvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib2sNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort); 
  TglVertexAttrib2svNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib3dNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble); 
  TglVertexAttrib3dvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib3fNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat); 
  TglVertexAttrib3fvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib3sNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort); 
  TglVertexAttrib3svNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4dNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLdouble; y: TGLdouble; z: TGLdouble; w: TGLdouble); 
  TglVertexAttrib4dvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLdouble); 
  TglVertexAttrib4fNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLfloat; y: TGLfloat; z: TGLfloat; w: TGLfloat); 
  TglVertexAttrib4fvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLfloat); 
  TglVertexAttrib4sNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLshort; y: TGLshort; z: TGLshort; w: TGLshort); 
  TglVertexAttrib4svNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLshort); 
  TglVertexAttrib4ubNV = PROCEDURE { WINAPI }(index: TGLuint; x: TGLubyte; y: TGLubyte; z: TGLubyte; w: TGLubyte); 
  TglVertexAttrib4ubvNV = PROCEDURE { WINAPI }(index: TGLuint; CONST v: PGLubyte); 
  TglVertexAttribs1dvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs1fvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs1svNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs2dvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs2fvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs2svNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs3dvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs3fvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs3svNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs4dvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLdouble); 
  TglVertexAttribs4fvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLfloat); 
  TglVertexAttribs4svNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLshort); 
  TglVertexAttribs4ubvNV = PROCEDURE { WINAPI }(index: TGLuint; count: TGLsizei; CONST v: PGLubyte); 

  (* GL_NV_depth_buffer_float *)
  TglDepthRangedNV = PROCEDURE { WINAPI }(n: TGLdouble; f: TGLdouble); 
  TglClearDepthdNV = PROCEDURE { WINAPI }(d: TGLdouble); 
  TglDepthBoundsdNV = PROCEDURE { WINAPI }(zmin: TGLdouble; zmax: TGLdouble); 

  (* GL_NV_framebuffer_multisample_coverage *)
  TglRenderbufferStorageMultsampleCoverageNV = PROCEDURE { WINAPI }(target: TGLenum; coverageSamples: TGLsizei; colorSamples: TGLsizei; internalformat: TGLenum; width: TGLsizei; height: TGLsizei); 

  (* GL_NV_geometry_program4 *)
  TglProgramVertexLimitNV = PROCEDURE { WINAPI }(target: TGLenum; limit: TGLint); 

  (* GL_NV_gpu_program4 *)
  TglProgramLocalParameterI4iNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglProgramLocalParameterI4ivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLint); 
  TglProgramLocalParametersI4ivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLint); 
  TglProgramLocalParameterI4uiNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglProgramLocalParameterI4uivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLuint); 
  TglProgramLocalParametersI4uivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLuint); 
  TglProgramEnvParameterI4iNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLint; y: TGLint; z: TGLint; w: TGLint); 
  TglProgramEnvParameterI4ivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLint); 
  TglProgramEnvParametersI4ivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLint); 
  TglProgramEnvParameterI4uiNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; x: TGLuint; y: TGLuint; z: TGLuint; w: TGLuint); 
  TglProgramEnvParameterI4uivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; CONST params: PGLuint); 
  TglProgramEnvParametersI4uivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; count: TGLsizei; CONST params: PGLuint); 
  TglGetProgramLocalParameterIivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLint); 
  TglGetProgramLocalParameterIuivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLuint); 
  TglGetProgramEnvParameterIivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLint); 
  TglGetProgramEnvParameterIuivNV = PROCEDURE { WINAPI }(target: TGLenum; index: TGLuint; params: PGLuint); 

  (* GL_NV_parameter_buffer_object *)
  TglProgramBufferParametersfvNV = PROCEDURE { WINAPI }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLsizei; CONST params: PGLfloat); 
  TglProgramBufferParametersIivNV = PROCEDURE { WINAPI }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLsizei; CONST params: TGLint); 
  TglProgramBufferParametersIuivNV = PROCEDURE { WINAPI }(target: TGLenum; buffer: TGLuint; index: TGLuint; count: TGLuint; CONST params: PGLuint); 

  (* GL_NV_transform_feedback *)
  TglBeginTransformFeedbackNV = PROCEDURE { WINAPI }(primitiveMode: TGLenum); 
  TglEndTransformFeedbackNV = PROCEDURE { WINAPI }(); 
  TglTransformFeedbackAttribsNV = PROCEDURE { WINAPI }(count: TGLsizei; CONST attribs: TGLint; bufferMode: TGLenum); 
  TglBindBufferRangeNV = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint; size: GLsizei); 
  TglBindBufferOffsetNV = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint); 
  TglBindBufferBaseNV = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; buffer: GLuint); 
  TglTransformFeedbackVaryingsNV = PROCEDURE { WINAPI }(program_: TGLuint; count: TGLsizei; CONST varyings: PPGLchar; bufferMode: TGLenum); 
  TglActiveVaryingNV = PROCEDURE { WINAPI }(program_: TGLuint; CONST name: PGLchar); 
  TglGetVaryingLocationNV = PROCEDURE { WINAPI } (program_: TGLuint; CONST name: PGLchar): TGLint; 
  TglGetActiveVaryingNV = PROCEDURE { WINAPI }(program_: TGLuint; index: TGLuint; bufSize: TGLsizei; length: PGLsizei; size: PGLsizei; _type: PGLenum; name: PGLchar); 
  TglGetTransformFeedbackVaryingNV = PROCEDURE { WINAPI }(program_: TGLuint; index: TGLuint; location: PGLint); 
   TglTransformFeedbackStreamAttribsNV = PROCEDURE { WINAPI } (count: GLsizei; CONST attribs: PGLint; nbuffers: GLsizei; CONST bufstreams: PGLint; bufferMode: GLenum); 
   
  (* GL_NV_conditional_render *)
  TglBeginConditionalRenderNV = PROCEDURE { WINAPI }(id: GLuint; mode: GLenum); 
  TglEndConditionalRenderNV = PROCEDURE { WINAPI }(); 

  (* GL_NV_present_video *)
  TglPresentFrameKeyedNV = PROCEDURE { WINAPI }(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDuratioId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; key0: GLuint; target1: GLenum; fill1: GLuint; key1: GLuint); 
  TglPresentFrameDualFillNV = PROCEDURE { WINAPI }(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDurationId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; target1: GLenum; fill1: GLuint; target2: GLenum; fill2: GLuint; target3: GLenum; fill3: GLuint); 
  TglGetVideoivNV = PROCEDURE { WINAPI }(video_slot: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideouivNV = PROCEDURE { WINAPI }(video_slot: GLuint; pname: GLenum; params: PGLuint); 
  TglGetVideoi64vNV = PROCEDURE { WINAPI }(video_slot: GLuint; pname: GLenum; params: PGLint64EXT); 
  TglGetVideoui64vNV = PROCEDURE { WINAPI }(video_slot: GLuint; pname: GLenum; params: PGLuint64EXT); 
(*  TglVideoParameterivNV = PROCEDURE { WINAPI }(video_slot: GLuint; pname: GLenum; CONST params: PGLint);  *)
  
  (* GL_NV_explicit_multisample *)
  TglGetMultisamplefvNV = PROCEDURE { WINAPI } (pname: GLenum; index: GLuint; val: PGLfloat); 
  TglSampleMaskIndexedNV = PROCEDURE { WINAPI } (index: GLuint; mask: GLbitfield); 
  TglTexRenderbufferNV = PROCEDURE { WINAPI } (target: GLenum; renderbuffer: GLuint); 

  (* GL_NV_transform_feedback2 *)
  TglBindTransformFeedbackNV = PROCEDURE { WINAPI }(target: GLenum; id: GLuint); 
  TglDeleteTransformFeedbacksNV = PROCEDURE { WINAPI }(n: GLsizei; ids: PGLuint); 
  TglGenTransformFeedbacksNV = PROCEDURE { WINAPI }(n: GLsizei; ids: PGLuint); 
  TglIsTransformFeedbackNV = PROCEDURE { WINAPI }(id: GLuint): GLboolean; 
  TglPauseTransformFeedbackNV = PROCEDURE { WINAPI }(); 
  TglResumeTransformFeedbackNV = PROCEDURE { WINAPI }(); 
  TglDrawTransformFeedbackNV = PROCEDURE { WINAPI }(mode: GLenum; id: GLuint); 

  (* GL_NV_video_capture *)
  TglBeginVideoCaptureNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint); 
  TglBindVideoCaptureStreamBufferNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; offset: GLsizei); 
  TglBindVideoCaptureStreamTextureNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; target: GLenum; texture: GLuint); 
  TglEndVideoCaptureNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint); 
  TglGetVideoCaptureivNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideoCaptureStreamivNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLint); 
  TglGetVideoCaptureStreamfvNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLfloat); 
  TglGetVideoCaptureStreamdvNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLdouble); 
  TglVideoCaptureNV = PROCEDURE { WINAPI } (video_capture_slot: GLuint; sequence_num: PGLuint; capture_time: PGLuint64EXT): GLenum; 
  TglVideoCaptureStreamParameterivNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLint); 
  TglVideoCaptureStreamParameterfvNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLfloat); 
  TglVideoCaptureStreamParameterdvNV = PROCEDURE { WINAPI }(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; CONST params: PGLdouble); 

  (* GL_NV_copy_image *)
  TglCopyImageSubDataNV = PROCEDURE { WINAPI }(srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei); 

    (* GL_NV_shader_buffer_load *)
  TglMakeBufferResidentNV = PROCEDURE { WINAPI }(target: GLenum; access: GLenum); 
  TglMakeBufferNonResidentNV = PROCEDURE { WINAPI }(target: GLenum); 
  TglIsBufferResidentNV = PROCEDURE { WINAPI }(target: GLenum): GLboolean; 
  TglMakeNamedBufferResidentNV = PROCEDURE { WINAPI }(buffer: GLuint; access: GLenum); 
  TglMakeNamedBufferNonResidentNV = PROCEDURE { WINAPI }(buffer: GLuint); 
  TglIsNamedBufferResidentNV = PROCEDURE { WINAPI }(buffer: GLuint): GLboolean; 
  TglGetBufferParameterui64vNV = PROCEDURE { WINAPI }(target: GLenum; pname: GLenum; params: PGLuint64EXT); 
  TglGetNamedBufferParameterui64vNV = PROCEDURE { WINAPI }(buffer: GLuint; pname: GLenum; params: PGLuint64EXT); 
  TglGetIntegerui64vNV = PROCEDURE { WINAPI }(value: GLenum; result: PGLuint64EXT); 
  TglUniformui64NV = PROCEDURE { WINAPI }(location: GLint; value: GLuint64EXT); 
  TglUniformui64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT); 
  TglGetUniformui64vNV = PROCEDURE { WINAPI }(_program: GLuint; location: GLint; params: PGLuint64EXT); 
  TglProgramUniformui64NV = PROCEDURE { WINAPI }(_program: GLuint; location: GLint; value: GLuint64EXT); 
  TglProgramUniformui64vNV = PROCEDURE { WINAPI }(_program: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT); 

  (* GL_NV_vertex_buffer_unified_memory *)
  TglBufferAddressRangeNV = PROCEDURE { WINAPI }(pname: GLenum; index: GLuint; adress: GLuint64EXT; length: GLsizei); 
  TglVertexFormatNV = PROCEDURE { WINAPI }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglNormalFormatNV = PROCEDURE { WINAPI }(_type: GLenum; stride: GLsizei); 
  TglColorFormatNV = PROCEDURE { WINAPI }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglIndexFormatNV = PROCEDURE { WINAPI }(_type: GLenum; stride: GLsizei); 
  TglTexCoordFormatNV = PROCEDURE { WINAPI }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglEdgeFlagFormatNV = PROCEDURE { WINAPI }(stride: GLsizei); 
  TglSecondaryColorFormatNV = PROCEDURE { WINAPI }(size: GLint; _type: GLenum; stride: GLsizei); 
  TglFogCoordFormatNV = PROCEDURE { WINAPI }(_type: GLenum; stride: GLsizei); 
  TglVertexAttribFormatNV = PROCEDURE { WINAPI }(index: GLuint; size: GLint; _type: GLenum; normalized: GLboolean; stride: GLsizei); 
  TglVertexAttribIFormatNV = PROCEDURE { WINAPI }(index: GLuint; size: GLint; _type: GLenum; stride: GLsizei); 
  TglGetIntegerui64i_vNV = PROCEDURE { WINAPI }(value: GLenum; index: GLuint; Result: PGLuint64EXT); 

   (* GL_NV_gpu_program5 *)
  TglProgramSubroutineParametersuivNV = PROCEDURE { WINAPI }(target: GLenum; count: GLsizei; CONST params: PGLuint);  
  TglGetProgramSubroutineParameteruivNV = PROCEDURE { WINAPI }(target: GLenum; index: GLuint; param: PGLuint); 

    (*  GL_NV_gpu_shader5 *)
  TglUniform1i64NV = PROCEDURE { WINAPI }(location: GLint; x: GLint64EXT);  
  TglUniform2i64NV = PROCEDURE { WINAPI }(location: GLint; x: GLint64EXT; y: GLint64EXT);  
  TglUniform3i64NV = PROCEDURE { WINAPI }(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglUniform4i64NV = PROCEDURE { WINAPI }(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglUniform1i64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform2i64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform3i64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform4i64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglUniform1ui64NV = PROCEDURE { WINAPI }(location: GLint; x: GLuint64EXT);  
  TglUniform2ui64NV = PROCEDURE { WINAPI }(location: GLint; x: GLuint64EXT; y: GLuint64EXT);  
  TglUniform3ui64NV = PROCEDURE { WINAPI }(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglUniform4ui64NV = PROCEDURE { WINAPI }(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglUniform1ui64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform2ui64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform3ui64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglUniform4ui64vNV = PROCEDURE { WINAPI }(location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglGetUniformi64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; params: PGLint64EXT);  
  TglProgramUniform1i64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLint64EXT);  
  TglProgramUniform2i64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT);  
  TglProgramUniform3i64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglProgramUniform4i64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglProgramUniform1i64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform2i64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform3i64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform4i64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLint64EXT);  
  TglProgramUniform1ui64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLuint64EXT);  
  TglProgramUniform2ui64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT);  
  TglProgramUniform3ui64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglProgramUniform4ui64NV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglProgramUniform1ui64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform2ui64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform3ui64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  
  TglProgramUniform4ui64vNV = PROCEDURE { WINAPI }(program_: GLuint; location: GLint; count: GLsizei; CONST value: PGLuint64EXT);  

  (* GL_NV_vertex_attrib_integer_64bit *)
  TglVertexAttribL1i64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLint64EXT);  
  TglVertexAttribL2i64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLint64EXT; y: GLint64EXT);  
  TglVertexAttribL3i64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);  
  TglVertexAttribL4i64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);  
  TglVertexAttribL1i64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL2i64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL3i64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL4i64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLint64EXT);  
  TglVertexAttribL1ui64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLuint64EXT);  
  TglVertexAttribL2ui64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT);  
  TglVertexAttribL3ui64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);  
  TglVertexAttribL4ui64NV = PROCEDURE { WINAPI }(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);  
  TglVertexAttribL1ui64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL2ui64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL3ui64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint64EXT);  
  TglVertexAttribL4ui64vNV = PROCEDURE { WINAPI }(index: GLuint; CONST v: PGLuint64EXT);  
  TglGetVertexAttribLi64vNV = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLint64EXT);  
  TglGetVertexAttribLui64vNV = PROCEDURE { WINAPI }(index: GLuint; pname: GLenum; params: PGLuint64EXT);  
  TglVertexAttribLFormatNV = PROCEDURE { WINAPI }(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei);  

  (* GL_NV_vdpau_interop *)
  TglVDPAUInitNV = PROCEDURE { WINAPI }(CONST vdpDevice: PGLvoid; CONST getProcAddress: PGLvoid);  
  TglVDPAUFiniNV = PROCEDURE { WINAPI };  
  TglVDPAURegisterVideoSurfaceNV = PROCEDURE { WINAPI }(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei; CONST textureNames: PGLuint): GLvdpauSurfaceNV;  
  TglVDPAURegisterOutputSurfaceNV = PROCEDURE { WINAPI }(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei; CONST textureNames: PGLuint): GLvdpauSurfaceNV;  
  TglVDPAUIsSurfaceNV = PROCEDURE { WINAPI }(surface: GLvdpauSurfaceNV);  
  TglVDPAUUnregisterSurfaceNV = PROCEDURE { WINAPI }(surface: GLvdpauSurfaceNV);  
  TglVDPAUGetSurfaceivNV = PROCEDURE { WINAPI }(surface: GLvdpauSurfaceNV; pname: GLenum; bufSize: GLsizei; length: PGLsizei; values: PGLint);  
  TglVDPAUSurfaceAccessNV = PROCEDURE { WINAPI }(surface: GLvdpauSurfaceNV; access: GLenum);  
  TglVDPAUMapSurfacesNV = PROCEDURE { WINAPI }(numSurfaces: GLsizei; CONST surfaces: PGLvdpauSurfaceNV);  
  TglVDPAUUnmapSurfacesNV = PROCEDURE { WINAPI }(numSurface: GLsizei; CONST surfaces: PGLvdpauSurfaceNV);  

  (* GL_NV_texture_barrier *)
  TglTextureBarrierNV = PROCEDURE { WINAPI };

 (*! window support functions WINDOWS *)
(* ************************************************* *)

  TwglGetProcAddress = PROCEDURE { WINAPI } (  CONST ProcName: ARRAY OF CHAR): Pointer; 
  TwglCopyContext = PROCEDURE { WINAPI } (p1: HGLRC; p2: HGLRC; p3: Cardinal): BOOLEAN; 
  TwglCreateContext = PROCEDURE { WINAPI } (DC: HDC): HGLRC; 
  TwglCreateLayerContext = PROCEDURE { WINAPI } (p1: HDC; p2: Integer): HGLRC; 
  TwglDeleteContext = PROCEDURE { WINAPI } (p1: HGLRC): BOOLEAN; 
  (*TwglDescribeLayerPlane  = PROCEDURE { WINAPI } (p1: HDC; p2, p3: Integer; p4: Cardinal; p5: PLayerPlaneDescriptor): BOOLEAN; *)
  TwglGetCurrentContext = PROCEDURE { WINAPI }(): HGLRC; 
  TwglGetCurrentDC = PROCEDURE { WINAPI }(): HDC; 
  TwglGetLayerPaletteEntries = PROCEDURE { WINAPI } (p1: HDC; p2, p3, p4: Integer; varpcr: ADDRESS): Integer; 
  TwglMakeCurrent = PROCEDURE { WINAPI } (DC: HDC; p2: HGLRC): BOOLEAN; 
  TwglRealizeLayerPalette  = PROCEDURE { WINAPI } (p1: HDC; p2: Integer; p3: BOOLEAN): BOOLEAN; 
  TwglSetLayerPaletteEntries  = PROCEDURE { WINAPI } (p1: HDC; p2, p3, p4: Integer;  varpcr: ADDRESS): Integer; 
  TwglShareLists = PROCEDURE { WINAPI } (p1, p2: HGLRC): BOOLEAN; 
  TwglSwapLayerBuffers  = PROCEDURE { WINAPI } (p1: HDC; p2: Cardinal): BOOLEAN; 
(*  TwglSwapMultipleBuffers  = PROCEDURE { WINAPI } (p1: UINT; CONST p2: PWGLSWAP): DWORD; *)
  TwglUseFontBitmapsA  = PROCEDURE { WINAPI } (DC: HDC; p2, p3, p4: DWORD): BOOLEAN; 
  TwglUseFontBitmapsW  = PROCEDURE { WINAPI } (DC: HDC; p2, p3, p4: DWORD): BOOLEAN; 
  TwglUseFontBitmaps  = PROCEDURE { WINAPI } (DC: HDC; p2, p3, p4: DWORD): BOOLEAN; 

 (* TwglUseFontOutlinesA  = PROCEDURE { WINAPI } (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN; 
  TwglUseFontOutlinesW  = PROCEDURE { WINAPI } (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN; 
  TwglUseFontOutlines  = PROCEDURE { WINAPI } (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN; 
*)

  (* WGL_ARB_buffer_region *)
  TwglCreateBufferRegionARB  = PROCEDURE { WINAPI } (hDC: HDC; iLayerPlane: TGLint; uType: TGLuint): THandle; 
  TwglDeleteBufferRegionARB  = PROCEDURE { WINAPI }(hRegion: THandle); 
  TwglSaveBufferRegionARB  = PROCEDURE { WINAPI } (hRegion: THandle; x: TGLint; y: TGLint; width: TGLint; height: TGLint): BOOLEAN; 
  TwglRestoreBufferRegionARB  = PROCEDURE { WINAPI } (hRegion: THandle; x: TGLint; y: TGLint; width: TGLint; height: TGLint; xSrc: TGLint; ySrc: TGLint): BOOLEAN; 

  (* WGL_ARB_extensionsxstring *)
  TwglGetExtensionsStringARB = PROCEDURE { WINAPI } (hdc: HDC): ADDRESS; 

  
  (* WGL_ARB_make_current_read *)
  TwglMakeContextCurrentARB  = PROCEDURE { WINAPI } (hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): BOOLEAN; 
  TwglGetCurrentReadDCARB  = PROCEDURE { WINAPI } (): HDC; 

  (* WGL_ARB_pbuffer *)
  TwglCreatePbufferARB  = PROCEDURE { WINAPI } (hDC: HDC; iPixelFormat: TGLint; iWidth: TGLint; iHeight: TGLint;  piAttribList: ADDRESS (* PGLint*)): HPBUFFERARB; 
  TwglGetPbufferDCARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB): HDC; 
  TwglReleasePbufferDCARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; hDC: HDC): TGLint; 
  TwglDestroyPbufferARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB): BOOLEAN; 
  TwglQueryPbufferARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; iAttribute: TGLint;  piValue: ADDRESS (*GLint*)): BOOLEAN; 

  (* WGL_ARB_pixel_format *)
  TwglGetPixelFormatAttribivARB  = PROCEDURE { WINAPI } (hdc: HDC; iPixelFormat: TGLint; iLayerPlane: TGLint; nAttributes: TGLuint; CONST piAttributes: PGLint; piValues: PGLint): BOOLEAN; 
  TwglGetPixelFormatAttribfvARB  = PROCEDURE { WINAPI } (hdc: HDC; iPixelFormat: TGLint; iLayerPlane: TGLint; nAttributes: TGLuint; CONST piAttributes: PGLint; pfValues: PGLfloat): BOOLEAN; 
  TwglChoosePixelFormatARB  = PROCEDURE { WINAPI } (hdc: HDC;  piAttribIList: ADDRESS (*PGLint*);  pfAttribFList: ADDRESS (* PGLfloat*); nMaxFormats: TGLuint; (*VAR*) piFormats: ADDRESS;(*GLint; VAR*) nNumFormats: ADDRESS(*GLuint*)): BOOLEAN; 

  (* WGL_ARB_color_buffer_float *)
  TwglClampColorARB  = PROCEDURE { WINAPI }(target: TGLenum; clamp: TGLenum); 

  (* WGL_ARB_render_texture *)
  TwglBindTexImageARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; iBuffer: TGLint): BOOLEAN; 
  TwglReleaseTexImageARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; iBuffer: TGLint): BOOLEAN; 
  TwglSetPbufferAttribARB  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; CONST piAttribList: PGLint): BOOLEAN; 

  (* WGL_ARB_create_context *)
  TwglCreateContextAttribsARB  = PROCEDURE { WINAPI } (hDC: HDC; hShareContext: HGLRC;  attribList: ADDRESS (*PGLint*)): HGLRC; 

  (* WGL_AMD_gpu_association *)
  TwglGetGPUIDsAMD  = PROCEDURE { WINAPI } (maxCount: Cardinal; ids: PCardinal): Cardinal; 
  TwglGetGPUInfoAMD  = PROCEDURE { WINAPI } (id: Cardinal; property_: Integer; dataType: GLenum; size: Cardinal; data: Pointer): Integer; 
  TwglGetContextGPUIDAMD  = PROCEDURE { WINAPI } (hglrc: HGLRC): Cardinal; 
  TwglCreateAssociatedContextAMD  = PROCEDURE { WINAPI } (id: Cardinal): HGLRC; 
  TwglCreateAssociatedContextAttribsAMD  = PROCEDURE { WINAPI } (id: Cardinal; hShareContext: HGLRC; CONST attribList: PInteger): HGLRC; 
  TwglDeleteAssociatedContextAMD  = PROCEDURE { WINAPI } (hglrc: HGLRC): BOOLEAN; 
  TwglMakeAssociatedContextCurrentAMD  = PROCEDURE { WINAPI } (hglrc: HGLRC): BOOLEAN; 
  TwglGetCurrentAssociatedContextAMD  = PROCEDURE { WINAPI } (): HGLRC; 
  TwglBlitContextFramebufferAMD  = PROCEDURE { WINAPI }(dstCtx: HGLRC; srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum); 

  (* WGL_EXT_display_color_table *)
  TwglCreateDisplayColorTableEXT  = PROCEDURE { WINAPI } (id: TGLushort): TGLboolean; 
  TwglLoadDisplayColorTableEXT  = PROCEDURE { WINAPI } (CONST table: PGLushort; length: TGLuint): TGLboolean; 
  TwglBindDisplayColorTableEXT  = PROCEDURE { WINAPI } (id: TGLushort): TGLboolean; 
  TwglDestroyDisplayColorTableEXT  = PROCEDURE { WINAPI }(id: TGLushort); 

  (* WGL_EXT_extensionsxstring *)
  TwglGetExtensionsStringEXT  = PROCEDURE { WINAPI } (): ADDRESS; 

  (* WGL_EXT_make_current_read *)
  TwglMakeContextCurrentEXT  = PROCEDURE { WINAPI } (hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): BOOLEAN; 
  TwglGetCurrentReadDCEXT  = PROCEDURE { WINAPI } (): HDC; 

  (* WGL_EXT_pbuffer *)
  TwglCreatePbufferEXT  = PROCEDURE { WINAPI } (hDC: HDC; iPixelFormat: TGLint; iWidth: TGLint; iHeight: TGLint; CONST piAttribList: PGLint): HPBUFFEREXT; 
  TwglGetPbufferDCEXT  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFEREXT): HDC; 
  TwglReleasePbufferDCEXT  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFEREXT; hDC: HDC): TGLint; 
  TwglDestroyPbufferEXT  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFEREXT): BOOLEAN; 
  TwglQueryPbufferEXT  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFEREXT; iAttribute: TGLint; piValue: PGLint): BOOLEAN; 

  (* WGL_EXT_pixel_format *)
  TwglGetPixelFormatAttribivEXT  = PROCEDURE { WINAPI } (hdc: HDC; iPixelFormat: TGLint; iLayerPlane: TGLint; nAttributes: TGLuint; piAttributes: PGLint; piValues: PGLint): BOOLEAN; 
  TwglGetPixelFormatAttribfvEXT  = PROCEDURE { WINAPI } (hdc: HDC; iPixelFormat: TGLint; iLayerPlane: TGLint; nAttributes: TGLuint; piAttributes: PGLint; pfValues: PGLfloat): BOOLEAN; 
  TwglChoosePixelFormatEXT  = PROCEDURE { WINAPI } (hdc: HDC; CONST piAttribIList: PGLint; CONST pfAttribFList: PGLfloat; nMaxFormats: TGLuint; piFormats: PGLint; nNumFormats: PGLuint): BOOLEAN; 

  (* WGL_EXT_swap_control *)
  TwglSwapIntervalEXT  = PROCEDURE { WINAPI } (interval: TGLint): BOOLEAN; 
  TwglGetSwapIntervalEXT  = PROCEDURE { WINAPI } ( ): TGLint; 

  (* WGL_I3D_digital_video_control *)
  TwglGetDigitalVideoParametersI3D  = PROCEDURE { WINAPI } (hDC: HDC; iAttribute: TGLint; piValue: PGLint): BOOLEAN; 
  TwglSetDigitalVideoParametersI3D  = PROCEDURE { WINAPI } (hDC: HDC; iAttribute: TGLint; CONST piValue: PGLint): BOOLEAN; 

  (* WGL_I3D_gamma *)
  TwglGetGammaTableParametersI3D  = PROCEDURE { WINAPI } (hDC: HDC; iAttribute: TGLint; piValue: PGLint): BOOLEAN; 
  TwglSetGammaTableParametersI3D  = PROCEDURE { WINAPI } (hDC: HDC; iAttribute: TGLint; CONST piValue: PGLint): BOOLEAN; 
  TwglGetGammaTableI3D  = PROCEDURE { WINAPI } (hDC: HDC; iEntries: TGLint; puRed: PGLushort; puGreen: PGLushort; puBlue: PGLushort): BOOLEAN; 
  TwglSetGammaTableI3D  = PROCEDURE { WINAPI } (hDC: HDC; iEntries: TGLint; CONST puRed: PGLushort; CONST puGreen: PGLushort; CONST puBlue: PGLushort): BOOLEAN; 

  (* WGL_I3D_genlock *)
  TwglEnableGenlockI3D  = PROCEDURE { WINAPI } (hDC: HDC): BOOLEAN; 
  TwglDisableGenlockI3D  = PROCEDURE { WINAPI } ( hDC: HDC): BOOLEAN; 
  TwglIsEnabledGenlockI3D  = PROCEDURE { WINAPI } (hDC: HDC; pFlag: BOOLEAN): BOOLEAN; 
  TwglGenlockSourceI3D  = PROCEDURE { WINAPI } (hDC: HDC; uSource: TGLuint): BOOLEAN; 
  TwglGetGenlockSourceI3D  = PROCEDURE { WINAPI } (hDC: HDC; uSource: PGLuint): BOOLEAN; 
  TwglGenlockSourceEdgeI3D  = PROCEDURE { WINAPI } (hDC: HDC; uEdge: TGLuint): BOOLEAN; 
  TwglGetGenlockSourceEdgeI3D  = PROCEDURE { WINAPI } (hDC: HDC; uEdge: PGLuint): BOOLEAN; 
  TwglGenlockSampleRateI3D  = PROCEDURE { WINAPI } (hDC: HDC; uRate: TGLuint): BOOLEAN; 
  TwglGetGenlockSampleRateI3D  = PROCEDURE { WINAPI } (hDC: HDC; uRate: PGLuint): BOOLEAN; 
  TwglGenlockSourceDelayI3D  = PROCEDURE { WINAPI } ( hDC: HDC; uDelay: TGLuint): BOOLEAN; 
  TwglGetGenlockSourceDelayI3D  = PROCEDURE { WINAPI } (hDC: HDC; uDelay: PGLuint): BOOLEAN; 
  TwglQueryGenlockMaxSourceDelayI3D  = PROCEDURE { WINAPI } (hDC: HDC; uMaxLineDelay: PGLuint; uMaxPixelDelay: PGLuint): BOOLEAN; 

  (* WGL_I3D_image_buffer *)
  TwglCreateImageBufferI3D  = PROCEDURE { WINAPI } (hDC: HDC; dwSize: TGLuint; uFlags: TGLuint): TGLvoid; 
  TwglDestroyImageBufferI3D  = PROCEDURE { WINAPI } (hDC: HDC; pAddress: TGLvoid): BOOLEAN; 
  TwglAssociateImageBufferEventsI3D  = PROCEDURE { WINAPI } (hDC: HDC; CONST pEvent: THandle; CONST pAddress: PGLvoid; CONST pSize: PGLuint; count: TGLuint): BOOLEAN; 
  TwglReleaseImageBufferEventsI3D  = PROCEDURE { WINAPI } (hDC: HDC; CONST pAddress: PGLvoid; count: TGLuint): BOOLEAN; 

  (* WGL_I3D_swap_frame_lock *)
  TwglEnableFrameLockI3D  = PROCEDURE { WINAPI } ( ): BOOLEAN; 
  TwglDisableFrameLockI3D  = PROCEDURE { WINAPI } ( ): BOOLEAN; 
  TwglIsEnabledFrameLockI3D  = PROCEDURE { WINAPI } (pFlag: BOOLEAN): BOOLEAN; 
  TwglQueryFrameLockMasterI3D  = PROCEDURE { WINAPI } (pFlag: BOOLEAN): BOOLEAN; 

  (* WGL_I3D_swap_frame_usage *)
  TwglGetFrameUsageI3D  = PROCEDURE { WINAPI } (pUsage: PGLfloat): BOOLEAN; 
  TwglBeginFrameTrackingI3D  = PROCEDURE { WINAPI } ( ): BOOLEAN; 
  TwglEndFrameTrackingI3D  = PROCEDURE { WINAPI } (): BOOLEAN; 
  TwglQueryFrameTrackingI3D  = PROCEDURE { WINAPI } (pFrameCount: PGLuint; pMissedFrames: PGLuint; pLastMissedUsage: PGLfloat): BOOLEAN; 

  (* WGL_NV_vertex_array_range *)
  TwglAllocateMemoryNV  = PROCEDURE { WINAPI }(size: TGLsizei; readfreq: TGLfloat; writefreq: TGLfloat; priority: TGLfloat); 
  TwglFreeMemoryNV  = PROCEDURE { WINAPI }(_pointer: Pointer); 

  (* WGL_NV_present_video  *)
  TwglEnumerateVideoDevicesNV  = PROCEDURE { WINAPI } (hdc: HDC; phDeviceList: PHVIDEOOUTPUTDEVICENV): Integer; 
  TwglBindVideoDeviceNV  = PROCEDURE { WINAPI } (hd: HDC; uVideoSlot: Cardinal; hVideoDevice: HVIDEOOUTPUTDEVICENV; piAttribList: PInteger): BOOLEAN; 
  TwglQueryCurrentContextNV  = PROCEDURE { WINAPI } (iAttribute: Integer; piValue: PInteger): BOOLEAN; 

  (* WGL_NV_video_output *)
  TwglGetVideoDeviceNV  = PROCEDURE { WINAPI } (hDC: HDC; numDevices: Integer; hVideoDevice: PHPVIDEODEV): BOOLEAN; 
  TwglReleaseVideoDeviceNV  = PROCEDURE { WINAPI } (hVideoDevice: HPVIDEODEV): BOOLEAN; 
  TwglBindVideoImageNV  = PROCEDURE { WINAPI } (hVideoDevice: HPVIDEODEV; hPbuffer: HPBUFFERARB; iVideoBuffer: Integer): BOOLEAN; 
  TwglReleaseVideoImageNV  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; iVideoBuffer: Integer): BOOLEAN; 
  TwglSendPbufferToVideoNV  = PROCEDURE { WINAPI } (hPbuffer: HPBUFFERARB; iBufferType: Integer; pulCounterPbuffer: PCardinal; bBlock: BOOLEAN): BOOLEAN; 
  TwglGetVideoInfoNV  = PROCEDURE { WINAPI } (hpVideoDevice: HPVIDEODEV; pulCounterOutputPbuffer: PCardinal; pulCounterOutputVideo: PCardinal): BOOLEAN; 

  (* WGL_NV_swap_group *)
  TwglJoinSwapGroupNV  = PROCEDURE { WINAPI } (hDC: HDC; group: GLuint): BOOLEAN; 
  TwglBindSwapBarrierNV  = PROCEDURE { WINAPI } (group: GLuint; barrier: GLuint): BOOLEAN; 
  TwglQuerySwapGroupNV  = PROCEDURE { WINAPI } (hDC: HDC; group: PGLuint; barrier: PGLuint): BOOLEAN; 
  TwglQueryMaxSwapGroupsNV  = PROCEDURE { WINAPI } (hDC: HDC; mxGroups: PGLuint; maxBarriers: PGLuint): BOOLEAN; 
  TwglQueryFrameCountNV  = PROCEDURE { WINAPI } (hDC: HDC; count: PGLuint): BOOLEAN; 
  TwglResetFrameCountNV  = PROCEDURE { WINAPI } (hDC: HDC): BOOLEAN; 

  (* WGL_NV_gpu_affinity *)
  TwglEnumGpusNV  = PROCEDURE { WINAPI } (iGpuIndex: Cardinal; phGpu: PHGPUNV): BOOLEAN; 
  TwglEnumGpuDevicesNV  = PROCEDURE { WINAPI } (hGpu: HGPUNV; iDeviceIndex: Cardinal; lpGpuDevice: PGPU_DEVICE): BOOLEAN; 
  TwglCreateAffinityDCNV  = PROCEDURE { WINAPI } ( CONST phGpuList: PHGPUNV): HDC; 
  TwglEnumGpusFromAffinityDCNV  = PROCEDURE { WINAPI } (hAffinityDC: HDC; iGpuIndex: Cardinal; hGpu: PHGPUNV): BOOLEAN; 
  TwglDeleteDCNV  = PROCEDURE { WINAPI } (hDC: HDC): BOOLEAN; 

  (* WGL_NV_video_capture *)
  TwglBindVideoCaptureDeviceNV  = PROCEDURE { WINAPI } (uVideoSlot: Cardinal; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN; 
  TwglEnumerateVideoCaptureDevicesNV  = PROCEDURE { WINAPI } (hDc: HDC; phDeviceList: PHVIDEOINPUTDEVICENV): Cardinal; 
  TwglLockVideoCaptureDeviceNV  = PROCEDURE { WINAPI } (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN; 
  TwglQueryVideoCaptureDeviceNV  = PROCEDURE { WINAPI } (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV; iAttribute: Integer; piValue: PInteger): BOOLEAN; 
  TwglReleaseVideoCaptureDeviceNV  = PROCEDURE { WINAPI } (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN; 

  (* WGL_NV_copy_image *)
  TwglCopyImageSubDataNV  = PROCEDURE { WINAPI } (hSrcRc: HGLRC; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; hDstRC: HGLRC; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei): BOOLEAN; 

  (* WGL_OML_sync_control *)
  TwglGetSyncValuesOML  = PROCEDURE { WINAPI } (hdc: HDC; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN; 
  TwglGetMscRateOML  = PROCEDURE { WINAPI } (hdc: HDC; numerator: PGLint; denominator: PGLint): BOOLEAN; 
  TwglSwapBuffersMscOML  = PROCEDURE { WINAPI } (hdc: HDC; target_msc: TGLint64; divisor: TGLint64; remainder: TGLint64): TGLint64; 
  TwglSwapLayerBuffersMscOML  = PROCEDURE { WINAPI } (hdc: HDC; fuPlanes: TGLint; target_msc: TGLint64; divisor: TGLint64; remainder: TGLint64): TGLint64; 
  TwglWaitForMscOML  = PROCEDURE { WINAPI } (hdc: HDC; target_msc: TGLint64; divisor: TGLint64; remainder: TGLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN; 
  TwglWaitForSbcOML  = PROCEDURE { WINAPI } (hdc: HDC; target_sbc: TGLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN; 


  (* WGL_3DL_stereo_control *)
(*  wglSetStereoEmitterState3DL  = PROCEDURE { WINAPI } (hDC: HDC; uState: UINT): BOOLEAN; *)
  
  (* WIN_draw_range_elements *)
  TglDrawRangeElementsWIN  = PROCEDURE { WINAPI }(mode: TGLenum; start: TGLuint; _end: TGLuint; count: TGLsizei; _type: TGLenum; CONST indices: PGLvoid); 

  (* WIN_swap_hint *)
  TglAddSwapHintRectWIN  = PROCEDURE { WINAPI }(x: TGLint; y: TGLint; width: TGLsizei; height: TGLsizei); 
 (* ENDIF *)


  (*! GL utility functions and procedures *)
VAR

  gluErrorString - : PROCEDURE { WINAPI } (errCode: TGLenum): ADDRESS; (* AnsiChar; *)
  gluGetString - : PROCEDURE { WINAPI } (name: TGLenum): ADDRESS; 
  gluOrtho2D - : PROCEDURE { WINAPI }(left, right, bottom, top: TGLdouble); 
  gluPerspective - : PROCEDURE { WINAPI }(fovy, aspect, zNear, zFar: TGLdouble); 
  gluPickMatrix - : PROCEDURE { WINAPI }(x, y, width, height: TGLdouble; CONST viewport: TVector4i); 
  gluLookAt - : PROCEDURE { WINAPI }(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: TGLdouble); 
  gluProject - : PROCEDURE { WINAPI } (objx, objy, objz: TGLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; winx, winy, winz: PGLdouble): TGLint; 
  gluUnProject - : PROCEDURE { WINAPI } (winx, winy, winz: TGLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; objx, objy, objz: PGLdouble): TGLint; 
  gluScaleImage - : PROCEDURE { WINAPI } (format: TGLenum; widthin, heightin: TGLint; typein: TGLenum; datain: Pointer; widthout, heightout: TGLint; typeout: TGLenum; CONST dataout: Pointer): TGLint; 
  gluBuild1DMipmaps - : PROCEDURE { WINAPI } (target: TGLenum; components, width: TGLint; format, atype: TGLenum; CONST data: Pointer): TGLint; 
  gluBuild2DMipmaps - : PROCEDURE { WINAPI } (target: TGLenum; components, width, height: TGLint; format, atype: TGLenum; CONST Data: Pointer): TGLint; 
  gluNewQuadric - : PROCEDURE { WINAPI }(): TGLUQuadric; 
  gluDeleteQuadric - : PROCEDURE { WINAPI }(state: TGLUQuadric); 
  gluQuadricNormals - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; normals: TGLenum); 
  gluQuadricTexture - : PROCEDURE { WINAPI }(quadObject: PGLUQuadric; textureCoords: TGLboolean); 
  gluQuadricOrientation - : PROCEDURE { WINAPI }(quadObject: PGLUQuadric; orientation: TGLenum); 
  gluQuadricDrawStyle - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; drawStyle: TGLenum); 
  gluCylinder - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; baseRadius, topRadius, height: TGLdouble; slices, stacks: TGLint); 
  gluDisk - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint); 
  gluPartialDisk - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; innerRadius, outerRadius: TGLdouble; slices, loops: TGLint; startAngle, sweepAngle: TGLdouble); 
  gluSphere - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; radius: TGLdouble; slices, stacks: TGLint); 
  gluQuadricCallback - : PROCEDURE { WINAPI }(quadObject: TGLUQuadric; which: TGLenum; fn: ADDRESS (*TGLUQuadricErrorProc*)); 
  gluNewTess - : PROCEDURE { WINAPI }(): PGLUTesselator; 
  gluDeleteTess - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 
  gluTessBeginPolygon - : PROCEDURE { WINAPI }(tess: PGLUTesselator; polygon_data: Pointer); 
  gluTessBeginContour - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 
  gluTessVertex - : PROCEDURE { WINAPI }(tess: PGLUTesselator; CONST coords: TGLArrayd3; data: Pointer); 
  gluTessEndContour - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 
  gluTessEndPolygon - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 
  gluTessProperty - : PROCEDURE { WINAPI }(tess: PGLUTesselator; which: TGLenum; value: TGLdouble); 
  gluTessNormal - : PROCEDURE { WINAPI }(tess: PGLUTesselator; x, y, z: TGLdouble); 
  gluTessCallback - : PROCEDURE { WINAPI }(tess: PGLUTesselator; which: TGLenum; fn: Pointer); 
  gluGetTessProperty - : PROCEDURE { WINAPI }(tess: PGLUTesselator; which: TGLenum; value: PGLdouble); 
  gluNewNurbsRenderer - : PROCEDURE { WINAPI }(): PGLUNurbs; 
  gluDeleteNurbsRenderer - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluBeginSurface - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluBeginCurve - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluEndCurve - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluEndSurface - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluBeginTrim - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluEndTrim - : PROCEDURE { WINAPI }(nobj: PGLUNurbs); 
  gluPwlCurve - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; count: TGLint; points: PGLfloat; stride: TGLint; atype: TGLenum); 
  gluNurbsCurve - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; nknots: TGLint; knot: PGLfloat; stride: TGLint; ctlarray: PGLfloat; order: TGLint; atype: TGLenum); 
  gluNurbsSurface - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; sknot_count: TGLint; sknot: PGLfloat; tknot_count: TGLint; tknot: PGLfloat; s_stride, t_stride: TGLint; ctlarray: PGLfloat; sorder, torder: TGLint; atype: TGLenum); 
  gluLoadSamplingMatrices - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; CONST modelMatrix, projMatrix: TGLMatrixf4; CONST viewport: TVector4i); 
  gluNurbsProperty - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; aproperty: TGLenum; value: TGLfloat); 
  gluGetNurbsProperty - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; aproperty: TGLenum; value: PGLfloat); 
  gluNurbsCallback - : PROCEDURE { WINAPI }(nobj: PGLUNurbs; which: TGLenum; fn: TGLUNurbsErrorProc); 
  gluBeginPolygon - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 
  gluNextContour - : PROCEDURE { WINAPI }(tess: PGLUTesselator; atype: TGLenum); 
  gluEndPolygon - : PROCEDURE { WINAPI }(tess: PGLUTesselator); 

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

  (*// GL_VERSION_1_1*)
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
  
(*! ifdef DEPRECATED *)
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

  (*! GL_VERSION_1_3 *)
  glActiveTexture- : TglActiveTexture;
  glSampleCoverage- : TglSampleCoverage;
  glCompressedTexImage3D- : TglCompressedTexImage3D;
  glCompressedTexImage2D- : TglCompressedTexImage2D;
  glCompressedTexImage1D- : TglCompressedTexImage1D;
  glCompressedTexSubImage3D- : TglCompressedTexSubImage3D;
  glCompressedTexSubImage2D- : TglCompressedTexSubImage2D;
  glCompressedTexSubImage1D- : TglCompressedTexSubImage1D;
  glGetCompressedTexImage- : TglGetCompressedTexImage;
  
(*! ifdef DEPRECATED *)
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

  (*! GL_VERSION_1_4 *)
  glBlendFuncSeparate- : TglBlendFuncSeparate;
  glMultiDrawArrays- : TglMultiDrawArrays;
  glMultiDrawElements- : TglMultiDrawElements;
  glPointParameterf- : TglPointParameterf;
  glPointParameterfv- : TglPointParameterfv;
  glPointParameteri- : TglPointParameteri;
  glPointParameteriv- : TglPointParameteriv;
  
(*! ifdef DEPRECATED *)
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

 (*! WGL_WINDOWS *)
  wglGetProcAddress- : TwglGetProcAddress;
  wglCopyContext- : TwglCopyContext;
  wglCreateContext- : TwglCreateContext;
  wglCreateLayerContext- : TwglCreateLayerContext;
  wglDeleteContext- : TwglDeleteContext;
 (* wglDescribeLayerPlane- : TwglDescribeLayerPlane;*)
  wglGetCurrentContext- : TwglGetCurrentContext;
  wglGetCurrentDC- : TwglGetCurrentDC;
  wglGetLayerPaletteEntries- : TwglGetLayerPaletteEntries;
  wglMakeCurrent- : TwglMakeCurrent;
  wglRealizeLayerPalette- : TwglRealizeLayerPalette;
  wglSetLayerPaletteEntries- : TwglSetLayerPaletteEntries;
  wglShareLists- : TwglShareLists;
  wglSwapLayerBuffers- : TwglSwapLayerBuffers;
(*  wglSwapMultipleBuffers- : TwglSwapMultipleBuffers;*)
  wglUseFontBitmapsA- : TwglUseFontBitmapsA;
(*  wglUseFontOutlinesA- : TwglUseFontOutlinesA;
  wglUseFontBitmapsW- : TwglUseFontBitmapsW;
  wglUseFontOutlinesW- : TwglUseFontOutlinesW;
  wglUseFontBitmaps- : TwglUseFontBitmaps;
  wglUseFontOutlines- : TwglUseFontOutlines;
*)
   (* WGL_ARB_buffer_region *)
  wglCreateBufferRegionARB- : TwglCreateBufferRegionARB;
  wglDeleteBufferRegionARB- : TwglDeleteBufferRegionARB;
  wglSaveBufferRegionARB- : TwglSaveBufferRegionARB;
  wglRestoreBufferRegionARB- : TwglRestoreBufferRegionARB;

  (* WGL_ARB_extensionsxstring *)
  wglGetExtensionsStringARB- : TwglGetExtensionsStringARB;

  (* WGL_ARB_make_current_read *)
  wglMakeContextCurrentARB- : TwglMakeContextCurrentARB;
  wglGetCurrentReadDCARB- : TwglGetCurrentReadDCARB;

  (* WGL_ARB_pbuffer *)
  wglCreatePbufferARB- : TwglCreatePbufferARB;
  wglGetPbufferDCARB- : TwglGetPbufferDCARB;
  wglReleasePbufferDCARB- : TwglReleasePbufferDCARB;
  wglDestroyPbufferARB- : TwglDestroyPbufferARB;
  wglQueryPbufferARB- : TwglQueryPbufferARB;

  (* WGL_ARB_pixel_format *)
  wglGetPixelFormatAttribivARB- : TwglGetPixelFormatAttribivARB;
  wglGetPixelFormatAttribfvARB- : TwglGetPixelFormatAttribfvARB;
  wglChoosePixelFormatARB- : TwglChoosePixelFormatARB;
  (* WGL_ARB_color_buffer_float *)
  wglClampColorARB- : TwglClampColorARB;

  (* WGL_ARB_render_texture *)
  wglBindTexImageARB- : TwglBindTexImageARB;
  wglReleaseTexImageARB- : TwglReleaseTexImageARB;
  wglSetPbufferAttribARB- : TwglSetPbufferAttribARB;

  (* WGL_ARB_create_context *)
  wglCreateContextAttribsARB- : TwglCreateContextAttribsARB;

  (* WGL_AMD_gpu_association *)
  wglGetGPUIDsAMD- : TwglGetGPUIDsAMD;
  wglGetGPUInfoAMD- : TwglGetGPUInfoAMD;
  wglGetContextGPUIDAMD- : TwglGetContextGPUIDAMD;
  wglCreateAssociatedContextAMD- : TwglCreateAssociatedContextAMD;
  wglCreateAssociatedContextAttribsAMD- : TwglCreateAssociatedContextAttribsAMD;
  wglDeleteAssociatedContextAMD- : TwglDeleteAssociatedContextAMD;
  wglMakeAssociatedContextCurrentAMD- : TwglMakeAssociatedContextCurrentAMD;
  wglGetCurrentAssociatedContextAMD- : TwglGetCurrentAssociatedContextAMD;
  wglBlitContextFramebufferAMD- : TwglBlitContextFramebufferAMD;

  (* WGL_EXT_display_color_table *)
  wglCreateDisplayColorTableEXT- : TwglCreateDisplayColorTableEXT;
  wglLoadDisplayColorTableEXT- : TwglLoadDisplayColorTableEXT;
  wglBindDisplayColorTableEXT- : TwglBindDisplayColorTableEXT;
  wglDestroyDisplayColorTableEXT- : TwglDestroyDisplayColorTableEXT;

  (* WGL_EXT_extensionsxstring *)
  wglGetExtensionsStringEXT- : TwglGetExtensionsStringEXT;

  (* WGL_EXT_make_current_read *)
  wglMakeContextCurrentEXT- : TwglMakeContextCurrentEXT;
  wglGetCurrentReadDCEXT- : TwglGetCurrentReadDCEXT;

  (* WGL_EXT_pbuffer *)
  wglCreatePbufferEXT- : TwglCreatePbufferEXT;
  wglGetPbufferDCEXT- : TwglGetPbufferDCEXT;
  wglReleasePbufferDCEXT- : TwglReleasePbufferDCEXT;
  wglDestroyPbufferEXT- : TwglDestroyPbufferEXT;
  wglQueryPbufferEXT- : TwglQueryPbufferEXT;

  (* WGL_EXT_pixel_format *)
  wglGetPixelFormatAttribivEXT- : TwglGetPixelFormatAttribivEXT;
  wglGetPixelFormatAttribfvEXT- : TwglGetPixelFormatAttribfvEXT;
  wglChoosePixelFormatEXT- : TwglChoosePixelFormatEXT;

  (* WGL_EXT_swap_control *)
  wglSwapIntervalEXT- : TwglSwapIntervalEXT;
  wglGetSwapIntervalEXT- : TwglGetSwapIntervalEXT;

  (* WGL_I3D_digital_video_control *)
  wglGetDigitalVideoParametersI3D- : TwglGetDigitalVideoParametersI3D;
  wglSetDigitalVideoParametersI3D- : TwglSetDigitalVideoParametersI3D;

  (* WGL_I3D_gamma *)
  wglGetGammaTableParametersI3D- : TwglGetGammaTableParametersI3D;
  wglSetGammaTableParametersI3D- : TwglSetGammaTableParametersI3D;
  wglGetGammaTableI3D- : TwglGetGammaTableI3D;
  wglSetGammaTableI3D- : TwglSetGammaTableI3D;

  (* WGL_I3D_genlock *)
  wglEnableGenlockI3D- : TwglEnableGenlockI3D;
  wglDisableGenlockI3D- : TwglDisableGenlockI3D;
  wglIsEnabledGenlockI3D- : TwglIsEnabledGenlockI3D;
  wglGenlockSourceI3D- : TwglGenlockSourceI3D;
  wglGetGenlockSourceI3D- : TwglGetGenlockSourceI3D;
  wglGenlockSourceEdgeI3D- : TwglGenlockSourceEdgeI3D;
  wglGetGenlockSourceEdgeI3D- : TwglGetGenlockSourceEdgeI3D;
  wglGenlockSampleRateI3D- : TwglGenlockSampleRateI3D;
  wglGetGenlockSampleRateI3D- : TwglGetGenlockSampleRateI3D;
  wglGenlockSourceDelayI3D- : TwglGenlockSourceDelayI3D;
  wglGetGenlockSourceDelayI3D- : TwglGetGenlockSourceDelayI3D;
  wglQueryGenlockMaxSourceDelayI3D- : TwglQueryGenlockMaxSourceDelayI3D;

  (* WGL_I3D_image_buffer *)
  wglCreateImageBufferI3D- : TwglCreateImageBufferI3D;
  wglDestroyImageBufferI3D- : TwglDestroyImageBufferI3D;
  wglAssociateImageBufferEventsI3D- : TwglAssociateImageBufferEventsI3D;
  wglReleaseImageBufferEventsI3D- : TwglReleaseImageBufferEventsI3D;

  (* WGL_I3D_swap_frame_lock *)
  wglEnableFrameLockI3D- : TwglEnableFrameLockI3D;
  wglDisableFrameLockI3D- : TwglDisableFrameLockI3D;
  wglIsEnabledFrameLockI3D- : TwglIsEnabledFrameLockI3D;
  wglQueryFrameLockMasterI3D- : TwglQueryFrameLockMasterI3D;

  (* WGL_I3D_swap_frame_usage *)
  wglGetFrameUsageI3D- : TwglGetFrameUsageI3D;
  wglBeginFrameTrackingI3D- : TwglBeginFrameTrackingI3D;
  wglEndFrameTrackingI3D- : TwglEndFrameTrackingI3D;
  wglQueryFrameTrackingI3D- : TwglQueryFrameTrackingI3D;

  (* WGL_NV_vertex_array_range *)
  wglAllocateMemoryNV- : TwglAllocateMemoryNV;
  wglFreeMemoryNV- : TwglFreeMemoryNV;

  (* WGL_NV_present_video *)
  wglEnumerateVideoDevicesNV- : TwglEnumerateVideoDevicesNV;
 (* wglBindVideoDeviceNV- : TwglBindVideoDeviceNV; *********************************** *)
  wglQueryCurrentContextNV- : TwglQueryCurrentContextNV;

  (* WGL_NV_video_output *)
  wglGetVideoDeviceNV- : TwglGetVideoDeviceNV;
  wglReleaseVideoDeviceNV- : TwglReleaseVideoDeviceNV;
  wglBindVideoImageNV- : TwglBindVideoImageNV;
  wglReleaseVideoImageNV- : TwglReleaseVideoImageNV;
  wglSendPbufferToVideoNV- : TwglSendPbufferToVideoNV;
  wglGetVideoInfoNV- : TwglGetVideoInfoNV;

  (* WGL_NV_swap_group *)
  wglJoinSwapGroupNV- : TwglJoinSwapGroupNV;
  wglBindSwapBarrierNV- : TwglBindSwapBarrierNV;
  wglQuerySwapGroupNV- : TwglQuerySwapGroupNV;
  wglQueryMaxSwapGroupsNV- : TwglQueryMaxSwapGroupsNV;
  wglQueryFrameCountNV- : TwglQueryFrameCountNV;
  wglResetFrameCountNV- : TwglResetFrameCountNV;

  (* WGL_NV_gpu_affinity *)
  wglEnumGpusNV- : TwglEnumGpusNV;
  wglEnumGpuDevicesNV- : TwglEnumGpuDevicesNV;
  wglCreateAffinityDCNV- : TwglCreateAffinityDCNV;
  wglEnumGpusFromAffinityDCNV- : TwglEnumGpusFromAffinityDCNV;
  wglDeleteDCNV- : TwglDeleteDCNV;

  (* WGL_NV_video_capture *)
  wglBindVideoCaptureDeviceNV- : TwglBindVideoCaptureDeviceNV;
  wglEnumerateVideoCaptureDevicesNV- : TwglEnumerateVideoCaptureDevicesNV;
  wglLockVideoCaptureDeviceNV- : TwglLockVideoCaptureDeviceNV;
  wglQueryVideoCaptureDeviceNV- : TwglQueryVideoCaptureDeviceNV;
  wglReleaseVideoCaptureDeviceNV- : TwglReleaseVideoCaptureDeviceNV;

  (* WGL_NV_copy_image *)
  wglCopyImageSubDataNV- : TwglCopyImageSubDataNV;

  (* WGL_OML_sync_control *)
  wglGetSyncValuesOML- : TwglGetSyncValuesOML;
  wglGetMscRateOML- : TwglGetMscRateOML;
  wglSwapBuffersMscOML- : TwglSwapBuffersMscOML;
  wglSwapLayerBuffersMscOML- : TwglSwapLayerBuffersMscOML;
  wglWaitForMscOML- : TwglWaitForMscOML;
  wglWaitForSbcOML- : TwglWaitForSbcOML;

  (* WGL_3DL_stereo_control *)
(*  wglSetStereoEmitterState3DL- : TwglSetStereoEmitterState3DL; ************************************   *)

  (* WIN_draw_range_elements *)
  glDrawRangeElementsWIN- : TglDrawRangeElementsWIN;

  (* WIN_swap_hint *)
  glAddSwapHintRectWIN- : TglAddSwapHintRectWIN;
(*ENDIF *)

  
  
PROCEDURE InitOpenGL*;
VAR 
  name: ARRAY 64 OF CHAR;
BEGIN {EXCLUSIVE}
KernelLog.String(" InitOpenGL .."); 
   COPY(GL_LibName, name);
  GL_LibHandle := Kernel32.LoadLibrary(name);
  ASSERT(GL_LibHandle # 0,101);

  COPY(GLU_LibName, name);	
  GLU_LibHandle := Kernel32.LoadLibrary(name);
  ASSERT(GLU_LibHandle # 0,102);	
  	  
  (* load GL functions*)
  IF (GL_LibHandle # 0) THEN
   	    Kernel32.GetProcAddress(GL_LibHandle,'wglGetProcAddress', SYSTEM.VAL(ADDRESS, wglGetProcAddress));	
        Kernel32.GetProcAddress(GL_LibHandle,'wglCopyContext', SYSTEM.VAL(ADDRESS, wglCopyContext ));
        Kernel32.GetProcAddress(GL_LibHandle,'wglCreateLayerContext', SYSTEM.VAL(ADDRESS, wglCreateLayerContext ));
        Kernel32.GetProcAddress(GL_LibHandle,'wglCreateContext', SYSTEM.VAL(ADDRESS, wglCreateContext));
        Kernel32.GetProcAddress(GL_LibHandle,'wglDeleteContext', SYSTEM.VAL(ADDRESS, wglDeleteContext ));
      (*  Kernel32.GetProcAddress(GL_LibHandle,'wglDescribeLayerPlane', SYSTEM.VAL(ADDRESS, wglDescribeLayerPlane ));*)
        Kernel32.GetProcAddress(GL_LibHandle,'wglGetCurrentContext', SYSTEM.VAL(ADDRESS, wglGetCurrentContext));
        Kernel32.GetProcAddress(GL_LibHandle,'wglGetCurrentDC', SYSTEM.VAL(ADDRESS, wglGetCurrentDC));
        Kernel32.GetProcAddress(GL_LibHandle,'wglGetLayerPaletteEntries', SYSTEM.VAL(ADDRESS, wglGetLayerPaletteEntries));
       
        Kernel32.GetProcAddress(GL_LibHandle,'wglMakeCurrent', SYSTEM.VAL(ADDRESS, wglMakeCurrent));
        Kernel32.GetProcAddress(GL_LibHandle,'wglRealizeLayerPalette', SYSTEM.VAL(ADDRESS, wglRealizeLayerPalette));
        Kernel32.GetProcAddress(GL_LibHandle,'wglSetLayerPaletteEntries', SYSTEM.VAL(ADDRESS, wglSetLayerPaletteEntries));
        Kernel32.GetProcAddress(GL_LibHandle,'wglShareLists', SYSTEM.VAL(ADDRESS, wglShareLists));
        Kernel32.GetProcAddress(GL_LibHandle,'wglSwapLayerBuffers', SYSTEM.VAL(ADDRESS, wglSwapLayerBuffers));
(*      (*  Kernel32.GetProcAddress(GL_LibHandle,'wglSwapMultipleBuffers', SYSTEM.VAL(ADDRESS, wglSwapMultipleBuffers));*)
        Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontBitmapsA', SYSTEM.VAL(ADDRESS, wglUseFontBitmapsA));
      (*  Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontOutlinesA', SYSTEM.VAL(ADDRESS, wglUseFontOutlinesA));*)
        Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontBitmapsW', SYSTEM.VAL(ADDRESS, wglUseFontBitmapsW));
      (*  Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontOutlinesW', SYSTEM.VAL(ADDRESS, wglUseFontOutlinesW));*)
        Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontBitmapsA', SYSTEM.VAL(ADDRESS, wglUseFontBitmaps));
     (*   Kernel32.GetProcAddress(GL_LibHandle,'wglUseFontOutlinesA', SYSTEM.VAL(ADDRESS, wglUseFontOutlines));*)
*)

   Kernel32.GetProcAddress(GL_LibHandle, 'glCullFace', SYSTEM.VAL(ADDRESS, glCullFace ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glFrontFace', SYSTEM.VAL(ADDRESS, glFrontFace ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glHint', SYSTEM.VAL(ADDRESS, glHint ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glLineWidth', SYSTEM.VAL(ADDRESS, glLineWidth ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glPointSize', SYSTEM.VAL(ADDRESS, glPointSize ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glPolygonMode', SYSTEM.VAL(ADDRESS, glPolygonMode ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glScissor', SYSTEM.VAL(ADDRESS, glScissor ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexParameterf', SYSTEM.VAL(ADDRESS, glTexParameterf ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexParameterfv', SYSTEM.VAL(ADDRESS, glTexParameterfv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexParameteri', SYSTEM.VAL(ADDRESS, glTexParameteri ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexParameteriv', SYSTEM.VAL(ADDRESS, glTexParameteriv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexImage1D', SYSTEM.VAL(ADDRESS, glTexImage1D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexImage2D', SYSTEM.VAL(ADDRESS, glTexImage2D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDrawBuffer', SYSTEM.VAL(ADDRESS, glDrawBuffer ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glClear', SYSTEM.VAL(ADDRESS, glClear ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glClearColor', SYSTEM.VAL(ADDRESS, glClearColor ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glClearStencil', SYSTEM.VAL(ADDRESS, glClearStencil ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glClearDepth', SYSTEM.VAL(ADDRESS, glClearDepth ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glStencilMask', SYSTEM.VAL(ADDRESS, glStencilMask ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glColorMask', SYSTEM.VAL(ADDRESS, glColorMask ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDepthMask', SYSTEM.VAL(ADDRESS, glDepthMask ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDisable', SYSTEM.VAL(ADDRESS, glDisable ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glEnable', SYSTEM.VAL(ADDRESS, glEnable ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glFinish', SYSTEM.VAL(ADDRESS, glFinish ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glFlush', SYSTEM.VAL(ADDRESS, glFlush ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glBlendFunc', SYSTEM.VAL(ADDRESS, glBlendFunc ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glLogicOp', SYSTEM.VAL(ADDRESS, glLogicOp ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glStencilFunc', SYSTEM.VAL(ADDRESS, glStencilFunc ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glStencilOp', SYSTEM.VAL(ADDRESS, glStencilOp ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDepthFunc', SYSTEM.VAL(ADDRESS, glDepthFunc ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glPixelStoref', SYSTEM.VAL(ADDRESS, glPixelStoref ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glPixelStorei', SYSTEM.VAL(ADDRESS, glPixelStorei ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glReadBuffer', SYSTEM.VAL(ADDRESS, glReadBuffer ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glReadPixels', SYSTEM.VAL(ADDRESS, glReadPixels ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetBooleanv', SYSTEM.VAL(ADDRESS, glGetBooleanv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetDoublev', SYSTEM.VAL(ADDRESS, glGetDoublev ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetError', SYSTEM.VAL(ADDRESS, glGetError ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetFloatv', SYSTEM.VAL(ADDRESS, glGetFloatv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetIntegerv', SYSTEM.VAL(ADDRESS, glGetIntegerv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetString', SYSTEM.VAL(ADDRESS, glGetString ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexImage', SYSTEM.VAL(ADDRESS, glGetTexImage ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexParameteriv', SYSTEM.VAL(ADDRESS, glGetTexParameteriv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexParameterfv', SYSTEM.VAL(ADDRESS, glGetTexParameterfv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexLevelParameterfv', SYSTEM.VAL(ADDRESS, glGetTexLevelParameterfv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexLevelParameteriv', SYSTEM.VAL(ADDRESS, glGetTexLevelParameteriv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glIsEnabled', SYSTEM.VAL(ADDRESS, glIsEnabled ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDepthRange', SYSTEM.VAL(ADDRESS, glDepthRange ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glViewport', SYSTEM.VAL(ADDRESS, glViewport ));

  (*! GL_VERSION_1_1*)
   Kernel32.GetProcAddress(GL_LibHandle, 'glDrawArrays', SYSTEM.VAL(ADDRESS, glDrawArrays ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDrawElements', SYSTEM.VAL(ADDRESS, glDrawElements ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGetPointerv', SYSTEM.VAL(ADDRESS, glGetPointerv ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glPolygonOffset', SYSTEM.VAL(ADDRESS, glPolygonOffset ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glCopyTexImage1D', SYSTEM.VAL(ADDRESS, glCopyTexImage1D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glCopyTexImage2D', SYSTEM.VAL(ADDRESS, glCopyTexImage2D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glCopyTexSubImage1D', SYSTEM.VAL(ADDRESS, glCopyTexSubImage1D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glCopyTexSubImage2D', SYSTEM.VAL(ADDRESS, glCopyTexSubImage2D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexSubImage1D', SYSTEM.VAL(ADDRESS, glTexSubImage1D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glTexSubImage2D', SYSTEM.VAL(ADDRESS, glTexSubImage2D ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glBindTexture', SYSTEM.VAL(ADDRESS, glBindTexture ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glDeleteTextures', SYSTEM.VAL(ADDRESS, glDeleteTextures ));
   Kernel32.GetProcAddress(GL_LibHandle, 'glGenTextures', SYSTEM.VAL(ADDRESS, glGenTextures ));

(*! ifdef DEPRECATED*)
   Kernel32.GetProcAddress(GL_LibHandle, 'glAccum', SYSTEM.VAL(ADDRESS, glAccum));
    Kernel32.GetProcAddress(GL_LibHandle, 'glAlphaFunc', SYSTEM.VAL(ADDRESS, glAlphaFunc));
    Kernel32.GetProcAddress(GL_LibHandle, 'glAreTexturesResident', SYSTEM.VAL(ADDRESS, glAreTexturesResident));
    Kernel32.GetProcAddress(GL_LibHandle, 'glArrayElement', SYSTEM.VAL(ADDRESS, glArrayElement));
    Kernel32.GetProcAddress(GL_LibHandle, 'glBegin', SYSTEM.VAL(ADDRESS, glBegin));
    Kernel32.GetProcAddress(GL_LibHandle, 'glBitmap', SYSTEM.VAL(ADDRESS, glBitmap));
    Kernel32.GetProcAddress(GL_LibHandle, 'glCallList', SYSTEM.VAL(ADDRESS, glCallList));
    Kernel32.GetProcAddress(GL_LibHandle, 'glCallLists', SYSTEM.VAL(ADDRESS, glCallLists));
    Kernel32.GetProcAddress(GL_LibHandle, 'glClearAccum', SYSTEM.VAL(ADDRESS, glClearAccum));
    Kernel32.GetProcAddress(GL_LibHandle, 'glClearIndex', SYSTEM.VAL(ADDRESS, glClearIndex));
    Kernel32.GetProcAddress(GL_LibHandle, 'glClipPlane', SYSTEM.VAL(ADDRESS, glClipPlane));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3b', SYSTEM.VAL(ADDRESS, glColor3b));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3bv', SYSTEM.VAL(ADDRESS, glColor3bv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3d', SYSTEM.VAL(ADDRESS, glColor3d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3dv', SYSTEM.VAL(ADDRESS, glColor3dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3f', SYSTEM.VAL(ADDRESS, glColor3f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3fv', SYSTEM.VAL(ADDRESS, glColor3fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3i', SYSTEM.VAL(ADDRESS, glColor3i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3iv', SYSTEM.VAL(ADDRESS, glColor3iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3s', SYSTEM.VAL(ADDRESS, glColor3s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3sv', SYSTEM.VAL(ADDRESS, glColor3sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3ub', SYSTEM.VAL(ADDRESS, glColor3ub));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3ubv', SYSTEM.VAL(ADDRESS, glColor3ubv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3ui', SYSTEM.VAL(ADDRESS, glColor3ui));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3uiv', SYSTEM.VAL(ADDRESS, glColor3uiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3us', SYSTEM.VAL(ADDRESS, glColor3us));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor3usv', SYSTEM.VAL(ADDRESS, glColor3usv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4b', SYSTEM.VAL(ADDRESS, glColor4b));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4bv', SYSTEM.VAL(ADDRESS, glColor4bv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4d', SYSTEM.VAL(ADDRESS, glColor4d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4dv', SYSTEM.VAL(ADDRESS, glColor4dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4f', SYSTEM.VAL(ADDRESS, glColor4f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4fv', SYSTEM.VAL(ADDRESS, glColor4fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4i', SYSTEM.VAL(ADDRESS, glColor4i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4iv', SYSTEM.VAL(ADDRESS, glColor4iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4s', SYSTEM.VAL(ADDRESS, glColor4s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4sv', SYSTEM.VAL(ADDRESS, glColor4sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4ub', SYSTEM.VAL(ADDRESS, glColor4ub));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4ubv', SYSTEM.VAL(ADDRESS, glColor4ubv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4ui', SYSTEM.VAL(ADDRESS, glColor4ui));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4uiv', SYSTEM.VAL(ADDRESS, glColor4uiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4us', SYSTEM.VAL(ADDRESS, glColor4us));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColor4usv', SYSTEM.VAL(ADDRESS, glColor4usv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColorMaterial', SYSTEM.VAL(ADDRESS, glColorMaterial));
    Kernel32.GetProcAddress(GL_LibHandle, 'glColorPointer', SYSTEM.VAL(ADDRESS, glColorPointer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glCopyPixels', SYSTEM.VAL(ADDRESS, glCopyPixels));
    Kernel32.GetProcAddress(GL_LibHandle, 'glDeleteLists', SYSTEM.VAL(ADDRESS, glDeleteLists));
    Kernel32.GetProcAddress(GL_LibHandle, 'glDisableClientState', SYSTEM.VAL(ADDRESS, glDisableClientState));
    Kernel32.GetProcAddress(GL_LibHandle, 'glDrawPixels', SYSTEM.VAL(ADDRESS, glDrawPixels));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEdgeFlag', SYSTEM.VAL(ADDRESS, glEdgeFlag));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEdgeFlagPointer', SYSTEM.VAL(ADDRESS, glEdgeFlagPointer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEdgeFlagv', SYSTEM.VAL(ADDRESS, glEdgeFlagv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEnableClientState', SYSTEM.VAL(ADDRESS, glEnableClientState));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEnd', SYSTEM.VAL(ADDRESS, glEnd));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEndList', SYSTEM.VAL(ADDRESS, glEndList));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord1d', SYSTEM.VAL(ADDRESS, glEvalCoord1d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord1dv', SYSTEM.VAL(ADDRESS, glEvalCoord1dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord1f', SYSTEM.VAL(ADDRESS, glEvalCoord1f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord1fv', SYSTEM.VAL(ADDRESS, glEvalCoord1fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord2d', SYSTEM.VAL(ADDRESS, glEvalCoord2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord2dv', SYSTEM.VAL(ADDRESS, glEvalCoord2dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord2f', SYSTEM.VAL(ADDRESS, glEvalCoord2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalCoord2fv', SYSTEM.VAL(ADDRESS, glEvalCoord2fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalMesh1', SYSTEM.VAL(ADDRESS, glEvalMesh1));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalMesh2', SYSTEM.VAL(ADDRESS, glEvalMesh2));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalPoint1', SYSTEM.VAL(ADDRESS, glEvalPoint1));
    Kernel32.GetProcAddress(GL_LibHandle, 'glEvalPoint2', SYSTEM.VAL(ADDRESS, glEvalPoint2));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFeedbackBuffer', SYSTEM.VAL(ADDRESS, glFeedbackBuffer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFogf', SYSTEM.VAL(ADDRESS, glFogf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFogfv', SYSTEM.VAL(ADDRESS, glFogfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFogi', SYSTEM.VAL(ADDRESS, glFogi));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFogiv', SYSTEM.VAL(ADDRESS, glFogiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glFrustum', SYSTEM.VAL(ADDRESS, glFrustum));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGenLists', SYSTEM.VAL(ADDRESS, glGenLists));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetClipPlane', SYSTEM.VAL(ADDRESS, glGetClipPlane));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetLightfv', SYSTEM.VAL(ADDRESS, glGetLightfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetLightiv', SYSTEM.VAL(ADDRESS, glGetLightiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetMapdv', SYSTEM.VAL(ADDRESS, glGetMapdv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetMapfv', SYSTEM.VAL(ADDRESS, glGetMapfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetMapiv', SYSTEM.VAL(ADDRESS, glGetMapiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetMaterialfv', SYSTEM.VAL(ADDRESS, glGetMaterialfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetMaterialiv', SYSTEM.VAL(ADDRESS, glGetMaterialiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetPixelMapfv', SYSTEM.VAL(ADDRESS, glGetPixelMapfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetPixelMapuiv', SYSTEM.VAL(ADDRESS, glGetPixelMapuiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetPixelMapusv', SYSTEM.VAL(ADDRESS, glGetPixelMapusv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetPolygonStipple', SYSTEM.VAL(ADDRESS, glGetPolygonStipple));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexEnvfv', SYSTEM.VAL(ADDRESS, glGetTexEnvfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexEnviv', SYSTEM.VAL(ADDRESS, glGetTexEnviv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexGendv', SYSTEM.VAL(ADDRESS, glGetTexGendv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexGenfv', SYSTEM.VAL(ADDRESS, glGetTexGenfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glGetTexGeniv', SYSTEM.VAL(ADDRESS, glGetTexGeniv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexMask', SYSTEM.VAL(ADDRESS, glIndexMask));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexPointer', SYSTEM.VAL(ADDRESS, glIndexPointer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexd', SYSTEM.VAL(ADDRESS, glIndexd));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexdv', SYSTEM.VAL(ADDRESS, glIndexdv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexf', SYSTEM.VAL(ADDRESS, glIndexf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexfv', SYSTEM.VAL(ADDRESS, glIndexfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexi', SYSTEM.VAL(ADDRESS, glIndexi));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexiv', SYSTEM.VAL(ADDRESS, glIndexiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexs', SYSTEM.VAL(ADDRESS, glIndexs));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexsv', SYSTEM.VAL(ADDRESS, glIndexsv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexub', SYSTEM.VAL(ADDRESS, glIndexub));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIndexubv', SYSTEM.VAL(ADDRESS, glIndexubv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glInitNames', SYSTEM.VAL(ADDRESS, glInitNames));
    Kernel32.GetProcAddress(GL_LibHandle, 'glInterleavedArrays', SYSTEM.VAL(ADDRESS, glInterleavedArrays));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIsList', SYSTEM.VAL(ADDRESS, glIsList));
    Kernel32.GetProcAddress(GL_LibHandle, 'glIsTexture', SYSTEM.VAL(ADDRESS, glIsTexture));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightModelf', SYSTEM.VAL(ADDRESS, glLightModelf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightModelfv', SYSTEM.VAL(ADDRESS, glLightModelfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightModeli', SYSTEM.VAL(ADDRESS, glLightModeli));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightModeliv', SYSTEM.VAL(ADDRESS, glLightModeliv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightf', SYSTEM.VAL(ADDRESS, glLightf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightfv', SYSTEM.VAL(ADDRESS, glLightfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLighti', SYSTEM.VAL(ADDRESS, glLighti));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLightiv', SYSTEM.VAL(ADDRESS, glLightiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLineStipple', SYSTEM.VAL(ADDRESS, glLineStipple));
    Kernel32.GetProcAddress(GL_LibHandle, 'glListBase', SYSTEM.VAL(ADDRESS, glListBase));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLoadIdentity', SYSTEM.VAL(ADDRESS, glLoadIdentity));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLoadMatrixd', SYSTEM.VAL(ADDRESS, glLoadMatrixd));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLoadMatrixf', SYSTEM.VAL(ADDRESS, glLoadMatrixf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glLoadName', SYSTEM.VAL(ADDRESS, glLoadName));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMap1d', SYSTEM.VAL(ADDRESS, glMap1d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMap1f', SYSTEM.VAL(ADDRESS, glMap1f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMap2d', SYSTEM.VAL(ADDRESS, glMap2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMap2f', SYSTEM.VAL(ADDRESS, glMap2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMapGrid1d', SYSTEM.VAL(ADDRESS, glMapGrid1d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMapGrid1f', SYSTEM.VAL(ADDRESS, glMapGrid1f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMapGrid2d', SYSTEM.VAL(ADDRESS, glMapGrid2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMapGrid2f', SYSTEM.VAL(ADDRESS, glMapGrid2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMaterialf', SYSTEM.VAL(ADDRESS, glMaterialf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMaterialfv', SYSTEM.VAL(ADDRESS, glMaterialfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMateriali', SYSTEM.VAL(ADDRESS, glMateriali));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMaterialiv', SYSTEM.VAL(ADDRESS, glMaterialiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMatrixMode', SYSTEM.VAL(ADDRESS, glMatrixMode));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMultMatrixd', SYSTEM.VAL(ADDRESS, glMultMatrixd));
    Kernel32.GetProcAddress(GL_LibHandle, 'glMultMatrixf', SYSTEM.VAL(ADDRESS, glMultMatrixf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNewList', SYSTEM.VAL(ADDRESS, glNewList));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3b', SYSTEM.VAL(ADDRESS, glNormal3b));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3bv', SYSTEM.VAL(ADDRESS, glNormal3bv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3d', SYSTEM.VAL(ADDRESS, glNormal3d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3dv', SYSTEM.VAL(ADDRESS, glNormal3dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3f', SYSTEM.VAL(ADDRESS, glNormal3f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3fv', SYSTEM.VAL(ADDRESS, glNormal3fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3i', SYSTEM.VAL(ADDRESS, glNormal3i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3iv', SYSTEM.VAL(ADDRESS, glNormal3iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3s', SYSTEM.VAL(ADDRESS, glNormal3s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormal3sv', SYSTEM.VAL(ADDRESS, glNormal3sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glNormalPointer', SYSTEM.VAL(ADDRESS, glNormalPointer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glOrtho', SYSTEM.VAL(ADDRESS, glOrtho));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPassThrough', SYSTEM.VAL(ADDRESS, glPassThrough));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelMapfv', SYSTEM.VAL(ADDRESS, glPixelMapfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelMapuiv', SYSTEM.VAL(ADDRESS, glPixelMapuiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelMapusv', SYSTEM.VAL(ADDRESS, glPixelMapusv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelTransferf', SYSTEM.VAL(ADDRESS, glPixelTransferf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelTransferi', SYSTEM.VAL(ADDRESS, glPixelTransferi));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPixelZoom', SYSTEM.VAL(ADDRESS, glPixelZoom));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPolygonStipple', SYSTEM.VAL(ADDRESS, glPolygonStipple));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPopAttrib', SYSTEM.VAL(ADDRESS, glPopAttrib));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPopClientAttrib', SYSTEM.VAL(ADDRESS, glPopClientAttrib));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPopMatrix', SYSTEM.VAL(ADDRESS, glPopMatrix));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPopName', SYSTEM.VAL(ADDRESS, glPopName));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPrioritizeTextures', SYSTEM.VAL(ADDRESS, glPrioritizeTextures));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPushAttrib', SYSTEM.VAL(ADDRESS, glPushAttrib));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPushClientAttrib', SYSTEM.VAL(ADDRESS, glPushClientAttrib));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPushMatrix', SYSTEM.VAL(ADDRESS, glPushMatrix));
    Kernel32.GetProcAddress(GL_LibHandle, 'glPushName', SYSTEM.VAL(ADDRESS, glPushName));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2d', SYSTEM.VAL(ADDRESS, glRasterPos2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2dv', SYSTEM.VAL(ADDRESS, glRasterPos2dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2f', SYSTEM.VAL(ADDRESS, glRasterPos2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2fv', SYSTEM.VAL(ADDRESS, glRasterPos2fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2i', SYSTEM.VAL(ADDRESS, glRasterPos2i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2iv', SYSTEM.VAL(ADDRESS, glRasterPos2iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2s', SYSTEM.VAL(ADDRESS, glRasterPos2s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos2sv', SYSTEM.VAL(ADDRESS, glRasterPos2sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3d', SYSTEM.VAL(ADDRESS, glRasterPos3d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3dv', SYSTEM.VAL(ADDRESS, glRasterPos3dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3f', SYSTEM.VAL(ADDRESS, glRasterPos3f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3fv', SYSTEM.VAL(ADDRESS, glRasterPos3fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3i', SYSTEM.VAL(ADDRESS, glRasterPos3i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3iv', SYSTEM.VAL(ADDRESS, glRasterPos3iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3s', SYSTEM.VAL(ADDRESS, glRasterPos3s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos3sv', SYSTEM.VAL(ADDRESS, glRasterPos3sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4d', SYSTEM.VAL(ADDRESS, glRasterPos4d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4dv', SYSTEM.VAL(ADDRESS, glRasterPos4dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4f', SYSTEM.VAL(ADDRESS, glRasterPos4f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4fv', SYSTEM.VAL(ADDRESS, glRasterPos4fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4i', SYSTEM.VAL(ADDRESS, glRasterPos4i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4iv', SYSTEM.VAL(ADDRESS, glRasterPos4iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4s', SYSTEM.VAL(ADDRESS, glRasterPos4s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRasterPos4sv', SYSTEM.VAL(ADDRESS, glRasterPos4sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectd', SYSTEM.VAL(ADDRESS, glRectd));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectdv', SYSTEM.VAL(ADDRESS, glRectdv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectf', SYSTEM.VAL(ADDRESS, glRectf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectfv', SYSTEM.VAL(ADDRESS, glRectfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRecti', SYSTEM.VAL(ADDRESS, glRecti));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectiv', SYSTEM.VAL(ADDRESS, glRectiv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRects', SYSTEM.VAL(ADDRESS, glRects));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRectsv', SYSTEM.VAL(ADDRESS, glRectsv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRenderMode', SYSTEM.VAL(ADDRESS, glRenderMode));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRotated', SYSTEM.VAL(ADDRESS, glRotated));
    Kernel32.GetProcAddress(GL_LibHandle, 'glRotatef', SYSTEM.VAL(ADDRESS, glRotatef));
    Kernel32.GetProcAddress(GL_LibHandle, 'glScaled', SYSTEM.VAL(ADDRESS, glScaled));
    Kernel32.GetProcAddress(GL_LibHandle, 'glScalef', SYSTEM.VAL(ADDRESS, glScalef));
    Kernel32.GetProcAddress(GL_LibHandle, 'glSelectBuffer', SYSTEM.VAL(ADDRESS, glSelectBuffer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glShadeModel', SYSTEM.VAL(ADDRESS, glShadeModel));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1d', SYSTEM.VAL(ADDRESS, glTexCoord1d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1dv', SYSTEM.VAL(ADDRESS, glTexCoord1dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1f', SYSTEM.VAL(ADDRESS, glTexCoord1f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1fv', SYSTEM.VAL(ADDRESS, glTexCoord1fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1i', SYSTEM.VAL(ADDRESS, glTexCoord1i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1iv', SYSTEM.VAL(ADDRESS, glTexCoord1iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1s', SYSTEM.VAL(ADDRESS, glTexCoord1s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord1sv', SYSTEM.VAL(ADDRESS, glTexCoord1sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2d', SYSTEM.VAL(ADDRESS, glTexCoord2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2dv', SYSTEM.VAL(ADDRESS, glTexCoord2dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2f', SYSTEM.VAL(ADDRESS, glTexCoord2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2fv', SYSTEM.VAL(ADDRESS, glTexCoord2fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2i', SYSTEM.VAL(ADDRESS, glTexCoord2i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2iv', SYSTEM.VAL(ADDRESS, glTexCoord2iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2s', SYSTEM.VAL(ADDRESS, glTexCoord2s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord2sv', SYSTEM.VAL(ADDRESS, glTexCoord2sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3d', SYSTEM.VAL(ADDRESS, glTexCoord3d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3dv', SYSTEM.VAL(ADDRESS, glTexCoord3dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3f', SYSTEM.VAL(ADDRESS, glTexCoord3f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3fv', SYSTEM.VAL(ADDRESS, glTexCoord3fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3i', SYSTEM.VAL(ADDRESS, glTexCoord3i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3iv', SYSTEM.VAL(ADDRESS, glTexCoord3iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3s', SYSTEM.VAL(ADDRESS, glTexCoord3s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord3sv', SYSTEM.VAL(ADDRESS, glTexCoord3sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4d', SYSTEM.VAL(ADDRESS, glTexCoord4d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4dv', SYSTEM.VAL(ADDRESS, glTexCoord4dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4f', SYSTEM.VAL(ADDRESS, glTexCoord4f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4fv', SYSTEM.VAL(ADDRESS, glTexCoord4fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4i', SYSTEM.VAL(ADDRESS, glTexCoord4i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4iv', SYSTEM.VAL(ADDRESS, glTexCoord4iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4s', SYSTEM.VAL(ADDRESS, glTexCoord4s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoord4sv', SYSTEM.VAL(ADDRESS, glTexCoord4sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexCoordPointer', SYSTEM.VAL(ADDRESS, glTexCoordPointer));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexEnvf', SYSTEM.VAL(ADDRESS, glTexEnvf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexEnvfv', SYSTEM.VAL(ADDRESS, glTexEnvfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexEnvi', SYSTEM.VAL(ADDRESS, glTexEnvi));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexEnviv', SYSTEM.VAL(ADDRESS, glTexEnviv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGend', SYSTEM.VAL(ADDRESS, glTexGend));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGendv', SYSTEM.VAL(ADDRESS, glTexGendv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGenf', SYSTEM.VAL(ADDRESS, glTexGenf));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGenfv', SYSTEM.VAL(ADDRESS, glTexGenfv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGeni', SYSTEM.VAL(ADDRESS, glTexGeni));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTexGeniv', SYSTEM.VAL(ADDRESS, glTexGeniv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTranslated', SYSTEM.VAL(ADDRESS, glTranslated));
    Kernel32.GetProcAddress(GL_LibHandle, 'glTranslatef', SYSTEM.VAL(ADDRESS, glTranslatef));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2d', SYSTEM.VAL(ADDRESS, glVertex2d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2dv', SYSTEM.VAL(ADDRESS, glVertex2dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2f', SYSTEM.VAL(ADDRESS, glVertex2f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2fv', SYSTEM.VAL(ADDRESS, glVertex2fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2i', SYSTEM.VAL(ADDRESS, glVertex2i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2iv', SYSTEM.VAL(ADDRESS, glVertex2iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2s', SYSTEM.VAL(ADDRESS, glVertex2s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex2sv', SYSTEM.VAL(ADDRESS, glVertex2sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3d', SYSTEM.VAL(ADDRESS, glVertex3d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3dv', SYSTEM.VAL(ADDRESS, glVertex3dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3f', SYSTEM.VAL(ADDRESS, glVertex3f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3fv', SYSTEM.VAL(ADDRESS, glVertex3fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3i', SYSTEM.VAL(ADDRESS, glVertex3i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3iv', SYSTEM.VAL(ADDRESS, glVertex3iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3s', SYSTEM.VAL(ADDRESS, glVertex3s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex3sv', SYSTEM.VAL(ADDRESS, glVertex3sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4d', SYSTEM.VAL(ADDRESS, glVertex4d));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4dv', SYSTEM.VAL(ADDRESS, glVertex4dv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4f', SYSTEM.VAL(ADDRESS, glVertex4f));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4fv', SYSTEM.VAL(ADDRESS, glVertex4fv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4i', SYSTEM.VAL(ADDRESS, glVertex4i));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4iv', SYSTEM.VAL(ADDRESS, glVertex4iv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4s', SYSTEM.VAL(ADDRESS, glVertex4s));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertex4sv', SYSTEM.VAL(ADDRESS, glVertex4sv));
    Kernel32.GetProcAddress(GL_LibHandle, 'glVertexPointer', SYSTEM.VAL(ADDRESS, glVertexPointer));
(*! endif *)

	 KernelLog.String(GL_LibName); KernelLog.String(" loaded.");  KernelLog.Ln; 
  END;

  (* load GLU functions *)
  IF GLU_LibHandle # 0 THEN
    (* GLU ======================================================================== *)
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBeginCurve', SYSTEM.VAL(ADDRESS, gluBeginCurve ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBeginPolygon', SYSTEM.VAL(ADDRESS, gluBeginPolygon ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBeginSurface', SYSTEM.VAL(ADDRESS, gluBeginSurface ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBeginTrim', SYSTEM.VAL(ADDRESS,  gluBeginTrim));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBuild1DMipmaps', SYSTEM.VAL(ADDRESS, gluBuild1DMipmaps ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluBuild2DMipmaps', SYSTEM.VAL(ADDRESS, gluBuild2DMipmaps ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluCylinder', SYSTEM.VAL(ADDRESS, gluCylinder ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluDeleteNurbsRenderer', SYSTEM.VAL(ADDRESS, gluDeleteNurbsRenderer ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluDeleteQuadric', SYSTEM.VAL(ADDRESS, gluDeleteQuadric ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluDeleteTess', SYSTEM.VAL(ADDRESS, gluDeleteTess ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluDisk', SYSTEM.VAL(ADDRESS, gluDisk ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluEndCurve', SYSTEM.VAL(ADDRESS, gluEndCurve ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluEndPolygon', SYSTEM.VAL(ADDRESS, gluEndPolygon ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluEndSurface', SYSTEM.VAL(ADDRESS, gluEndSurface ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluEndTrim', SYSTEM.VAL(ADDRESS, gluEndTrim ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluErrorString', SYSTEM.VAL(ADDRESS, gluErrorString ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluGetNurbsProperty', SYSTEM.VAL(ADDRESS, gluGetNurbsProperty ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluGetString', SYSTEM.VAL(ADDRESS, gluGetString ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluGetTessProperty', SYSTEM.VAL(ADDRESS, gluGetTessProperty ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluLoadSamplingMatrices', SYSTEM.VAL(ADDRESS, gluLoadSamplingMatrices ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluLookAt', SYSTEM.VAL(ADDRESS, gluLookAt ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNewNurbsRenderer', SYSTEM.VAL(ADDRESS, gluNewNurbsRenderer ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNewQuadric', SYSTEM.VAL(ADDRESS, gluNewQuadric ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNewTess', SYSTEM.VAL(ADDRESS, gluNewTess ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNextContour', SYSTEM.VAL(ADDRESS, gluNextContour ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNurbsCallback', SYSTEM.VAL(ADDRESS, gluNurbsCallback ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNurbsCurve', SYSTEM.VAL(ADDRESS, gluNurbsCurve ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNurbsProperty', SYSTEM.VAL(ADDRESS, gluNurbsProperty ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluNurbsSurface', SYSTEM.VAL(ADDRESS, gluNurbsSurface ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluOrtho2D', SYSTEM.VAL(ADDRESS, gluOrtho2D ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluPartialDisk', SYSTEM.VAL(ADDRESS, gluPartialDisk ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluPerspective', SYSTEM.VAL(ADDRESS, gluPerspective ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluPickMatrix', SYSTEM.VAL(ADDRESS, gluPickMatrix ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluProject', SYSTEM.VAL(ADDRESS, gluProject ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluPwlCurve', SYSTEM.VAL(ADDRESS, gluPwlCurve ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluQuadricCallback', SYSTEM.VAL(ADDRESS, gluQuadricCallback ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluQuadricDrawStyle', SYSTEM.VAL(ADDRESS, gluQuadricDrawStyle ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluQuadricNormals', SYSTEM.VAL(ADDRESS, gluQuadricNormals ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluQuadricOrientation', SYSTEM.VAL(ADDRESS, gluQuadricOrientation ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluQuadricTexture', SYSTEM.VAL(ADDRESS, gluQuadricTexture ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluScaleImage', SYSTEM.VAL(ADDRESS, gluScaleImage ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluSphere', SYSTEM.VAL(ADDRESS, gluSphere ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessBeginContour', SYSTEM.VAL(ADDRESS, gluTessBeginContour ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessBeginPolygon', SYSTEM.VAL(ADDRESS, gluTessBeginPolygon ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessCallback', SYSTEM.VAL(ADDRESS, gluTessCallback ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessEndContour', SYSTEM.VAL(ADDRESS, gluTessEndContour ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessEndPolygon', SYSTEM.VAL(ADDRESS, gluTessEndPolygon ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessNormal', SYSTEM.VAL(ADDRESS, gluTessNormal ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessProperty', SYSTEM.VAL(ADDRESS, gluTessProperty ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluTessVertex', SYSTEM.VAL(ADDRESS, gluTessVertex ));
     Kernel32.GetProcAddress(GLU_LibHandle,  'gluUnProject', SYSTEM.VAL(ADDRESS, gluUnProject ));
     
      KernelLog.String(GLU_LibName); KernelLog.String(" loaded."); KernelLog.Ln; 
  END;
  KernelLog.String(" Ok."); KernelLog.Ln; 
END InitOpenGL;


PROCEDURE ReadOpenGLCore*;
BEGIN
  KernelLog.String(" ReadOpenGLCore .."); 	
 
  (* GL_VERSION_1_2 *)
    glBlendColor := SYSTEM.VAL(TglBlendColor, wglGetProcAddress("glBlendColor")); 
    glBlendEquation := SYSTEM.VAL(TglBlendEquation, wglGetProcAddress('glBlendEquation'));
    glDrawRangeElements := SYSTEM.VAL(TglDrawRangeElements, wglGetProcAddress('glDrawRangeElements'));
    glTexImage3D := SYSTEM.VAL( TglTexImage3D, wglGetProcAddress('glTexImage3D'));
    glTexSubImage3D := SYSTEM.VAL(TglTexSubImage3D, wglGetProcAddress( 'glTexSubImage3D'));
    glCopyTexSubImage3D := SYSTEM.VAL(TglCopyTexSubImage3D, wglGetProcAddress( 'glCopyTexSubImage3D'));

  (* GL_VERSION_1_3 *)
   glActiveTexture := SYSTEM.VAL( TglActiveTexture, wglGetProcAddress( 'glActiveTexture'));
   glSampleCoverage := SYSTEM.VAL(TglSampleCoverage, wglGetProcAddress( 'glSampleCoverage'));
   glCompressedTexImage3D := SYSTEM.VAL(TglCompressedTexImage3D, wglGetProcAddress( 'glCompressedTexImage3D'));
   glCompressedTexImage2D := SYSTEM.VAL(TglCompressedTexImage2D, wglGetProcAddress( 'glCompressedTexImage2D'));
   glCompressedTexImage1D := SYSTEM.VAL(TglCompressedTexImage1D, wglGetProcAddress( 'glCompressedTexImage1D'));
   glCompressedTexSubImage3D := SYSTEM.VAL(TglCompressedTexSubImage3D, wglGetProcAddress( 'glCompressedTexSubImage3D'));
   glCompressedTexSubImage2D := SYSTEM.VAL(TglCompressedTexSubImage2D, wglGetProcAddress( 'glCompressedTexSubImage2D'));
   glCompressedTexSubImage1D := SYSTEM.VAL(TglCompressedTexSubImage1D, wglGetProcAddress( 'glCompressedTexSubImage1D'));
   glGetCompressedTexImage := SYSTEM.VAL(TglGetCompressedTexImage, wglGetProcAddress( 'glGetCompressedTexImage'));

  (* GL_VERSION_1_4 *)
   glBlendFuncSeparate := SYSTEM.VAL(TglBlendFuncSeparate  , wglGetProcAddress( 'glBlendFuncSeparate'));
   glMultiDrawArrays := SYSTEM.VAL(TglMultiDrawArrays  , wglGetProcAddress( 'glMultiDrawArrays'));
   glMultiDrawElements := SYSTEM.VAL(TglMultiDrawElements  , wglGetProcAddress( 'glMultiDrawElements'));
   glPointParameterf := SYSTEM.VAL(TglPointParameterf  , wglGetProcAddress( 'glPointParameterf'));
   glPointParameterfv := SYSTEM.VAL(TglPointParameterfv  , wglGetProcAddress( 'glPointParameterfv'));
   glPointParameteri := SYSTEM.VAL(TglPointParameteri  , wglGetProcAddress( 'glPointParameteri'));
   glPointParameteriv := SYSTEM.VAL(TglPointParameteriv  , wglGetProcAddress( 'glPointParameteriv'));

  (* GL_VERSION_1_5 *)
   glGenQueries := SYSTEM.VAL(TglGenQueries  , wglGetProcAddress( 'glGenQueries'));
   glDeleteQueries := SYSTEM.VAL(TglDeleteQueries  , wglGetProcAddress( 'glDeleteQueries'));
   glIsQuery := SYSTEM.VAL(TglIsQuery  , wglGetProcAddress( 'glIsQuery'));
   glBeginQuery := SYSTEM.VAL(TglBeginQuery  , wglGetProcAddress( 'glBeginQuery'));
   glEndQuery := SYSTEM.VAL(TglEndQuery  , wglGetProcAddress( 'glEndQuery'));
   glGetQueryiv := SYSTEM.VAL(TglGetQueryiv  , wglGetProcAddress( 'glGetQueryiv'));
   glGetQueryObjectiv := SYSTEM.VAL(TglGetQueryObjectiv  , wglGetProcAddress( 'glGetQueryObjectiv'));
   glGetQueryObjectuiv := SYSTEM.VAL(TglGetQueryObjectuiv  , wglGetProcAddress( 'glGetQueryObjectuiv'));
   glBindBuffer := SYSTEM.VAL(TglBindBuffer  , wglGetProcAddress( 'glBindBuffer'));
   glDeleteBuffers := SYSTEM.VAL(TglDeleteBuffers  , wglGetProcAddress( 'glDeleteBuffers'));
   glGenBuffers := SYSTEM.VAL(TglGenBuffers  , wglGetProcAddress( 'glGenBuffers'));
   glIsBuffer := SYSTEM.VAL(TglIsBuffer  , wglGetProcAddress( 'glIsBuffer'));
   glBufferData := SYSTEM.VAL(TglBufferData  , wglGetProcAddress( 'glBufferData'));
   glBufferSubData := SYSTEM.VAL(TglBufferSubData  , wglGetProcAddress( 'glBufferSubData'));
   glGetBufferSubData := SYSTEM.VAL(TglGetBufferSubData  , wglGetProcAddress( 'glGetBufferSubData'));
   glMapBuffer := SYSTEM.VAL(TglMapBuffer  , wglGetProcAddress( 'glMapBuffer'));
   glUnmapBuffer := SYSTEM.VAL(TglUnmapBuffer  , wglGetProcAddress( 'glUnmapBuffer'));
   glGetBufferParameteriv := SYSTEM.VAL(TglGetBufferParameteriv  , wglGetProcAddress( 'glGetBufferParameteriv'));
   glGetBufferPointerv := SYSTEM.VAL(TglGetBufferPointerv  , wglGetProcAddress( 'glGetBufferPointerv'));

  (* GL_VERSION_2_0 *)
   glBlendEquationSeparate := SYSTEM.VAL(TglBlendEquationSeparate  , wglGetProcAddress( 'glBlendEquationSeparate'));
   glDrawBuffers := SYSTEM.VAL(TglDrawBuffers  , wglGetProcAddress( 'glDrawBuffers'));
   glStencilOpSeparate := SYSTEM.VAL(TglStencilOpSeparate  , wglGetProcAddress( 'glStencilOpSeparate'));
   glStencilFuncSeparate := SYSTEM.VAL(TglStencilFuncSeparate  , wglGetProcAddress( 'glStencilFuncSeparate'));
   glStencilMaskSeparate := SYSTEM.VAL(TglStencilMaskSeparate  , wglGetProcAddress( 'glStencilMaskSeparate'));
   glAttachShader := SYSTEM.VAL(TglAttachShader  , wglGetProcAddress( 'glAttachShader'));
   glBindAttribLocation := SYSTEM.VAL(TglBindAttribLocation  , wglGetProcAddress( 'glBindAttribLocation'));
   glCompileShader := SYSTEM.VAL(TglCompileShader  , wglGetProcAddress( 'glCompileShader'));
   glCreateProgram := SYSTEM.VAL(TglCreateProgram  , wglGetProcAddress( 'glCreateProgram'));
   glCreateShader := SYSTEM.VAL(TglCreateShader  , wglGetProcAddress( 'glCreateShader'));
   glDeleteProgram := SYSTEM.VAL(TglDeleteProgram  , wglGetProcAddress( 'glDeleteProgram'));
   glDeleteShader := SYSTEM.VAL(TglDeleteShader  , wglGetProcAddress( 'glDeleteShader'));
   glDetachShader := SYSTEM.VAL(TglDetachShader  , wglGetProcAddress( 'glDetachShader'));
   glDisableVertexAttribArray := SYSTEM.VAL(TglDisableVertexAttribArray  , wglGetProcAddress( 'glDisableVertexAttribArray'));
   glEnableVertexAttribArray := SYSTEM.VAL(TglEnableVertexAttribArray  , wglGetProcAddress( 'glEnableVertexAttribArray'));
   glGetActiveAttrib := SYSTEM.VAL(TglGetActiveAttrib  , wglGetProcAddress( 'glGetActiveAttrib'));
   glGetActiveUniform := SYSTEM.VAL(TglGetActiveUniform  , wglGetProcAddress( 'glGetActiveUniform'));
   glGetAttachedShaders := SYSTEM.VAL(TglGetAttachedShaders  , wglGetProcAddress( 'glGetAttachedShaders'));
   glGetAttribLocation := SYSTEM.VAL(TglGetAttribLocation  , wglGetProcAddress( 'glGetAttribLocation'));
   glGetProgramiv := SYSTEM.VAL(TglGetProgramiv  , wglGetProcAddress( 'glGetProgramiv'));
   glGetProgramInfoLog := SYSTEM.VAL(TglGetProgramInfoLog  , wglGetProcAddress( 'glGetProgramInfoLog'));
   glGetShaderiv := SYSTEM.VAL(TglGetShaderiv  , wglGetProcAddress( 'glGetShaderiv'));
   glGetShaderInfoLog := SYSTEM.VAL(TglGetShaderInfoLog  , wglGetProcAddress( 'glGetShaderInfoLog'));
   glGetShaderSource := SYSTEM.VAL(TglGetShaderSource  , wglGetProcAddress( 'glGetShaderSource'));
   glGetUniformLocation := SYSTEM.VAL(TglGetUniformLocation  , wglGetProcAddress( 'glGetUniformLocation'));
   glGetUniformfv := SYSTEM.VAL(TglGetUniformfv  , wglGetProcAddress( 'glGetUniformfv'));
   glGetUniformiv := SYSTEM.VAL(TglGetUniformiv  , wglGetProcAddress( 'glGetUniformiv'));
   glGetVertexAttribfv := SYSTEM.VAL(TglGetVertexAttribfv  , wglGetProcAddress( 'glGetVertexAttribfv'));
   glGetVertexAttribiv := SYSTEM.VAL(TglGetVertexAttribiv  , wglGetProcAddress( 'glGetVertexAttribiv'));
   glGetVertexAttribPointerv := SYSTEM.VAL(TglGetVertexAttribPointerv  , wglGetProcAddress( 'glGetVertexAttribPointerv'));
   glIsProgram := SYSTEM.VAL(TglIsProgram  , wglGetProcAddress( 'glIsProgram'));
   glIsShader := SYSTEM.VAL(TglIsShader  , wglGetProcAddress( 'glIsShader'));
   glLinkProgram := SYSTEM.VAL(TglLinkProgram  , wglGetProcAddress( 'glLinkProgram'));
   glShaderSource := SYSTEM.VAL(TglShaderSource  , wglGetProcAddress( 'glShaderSource'));
   glUseProgram := SYSTEM.VAL(TglUseProgram  , wglGetProcAddress( 'glUseProgram'));
   glUniform1f := SYSTEM.VAL(TglUniform1f  , wglGetProcAddress( 'glUniform1f'));
   glUniform2f := SYSTEM.VAL(TglUniform2f  , wglGetProcAddress( 'glUniform2f'));
   glUniform3f := SYSTEM.VAL(TglUniform3f  , wglGetProcAddress( 'glUniform3f'));
   glUniform4f := SYSTEM.VAL(TglUniform4f  , wglGetProcAddress( 'glUniform4f'));
   glUniform1i := SYSTEM.VAL(TglUniform1i  , wglGetProcAddress( 'glUniform1i'));
   glUniform2i := SYSTEM.VAL(TglUniform2i  , wglGetProcAddress( 'glUniform2i'));
   glUniform3i := SYSTEM.VAL(TglUniform3i  , wglGetProcAddress( 'glUniform3i'));
   glUniform4i := SYSTEM.VAL(TglUniform4i  , wglGetProcAddress( 'glUniform4i'));
   glUniform1fv := SYSTEM.VAL(TglUniform1fv  , wglGetProcAddress( 'glUniform1fv'));
   glUniform2fv := SYSTEM.VAL(TglUniform2fv  , wglGetProcAddress( 'glUniform2fv'));
   glUniform3fv := SYSTEM.VAL(TglUniform3fv  , wglGetProcAddress( 'glUniform3fv'));
   glUniform4fv := SYSTEM.VAL(TglUniform4fv  , wglGetProcAddress( 'glUniform4fv'));
   glUniform1iv := SYSTEM.VAL(TglUniform1iv  , wglGetProcAddress( 'glUniform1iv'));
   glUniform2iv := SYSTEM.VAL(TglUniform2iv  , wglGetProcAddress( 'glUniform2iv'));
   glUniform3iv := SYSTEM.VAL(TglUniform3iv  , wglGetProcAddress( 'glUniform3iv'));
   glUniform4iv := SYSTEM.VAL(TglUniform4iv  , wglGetProcAddress( 'glUniform4iv'));
   glUniformMatrix2fv := SYSTEM.VAL(TglUniformMatrix2fv  , wglGetProcAddress( 'glUniformMatrix2fv'));
   glUniformMatrix3fv := SYSTEM.VAL(TglUniformMatrix3fv  , wglGetProcAddress( 'glUniformMatrix3fv'));
   glUniformMatrix4fv := SYSTEM.VAL(TglUniformMatrix4fv  , wglGetProcAddress( 'glUniformMatrix4fv'));
   glValidateProgram := SYSTEM.VAL(TglValidateProgram  , wglGetProcAddress( 'glValidateProgram'));
   glVertexAttrib1d := SYSTEM.VAL(TglVertexAttrib1d  , wglGetProcAddress( 'glVertexAttrib1d'));
   glVertexAttrib1dv := SYSTEM.VAL(TglVertexAttrib1dv  , wglGetProcAddress( 'glVertexAttrib1dv'));
   glVertexAttrib1f := SYSTEM.VAL(TglVertexAttrib1f  , wglGetProcAddress( 'glVertexAttrib1f'));
   glVertexAttrib1fv := SYSTEM.VAL(TglVertexAttrib1fv  , wglGetProcAddress( 'glVertexAttrib1fv'));
   glVertexAttrib1s := SYSTEM.VAL(TglVertexAttrib1s  , wglGetProcAddress( 'glVertexAttrib1s'));
   glVertexAttrib1sv := SYSTEM.VAL(TglVertexAttrib1sv  , wglGetProcAddress( 'glVertexAttrib1sv'));
   glVertexAttrib2d := SYSTEM.VAL(TglVertexAttrib2d  , wglGetProcAddress( 'glVertexAttrib2d'));
   glVertexAttrib2dv := SYSTEM.VAL(TglVertexAttrib2dv  , wglGetProcAddress( 'glVertexAttrib2dv'));
   glVertexAttrib2f := SYSTEM.VAL(TglVertexAttrib2f  , wglGetProcAddress( 'glVertexAttrib2f'));
   glVertexAttrib2fv := SYSTEM.VAL(TglVertexAttrib2fv  , wglGetProcAddress( 'glVertexAttrib2fv'));
   glVertexAttrib2s := SYSTEM.VAL(TglVertexAttrib2s  , wglGetProcAddress( 'glVertexAttrib2s'));
   glVertexAttrib2sv := SYSTEM.VAL(TglVertexAttrib2sv  , wglGetProcAddress( 'glVertexAttrib2sv'));
   glVertexAttrib3d := SYSTEM.VAL(TglVertexAttrib3d  , wglGetProcAddress( 'glVertexAttrib3d'));
   glVertexAttrib3dv := SYSTEM.VAL(TglVertexAttrib3dv  , wglGetProcAddress( 'glVertexAttrib3dv'));
   glVertexAttrib3f := SYSTEM.VAL(TglVertexAttrib3f  , wglGetProcAddress( 'glVertexAttrib3f'));
   glVertexAttrib3fv := SYSTEM.VAL(TglVertexAttrib3fv  , wglGetProcAddress( 'glVertexAttrib3fv'));
   glVertexAttrib3s := SYSTEM.VAL(TglVertexAttrib3s  , wglGetProcAddress( 'glVertexAttrib3s'));
   glVertexAttrib3sv := SYSTEM.VAL(TglVertexAttrib3sv  , wglGetProcAddress( 'glVertexAttrib3sv'));
   glVertexAttrib4Nbv := SYSTEM.VAL(TglVertexAttrib4Nbv  , wglGetProcAddress( 'glVertexAttrib4Nbv'));
   glVertexAttrib4Niv := SYSTEM.VAL(TglVertexAttrib4Niv  , wglGetProcAddress( 'glVertexAttrib4Niv'));
   glVertexAttrib4Nsv := SYSTEM.VAL(TglVertexAttrib4Nsv  , wglGetProcAddress( 'glVertexAttrib4Nsv'));
   glVertexAttrib4Nub := SYSTEM.VAL(TglVertexAttrib4Nub  , wglGetProcAddress( 'glVertexAttrib4Nub'));
   glVertexAttrib4Nubv := SYSTEM.VAL(TglVertexAttrib4Nubv  , wglGetProcAddress( 'glVertexAttrib4Nubv'));
   glVertexAttrib4Nuiv := SYSTEM.VAL(TglVertexAttrib4Nuiv  , wglGetProcAddress( 'glVertexAttrib4Nuiv'));
   glVertexAttrib4Nusv := SYSTEM.VAL(TglVertexAttrib4Nusv  , wglGetProcAddress( 'glVertexAttrib4Nusv'));
   glVertexAttrib4bv := SYSTEM.VAL(TglVertexAttrib4bv  , wglGetProcAddress( 'glVertexAttrib4bv'));
   glVertexAttrib4d := SYSTEM.VAL(TglVertexAttrib4d  , wglGetProcAddress( 'glVertexAttrib4d'));
   glVertexAttrib4dv := SYSTEM.VAL(TglVertexAttrib4dv  , wglGetProcAddress( 'glVertexAttrib4dv'));
   glVertexAttrib4f := SYSTEM.VAL(TglVertexAttrib4f  , wglGetProcAddress( 'glVertexAttrib4f'));
   glVertexAttrib4fv := SYSTEM.VAL(TglVertexAttrib4fv  , wglGetProcAddress( 'glVertexAttrib4fv'));
   glVertexAttrib4iv := SYSTEM.VAL(TglVertexAttrib4iv  , wglGetProcAddress( 'glVertexAttrib4iv'));
   glVertexAttrib4s := SYSTEM.VAL(TglVertexAttrib4s  , wglGetProcAddress( 'glVertexAttrib4s'));
   glVertexAttrib4sv := SYSTEM.VAL(TglVertexAttrib4sv  , wglGetProcAddress( 'glVertexAttrib4sv'));
   glVertexAttrib4ubv := SYSTEM.VAL(TglVertexAttrib4ubv  , wglGetProcAddress( 'glVertexAttrib4ubv'));
   glVertexAttrib4uiv := SYSTEM.VAL(TglVertexAttrib4uiv  , wglGetProcAddress( 'glVertexAttrib4uiv'));
   glVertexAttrib4usv := SYSTEM.VAL(TglVertexAttrib4usv  , wglGetProcAddress( 'glVertexAttrib4usv'));
   glVertexAttribPointer := SYSTEM.VAL(TglVertexAttribPointer  , wglGetProcAddress( 'glVertexAttribPointer'));

  (* GL_VERSION_2_1 *)
   glUniformMatrix2x3fv := SYSTEM.VAL(TglUniformMatrix2x3fv  , wglGetProcAddress( 'glUniformMatrix2x3fv'));
   glUniformMatrix3x2fv := SYSTEM.VAL(TglUniformMatrix3x2fv  , wglGetProcAddress( 'glUniformMatrix3x2fv'));
   glUniformMatrix2x4fv := SYSTEM.VAL(TglUniformMatrix2x4fv  , wglGetProcAddress( 'glUniformMatrix2x4fv'));
   glUniformMatrix4x2fv := SYSTEM.VAL(TglUniformMatrix4x2fv  , wglGetProcAddress( 'glUniformMatrix4x2fv'));
   glUniformMatrix3x4fv := SYSTEM.VAL(TglUniformMatrix3x4fv  , wglGetProcAddress( 'glUniformMatrix3x4fv'));
   glUniformMatrix4x3fv := SYSTEM.VAL(TglUniformMatrix4x3fv  , wglGetProcAddress( 'glUniformMatrix4x3fv'));
  
  (* GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions: *)
  Read_GL_ARB_framebuffer_object;
  Read_GL_ARB_map_buffer_range;
  Read_GL_ARB_vertex_array_object;

   glColorMaski := SYSTEM.VAL(TglColorMaski  , wglGetProcAddress( 'glColorMaski'));
   glGetBooleani_v := SYSTEM.VAL(TglGetBooleani_v  , wglGetProcAddress( 'glGetBooleani_v'));
   glGetIntegeri_v := SYSTEM.VAL(TglGetIntegeri_v  , wglGetProcAddress( 'glGetIntegeri_v'));
   glEnablei := SYSTEM.VAL(TglEnablei  , wglGetProcAddress( 'glEnablei'));
   glDisablei := SYSTEM.VAL(TglDisablei  , wglGetProcAddress( 'glDisablei'));
   glIsEnabledi := SYSTEM.VAL(TglIsEnabledi  , wglGetProcAddress( 'glIsEnabledi'));
   glBeginTransformFeedback := SYSTEM.VAL(TglBeginTransformFeedback  , wglGetProcAddress( 'glBeginTransformFeedback'));
   glEndTransformFeedback := SYSTEM.VAL(TglEndTransformFeedback  , wglGetProcAddress( 'glEndTransformFeedback'));
   glBindBufferRange := SYSTEM.VAL(TglBindBufferRange  , wglGetProcAddress( 'glBindBufferRange'));
   glBindBufferBase := SYSTEM.VAL(TglBindBufferBase  , wglGetProcAddress( 'glBindBufferBase'));
   glTransformFeedbackVaryings := SYSTEM.VAL(TglTransformFeedbackVaryings  , wglGetProcAddress( 'glTransformFeedbackVaryings'));
   glGetTransformFeedbackVarying := SYSTEM.VAL(TglGetTransformFeedbackVarying  , wglGetProcAddress( 'glGetTransformFeedbackVarying'));
   glClampColor := SYSTEM.VAL(TglClampColor  , wglGetProcAddress( 'glClampColor'));
   glBeginConditionalRender := SYSTEM.VAL(TglBeginConditionalRender  , wglGetProcAddress( 'glBeginConditionalRender'));
   glEndConditionalRender := SYSTEM.VAL(TglEndConditionalRender  , wglGetProcAddress( 'glEndConditionalRender'));
   glVertexAttribI1i := SYSTEM.VAL(TglVertexAttribI1i  , wglGetProcAddress( 'glVertexAttribI1i'));
   glVertexAttribI2i := SYSTEM.VAL(TglVertexAttribI2i  , wglGetProcAddress( 'glVertexAttribI2i'));
   glVertexAttribI3i := SYSTEM.VAL(TglVertexAttribI3i  , wglGetProcAddress( 'glVertexAttribI3i'));
   glVertexAttribI4i := SYSTEM.VAL(TglVertexAttribI4i  , wglGetProcAddress( 'glVertexAttribI4i'));
   glVertexAttribI1ui := SYSTEM.VAL(TglVertexAttribI1ui  , wglGetProcAddress( 'glVertexAttribI1ui'));
   glVertexAttribI2ui := SYSTEM.VAL(TglVertexAttribI2ui  , wglGetProcAddress( 'glVertexAttribI2ui'));
   glVertexAttribI3ui := SYSTEM.VAL(TglVertexAttribI3ui  , wglGetProcAddress( 'glVertexAttribI3ui'));
   glVertexAttribI4ui := SYSTEM.VAL(TglVertexAttribI4ui  , wglGetProcAddress( 'glVertexAttribI4ui'));
   glVertexAttribI1iv := SYSTEM.VAL(TglVertexAttribI1iv  , wglGetProcAddress( 'glVertexAttribI1iv'));
   glVertexAttribI2iv := SYSTEM.VAL(TglVertexAttribI2iv  , wglGetProcAddress( 'glVertexAttribI2iv'));
   glVertexAttribI3iv := SYSTEM.VAL(TglVertexAttribI3iv  , wglGetProcAddress( 'glVertexAttribI3iv'));
   glVertexAttribI4iv := SYSTEM.VAL(TglVertexAttribI4iv  , wglGetProcAddress( 'glVertexAttribI4iv'));
   glVertexAttribI1uiv := SYSTEM.VAL(TglVertexAttribI1uiv  , wglGetProcAddress( 'glVertexAttribI1uiv'));
   glVertexAttribI2uiv := SYSTEM.VAL(TglVertexAttribI2uiv  , wglGetProcAddress( 'glVertexAttribI2uiv'));
   glVertexAttribI3uiv := SYSTEM.VAL(TglVertexAttribI3uiv  , wglGetProcAddress( 'glVertexAttribI3uiv'));
   glVertexAttribI4uiv := SYSTEM.VAL(TglVertexAttribI4uiv  , wglGetProcAddress( 'glVertexAttribI4uiv'));
   glVertexAttribI4bv := SYSTEM.VAL(TglVertexAttribI4bv  , wglGetProcAddress( 'glVertexAttribI4bv'));
   glVertexAttribI4sv := SYSTEM.VAL(TglVertexAttribI4sv  , wglGetProcAddress( 'glVertexAttribI4sv'));
   glVertexAttribI4ubv := SYSTEM.VAL(TglVertexAttribI4ubv  , wglGetProcAddress( 'glVertexAttribI4ubv'));
   glVertexAttribI4usv := SYSTEM.VAL(TglVertexAttribI4usv  , wglGetProcAddress( 'glVertexAttribI4usv'));
   glVertexAttribIPointer := SYSTEM.VAL(TglVertexAttribIPointer  , wglGetProcAddress( 'glVertexAttribIPointer'));
   glGetVertexAttribIiv := SYSTEM.VAL(TglGetVertexAttribIiv  , wglGetProcAddress( 'glGetVertexAttribIiv'));
   glGetVertexAttribIuiv := SYSTEM.VAL(TglGetVertexAttribIuiv  , wglGetProcAddress( 'glGetVertexAttribIuiv'));
   glGetUniformuiv := SYSTEM.VAL(TglGetUniformuiv  , wglGetProcAddress( 'glGetUniformuiv'));
   glBindFragDataLocation := SYSTEM.VAL(TglBindFragDataLocation  , wglGetProcAddress( 'glBindFragDataLocation'));
   glGetFragDataLocation := SYSTEM.VAL(TglGetFragDataLocation  , wglGetProcAddress( 'glGetFragDataLocation'));
   glUniform1ui := SYSTEM.VAL(TglUniform1ui  , wglGetProcAddress( 'glUniform1ui'));
   glUniform2ui := SYSTEM.VAL(TglUniform2ui  , wglGetProcAddress( 'glUniform2ui'));
   glUniform3ui := SYSTEM.VAL(TglUniform3ui  , wglGetProcAddress( 'glUniform3ui'));
   glUniform4ui := SYSTEM.VAL(TglUniform4ui  , wglGetProcAddress( 'glUniform4ui'));
   glUniform1uiv := SYSTEM.VAL(TglUniform1uiv  , wglGetProcAddress( 'glUniform1uiv'));
   glUniform2uiv := SYSTEM.VAL(TglUniform2uiv  , wglGetProcAddress( 'glUniform2uiv'));
   glUniform3uiv := SYSTEM.VAL(TglUniform3uiv  , wglGetProcAddress( 'glUniform3uiv'));
   glUniform4uiv := SYSTEM.VAL(TglUniform4uiv  , wglGetProcAddress( 'glUniform4uiv'));
   glTexParameterIiv := SYSTEM.VAL(TglTexParameterIiv  , wglGetProcAddress( 'glTexParameterIiv'));
   glTexParameterIuiv := SYSTEM.VAL(TglTexParameterIuiv  , wglGetProcAddress( 'glTexParameterIuiv'));
   glGetTexParameterIiv := SYSTEM.VAL(TglGetTexParameterIiv  , wglGetProcAddress( 'glGetTexParameterIiv'));
   glGetTexParameterIuiv := SYSTEM.VAL(TglGetTexParameterIuiv  , wglGetProcAddress( 'glGetTexParameterIuiv'));
   glClearBufferiv := SYSTEM.VAL(TglClearBufferiv  , wglGetProcAddress( 'glClearBufferiv'));
   glClearBufferuiv := SYSTEM.VAL(TglClearBufferuiv  , wglGetProcAddress( 'glClearBufferuiv'));
   glClearBufferfv := SYSTEM.VAL(TglClearBufferfv  , wglGetProcAddress( 'glClearBufferfv'));
   glClearBufferfi := SYSTEM.VAL(TglClearBufferfi  , wglGetProcAddress( 'glClearBufferfi'));
   glGetStringi := SYSTEM.VAL(TglGetStringi  , wglGetProcAddress( 'glGetStringi'));

  (* GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions: *)
  Read_GL_ARB_copy_buffer;
  Read_GL_ARB_uniform_buffer_object;

   glDrawArraysInstanced := SYSTEM.VAL(TglDrawArraysInstanced  , wglGetProcAddress( 'glDrawArraysInstanced'));
   glDrawElementsInstanced := SYSTEM.VAL(TglDrawElementsInstanced  , wglGetProcAddress( 'glDrawElementsInstanced'));
   glTexBuffer := SYSTEM.VAL(TglTexBuffer  , wglGetProcAddress( 'glTexBuffer'));
   glPrimitiveRestartIndex := SYSTEM.VAL(TglPrimitiveRestartIndex  , wglGetProcAddress( 'glPrimitiveRestartIndex'));

  (* GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions: *)
  Read_GL_ARB_draw_elements_base_vertex;
  Read_GL_ARB_provoking_vertex;
  Read_GL_ARB_sync;
  Read_GL_ARB_texture_multisample;

   glGetInteger64i_v  := SYSTEM.VAL(TglGetInteger64i_v  , wglGetProcAddress( 'glGetInteger64i_v'));
   glGetBufferParameteri64v := SYSTEM.VAL(TglGetBufferParameteri64v  , wglGetProcAddress( 'glGetBufferParameteri64v'));
   glProgramParameteri := SYSTEM.VAL(TglProgramParameteri  , wglGetProcAddress( 'glProgramParameteri'));
   glFramebufferTexture := SYSTEM.VAL(TglFramebufferTexture  , wglGetProcAddress( 'glFramebufferTexture'));
  
  
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
     glVertexAttribDivisor := SYSTEM.VAL(TglVertexAttribDivisor, wglGetProcAddress('glVertexAttribDivisor'));
     
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
     glMinSampleShading := SYSTEM.VAL(TglMinSampleShading, wglGetProcAddress('glMinSampleShading'));
     glBlendEquationi := SYSTEM.VAL(TglBlendEquationi, wglGetProcAddress('glBlendEquationi'));
     glBlendEquationSeparatei := SYSTEM.VAL(TglBlendEquationSeparatei, wglGetProcAddress('glBlendEquationSeparatei'));
     glBlendFunci := SYSTEM.VAL(TglBlendFunci, wglGetProcAddress('glBlendFunci'));
     glBlendFuncSeparatei := SYSTEM.VAL(TglBlendFuncSeparatei, wglGetProcAddress('glBlendFuncSeparatei'));

 (* GL_VERSION_4_1 *)
 	(* OpenGL 4.1 also reuses entry points from these extensions: *)
  	Read_GL_ARB_ES2_compatibility;
  	Read_GL_ARB_get_program_binary;
  	Read_GL_ARB_separate_shader_objects;
  	(* ARB_shader_precision (no entry points) *)
  	Read_GL_ARB_vertex_attrib_64bit;
  	Read_GL_ARB_viewport_array;
 
   KernelLog.String(" Ok.");  KernelLog.Ln; 
END ReadOpenGLCore;


PROCEDURE Read_GL_3DFX_tbuffer;
BEGIN
     glTbufferMask3DFX := SYSTEM.VAL(TglTbufferMask3DFX, wglGetProcAddress('glTbufferMask3DFX'));
END Read_GL_3DFX_tbuffer;

PROCEDURE Read_GL_APPLE_element_array;
BEGIN
 (*    glElementPointerAPPLE := SYSTEM.VAL(TglElementPointerAPPLE, wglGetProcAddress('glElementPointerAPPLE'));
     glDrawElementArrayAPPLE := SYSTEM.VAL(TglDrawElementArrayAPPLE, wglGetProcAddress('glDrawElementArrayAPPLE'));
     glDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglDrawRangeElementArrayAPPLE, wglGetProcAddress('glDrawRangeElementArrayAPPLE'));
     glMultiDrawElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawElementArrayAPPLE, wglGetProcAddress('glMultiDrawElementArrayAPPLE'));
     glMultiDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawRangeElementArrayAPPLE, wglGetProcAddress('glMultiDrawRangeElementArrayAPPLE'));
 *)    
END Read_GL_APPLE_element_array;

PROCEDURE Read_GL_APPLE_fence;
BEGIN
(*     glGenFencesAPPLE := SYSTEM.VAL(TglGenFencesAPPLE, wglGetProcAddress('glGenFencesAPPLE'));
     glDeleteFencesAPPLE := SYSTEM.VAL(TglDeleteFencesAPPLE, wglGetProcAddress('glDeleteFencesAPPLE'));
     glSetFenceAPPLE := SYSTEM.VAL(TglSetFenceAPPLE, wglGetProcAddress('glSetFenceAPPLE'));
     glIsFenceAPPLE := SYSTEM.VAL(TglIsFenceAPPLE, wglGetProcAddress('glIsFenceAPPLE'));
     glTestFenceAPPLE := SYSTEM.VAL(TglTestFenceAPPLE, wglGetProcAddress('glTestFenceAPPLE'));
     glFinishFenceAPPLE := SYSTEM.VAL(TglFinishFenceAPPLE, wglGetProcAddress('glFinishFenceAPPLE'));
     glTestObjectAPPLE := SYSTEM.VAL(TglTestObjectAPPLE, wglGetProcAddress('glTestObjectAPPLE'));
     glFinishObjectAPPLE := SYSTEM.VAL(TglFinishObjectAPPLE, wglGetProcAddress('glFinishObjectAPPLE'));
*)     
END Read_GL_APPLE_fence;

PROCEDURE Read_GL_APPLE_vertex_array_object;
BEGIN
(*     glBindVertexArrayAPPLE := SYSTEM.VAL(TglBindVertexArrayAPPLE, wglGetProcAddress('glBindVertexArrayAPPLE'));
     glDeleteVertexArraysAPPLE := SYSTEM.VAL(TglDeleteVertexArraysAPPLE, wglGetProcAddress('glDeleteVertexArraysAPPLE'));
     glGenVertexArraysAPPLE := SYSTEM.VAL(TglGenVertexArraysAPPLE, wglGetProcAddress('glGenVertexArraysAPPLE'));
     glIsVertexArrayAPPLE := SYSTEM.VAL(TglIsVertexArrayAPPLE, wglGetProcAddress('glIsVertexArrayAPPLE'));
*)     
END Read_GL_APPLE_vertex_array_object;

PROCEDURE Read_GL_APPLE_vertex_array_range;
BEGIN
(*     glVertexArrayRangeAPPLE := SYSTEM.VAL(TglVertexArrayRangeAPPLE, wglGetProcAddress('glVertexArrayRangeAPPLE'));
     glFlushVertexArrayRangeAPPLE := SYSTEM.VAL(TglFlushVertexArrayRangeAPPLE, wglGetProcAddress('glFlushVertexArrayRangeAPPLE'));
     glVertexArrayParameteriAPPLE := SYSTEM.VAL(TglVertexArrayParameteriAPPLE, wglGetProcAddress('glVertexArrayParameteriAPPLE'));
*)
END Read_GL_APPLE_vertex_array_range;

PROCEDURE Read_GL_APPLE_texture_range;
BEGIN
(*     glTextureRangeAPPLE := SYSTEM.VAL(TglTextureRangeAPPLE, wglGetProcAddress('glTextureRangeAPPLE'));
     glGetTexParameterPointervAPPLE := SYSTEM.VAL(TglGetTexParameterPointervAPPLE, wglGetProcAddress('glGetTexParameterPointervAPPLE'));
*)
END Read_GL_APPLE_texture_range;

PROCEDURE Read_GL_APPLE_vertex_program_evaluators;
BEGIN
(*     glEnableVertexAttribAPPLE := SYSTEM.VAL(TglEnableVertexAttribAPPLE, wglGetProcAddress('glEnableVertexAttribAPPLE'));
     glDisableVertexAttribAPPLE := SYSTEM.VAL(TglDisableVertexAttribAPPLE, wglGetProcAddress('glDisableVertexAttribAPPLE'));
     glIsVertexAttribEnabledAPPLE := SYSTEM.VAL(TglIsVertexAttribEnabledAPPLE, wglGetProcAddress('glIsVertexAttribEnabledAPPLE'));
     glMapVertexAttrib1dAPPLE := SYSTEM.VAL(TglMapVertexAttrib1dAPPLE, wglGetProcAddress('glMapVertexAttrib1dAPPLE'));
     glMapVertexAttrib1fAPPLE := SYSTEM.VAL(TglMapVertexAttrib1fAPPLE, wglGetProcAddress('glMapVertexAttrib1fAPPLE'));
     glMapVertexAttrib2dAPPLE := SYSTEM.VAL(TglMapVertexAttrib2dAPPLE, wglGetProcAddress('glMapVertexAttrib2dAPPLE'));
     glMapVertexAttrib2fAPPLE := SYSTEM.VAL(TglMapVertexAttrib2fAPPLE, wglGetProcAddress('glMapVertexAttrib2fAPPLE'));
*)
END Read_GL_APPLE_vertex_program_evaluators;

PROCEDURE Read_GL_APPLE_object_purgeable;
BEGIN
(*     glObjectPurgeableAPPLE := SYSTEM.VAL(TglObjectPurgeableAPPLE, wglGetProcAddress('glObjectPurgeableAPPLE'));
     glObjectUnpurgeableAPPLE := SYSTEM.VAL(TglObjectUnpurgeableAPPLE, wglGetProcAddress('glObjectUnpurgeableAPPLE'));
     glGetObjectParameterivAPPLE := SYSTEM.VAL(TglGetObjectParameterivAPPLE, wglGetProcAddress('glGetObjectParameterivAPPLE'));
*)
END Read_GL_APPLE_object_purgeable;

PROCEDURE Read_GL_ARB_matrix_palette;
BEGIN
     glCurrentPaletteMatrixARB := SYSTEM.VAL(TglCurrentPaletteMatrixARB, wglGetProcAddress('glCurrentPaletteMatrixARB'));
     glMatrixIndexubvARB := SYSTEM.VAL(TglMatrixIndexubvARB, wglGetProcAddress('glMatrixIndexubvARB'));
     glMatrixIndexusvARB := SYSTEM.VAL(TglMatrixIndexusvARB, wglGetProcAddress('glMatrixIndexusvARB'));
     glMatrixIndexuivARB := SYSTEM.VAL(TglMatrixIndexuivARB, wglGetProcAddress('glMatrixIndexuivARB'));
     glMatrixIndexPointerARB := SYSTEM.VAL(TglMatrixIndexPointerARB, wglGetProcAddress('glMatrixIndexPointerARB'));
END Read_GL_ARB_matrix_palette;

PROCEDURE Read_GL_ARB_multisample;
BEGIN
     glSampleCoverageARB := SYSTEM.VAL(TglSampleCoverageARB, wglGetProcAddress('glSampleCoverageARB'));
END Read_GL_ARB_multisample;

PROCEDURE Read_GL_ARB_multitexture;
BEGIN
     glActiveTextureARB := SYSTEM.VAL(TglActiveTextureARB, wglGetProcAddress('glActiveTextureARB'));
     glClientActiveTextureARB := SYSTEM.VAL(TglClientActiveTextureARB, wglGetProcAddress('glClientActiveTextureARB'));
     glMultiTexCoord1dARB := SYSTEM.VAL(TglMultiTexCoord1dARB, wglGetProcAddress('glMultiTexCoord1dARB'));
     glMultiTexCoord1dvARB := SYSTEM.VAL(TglMultiTexCoord1dvARB, wglGetProcAddress('glMultiTexCoord1dvARB'));
     glMultiTexCoord1fARB := SYSTEM.VAL(TglMultiTexCoord1fARB, wglGetProcAddress('glMultiTexCoord1fARB'));
     glMultiTexCoord1fvARB := SYSTEM.VAL(TglMultiTexCoord1fvARB, wglGetProcAddress('glMultiTexCoord1fvARB'));
     glMultiTexCoord1iARB := SYSTEM.VAL(TglMultiTexCoord1iARB, wglGetProcAddress('glMultiTexCoord1iARB'));
     glMultiTexCoord1ivARB := SYSTEM.VAL(TglMultiTexCoord1ivARB, wglGetProcAddress('glMultiTexCoord1ivARB'));
     glMultiTexCoord1sARB := SYSTEM.VAL(TglMultiTexCoord1sARB, wglGetProcAddress('glMultiTexCoord1sARB'));
     glMultiTexCoord1svARB := SYSTEM.VAL(TglMultiTexCoord1svARB, wglGetProcAddress('glMultiTexCoord1svARB'));
     glMultiTexCoord2dARB := SYSTEM.VAL(TglMultiTexCoord2dARB, wglGetProcAddress('glMultiTexCoord2dARB'));
     glMultiTexCoord2dvARB := SYSTEM.VAL(TglMultiTexCoord2dvARB, wglGetProcAddress('glMultiTexCoord2dvARB'));
     glMultiTexCoord2fARB := SYSTEM.VAL(TglMultiTexCoord2fARB, wglGetProcAddress('glMultiTexCoord2fARB'));
     glMultiTexCoord2fvARB := SYSTEM.VAL(TglMultiTexCoord2fvARB, wglGetProcAddress('glMultiTexCoord2fvARB'));
     glMultiTexCoord2iARB := SYSTEM.VAL(TglMultiTexCoord2iARB, wglGetProcAddress('glMultiTexCoord2iARB'));
     glMultiTexCoord2ivARB := SYSTEM.VAL(TglMultiTexCoord2ivARB, wglGetProcAddress('glMultiTexCoord2ivARB'));
     glMultiTexCoord2sARB := SYSTEM.VAL(TglMultiTexCoord2sARB, wglGetProcAddress('glMultiTexCoord2sARB'));
     glMultiTexCoord2svARB := SYSTEM.VAL(TglMultiTexCoord2svARB, wglGetProcAddress('glMultiTexCoord2svARB'));
     glMultiTexCoord3dARB := SYSTEM.VAL(TglMultiTexCoord3dARB, wglGetProcAddress('glMultiTexCoord3dARB'));
     glMultiTexCoord3dvARB := SYSTEM.VAL(TglMultiTexCoord3dvARB, wglGetProcAddress('glMultiTexCoord3dvARB'));
     glMultiTexCoord3fARB := SYSTEM.VAL(TglMultiTexCoord3fARB, wglGetProcAddress('glMultiTexCoord3fARB'));
     glMultiTexCoord3fvARB := SYSTEM.VAL(TglMultiTexCoord3fvARB, wglGetProcAddress('glMultiTexCoord3fvARB'));
     glMultiTexCoord3iARB := SYSTEM.VAL(TglMultiTexCoord3iARB, wglGetProcAddress('glMultiTexCoord3iARB'));
     glMultiTexCoord3ivARB := SYSTEM.VAL(TglMultiTexCoord3ivARB, wglGetProcAddress('glMultiTexCoord3ivARB'));
     glMultiTexCoord3sARB := SYSTEM.VAL(TglMultiTexCoord3sARB, wglGetProcAddress('glMultiTexCoord3sARB'));
     glMultiTexCoord3svARB := SYSTEM.VAL(TglMultiTexCoord3svARB, wglGetProcAddress('glMultiTexCoord3svARB'));
     glMultiTexCoord4dARB := SYSTEM.VAL(TglMultiTexCoord4dARB, wglGetProcAddress('glMultiTexCoord4dARB'));
     glMultiTexCoord4dvARB := SYSTEM.VAL(TglMultiTexCoord4dvARB, wglGetProcAddress('glMultiTexCoord4dvARB'));
     glMultiTexCoord4fARB := SYSTEM.VAL(TglMultiTexCoord4fARB, wglGetProcAddress('glMultiTexCoord4fARB'));
     glMultiTexCoord4fvARB := SYSTEM.VAL(TglMultiTexCoord4fvARB, wglGetProcAddress('glMultiTexCoord4fvARB'));
     glMultiTexCoord4iARB := SYSTEM.VAL(TglMultiTexCoord4iARB, wglGetProcAddress('glMultiTexCoord4iARB'));
     glMultiTexCoord4ivARB := SYSTEM.VAL(TglMultiTexCoord4ivARB, wglGetProcAddress('glMultiTexCoord4ivARB'));
     glMultiTexCoord4sARB := SYSTEM.VAL(TglMultiTexCoord4sARB, wglGetProcAddress('glMultiTexCoord4sARB'));
     glMultiTexCoord4svARB := SYSTEM.VAL(TglMultiTexCoord4svARB, wglGetProcAddress('glMultiTexCoord4svARB'));
END Read_GL_ARB_multitexture;

PROCEDURE Read_GL_ARB_point_parameters;
BEGIN
     glPointParameterfARB := SYSTEM.VAL(TglPointParameterfARB, wglGetProcAddress('glPointParameterfARB'));
     glPointParameterfvARB := SYSTEM.VAL(TglPointParameterfvARB, wglGetProcAddress('glPointParameterfvARB'));
END Read_GL_ARB_point_parameters;

PROCEDURE Read_GL_ARB_texture_compression;
BEGIN
     glCompressedTexImage3DARB := SYSTEM.VAL(TglCompressedTexImage3DARB, wglGetProcAddress('glCompressedTexImage3DARB'));
     glCompressedTexImage2DARB := SYSTEM.VAL(TglCompressedTexImage2DARB, wglGetProcAddress('glCompressedTexImage2DARB'));
     glCompressedTexImage1DARB := SYSTEM.VAL(TglCompressedTexImage1DARB, wglGetProcAddress('glCompressedTexImage1DARB'));
     glCompressedTexSubImage3DARB := SYSTEM.VAL(TglCompressedTexSubImage3DARB, wglGetProcAddress('glCompressedTexSubImage3DARB'));
     glCompressedTexSubImage2DARB := SYSTEM.VAL(TglCompressedTexSubImage2DARB, wglGetProcAddress('glCompressedTexSubImage2DARB'));
     glCompressedTexSubImage1DARB := SYSTEM.VAL(TglCompressedTexSubImage1DARB, wglGetProcAddress('glCompressedTexSubImage1DARB'));
     glGetCompressedTexImageARB := SYSTEM.VAL(TglGetCompressedTexImageARB, wglGetProcAddress('glGetCompressedTexImageARB'));
END Read_GL_ARB_texture_compression;

PROCEDURE Read_GL_ARB_transpose_matrix;
BEGIN
     glLoadTransposeMatrixfARB := SYSTEM.VAL(TglLoadTransposeMatrixfARB, wglGetProcAddress('glLoadTransposeMatrixfARB'));
     glLoadTransposeMatrixdARB := SYSTEM.VAL(TglLoadTransposeMatrixdARB, wglGetProcAddress('glLoadTransposeMatrixdARB'));
     glMultTransposeMatrixfARB := SYSTEM.VAL(TglMultTransposeMatrixfARB, wglGetProcAddress('glMultTransposeMatrixfARB'));
     glMultTransposeMatrixdARB := SYSTEM.VAL(TglMultTransposeMatrixdARB, wglGetProcAddress('glMultTransposeMatrixdARB'));
END Read_GL_ARB_transpose_matrix;

PROCEDURE Read_GL_ARB_vertex_blend;
BEGIN
     glWeightbvARB := SYSTEM.VAL(TglWeightbvARB, wglGetProcAddress('glWeightbvARB'));
     glWeightsvARB := SYSTEM.VAL(TglWeightsvARB, wglGetProcAddress('glWeightsvARB'));
     glWeightivARB := SYSTEM.VAL(TglWeightivARB, wglGetProcAddress('glWeightivARB'));
     glWeightfvARB := SYSTEM.VAL(TglWeightfvARB, wglGetProcAddress('glWeightfvARB'));
     glWeightdvARB := SYSTEM.VAL(TglWeightdvARB, wglGetProcAddress('glWeightdvARB'));
     glWeightubvARB := SYSTEM.VAL(TglWeightubvARB, wglGetProcAddress('glWeightubvARB'));
     glWeightusvARB := SYSTEM.VAL(TglWeightusvARB, wglGetProcAddress('glWeightusvARB'));
     glWeightuivARB := SYSTEM.VAL(TglWeightuivARB, wglGetProcAddress('glWeightuivARB'));
     glWeightPointerARB := SYSTEM.VAL(TglWeightPointerARB, wglGetProcAddress('glWeightPointerARB'));
     glVertexBlendARB := SYSTEM.VAL(TglVertexBlendARB, wglGetProcAddress('glVertexBlendARB'));
END Read_GL_ARB_vertex_blend;

PROCEDURE Read_GL_ARB_vertex_buffer_object;
BEGIN
     glBindBufferARB := SYSTEM.VAL(TglBindBufferARB, wglGetProcAddress('glBindBufferARB'));
     glDeleteBuffersARB := SYSTEM.VAL(TglDeleteBuffersARB, wglGetProcAddress('glDeleteBuffersARB'));
     glGenBuffersARB := SYSTEM.VAL(TglGenBuffersARB, wglGetProcAddress('glGenBuffersARB'));
     glIsBufferARB := SYSTEM.VAL(TglIsBufferARB, wglGetProcAddress('glIsBufferARB'));
     glBufferDataARB := SYSTEM.VAL(TglBufferDataARB, wglGetProcAddress('glBufferDataARB'));
     glBufferSubDataARB := SYSTEM.VAL(TglBufferSubDataARB, wglGetProcAddress('glBufferSubDataARB'));
     glGetBufferSubDataARB := SYSTEM.VAL(TglGetBufferSubDataARB, wglGetProcAddress('glGetBufferSubDataARB'));
     glMapBufferARB := SYSTEM.VAL(TglMapBufferARB, wglGetProcAddress('glMapBufferARB'));
     glUnmapBufferARB := SYSTEM.VAL(TglUnmapBufferARB, wglGetProcAddress('glUnmapBufferARB'));
     glGetBufferParameterivARB := SYSTEM.VAL(TglGetBufferParameterivARB, wglGetProcAddress('glGetBufferParameterivARB'));
     glGetBufferPointervARB := SYSTEM.VAL(TglGetBufferPointervARB, wglGetProcAddress('glGetBufferPointervARB'));
END Read_GL_ARB_vertex_buffer_object;

PROCEDURE Read_GL_ARB_vertex_program;
BEGIN
     glVertexAttrib1dARB := SYSTEM.VAL(TglVertexAttrib1dARB, wglGetProcAddress('glVertexAttrib1dARB'));
     glVertexAttrib1dvARB := SYSTEM.VAL(TglVertexAttrib1dvARB, wglGetProcAddress('glVertexAttrib1dvARB'));
     glVertexAttrib1fARB := SYSTEM.VAL(TglVertexAttrib1fARB, wglGetProcAddress('glVertexAttrib1fARB'));
     glVertexAttrib1fvARB := SYSTEM.VAL(TglVertexAttrib1fvARB, wglGetProcAddress('glVertexAttrib1fvARB'));
     glVertexAttrib1sARB := SYSTEM.VAL(TglVertexAttrib1sARB, wglGetProcAddress('glVertexAttrib1sARB'));
     glVertexAttrib1svARB := SYSTEM.VAL(TglVertexAttrib1svARB, wglGetProcAddress('glVertexAttrib1svARB'));
     glVertexAttrib2dARB := SYSTEM.VAL(TglVertexAttrib2dARB, wglGetProcAddress('glVertexAttrib2dARB'));
     glVertexAttrib2dvARB := SYSTEM.VAL(TglVertexAttrib2dvARB, wglGetProcAddress('glVertexAttrib2dvARB'));
     glVertexAttrib2fARB := SYSTEM.VAL(TglVertexAttrib2fARB, wglGetProcAddress('glVertexAttrib2fARB'));
     glVertexAttrib2fvARB := SYSTEM.VAL(TglVertexAttrib2fvARB, wglGetProcAddress('glVertexAttrib2fvARB'));
     glVertexAttrib2sARB := SYSTEM.VAL(TglVertexAttrib2sARB, wglGetProcAddress('glVertexAttrib2sARB'));
     glVertexAttrib2svARB := SYSTEM.VAL(TglVertexAttrib2svARB, wglGetProcAddress('glVertexAttrib2svARB'));
     glVertexAttrib3dARB := SYSTEM.VAL(TglVertexAttrib3dARB, wglGetProcAddress('glVertexAttrib3dARB'));
     glVertexAttrib3dvARB := SYSTEM.VAL(TglVertexAttrib3dvARB, wglGetProcAddress('glVertexAttrib3dvARB'));
     glVertexAttrib3fARB := SYSTEM.VAL(TglVertexAttrib3fARB, wglGetProcAddress('glVertexAttrib3fARB'));
     glVertexAttrib3fvARB := SYSTEM.VAL(TglVertexAttrib3fvARB, wglGetProcAddress('glVertexAttrib3fvARB'));
     glVertexAttrib3sARB := SYSTEM.VAL(TglVertexAttrib3sARB, wglGetProcAddress('glVertexAttrib3sARB'));
     glVertexAttrib3svARB := SYSTEM.VAL(TglVertexAttrib3svARB, wglGetProcAddress('glVertexAttrib3svARB'));
     glVertexAttrib4NbvARB := SYSTEM.VAL(TglVertexAttrib4NbvARB, wglGetProcAddress('glVertexAttrib4NbvARB'));
     glVertexAttrib4NivARB := SYSTEM.VAL(TglVertexAttrib4NivARB, wglGetProcAddress('glVertexAttrib4NivARB'));
     glVertexAttrib4NsvARB := SYSTEM.VAL(TglVertexAttrib4NsvARB, wglGetProcAddress('glVertexAttrib4NsvARB'));
     glVertexAttrib4NubARB := SYSTEM.VAL(TglVertexAttrib4NubARB, wglGetProcAddress('glVertexAttrib4NubARB'));
     glVertexAttrib4NubvARB := SYSTEM.VAL(TglVertexAttrib4NubvARB, wglGetProcAddress('glVertexAttrib4NubvARB'));
     glVertexAttrib4NuivARB := SYSTEM.VAL(TglVertexAttrib4NuivARB, wglGetProcAddress('glVertexAttrib4NuivARB'));
     glVertexAttrib4NusvARB := SYSTEM.VAL(TglVertexAttrib4NusvARB, wglGetProcAddress('glVertexAttrib4NusvARB'));
     glVertexAttrib4bvARB := SYSTEM.VAL(TglVertexAttrib4bvARB, wglGetProcAddress('glVertexAttrib4bvARB'));
     glVertexAttrib4dARB := SYSTEM.VAL(TglVertexAttrib4dARB, wglGetProcAddress('glVertexAttrib4dARB'));
     glVertexAttrib4dvARB := SYSTEM.VAL(TglVertexAttrib4dvARB, wglGetProcAddress('glVertexAttrib4dvARB'));
     glVertexAttrib4fARB := SYSTEM.VAL(TglVertexAttrib4fARB, wglGetProcAddress('glVertexAttrib4fARB'));
     glVertexAttrib4fvARB := SYSTEM.VAL(TglVertexAttrib4fvARB, wglGetProcAddress('glVertexAttrib4fvARB'));
     glVertexAttrib4ivARB := SYSTEM.VAL(TglVertexAttrib4ivARB, wglGetProcAddress('glVertexAttrib4ivARB'));
     glVertexAttrib4sARB := SYSTEM.VAL(TglVertexAttrib4sARB, wglGetProcAddress('glVertexAttrib4sARB'));
     glVertexAttrib4svARB := SYSTEM.VAL(TglVertexAttrib4svARB, wglGetProcAddress('glVertexAttrib4svARB'));
     glVertexAttrib4ubvARB := SYSTEM.VAL(TglVertexAttrib4ubvARB, wglGetProcAddress('glVertexAttrib4ubvARB'));
     glVertexAttrib4uivARB := SYSTEM.VAL(TglVertexAttrib4uivARB, wglGetProcAddress('glVertexAttrib4uivARB'));
     glVertexAttrib4usvARB := SYSTEM.VAL(TglVertexAttrib4usvARB, wglGetProcAddress('glVertexAttrib4usvARB'));
     glVertexAttribPointerARB := SYSTEM.VAL(TglVertexAttribPointerARB, wglGetProcAddress('glVertexAttribPointerARB'));
     glEnableVertexAttribArrayARB := SYSTEM.VAL(TglEnableVertexAttribArrayARB, wglGetProcAddress('glEnableVertexAttribArrayARB'));
     glDisableVertexAttribArrayARB := SYSTEM.VAL(TglDisableVertexAttribArrayARB, wglGetProcAddress('glDisableVertexAttribArrayARB'));
     glProgramStringARB := SYSTEM.VAL(TglProgramStringARB, wglGetProcAddress('glProgramStringARB'));
     glBindProgramARB := SYSTEM.VAL(TglBindProgramARB, wglGetProcAddress('glBindProgramARB'));
     glDeleteProgramsARB := SYSTEM.VAL(TglDeleteProgramsARB, wglGetProcAddress('glDeleteProgramsARB'));
     glGenProgramsARB := SYSTEM.VAL(TglGenProgramsARB, wglGetProcAddress('glGenProgramsARB'));
     glProgramEnvParameter4dARB := SYSTEM.VAL(TglProgramEnvParameter4dARB, wglGetProcAddress('glProgramEnvParameter4dARB'));
     glProgramEnvParameter4dvARB := SYSTEM.VAL(TglProgramEnvParameter4dvARB, wglGetProcAddress('glProgramEnvParameter4dvARB'));
     glProgramEnvParameter4fARB := SYSTEM.VAL(TglProgramEnvParameter4fARB, wglGetProcAddress('glProgramEnvParameter4fARB'));
     glProgramEnvParameter4fvARB := SYSTEM.VAL(TglProgramEnvParameter4fvARB, wglGetProcAddress('glProgramEnvParameter4fvARB'));
     glProgramLocalParameter4dARB := SYSTEM.VAL(TglProgramLocalParameter4dARB, wglGetProcAddress('glProgramLocalParameter4dARB'));
     glProgramLocalParameter4dvARB := SYSTEM.VAL(TglProgramLocalParameter4dvARB, wglGetProcAddress('glProgramLocalParameter4dvARB'));
     glProgramLocalParameter4fARB := SYSTEM.VAL(TglProgramLocalParameter4fARB, wglGetProcAddress('glProgramLocalParameter4fARB'));
     glProgramLocalParameter4fvARB := SYSTEM.VAL(TglProgramLocalParameter4fvARB, wglGetProcAddress('glProgramLocalParameter4fvARB'));
     glGetProgramEnvParameterdvARB := SYSTEM.VAL(TglGetProgramEnvParameterdvARB, wglGetProcAddress('glGetProgramEnvParameterdvARB'));
     glGetProgramEnvParameterfvARB := SYSTEM.VAL(TglGetProgramEnvParameterfvARB, wglGetProcAddress('glGetProgramEnvParameterfvARB'));
     glGetProgramLocalParameterdvARB := SYSTEM.VAL(TglGetProgramLocalParameterdvARB, wglGetProcAddress('glGetProgramLocalParameterdvARB'));
     glGetProgramLocalParameterfvARB := SYSTEM.VAL(TglGetProgramLocalParameterfvARB, wglGetProcAddress('glGetProgramLocalParameterfvARB'));
     glGetProgramivARB := SYSTEM.VAL(TglGetProgramivARB, wglGetProcAddress('glGetProgramivARB'));
     glGetProgramStringARB := SYSTEM.VAL(TglGetProgramStringARB, wglGetProcAddress('glGetProgramStringARB'));
     glGetVertexAttribdvARB := SYSTEM.VAL(TglGetVertexAttribdvARB, wglGetProcAddress('glGetVertexAttribdvARB'));
     glGetVertexAttribfvARB := SYSTEM.VAL(TglGetVertexAttribfvARB, wglGetProcAddress('glGetVertexAttribfvARB'));
     glGetVertexAttribivARB := SYSTEM.VAL(TglGetVertexAttribivARB, wglGetProcAddress('glGetVertexAttribivARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, wglGetProcAddress('glGetVertexAttribPointervARB'));
     glIsProgramARB := SYSTEM.VAL(TglIsProgramARB, wglGetProcAddress('glIsProgramARB'));
END Read_GL_ARB_vertex_program;

PROCEDURE Read_GL_ARB_window_pos;
BEGIN
     glWindowPos2dARB := SYSTEM.VAL(TglWindowPos2dARB, wglGetProcAddress('glWindowPos2dARB'));
     glWindowPos2dvARB := SYSTEM.VAL(TglWindowPos2dvARB, wglGetProcAddress('glWindowPos2dvARB'));
     glWindowPos2fARB := SYSTEM.VAL(TglWindowPos2fARB, wglGetProcAddress('glWindowPos2fARB'));
     glWindowPos2fvARB := SYSTEM.VAL(TglWindowPos2fvARB, wglGetProcAddress('glWindowPos2fvARB'));
     glWindowPos2iARB := SYSTEM.VAL(TglWindowPos2iARB, wglGetProcAddress('glWindowPos2iARB'));
     glWindowPos2ivARB := SYSTEM.VAL(TglWindowPos2ivARB, wglGetProcAddress('glWindowPos2ivARB'));
     glWindowPos2sARB := SYSTEM.VAL(TglWindowPos2sARB, wglGetProcAddress('glWindowPos2sARB'));
     glWindowPos2svARB := SYSTEM.VAL(TglWindowPos2svARB, wglGetProcAddress('glWindowPos2svARB'));
     glWindowPos3dARB := SYSTEM.VAL(TglWindowPos3dARB, wglGetProcAddress('glWindowPos3dARB'));
     glWindowPos3dvARB := SYSTEM.VAL(TglWindowPos3dvARB, wglGetProcAddress('glWindowPos3dvARB'));
     glWindowPos3fARB := SYSTEM.VAL(TglWindowPos3fARB, wglGetProcAddress('glWindowPos3fARB'));
     glWindowPos3fvARB := SYSTEM.VAL(TglWindowPos3fvARB, wglGetProcAddress('glWindowPos3fvARB'));
     glWindowPos3iARB := SYSTEM.VAL(TglWindowPos3iARB, wglGetProcAddress('glWindowPos3iARB'));
     glWindowPos3ivARB := SYSTEM.VAL(TglWindowPos3ivARB, wglGetProcAddress('glWindowPos3ivARB'));
     glWindowPos3sARB := SYSTEM.VAL(TglWindowPos3sARB, wglGetProcAddress('glWindowPos3sARB'));
     glWindowPos3svARB := SYSTEM.VAL(TglWindowPos3svARB, wglGetProcAddress('glWindowPos3svARB'));
END Read_GL_ARB_window_pos;

PROCEDURE Read_GL_ARB_draw_buffers;
BEGIN
     glDrawBuffersARB := SYSTEM.VAL(TglDrawBuffersARB, wglGetProcAddress('glDrawBuffersARB'));
END Read_GL_ARB_draw_buffers;

PROCEDURE Read_GL_ARB_color_buffer_float;
BEGIN
     glClampColorARB := SYSTEM.VAL(TglClampColorARB, wglGetProcAddress('glClampColorARB'));
END Read_GL_ARB_color_buffer_float;

PROCEDURE Read_GL_ARB_Shader_Objects;
BEGIN
(*  GL_ARB_Shader_Objects *)
     glCreateShaderObjectARB := SYSTEM.VAL(TglCreateShaderObjectARB, wglGetProcAddress('glCreateShaderObjectARB'));
     glShaderSourceARB := SYSTEM.VAL(TglShaderSourceARB, wglGetProcAddress('glShaderSourceARB'));
     glCompileShaderARB := SYSTEM.VAL(TglCompileShaderARB, wglGetProcAddress('glCompileShaderARB'));
     glDeleteObjectARB := SYSTEM.VAL(TglDeleteObjectARB, wglGetProcAddress('glDeleteObjectARB'));
     glGetHandleARB := SYSTEM.VAL(TglGetHandleARB, wglGetProcAddress('glGetHandleARB'));
     glDetachObjectARB := SYSTEM.VAL(TglDetachObjectARB, wglGetProcAddress('glDetachObjectARB'));
     glCreateProgramObjectARB := SYSTEM.VAL(TglCreateProgramObjectARB, wglGetProcAddress('glCreateProgramObjectARB'));
     glAttachObjectARB := SYSTEM.VAL(TglAttachObjectARB, wglGetProcAddress('glAttachObjectARB'));
     glLinkProgramARB := SYSTEM.VAL(TglLinkProgramARB, wglGetProcAddress('glLinkProgramARB'));
     glUseProgramObjectARB := SYSTEM.VAL(TglUseProgramObjectARB, wglGetProcAddress('glUseProgramObjectARB'));
     glValidateProgramARB := SYSTEM.VAL(TglValidateProgramARB, wglGetProcAddress('glValidateProgramARB'));
     glGetObjectParameterfvARB := SYSTEM.VAL(TglGetObjectParameterfvARB, wglGetProcAddress('glGetObjectParameterfvARB'));
     glGetObjectParameterivARB := SYSTEM.VAL(TglGetObjectParameterivARB, wglGetProcAddress('glGetObjectParameterivARB'));
     glGetActiveUniformARB := SYSTEM.VAL(TglGetActiveUniformARB, wglGetProcAddress('glGetActiveUniformARB'));
     glGetAttachedObjectsARB := SYSTEM.VAL(TglGetAttachedObjectsARB, wglGetProcAddress('glGetAttachedObjectsARB'));
     glGetShaderSourceARB := SYSTEM.VAL(TglGetShaderSourceARB, wglGetProcAddress('glGetShaderSourceARB'));
     glGetUniformfvARB := SYSTEM.VAL(TglGetUniformfvARB, wglGetProcAddress('glGetUniformfvARB'));
     glGetUniformivARB := SYSTEM.VAL(TglGetUniformivARB, wglGetProcAddress('glGetUniformivARB'));
     glGetUniformLocationARB := SYSTEM.VAL(TglGetUniformLocationARB, wglGetProcAddress('glGetUniformLocationARB'));
     glGetInfoLogARB := SYSTEM.VAL(TglGetInfoLogARB, wglGetProcAddress('glGetInfoLogARB'));
     glUniform1fARB := SYSTEM.VAL(TglUniform1fARB, wglGetProcAddress('glUniform1fARB'));
     glUniform2fARB := SYSTEM.VAL(TglUniform2fARB, wglGetProcAddress('glUniform2fARB'));
     glUniform3fARB := SYSTEM.VAL(TglUniform3fARB, wglGetProcAddress('glUniform3fARB'));
     glUniform4fARB := SYSTEM.VAL(TglUniform4fARB, wglGetProcAddress('glUniform4fARB'));
     glUniform1iARB := SYSTEM.VAL(TglUniform1iARB, wglGetProcAddress('glUniform1iARB'));
     glUniform2iARB := SYSTEM.VAL(TglUniform2iARB, wglGetProcAddress('glUniform2iARB'));
     glUniform3iARB := SYSTEM.VAL(TglUniform3iARB, wglGetProcAddress('glUniform3iARB'));
     glUniform4iARB := SYSTEM.VAL(TglUniform4iARB, wglGetProcAddress('glUniform4iARB'));
     glUniform1fvARB := SYSTEM.VAL(TglUniform1fvARB, wglGetProcAddress('glUniform1fvARB'));
     glUniform2fvARB := SYSTEM.VAL(TglUniform2fvARB, wglGetProcAddress('glUniform2fvARB'));
     glUniform3fvARB := SYSTEM.VAL(TglUniform3fvARB, wglGetProcAddress('glUniform3fvARB'));
     glUniform4fvARB := SYSTEM.VAL(TglUniform4fvARB, wglGetProcAddress('glUniform4fvARB'));
     glUniform1ivARB := SYSTEM.VAL(TglUniform1ivARB, wglGetProcAddress('glUniform1ivARB'));
     glUniform2ivARB := SYSTEM.VAL(TglUniform2ivARB, wglGetProcAddress('glUniform2ivARB'));
     glUniform3ivARB := SYSTEM.VAL(TglUniform3ivARB, wglGetProcAddress('glUniform3ivARB'));
     glUniform4ivARB := SYSTEM.VAL(TglUniform4ivARB, wglGetProcAddress('glUniform4ivARB'));
     glUniformMatrix2fvARB := SYSTEM.VAL(TglUniformMatrix2fvARB, wglGetProcAddress('glUniformMatrix2fvARB'));
     glUniformMatrix3fvARB := SYSTEM.VAL(TglUniformMatrix3fvARB, wglGetProcAddress('glUniformMatrix3fvARB'));
     glUniformMatrix4fvARB := SYSTEM.VAL(TglUniformMatrix4fvARB, wglGetProcAddress('glUniformMatrix4fvARB'));
     
	(* GL_ARB_vertex_shader *)
     glGetActiveAttribARB := SYSTEM.VAL(TglGetActiveAttribARB, wglGetProcAddress('glGetActiveAttribARB'));
     glGetAttribLocationARB := SYSTEM.VAL(TglGetAttribLocationARB, wglGetProcAddress('glGetAttribLocationARB'));
     glBindAttribLocationARB := SYSTEM.VAL(TglBindAttribLocationARB, wglGetProcAddress('glBindAttribLocationARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, wglGetProcAddress('glGetVertexAttribPointervARB'));
END Read_GL_ARB_Shader_Objects;

PROCEDURE Read_GL_ARB_occlusion_query;
BEGIN
     glGenQueriesARB := SYSTEM.VAL(TglGenQueriesARB, wglGetProcAddress('glGenQueriesARB'));
     glDeleteQueriesARB := SYSTEM.VAL(TglDeleteQueriesARB, wglGetProcAddress('glDeleteQueriesARB'));
     glIsQueryARB := SYSTEM.VAL(TglIsQueryARB, wglGetProcAddress('glIsQueryARB'));
     glBeginQueryARB := SYSTEM.VAL(TglBeginQueryARB, wglGetProcAddress('glBeginQueryARB'));
     glEndQueryARB := SYSTEM.VAL(TglEndQueryARB, wglGetProcAddress('glEndQueryARB'));
     glGetQueryivARB := SYSTEM.VAL(TglGetQueryivARB, wglGetProcAddress('glGetQueryivARB'));
     glGetQueryObjectivARB := SYSTEM.VAL(TglGetQueryObjectivARB, wglGetProcAddress('glGetQueryObjectivARB'));
     glGetQueryObjectuivARB := SYSTEM.VAL(TglGetQueryObjectuivARB, wglGetProcAddress('glGetQueryObjectuivARB'));
END Read_GL_ARB_occlusion_query;

PROCEDURE Read_GL_ARB_draw_instanced;
BEGIN
     glDrawArraysInstancedARB := SYSTEM.VAL(TglDrawArraysInstancedARB, wglGetProcAddress('glDrawArraysInstancedARB'));
     glDrawElementsInstancedARB := SYSTEM.VAL(TglDrawElementsInstancedARB, wglGetProcAddress('glDrawElementsInstancedARB'));
END Read_GL_ARB_draw_instanced;

PROCEDURE Read_GL_ARB_framebuffer_object;
BEGIN
     glIsRenderbuffer := SYSTEM.VAL(TglIsRenderbuffer, wglGetProcAddress('glIsRenderbuffer'));
     glBindRenderbuffer := SYSTEM.VAL(TglBindRenderbuffer, wglGetProcAddress('glBindRenderbuffer'));
     glDeleteRenderbuffers := SYSTEM.VAL(TglDeleteRenderbuffers, wglGetProcAddress('glDeleteRenderbuffers'));
     glGenRenderbuffers := SYSTEM.VAL(TglGenRenderbuffers, wglGetProcAddress('glGenRenderbuffers'));
     glRenderbufferStorage := SYSTEM.VAL(TglRenderbufferStorage, wglGetProcAddress('glRenderbufferStorage'));
     glGetRenderbufferParameteriv := SYSTEM.VAL(TglGetRenderbufferParameteriv, wglGetProcAddress('glGetRenderbufferParameteriv'));
     glIsFramebuffer := SYSTEM.VAL(TglIsFramebuffer, wglGetProcAddress('glIsFramebuffer'));
     glBindFramebuffer := SYSTEM.VAL(TglBindFramebuffer, wglGetProcAddress('glBindFramebuffer'));
     glDeleteFramebuffers := SYSTEM.VAL(TglDeleteFramebuffers, wglGetProcAddress('glDeleteFramebuffers'));
     glGenFramebuffers := SYSTEM.VAL(TglGenFramebuffers, wglGetProcAddress('glGenFramebuffers'));
     glCheckFramebufferStatus := SYSTEM.VAL(TglCheckFramebufferStatus, wglGetProcAddress('glCheckFramebufferStatus'));
     glFramebufferTexture1D := SYSTEM.VAL(TglFramebufferTexture1D, wglGetProcAddress('glFramebufferTexture1D'));
     glFramebufferTexture2D := SYSTEM.VAL(TglFramebufferTexture2D, wglGetProcAddress('glFramebufferTexture2D'));
     glFramebufferTexture3D := SYSTEM.VAL(TglFramebufferTexture3D, wglGetProcAddress('glFramebufferTexture3D'));
     glFramebufferRenderbuffer := SYSTEM.VAL(TglFramebufferRenderbuffer, wglGetProcAddress('glFramebufferRenderbuffer'));
     glGetFramebufferAttachmentParameteriv := SYSTEM.VAL(TglGetFramebufferAttachmentParameteriv, wglGetProcAddress('glGetFramebufferAttachmentParameteriv'));
     glGenerateMipmap := SYSTEM.VAL(TglGenerateMipmap, wglGetProcAddress('glGenerateMipmap'));
     glBlitFramebuffer := SYSTEM.VAL(TglBlitFramebuffer, wglGetProcAddress('glBlitFramebuffer'));
     glRenderbufferStorageMultisample := SYSTEM.VAL(TglRenderbufferStorageMultisample, wglGetProcAddress('glRenderbufferStorageMultisample'));
     glFramebufferTextureLayer := SYSTEM.VAL(TglFramebufferTextureLayer, wglGetProcAddress('glFramebufferTextureLayer'));
END Read_GL_ARB_framebuffer_object;

PROCEDURE Read_GL_ARB_geometry_shader4;
BEGIN
     glProgramParameteriARB := SYSTEM.VAL(TglProgramParameteriARB, wglGetProcAddress('glProgramParameteriARB'));
     glFramebufferTextureARB := SYSTEM.VAL(TglFramebufferTextureARB, wglGetProcAddress('glFramebufferTextureARB'));
     glFramebufferTextureLayerARB := SYSTEM.VAL(TglFramebufferTextureLayerARB, wglGetProcAddress('glFramebufferTextureLayerARB'));
     glFramebufferTextureFaceARB := SYSTEM.VAL(TglFramebufferTextureFaceARB, wglGetProcAddress('glFramebufferTextureFaceARB'));
END Read_GL_ARB_geometry_shader4;

PROCEDURE Read_GL_ARB_instanced_arrays;
BEGIN
     glVertexAttribDivisorARB := SYSTEM.VAL(TglVertexAttribDivisorARB, wglGetProcAddress('glVertexAttribDivisorARB'));
END Read_GL_ARB_instanced_arrays;

PROCEDURE Read_GL_ARB_map_buffer_range;
BEGIN
     glMapBufferRange := SYSTEM.VAL(TglMapBufferRange, wglGetProcAddress('glMapBufferRange'));
     glFlushMappedBufferRange := SYSTEM.VAL(TglFlushMappedBufferRange, wglGetProcAddress('glFlushMappedBufferRange'));
END Read_GL_ARB_map_buffer_range;

PROCEDURE Read_GL_ARB_texture_buffer_object;
BEGIN
     glTexBufferARB := SYSTEM.VAL(TglTexBufferARB, wglGetProcAddress('glTexBufferARB'));
END Read_GL_ARB_texture_buffer_object;

PROCEDURE Read_GL_ARB_vertex_array_object;
BEGIN
     glBindVertexArray := SYSTEM.VAL(TglBindVertexArray, wglGetProcAddress('glBindVertexArray'));
     glDeleteVertexArrays := SYSTEM.VAL(TglDeleteVertexArrays, wglGetProcAddress('glDeleteVertexArrays'));
     glGenVertexArrays := SYSTEM.VAL(TglGenVertexArrays, wglGetProcAddress('glGenVertexArrays'));
     glIsVertexArray := SYSTEM.VAL(TglIsVertexArray, wglGetProcAddress('glIsVertexArray'));
END Read_GL_ARB_vertex_array_object;

PROCEDURE Read_GL_ARB_uniform_buffer_object;
BEGIN
     glGetUniformIndices := SYSTEM.VAL(TglGetUniformIndices, wglGetProcAddress('glGetUniformIndices'));
     glGetActiveUniformsiv := SYSTEM.VAL(TglGetActiveUniformsiv, wglGetProcAddress('glGetActiveUniformsiv'));
     glGetActiveUniformName := SYSTEM.VAL(TglGetActiveUniformName, wglGetProcAddress('glGetActiveUniformName'));
     glGetUniformBlockIndex := SYSTEM.VAL(TglGetUniformBlockIndex, wglGetProcAddress('glGetUniformBlockIndex'));
     glGetActiveUniformBlockiv := SYSTEM.VAL(TglGetActiveUniformBlockiv, wglGetProcAddress('glGetActiveUniformBlockiv'));
     glGetActiveUniformBlockName := SYSTEM.VAL(TglGetActiveUniformBlockName, wglGetProcAddress('glGetActiveUniformBlockName'));
     glUniformBlockBinding := SYSTEM.VAL(TglUniformBlockBinding, wglGetProcAddress('glUniformBlockBinding'));
END Read_GL_ARB_uniform_buffer_object;

PROCEDURE Read_GL_ARB_copy_buffer;
BEGIN
     glCopyBufferSubData := SYSTEM.VAL(TglCopyBufferSubData, wglGetProcAddress('glCopyBufferSubData'));
END Read_GL_ARB_copy_buffer;

PROCEDURE Read_GL_ARB_draw_elements_base_vertex;
BEGIN
     glDrawElementsBaseVertex := SYSTEM.VAL(TglDrawElementsBaseVertex, wglGetProcAddress('glDrawElementsBaseVertex'));
     glDrawRangeElementsBaseVertex := SYSTEM.VAL(TglDrawRangeElementsBaseVertex, wglGetProcAddress('glDrawRangeElementsBaseVertex'));
     glDrawElementsInstancedBaseVertex := SYSTEM.VAL(TglDrawElementsInstancedBaseVertex, wglGetProcAddress('glDrawElementsInstancedBaseVertex'));
     glMultiDrawElementsBaseVertex := SYSTEM.VAL(TglMultiDrawElementsBaseVertex, wglGetProcAddress('glMultiDrawElementsBaseVertex'));
END Read_GL_ARB_draw_elements_base_vertex;

PROCEDURE Read_GL_ARB_provoking_vertex;
BEGIN
     glProvokingVertex := SYSTEM.VAL(TglProvokingVertex, wglGetProcAddress('glProvokingVertex'));
END Read_GL_ARB_provoking_vertex;

PROCEDURE Read_GL_ARB_sync;
BEGIN
     glFenceSync := SYSTEM.VAL(TglFenceSync, wglGetProcAddress('glFenceSync'));
     glIsSync := SYSTEM.VAL(TglIsSync, wglGetProcAddress('glIsSync'));
     glDeleteSync := SYSTEM.VAL(TglDeleteSync, wglGetProcAddress('glDeleteSync'));
     glClientWaitSync := SYSTEM.VAL(TglClientWaitSync, wglGetProcAddress('glClientWaitSync'));
     glWaitSync := SYSTEM.VAL(TglWaitSync, wglGetProcAddress('glWaitSync'));
     glGetInteger64v := SYSTEM.VAL(TglGetInteger64v, wglGetProcAddress('glGetInteger64v'));
     glGetSynciv := SYSTEM.VAL(TglGetSynciv, wglGetProcAddress('glGetSynciv'));
END Read_GL_ARB_sync;

PROCEDURE Read_GL_ARB_texture_multisample;
BEGIN
     glTexImage2DMultisample := SYSTEM.VAL(TglTexImage2DMultisample, wglGetProcAddress('glTexImage2DMultisample'));
     glTexImage3DMultisample := SYSTEM.VAL(TglTexImage3DMultisample, wglGetProcAddress('glTexImage3DMultisample'));
     glGetMultisamplefv := SYSTEM.VAL(TglGetMultisamplefv, wglGetProcAddress('glGetMultisamplefv'));
     glSampleMaski := SYSTEM.VAL(TglSampleMaski, wglGetProcAddress('glSampleMaski'));
END Read_GL_ARB_texture_multisample;

PROCEDURE Read_GL_ARB_draw_buffers_blend;
BEGIN
     glBlendEquationiARB := SYSTEM.VAL(TglBlendEquationiARB, wglGetProcAddress('glBlendEquationiARB'));
     glBlendEquationSeparateiARB := SYSTEM.VAL(TglBlendEquationSeparateiARB, wglGetProcAddress('glBlendEquationSeparateiARB'));
     glBlendFunciARB := SYSTEM.VAL(TglBlendFunciARB, wglGetProcAddress('glBlendFunciARB'));
     glBlendFuncSeparateiARB := SYSTEM.VAL(TglBlendFuncSeparateiARB, wglGetProcAddress('glBlendFuncSeparateiARB'));
END Read_GL_ARB_draw_buffers_blend;

PROCEDURE Read_GL_ARB_sample_shading;
BEGIN
     glMinSampleShadingARB := SYSTEM.VAL(TglMinSampleShadingARB, wglGetProcAddress('glMinSampleShadingARB'));
END Read_GL_ARB_sample_shading;

PROCEDURE Read_GL_ARB_shading_language_include;
BEGIN
     glNamedStringARB := SYSTEM.VAL(TglNamedStringARB, wglGetProcAddress('glNamedStringARB'));
     glDeleteNamedStringARB := SYSTEM.VAL(TglDeleteNamedStringARB, wglGetProcAddress('glDeleteNamedStringARB'));
     glCompileShaderIncludeARB := SYSTEM.VAL(TglCompileShaderIncludeARB, wglGetProcAddress('glCompileShaderIncludeARB'));
     glIsNamedStringARB := SYSTEM.VAL(TglIsNamedStringARB, wglGetProcAddress('glIsNamedStringARB'));
     glGetNamedStringARB := SYSTEM.VAL(TglGetNamedStringARB, wglGetProcAddress('glGetNamedStringARB'));
     glGetNamedStringivARB := SYSTEM.VAL(TglGetNamedStringivARB, wglGetProcAddress('glGetNamedStringivARB'));
END Read_GL_ARB_shading_language_include;

PROCEDURE Read_GL_ARB_blend_func_extended;
BEGIN
     glBindFragDataLocationIndexed := SYSTEM.VAL(TglBindFragDataLocationIndexed, wglGetProcAddress('glBindFragDataLocationIndexed'));
     glGetFragDataIndex := SYSTEM.VAL(TglGetFragDataIndex, wglGetProcAddress('glGetFragDataIndex'));
END Read_GL_ARB_blend_func_extended;

PROCEDURE Read_GL_ARB_sampler_objects;
BEGIN
     glGenSamplers := SYSTEM.VAL(TglGenSamplers, wglGetProcAddress('glGenSamplers'));
     glDeleteSamplers := SYSTEM.VAL(TglDeleteSamplers, wglGetProcAddress('glDeleteSamplers'));
     glIsSampler := SYSTEM.VAL(TglIsSampler, wglGetProcAddress('glIsSampler'));
     glBindSampler := SYSTEM.VAL(TglBindSampler, wglGetProcAddress('glBindSampler'));
     glSamplerParameteri := SYSTEM.VAL(TglSamplerParameteri, wglGetProcAddress('glSamplerParameteri'));
     glSamplerParameteriv := SYSTEM.VAL(TglSamplerParameteriv, wglGetProcAddress('glSamplerParameteriv'));
     glSamplerParameterf := SYSTEM.VAL(TglSamplerParameterf, wglGetProcAddress('glSamplerParameterf'));
     glSamplerParameterfv := SYSTEM.VAL(TglSamplerParameterfv, wglGetProcAddress('glSamplerParameterfv'));
     glSamplerParameterIiv := SYSTEM.VAL(TglSamplerParameterIiv, wglGetProcAddress('glSamplerParameterIiv'));
     glSamplerParameterIuiv := SYSTEM.VAL(TglSamplerParameterIuiv, wglGetProcAddress('glSamplerParameterIuiv'));
     glGetSamplerParameteriv := SYSTEM.VAL(TglGetSamplerParameteriv, wglGetProcAddress('glGetSamplerParameteriv'));
     glGetSamplerParameterIiv := SYSTEM.VAL(TglGetSamplerParameterIiv, wglGetProcAddress('glGetSamplerParameterIiv'));
     glGetSamplerParameterfv := SYSTEM.VAL(TglGetSamplerParameterfv, wglGetProcAddress('glGetSamplerParameterfv'));
     glGetSamplerParameterIuiv := SYSTEM.VAL(TglGetSamplerParameterIuiv, wglGetProcAddress('glGetSamplerParameterIuiv'));
END Read_GL_ARB_sampler_objects;

PROCEDURE Read_GL_ARB_timer_query;
BEGIN
     glQueryCounter := SYSTEM.VAL(TglQueryCounter, wglGetProcAddress('glQueryCounter'));
     glGetQueryObjecti64v := SYSTEM.VAL(TglGetQueryObjecti64v, wglGetProcAddress('glGetQueryObjecti64v'));
     glGetQueryObjectui64v := SYSTEM.VAL(TglGetQueryObjectui64v, wglGetProcAddress('glGetQueryObjectui64v'));
END Read_GL_ARB_timer_query;

PROCEDURE Read_GL_ARB_vertex_type_2_10_10_10_rev;
BEGIN
     glVertexP2ui := SYSTEM.VAL(TglVertexP2ui, wglGetProcAddress('glVertexP2ui'));
     glVertexP2uiv := SYSTEM.VAL(TglVertexP2uiv, wglGetProcAddress('glVertexP2uiv'));
     glVertexP3ui := SYSTEM.VAL(TglVertexP3ui, wglGetProcAddress('glVertexP3ui'));
     glVertexP3uiv := SYSTEM.VAL(TglVertexP3uiv, wglGetProcAddress('glVertexP3uiv'));
     glVertexP4ui := SYSTEM.VAL(TglVertexP4ui, wglGetProcAddress('glVertexP4ui'));
     glVertexP4uiv := SYSTEM.VAL(TglVertexP4uiv, wglGetProcAddress('glVertexP4uiv'));
     glTexCoordP1ui := SYSTEM.VAL(TglTexCoordP1ui, wglGetProcAddress('glTexCoordP1ui'));
     glTexCoordP1uiv := SYSTEM.VAL(TglTexCoordP1uiv, wglGetProcAddress('glTexCoordP1uiv'));
     glTexCoordP2ui := SYSTEM.VAL(TglTexCoordP2ui, wglGetProcAddress('glTexCoordP2ui'));
     glTexCoordP2uiv := SYSTEM.VAL(TglTexCoordP2uiv, wglGetProcAddress('glTexCoordP2uiv'));
     glTexCoordP3ui := SYSTEM.VAL(TglTexCoordP3ui, wglGetProcAddress('glTexCoordP3ui'));
     glTexCoordP3uiv := SYSTEM.VAL(TglTexCoordP3uiv, wglGetProcAddress('glTexCoordP3uiv'));
     glTexCoordP4ui := SYSTEM.VAL(TglTexCoordP4ui, wglGetProcAddress('glTexCoordP4ui'));
     glTexCoordP4uiv := SYSTEM.VAL(TglTexCoordP4uiv, wglGetProcAddress('glTexCoordP4uiv'));
     glMultiTexCoordP1ui := SYSTEM.VAL(TglMultiTexCoordP1ui, wglGetProcAddress('glMultiTexCoordP1ui'));
     glMultiTexCoordP1uiv := SYSTEM.VAL(TglMultiTexCoordP1uiv, wglGetProcAddress('glMultiTexCoordP1uiv'));
     glMultiTexCoordP2ui := SYSTEM.VAL(TglMultiTexCoordP2ui, wglGetProcAddress('glMultiTexCoordP2ui'));
     glMultiTexCoordP2uiv := SYSTEM.VAL(TglMultiTexCoordP2uiv, wglGetProcAddress('glMultiTexCoordP2uiv'));
     glMultiTexCoordP3ui := SYSTEM.VAL(TglMultiTexCoordP3ui, wglGetProcAddress('glMultiTexCoordP3ui'));
     glMultiTexCoordP3uiv := SYSTEM.VAL(TglMultiTexCoordP3uiv, wglGetProcAddress('glMultiTexCoordP3uiv'));
     glMultiTexCoordP4ui := SYSTEM.VAL(TglMultiTexCoordP4ui, wglGetProcAddress('glMultiTexCoordP4ui'));
     glMultiTexCoordP4uiv := SYSTEM.VAL(TglMultiTexCoordP4uiv, wglGetProcAddress('glMultiTexCoordP4uiv'));
     glNormalP3ui := SYSTEM.VAL(TglNormalP3ui, wglGetProcAddress('glNormalP3ui'));
     glNormalP3uiv := SYSTEM.VAL(TglNormalP3uiv, wglGetProcAddress('glNormalP3uiv'));
     glColorP3ui := SYSTEM.VAL(TglColorP3ui, wglGetProcAddress('glColorP3ui'));
     glColorP3uiv := SYSTEM.VAL(TglColorP3uiv, wglGetProcAddress('glColorP3uiv'));
     glColorP4ui := SYSTEM.VAL(TglColorP4ui, wglGetProcAddress('glColorP4ui'));
     glColorP4uiv := SYSTEM.VAL(TglColorP4uiv, wglGetProcAddress('glColorP4uiv'));
     glSecondaryColorP3ui := SYSTEM.VAL(TglSecondaryColorP3ui, wglGetProcAddress('glSecondaryColorP3ui'));
     glSecondaryColorP3uiv := SYSTEM.VAL(TglSecondaryColorP3uiv, wglGetProcAddress('glSecondaryColorP3uiv'));
     glVertexAttribP1ui := SYSTEM.VAL(TglVertexAttribP1ui, wglGetProcAddress('glVertexAttribP1ui'));
     glVertexAttribP1uiv := SYSTEM.VAL(TglVertexAttribP1uiv, wglGetProcAddress('glVertexAttribP1uiv'));
     glVertexAttribP2ui := SYSTEM.VAL(TglVertexAttribP2ui, wglGetProcAddress('glVertexAttribP2ui'));
     glVertexAttribP2uiv := SYSTEM.VAL(TglVertexAttribP2uiv, wglGetProcAddress('glVertexAttribP2uiv'));
     glVertexAttribP3ui := SYSTEM.VAL(TglVertexAttribP3ui, wglGetProcAddress('glVertexAttribP3ui'));
     glVertexAttribP3uiv := SYSTEM.VAL(TglVertexAttribP3uiv, wglGetProcAddress('glVertexAttribP3uiv'));
     glVertexAttribP4ui := SYSTEM.VAL(TglVertexAttribP4ui, wglGetProcAddress('glVertexAttribP4ui'));
     glVertexAttribP4uiv := SYSTEM.VAL(TglVertexAttribP4uiv, wglGetProcAddress('glVertexAttribP4uiv'));
END Read_GL_ARB_vertex_type_2_10_10_10_rev;

PROCEDURE Read_GL_ARB_draw_indirect;
BEGIN
     glDrawArraysIndirect := SYSTEM.VAL(TglDrawArraysIndirect, wglGetProcAddress('glDrawArraysIndirect'));
     glDrawElementsIndirect := SYSTEM.VAL(TglDrawElementsIndirect, wglGetProcAddress('glDrawElementsIndirect'));
END Read_GL_ARB_draw_indirect;

PROCEDURE Read_GL_ARB_gpu_shader_fp64;
BEGIN
     glUniform1d := SYSTEM.VAL(TglUniform1d, wglGetProcAddress('glUniform1d'));
     glUniform2d := SYSTEM.VAL(TglUniform2d, wglGetProcAddress('glUniform2d'));
     glUniform3d := SYSTEM.VAL(TglUniform3d, wglGetProcAddress('glUniform3d'));
     glUniform4d := SYSTEM.VAL(TglUniform4d, wglGetProcAddress('glUniform4d'));
     glUniform1dv := SYSTEM.VAL(TglUniform1dv, wglGetProcAddress('glUniform1dv'));
     glUniform2dv := SYSTEM.VAL(TglUniform2dv, wglGetProcAddress('glUniform2dv'));
     glUniform3dv := SYSTEM.VAL(TglUniform3dv, wglGetProcAddress('glUniform3dv'));
     glUniform4dv := SYSTEM.VAL(TglUniform4dv, wglGetProcAddress('glUniform4dv'));
     glUniformMatrix2dv := SYSTEM.VAL(TglUniformMatrix2dv, wglGetProcAddress('glUniformMatrix2dv'));
     glUniformMatrix3dv := SYSTEM.VAL(TglUniformMatrix3dv, wglGetProcAddress('glUniformMatrix3dv'));
     glUniformMatrix4dv := SYSTEM.VAL(TglUniformMatrix4dv, wglGetProcAddress('glUniformMatrix4dv'));
     glUniformMatrix2x3dv := SYSTEM.VAL(TglUniformMatrix2x3dv, wglGetProcAddress('glUniformMatrix2x3dv'));
     glUniformMatrix2x4dv := SYSTEM.VAL(TglUniformMatrix2x4dv, wglGetProcAddress('glUniformMatrix2x4dv'));
     glUniformMatrix3x2dv := SYSTEM.VAL(TglUniformMatrix3x2dv, wglGetProcAddress('glUniformMatrix3x2dv'));
     glUniformMatrix3x4dv := SYSTEM.VAL(TglUniformMatrix3x4dv, wglGetProcAddress('glUniformMatrix3x4dv'));
     glUniformMatrix4x2dv := SYSTEM.VAL(TglUniformMatrix4x2dv, wglGetProcAddress('glUniformMatrix4x2dv'));
     glUniformMatrix4x3dv := SYSTEM.VAL(TglUniformMatrix4x3dv, wglGetProcAddress('glUniformMatrix4x3dv'));
     glGetUniformdv := SYSTEM.VAL(TglGetUniformdv, wglGetProcAddress('glGetUniformdv'));
END Read_GL_ARB_gpu_shader_fp64;

PROCEDURE Read_GL_ARB_shader_subroutine;
BEGIN
     glGetSubroutineUniformLocation := SYSTEM.VAL(TglGetSubroutineUniformLocation, wglGetProcAddress('glGetSubroutineUniformLocation'));
     glGetSubroutineIndex := SYSTEM.VAL(TglGetSubroutineIndex, wglGetProcAddress('glGetSubroutineIndex'));
     glGetActiveSubroutineUniformiv := SYSTEM.VAL(TglGetActiveSubroutineUniformiv, wglGetProcAddress('glGetActiveSubroutineUniformiv'));
     glGetActiveSubroutineUniformName := SYSTEM.VAL(TglGetActiveSubroutineUniformName, wglGetProcAddress('glGetActiveSubroutineUniformName'));
     glGetActiveSubroutineName := SYSTEM.VAL(TglGetActiveSubroutineName, wglGetProcAddress('glGetActiveSubroutineName'));
     glUniformSubroutinesuiv := SYSTEM.VAL(TglUniformSubroutinesuiv, wglGetProcAddress('glUniformSubroutinesuiv'));
     glGetUniformSubroutineuiv := SYSTEM.VAL(TglGetUniformSubroutineuiv, wglGetProcAddress('glGetUniformSubroutineuiv'));
     glGetProgramStageiv := SYSTEM.VAL(TglGetProgramStageiv, wglGetProcAddress('glGetProgramStageiv'));
END Read_GL_ARB_shader_subroutine;

PROCEDURE Read_GL_ARB_tessellation_shader;
BEGIN
     glPatchParameteri := SYSTEM.VAL(TglPatchParameteri, wglGetProcAddress('glPatchParameteri'));
     glPatchParameterfv := SYSTEM.VAL(TglPatchParameterfv, wglGetProcAddress('glPatchParameterfv'));
END Read_GL_ARB_tessellation_shader;

PROCEDURE Read_GL_ARB_transform_feedback2;
BEGIN
     glBindTransformFeedback := SYSTEM.VAL(TglBindTransformFeedback, wglGetProcAddress('glBindTransformFeedback'));
     glDeleteTransformFeedbacks := SYSTEM.VAL(TglDeleteTransformFeedbacks, wglGetProcAddress('glDeleteTransformFeedbacks'));
     glGenTransformFeedbacks := SYSTEM.VAL(TglGenTransformFeedbacks, wglGetProcAddress('glGenTransformFeedbacks'));
     glIsTransformFeedback := SYSTEM.VAL(TglIsTransformFeedback, wglGetProcAddress('glIsTransformFeedback'));
     glPauseTransformFeedback := SYSTEM.VAL(TglPauseTransformFeedback, wglGetProcAddress('glPauseTransformFeedback'));
     glResumeTransformFeedback := SYSTEM.VAL(TglResumeTransformFeedback, wglGetProcAddress('glResumeTransformFeedback'));
     glDrawTransformFeedback := SYSTEM.VAL(TglDrawTransformFeedback, wglGetProcAddress('glDrawTransformFeedback'));
END Read_GL_ARB_transform_feedback2;

PROCEDURE Read_GL_ARB_transform_feedback3;
BEGIN
     glDrawTransformFeedbackStream := SYSTEM.VAL(TglDrawTransformFeedbackStream, wglGetProcAddress('glDrawTransformFeedbackStream'));
     glBeginQueryIndexed := SYSTEM.VAL(TglBeginQueryIndexed, wglGetProcAddress('glBeginQueryIndexed'));
     glEndQueryIndexed := SYSTEM.VAL(TglEndQueryIndexed, wglGetProcAddress('glEndQueryIndexed'));
     glGetQueryIndexediv := SYSTEM.VAL(TglGetQueryIndexediv, wglGetProcAddress('glGetQueryIndexediv'));
END Read_GL_ARB_transform_feedback3;

PROCEDURE Read_GL_ARB_ES2_compatibility;
BEGIN
     glReleaseShaderCompiler := SYSTEM.VAL(TglReleaseShaderCompiler, wglGetProcAddress('glReleaseShaderCompiler'));
     glShaderBinary := SYSTEM.VAL(TglShaderBinary, wglGetProcAddress('glShaderBinary'));
     glGetShaderPrecisionFormat := SYSTEM.VAL(TglGetShaderPrecisionFormat, wglGetProcAddress('glGetShaderPrecisionFormat'));
     glDepthRangef := SYSTEM.VAL(TglDepthRangef, wglGetProcAddress('glDepthRangef'));
     glClearDepthf := SYSTEM.VAL(TglClearDepthf, wglGetProcAddress('glClearDepthf'));
END Read_GL_ARB_ES2_compatibility;

PROCEDURE Read_GL_ARB_get_program_binary;
BEGIN
     glGetProgramBinary := SYSTEM.VAL(TglGetProgramBinary, wglGetProcAddress('glGetProgramBinary'));
     glProgramBinary := SYSTEM.VAL(TglProgramBinary, wglGetProcAddress('glProgramBinary'));
     glProgramParameteri := SYSTEM.VAL(TglProgramParameteri, wglGetProcAddress('glProgramParameteri'));
END Read_GL_ARB_get_program_binary;

PROCEDURE Read_GL_ARB_separate_shader_objects;
BEGIN
     glUseProgramStages := SYSTEM.VAL(TglUseProgramStages, wglGetProcAddress('glUseProgramStages'));
     glActiveShaderProgram := SYSTEM.VAL(TglActiveShaderProgram, wglGetProcAddress('glActiveShaderProgram'));
     glCreateShaderProgramv := SYSTEM.VAL(TglCreateShaderProgramv, wglGetProcAddress('glCreateShaderProgramv'));
     glBindProgramPipeline := SYSTEM.VAL(TglBindProgramPipeline, wglGetProcAddress('glBindProgramPipeline'));
     glDeleteProgramPipelines := SYSTEM.VAL(TglDeleteProgramPipelines, wglGetProcAddress('glDeleteProgramPipelines'));
     glGenProgramPipelines := SYSTEM.VAL(TglGenProgramPipelines, wglGetProcAddress('glGenProgramPipelines'));
     glIsProgramPipeline := SYSTEM.VAL(TglIsProgramPipeline, wglGetProcAddress('glIsProgramPipeline'));
     glGetProgramPipelineiv := SYSTEM.VAL(TglGetProgramPipelineiv, wglGetProcAddress('glGetProgramPipelineiv'));
     glProgramUniform1i := SYSTEM.VAL(TglProgramUniform1i, wglGetProcAddress('glProgramUniform1i'));
     glProgramUniform1iv := SYSTEM.VAL(TglProgramUniform1iv, wglGetProcAddress('glProgramUniform1iv'));
     glProgramUniform1f := SYSTEM.VAL(TglProgramUniform1f, wglGetProcAddress('glProgramUniform1f'));
     glProgramUniform1fv := SYSTEM.VAL(TglProgramUniform1fv, wglGetProcAddress('glProgramUniform1fv'));
     glProgramUniform1d := SYSTEM.VAL(TglProgramUniform1d, wglGetProcAddress('glProgramUniform1d'));
     glProgramUniform1dv := SYSTEM.VAL(TglProgramUniform1dv, wglGetProcAddress('glProgramUniform1dv'));
     glProgramUniform1ui := SYSTEM.VAL(TglProgramUniform1ui, wglGetProcAddress('glProgramUniform1ui'));
     glProgramUniform1uiv := SYSTEM.VAL(TglProgramUniform1uiv, wglGetProcAddress('glProgramUniform1uiv'));
     glProgramUniform2i := SYSTEM.VAL(TglProgramUniform2i, wglGetProcAddress('glProgramUniform2i'));
     glProgramUniform2iv := SYSTEM.VAL(TglProgramUniform2iv, wglGetProcAddress('glProgramUniform2iv'));
     glProgramUniform2f := SYSTEM.VAL(TglProgramUniform2f, wglGetProcAddress('glProgramUniform2f'));
     glProgramUniform2fv := SYSTEM.VAL(TglProgramUniform2fv, wglGetProcAddress('glProgramUniform2fv'));
     glProgramUniform2d := SYSTEM.VAL(TglProgramUniform2d, wglGetProcAddress('glProgramUniform2d'));
     glProgramUniform2dv := SYSTEM.VAL(TglProgramUniform2dv, wglGetProcAddress('glProgramUniform2dv'));
     glProgramUniform2ui := SYSTEM.VAL(TglProgramUniform2ui, wglGetProcAddress('glProgramUniform2ui'));
     glProgramUniform2uiv := SYSTEM.VAL(TglProgramUniform2uiv, wglGetProcAddress('glProgramUniform2uiv'));
     glProgramUniform3i := SYSTEM.VAL(TglProgramUniform3i, wglGetProcAddress('glProgramUniform3i'));
     glProgramUniform3iv := SYSTEM.VAL(TglProgramUniform3iv, wglGetProcAddress('glProgramUniform3iv'));
     glProgramUniform3f := SYSTEM.VAL(TglProgramUniform3f, wglGetProcAddress('glProgramUniform3f'));
     glProgramUniform3fv := SYSTEM.VAL(TglProgramUniform3fv, wglGetProcAddress('glProgramUniform3fv'));
     glProgramUniform3d := SYSTEM.VAL(TglProgramUniform3d, wglGetProcAddress('glProgramUniform3d'));
     glProgramUniform3dv := SYSTEM.VAL(TglProgramUniform3dv, wglGetProcAddress('glProgramUniform3dv'));
     glProgramUniform3ui := SYSTEM.VAL(TglProgramUniform3ui, wglGetProcAddress('glProgramUniform3ui'));
     glProgramUniform3uiv := SYSTEM.VAL(TglProgramUniform3uiv, wglGetProcAddress('glProgramUniform3uiv'));
     glProgramUniform4i := SYSTEM.VAL(TglProgramUniform4i, wglGetProcAddress('glProgramUniform4i'));
     glProgramUniform4iv := SYSTEM.VAL(TglProgramUniform4iv, wglGetProcAddress('glProgramUniform4iv'));
     glProgramUniform4f := SYSTEM.VAL(TglProgramUniform4f, wglGetProcAddress('glProgramUniform4f'));
     glProgramUniform4fv := SYSTEM.VAL(TglProgramUniform4fv, wglGetProcAddress('glProgramUniform4fv'));
     glProgramUniform4d := SYSTEM.VAL(TglProgramUniform4d, wglGetProcAddress('glProgramUniform4d'));
     glProgramUniform4dv := SYSTEM.VAL(TglProgramUniform4dv, wglGetProcAddress('glProgramUniform4dv'));
     glProgramUniform4ui := SYSTEM.VAL(TglProgramUniform4ui, wglGetProcAddress('glProgramUniform4ui'));
     glProgramUniform4uiv := SYSTEM.VAL(TglProgramUniform4uiv, wglGetProcAddress('glProgramUniform4uiv'));
     glProgramUniformMatrix2fv := SYSTEM.VAL(TglProgramUniformMatrix2fv, wglGetProcAddress('glProgramUniformMatrix2fv'));
     glProgramUniformMatrix3fv := SYSTEM.VAL(TglProgramUniformMatrix3fv, wglGetProcAddress('glProgramUniformMatrix3fv'));
     glProgramUniformMatrix4fv := SYSTEM.VAL(TglProgramUniformMatrix4fv, wglGetProcAddress('glProgramUniformMatrix4fv'));
     glProgramUniformMatrix2dv := SYSTEM.VAL(TglProgramUniformMatrix2dv, wglGetProcAddress('glProgramUniformMatrix2dv'));
     glProgramUniformMatrix3dv := SYSTEM.VAL(TglProgramUniformMatrix3dv, wglGetProcAddress('glProgramUniformMatrix3dv'));
     glProgramUniformMatrix4dv := SYSTEM.VAL(TglProgramUniformMatrix4dv, wglGetProcAddress('glProgramUniformMatrix4dv'));
     glProgramUniformMatrix2x3fv := SYSTEM.VAL(TglProgramUniformMatrix2x3fv, wglGetProcAddress('glProgramUniformMatrix2x3fv'));
     glProgramUniformMatrix3x2fv := SYSTEM.VAL(TglProgramUniformMatrix3x2fv, wglGetProcAddress('glProgramUniformMatrix3x2fv'));
     glProgramUniformMatrix2x4fv := SYSTEM.VAL(TglProgramUniformMatrix2x4fv, wglGetProcAddress('glProgramUniformMatrix2x4fv'));
     glProgramUniformMatrix4x2fv := SYSTEM.VAL(TglProgramUniformMatrix4x2fv, wglGetProcAddress('glProgramUniformMatrix4x2fv'));
     glProgramUniformMatrix3x4fv := SYSTEM.VAL(TglProgramUniformMatrix3x4fv, wglGetProcAddress('glProgramUniformMatrix3x4fv'));
     glProgramUniformMatrix4x3fv := SYSTEM.VAL(TglProgramUniformMatrix4x3fv, wglGetProcAddress('glProgramUniformMatrix4x3fv'));
     glProgramUniformMatrix2x3dv := SYSTEM.VAL(TglProgramUniformMatrix2x3dv, wglGetProcAddress('glProgramUniformMatrix2x3dv'));
     glProgramUniformMatrix3x2dv := SYSTEM.VAL(TglProgramUniformMatrix3x2dv, wglGetProcAddress('glProgramUniformMatrix3x2dv'));
     glProgramUniformMatrix2x4dv := SYSTEM.VAL(TglProgramUniformMatrix2x4dv, wglGetProcAddress('glProgramUniformMatrix2x4dv'));
     glProgramUniformMatrix4x2dv := SYSTEM.VAL(TglProgramUniformMatrix4x2dv, wglGetProcAddress('glProgramUniformMatrix4x2dv'));
     glProgramUniformMatrix3x4dv := SYSTEM.VAL(TglProgramUniformMatrix3x4dv, wglGetProcAddress('glProgramUniformMatrix3x4dv'));
     glProgramUniformMatrix4x3dv := SYSTEM.VAL(TglProgramUniformMatrix4x3dv, wglGetProcAddress('glProgramUniformMatrix4x3dv'));
     glValidateProgramPipeline := SYSTEM.VAL(TglValidateProgramPipeline, wglGetProcAddress('glValidateProgramPipeline'));
     glGetProgramPipelineInfoLog := SYSTEM.VAL(TglGetProgramPipelineInfoLog, wglGetProcAddress('glGetProgramPipelineInfoLog'));
END Read_GL_ARB_separate_shader_objects;

PROCEDURE Read_GL_ARB_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1d := SYSTEM.VAL(TglVertexAttribL1d, wglGetProcAddress('glVertexAttribL1d'));
     glVertexAttribL2d := SYSTEM.VAL(TglVertexAttribL2d, wglGetProcAddress('glVertexAttribL2d'));
     glVertexAttribL3d := SYSTEM.VAL(TglVertexAttribL3d, wglGetProcAddress('glVertexAttribL3d'));
     glVertexAttribL4d := SYSTEM.VAL(TglVertexAttribL4d, wglGetProcAddress('glVertexAttribL4d'));
     glVertexAttribL1dv := SYSTEM.VAL(TglVertexAttribL1dv, wglGetProcAddress('glVertexAttribL1dv'));
     glVertexAttribL2dv := SYSTEM.VAL(TglVertexAttribL2dv, wglGetProcAddress('glVertexAttribL2dv'));
     glVertexAttribL3dv := SYSTEM.VAL(TglVertexAttribL3dv, wglGetProcAddress('glVertexAttribL3dv'));
     glVertexAttribL4dv := SYSTEM.VAL(TglVertexAttribL4dv, wglGetProcAddress('glVertexAttribL4dv'));
     glVertexAttribLPointer := SYSTEM.VAL(TglVertexAttribLPointer, wglGetProcAddress('glVertexAttribLPointer'));
     glGetVertexAttribLdv := SYSTEM.VAL(TglGetVertexAttribLdv, wglGetProcAddress('glGetVertexAttribLdv'));
END Read_GL_ARB_vertex_attrib_64bit;

PROCEDURE Read_GL_ARB_viewport_array;
BEGIN
     glViewportArrayv := SYSTEM.VAL(TglViewportArrayv, wglGetProcAddress('glViewportArrayv'));
     glViewportIndexedf := SYSTEM.VAL(TglViewportIndexedf, wglGetProcAddress('glViewportIndexedf'));
     glViewportIndexedfv := SYSTEM.VAL(TglViewportIndexedfv, wglGetProcAddress('glViewportIndexedfv'));
     glScissorArrayv := SYSTEM.VAL(TglScissorArrayv, wglGetProcAddress('glScissorArrayv'));
     glScissorIndexed := SYSTEM.VAL(TglScissorIndexed, wglGetProcAddress('glScissorIndexed'));
     glScissorIndexedv := SYSTEM.VAL(TglScissorIndexedv, wglGetProcAddress('glScissorIndexedv'));
     glDepthRangeArrayv := SYSTEM.VAL(TglDepthRangeArrayv, wglGetProcAddress('glDepthRangeArrayv'));
     glDepthRangeIndexed := SYSTEM.VAL(TglDepthRangeIndexed, wglGetProcAddress('glDepthRangeIndexed'));
     glGetFloati_v := SYSTEM.VAL(TglGetFloati_v, wglGetProcAddress('glGetFloati_v'));
     glGetDoublei_v := SYSTEM.VAL(TglGetDoublei_v, wglGetProcAddress('glGetDoublei_v'));
END Read_GL_ARB_viewport_array;

PROCEDURE Read_GL_ARB_cl_event;
BEGIN
     glCreateSyncFromCLeventARB := SYSTEM.VAL(TglCreateSyncFromCLeventARB, wglGetProcAddress('glCreateSyncFromCLeventARB'));
END Read_GL_ARB_cl_event;

PROCEDURE Read_GL_ARB_debug_output;
BEGIN
     glDebugMessageControlARB := SYSTEM.VAL(TglDebugMessageControlARB, wglGetProcAddress('glDebugMessageControlARB'));
     glDebugMessageInsertARB := SYSTEM.VAL(TglDebugMessageInsertARB, wglGetProcAddress('glDebugMessageInsertARB'));
(*     glDebugMessageCallbackARB := SYSTEM.VAL(TglDebugMessageCallbackARB, wglGetProcAddress('glDebugMessageCallbackARB')); *)
     glGetDebugMessageLogARB := SYSTEM.VAL(TglGetDebugMessageLogARB, wglGetProcAddress('glGetDebugMessageLogARB'));
END Read_GL_ARB_debug_output;

PROCEDURE Read_GL_ARB_robustness;
BEGIN
     glGetGraphicsResetStatusARB := SYSTEM.VAL(TglGetGraphicsResetStatusARB, wglGetProcAddress('glGetGraphicsResetStatusARB'));
     glGetnMapdvARB := SYSTEM.VAL(TglGetnMapdvARB, wglGetProcAddress('glGetnMapdvARB'));
     glGetnMapfvARB := SYSTEM.VAL(TglGetnMapfvARB, wglGetProcAddress('glGetnMapfvARB'));
     glGetnMapivARB := SYSTEM.VAL(TglGetnMapivARB, wglGetProcAddress('glGetnMapivARB'));
     glGetnPixelMapfvARB := SYSTEM.VAL(TglGetnPixelMapfvARB, wglGetProcAddress('glGetnPixelMapfvARB'));
     glGetnPixelMapuivARB := SYSTEM.VAL(TglGetnPixelMapuivARB, wglGetProcAddress('glGetnPixelMapuivARB'));
     glGetnPixelMapusvARB := SYSTEM.VAL(TglGetnPixelMapusvARB, wglGetProcAddress('glGetnPixelMapusvARB'));
     glGetnPolygonStippleARB := SYSTEM.VAL(TglGetnPolygonStippleARB, wglGetProcAddress('glGetnPolygonStippleARB'));
     glGetnColorTableARB := SYSTEM.VAL(TglGetnColorTableARB, wglGetProcAddress('glGetnColorTableARB'));
     glGetnConvolutionFilterARB := SYSTEM.VAL(TglGetnConvolutionFilterARB, wglGetProcAddress('glGetnConvolutionFilterARB'));
     glGetnSeparableFilterARB := SYSTEM.VAL(TglGetnSeparableFilterARB, wglGetProcAddress('glGetnSeparableFilterARB'));
     glGetnHistogramARB := SYSTEM.VAL(TglGetnHistogramARB, wglGetProcAddress('glGetnHistogramARB'));
     glGetnMinmaxARB := SYSTEM.VAL(TglGetnMinmaxARB, wglGetProcAddress('glGetnMinmaxARB'));
     glGetnTexImageARB := SYSTEM.VAL(TglGetnTexImageARB, wglGetProcAddress('glGetnTexImageARB'));
     glReadnPixelsARB := SYSTEM.VAL(TglReadnPixelsARB, wglGetProcAddress('glReadnPixelsARB'));
     glGetnCompressedTexImageARB := SYSTEM.VAL(TglGetnCompressedTexImageARB, wglGetProcAddress('glGetnCompressedTexImageARB'));
     glGetnUniformfvARB := SYSTEM.VAL(TglGetnUniformfvARB, wglGetProcAddress('glGetnUniformfvARB'));
     glGetnUniformivARB := SYSTEM.VAL(TglGetnUniformivARB, wglGetProcAddress('glGetnUniformivARB'));
     glGetnUniformuivARB := SYSTEM.VAL(TglGetnUniformuivARB, wglGetProcAddress('glGetnUniformuivARB'));
     glGetnUniformdvARB := SYSTEM.VAL(TglGetnUniformdvARB, wglGetProcAddress('glGetnUniformdvARB'));
END Read_GL_ARB_robustness;

PROCEDURE Read_GL_ATI_draw_buffers;
BEGIN
     glDrawBuffersATI := SYSTEM.VAL(TglDrawBuffersATI, wglGetProcAddress('glDrawBuffersATI'));
END Read_GL_ATI_draw_buffers;

PROCEDURE Read_GL_ATI_element_array;
BEGIN
     glElementPointerATI := SYSTEM.VAL(TglElementPointerATI, wglGetProcAddress('glElementPointerATI'));
     glDrawElementArrayATI := SYSTEM.VAL(TglDrawElementArrayATI, wglGetProcAddress('glDrawElementArrayATI'));
     glDrawRangeElementArrayATI := SYSTEM.VAL(TglDrawRangeElementArrayATI, wglGetProcAddress('glDrawRangeElementArrayATI'));
END Read_GL_ATI_element_array;

PROCEDURE Read_GL_ATI_envmap_bumpmap;
BEGIN
     glTexBumpParameterivATI := SYSTEM.VAL(TglTexBumpParameterivATI, wglGetProcAddress('glTexBumpParameterivATI'));
     glTexBumpParameterfvATI := SYSTEM.VAL(TglTexBumpParameterfvATI, wglGetProcAddress('glTexBumpParameterfvATI'));
     glGetTexBumpParameterivATI := SYSTEM.VAL(TglGetTexBumpParameterivATI, wglGetProcAddress('glGetTexBumpParameterivATI'));
     glGetTexBumpParameterfvATI := SYSTEM.VAL(TglGetTexBumpParameterfvATI, wglGetProcAddress('glGetTexBumpParameterfvATI'));
END Read_GL_ATI_envmap_bumpmap;

PROCEDURE Read_GL_ATI_fragment_shader;
BEGIN
     glGenFragmentShadersATI := SYSTEM.VAL(TglGenFragmentShadersATI, wglGetProcAddress('glGenFragmentShadersATI'));
     glBindFragmentShaderATI := SYSTEM.VAL(TglBindFragmentShaderATI, wglGetProcAddress('glBindFragmentShaderATI'));
     glDeleteFragmentShaderATI := SYSTEM.VAL(TglDeleteFragmentShaderATI, wglGetProcAddress('glDeleteFragmentShaderATI'));
     glBeginFragmentShaderATI := SYSTEM.VAL(TglBeginFragmentShaderATI, wglGetProcAddress('glBeginFragmentShaderATI'));
     glEndFragmentShaderATI := SYSTEM.VAL(TglEndFragmentShaderATI, wglGetProcAddress('glEndFragmentShaderATI'));
     glPassTexCoordATI := SYSTEM.VAL(TglPassTexCoordATI, wglGetProcAddress('glPassTexCoordATI'));
     glSampleMapATI := SYSTEM.VAL(TglSampleMapATI, wglGetProcAddress('glSampleMapATI'));
     glColorFragmentOp1ATI := SYSTEM.VAL(TglColorFragmentOp1ATI, wglGetProcAddress('glColorFragmentOp1ATI'));
     glColorFragmentOp2ATI := SYSTEM.VAL(TglColorFragmentOp2ATI, wglGetProcAddress('glColorFragmentOp2ATI'));
     glColorFragmentOp3ATI := SYSTEM.VAL(TglColorFragmentOp3ATI, wglGetProcAddress('glColorFragmentOp3ATI'));
     glAlphaFragmentOp1ATI := SYSTEM.VAL(TglAlphaFragmentOp1ATI, wglGetProcAddress('glAlphaFragmentOp1ATI'));
     glAlphaFragmentOp2ATI := SYSTEM.VAL(TglAlphaFragmentOp2ATI, wglGetProcAddress('glAlphaFragmentOp2ATI'));
     glAlphaFragmentOp3ATI := SYSTEM.VAL(TglAlphaFragmentOp3ATI, wglGetProcAddress('glAlphaFragmentOp3ATI'));
     glSetFragmentShaderConstantATI := SYSTEM.VAL(TglSetFragmentShaderConstantATI, wglGetProcAddress('glSetFragmentShaderConstantATI'));
END Read_GL_ATI_fragment_shader;

PROCEDURE Read_GL_ATI_map_object_buffer;
BEGIN
     glMapObjectBufferATI := SYSTEM.VAL(TglMapObjectBufferATI, wglGetProcAddress('glMapObjectBufferATI'));
     glUnmapObjectBufferATI := SYSTEM.VAL(TglUnmapObjectBufferATI, wglGetProcAddress('glUnmapObjectBufferATI'));
END Read_GL_ATI_map_object_buffer;

PROCEDURE Read_GL_ATI_pn_triangles;
BEGIN
     glPNTrianglesiATI := SYSTEM.VAL(TglPNTrianglesiATI, wglGetProcAddress('glPNTrianglesiATI'));
     glPNTrianglesfATI := SYSTEM.VAL(TglPNTrianglesfATI, wglGetProcAddress('glPNTrianglesfATI'));
END Read_GL_ATI_pn_triangles;

PROCEDURE Read_GL_ATI_separate_stencil;
BEGIN
     glStencilOpSeparateATI := SYSTEM.VAL(TglStencilOpSeparateATI, wglGetProcAddress('glStencilOpSeparateATI'));
     glStencilFuncSeparateATI := SYSTEM.VAL(TglStencilFuncSeparateATI, wglGetProcAddress('glStencilFuncSeparateATI'));
END Read_GL_ATI_separate_stencil;

PROCEDURE Read_GL_ATI_vertex_array_object;
BEGIN
     glNewObjectBufferATI := SYSTEM.VAL(TglNewObjectBufferATI, wglGetProcAddress('glNewObjectBufferATI'));
     glIsObjectBufferATI := SYSTEM.VAL(TglIsObjectBufferATI, wglGetProcAddress('glIsObjectBufferATI'));
     glUpdateObjectBufferATI := SYSTEM.VAL(TglUpdateObjectBufferATI, wglGetProcAddress('glUpdateObjectBufferATI'));
     glGetObjectBufferfvATI := SYSTEM.VAL(TglGetObjectBufferfvATI, wglGetProcAddress('glGetObjectBufferfvATI'));
     glGetObjectBufferivATI := SYSTEM.VAL(TglGetObjectBufferivATI, wglGetProcAddress('glGetObjectBufferivATI'));
     glFreeObjectBufferATI := SYSTEM.VAL(TglFreeObjectBufferATI, wglGetProcAddress('glFreeObjectBufferATI'));
     glArrayObjectATI := SYSTEM.VAL(TglArrayObjectATI, wglGetProcAddress('glArrayObjectATI'));
     glGetArrayObjectfvATI := SYSTEM.VAL(TglGetArrayObjectfvATI, wglGetProcAddress('glGetArrayObjectfvATI'));
     glGetArrayObjectivATI := SYSTEM.VAL(TglGetArrayObjectivATI, wglGetProcAddress('glGetArrayObjectivATI'));
     glVariantArrayObjectATI := SYSTEM.VAL(TglVariantArrayObjectATI, wglGetProcAddress('glVariantArrayObjectATI'));
     glGetVariantArrayObjectfvATI := SYSTEM.VAL(TglGetVariantArrayObjectfvATI, wglGetProcAddress('glGetVariantArrayObjectfvATI'));
     glGetVariantArrayObjectivATI := SYSTEM.VAL(TglGetVariantArrayObjectivATI, wglGetProcAddress('glGetVariantArrayObjectivATI'));
END Read_GL_ATI_vertex_array_object;

PROCEDURE Read_GL_ATI_vertex_attrib_array_object;
BEGIN
     glVertexAttribArrayObjectATI := SYSTEM.VAL(TglVertexAttribArrayObjectATI, wglGetProcAddress('glVertexAttribArrayObjectATI'));
     glGetVertexAttribArrayObjectfvATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectfvATI, wglGetProcAddress('glGetVertexAttribArrayObjectfvATI'));
     glGetVertexAttribArrayObjectivATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectivATI, wglGetProcAddress('glGetVertexAttribArrayObjectivATI'));
END Read_GL_ATI_vertex_attrib_array_object;

PROCEDURE Read_GL_ATI_vertex_streams;
BEGIN
     glVertexStream1sATI := SYSTEM.VAL(TglVertexStream1sATI, wglGetProcAddress('glVertexStream1sATI'));
     glVertexStream1svATI := SYSTEM.VAL(TglVertexStream1svATI, wglGetProcAddress('glVertexStream1svATI'));
     glVertexStream1iATI := SYSTEM.VAL(TglVertexStream1iATI, wglGetProcAddress('glVertexStream1iATI'));
     glVertexStream1ivATI := SYSTEM.VAL(TglVertexStream1ivATI, wglGetProcAddress('glVertexStream1ivATI'));
     glVertexStream1fATI := SYSTEM.VAL(TglVertexStream1fATI, wglGetProcAddress('glVertexStream1fATI'));
     glVertexStream1fvATI := SYSTEM.VAL(TglVertexStream1fvATI, wglGetProcAddress('glVertexStream1fvATI'));
     glVertexStream1dATI := SYSTEM.VAL(TglVertexStream1dATI, wglGetProcAddress('glVertexStream1dATI'));
     glVertexStream1dvATI := SYSTEM.VAL(TglVertexStream1dvATI, wglGetProcAddress('glVertexStream1dvATI'));
     glVertexStream2sATI := SYSTEM.VAL(TglVertexStream2sATI, wglGetProcAddress('glVertexStream2sATI'));
     glVertexStream2svATI := SYSTEM.VAL(TglVertexStream2svATI, wglGetProcAddress('glVertexStream2svATI'));
     glVertexStream2iATI := SYSTEM.VAL(TglVertexStream2iATI, wglGetProcAddress('glVertexStream2iATI'));
     glVertexStream2ivATI := SYSTEM.VAL(TglVertexStream2ivATI, wglGetProcAddress('glVertexStream2ivATI'));
     glVertexStream2fATI := SYSTEM.VAL(TglVertexStream2fATI, wglGetProcAddress('glVertexStream2fATI'));
     glVertexStream2fvATI := SYSTEM.VAL(TglVertexStream2fvATI, wglGetProcAddress('glVertexStream2fvATI'));
     glVertexStream2dATI := SYSTEM.VAL(TglVertexStream2dATI, wglGetProcAddress('glVertexStream2dATI'));
     glVertexStream2dvATI := SYSTEM.VAL(TglVertexStream2dvATI, wglGetProcAddress('glVertexStream2dvATI'));
     glVertexStream3sATI := SYSTEM.VAL(TglVertexStream3sATI, wglGetProcAddress('glVertexStream3sATI'));
     glVertexStream3svATI := SYSTEM.VAL(TglVertexStream3svATI, wglGetProcAddress('glVertexStream3svATI'));
     glVertexStream3iATI := SYSTEM.VAL(TglVertexStream3iATI, wglGetProcAddress('glVertexStream3iATI'));
     glVertexStream3ivATI := SYSTEM.VAL(TglVertexStream3ivATI, wglGetProcAddress('glVertexStream3ivATI'));
     glVertexStream3fATI := SYSTEM.VAL(TglVertexStream3fATI, wglGetProcAddress('glVertexStream3fATI'));
     glVertexStream3fvATI := SYSTEM.VAL(TglVertexStream3fvATI, wglGetProcAddress('glVertexStream3fvATI'));
     glVertexStream3dATI := SYSTEM.VAL(TglVertexStream3dATI, wglGetProcAddress('glVertexStream3dATI'));
     glVertexStream3dvATI := SYSTEM.VAL(TglVertexStream3dvATI, wglGetProcAddress('glVertexStream3dvATI'));
     glVertexStream4sATI := SYSTEM.VAL(TglVertexStream4sATI, wglGetProcAddress('glVertexStream4sATI'));
     glVertexStream4svATI := SYSTEM.VAL(TglVertexStream4svATI, wglGetProcAddress('glVertexStream4svATI'));
     glVertexStream4iATI := SYSTEM.VAL(TglVertexStream4iATI, wglGetProcAddress('glVertexStream4iATI'));
     glVertexStream4ivATI := SYSTEM.VAL(TglVertexStream4ivATI, wglGetProcAddress('glVertexStream4ivATI'));
     glVertexStream4fATI := SYSTEM.VAL(TglVertexStream4fATI, wglGetProcAddress('glVertexStream4fATI'));
     glVertexStream4fvATI := SYSTEM.VAL(TglVertexStream4fvATI, wglGetProcAddress('glVertexStream4fvATI'));
     glVertexStream4dATI := SYSTEM.VAL(TglVertexStream4dATI, wglGetProcAddress('glVertexStream4dATI'));
     glVertexStream4dvATI := SYSTEM.VAL(TglVertexStream4dvATI, wglGetProcAddress('glVertexStream4dvATI'));
     glNormalStream3bATI := SYSTEM.VAL(TglNormalStream3bATI, wglGetProcAddress('glNormalStream3bATI'));
     glNormalStream3bvATI := SYSTEM.VAL(TglNormalStream3bvATI, wglGetProcAddress('glNormalStream3bvATI'));
     glNormalStream3sATI := SYSTEM.VAL(TglNormalStream3sATI, wglGetProcAddress('glNormalStream3sATI'));
     glNormalStream3svATI := SYSTEM.VAL(TglNormalStream3svATI, wglGetProcAddress('glNormalStream3svATI'));
     glNormalStream3iATI := SYSTEM.VAL(TglNormalStream3iATI, wglGetProcAddress('glNormalStream3iATI'));
     glNormalStream3ivATI := SYSTEM.VAL(TglNormalStream3ivATI, wglGetProcAddress('glNormalStream3ivATI'));
     glNormalStream3fATI := SYSTEM.VAL(TglNormalStream3fATI, wglGetProcAddress('glNormalStream3fATI'));
     glNormalStream3fvATI := SYSTEM.VAL(TglNormalStream3fvATI, wglGetProcAddress('glNormalStream3fvATI'));
     glNormalStream3dATI := SYSTEM.VAL(TglNormalStream3dATI, wglGetProcAddress('glNormalStream3dATI'));
     glNormalStream3dvATI := SYSTEM.VAL(TglNormalStream3dvATI, wglGetProcAddress('glNormalStream3dvATI'));
     glClientActiveVertexStreamATI := SYSTEM.VAL(TglClientActiveVertexStreamATI, wglGetProcAddress('glClientActiveVertexStreamATI'));
     glVertexBlendEnviATI := SYSTEM.VAL(TglVertexBlendEnviATI, wglGetProcAddress('glVertexBlendEnviATI'));
     glVertexBlendEnvfATI := SYSTEM.VAL(TglVertexBlendEnvfATI, wglGetProcAddress('glVertexBlendEnvfATI'));
END Read_GL_ATI_vertex_streams;

PROCEDURE Read_GL_AMD_performance_monitor;
BEGIN
     glGetPerfMonitorGroupsAMD := SYSTEM.VAL(TglGetPerfMonitorGroupsAMD, wglGetProcAddress('glGetPerfMonitorGroupsAMD'));
     glGetPerfMonitorCountersAMD := SYSTEM.VAL(TglGetPerfMonitorCountersAMD, wglGetProcAddress('glGetPerfMonitorCountersAMD'));
     glGetPerfMonitorGroupStringAMD := SYSTEM.VAL(TglGetPerfMonitorGroupStringAMD, wglGetProcAddress('glGetPerfMonitorGroupStringAMD'));
     glGetPerfMonitorCounterStringAMD := SYSTEM.VAL(TglGetPerfMonitorCounterStringAMD, wglGetProcAddress('glGetPerfMonitorCounterStringAMD'));
     glGetPerfMonitorCounterInfoAMD := SYSTEM.VAL(TglGetPerfMonitorCounterInfoAMD, wglGetProcAddress('glGetPerfMonitorCounterInfoAMD'));
     glGenPerfMonitorsAMD := SYSTEM.VAL(TglGenPerfMonitorsAMD, wglGetProcAddress('glGenPerfMonitorsAMD'));
     glDeletePerfMonitorsAMD := SYSTEM.VAL(TglDeletePerfMonitorsAMD, wglGetProcAddress('glDeletePerfMonitorsAMD'));
     glSelectPerfMonitorCountersAMD := SYSTEM.VAL(TglSelectPerfMonitorCountersAMD, wglGetProcAddress('glSelectPerfMonitorCountersAMD'));
     glBeginPerfMonitorAMD := SYSTEM.VAL(TglBeginPerfMonitorAMD, wglGetProcAddress('glBeginPerfMonitorAMD'));
     glEndPerfMonitorAMD := SYSTEM.VAL(TglEndPerfMonitorAMD, wglGetProcAddress('glEndPerfMonitorAMD'));
     glGetPerfMonitorCounterDataAMD := SYSTEM.VAL(TglGetPerfMonitorCounterDataAMD, wglGetProcAddress('glGetPerfMonitorCounterDataAMD'));
END Read_GL_AMD_performance_monitor;

PROCEDURE Read_GL_AMD_vertex_shader_tesselator;
BEGIN
     glTessellationFactorAMD := SYSTEM.VAL(TglTessellationFactorAMD, wglGetProcAddress('glTessellationFactorAMD'));
     glTessellationModeAMD := SYSTEM.VAL(TglTessellationModeAMD, wglGetProcAddress('glTessellationModeAMD'));
END Read_GL_AMD_vertex_shader_tesselator;

PROCEDURE Read_GL_AMD_draw_buffers_blend;
BEGIN
     glBlendFuncIndexedAMD := SYSTEM.VAL(TglBlendFuncIndexedAMD, wglGetProcAddress('glBlendFuncIndexedAMD'));
     glBlendFuncSeparateIndexedAMD := SYSTEM.VAL(TglBlendFuncSeparateIndexedAMD, wglGetProcAddress('glBlendFuncSeparateIndexedAMD'));
     glBlendEquationIndexedAMD := SYSTEM.VAL(TglBlendEquationIndexedAMD, wglGetProcAddress('glBlendEquationIndexedAMD'));
     glBlendEquationSeparateIndexedAMD := SYSTEM.VAL(TglBlendEquationSeparateIndexedAMD, wglGetProcAddress('glBlendEquationSeparateIndexedAMD'));
END Read_GL_AMD_draw_buffers_blend;

PROCEDURE Read_GL_AMD_name_gen_delete;
BEGIN
     glGenNamesAMD := SYSTEM.VAL(TglGenNamesAMD, wglGetProcAddress('glGenNamesAMD'));
     glDeleteNamesAMD := SYSTEM.VAL(TglDeleteNamesAMD, wglGetProcAddress('glDeleteNamesAMD'));
     glIsNameAMD := SYSTEM.VAL(TglIsNameAMD, wglGetProcAddress('glIsNameAMD'));
END Read_GL_AMD_name_gen_delete;

PROCEDURE Read_GL_AMD_debug_output;
BEGIN
     glDebugMessageEnableAMD := SYSTEM.VAL(TglDebugMessageEnableAMD, wglGetProcAddress('glDebugMessageEnableAMD'));
     glDebugMessageInsertAMD := SYSTEM.VAL(TglDebugMessageInsertAMD, wglGetProcAddress('glDebugMessageInsertAMD'));
(*     glDebugMessageCallbackAMD := SYSTEM.VAL(TglDebugMessageCallbackAMD, wglGetProcAddress('glDebugMessageCallbackAMD')); *)
     glGetDebugMessageLogAMD := SYSTEM.VAL(TglGetDebugMessageLogAMD, wglGetProcAddress('glGetDebugMessageLogAMD'));
END Read_GL_AMD_debug_output;

PROCEDURE Read_GL_EXT_blend_color;
BEGIN
     glBlendColorEXT := SYSTEM.VAL(TglBlendColorEXT, wglGetProcAddress('glBlendColorEXT'));
END Read_GL_EXT_blend_color;

PROCEDURE Read_GL_EXT_blend_func_separate;
BEGIN
     glBlendFuncSeparateEXT := SYSTEM.VAL(TglBlendFuncSeparateEXT, wglGetProcAddress('glBlendFuncSeparateEXT'));
END Read_GL_EXT_blend_func_separate;

PROCEDURE Read_GL_EXT_blend_minmax;
BEGIN
     glBlendEquationEXT := SYSTEM.VAL(TglBlendEquationEXT, wglGetProcAddress('glBlendEquationEXT'));
END Read_GL_EXT_blend_minmax;

PROCEDURE Read_GL_EXT_color_subtable;
BEGIN
     glColorSubTableEXT := SYSTEM.VAL(TglColorSubTableEXT, wglGetProcAddress('glColorSubTableEXT'));
     glCopyColorSubTableEXT := SYSTEM.VAL(TglCopyColorSubTableEXT, wglGetProcAddress('glCopyColorSubTableEXT'));
END Read_GL_EXT_color_subtable;

PROCEDURE Read_GL_EXT_compiled_vertex_array;
BEGIN
     glLockArraysEXT := SYSTEM.VAL(TglLockArraysEXT, wglGetProcAddress('glLockArraysEXT'));
     glUnlockArraysEXT := SYSTEM.VAL(TglUnlockArraysEXT, wglGetProcAddress('glUnlockArraysEXT'));
END Read_GL_EXT_compiled_vertex_array;

PROCEDURE Read_GL_EXT_convolution;
BEGIN
     glConvolutionFilter1DEXT := SYSTEM.VAL(TglConvolutionFilter1DEXT, wglGetProcAddress('glConvolutionFilter1DEXT'));
     glConvolutionFilter2DEXT := SYSTEM.VAL(TglConvolutionFilter2DEXT, wglGetProcAddress('glConvolutionFilter2DEXT'));
     glConvolutionParameterfEXT := SYSTEM.VAL(TglConvolutionParameterfEXT, wglGetProcAddress('glConvolutionParameterfEXT'));
     glConvolutionParameterfvEXT := SYSTEM.VAL(TglConvolutionParameterfvEXT, wglGetProcAddress('glConvolutionParameterfvEXT'));
     glConvolutionParameteriEXT := SYSTEM.VAL(TglConvolutionParameteriEXT, wglGetProcAddress('glConvolutionParameteriEXT'));
     glConvolutionParameterivEXT := SYSTEM.VAL(TglConvolutionParameterivEXT, wglGetProcAddress('glConvolutionParameterivEXT'));
     glCopyConvolutionFilter1DEXT := SYSTEM.VAL(TglCopyConvolutionFilter1DEXT, wglGetProcAddress('glCopyConvolutionFilter1DEXT'));
     glCopyConvolutionFilter2DEXT := SYSTEM.VAL(TglCopyConvolutionFilter2DEXT, wglGetProcAddress('glCopyConvolutionFilter2DEXT'));
     glGetConvolutionFilterEXT := SYSTEM.VAL(TglGetConvolutionFilterEXT, wglGetProcAddress('glGetConvolutionFilterEXT'));
     glGetConvolutionParameterfvEXT := SYSTEM.VAL(TglGetConvolutionParameterfvEXT, wglGetProcAddress('glGetConvolutionParameterfvEXT'));
     glGetConvolutionParameterivEXT := SYSTEM.VAL(TglGetConvolutionParameterivEXT, wglGetProcAddress('glGetConvolutionParameterivEXT'));
     glGetSeparableFilterEXT := SYSTEM.VAL(TglGetSeparableFilterEXT, wglGetProcAddress('glGetSeparableFilterEXT'));
     glSeparableFilter2DEXT := SYSTEM.VAL(TglSeparableFilter2DEXT, wglGetProcAddress('glSeparableFilter2DEXT'));
END Read_GL_EXT_convolution;

PROCEDURE Read_GL_EXT_coordinate_frame;
BEGIN
     glTangent3bEXT := SYSTEM.VAL(TglTangent3bEXT, wglGetProcAddress('glTangent3bEXT'));
     glTangent3bvEXT := SYSTEM.VAL(TglTangent3bvEXT, wglGetProcAddress('glTangent3bvEXT'));
     glTangent3dEXT := SYSTEM.VAL(TglTangent3dEXT, wglGetProcAddress('glTangent3dEXT'));
     glTangent3dvEXT := SYSTEM.VAL(TglTangent3dvEXT, wglGetProcAddress('glTangent3dvEXT'));
     glTangent3fEXT := SYSTEM.VAL(TglTangent3fEXT, wglGetProcAddress('glTangent3fEXT'));
     glTangent3fvEXT := SYSTEM.VAL(TglTangent3fvEXT, wglGetProcAddress('glTangent3fvEXT'));
     glTangent3iEXT := SYSTEM.VAL(TglTangent3iEXT, wglGetProcAddress('glTangent3iEXT'));
     glTangent3ivEXT := SYSTEM.VAL(TglTangent3ivEXT, wglGetProcAddress('glTangent3ivEXT'));
     glTangent3sEXT := SYSTEM.VAL(TglTangent3sEXT, wglGetProcAddress('glTangent3sEXT'));
     glTangent3svEXT := SYSTEM.VAL(TglTangent3svEXT, wglGetProcAddress('glTangent3svEXT'));
     glBinormal3bEXT := SYSTEM.VAL(TglBinormal3bEXT, wglGetProcAddress('glBinormal3bEXT'));
     glBinormal3bvEXT := SYSTEM.VAL(TglBinormal3bvEXT, wglGetProcAddress('glBinormal3bvEXT'));
     glBinormal3dEXT := SYSTEM.VAL(TglBinormal3dEXT, wglGetProcAddress('glBinormal3dEXT'));
     glBinormal3dvEXT := SYSTEM.VAL(TglBinormal3dvEXT, wglGetProcAddress('glBinormal3dvEXT'));
     glBinormal3fEXT := SYSTEM.VAL(TglBinormal3fEXT, wglGetProcAddress('glBinormal3fEXT'));
     glBinormal3fvEXT := SYSTEM.VAL(TglBinormal3fvEXT, wglGetProcAddress('glBinormal3fvEXT'));
     glBinormal3iEXT := SYSTEM.VAL(TglBinormal3iEXT, wglGetProcAddress('glBinormal3iEXT'));
     glBinormal3ivEXT := SYSTEM.VAL(TglBinormal3ivEXT, wglGetProcAddress('glBinormal3ivEXT'));
     glBinormal3sEXT := SYSTEM.VAL(TglBinormal3sEXT, wglGetProcAddress('glBinormal3sEXT'));
     glBinormal3svEXT := SYSTEM.VAL(TglBinormal3svEXT, wglGetProcAddress('glBinormal3svEXT'));
     glTangentPointerEXT := SYSTEM.VAL(TglTangentPointerEXT, wglGetProcAddress('glTangentPointerEXT'));
     glBinormalPointerEXT := SYSTEM.VAL(TglBinormalPointerEXT, wglGetProcAddress('glBinormalPointerEXT'));
END Read_GL_EXT_coordinate_frame;

PROCEDURE Read_GL_EXT_copy_texture;
BEGIN
     glCopyTexImage1DEXT := SYSTEM.VAL(TglCopyTexImage1DEXT, wglGetProcAddress('glCopyTexImage1DEXT'));
     glCopyTexImage2DEXT := SYSTEM.VAL(TglCopyTexImage2DEXT, wglGetProcAddress('glCopyTexImage2DEXT'));
     glCopyTexSubImage1DEXT := SYSTEM.VAL(TglCopyTexSubImage1DEXT, wglGetProcAddress('glCopyTexSubImage1DEXT'));
     glCopyTexSubImage2DEXT := SYSTEM.VAL(TglCopyTexSubImage2DEXT, wglGetProcAddress('glCopyTexSubImage2DEXT'));
     glCopyTexSubImage3DEXT := SYSTEM.VAL(TglCopyTexSubImage3DEXT, wglGetProcAddress('glCopyTexSubImage3DEXT'));
END Read_GL_EXT_copy_texture;

PROCEDURE Read_GL_EXT_cull_vertex;
BEGIN
     glCullParameterdvEXT := SYSTEM.VAL(TglCullParameterdvEXT, wglGetProcAddress('glCullParameterdvEXT'));
     glCullParameterfvEXT := SYSTEM.VAL(TglCullParameterfvEXT, wglGetProcAddress('glCullParameterfvEXT'));
END Read_GL_EXT_cull_vertex;

PROCEDURE Read_GL_EXT_draw_range_elements;
BEGIN
     glDrawRangeElementsEXT := SYSTEM.VAL(TglDrawRangeElementsEXT, wglGetProcAddress('glDrawRangeElementsEXT'));
END Read_GL_EXT_draw_range_elements;

PROCEDURE Read_GL_EXT_fog_coord;
BEGIN
     glFogCoordfEXT := SYSTEM.VAL(TglFogCoordfEXT, wglGetProcAddress('glFogCoordfEXT'));
     glFogCoordfvEXT := SYSTEM.VAL(TglFogCoordfvEXT, wglGetProcAddress('glFogCoordfvEXT'));
     glFogCoorddEXT := SYSTEM.VAL(TglFogCoorddEXT, wglGetProcAddress('glFogCoorddEXT'));
     glFogCoorddvEXT := SYSTEM.VAL(TglFogCoorddvEXT, wglGetProcAddress('glFogCoorddvEXT'));
     glFogCoordPointerEXT := SYSTEM.VAL(TglFogCoordPointerEXT, wglGetProcAddress('glFogCoordPointerEXT'));
END Read_GL_EXT_fog_coord;

PROCEDURE Read_GL_EXT_framebuffer_object;
BEGIN
     glIsRenderbufferEXT := SYSTEM.VAL(TglIsRenderbufferEXT, wglGetProcAddress('glIsRenderbufferEXT'));
     glBindRenderbufferEXT := SYSTEM.VAL(TglBindRenderbufferEXT, wglGetProcAddress('glBindRenderbufferEXT'));
     glDeleteRenderbuffersEXT := SYSTEM.VAL(TglDeleteRenderbuffersEXT, wglGetProcAddress('glDeleteRenderbuffersEXT'));
     glGenRenderbuffersEXT := SYSTEM.VAL(TglGenRenderbuffersEXT, wglGetProcAddress('glGenRenderbuffersEXT'));
     glRenderbufferStorageEXT := SYSTEM.VAL(TglRenderbufferStorageEXT, wglGetProcAddress('glRenderbufferStorageEXT'));
     glGetRenderbufferParameterivEXT := SYSTEM.VAL(TglGetRenderbufferParameterivEXT, wglGetProcAddress('glGetRenderbufferParameterivEXT'));
     glIsFramebufferEXT := SYSTEM.VAL(TglIsFramebufferEXT, wglGetProcAddress('glIsFramebufferEXT'));
     glBindFramebufferEXT := SYSTEM.VAL(TglBindFramebufferEXT, wglGetProcAddress('glBindFramebufferEXT'));
     glDeleteFramebuffersEXT := SYSTEM.VAL(TglDeleteFramebuffersEXT, wglGetProcAddress('glDeleteFramebuffersEXT'));
     glGenFramebuffersEXT := SYSTEM.VAL(TglGenFramebuffersEXT, wglGetProcAddress('glGenFramebuffersEXT'));
     glCheckFramebufferStatusEXT := SYSTEM.VAL(TglCheckFramebufferStatusEXT, wglGetProcAddress('glCheckFramebufferStatusEXT'));
     glFramebufferTexture1DEXT := SYSTEM.VAL(TglFramebufferTexture1DEXT, wglGetProcAddress('glFramebufferTexture1DEXT'));
     glFramebufferTexture2DEXT := SYSTEM.VAL(TglFramebufferTexture2DEXT, wglGetProcAddress('glFramebufferTexture2DEXT'));
     glFramebufferTexture3DEXT := SYSTEM.VAL(TglFramebufferTexture3DEXT, wglGetProcAddress('glFramebufferTexture3DEXT'));
     glFramebufferRenderbufferEXT := SYSTEM.VAL(TglFramebufferRenderbufferEXT, wglGetProcAddress('glFramebufferRenderbufferEXT'));
     glGetFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetFramebufferAttachmentParameterivEXT, wglGetProcAddress('glGetFramebufferAttachmentParameterivEXT'));
     glGenerateMipmapEXT := SYSTEM.VAL(TglGenerateMipmapEXT, wglGetProcAddress('glGenerateMipmapEXT'));
END Read_GL_EXT_framebuffer_object;

PROCEDURE Read_GL_EXT_histogram;
BEGIN
     glGetHistogramEXT := SYSTEM.VAL(TglGetHistogramEXT, wglGetProcAddress('glGetHistogramEXT'));
     glGetHistogramParameterfvEXT := SYSTEM.VAL(TglGetHistogramParameterfvEXT, wglGetProcAddress('glGetHistogramParameterfvEXT'));
     glGetHistogramParameterivEXT := SYSTEM.VAL(TglGetHistogramParameterivEXT, wglGetProcAddress('glGetHistogramParameterivEXT'));
     glGetMinmaxEXT := SYSTEM.VAL(TglGetMinmaxEXT, wglGetProcAddress('glGetMinmaxEXT'));
     glGetMinmaxParameterfvEXT := SYSTEM.VAL(TglGetMinmaxParameterfvEXT, wglGetProcAddress('glGetMinmaxParameterfvEXT'));
     glGetMinmaxParameterivEXT := SYSTEM.VAL(TglGetMinmaxParameterivEXT, wglGetProcAddress('glGetMinmaxParameterivEXT'));
     glHistogramEXT := SYSTEM.VAL(TglHistogramEXT, wglGetProcAddress('glHistogramEXT'));
     glMinmaxEXT := SYSTEM.VAL(TglMinmaxEXT, wglGetProcAddress('glMinmaxEXT'));
     glResetHistogramEXT := SYSTEM.VAL(TglResetHistogramEXT, wglGetProcAddress('glResetHistogramEXT'));
     glResetMinmaxEXT := SYSTEM.VAL(TglResetMinmaxEXT, wglGetProcAddress('glResetMinmaxEXT'));
END Read_GL_EXT_histogram;

PROCEDURE Read_GL_EXT_index_func;
BEGIN
     glIndexFuncEXT := SYSTEM.VAL(TglIndexFuncEXT, wglGetProcAddress('glIndexFuncEXT'));
END Read_GL_EXT_index_func;

PROCEDURE Read_GL_EXT_index_material;
BEGIN
     glIndexMaterialEXT := SYSTEM.VAL(TglIndexMaterialEXT, wglGetProcAddress('glIndexMaterialEXT'));
END Read_GL_EXT_index_material;

PROCEDURE Read_GL_EXT_light_texture;
BEGIN
     glApplyTextureEXT := SYSTEM.VAL(TglApplyTextureEXT, wglGetProcAddress('glApplyTextureEXT'));
     glTextureLightEXT := SYSTEM.VAL(TglTextureLightEXT, wglGetProcAddress('glTextureLightEXT'));
     glTextureMaterialEXT := SYSTEM.VAL(TglTextureMaterialEXT, wglGetProcAddress('glTextureMaterialEXT'));
END Read_GL_EXT_light_texture;

PROCEDURE Read_GL_EXT_multi_draw_arrays;
BEGIN
     glMultiDrawArraysEXT := SYSTEM.VAL(TglMultiDrawArraysEXT, wglGetProcAddress('glMultiDrawArraysEXT'));
     glMultiDrawElementsEXT := SYSTEM.VAL(TglMultiDrawElementsEXT, wglGetProcAddress('glMultiDrawElementsEXT'));
END Read_GL_EXT_multi_draw_arrays;

PROCEDURE Read_GL_EXT_multisample;
BEGIN
     glSampleMaskEXT := SYSTEM.VAL(TglSampleMaskEXT, wglGetProcAddress('glSampleMaskEXT'));
     glSamplePatternEXT := SYSTEM.VAL(TglSamplePatternEXT, wglGetProcAddress('glSamplePatternEXT'));
END Read_GL_EXT_multisample;

PROCEDURE Read_GL_EXT_paletted_texture;
BEGIN
     glColorTableEXT := SYSTEM.VAL(TglColorTableEXT, wglGetProcAddress('glColorTableEXT'));
     glGetColorTableEXT := SYSTEM.VAL(TglGetColorTableEXT, wglGetProcAddress('glGetColorTableEXT'));
     glGetColorTableParameterivEXT := SYSTEM.VAL(TglGetColorTableParameterivEXT, wglGetProcAddress('glGetColorTableParameterivEXT'));
     glGetColorTableParameterfvEXT := SYSTEM.VAL(TglGetColorTableParameterfvEXT, wglGetProcAddress('glGetColorTableParameterfvEXT'));
END Read_GL_EXT_paletted_texture;

PROCEDURE Read_GL_EXT_pixel_transform;
BEGIN
     glPixelTransformParameteriEXT := SYSTEM.VAL(TglPixelTransformParameteriEXT, wglGetProcAddress('glPixelTransformParameteriEXT'));
     glPixelTransformParameterfEXT := SYSTEM.VAL(TglPixelTransformParameterfEXT, wglGetProcAddress('glPixelTransformParameterfEXT'));
     glPixelTransformParameterivEXT := SYSTEM.VAL(TglPixelTransformParameterivEXT, wglGetProcAddress('glPixelTransformParameterivEXT'));
     glPixelTransformParameterfvEXT := SYSTEM.VAL(TglPixelTransformParameterfvEXT, wglGetProcAddress('glPixelTransformParameterfvEXT'));
END Read_GL_EXT_pixel_transform;

PROCEDURE Read_GL_EXT_point_parameters;
BEGIN
     glPointParameterfEXT := SYSTEM.VAL(TglPointParameterfEXT, wglGetProcAddress('glPointParameterfEXT'));
     glPointParameterfvEXT := SYSTEM.VAL(TglPointParameterfvEXT, wglGetProcAddress('glPointParameterfvEXT'));
END Read_GL_EXT_point_parameters;

PROCEDURE Read_GL_EXT_polygon_offset;
BEGIN
     glPolygonOffsetEXT := SYSTEM.VAL(TglPolygonOffsetEXT, wglGetProcAddress('glPolygonOffsetEXT'));
END Read_GL_EXT_polygon_offset;

PROCEDURE Read_GL_EXT_secondary_color;
BEGIN
     glSecondaryColor3bEXT := SYSTEM.VAL(TglSecondaryColor3bEXT, wglGetProcAddress('glSecondaryColor3bEXT'));
     glSecondaryColor3bvEXT := SYSTEM.VAL(TglSecondaryColor3bvEXT, wglGetProcAddress('glSecondaryColor3bvEXT'));
     glSecondaryColor3dEXT := SYSTEM.VAL(TglSecondaryColor3dEXT, wglGetProcAddress('glSecondaryColor3dEXT'));
     glSecondaryColor3dvEXT := SYSTEM.VAL(TglSecondaryColor3dvEXT, wglGetProcAddress('glSecondaryColor3dvEXT'));
     glSecondaryColor3fEXT := SYSTEM.VAL(TglSecondaryColor3fEXT, wglGetProcAddress('glSecondaryColor3fEXT'));
     glSecondaryColor3fvEXT := SYSTEM.VAL(TglSecondaryColor3fvEXT, wglGetProcAddress('glSecondaryColor3fvEXT'));
     glSecondaryColor3iEXT := SYSTEM.VAL(TglSecondaryColor3iEXT, wglGetProcAddress('glSecondaryColor3iEXT'));
     glSecondaryColor3ivEXT := SYSTEM.VAL(TglSecondaryColor3ivEXT, wglGetProcAddress('glSecondaryColor3ivEXT'));
     glSecondaryColor3sEXT := SYSTEM.VAL(TglSecondaryColor3sEXT, wglGetProcAddress('glSecondaryColor3sEXT'));
     glSecondaryColor3svEXT := SYSTEM.VAL(TglSecondaryColor3svEXT, wglGetProcAddress('glSecondaryColor3svEXT'));
     glSecondaryColor3ubEXT := SYSTEM.VAL(TglSecondaryColor3ubEXT, wglGetProcAddress('glSecondaryColor3ubEXT'));
     glSecondaryColor3ubvEXT := SYSTEM.VAL(TglSecondaryColor3ubvEXT, wglGetProcAddress('glSecondaryColor3ubvEXT'));
     glSecondaryColor3uiEXT := SYSTEM.VAL(TglSecondaryColor3uiEXT, wglGetProcAddress('glSecondaryColor3uiEXT'));
     glSecondaryColor3uivEXT := SYSTEM.VAL(TglSecondaryColor3uivEXT, wglGetProcAddress('glSecondaryColor3uivEXT'));
     glSecondaryColor3usEXT := SYSTEM.VAL(TglSecondaryColor3usEXT, wglGetProcAddress('glSecondaryColor3usEXT'));
     glSecondaryColor3usvEXT := SYSTEM.VAL(TglSecondaryColor3usvEXT, wglGetProcAddress('glSecondaryColor3usvEXT'));
     glSecondaryColorPointerEXT := SYSTEM.VAL(TglSecondaryColorPointerEXT, wglGetProcAddress('glSecondaryColorPointerEXT'));
END Read_GL_EXT_secondary_color;

PROCEDURE Read_GL_EXT_stencil_two_side;
BEGIN
     glActiveStencilFaceEXT := SYSTEM.VAL(TglActiveStencilFaceEXT, wglGetProcAddress('glActiveStencilFaceEXT'));
END Read_GL_EXT_stencil_two_side;

PROCEDURE Read_GL_EXT_subtexture;
BEGIN
     glTexSubImage1DEXT := SYSTEM.VAL(TglTexSubImage1DEXT, wglGetProcAddress('glTexSubImage1DEXT'));
     glTexSubImage2DEXT := SYSTEM.VAL(TglTexSubImage2DEXT, wglGetProcAddress('glTexSubImage2DEXT'));
END Read_GL_EXT_subtexture;

PROCEDURE Read_GL_EXT_texture3D;
BEGIN
     glTexImage3DEXT := SYSTEM.VAL(TglTexImage3DEXT, wglGetProcAddress('glTexImage3DEXT'));
     glTexSubImage3DEXT := SYSTEM.VAL(TglTexSubImage3DEXT, wglGetProcAddress('glTexSubImage3DEXT'));
END Read_GL_EXT_texture3D;

PROCEDURE Read_GL_EXT_texture_object;
BEGIN
     glAreTexturesResidentEXT := SYSTEM.VAL(TglAreTexturesResidentEXT, wglGetProcAddress('glAreTexturesResidentEXT'));
     glBindTextureEXT := SYSTEM.VAL(TglBindTextureEXT, wglGetProcAddress('glBindTextureEXT'));
     glDeleteTexturesEXT := SYSTEM.VAL(TglDeleteTexturesEXT, wglGetProcAddress('glDeleteTexturesEXT'));
     glGenTexturesEXT := SYSTEM.VAL(TglGenTexturesEXT, wglGetProcAddress('glGenTexturesEXT'));
     glIsTextureEXT := SYSTEM.VAL(TglIsTextureEXT, wglGetProcAddress('glIsTextureEXT'));
     glPrioritizeTexturesEXT := SYSTEM.VAL(TglPrioritizeTexturesEXT, wglGetProcAddress('glPrioritizeTexturesEXT'));
END Read_GL_EXT_texture_object;

PROCEDURE Read_GL_EXT_texture_perturb_normal;
BEGIN
     glTextureNormalEXT := SYSTEM.VAL(TglTextureNormalEXT, wglGetProcAddress('glTextureNormalEXT'));
END Read_GL_EXT_texture_perturb_normal;

PROCEDURE Read_GL_EXT_vertex_array;
BEGIN
     glArrayElementEXT := SYSTEM.VAL(TglArrayElementEXT, wglGetProcAddress('glArrayElementEXT'));
     glColorPointerEXT := SYSTEM.VAL(TglColorPointerEXT, wglGetProcAddress('glColorPointerEXT'));
     glDrawArraysEXT := SYSTEM.VAL(TglDrawArraysEXT, wglGetProcAddress('glDrawArraysEXT'));
     glEdgeFlagPointerEXT := SYSTEM.VAL(TglEdgeFlagPointerEXT, wglGetProcAddress('glEdgeFlagPointerEXT'));
     glGetPointervEXT := SYSTEM.VAL(TglGetPointervEXT, wglGetProcAddress('glGetPointervEXT'));
     glIndexPointerEXT := SYSTEM.VAL(TglIndexPointerEXT, wglGetProcAddress('glIndexPointerEXT'));
     glNormalPointerEXT := SYSTEM.VAL(TglNormalPointerEXT, wglGetProcAddress('glNormalPointerEXT'));
     glTexCoordPointerEXT := SYSTEM.VAL(TglTexCoordPointerEXT, wglGetProcAddress('glTexCoordPointerEXT'));
     glVertexPointerEXT := SYSTEM.VAL(TglVertexPointerEXT, wglGetProcAddress('glVertexPointerEXT'));
END Read_GL_EXT_vertex_array;

PROCEDURE Read_GL_EXT_vertex_shader;
BEGIN
     glBeginVertexShaderEXT := SYSTEM.VAL(TglBeginVertexShaderEXT, wglGetProcAddress('glBeginVertexShaderEXT'));
     glEndVertexShaderEXT := SYSTEM.VAL(TglEndVertexShaderEXT, wglGetProcAddress('glEndVertexShaderEXT'));
     glBindVertexShaderEXT := SYSTEM.VAL(TglBindVertexShaderEXT, wglGetProcAddress('glBindVertexShaderEXT'));
     glGenVertexShadersEXT := SYSTEM.VAL(TglGenVertexShadersEXT, wglGetProcAddress('glGenVertexShadersEXT'));
     glDeleteVertexShaderEXT := SYSTEM.VAL(TglDeleteVertexShaderEXT, wglGetProcAddress('glDeleteVertexShaderEXT'));
     glShaderOp1EXT := SYSTEM.VAL(TglShaderOp1EXT, wglGetProcAddress('glShaderOp1EXT'));
     glShaderOp2EXT := SYSTEM.VAL(TglShaderOp2EXT, wglGetProcAddress('glShaderOp2EXT'));
     glShaderOp3EXT := SYSTEM.VAL(TglShaderOp3EXT, wglGetProcAddress('glShaderOp3EXT'));
     glSwizzleEXT := SYSTEM.VAL(TglSwizzleEXT, wglGetProcAddress('glSwizzleEXT'));
     glWriteMaskEXT := SYSTEM.VAL(TglWriteMaskEXT, wglGetProcAddress('glWriteMaskEXT'));
     glInsertComponentEXT := SYSTEM.VAL(TglInsertComponentEXT, wglGetProcAddress('glInsertComponentEXT'));
     glExtractComponentEXT := SYSTEM.VAL(TglExtractComponentEXT, wglGetProcAddress('glExtractComponentEXT'));
     glGenSymbolsEXT := SYSTEM.VAL(TglGenSymbolsEXT, wglGetProcAddress('glGenSymbolsEXT'));
     glSetInvariantEXT := SYSTEM.VAL(TglSetInvariantEXT, wglGetProcAddress('glSetInvariantEXT'));
     glSetLocalConstantEXT := SYSTEM.VAL(TglSetLocalConstantEXT, wglGetProcAddress('glSetLocalConstantEXT'));
     glVariantbvEXT := SYSTEM.VAL(TglVariantbvEXT, wglGetProcAddress('glVariantbvEXT'));
     glVariantsvEXT := SYSTEM.VAL(TglVariantsvEXT, wglGetProcAddress('glVariantsvEXT'));
     glVariantivEXT := SYSTEM.VAL(TglVariantivEXT, wglGetProcAddress('glVariantivEXT'));
     glVariantfvEXT := SYSTEM.VAL(TglVariantfvEXT, wglGetProcAddress('glVariantfvEXT'));
     glVariantdvEXT := SYSTEM.VAL(TglVariantdvEXT, wglGetProcAddress('glVariantdvEXT'));
     glVariantubvEXT := SYSTEM.VAL(TglVariantubvEXT, wglGetProcAddress('glVariantubvEXT'));
     glVariantusvEXT := SYSTEM.VAL(TglVariantusvEXT, wglGetProcAddress('glVariantusvEXT'));
     glVariantuivEXT := SYSTEM.VAL(TglVariantuivEXT, wglGetProcAddress('glVariantuivEXT'));
     glVariantPointerEXT := SYSTEM.VAL(TglVariantPointerEXT, wglGetProcAddress('glVariantPointerEXT'));
     glEnableVariantClientStateEXT := SYSTEM.VAL(TglEnableVariantClientStateEXT, wglGetProcAddress('glEnableVariantClientStateEXT'));
     glDisableVariantClientStateEXT := SYSTEM.VAL(TglDisableVariantClientStateEXT, wglGetProcAddress('glDisableVariantClientStateEXT'));
     glBindLightParameterEXT := SYSTEM.VAL(TglBindLightParameterEXT, wglGetProcAddress('glBindLightParameterEXT'));
     glBindMaterialParameterEXT := SYSTEM.VAL(TglBindMaterialParameterEXT, wglGetProcAddress('glBindMaterialParameterEXT'));
     glBindTexGenParameterEXT := SYSTEM.VAL(TglBindTexGenParameterEXT, wglGetProcAddress('glBindTexGenParameterEXT'));
     glBindTextureUnitParameterEXT := SYSTEM.VAL(TglBindTextureUnitParameterEXT, wglGetProcAddress('glBindTextureUnitParameterEXT'));
     glBindParameterEXT := SYSTEM.VAL(TglBindParameterEXT, wglGetProcAddress('glBindParameterEXT'));
     glIsVariantEnabledEXT := SYSTEM.VAL(TglIsVariantEnabledEXT, wglGetProcAddress('glIsVariantEnabledEXT'));
     glGetVariantBooleanvEXT := SYSTEM.VAL(TglGetVariantBooleanvEXT, wglGetProcAddress('glGetVariantBooleanvEXT'));
     glGetVariantIntegervEXT := SYSTEM.VAL(TglGetVariantIntegervEXT, wglGetProcAddress('glGetVariantIntegervEXT'));
     glGetVariantFloatvEXT := SYSTEM.VAL(TglGetVariantFloatvEXT, wglGetProcAddress('glGetVariantFloatvEXT'));
     glGetVariantPointervEXT := SYSTEM.VAL(TglGetVariantPointervEXT, wglGetProcAddress('glGetVariantPointervEXT'));
     glGetInvariantBooleanvEXT := SYSTEM.VAL(TglGetInvariantBooleanvEXT, wglGetProcAddress('glGetInvariantBooleanvEXT'));
     glGetInvariantIntegervEXT := SYSTEM.VAL(TglGetInvariantIntegervEXT, wglGetProcAddress('glGetInvariantIntegervEXT'));
     glGetInvariantFloatvEXT := SYSTEM.VAL(TglGetInvariantFloatvEXT, wglGetProcAddress('glGetInvariantFloatvEXT'));
     glGetLocalConstantBooleanvEXT := SYSTEM.VAL(TglGetLocalConstantBooleanvEXT, wglGetProcAddress('glGetLocalConstantBooleanvEXT'));
     glGetLocalConstantIntegervEXT := SYSTEM.VAL(TglGetLocalConstantIntegervEXT, wglGetProcAddress('glGetLocalConstantIntegervEXT'));
     glGetLocalConstantFloatvEXT := SYSTEM.VAL(TglGetLocalConstantFloatvEXT, wglGetProcAddress('glGetLocalConstantFloatvEXT'));
END Read_GL_EXT_vertex_shader;

PROCEDURE Read_GL_EXT_vertex_weighting;
BEGIN
     glVertexWeightfEXT := SYSTEM.VAL(TglVertexWeightfEXT, wglGetProcAddress('glVertexWeightfEXT'));
     glVertexWeightfvEXT := SYSTEM.VAL(TglVertexWeightfvEXT, wglGetProcAddress('glVertexWeightfvEXT'));
     glVertexWeightPointerEXT := SYSTEM.VAL(TglVertexWeightPointerEXT, wglGetProcAddress('glVertexWeightPointerEXT'));
END Read_GL_EXT_vertex_weighting;

PROCEDURE Read_GL_EXT_depth_bounds_test;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, wglGetProcAddress('glImageTransformParameteriHP'));
     glDepthBoundsEXT := SYSTEM.VAL(TglDepthBoundsEXT, wglGetProcAddress('glDepthBoundsEXT'));
END Read_GL_EXT_depth_bounds_test;

PROCEDURE Read_GL_EXT_blend_equation_separate;
BEGIN
     glBlendEquationSeparateEXT := SYSTEM.VAL(TglBlendEquationSeparateEXT, wglGetProcAddress('glBlendEquationSeparateEXT'));
END Read_GL_EXT_blend_equation_separate;

PROCEDURE Read_GL_EXT_stencil_clear_tag;
BEGIN
     glStencilClearTagEXT := SYSTEM.VAL(TglStencilClearTagEXT, wglGetProcAddress('glStencilClearTagEXT'));
END Read_GL_EXT_stencil_clear_tag;

PROCEDURE Read_GL_EXT_framebuffer_blit;
BEGIN
     glBlitFramebufferEXT := SYSTEM.VAL(TglBlitFramebufferEXT, wglGetProcAddress('glBlitFramebufferEXT'));
END Read_GL_EXT_framebuffer_blit;

PROCEDURE Read_GL_EXT_framebuffer_multisample;
BEGIN
     glRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglRenderbufferStorageMultisampleEXT, wglGetProcAddress('glRenderbufferStorageMultisampleEXT'));
END Read_GL_EXT_framebuffer_multisample;

PROCEDURE Read_GL_EXT_timer_query;
BEGIN
     glGetQueryObjecti64vEXT := SYSTEM.VAL(TglGetQueryObjecti64vEXT, wglGetProcAddress('glGetQueryObjecti64vEXT'));
     glGetQueryObjectui64vEXT := SYSTEM.VAL(TglGetQueryObjectui64vEXT, wglGetProcAddress('glGetQueryObjectui64vEXT'));
END Read_GL_EXT_timer_query;

PROCEDURE Read_GL_EXT_gpu_program_parameters;
BEGIN
     glProgramEnvParameters4fvEXT := SYSTEM.VAL(TglProgramEnvParameters4fvEXT, wglGetProcAddress('glProgramEnvParameters4fvEXT'));
     glProgramLocalParameters4fvEXT := SYSTEM.VAL(TglProgramLocalParameters4fvEXT, wglGetProcAddress('glProgramLocalParameters4fvEXT'));
END Read_GL_EXT_gpu_program_parameters;

PROCEDURE Read_GL_EXT_bindable_uniform;
BEGIN
     glUniformBufferEXT := SYSTEM.VAL(TglUniformBufferEXT, wglGetProcAddress('glUniformBufferEXT'));
     glGetUniformBufferSizeEXT := SYSTEM.VAL(TglGetUniformBufferSizeEXT, wglGetProcAddress('glGetUniformBufferSizeEXT'));
     glGetUniformOffsetEXT := SYSTEM.VAL(TglGetUniformOffsetEXT, wglGetProcAddress('glGetUniformOffsetEXT'));
END Read_GL_EXT_bindable_uniform;

PROCEDURE Read_GL_EXT_draw_buffers2;
BEGIN
     glColorMaskIndexedEXT := SYSTEM.VAL(TglColorMaskIndexedEXT, wglGetProcAddress('glColorMaskIndexedEXT'));
     glGetBooleanIndexedvEXT := SYSTEM.VAL(TglGetBooleanIndexedvEXT, wglGetProcAddress('glGetBooleanIndexedvEXT'));
     glGetIntegerIndexedvEXT := SYSTEM.VAL(TglGetIntegerIndexedvEXT, wglGetProcAddress('glGetIntegerIndexedvEXT'));
     glEnableIndexedEXT := SYSTEM.VAL(TglEnableIndexedEXT, wglGetProcAddress('glEnableIndexedEXT'));
     glDisableIndexedEXT := SYSTEM.VAL(TglDisableIndexedEXT, wglGetProcAddress('glDisableIndexedEXT'));
     glIsEnabledIndexedEXT := SYSTEM.VAL(TglIsEnabledIndexedEXT, wglGetProcAddress('glIsEnabledIndexedEXT'));
END Read_GL_EXT_draw_buffers2;

PROCEDURE Read_GL_EXT_draw_instanced;
BEGIN
     glDrawArraysInstancedEXT := SYSTEM.VAL(TglDrawArraysInstancedEXT, wglGetProcAddress('glDrawArraysInstancedEXT'));
     glDrawElementsInstancedEXT := SYSTEM.VAL(TglDrawElementsInstancedEXT, wglGetProcAddress('glDrawElementsInstancedEXT'));
END Read_GL_EXT_draw_instanced;

PROCEDURE Read_GL_EXT_geometry_shader4;
BEGIN
     glProgramParameteriEXT := SYSTEM.VAL(TglProgramParameteriEXT, wglGetProcAddress('glProgramParameteriEXT'));
     glFramebufferTextureEXT := SYSTEM.VAL(TglFramebufferTextureEXT, wglGetProcAddress('glFramebufferTextureEXT'));
     glFramebufferTextureFaceEXT := SYSTEM.VAL(TglFramebufferTextureFaceEXT, wglGetProcAddress('glFramebufferTextureFaceEXT'));
END Read_GL_EXT_geometry_shader4;

PROCEDURE Read_GL_EXT_gpu_shader4;
BEGIN
     glVertexAttribI1iEXT := SYSTEM.VAL(TglVertexAttribI1iEXT, wglGetProcAddress('glVertexAttribI1iEXT'));
     glVertexAttribI2iEXT := SYSTEM.VAL(TglVertexAttribI2iEXT, wglGetProcAddress('glVertexAttribI2iEXT'));
     glVertexAttribI3iEXT := SYSTEM.VAL(TglVertexAttribI3iEXT, wglGetProcAddress('glVertexAttribI3iEXT'));
     glVertexAttribI4iEXT := SYSTEM.VAL(TglVertexAttribI4iEXT, wglGetProcAddress('glVertexAttribI4iEXT'));
     glVertexAttribI1uiEXT := SYSTEM.VAL(TglVertexAttribI1uiEXT, wglGetProcAddress('glVertexAttribI1uiEXT'));
     glVertexAttribI2uiEXT := SYSTEM.VAL(TglVertexAttribI2uiEXT, wglGetProcAddress('glVertexAttribI2uiEXT'));
     glVertexAttribI3uiEXT := SYSTEM.VAL(TglVertexAttribI3uiEXT, wglGetProcAddress('glVertexAttribI3uiEXT'));
     glVertexAttribI4uiEXT := SYSTEM.VAL(TglVertexAttribI4uiEXT, wglGetProcAddress('glVertexAttribI4uiEXT'));
     glVertexAttribI1ivEXT := SYSTEM.VAL(TglVertexAttribI1ivEXT, wglGetProcAddress('glVertexAttribI1ivEXT'));
     glVertexAttribI2ivEXT := SYSTEM.VAL(TglVertexAttribI2ivEXT, wglGetProcAddress('glVertexAttribI2ivEXT'));
     glVertexAttribI3ivEXT := SYSTEM.VAL(TglVertexAttribI3ivEXT, wglGetProcAddress('glVertexAttribI3ivEXT'));
     glVertexAttribI4ivEXT := SYSTEM.VAL(TglVertexAttribI4ivEXT, wglGetProcAddress('glVertexAttribI4ivEXT'));
     glVertexAttribI1uivEXT := SYSTEM.VAL(TglVertexAttribI1uivEXT, wglGetProcAddress('glVertexAttribI1uivEXT'));
     glVertexAttribI2uivEXT := SYSTEM.VAL(TglVertexAttribI2uivEXT, wglGetProcAddress('glVertexAttribI2uivEXT'));
     glVertexAttribI3uivEXT := SYSTEM.VAL(TglVertexAttribI3uivEXT, wglGetProcAddress('glVertexAttribI3uivEXT'));
     glVertexAttribI4uivEXT := SYSTEM.VAL(TglVertexAttribI4uivEXT, wglGetProcAddress('glVertexAttribI4uivEXT'));
     glVertexAttribI4bvEXT := SYSTEM.VAL(TglVertexAttribI4bvEXT, wglGetProcAddress('glVertexAttribI4bvEXT'));
     glVertexAttribI4svEXT := SYSTEM.VAL(TglVertexAttribI4svEXT, wglGetProcAddress('glVertexAttribI4svEXT'));
     glVertexAttribI4ubvEXT := SYSTEM.VAL(TglVertexAttribI4ubvEXT, wglGetProcAddress('glVertexAttribI4ubvEXT'));
     glVertexAttribI4usvEXT := SYSTEM.VAL(TglVertexAttribI4usvEXT, wglGetProcAddress('glVertexAttribI4usvEXT'));
     glVertexAttribIPointerEXT := SYSTEM.VAL(TglVertexAttribIPointerEXT, wglGetProcAddress('glVertexAttribIPointerEXT'));
     glGetVertexAttribIivEXT := SYSTEM.VAL(TglGetVertexAttribIivEXT, wglGetProcAddress('glGetVertexAttribIivEXT'));
     glGetVertexAttribIuivEXT := SYSTEM.VAL(TglGetVertexAttribIuivEXT, wglGetProcAddress('glGetVertexAttribIuivEXT'));
     glUniform1uiEXT := SYSTEM.VAL(TglUniform1uiEXT, wglGetProcAddress('glUniform1uiEXT'));
     glUniform2uiEXT := SYSTEM.VAL(TglUniform2uiEXT, wglGetProcAddress('glUniform2uiEXT'));
     glUniform3uiEXT := SYSTEM.VAL(TglUniform3uiEXT, wglGetProcAddress('glUniform3uiEXT'));
     glUniform4uiEXT := SYSTEM.VAL(TglUniform4uiEXT, wglGetProcAddress('glUniform4uiEXT'));
     glUniform1uivEXT := SYSTEM.VAL(TglUniform1uivEXT, wglGetProcAddress('glUniform1uivEXT'));
     glUniform2uivEXT := SYSTEM.VAL(TglUniform2uivEXT, wglGetProcAddress('glUniform2uivEXT'));
     glUniform3uivEXT := SYSTEM.VAL(TglUniform3uivEXT, wglGetProcAddress('glUniform3uivEXT'));
     glUniform4uivEXT := SYSTEM.VAL(TglUniform4uivEXT, wglGetProcAddress('glUniform4uivEXT'));
     glGetUniformuivEXT := SYSTEM.VAL(TglGetUniformuivEXT, wglGetProcAddress('glGetUniformuivEXT'));
     glBindFragDataLocationEXT := SYSTEM.VAL(TglBindFragDataLocationEXT, wglGetProcAddress('glBindFragDataLocationEXT'));
     glGetFragDataLocationEXT := SYSTEM.VAL(TglGetFragDataLocationEXT, wglGetProcAddress('glGetFragDataLocationEXT'));
END Read_GL_EXT_gpu_shader4;

PROCEDURE Read_GL_EXT_texture_array;
BEGIN
     glFramebufferTextureLayerEXT := SYSTEM.VAL(TglFramebufferTextureLayerEXT, wglGetProcAddress('glFramebufferTextureLayerEXT'));
END Read_GL_EXT_texture_array;

PROCEDURE Read_GL_EXT_texture_buffer_object;
BEGIN
     glTexBufferEXT := SYSTEM.VAL(TglTexBufferEXT, wglGetProcAddress('glTexBufferEXT'));
END Read_GL_EXT_texture_buffer_object;

PROCEDURE Read_GL_EXT_texture_integer;
BEGIN
     glClearColorIiEXT := SYSTEM.VAL(TglClearColorIiEXT, wglGetProcAddress('glClearColorIiEXT'));
     glClearColorIuiEXT := SYSTEM.VAL(TglClearColorIuiEXT, wglGetProcAddress('glClearColorIuiEXT'));
     glTexParameterIivEXT := SYSTEM.VAL(TglTexParameterIivEXT, wglGetProcAddress('glTexParameterIivEXT'));
     glTexParameterIuivEXT := SYSTEM.VAL(TglTexParameterIuivEXT, wglGetProcAddress('glTexParameterIuivEXT'));
     glGetTexParameterIivEXT := SYSTEM.VAL(TglGetTexParameterIivEXT, wglGetProcAddress('glGetTexParameterIivEXT'));
     glGetTexParameterIiuvEXT := SYSTEM.VAL(TglGetTexParameterIiuvEXT, wglGetProcAddress('glGetTexParameterIiuvEXT'));
END Read_GL_EXT_texture_integer;

PROCEDURE Read_GL_EXT_transform_feedback;
BEGIN
     glBeginTransformFeedbackEXT := SYSTEM.VAL(TglBeginTransformFeedbackEXT, wglGetProcAddress('glBeginTransformFeedbackEXT'));
     glEndTransformFeedbackEXT := SYSTEM.VAL(TglEndTransformFeedbackEXT, wglGetProcAddress('glEndTransformFeedbackEXT'));
     glBindBufferRangeEXT := SYSTEM.VAL(TglBindBufferRangeEXT, wglGetProcAddress('glBindBufferRangeEXT'));
     glBindBufferOffsetEXT := SYSTEM.VAL(TglBindBufferOffsetEXT, wglGetProcAddress('glBindBufferOffsetEXT'));
     glBindBufferBaseEXT := SYSTEM.VAL(TglBindBufferBaseEXT, wglGetProcAddress('glBindBufferBaseEXT'));
     glTransformFeedbackVaryingsEXT := SYSTEM.VAL(TglTransformFeedbackVaryingsEXT, wglGetProcAddress('glTransformFeedbackVaryingsEXT'));
     glGetTransformFeedbackVaryingEXT := SYSTEM.VAL(TglGetTransformFeedbackVaryingEXT, wglGetProcAddress('glGetTransformFeedbackVaryingEXT'));
END Read_GL_EXT_transform_feedback;

PROCEDURE Read_GL_EXT_direct_state_access;
BEGIN
     glClientAttribDefaultEXT := SYSTEM.VAL(TglClientAttribDefaultEXT, wglGetProcAddress('glClientAttribDefaultEXT'));
     glPushClientAttribDefaultEXT := SYSTEM.VAL(TglPushClientAttribDefaultEXT, wglGetProcAddress('glPushClientAttribDefaultEXT'));
     glMatrixLoadfEXT := SYSTEM.VAL(TglMatrixLoadfEXT, wglGetProcAddress('glMatrixLoadfEXT'));
     glMatrixLoaddEXT := SYSTEM.VAL(TglMatrixLoaddEXT, wglGetProcAddress('glMatrixLoaddEXT'));
     glMatrixMultfEXT := SYSTEM.VAL(TglMatrixMultfEXT, wglGetProcAddress('glMatrixMultfEXT'));
     glMatrixMultdEXT := SYSTEM.VAL(TglMatrixMultdEXT, wglGetProcAddress('glMatrixMultdEXT'));
     glMatrixLoadIdentityEXT := SYSTEM.VAL(TglMatrixLoadIdentityEXT, wglGetProcAddress('glMatrixLoadIdentityEXT'));
     glMatrixRotatefEXT := SYSTEM.VAL(TglMatrixRotatefEXT, wglGetProcAddress('glMatrixRotatefEXT'));
     glMatrixRotatedEXT := SYSTEM.VAL(TglMatrixRotatedEXT, wglGetProcAddress('glMatrixRotatedEXT'));
     glMatrixScalefEXT := SYSTEM.VAL(TglMatrixScalefEXT, wglGetProcAddress('glMatrixScalefEXT'));
     glMatrixScaledEXT := SYSTEM.VAL(TglMatrixScaledEXT, wglGetProcAddress('glMatrixScaledEXT'));
     glMatrixTranslatefEXT := SYSTEM.VAL(TglMatrixTranslatefEXT, wglGetProcAddress('glMatrixTranslatefEXT'));
     glMatrixTranslatedEXT := SYSTEM.VAL(TglMatrixTranslatedEXT, wglGetProcAddress('glMatrixTranslatedEXT'));
     glMatrixFrustumEXT := SYSTEM.VAL(TglMatrixFrustumEXT, wglGetProcAddress('glMatrixFrustumEXT'));
     glMatrixOrthoEXT := SYSTEM.VAL(TglMatrixOrthoEXT, wglGetProcAddress('glMatrixOrthoEXT'));
     glMatrixPopEXT := SYSTEM.VAL(TglMatrixPopEXT, wglGetProcAddress('glMatrixPopEXT'));
     glMatrixPushEXT := SYSTEM.VAL(TglMatrixPushEXT, wglGetProcAddress('glMatrixPushEXT'));
     glMatrixLoadTransposefEXT := SYSTEM.VAL(TglMatrixLoadTransposefEXT, wglGetProcAddress('glMatrixLoadTransposefEXT'));
     glMatrixLoadTransposedEXT := SYSTEM.VAL(TglMatrixLoadTransposedEXT, wglGetProcAddress('glMatrixLoadTransposedEXT'));
     glMatrixMultTransposefEXT := SYSTEM.VAL(TglMatrixMultTransposefEXT, wglGetProcAddress('glMatrixMultTransposefEXT'));
     glMatrixMultTransposedEXT := SYSTEM.VAL(TglMatrixMultTransposedEXT, wglGetProcAddress('glMatrixMultTransposedEXT'));
     glTextureParameterfEXT := SYSTEM.VAL(TglTextureParameterfEXT, wglGetProcAddress('glTextureParameterfEXT'));
     glTextureParameterfvEXT := SYSTEM.VAL(TglTextureParameterfvEXT, wglGetProcAddress('glTextureParameterfvEXT'));
     glTextureParameteriEXT := SYSTEM.VAL(TglTextureParameteriEXT, wglGetProcAddress('glTextureParameteriEXT'));
     glTextureParameterivEXT := SYSTEM.VAL(TglTextureParameterivEXT, wglGetProcAddress('glTextureParameterivEXT'));
     glTextureImage1DEXT := SYSTEM.VAL(TglTextureImage1DEXT, wglGetProcAddress('glTextureImage1DEXT'));
     glTextureImage2DEXT := SYSTEM.VAL(TglTextureImage2DEXT, wglGetProcAddress('glTextureImage2DEXT'));
     glTextureSubImage1DEXT := SYSTEM.VAL(TglTextureSubImage1DEXT, wglGetProcAddress('glTextureSubImage1DEXT'));
     glTextureSubImage2DEXT := SYSTEM.VAL(TglTextureSubImage2DEXT, wglGetProcAddress('glTextureSubImage2DEXT'));
     glCopyTextureImage1DEXT := SYSTEM.VAL(TglCopyTextureImage1DEXT, wglGetProcAddress('glCopyTextureImage1DEXT'));
     glCopyTextureImage2DEXT := SYSTEM.VAL(TglCopyTextureImage2DEXT, wglGetProcAddress('glCopyTextureImage2DEXT'));
     glCopyTextureSubImage1DEXT := SYSTEM.VAL(TglCopyTextureSubImage1DEXT, wglGetProcAddress('glCopyTextureSubImage1DEXT'));
     glCopyTextureSubImage2DEXT := SYSTEM.VAL(TglCopyTextureSubImage2DEXT, wglGetProcAddress('glCopyTextureSubImage2DEXT'));
     glGetTextureImageEXT := SYSTEM.VAL(TglGetTextureImageEXT, wglGetProcAddress('glGetTextureImageEXT'));
     glGetTextureParameterfvEXT := SYSTEM.VAL(TglGetTextureParameterfvEXT, wglGetProcAddress('glGetTextureParameterfvEXT'));
     glGetTextureParameterivEXT := SYSTEM.VAL(TglGetTextureParameterivEXT, wglGetProcAddress('glGetTextureParameterivEXT'));
     glGetTextureLevelParameterfvEXT := SYSTEM.VAL(TglGetTextureLevelParameterfvEXT, wglGetProcAddress('glGetTextureLevelParameterfvEXT'));
     glGetTextureLevelParameterivEXT := SYSTEM.VAL(TglGetTextureLevelParameterivEXT, wglGetProcAddress('glGetTextureLevelParameterivEXT'));
     glTextureImage3DEXT := SYSTEM.VAL(TglTextureImage3DEXT, wglGetProcAddress('glTextureImage3DEXT'));
     glTextureSubImage3DEXT := SYSTEM.VAL(TglTextureSubImage3DEXT, wglGetProcAddress('glTextureSubImage3DEXT'));
     glCopyTextureSubImage3DEXT := SYSTEM.VAL(TglCopyTextureSubImage3DEXT, wglGetProcAddress('glCopyTextureSubImage3DEXT'));
     glMultiTexParameterfEXT := SYSTEM.VAL(TglMultiTexParameterfEXT, wglGetProcAddress('glMultiTexParameterfEXT'));
     glMultiTexParameterfvEXT := SYSTEM.VAL(TglMultiTexParameterfvEXT, wglGetProcAddress('glMultiTexParameterfvEXT'));
     glMultiTexParameteriEXT := SYSTEM.VAL(TglMultiTexParameteriEXT, wglGetProcAddress('glMultiTexParameteriEXT'));
     glMultiTexParameterivEXT := SYSTEM.VAL(TglMultiTexParameterivEXT, wglGetProcAddress('glMultiTexParameterivEXT'));
     glMultiTexImage1DEXT := SYSTEM.VAL(TglMultiTexImage1DEXT, wglGetProcAddress('glMultiTexImage1DEXT'));
     glMultiTexImage2DEXT := SYSTEM.VAL(TglMultiTexImage2DEXT, wglGetProcAddress('glMultiTexImage2DEXT'));
     glMultiTexSubImage1DEXT := SYSTEM.VAL(TglMultiTexSubImage1DEXT, wglGetProcAddress('glMultiTexSubImage1DEXT'));
     glMultiTexSubImage2DEXT := SYSTEM.VAL(TglMultiTexSubImage2DEXT, wglGetProcAddress('glMultiTexSubImage2DEXT'));
     glCopyMultiTexImage1DEXT := SYSTEM.VAL(TglCopyMultiTexImage1DEXT, wglGetProcAddress('glCopyMultiTexImage1DEXT'));
     glCopyMultiTexImage2DEXT := SYSTEM.VAL(TglCopyMultiTexImage2DEXT, wglGetProcAddress('glCopyMultiTexImage2DEXT'));
     glCopyMultiTexSubImage1DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage1DEXT, wglGetProcAddress('glCopyMultiTexSubImage1DEXT'));
     glCopyMultiTexSubImage2DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage2DEXT, wglGetProcAddress('glCopyMultiTexSubImage2DEXT'));
     glGetMultiTexImageEXT := SYSTEM.VAL(TglGetMultiTexImageEXT, wglGetProcAddress('glGetMultiTexImageEXT'));
     glGetMultiTexParameterfvEXT := SYSTEM.VAL(TglGetMultiTexParameterfvEXT, wglGetProcAddress('glGetMultiTexParameterfvEXT'));
     glGetMultiTexParameterivEXT := SYSTEM.VAL(TglGetMultiTexParameterivEXT, wglGetProcAddress('glGetMultiTexParameterivEXT'));
     glGetMultiTexLevelParameterfvEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterfvEXT, wglGetProcAddress('glGetMultiTexLevelParameterfvEXT'));
     glGetMultiTexLevelParameterivEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterivEXT, wglGetProcAddress('glGetMultiTexLevelParameterivEXT'));
     glMultiTexImage3DEXT := SYSTEM.VAL(TglMultiTexImage3DEXT, wglGetProcAddress('glMultiTexImage3DEXT'));
     glMultiTexSubImage3DEXT := SYSTEM.VAL(TglMultiTexSubImage3DEXT, wglGetProcAddress('glMultiTexSubImage3DEXT'));
     glCopyMultiTexSubImage3DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage3DEXT, wglGetProcAddress('glCopyMultiTexSubImage3DEXT'));
     glBindMultiTextureEXT := SYSTEM.VAL(TglBindMultiTextureEXT, wglGetProcAddress('glBindMultiTextureEXT'));
     glEnableClientStateIndexedEXT := SYSTEM.VAL(TglEnableClientStateIndexedEXT, wglGetProcAddress('glEnableClientStateIndexedEXT'));
     glDisableClientStateIndexedEXT := SYSTEM.VAL(TglDisableClientStateIndexedEXT, wglGetProcAddress('glDisableClientStateIndexedEXT'));
     glMultiTexCoordPointerEXT := SYSTEM.VAL(TglMultiTexCoordPointerEXT, wglGetProcAddress('glMultiTexCoordPointerEXT'));
     glMultiTexEnvfEXT := SYSTEM.VAL(TglMultiTexEnvfEXT, wglGetProcAddress('glMultiTexEnvfEXT'));
     glMultiTexEnvfvEXT := SYSTEM.VAL(TglMultiTexEnvfvEXT, wglGetProcAddress('glMultiTexEnvfvEXT'));
     glMultiTexEnviEXT := SYSTEM.VAL(TglMultiTexEnviEXT, wglGetProcAddress('glMultiTexEnviEXT'));
     glMultiTexEnvivEXT := SYSTEM.VAL(TglMultiTexEnvivEXT, wglGetProcAddress('glMultiTexEnvivEXT'));
     glMultiTexGendEXT := SYSTEM.VAL(TglMultiTexGendEXT, wglGetProcAddress('glMultiTexGendEXT'));
     glMultiTexGendvEXT := SYSTEM.VAL(TglMultiTexGendvEXT, wglGetProcAddress('glMultiTexGendvEXT'));
     glMultiTexGenfEXT := SYSTEM.VAL(TglMultiTexGenfEXT, wglGetProcAddress('glMultiTexGenfEXT'));
     glMultiTexGenfvEXT := SYSTEM.VAL(TglMultiTexGenfvEXT, wglGetProcAddress('glMultiTexGenfvEXT'));
     glMultiTexGeniEXT := SYSTEM.VAL(TglMultiTexGeniEXT, wglGetProcAddress('glMultiTexGeniEXT'));
     glMultiTexGenivEXT := SYSTEM.VAL(TglMultiTexGenivEXT, wglGetProcAddress('glMultiTexGenivEXT'));
     glGetMultiTexEnvfvEXT := SYSTEM.VAL(TglGetMultiTexEnvfvEXT, wglGetProcAddress('glGetMultiTexEnvfvEXT'));
     glGetMultiTexEnvivEXT := SYSTEM.VAL(TglGetMultiTexEnvivEXT, wglGetProcAddress('glGetMultiTexEnvivEXT'));
     glGetMultiTexGendvEXT := SYSTEM.VAL(TglGetMultiTexGendvEXT, wglGetProcAddress('glGetMultiTexGendvEXT'));
     glGetMultiTexGenfvEXT := SYSTEM.VAL(TglGetMultiTexGenfvEXT, wglGetProcAddress('glGetMultiTexGenfvEXT'));
     glGetMultiTexGenivEXT := SYSTEM.VAL(TglGetMultiTexGenivEXT, wglGetProcAddress('glGetMultiTexGenivEXT'));
     glGetFloatIndexedvEXT := SYSTEM.VAL(TglGetFloatIndexedvEXT, wglGetProcAddress('glGetFloatIndexedvEXT'));
     glGetDoubleIndexedvEXT := SYSTEM.VAL(TglGetDoubleIndexedvEXT, wglGetProcAddress('glGetDoubleIndexedvEXT'));
     glGetPointerIndexedvEXT := SYSTEM.VAL(TglGetPointerIndexedvEXT, wglGetProcAddress('glGetPointerIndexedvEXT'));
     glCompressedTextureImage3DEXT := SYSTEM.VAL(TglCompressedTextureImage3DEXT, wglGetProcAddress('glCompressedTextureImage3DEXT'));
     glCompressedTextureImage2DEXT := SYSTEM.VAL(TglCompressedTextureImage2DEXT, wglGetProcAddress('glCompressedTextureImage2DEXT'));
     glCompressedTextureImage1DEXT := SYSTEM.VAL(TglCompressedTextureImage1DEXT, wglGetProcAddress('glCompressedTextureImage1DEXT'));
     glCompressedTextureSubImage3DEXT := SYSTEM.VAL(TglCompressedTextureSubImage3DEXT, wglGetProcAddress('glCompressedTextureSubImage3DEXT'));
     glCompressedTextureSubImage2DEXT := SYSTEM.VAL(TglCompressedTextureSubImage2DEXT, wglGetProcAddress('glCompressedTextureSubImage2DEXT'));
     glCompressedTextureSubImage1DEXT := SYSTEM.VAL(TglCompressedTextureSubImage1DEXT, wglGetProcAddress('glCompressedTextureSubImage1DEXT'));
     glGetCompressedTextureImageEXT := SYSTEM.VAL(TglGetCompressedTextureImageEXT, wglGetProcAddress('glGetCompressedTextureImageEXT'));
     glCompressedMultiTexImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexImage3DEXT, wglGetProcAddress('glCompressedMultiTexImage3DEXT'));
     glCompressedMultiTexImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexImage2DEXT, wglGetProcAddress('glCompressedMultiTexImage2DEXT'));
     glCompressedMultiTexImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexImage1DEXT, wglGetProcAddress('glCompressedMultiTexImage1DEXT'));
     glCompressedMultiTexSubImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage3DEXT, wglGetProcAddress('glCompressedMultiTexSubImage3DEXT'));
     glCompressedMultiTexSubImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage2DEXT, wglGetProcAddress('glCompressedMultiTexSubImage2DEXT'));
     glCompressedMultiTexSubImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage1DEXT, wglGetProcAddress('glCompressedMultiTexSubImage1DEXT'));
     glGetCompressedMultiTexImageEXT := SYSTEM.VAL(TglGetCompressedMultiTexImageEXT, wglGetProcAddress('glGetCompressedMultiTexImageEXT'));
     glNamedProgramStringEXT := SYSTEM.VAL(TglNamedProgramStringEXT, wglGetProcAddress('glNamedProgramStringEXT'));
     glNamedProgramLocalParameter4dEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dEXT, wglGetProcAddress('glNamedProgramLocalParameter4dEXT'));
     glNamedProgramLocalParameter4dvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dvEXT, wglGetProcAddress('glNamedProgramLocalParameter4dvEXT'));
     glNamedProgramLocalParameter4fEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fEXT, wglGetProcAddress('glNamedProgramLocalParameter4fEXT'));
     glNamedProgramLocalParameter4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fvEXT, wglGetProcAddress('glNamedProgramLocalParameter4fvEXT'));
     glGetNamedProgramLocalParameterdvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterdvEXT, wglGetProcAddress('glGetNamedProgramLocalParameterdvEXT'));
     glGetNamedProgramLocalParameterfvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterfvEXT, wglGetProcAddress('glGetNamedProgramLocalParameterfvEXT'));
     glGetNamedProgramivEXT := SYSTEM.VAL(TglGetNamedProgramivEXT, wglGetProcAddress('glGetNamedProgramivEXT'));
     glGetNamedProgramStringEXT := SYSTEM.VAL(TglGetNamedProgramStringEXT, wglGetProcAddress('glGetNamedProgramStringEXT'));
     glNamedProgramLocalParameters4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameters4fvEXT, wglGetProcAddress('glNamedProgramLocalParameters4fvEXT'));
     glNamedProgramLocalParameterI4iEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4iEXT, wglGetProcAddress('glNamedProgramLocalParameterI4iEXT'));
     glNamedProgramLocalParameterI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4ivEXT, wglGetProcAddress('glNamedProgramLocalParameterI4ivEXT'));
     glNamedProgramLocalParametersI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4ivEXT, wglGetProcAddress('glNamedProgramLocalParametersI4ivEXT'));
     glNamedProgramLocalParameterI4uiEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uiEXT, wglGetProcAddress('glNamedProgramLocalParameterI4uiEXT'));
     glNamedProgramLocalParameterI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uivEXT, wglGetProcAddress('glNamedProgramLocalParameterI4uivEXT'));
     glNamedProgramLocalParametersI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4uivEXT, wglGetProcAddress('glNamedProgramLocalParametersI4uivEXT'));
     glGetNamedProgramLocalParameterIivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIivEXT, wglGetProcAddress('glGetNamedProgramLocalParameterIivEXT'));
     glGetNamedProgramLocalParameterIuivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIuivEXT, wglGetProcAddress('glGetNamedProgramLocalParameterIuivEXT'));
     glTextureParameterIivEXT := SYSTEM.VAL(TglTextureParameterIivEXT, wglGetProcAddress('glTextureParameterIivEXT'));
     glTextureParameterIuivEXT := SYSTEM.VAL(TglTextureParameterIuivEXT, wglGetProcAddress('glTextureParameterIuivEXT'));
     glGetTextureParameterIivEXT := SYSTEM.VAL(TglGetTextureParameterIivEXT, wglGetProcAddress('glGetTextureParameterIivEXT'));
     glGetTextureParameterIuivEXT := SYSTEM.VAL(TglGetTextureParameterIuivEXT, wglGetProcAddress('glGetTextureParameterIuivEXT'));
     glMultiTexParameterIivEXT := SYSTEM.VAL(TglMultiTexParameterIivEXT, wglGetProcAddress('glMultiTexParameterIivEXT'));
     glMultiTexParameterIuivEXT := SYSTEM.VAL(TglMultiTexParameterIuivEXT, wglGetProcAddress('glMultiTexParameterIuivEXT'));
     glGetMultiTexParameterIivEXT := SYSTEM.VAL(TglGetMultiTexParameterIivEXT, wglGetProcAddress('glGetMultiTexParameterIivEXT'));
     glGetMultiTexParameterIuivEXT := SYSTEM.VAL(TglGetMultiTexParameterIuivEXT, wglGetProcAddress('glGetMultiTexParameterIuivEXT'));
     glProgramUniform1fEXT := SYSTEM.VAL(TglProgramUniform1fEXT, wglGetProcAddress('glProgramUniform1fEXT'));
     glProgramUniform2fEXT := SYSTEM.VAL(TglProgramUniform2fEXT, wglGetProcAddress('glProgramUniform2fEXT'));
     glProgramUniform3fEXT := SYSTEM.VAL(TglProgramUniform3fEXT, wglGetProcAddress('glProgramUniform3fEXT'));
     glProgramUniform4fEXT := SYSTEM.VAL(TglProgramUniform4fEXT, wglGetProcAddress('glProgramUniform4fEXT'));
     glProgramUniform1iEXT := SYSTEM.VAL(TglProgramUniform1iEXT, wglGetProcAddress('glProgramUniform1iEXT'));
     glProgramUniform2iEXT := SYSTEM.VAL(TglProgramUniform2iEXT, wglGetProcAddress('glProgramUniform2iEXT'));
     glProgramUniform3iEXT := SYSTEM.VAL(TglProgramUniform3iEXT, wglGetProcAddress('glProgramUniform3iEXT'));
     glProgramUniform4iEXT := SYSTEM.VAL(TglProgramUniform4iEXT, wglGetProcAddress('glProgramUniform4iEXT'));
     glProgramUniform1fvEXT := SYSTEM.VAL(TglProgramUniform1fvEXT, wglGetProcAddress('glProgramUniform1fvEXT'));
     glProgramUniform2fvEXT := SYSTEM.VAL(TglProgramUniform2fvEXT, wglGetProcAddress('glProgramUniform2fvEXT'));
     glProgramUniform3fvEXT := SYSTEM.VAL(TglProgramUniform3fvEXT, wglGetProcAddress('glProgramUniform3fvEXT'));
     glProgramUniform4fvEXT := SYSTEM.VAL(TglProgramUniform4fvEXT, wglGetProcAddress('glProgramUniform4fvEXT'));
     glProgramUniform1ivEXT := SYSTEM.VAL(TglProgramUniform1ivEXT, wglGetProcAddress('glProgramUniform1ivEXT'));
     glProgramUniform2ivEXT := SYSTEM.VAL(TglProgramUniform2ivEXT, wglGetProcAddress('glProgramUniform2ivEXT'));
     glProgramUniform3ivEXT := SYSTEM.VAL(TglProgramUniform3ivEXT, wglGetProcAddress('glProgramUniform3ivEXT'));
     glProgramUniform4ivEXT := SYSTEM.VAL(TglProgramUniform4ivEXT, wglGetProcAddress('glProgramUniform4ivEXT'));
     glProgramUniformMatrix2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2fvEXT, wglGetProcAddress('glProgramUniformMatrix2fvEXT'));
     glProgramUniformMatrix3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3fvEXT, wglGetProcAddress('glProgramUniformMatrix3fvEXT'));
     glProgramUniformMatrix4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4fvEXT, wglGetProcAddress('glProgramUniformMatrix4fvEXT'));
     glProgramUniformMatrix2x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3fvEXT, wglGetProcAddress('glProgramUniformMatrix2x3fvEXT'));
     glProgramUniformMatrix3x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2fvEXT, wglGetProcAddress('glProgramUniformMatrix3x2fvEXT'));
     glProgramUniformMatrix2x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4fvEXT, wglGetProcAddress('glProgramUniformMatrix2x4fvEXT'));
     glProgramUniformMatrix4x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2fvEXT, wglGetProcAddress('glProgramUniformMatrix4x2fvEXT'));
     glProgramUniformMatrix3x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4fvEXT, wglGetProcAddress('glProgramUniformMatrix3x4fvEXT'));
     glProgramUniformMatrix4x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3fvEXT, wglGetProcAddress('glProgramUniformMatrix4x3fvEXT'));
     glProgramUniform1uiEXT := SYSTEM.VAL(TglProgramUniform1uiEXT, wglGetProcAddress('glProgramUniform1uiEXT'));
     glProgramUniform2uiEXT := SYSTEM.VAL(TglProgramUniform2uiEXT, wglGetProcAddress('glProgramUniform2uiEXT'));
     glProgramUniform3uiEXT := SYSTEM.VAL(TglProgramUniform3uiEXT, wglGetProcAddress('glProgramUniform3uiEXT'));
     glProgramUniform4uiEXT := SYSTEM.VAL(TglProgramUniform4uiEXT, wglGetProcAddress('glProgramUniform4uiEXT'));
     glProgramUniform1uivEXT := SYSTEM.VAL(TglProgramUniform1uivEXT, wglGetProcAddress('glProgramUniform1uivEXT'));
     glProgramUniform2uivEXT := SYSTEM.VAL(TglProgramUniform2uivEXT, wglGetProcAddress('glProgramUniform2uivEXT'));
     glProgramUniform3uivEXT := SYSTEM.VAL(TglProgramUniform3uivEXT, wglGetProcAddress('glProgramUniform3uivEXT'));
     glProgramUniform4uivEXT := SYSTEM.VAL(TglProgramUniform4uivEXT, wglGetProcAddress('glProgramUniform4uivEXT'));
     glNamedBufferDataEXT := SYSTEM.VAL(TglNamedBufferDataEXT, wglGetProcAddress('glNamedBufferDataEXT'));
     glNamedBufferSubDataEXT := SYSTEM.VAL(TglNamedBufferSubDataEXT, wglGetProcAddress('glNamedBufferSubDataEXT'));
     glMapNamedBufferEXT := SYSTEM.VAL(TglMapNamedBufferEXT, wglGetProcAddress('glMapNamedBufferEXT'));
     glUnmapNamedBufferEXT := SYSTEM.VAL(TglUnmapNamedBufferEXT, wglGetProcAddress('glUnmapNamedBufferEXT'));
     glMapNamedBufferRangeEXT := SYSTEM.VAL(TglMapNamedBufferRangeEXT, wglGetProcAddress('glMapNamedBufferRangeEXT'));
     glFlushMappedNamedBufferRangeEXT := SYSTEM.VAL(TglFlushMappedNamedBufferRangeEXT, wglGetProcAddress('glFlushMappedNamedBufferRangeEXT'));
     glNamedCopyBufferSubDataEXT := SYSTEM.VAL(TglNamedCopyBufferSubDataEXT, wglGetProcAddress('glNamedCopyBufferSubDataEXT'));
     glGetNamedBufferParameterivEXT := SYSTEM.VAL(TglGetNamedBufferParameterivEXT, wglGetProcAddress('glGetNamedBufferParameterivEXT'));
     glGetNamedBufferPointervEXT := SYSTEM.VAL(TglGetNamedBufferPointervEXT, wglGetProcAddress('glGetNamedBufferPointervEXT'));
     glGetNamedBufferSubDataEXT := SYSTEM.VAL(TglGetNamedBufferSubDataEXT, wglGetProcAddress('glGetNamedBufferSubDataEXT'));
     glTextureBufferEXT := SYSTEM.VAL(TglTextureBufferEXT, wglGetProcAddress('glTextureBufferEXT'));
     glMultiTexBufferEXT := SYSTEM.VAL(TglMultiTexBufferEXT, wglGetProcAddress('glMultiTexBufferEXT'));
     glNamedRenderbufferStorageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageEXT, wglGetProcAddress('glNamedRenderbufferStorageEXT'));
     glGetNamedRenderbufferParameterivEXT := SYSTEM.VAL(TglGetNamedRenderbufferParameterivEXT, wglGetProcAddress('glGetNamedRenderbufferParameterivEXT'));
     glCheckNamedFramebufferStatusEXT := SYSTEM.VAL(TglCheckNamedFramebufferStatusEXT, wglGetProcAddress('glCheckNamedFramebufferStatusEXT'));
     glNamedFramebufferTexture1DEXT := SYSTEM.VAL(TglNamedFramebufferTexture1DEXT, wglGetProcAddress('glNamedFramebufferTexture1DEXT'));
     glNamedFramebufferTexture2DEXT := SYSTEM.VAL(TglNamedFramebufferTexture2DEXT, wglGetProcAddress('glNamedFramebufferTexture2DEXT'));
     glNamedFramebufferTexture3DEXT := SYSTEM.VAL(TglNamedFramebufferTexture3DEXT, wglGetProcAddress('glNamedFramebufferTexture3DEXT'));
     glNamedFramebufferRenderbufferEXT := SYSTEM.VAL(TglNamedFramebufferRenderbufferEXT, wglGetProcAddress('glNamedFramebufferRenderbufferEXT'));
     glGetNamedFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetNamedFramebufferAttachmentParameterivEXT, wglGetProcAddress('glGetNamedFramebufferAttachmentParameterivEXT'));
     glGenerateTextureMipmapEXT := SYSTEM.VAL(TglGenerateTextureMipmapEXT, wglGetProcAddress('glGenerateTextureMipmapEXT'));
     glGenerateMultiTexMipmapEXT := SYSTEM.VAL(TglGenerateMultiTexMipmapEXT, wglGetProcAddress('glGenerateMultiTexMipmapEXT'));
     glFramebufferDrawBufferEXT := SYSTEM.VAL(TglFramebufferDrawBufferEXT, wglGetProcAddress('glFramebufferDrawBufferEXT'));
     glFramebufferDrawBuffersEXT := SYSTEM.VAL(TglFramebufferDrawBuffersEXT, wglGetProcAddress('glFramebufferDrawBuffersEXT'));
     glFramebufferReadBufferEXT := SYSTEM.VAL(TglFramebufferReadBufferEXT, wglGetProcAddress('glFramebufferReadBufferEXT'));
     glGetFramebufferParameterivEXT := SYSTEM.VAL(TglGetFramebufferParameterivEXT, wglGetProcAddress('glGetFramebufferParameterivEXT'));
     glNamedRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleEXT, wglGetProcAddress('glNamedRenderbufferStorageMultisampleEXT'));
     glNamedRenderbufferStorageMultisampleCoverageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleCoverageEXT, wglGetProcAddress('glNamedRenderbufferStorageMultisampleCoverageEXT'));
     glNamedFramebufferTextureEXT := SYSTEM.VAL(TglNamedFramebufferTextureEXT, wglGetProcAddress('glNamedFramebufferTextureEXT'));
     glNamedFramebufferTextureLayerEXT := SYSTEM.VAL(TglNamedFramebufferTextureLayerEXT, wglGetProcAddress('glNamedFramebufferTextureLayerEXT'));
     glNamedFramebufferTextureFaceEXT := SYSTEM.VAL(TglNamedFramebufferTextureFaceEXT, wglGetProcAddress('glNamedFramebufferTextureFaceEXT'));
     glTextureRenderbufferEXT := SYSTEM.VAL(TglTextureRenderbufferEXT, wglGetProcAddress('glTextureRenderbufferEXT'));
     glMultiTexRenderbufferEXT := SYSTEM.VAL(TglMultiTexRenderbufferEXT, wglGetProcAddress('glMultiTexRenderbufferEXT'));
     glProgramUniform1dEXT := SYSTEM.VAL(TglProgramUniform1dEXT, wglGetProcAddress('glProgramUniform1dEXT'));
     glProgramUniform2dEXT := SYSTEM.VAL(TglProgramUniform2dEXT, wglGetProcAddress('glProgramUniform2dEXT'));
     glProgramUniform3dEXT := SYSTEM.VAL(TglProgramUniform3dEXT, wglGetProcAddress('glProgramUniform3dEXT'));
     glProgramUniform4dEXT := SYSTEM.VAL(TglProgramUniform4dEXT, wglGetProcAddress('glProgramUniform4dEXT'));
     glProgramUniform1dvEXT := SYSTEM.VAL(TglProgramUniform1dvEXT, wglGetProcAddress('glProgramUniform1dvEXT'));
     glProgramUniform2dvEXT := SYSTEM.VAL(TglProgramUniform2dvEXT, wglGetProcAddress('glProgramUniform2dvEXT'));
     glProgramUniform3dvEXT := SYSTEM.VAL(TglProgramUniform3dvEXT, wglGetProcAddress('glProgramUniform3dvEXT'));
     glProgramUniform4dvEXT := SYSTEM.VAL(TglProgramUniform4dvEXT, wglGetProcAddress('glProgramUniform4dvEXT'));
     glProgramUniformMatrix2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2dvEXT, wglGetProcAddress('glProgramUniformMatrix2dvEXT'));
     glProgramUniformMatrix3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3dvEXT, wglGetProcAddress('glProgramUniformMatrix3dvEXT'));
     glProgramUniformMatrix4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4dvEXT, wglGetProcAddress('glProgramUniformMatrix4dvEXT'));
     glProgramUniformMatrix2x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3dvEXT, wglGetProcAddress('glProgramUniformMatrix2x3dvEXT'));
     glProgramUniformMatrix2x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4dvEXT, wglGetProcAddress('glProgramUniformMatrix2x4dvEXT'));
     glProgramUniformMatrix3x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2dvEXT, wglGetProcAddress('glProgramUniformMatrix3x2dvEXT'));
     glProgramUniformMatrix3x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4dvEXT, wglGetProcAddress('glProgramUniformMatrix3x4dvEXT'));
     glProgramUniformMatrix4x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2dvEXT, wglGetProcAddress('glProgramUniformMatrix4x2dvEXT'));
     glProgramUniformMatrix4x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3dvEXT, wglGetProcAddress('glProgramUniformMatrix4x3dvEXT'));
END Read_GL_EXT_direct_state_access;

PROCEDURE Read_GL_EXT_separate_shader_objects;
BEGIN
     glUseShaderProgramEXT := SYSTEM.VAL(TglUseShaderProgramEXT, wglGetProcAddress('glUseShaderProgramEXT'));
     glActiveProgramEXT := SYSTEM.VAL(TglActiveProgramEXT, wglGetProcAddress('glActiveProgramEXT'));
     glCreateShaderProgramEXT := SYSTEM.VAL(TglCreateShaderProgramEXT, wglGetProcAddress('glCreateShaderProgramEXT'));
END Read_GL_EXT_separate_shader_objects;

PROCEDURE Read_GL_EXT_shader_image_load_store;
BEGIN
     glBindImageTextureEXT := SYSTEM.VAL(TglBindImageTextureEXT, wglGetProcAddress('glBindImageTextureEXT'));
     glMemoryBarrierEXT := SYSTEM.VAL(TglMemoryBarrierEXT, wglGetProcAddress('glMemoryBarrierEXT'));
END Read_GL_EXT_shader_image_load_store;

PROCEDURE Read_GL_EXT_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1dEXT := SYSTEM.VAL(TglVertexAttribL1dEXT, wglGetProcAddress('glVertexAttribL1dEXT'));
     glVertexAttribL2dEXT := SYSTEM.VAL(TglVertexAttribL2dEXT, wglGetProcAddress('glVertexAttribL2dEXT'));
     glVertexAttribL3dEXT := SYSTEM.VAL(TglVertexAttribL3dEXT, wglGetProcAddress('glVertexAttribL3dEXT'));
     glVertexAttribL4dEXT := SYSTEM.VAL(TglVertexAttribL4dEXT, wglGetProcAddress('glVertexAttribL4dEXT'));
     glVertexAttribL1dvEXT := SYSTEM.VAL(TglVertexAttribL1dvEXT, wglGetProcAddress('glVertexAttribL1dvEXT'));
     glVertexAttribL2dvEXT := SYSTEM.VAL(TglVertexAttribL2dvEXT, wglGetProcAddress('glVertexAttribL2dvEXT'));
     glVertexAttribL3dvEXT := SYSTEM.VAL(TglVertexAttribL3dvEXT, wglGetProcAddress('glVertexAttribL3dvEXT'));
     glVertexAttribL4dvEXT := SYSTEM.VAL(TglVertexAttribL4dvEXT, wglGetProcAddress('glVertexAttribL4dvEXT'));
     glVertexAttribLPointerEXT := SYSTEM.VAL(TglVertexAttribLPointerEXT, wglGetProcAddress('glVertexAttribLPointerEXT'));
     glGetVertexAttribLdvEXT := SYSTEM.VAL(TglGetVertexAttribLdvEXT, wglGetProcAddress('glGetVertexAttribLdvEXT'));
     glVertexArrayVertexAttribLOffsetEXT := SYSTEM.VAL(TglVertexArrayVertexAttribLOffsetEXT, wglGetProcAddress('glVertexArrayVertexAttribLOffsetEXT'));
END Read_GL_EXT_vertex_attrib_64bit;

PROCEDURE Read_GL_HP_image_transform;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, wglGetProcAddress('glImageTransformParameteriHP'));
     glImageTransformParameterfHP := SYSTEM.VAL(TglImageTransformParameterfHP, wglGetProcAddress('glImageTransformParameterfHP'));
     glImageTransformParameterivHP := SYSTEM.VAL(TglImageTransformParameterivHP, wglGetProcAddress('glImageTransformParameterivHP'));
     glImageTransformParameterfvHP := SYSTEM.VAL(TglImageTransformParameterfvHP, wglGetProcAddress('glImageTransformParameterfvHP'));
     glGetImageTransformParameterivHP := SYSTEM.VAL(TglGetImageTransformParameterivHP, wglGetProcAddress('glGetImageTransformParameterivHP'));
     glGetImageTransformParameterfvHP := SYSTEM.VAL(TglGetImageTransformParameterfvHP, wglGetProcAddress('glGetImageTransformParameterfvHP'));
END Read_GL_HP_image_transform;

PROCEDURE Read_GL_IBM_multimode_draw_arrays;
BEGIN
(*     glMultiModeDrawArraysIBM := SYSTEM.VAL(TglMultiModeDrawArraysIBM, wglGetProcAddress('glMultiModeDrawArraysIBM'));
     glMultiModeDrawElementsIBM := SYSTEM.VAL(TglMultiModeDrawElementsIBM, wglGetProcAddress('glMultiModeDrawElementsIBM'));
*)
END Read_GL_IBM_multimode_draw_arrays;

PROCEDURE Read_GL_IBM_vertex_array_lists;
BEGIN
(*     glColorPointerListIBM := SYSTEM.VAL(TglColorPointerListIBM, wglGetProcAddress('glColorPointerListIBM'));
     glSecondaryColorPointerListIBM := SYSTEM.VAL(TglSecondaryColorPointerListIBM, wglGetProcAddress('glSecondaryColorPointerListIBM'));
     glEdgeFlagPointerListIBM := SYSTEM.VAL(TglEdgeFlagPointerListIBM, wglGetProcAddress('glEdgeFlagPointerListIBM'));
     glFogCoordPointerListIBM := SYSTEM.VAL(TglFogCoordPointerListIBM, wglGetProcAddress('glFogCoordPointerListIBM'));
     glIndexPointerListIBM := SYSTEM.VAL(TglIndexPointerListIBM, wglGetProcAddress('glIndexPointerListIBM'));
     glNormalPointerListIBM := SYSTEM.VAL(TglNormalPointerListIBM, wglGetProcAddress('glNormalPointerListIBM'));
     glTexCoordPointerListIBM := SYSTEM.VAL(TglTexCoordPointerListIBM, wglGetProcAddress('glTexCoordPointerListIBM'));
     glVertexPointerListIBM := SYSTEM.VAL(TglVertexPointerListIBM, wglGetProcAddress('glVertexPointerListIBM'));
*)
END Read_GL_IBM_vertex_array_lists;

PROCEDURE Read_GL_INGR_blend_func_separate;
BEGIN
(*     glBlendFuncSeparateINGR := SYSTEM.VAL(TglBlendFuncSeparateINGR, wglGetProcAddress('glBlendFuncSeparateINGR'));
*)
END Read_GL_INGR_blend_func_separate;

PROCEDURE Read_GL_INTEL_parallel_arrays;
BEGIN
(*     glVertexPointervINTEL := SYSTEM.VAL(TglVertexPointervINTEL, wglGetProcAddress('glVertexPointervINTEL'));
     glNormalPointervINTEL := SYSTEM.VAL(TglNormalPointervINTEL, wglGetProcAddress('glNormalPointervINTEL'));
     glColorPointervINTEL := SYSTEM.VAL(TglColorPointervINTEL, wglGetProcAddress('glColorPointervINTEL'));
     glTexCoordPointervINTEL := SYSTEM.VAL(TglTexCoordPointervINTEL, wglGetProcAddress('glTexCoordPointervINTEL'));
*)
END Read_GL_INTEL_parallel_arrays;

PROCEDURE Read_GL_MESA_resize_buffers;
BEGIN
     glResizeBuffersMESA := SYSTEM.VAL(TglResizeBuffersMESA, wglGetProcAddress('glResizeBuffersMESA'));
END Read_GL_MESA_resize_buffers;

PROCEDURE Read_GL_MESA_window_pos;
BEGIN
     glWindowPos2dMESA := SYSTEM.VAL(TglWindowPos2dMESA, wglGetProcAddress('glWindowPos2dMESA'));
     glWindowPos2dvMESA := SYSTEM.VAL(TglWindowPos2dvMESA, wglGetProcAddress('glWindowPos2dvMESA'));
     glWindowPos2fMESA := SYSTEM.VAL(TglWindowPos2fMESA, wglGetProcAddress('glWindowPos2fMESA'));
     glWindowPos2fvMESA := SYSTEM.VAL(TglWindowPos2fvMESA, wglGetProcAddress('glWindowPos2fvMESA'));
     glWindowPos2iMESA := SYSTEM.VAL(TglWindowPos2iMESA, wglGetProcAddress('glWindowPos2iMESA'));
     glWindowPos2ivMESA := SYSTEM.VAL(TglWindowPos2ivMESA, wglGetProcAddress('glWindowPos2ivMESA'));
     glWindowPos2sMESA := SYSTEM.VAL(TglWindowPos2sMESA, wglGetProcAddress('glWindowPos2sMESA'));
     glWindowPos2svMESA := SYSTEM.VAL(TglWindowPos2svMESA, wglGetProcAddress('glWindowPos2svMESA'));
     glWindowPos3dMESA := SYSTEM.VAL(TglWindowPos3dMESA, wglGetProcAddress('glWindowPos3dMESA'));
     glWindowPos3dvMESA := SYSTEM.VAL(TglWindowPos3dvMESA, wglGetProcAddress('glWindowPos3dvMESA'));
     glWindowPos3fMESA := SYSTEM.VAL(TglWindowPos3fMESA, wglGetProcAddress('glWindowPos3fMESA'));
     glWindowPos3fvMESA := SYSTEM.VAL(TglWindowPos3fvMESA, wglGetProcAddress('glWindowPos3fvMESA'));
     glWindowPos3iMESA := SYSTEM.VAL(TglWindowPos3iMESA, wglGetProcAddress('glWindowPos3iMESA'));
     glWindowPos3ivMESA := SYSTEM.VAL(TglWindowPos3ivMESA, wglGetProcAddress('glWindowPos3ivMESA'));
     glWindowPos3sMESA := SYSTEM.VAL(TglWindowPos3sMESA, wglGetProcAddress('glWindowPos3sMESA'));
     glWindowPos3svMESA := SYSTEM.VAL(TglWindowPos3svMESA, wglGetProcAddress('glWindowPos3svMESA'));
     glWindowPos4dMESA := SYSTEM.VAL(TglWindowPos4dMESA, wglGetProcAddress('glWindowPos4dMESA'));
     glWindowPos4dvMESA := SYSTEM.VAL(TglWindowPos4dvMESA, wglGetProcAddress('glWindowPos4dvMESA'));
     glWindowPos4fMESA := SYSTEM.VAL(TglWindowPos4fMESA, wglGetProcAddress('glWindowPos4fMESA'));
     glWindowPos4fvMESA := SYSTEM.VAL(TglWindowPos4fvMESA, wglGetProcAddress('glWindowPos4fvMESA'));
     glWindowPos4iMESA := SYSTEM.VAL(TglWindowPos4iMESA, wglGetProcAddress('glWindowPos4iMESA'));
     glWindowPos4ivMESA := SYSTEM.VAL(TglWindowPos4ivMESA, wglGetProcAddress('glWindowPos4ivMESA'));
     glWindowPos4sMESA := SYSTEM.VAL(TglWindowPos4sMESA, wglGetProcAddress('glWindowPos4sMESA'));
     glWindowPos4svMESA := SYSTEM.VAL(TglWindowPos4svMESA, wglGetProcAddress('glWindowPos4svMESA'));
END Read_GL_MESA_window_pos;

PROCEDURE Read_GL_NV_evaluators;
BEGIN
     glMapControlPointsNV := SYSTEM.VAL(TglMapControlPointsNV, wglGetProcAddress('glMapControlPointsNV'));
     glMapParameterivNV := SYSTEM.VAL(TglMapParameterivNV, wglGetProcAddress('glMapParameterivNV'));
     glMapParameterfvNV := SYSTEM.VAL(TglMapParameterfvNV, wglGetProcAddress('glMapParameterfvNV'));
     glGetMapControlPointsNV := SYSTEM.VAL(TglGetMapControlPointsNV, wglGetProcAddress('glGetMapControlPointsNV'));
     glGetMapParameterivNV := SYSTEM.VAL(TglGetMapParameterivNV, wglGetProcAddress('glGetMapParameterivNV'));
     glGetMapParameterfvNV := SYSTEM.VAL(TglGetMapParameterfvNV, wglGetProcAddress('glGetMapParameterfvNV'));
     glGetMapAttribParameterivNV := SYSTEM.VAL(TglGetMapAttribParameterivNV, wglGetProcAddress('glGetMapAttribParameterivNV'));
     glGetMapAttribParameterfvNV := SYSTEM.VAL(TglGetMapAttribParameterfvNV, wglGetProcAddress('glGetMapAttribParameterfvNV'));
     glEvalMapsNV := SYSTEM.VAL(TglEvalMapsNV, wglGetProcAddress('glEvalMapsNV'));
END Read_GL_NV_evaluators;

PROCEDURE Read_GL_NV_fence;
BEGIN
     glDeleteFencesNV := SYSTEM.VAL(TglDeleteFencesNV, wglGetProcAddress('glDeleteFencesNV'));
     glGenFencesNV := SYSTEM.VAL(TglGenFencesNV, wglGetProcAddress('glGenFencesNV'));
     glIsFenceNV := SYSTEM.VAL(TglIsFenceNV, wglGetProcAddress('glIsFenceNV'));
     glTestFenceNV := SYSTEM.VAL(TglTestFenceNV, wglGetProcAddress('glTestFenceNV'));
     glGetFenceivNV := SYSTEM.VAL(TglGetFenceivNV, wglGetProcAddress('glGetFenceivNV'));
     glFinishFenceNV := SYSTEM.VAL(TglFinishFenceNV, wglGetProcAddress('glFinishFenceNV'));
     glSetFenceNV := SYSTEM.VAL(TglSetFenceNV, wglGetProcAddress('glSetFenceNV'));
END Read_GL_NV_fence;

PROCEDURE Read_GL_NV_fragment_program;
BEGIN
     glProgramNamedParameter4fNV := SYSTEM.VAL(TglProgramNamedParameter4fNV, wglGetProcAddress('glProgramNamedParameter4fNV'));
     glProgramNamedParameter4dNV := SYSTEM.VAL(TglProgramNamedParameter4dNV, wglGetProcAddress('glProgramNamedParameter4dNV'));
     glProgramNamedParameter4fvNV := SYSTEM.VAL(TglProgramNamedParameter4fvNV, wglGetProcAddress('glProgramNamedParameter4fvNV'));
     glProgramNamedParameter4dvNV := SYSTEM.VAL(TglProgramNamedParameter4dvNV, wglGetProcAddress('glProgramNamedParameter4dvNV'));
     glGetProgramNamedParameterfvNV := SYSTEM.VAL(TglGetProgramNamedParameterfvNV, wglGetProcAddress('glGetProgramNamedParameterfvNV'));
     glGetProgramNamedParameterdvNV := SYSTEM.VAL(TglGetProgramNamedParameterdvNV, wglGetProcAddress('glGetProgramNamedParameterdvNV'));
END Read_GL_NV_fragment_program;

PROCEDURE Read_GL_NV_half_float;
BEGIN
     glVertex2hNV := SYSTEM.VAL(TglVertex2hNV, wglGetProcAddress('glVertex2hNV'));
     glVertex2hvNV := SYSTEM.VAL(TglVertex2hvNV, wglGetProcAddress('glVertex2hvNV'));
     glVertex3hNV := SYSTEM.VAL(TglVertex3hNV, wglGetProcAddress('glVertex3hNV'));
     glVertex3hvNV := SYSTEM.VAL(TglVertex3hvNV, wglGetProcAddress('glVertex3hvNV'));
     glVertex4hNV := SYSTEM.VAL(TglVertex4hNV, wglGetProcAddress('glVertex4hNV'));
     glVertex4hvNV := SYSTEM.VAL(TglVertex4hvNV, wglGetProcAddress('glVertex4hvNV'));
     glNormal3hNV := SYSTEM.VAL(TglNormal3hNV, wglGetProcAddress('glNormal3hNV'));
     glNormal3hvNV := SYSTEM.VAL(TglNormal3hvNV, wglGetProcAddress('glNormal3hvNV'));
     glColor3hNV := SYSTEM.VAL(TglColor3hNV, wglGetProcAddress('glColor3hNV'));
     glColor3hvNV := SYSTEM.VAL(TglColor3hvNV, wglGetProcAddress('glColor3hvNV'));
     glColor4hNV := SYSTEM.VAL(TglColor4hNV, wglGetProcAddress('glColor4hNV'));
     glColor4hvNV := SYSTEM.VAL(TglColor4hvNV, wglGetProcAddress('glColor4hvNV'));
     glTexCoord1hNV := SYSTEM.VAL(TglTexCoord1hNV, wglGetProcAddress('glTexCoord1hNV'));
     glTexCoord1hvNV := SYSTEM.VAL(TglTexCoord1hvNV, wglGetProcAddress('glTexCoord1hvNV'));
     glTexCoord2hNV := SYSTEM.VAL(TglTexCoord2hNV, wglGetProcAddress('glTexCoord2hNV'));
     glTexCoord2hvNV := SYSTEM.VAL(TglTexCoord2hvNV, wglGetProcAddress('glTexCoord2hvNV'));
     glTexCoord3hNV := SYSTEM.VAL(TglTexCoord3hNV, wglGetProcAddress('glTexCoord3hNV'));
     glTexCoord3hvNV := SYSTEM.VAL(TglTexCoord3hvNV, wglGetProcAddress('glTexCoord3hvNV'));
     glTexCoord4hNV := SYSTEM.VAL(TglTexCoord4hNV, wglGetProcAddress('glTexCoord4hNV'));
     glTexCoord4hvNV := SYSTEM.VAL(TglTexCoord4hvNV, wglGetProcAddress('glTexCoord4hvNV'));
     glMultiTexCoord1hNV := SYSTEM.VAL(TglMultiTexCoord1hNV, wglGetProcAddress('glMultiTexCoord1hNV'));
     glMultiTexCoord1hvNV := SYSTEM.VAL(TglMultiTexCoord1hvNV, wglGetProcAddress('glMultiTexCoord1hvNV'));
     glMultiTexCoord2hNV := SYSTEM.VAL(TglMultiTexCoord2hNV, wglGetProcAddress('glMultiTexCoord2hNV'));
     glMultiTexCoord2hvNV := SYSTEM.VAL(TglMultiTexCoord2hvNV, wglGetProcAddress('glMultiTexCoord2hvNV'));
     glMultiTexCoord3hNV := SYSTEM.VAL(TglMultiTexCoord3hNV, wglGetProcAddress('glMultiTexCoord3hNV'));
     glMultiTexCoord3hvNV := SYSTEM.VAL(TglMultiTexCoord3hvNV, wglGetProcAddress('glMultiTexCoord3hvNV'));
     glMultiTexCoord4hNV := SYSTEM.VAL(TglMultiTexCoord4hNV, wglGetProcAddress('glMultiTexCoord4hNV'));
     glMultiTexCoord4hvNV := SYSTEM.VAL(TglMultiTexCoord4hvNV, wglGetProcAddress('glMultiTexCoord4hvNV'));
     glFogCoordhNV := SYSTEM.VAL(TglFogCoordhNV, wglGetProcAddress('glFogCoordhNV'));
     glFogCoordhvNV := SYSTEM.VAL(TglFogCoordhvNV, wglGetProcAddress('glFogCoordhvNV'));
     glSecondaryColor3hNV := SYSTEM.VAL(TglSecondaryColor3hNV, wglGetProcAddress('glSecondaryColor3hNV'));
     glSecondaryColor3hvNV := SYSTEM.VAL(TglSecondaryColor3hvNV, wglGetProcAddress('glSecondaryColor3hvNV'));
     glVertexWeighthNV := SYSTEM.VAL(TglVertexWeighthNV, wglGetProcAddress('glVertexWeighthNV'));
     glVertexWeighthvNV := SYSTEM.VAL(TglVertexWeighthvNV, wglGetProcAddress('glVertexWeighthvNV'));
     glVertexAttrib1hNV := SYSTEM.VAL(TglVertexAttrib1hNV, wglGetProcAddress('glVertexAttrib1hNV'));
     glVertexAttrib1hvNV := SYSTEM.VAL(TglVertexAttrib1hvNV, wglGetProcAddress('glVertexAttrib1hvNV'));
     glVertexAttrib2hNV := SYSTEM.VAL(TglVertexAttrib2hNV, wglGetProcAddress('glVertexAttrib2hNV'));
     glVertexAttrib2hvNV := SYSTEM.VAL(TglVertexAttrib2hvNV, wglGetProcAddress('glVertexAttrib2hvNV'));
     glVertexAttrib3hNV := SYSTEM.VAL(TglVertexAttrib3hNV, wglGetProcAddress('glVertexAttrib3hNV'));
     glVertexAttrib3hvNV := SYSTEM.VAL(TglVertexAttrib3hvNV, wglGetProcAddress('glVertexAttrib3hvNV'));
     glVertexAttrib4hNV := SYSTEM.VAL(TglVertexAttrib4hNV, wglGetProcAddress('glVertexAttrib4hNV'));
     glVertexAttrib4hvNV := SYSTEM.VAL(TglVertexAttrib4hvNV, wglGetProcAddress('glVertexAttrib4hvNV'));
     glVertexAttribs1hvNV := SYSTEM.VAL(TglVertexAttribs1hvNV, wglGetProcAddress('glVertexAttribs1hvNV'));
     glVertexAttribs2hvNV := SYSTEM.VAL(TglVertexAttribs2hvNV, wglGetProcAddress('glVertexAttribs2hvNV'));
     glVertexAttribs3hvNV := SYSTEM.VAL(TglVertexAttribs3hvNV, wglGetProcAddress('glVertexAttribs3hvNV'));
     glVertexAttribs4hvNV := SYSTEM.VAL(TglVertexAttribs4hvNV, wglGetProcAddress('glVertexAttribs4hvNV'));
END Read_GL_NV_half_float;

PROCEDURE Read_GL_NV_occlusion_query;
BEGIN
     glGenOcclusionQueriesNV := SYSTEM.VAL(TglGenOcclusionQueriesNV, wglGetProcAddress('glGenOcclusionQueriesNV'));
     glDeleteOcclusionQueriesNV := SYSTEM.VAL(TglDeleteOcclusionQueriesNV, wglGetProcAddress('glDeleteOcclusionQueriesNV'));
     glIsOcclusionQueryNV := SYSTEM.VAL(TglIsOcclusionQueryNV, wglGetProcAddress('glIsOcclusionQueryNV'));
     glBeginOcclusionQueryNV := SYSTEM.VAL(TglBeginOcclusionQueryNV, wglGetProcAddress('glBeginOcclusionQueryNV'));
     glEndOcclusionQueryNV := SYSTEM.VAL(TglEndOcclusionQueryNV, wglGetProcAddress('glEndOcclusionQueryNV'));
     glGetOcclusionQueryivNV := SYSTEM.VAL(TglGetOcclusionQueryivNV, wglGetProcAddress('glGetOcclusionQueryivNV'));
     glGetOcclusionQueryuivNV := SYSTEM.VAL(TglGetOcclusionQueryuivNV, wglGetProcAddress('glGetOcclusionQueryuivNV'));
END Read_GL_NV_occlusion_query;

PROCEDURE Read_GL_NV_pixel_data_range;
BEGIN
     glPixelDataRangeNV := SYSTEM.VAL(TglPixelDataRangeNV, wglGetProcAddress('glPixelDataRangeNV'));
     glFlushPixelDataRangeNV := SYSTEM.VAL(TglFlushPixelDataRangeNV, wglGetProcAddress('glFlushPixelDataRangeNV'));
END Read_GL_NV_pixel_data_range;

PROCEDURE Read_GL_NV_point_sprite;
BEGIN
     glPointParameteriNV := SYSTEM.VAL(TglPointParameteriNV, wglGetProcAddress('glPointParameteriNV'));
     glPointParameterivNV := SYSTEM.VAL(TglPointParameterivNV, wglGetProcAddress('glPointParameterivNV'));
END Read_GL_NV_point_sprite;

PROCEDURE Read_GL_NV_primitive_restart;
BEGIN
     glPrimitiveRestartNV := SYSTEM.VAL(TglPrimitiveRestartNV, wglGetProcAddress('glPrimitiveRestartNV'));
     glPrimitiveRestartIndexNV := SYSTEM.VAL(TglPrimitiveRestartIndexNV, wglGetProcAddress('glPrimitiveRestartIndexNV'));
END Read_GL_NV_primitive_restart;

PROCEDURE Read_GL_NV_register_combiners;
BEGIN
     glCombinerParameterfvNV := SYSTEM.VAL(TglCombinerParameterfvNV, wglGetProcAddress('glCombinerParameterfvNV'));
     glCombinerParameterfNV := SYSTEM.VAL(TglCombinerParameterfNV, wglGetProcAddress('glCombinerParameterfNV'));
     glCombinerParameterivNV := SYSTEM.VAL(TglCombinerParameterivNV, wglGetProcAddress('glCombinerParameterivNV'));
     glCombinerParameteriNV := SYSTEM.VAL(TglCombinerParameteriNV, wglGetProcAddress('glCombinerParameteriNV'));
     glCombinerInputNV := SYSTEM.VAL(TglCombinerInputNV, wglGetProcAddress('glCombinerInputNV'));
     glCombinerOutputNV := SYSTEM.VAL(TglCombinerOutputNV, wglGetProcAddress('glCombinerOutputNV'));
     glFinalCombinerInputNV := SYSTEM.VAL(TglFinalCombinerInputNV, wglGetProcAddress('glFinalCombinerInputNV'));
     glGetCombinerInputParameterfvNV := SYSTEM.VAL(TglGetCombinerInputParameterfvNV, wglGetProcAddress('glGetCombinerInputParameterfvNV'));
     glGetCombinerInputParameterivNV := SYSTEM.VAL(TglGetCombinerInputParameterivNV, wglGetProcAddress('glGetCombinerInputParameterivNV'));
     glGetCombinerOutputParameterfvNV := SYSTEM.VAL(TglGetCombinerOutputParameterfvNV, wglGetProcAddress('glGetCombinerOutputParameterfvNV'));
     glGetCombinerOutputParameterivNV := SYSTEM.VAL(TglGetCombinerOutputParameterivNV, wglGetProcAddress('glGetCombinerOutputParameterivNV'));
     glGetFinalCombinerInputParameterfvNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterfvNV, wglGetProcAddress('glGetFinalCombinerInputParameterfvNV'));
     glGetFinalCombinerInputParameterivNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterivNV, wglGetProcAddress('glGetFinalCombinerInputParameterivNV'));
END Read_GL_NV_register_combiners;

PROCEDURE Read_GL_NV_register_combiners2;
BEGIN
     glCombinerStageParameterfvNV := SYSTEM.VAL(TglCombinerStageParameterfvNV, wglGetProcAddress('glCombinerStageParameterfvNV'));
     glGetCombinerStageParameterfvNV := SYSTEM.VAL(TglGetCombinerStageParameterfvNV, wglGetProcAddress('glGetCombinerStageParameterfvNV'));
END Read_GL_NV_register_combiners2;

PROCEDURE Read_GL_NV_vertex_array_range;
BEGIN
     glFlushVertexArrayRangeNV := SYSTEM.VAL(TglFlushVertexArrayRangeNV, wglGetProcAddress('glFlushVertexArrayRangeNV'));
     glVertexArrayRangeNV := SYSTEM.VAL(TglVertexArrayRangeNV, wglGetProcAddress('glVertexArrayRangeNV'));
END Read_GL_NV_vertex_array_range;

PROCEDURE Read_GL_NV_vertex_program;
BEGIN
     glAreProgramsResidentNV := SYSTEM.VAL(TglAreProgramsResidentNV, wglGetProcAddress('glAreProgramsResidentNV'));
     glBindProgramNV := SYSTEM.VAL(TglBindProgramNV, wglGetProcAddress('glBindProgramNV'));
     glDeleteProgramsNV := SYSTEM.VAL(TglDeleteProgramsNV, wglGetProcAddress('glDeleteProgramsNV'));
     glExecuteProgramNV := SYSTEM.VAL(TglExecuteProgramNV, wglGetProcAddress('glExecuteProgramNV'));
     glGenProgramsNV := SYSTEM.VAL(TglGenProgramsNV, wglGetProcAddress('glGenProgramsNV'));
     glGetProgramParameterdvNV := SYSTEM.VAL(TglGetProgramParameterdvNV, wglGetProcAddress('glGetProgramParameterdvNV'));
     glGetProgramParameterfvNV := SYSTEM.VAL(TglGetProgramParameterfvNV, wglGetProcAddress('glGetProgramParameterfvNV'));
     glGetProgramivNV := SYSTEM.VAL(TglGetProgramivNV, wglGetProcAddress('glGetProgramivNV'));
     glGetProgramStringNV := SYSTEM.VAL(TglGetProgramStringNV, wglGetProcAddress('glGetProgramStringNV'));
     glGetTrackMatrixivNV := SYSTEM.VAL(TglGetTrackMatrixivNV, wglGetProcAddress('glGetTrackMatrixivNV'));
     glGetVertexAttribdvNV := SYSTEM.VAL(TglGetVertexAttribdvNV, wglGetProcAddress('glGetVertexAttribdvNV'));
     glGetVertexAttribfvNV := SYSTEM.VAL(TglGetVertexAttribfvNV, wglGetProcAddress('glGetVertexAttribfvNV'));
     glGetVertexAttribivNV := SYSTEM.VAL(TglGetVertexAttribivNV, wglGetProcAddress('glGetVertexAttribivNV'));
     glGetVertexAttribPointervNV := SYSTEM.VAL(TglGetVertexAttribPointervNV, wglGetProcAddress('glGetVertexAttribPointervNV'));
     glIsProgramNV := SYSTEM.VAL(TglIsProgramNV, wglGetProcAddress('glIsProgramNV'));
     glLoadProgramNV := SYSTEM.VAL(TglLoadProgramNV, wglGetProcAddress('glLoadProgramNV'));
     glProgramParameter4dNV := SYSTEM.VAL(TglProgramParameter4dNV, wglGetProcAddress('glProgramParameter4dNV'));
     glProgramParameter4dvNV := SYSTEM.VAL(TglProgramParameter4dvNV, wglGetProcAddress('glProgramParameter4dvNV'));
     glProgramParameter4fNV := SYSTEM.VAL(TglProgramParameter4fNV, wglGetProcAddress('glProgramParameter4fNV'));
     glProgramParameter4fvNV := SYSTEM.VAL(TglProgramParameter4fvNV, wglGetProcAddress('glProgramParameter4fvNV'));
     glProgramParameters4dvNV := SYSTEM.VAL(TglProgramParameters4dvNV, wglGetProcAddress('glProgramParameters4dvNV'));
     glProgramParameters4fvNV := SYSTEM.VAL(TglProgramParameters4fvNV, wglGetProcAddress('glProgramParameters4fvNV'));
     glRequestResidentProgramsNV := SYSTEM.VAL(TglRequestResidentProgramsNV, wglGetProcAddress('glRequestResidentProgramsNV'));
     glTrackMatrixNV := SYSTEM.VAL(TglTrackMatrixNV, wglGetProcAddress('glTrackMatrixNV'));
     glVertexAttribPointerNV := SYSTEM.VAL(TglVertexAttribPointerNV, wglGetProcAddress('glVertexAttribPointerNV'));
     glVertexAttrib1dNV := SYSTEM.VAL(TglVertexAttrib1dNV, wglGetProcAddress('glVertexAttrib1dNV'));
     glVertexAttrib1dvNV := SYSTEM.VAL(TglVertexAttrib1dvNV, wglGetProcAddress('glVertexAttrib1dvNV'));
     glVertexAttrib1fNV := SYSTEM.VAL(TglVertexAttrib1fNV, wglGetProcAddress('glVertexAttrib1fNV'));
     glVertexAttrib1fvNV := SYSTEM.VAL(TglVertexAttrib1fvNV, wglGetProcAddress('glVertexAttrib1fvNV'));
     glVertexAttrib1sNV := SYSTEM.VAL(TglVertexAttrib1sNV, wglGetProcAddress('glVertexAttrib1sNV'));
     glVertexAttrib1svNV := SYSTEM.VAL(TglVertexAttrib1svNV, wglGetProcAddress('glVertexAttrib1svNV'));
     glVertexAttrib2dNV := SYSTEM.VAL(TglVertexAttrib2dNV, wglGetProcAddress('glVertexAttrib2dNV'));
     glVertexAttrib2dvNV := SYSTEM.VAL(TglVertexAttrib2dvNV, wglGetProcAddress('glVertexAttrib2dvNV'));
     glVertexAttrib2fNV := SYSTEM.VAL(TglVertexAttrib2fNV, wglGetProcAddress('glVertexAttrib2fNV'));
     glVertexAttrib2fvNV := SYSTEM.VAL(TglVertexAttrib2fvNV, wglGetProcAddress('glVertexAttrib2fvNV'));
     glVertexAttrib2sNV := SYSTEM.VAL(TglVertexAttrib2sNV, wglGetProcAddress('glVertexAttrib2sNV'));
     glVertexAttrib2svNV := SYSTEM.VAL(TglVertexAttrib2svNV, wglGetProcAddress('glVertexAttrib2svNV'));
     glVertexAttrib3dNV := SYSTEM.VAL(TglVertexAttrib3dNV, wglGetProcAddress('glVertexAttrib3dNV'));
     glVertexAttrib3dvNV := SYSTEM.VAL(TglVertexAttrib3dvNV, wglGetProcAddress('glVertexAttrib3dvNV'));
     glVertexAttrib3fNV := SYSTEM.VAL(TglVertexAttrib3fNV, wglGetProcAddress('glVertexAttrib3fNV'));
     glVertexAttrib3fvNV := SYSTEM.VAL(TglVertexAttrib3fvNV, wglGetProcAddress('glVertexAttrib3fvNV'));
     glVertexAttrib3sNV := SYSTEM.VAL(TglVertexAttrib3sNV, wglGetProcAddress('glVertexAttrib3sNV'));
     glVertexAttrib3svNV := SYSTEM.VAL(TglVertexAttrib3svNV, wglGetProcAddress('glVertexAttrib3svNV'));
     glVertexAttrib4dNV := SYSTEM.VAL(TglVertexAttrib4dNV, wglGetProcAddress('glVertexAttrib4dNV'));
     glVertexAttrib4dvNV := SYSTEM.VAL(TglVertexAttrib4dvNV, wglGetProcAddress('glVertexAttrib4dvNV'));
     glVertexAttrib4fNV := SYSTEM.VAL(TglVertexAttrib4fNV, wglGetProcAddress('glVertexAttrib4fNV'));
     glVertexAttrib4fvNV := SYSTEM.VAL(TglVertexAttrib4fvNV, wglGetProcAddress('glVertexAttrib4fvNV'));
     glVertexAttrib4sNV := SYSTEM.VAL(TglVertexAttrib4sNV, wglGetProcAddress('glVertexAttrib4sNV'));
     glVertexAttrib4svNV := SYSTEM.VAL(TglVertexAttrib4svNV, wglGetProcAddress('glVertexAttrib4svNV'));
     glVertexAttrib4ubNV := SYSTEM.VAL(TglVertexAttrib4ubNV, wglGetProcAddress('glVertexAttrib4ubNV'));
     glVertexAttrib4ubvNV := SYSTEM.VAL(TglVertexAttrib4ubvNV, wglGetProcAddress('glVertexAttrib4ubvNV'));
     glVertexAttribs1dvNV := SYSTEM.VAL(TglVertexAttribs1dvNV, wglGetProcAddress('glVertexAttribs1dvNV'));
     glVertexAttribs1fvNV := SYSTEM.VAL(TglVertexAttribs1fvNV, wglGetProcAddress('glVertexAttribs1fvNV'));
     glVertexAttribs1svNV := SYSTEM.VAL(TglVertexAttribs1svNV, wglGetProcAddress('glVertexAttribs1svNV'));
     glVertexAttribs2dvNV := SYSTEM.VAL(TglVertexAttribs2dvNV, wglGetProcAddress('glVertexAttribs2dvNV'));
     glVertexAttribs2fvNV := SYSTEM.VAL(TglVertexAttribs2fvNV, wglGetProcAddress('glVertexAttribs2fvNV'));
     glVertexAttribs2svNV := SYSTEM.VAL(TglVertexAttribs2svNV, wglGetProcAddress('glVertexAttribs2svNV'));
     glVertexAttribs3dvNV := SYSTEM.VAL(TglVertexAttribs3dvNV, wglGetProcAddress('glVertexAttribs3dvNV'));
     glVertexAttribs3fvNV := SYSTEM.VAL(TglVertexAttribs3fvNV, wglGetProcAddress('glVertexAttribs3fvNV'));
     glVertexAttribs3svNV := SYSTEM.VAL(TglVertexAttribs3svNV, wglGetProcAddress('glVertexAttribs3svNV'));
     glVertexAttribs4dvNV := SYSTEM.VAL(TglVertexAttribs4dvNV, wglGetProcAddress('glVertexAttribs4dvNV'));
     glVertexAttribs4fvNV := SYSTEM.VAL(TglVertexAttribs4fvNV, wglGetProcAddress('glVertexAttribs4fvNV'));
     glVertexAttribs4svNV := SYSTEM.VAL(TglVertexAttribs4svNV, wglGetProcAddress('glVertexAttribs4svNV'));
     glVertexAttribs4ubvNV := SYSTEM.VAL(TglVertexAttribs4ubvNV, wglGetProcAddress('glVertexAttribs4ubvNV'));
END Read_GL_NV_vertex_program;

PROCEDURE Read_GL_NV_depth_buffer_float;
BEGIN
     glDepthRangedNV := SYSTEM.VAL(TglDepthRangedNV, wglGetProcAddress('glDepthRangedNV'));
     glClearDepthdNV := SYSTEM.VAL(TglClearDepthdNV, wglGetProcAddress('glClearDepthdNV'));
     glDepthBoundsdNV := SYSTEM.VAL(TglDepthBoundsdNV, wglGetProcAddress('glDepthBoundsdNV'));
END Read_GL_NV_depth_buffer_float;

PROCEDURE Read_GL_NV_framebuffer_multisample_coverage;
BEGIN
     glRenderbufferStorageMultsampleCoverageNV := SYSTEM.VAL(TglRenderbufferStorageMultsampleCoverageNV, wglGetProcAddress('glRenderbufferStorageMultsampleCoverageNV'));
END Read_GL_NV_framebuffer_multisample_coverage;

PROCEDURE Read_GL_NV_geometry_program4;
BEGIN
     glProgramVertexLimitNV := SYSTEM.VAL(TglProgramVertexLimitNV, wglGetProcAddress('glProgramVertexLimitNV'));
END Read_GL_NV_geometry_program4;

PROCEDURE Read_GL_NV_gpu_program4;
BEGIN
     glProgramLocalParameterI4iNV := SYSTEM.VAL(TglProgramLocalParameterI4iNV, wglGetProcAddress('glProgramLocalParameterI4iNV'));
     glProgramLocalParameterI4ivNV := SYSTEM.VAL(TglProgramLocalParameterI4ivNV, wglGetProcAddress('glProgramLocalParameterI4ivNV'));
     glProgramLocalParametersI4ivNV := SYSTEM.VAL(TglProgramLocalParametersI4ivNV, wglGetProcAddress('glProgramLocalParametersI4ivNV'));
     glProgramLocalParameterI4uiNV := SYSTEM.VAL(TglProgramLocalParameterI4uiNV, wglGetProcAddress('glProgramLocalParameterI4uiNV'));
     glProgramLocalParameterI4uivNV := SYSTEM.VAL(TglProgramLocalParameterI4uivNV, wglGetProcAddress('glProgramLocalParameterI4uivNV'));
     glProgramLocalParametersI4uivNV := SYSTEM.VAL(TglProgramLocalParametersI4uivNV, wglGetProcAddress('glProgramLocalParametersI4uivNV'));
     glProgramEnvParameterI4iNV := SYSTEM.VAL(TglProgramEnvParameterI4iNV, wglGetProcAddress('glProgramEnvParameterI4iNV'));
     glProgramEnvParameterI4ivNV := SYSTEM.VAL(TglProgramEnvParameterI4ivNV, wglGetProcAddress('glProgramEnvParameterI4ivNV'));
     glProgramEnvParametersI4ivNV := SYSTEM.VAL(TglProgramEnvParametersI4ivNV, wglGetProcAddress('glProgramEnvParametersI4ivNV'));
     glProgramEnvParameterI4uiNV := SYSTEM.VAL(TglProgramEnvParameterI4uiNV, wglGetProcAddress('glProgramEnvParameterI4uiNV'));
     glProgramEnvParameterI4uivNV := SYSTEM.VAL(TglProgramEnvParameterI4uivNV, wglGetProcAddress('glProgramEnvParameterI4uivNV'));
     glProgramEnvParametersI4uivNV := SYSTEM.VAL(TglProgramEnvParametersI4uivNV, wglGetProcAddress('glProgramEnvParametersI4uivNV'));
     glGetProgramLocalParameterIivNV := SYSTEM.VAL(TglGetProgramLocalParameterIivNV, wglGetProcAddress('glGetProgramLocalParameterIivNV'));
     glGetProgramLocalParameterIuivNV := SYSTEM.VAL(TglGetProgramLocalParameterIuivNV, wglGetProcAddress('glGetProgramLocalParameterIuivNV'));
     glGetProgramEnvParameterIivNV := SYSTEM.VAL(TglGetProgramEnvParameterIivNV, wglGetProcAddress('glGetProgramEnvParameterIivNV'));
     glGetProgramEnvParameterIuivNV := SYSTEM.VAL(TglGetProgramEnvParameterIuivNV, wglGetProcAddress('glGetProgramEnvParameterIuivNV'));
END Read_GL_NV_gpu_program4;

PROCEDURE Read_GL_NV_parameter_buffer_object;
BEGIN
     glProgramBufferParametersfvNV := SYSTEM.VAL(TglProgramBufferParametersfvNV, wglGetProcAddress('glProgramBufferParametersfvNV'));
     glProgramBufferParametersIivNV := SYSTEM.VAL(TglProgramBufferParametersIivNV, wglGetProcAddress('glProgramBufferParametersIivNV'));
     glProgramBufferParametersIuivNV := SYSTEM.VAL(TglProgramBufferParametersIuivNV, wglGetProcAddress('glProgramBufferParametersIuivNV'));
END Read_GL_NV_parameter_buffer_object;

PROCEDURE Read_GL_NV_transform_feedback;
BEGIN
     glBeginTransformFeedbackNV := SYSTEM.VAL(TglBeginTransformFeedbackNV, wglGetProcAddress('glBeginTransformFeedbackNV'));
     glEndTransformFeedbackNV := SYSTEM.VAL(TglEndTransformFeedbackNV, wglGetProcAddress('glEndTransformFeedbackNV'));
     glTransformFeedbackAttribsNV := SYSTEM.VAL(TglTransformFeedbackAttribsNV, wglGetProcAddress('glTransformFeedbackAttribsNV'));
     glBindBufferRangeNV := SYSTEM.VAL(TglBindBufferRangeNV, wglGetProcAddress('glBindBufferRangeNV'));
     glBindBufferOffsetNV := SYSTEM.VAL(TglBindBufferOffsetNV, wglGetProcAddress('glBindBufferOffsetNV'));
     glBindBufferBaseNV := SYSTEM.VAL(TglBindBufferBaseNV, wglGetProcAddress('glBindBufferBaseNV'));
     glTransformFeedbackVaryingsNV := SYSTEM.VAL(TglTransformFeedbackVaryingsNV, wglGetProcAddress('glTransformFeedbackVaryingsNV'));
     glActiveVaryingNV := SYSTEM.VAL(TglActiveVaryingNV, wglGetProcAddress('glActiveVaryingNV'));
     glGetVaryingLocationNV := SYSTEM.VAL(TglGetVaryingLocationNV, wglGetProcAddress('glGetVaryingLocationNV'));
     glGetActiveVaryingNV := SYSTEM.VAL(TglGetActiveVaryingNV, wglGetProcAddress('glGetActiveVaryingNV'));
     glGetTransformFeedbackVaryingNV := SYSTEM.VAL(TglGetTransformFeedbackVaryingNV, wglGetProcAddress('glGetTransformFeedbackVaryingNV'));
     glTransformFeedbackStreamAttribsNV := SYSTEM.VAL(TglTransformFeedbackStreamAttribsNV, wglGetProcAddress('glTransformFeedbackStreamAttribsNV'));
END Read_GL_NV_transform_feedback;

PROCEDURE Read_GL_NV_conditional_render;
BEGIN
     glBeginConditionalRenderNV := SYSTEM.VAL(TglBeginConditionalRenderNV, wglGetProcAddress('glBeginConditionalRenderNV'));
     glEndConditionalRenderNV := SYSTEM.VAL(TglEndConditionalRenderNV, wglGetProcAddress('glEndConditionalRenderNV'));
END Read_GL_NV_conditional_render;

PROCEDURE Read_GL_NV_present_video;
BEGIN
     glPresentFrameKeyedNV := SYSTEM.VAL(TglPresentFrameKeyedNV, wglGetProcAddress('glPresentFrameKeyedNV'));
     glPresentFrameDualFillNV := SYSTEM.VAL(TglPresentFrameDualFillNV, wglGetProcAddress('glPresentFrameDualFillNV'));
     glGetVideoivNV := SYSTEM.VAL(TglGetVideoivNV, wglGetProcAddress('glGetVideoivNV'));
     glGetVideouivNV := SYSTEM.VAL(TglGetVideouivNV, wglGetProcAddress('glGetVideouivNV'));
     glGetVideoi64vNV := SYSTEM.VAL(TglGetVideoi64vNV, wglGetProcAddress('glGetVideoi64vNV'));
     glGetVideoui64vNV := SYSTEM.VAL(TglGetVideoui64vNV, wglGetProcAddress('glGetVideoui64vNV'));
END Read_GL_NV_present_video;

PROCEDURE Read_GL_NV_explicit_multisample;
BEGIN
     glGetMultisamplefvNV := SYSTEM.VAL(TglGetMultisamplefvNV, wglGetProcAddress('glGetMultisamplefvNV'));
     glSampleMaskIndexedNV := SYSTEM.VAL(TglSampleMaskIndexedNV, wglGetProcAddress('glSampleMaskIndexedNV'));
     glTexRenderbufferNV := SYSTEM.VAL(TglTexRenderbufferNV, wglGetProcAddress('glTexRenderbufferNV'));
END Read_GL_NV_explicit_multisample;

PROCEDURE Read_GL_NV_transform_feedback2;
BEGIN
     glBindTransformFeedbackNV := SYSTEM.VAL(TglBindTransformFeedbackNV, wglGetProcAddress('glBindTransformFeedbackNV'));
     glDeleteTransformFeedbacksNV := SYSTEM.VAL(TglDeleteTransformFeedbacksNV, wglGetProcAddress('glDeleteTransformFeedbacksNV'));
     glGenTransformFeedbacksNV := SYSTEM.VAL(TglGenTransformFeedbacksNV, wglGetProcAddress('glGenTransformFeedbacksNV'));
     glIsTransformFeedbackNV := SYSTEM.VAL(TglIsTransformFeedbackNV, wglGetProcAddress('glIsTransformFeedbackNV'));
     glPauseTransformFeedbackNV := SYSTEM.VAL(TglPauseTransformFeedbackNV, wglGetProcAddress('glPauseTransformFeedbackNV'));
     glResumeTransformFeedbackNV := SYSTEM.VAL(TglResumeTransformFeedbackNV, wglGetProcAddress('glResumeTransformFeedbackNV'));
     glDrawTransformFeedbackNV := SYSTEM.VAL(TglDrawTransformFeedbackNV, wglGetProcAddress('glDrawTransformFeedbackNV'));
END Read_GL_NV_transform_feedback2;

PROCEDURE Read_GL_NV_video_capture;
BEGIN
     glBeginVideoCaptureNV := SYSTEM.VAL(TglBeginVideoCaptureNV, wglGetProcAddress('glBeginVideoCaptureNV'));
     glBindVideoCaptureStreamBufferNV := SYSTEM.VAL(TglBindVideoCaptureStreamBufferNV, wglGetProcAddress('glBindVideoCaptureStreamBufferNV'));
     glBindVideoCaptureStreamTextureNV := SYSTEM.VAL(TglBindVideoCaptureStreamTextureNV, wglGetProcAddress('glBindVideoCaptureStreamTextureNV'));
     glEndVideoCaptureNV := SYSTEM.VAL(TglEndVideoCaptureNV, wglGetProcAddress('glEndVideoCaptureNV'));
     glGetVideoCaptureivNV := SYSTEM.VAL(TglGetVideoCaptureivNV, wglGetProcAddress('glGetVideoCaptureivNV'));
     glGetVideoCaptureStreamivNV := SYSTEM.VAL(TglGetVideoCaptureStreamivNV, wglGetProcAddress('glGetVideoCaptureStreamivNV'));
     glGetVideoCaptureStreamfvNV := SYSTEM.VAL(TglGetVideoCaptureStreamfvNV, wglGetProcAddress('glGetVideoCaptureStreamfvNV'));
     glGetVideoCaptureStreamdvNV := SYSTEM.VAL(TglGetVideoCaptureStreamdvNV, wglGetProcAddress('glGetVideoCaptureStreamdvNV'));
     glVideoCaptureNV := SYSTEM.VAL(TglVideoCaptureNV, wglGetProcAddress('glVideoCaptureNV'));
     glVideoCaptureStreamParameterivNV := SYSTEM.VAL(TglVideoCaptureStreamParameterivNV, wglGetProcAddress('glVideoCaptureStreamParameterivNV'));
     glVideoCaptureStreamParameterfvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterfvNV, wglGetProcAddress('glVideoCaptureStreamParameterfvNV'));
     glVideoCaptureStreamParameterdvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterdvNV, wglGetProcAddress('glVideoCaptureStreamParameterdvNV'));
END Read_GL_NV_video_capture;

PROCEDURE Read_GL_NV_copy_image;
BEGIN
     glCopyImageSubDataNV := SYSTEM.VAL(TglCopyImageSubDataNV, wglGetProcAddress('glCopyImageSubDataNV'));
END Read_GL_NV_copy_image;

PROCEDURE Read_GL_NV_shader_buffer_load;
BEGIN
     glMakeBufferResidentNV := SYSTEM.VAL(TglMakeBufferResidentNV, wglGetProcAddress('glMakeBufferResidentNV'));
     glMakeBufferNonResidentNV := SYSTEM.VAL(TglMakeBufferNonResidentNV, wglGetProcAddress('glMakeBufferNonResidentNV'));
     glIsBufferResidentNV := SYSTEM.VAL(TglIsBufferResidentNV, wglGetProcAddress('glIsBufferResidentNV'));
     glMakeNamedBufferResidentNV := SYSTEM.VAL(TglMakeNamedBufferResidentNV, wglGetProcAddress('glMakeNamedBufferResidentNV'));
     glMakeNamedBufferNonResidentNV := SYSTEM.VAL(TglMakeNamedBufferNonResidentNV, wglGetProcAddress('glMakeNamedBufferNonResidentNV'));
     glIsNamedBufferResidentNV := SYSTEM.VAL(TglIsNamedBufferResidentNV, wglGetProcAddress('glIsNamedBufferResidentNV'));
     glGetBufferParameterui64vNV := SYSTEM.VAL(TglGetBufferParameterui64vNV, wglGetProcAddress('glGetBufferParameterui64vNV'));
     glGetNamedBufferParameterui64vNV := SYSTEM.VAL(TglGetNamedBufferParameterui64vNV, wglGetProcAddress('glGetNamedBufferParameterui64vNV'));
     glGetIntegerui64vNV := SYSTEM.VAL(TglGetIntegerui64vNV, wglGetProcAddress('glGetIntegerui64vNV'));
     glUniformui64NV := SYSTEM.VAL(TglUniformui64NV, wglGetProcAddress('glUniformui64NV'));
     glUniformui64vNV := SYSTEM.VAL(TglUniformui64vNV, wglGetProcAddress('glUniformui64vNV'));
     glGetUniformui64vNV := SYSTEM.VAL(TglGetUniformui64vNV, wglGetProcAddress('glGetUniformui64vNV'));
     glProgramUniformui64NV := SYSTEM.VAL(TglProgramUniformui64NV, wglGetProcAddress('glProgramUniformui64NV'));
     glProgramUniformui64vNV := SYSTEM.VAL(TglProgramUniformui64vNV, wglGetProcAddress('glProgramUniformui64vNV'));
END Read_GL_NV_shader_buffer_load;

PROCEDURE Read_GL_NV_vertex_buffer_unified_memory;
BEGIN
     glBufferAddressRangeNV := SYSTEM.VAL(TglBufferAddressRangeNV, wglGetProcAddress('glBufferAddressRangeNV'));
     glVertexFormatNV := SYSTEM.VAL(TglVertexFormatNV, wglGetProcAddress('glVertexFormatNV'));
     glNormalFormatNV := SYSTEM.VAL(TglNormalFormatNV, wglGetProcAddress('glNormalFormatNV'));
     glColorFormatNV := SYSTEM.VAL(TglColorFormatNV, wglGetProcAddress('glColorFormatNV'));
     glIndexFormatNV := SYSTEM.VAL(TglIndexFormatNV, wglGetProcAddress('glIndexFormatNV'));
     glTexCoordFormatNV := SYSTEM.VAL(TglTexCoordFormatNV, wglGetProcAddress('glTexCoordFormatNV'));
     glEdgeFlagFormatNV := SYSTEM.VAL(TglEdgeFlagFormatNV, wglGetProcAddress('glEdgeFlagFormatNV'));
     glSecondaryColorFormatNV := SYSTEM.VAL(TglSecondaryColorFormatNV, wglGetProcAddress('glSecondaryColorFormatNV'));
     glFogCoordFormatNV := SYSTEM.VAL(TglFogCoordFormatNV, wglGetProcAddress('glFogCoordFormatNV'));
     glVertexAttribFormatNV := SYSTEM.VAL(TglVertexAttribFormatNV, wglGetProcAddress('glVertexAttribFormatNV'));
     glVertexAttribIFormatNV := SYSTEM.VAL(TglVertexAttribIFormatNV, wglGetProcAddress('glVertexAttribIFormatNV'));
     glGetIntegerui64i_vNV := SYSTEM.VAL(TglGetIntegerui64i_vNV, wglGetProcAddress('glGetIntegerui64i_vNV'));
END Read_GL_NV_vertex_buffer_unified_memory;

PROCEDURE Read_GL_NV_gpu_program5;
BEGIN
     glProgramSubroutineParametersuivNV := SYSTEM.VAL(TglProgramSubroutineParametersuivNV, wglGetProcAddress('glProgramSubroutineParametersuivNV'));
     glGetProgramSubroutineParameteruivNV := SYSTEM.VAL(TglGetProgramSubroutineParameteruivNV, wglGetProcAddress('glGetProgramSubroutineParameteruivNV'));
END Read_GL_NV_gpu_program5;

PROCEDURE Read_GL_NV_gpu_shader5;
BEGIN
     glUniform1i64NV := SYSTEM.VAL(TglUniform1i64NV, wglGetProcAddress('glUniform1i64NV'));
     glUniform2i64NV := SYSTEM.VAL(TglUniform2i64NV, wglGetProcAddress('glUniform2i64NV'));
     glUniform3i64NV := SYSTEM.VAL(TglUniform3i64NV, wglGetProcAddress('glUniform3i64NV'));
     glUniform4i64NV := SYSTEM.VAL(TglUniform4i64NV, wglGetProcAddress('glUniform4i64NV'));
     glUniform1i64vNV := SYSTEM.VAL(TglUniform1i64vNV, wglGetProcAddress('glUniform1i64vNV'));
     glUniform2i64vNV := SYSTEM.VAL(TglUniform2i64vNV, wglGetProcAddress('glUniform2i64vNV'));
     glUniform3i64vNV := SYSTEM.VAL(TglUniform3i64vNV, wglGetProcAddress('glUniform3i64vNV'));
     glUniform4i64vNV := SYSTEM.VAL(TglUniform4i64vNV, wglGetProcAddress('glUniform4i64vNV'));
     glUniform1ui64NV := SYSTEM.VAL(TglUniform1ui64NV, wglGetProcAddress('glUniform1ui64NV'));
     glUniform2ui64NV := SYSTEM.VAL(TglUniform2ui64NV, wglGetProcAddress('glUniform2ui64NV'));
     glUniform3ui64NV := SYSTEM.VAL(TglUniform3ui64NV, wglGetProcAddress('glUniform3ui64NV'));
     glUniform4ui64NV := SYSTEM.VAL(TglUniform4ui64NV, wglGetProcAddress('glUniform4ui64NV'));
     glUniform1ui64vNV := SYSTEM.VAL(TglUniform1ui64vNV, wglGetProcAddress('glUniform1ui64vNV'));
     glUniform2ui64vNV := SYSTEM.VAL(TglUniform2ui64vNV, wglGetProcAddress('glUniform2ui64vNV'));
     glUniform3ui64vNV := SYSTEM.VAL(TglUniform3ui64vNV, wglGetProcAddress('glUniform3ui64vNV'));
     glUniform4ui64vNV := SYSTEM.VAL(TglUniform4ui64vNV, wglGetProcAddress('glUniform4ui64vNV'));
     glGetUniformi64vNV := SYSTEM.VAL(TglGetUniformi64vNV, wglGetProcAddress('glGetUniformi64vNV'));
     glProgramUniform1i64NV := SYSTEM.VAL(TglProgramUniform1i64NV, wglGetProcAddress('glProgramUniform1i64NV'));
     glProgramUniform2i64NV := SYSTEM.VAL(TglProgramUniform2i64NV, wglGetProcAddress('glProgramUniform2i64NV'));
     glProgramUniform3i64NV := SYSTEM.VAL(TglProgramUniform3i64NV, wglGetProcAddress('glProgramUniform3i64NV'));
     glProgramUniform4i64NV := SYSTEM.VAL(TglProgramUniform4i64NV, wglGetProcAddress('glProgramUniform4i64NV'));
     glProgramUniform1i64vNV := SYSTEM.VAL(TglProgramUniform1i64vNV, wglGetProcAddress('glProgramUniform1i64vNV'));
     glProgramUniform2i64vNV := SYSTEM.VAL(TglProgramUniform2i64vNV, wglGetProcAddress('glProgramUniform2i64vNV'));
     glProgramUniform3i64vNV := SYSTEM.VAL(TglProgramUniform3i64vNV, wglGetProcAddress('glProgramUniform3i64vNV'));
     glProgramUniform4i64vNV := SYSTEM.VAL(TglProgramUniform4i64vNV, wglGetProcAddress('glProgramUniform4i64vNV'));
     glProgramUniform1ui64NV := SYSTEM.VAL(TglProgramUniform1ui64NV, wglGetProcAddress('glProgramUniform1ui64NV'));
     glProgramUniform2ui64NV := SYSTEM.VAL(TglProgramUniform2ui64NV, wglGetProcAddress('glProgramUniform2ui64NV'));
     glProgramUniform3ui64NV := SYSTEM.VAL(TglProgramUniform3ui64NV, wglGetProcAddress('glProgramUniform3ui64NV'));
     glProgramUniform4ui64NV := SYSTEM.VAL(TglProgramUniform4ui64NV, wglGetProcAddress('glProgramUniform4ui64NV'));
     glProgramUniform1ui64vNV := SYSTEM.VAL(TglProgramUniform1ui64vNV, wglGetProcAddress('glProgramUniform1ui64vNV'));
     glProgramUniform2ui64vNV := SYSTEM.VAL(TglProgramUniform2ui64vNV, wglGetProcAddress('glProgramUniform2ui64vNV'));
     glProgramUniform3ui64vNV := SYSTEM.VAL(TglProgramUniform3ui64vNV, wglGetProcAddress('glProgramUniform3ui64vNV'));
     glProgramUniform4ui64vNV := SYSTEM.VAL(TglProgramUniform4ui64vNV, wglGetProcAddress('glProgramUniform4ui64vNV'));
END Read_GL_NV_gpu_shader5;

PROCEDURE Read_GL_NV_vertex_attrib_integer_64bit;
BEGIN
     glVertexAttribL1i64NV := SYSTEM.VAL(TglVertexAttribL1i64NV, wglGetProcAddress('glVertexAttribL1i64NV'));
     glVertexAttribL2i64NV := SYSTEM.VAL(TglVertexAttribL2i64NV, wglGetProcAddress('glVertexAttribL2i64NV'));
     glVertexAttribL3i64NV := SYSTEM.VAL(TglVertexAttribL3i64NV, wglGetProcAddress('glVertexAttribL3i64NV'));
     glVertexAttribL4i64NV := SYSTEM.VAL(TglVertexAttribL4i64NV, wglGetProcAddress('glVertexAttribL4i64NV'));
     glVertexAttribL1i64vNV := SYSTEM.VAL(TglVertexAttribL1i64vNV, wglGetProcAddress('glVertexAttribL1i64vNV'));
     glVertexAttribL2i64vNV := SYSTEM.VAL(TglVertexAttribL2i64vNV, wglGetProcAddress('glVertexAttribL2i64vNV'));
     glVertexAttribL3i64vNV := SYSTEM.VAL(TglVertexAttribL3i64vNV, wglGetProcAddress('glVertexAttribL3i64vNV'));
     glVertexAttribL4i64vNV := SYSTEM.VAL(TglVertexAttribL4i64vNV, wglGetProcAddress('glVertexAttribL4i64vNV'));
     glVertexAttribL1ui64NV := SYSTEM.VAL(TglVertexAttribL1ui64NV, wglGetProcAddress('glVertexAttribL1ui64NV'));
     glVertexAttribL2ui64NV := SYSTEM.VAL(TglVertexAttribL2ui64NV, wglGetProcAddress('glVertexAttribL2ui64NV'));
     glVertexAttribL3ui64NV := SYSTEM.VAL(TglVertexAttribL3ui64NV, wglGetProcAddress('glVertexAttribL3ui64NV'));
     glVertexAttribL4ui64NV := SYSTEM.VAL(TglVertexAttribL4ui64NV, wglGetProcAddress('glVertexAttribL4ui64NV'));
     glVertexAttribL1ui64vNV := SYSTEM.VAL(TglVertexAttribL1ui64vNV, wglGetProcAddress('glVertexAttribL1ui64vNV'));
     glVertexAttribL2ui64vNV := SYSTEM.VAL(TglVertexAttribL2ui64vNV, wglGetProcAddress('glVertexAttribL2ui64vNV'));
     glVertexAttribL3ui64vNV := SYSTEM.VAL(TglVertexAttribL3ui64vNV, wglGetProcAddress('glVertexAttribL3ui64vNV'));
     glVertexAttribL4ui64vNV := SYSTEM.VAL(TglVertexAttribL4ui64vNV, wglGetProcAddress('glVertexAttribL4ui64vNV'));
     glGetVertexAttribLi64vNV := SYSTEM.VAL(TglGetVertexAttribLi64vNV, wglGetProcAddress('glGetVertexAttribLi64vNV'));
     glGetVertexAttribLui64vNV := SYSTEM.VAL(TglGetVertexAttribLui64vNV, wglGetProcAddress('glGetVertexAttribLui64vNV'));
     glVertexAttribLFormatNV := SYSTEM.VAL(TglVertexAttribLFormatNV, wglGetProcAddress('glVertexAttribLFormatNV'));
END Read_GL_NV_vertex_attrib_integer_64bit;

PROCEDURE Read_GL_NV_vdpau_interop;
BEGIN
     glVDPAUInitNV := SYSTEM.VAL(TglVDPAUInitNV, wglGetProcAddress('glVDPAUInitNV'));
     glVDPAUFiniNV := SYSTEM.VAL(TglVDPAUFiniNV, wglGetProcAddress('glVDPAUFiniNV'));
     glVDPAURegisterVideoSurfaceNV := SYSTEM.VAL(TglVDPAURegisterVideoSurfaceNV, wglGetProcAddress('glVDPAURegisterVideoSurfaceNV'));
     glVDPAURegisterOutputSurfaceNV := SYSTEM.VAL(TglVDPAURegisterOutputSurfaceNV, wglGetProcAddress('glVDPAURegisterOutputSurfaceNV'));
     glVDPAUIsSurfaceNV := SYSTEM.VAL(TglVDPAUIsSurfaceNV, wglGetProcAddress('glVDPAUIsSurfaceNV'));
     glVDPAUUnregisterSurfaceNV := SYSTEM.VAL(TglVDPAUUnregisterSurfaceNV, wglGetProcAddress('glVDPAUUnregisterSurfaceNV'));
     glVDPAUGetSurfaceivNV := SYSTEM.VAL(TglVDPAUGetSurfaceivNV, wglGetProcAddress('glVDPAUGetSurfaceivNV'));
     glVDPAUSurfaceAccessNV := SYSTEM.VAL(TglVDPAUSurfaceAccessNV, wglGetProcAddress('glVDPAUSurfaceAccessNV'));
     glVDPAUMapSurfacesNV := SYSTEM.VAL(TglVDPAUMapSurfacesNV, wglGetProcAddress('glVDPAUMapSurfacesNV'));
     glVDPAUUnmapSurfacesNV := SYSTEM.VAL(TglVDPAUUnmapSurfacesNV, wglGetProcAddress('glVDPAUUnmapSurfacesNV'));
END Read_GL_NV_vdpau_interop;

PROCEDURE Read_GL_NV_texture_barrier;
BEGIN
     glTextureBarrierNV := SYSTEM.VAL(TglTextureBarrierNV, wglGetProcAddress('glTextureBarrierNV'));
END Read_GL_NV_texture_barrier;

PROCEDURE Read_GL_PGI_misc_hints;
BEGIN
(*     glHintPGI := SYSTEM.VAL(TglHintPGI, wglGetProcAddress('glHintPGI'));
*)
END Read_GL_PGI_misc_hints;

PROCEDURE Read_GL_SGIS_detail_texture;
BEGIN
(*     glDetailTexFuncSGIS := SYSTEM.VAL(TglDetailTexFuncSGIS, wglGetProcAddress('glDetailTexFuncSGIS'));
     glGetDetailTexFuncSGIS := SYSTEM.VAL(TglGetDetailTexFuncSGIS, wglGetProcAddress('glGetDetailTexFuncSGIS'));
*)
END Read_GL_SGIS_detail_texture;

PROCEDURE Read_GL_SGIS_fog_function;
BEGIN
(*     glFogFuncSGIS := SYSTEM.VAL(TglFogFuncSGIS, wglGetProcAddress('glFogFuncSGIS'));
     glGetFogFuncSGIS := SYSTEM.VAL(TglGetFogFuncSGIS, wglGetProcAddress('glGetFogFuncSGIS'));
*)
END Read_GL_SGIS_fog_function;

PROCEDURE Read_GL_SGIS_multisample;
BEGIN
(*     glSampleMaskSGIS := SYSTEM.VAL(TglSampleMaskSGIS, wglGetProcAddress('glSampleMaskSGIS'));
     glSamplePatternSGIS := SYSTEM.VAL(TglSamplePatternSGIS, wglGetProcAddress('glSamplePatternSGIS'));
*)
END Read_GL_SGIS_multisample;

PROCEDURE Read_GL_SGIS_pixel_texture;
BEGIN
(*     glPixelTexGenParameteriSGIS := SYSTEM.VAL(TglPixelTexGenParameteriSGIS, wglGetProcAddress('glPixelTexGenParameteriSGIS'));
     glPixelTexGenParameterivSGIS := SYSTEM.VAL(TglPixelTexGenParameterivSGIS, wglGetProcAddress('glPixelTexGenParameterivSGIS'));
     glPixelTexGenParameterfSGIS := SYSTEM.VAL(TglPixelTexGenParameterfSGIS, wglGetProcAddress('glPixelTexGenParameterfSGIS'));
     glPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglPixelTexGenParameterfvSGIS, wglGetProcAddress('glPixelTexGenParameterfvSGIS'));
     glGetPixelTexGenParameterivSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterivSGIS, wglGetProcAddress('glGetPixelTexGenParameterivSGIS'));
     glGetPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterfvSGIS, wglGetProcAddress('glGetPixelTexGenParameterfvSGIS'));
*)
END Read_GL_SGIS_pixel_texture;

PROCEDURE Read_GL_SGIS_point_parameters;
BEGIN
(*     glPointParameterfSGIS := SYSTEM.VAL(TglPointParameterfSGIS, wglGetProcAddress('glPointParameterfSGIS'));
     glPointParameterfvSGIS := SYSTEM.VAL(TglPointParameterfvSGIS, wglGetProcAddress('glPointParameterfvSGIS'));
*)
END Read_GL_SGIS_point_parameters;

PROCEDURE Read_GL_SGIS_sharpen_texture;
BEGIN
(*     glSharpenTexFuncSGIS := SYSTEM.VAL(TglSharpenTexFuncSGIS, wglGetProcAddress('glSharpenTexFuncSGIS'));
     glGetSharpenTexFuncSGIS := SYSTEM.VAL(TglGetSharpenTexFuncSGIS, wglGetProcAddress('glGetSharpenTexFuncSGIS'));
*)
END Read_GL_SGIS_sharpen_texture;

PROCEDURE Read_GL_SGIS_texture4D;
BEGIN
(*     glTexImage4DSGIS := SYSTEM.VAL(TglTexImage4DSGIS, wglGetProcAddress('glTexImage4DSGIS'));
     glTexSubImage4DSGIS := SYSTEM.VAL(TglTexSubImage4DSGIS, wglGetProcAddress('glTexSubImage4DSGIS'));
*)
END Read_GL_SGIS_texture4D;

PROCEDURE Read_GL_SGIS_texture_color_mask;
BEGIN
(*     glTextureColorMaskSGIS := SYSTEM.VAL(TglTextureColorMaskSGIS, wglGetProcAddress('glTextureColorMaskSGIS'));
*)
END Read_GL_SGIS_texture_color_mask;

PROCEDURE Read_GL_SGIS_texture_filter4;
BEGIN
(*     glGetTexFilterFuncSGIS := SYSTEM.VAL(TglGetTexFilterFuncSGIS, wglGetProcAddress('glGetTexFilterFuncSGIS'));
     glTexFilterFuncSGIS := SYSTEM.VAL(TglTexFilterFuncSGIS, wglGetProcAddress('glTexFilterFuncSGIS'));
*)
END Read_GL_SGIS_texture_filter4;

PROCEDURE Read_GL_SGIX_async;
BEGIN
(*     glAsyncMarkerSGIX := SYSTEM.VAL(TglAsyncMarkerSGIX, wglGetProcAddress('glAsyncMarkerSGIX'));
     glFinishAsyncSGIX := SYSTEM.VAL(TglFinishAsyncSGIX, wglGetProcAddress('glFinishAsyncSGIX'));
     glPollAsyncSGIX := SYSTEM.VAL(TglPollAsyncSGIX, wglGetProcAddress('glPollAsyncSGIX'));
     glGenAsyncMarkersSGIX := SYSTEM.VAL(TglGenAsyncMarkersSGIX, wglGetProcAddress('glGenAsyncMarkersSGIX'));
     glDeleteAsyncMarkersSGIX := SYSTEM.VAL(TglDeleteAsyncMarkersSGIX, wglGetProcAddress('glDeleteAsyncMarkersSGIX'));
     glIsAsyncMarkerSGIX := SYSTEM.VAL(TglIsAsyncMarkerSGIX, wglGetProcAddress('glIsAsyncMarkerSGIX'));
*)
END Read_GL_SGIX_async;

PROCEDURE Read_GL_SGIX_flush_raster;
BEGIN
(*     glFlushRasterSGIX := SYSTEM.VAL(TglFlushRasterSGIX, wglGetProcAddress('glFlushRasterSGIX'));
*)
END Read_GL_SGIX_flush_raster;

PROCEDURE Read_GL_SGIX_fragment_lighting;
BEGIN
(*     glFragmentColorMaterialSGIX := SYSTEM.VAL(TglFragmentColorMaterialSGIX, wglGetProcAddress('glFragmentColorMaterialSGIX'));
     glFragmentLightfSGIX := SYSTEM.VAL(TglFragmentLightfSGIX, wglGetProcAddress('glFragmentLightfSGIX'));
     glFragmentLightfvSGIX := SYSTEM.VAL(TglFragmentLightfvSGIX, wglGetProcAddress('glFragmentLightfvSGIX'));
     glFragmentLightiSGIX := SYSTEM.VAL(TglFragmentLightiSGIX, wglGetProcAddress('glFragmentLightiSGIX'));
     glFragmentLightivSGIX := SYSTEM.VAL(TglFragmentLightivSGIX, wglGetProcAddress('glFragmentLightivSGIX'));
     glFragmentLightModelfSGIX := SYSTEM.VAL(TglFragmentLightModelfSGIX, wglGetProcAddress('glFragmentLightModelfSGIX'));
     glFragmentLightModelfvSGIX := SYSTEM.VAL(TglFragmentLightModelfvSGIX, wglGetProcAddress('glFragmentLightModelfvSGIX'));
     glFragmentLightModeliSGIX := SYSTEM.VAL(TglFragmentLightModeliSGIX, wglGetProcAddress('glFragmentLightModeliSGIX'));
     glFragmentLightModelivSGIX := SYSTEM.VAL(TglFragmentLightModelivSGIX, wglGetProcAddress('glFragmentLightModelivSGIX'));
     glFragmentMaterialfSGIX := SYSTEM.VAL(TglFragmentMaterialfSGIX, wglGetProcAddress('glFragmentMaterialfSGIX'));
     glFragmentMaterialfvSGIX := SYSTEM.VAL(TglFragmentMaterialfvSGIX, wglGetProcAddress('glFragmentMaterialfvSGIX'));
     glFragmentMaterialiSGIX := SYSTEM.VAL(TglFragmentMaterialiSGIX, wglGetProcAddress('glFragmentMaterialiSGIX'));
     glFragmentMaterialivSGIX := SYSTEM.VAL(TglFragmentMaterialivSGIX, wglGetProcAddress('glFragmentMaterialivSGIX'));
     glGetFragmentLightfvSGIX := SYSTEM.VAL(TglGetFragmentLightfvSGIX, wglGetProcAddress('glGetFragmentLightfvSGIX'));
     glGetFragmentLightivSGIX := SYSTEM.VAL(TglGetFragmentLightivSGIX, wglGetProcAddress('glGetFragmentLightivSGIX'));
     glGetFragmentMaterialfvSGIX := SYSTEM.VAL(TglGetFragmentMaterialfvSGIX, wglGetProcAddress('glGetFragmentMaterialfvSGIX'));
     glGetFragmentMaterialivSGIX := SYSTEM.VAL(TglGetFragmentMaterialivSGIX, wglGetProcAddress('glGetFragmentMaterialivSGIX'));
     glLightEnviSGIX := SYSTEM.VAL(TglLightEnviSGIX, wglGetProcAddress('glLightEnviSGIX'));
*)
END Read_GL_SGIX_fragment_lighting;

PROCEDURE Read_GL_SGIX_framezoom;
BEGIN
(*     glFrameZoomSGIX := SYSTEM.VAL(TglFrameZoomSGIX, wglGetProcAddress('glFrameZoomSGIX'));
*)
END Read_GL_SGIX_framezoom;

PROCEDURE Read_GL_SGIX_igloo_interface;
BEGIN
(*     glIglooInterfaceSGIX := SYSTEM.VAL(TglIglooInterfaceSGIX, wglGetProcAddress('glIglooInterfaceSGIX'));
*)
END Read_GL_SGIX_igloo_interface;

PROCEDURE Read_GL_SGIX_instruments;
BEGIN
(*     glGetInstrumentsSGIX := SYSTEM.VAL(TglGetInstrumentsSGIX, wglGetProcAddress('glGetInstrumentsSGIX'));
     glInstrumentsBufferSGIX := SYSTEM.VAL(TglInstrumentsBufferSGIX, wglGetProcAddress('glInstrumentsBufferSGIX'));
     glPollInstrumentsSGIX := SYSTEM.VAL(TglPollInstrumentsSGIX, wglGetProcAddress('glPollInstrumentsSGIX'));
     glReadInstrumentsSGIX := SYSTEM.VAL(TglReadInstrumentsSGIX, wglGetProcAddress('glReadInstrumentsSGIX'));
     glStartInstrumentsSGIX := SYSTEM.VAL(TglStartInstrumentsSGIX, wglGetProcAddress('glStartInstrumentsSGIX'));
     glStopInstrumentsSGIX := SYSTEM.VAL(TglStopInstrumentsSGIX, wglGetProcAddress('glStopInstrumentsSGIX'));
*)
END Read_GL_SGIX_instruments;

PROCEDURE Read_GL_SGIX_list_priority;
BEGIN
(*     glGetListParameterfvSGIX := SYSTEM.VAL(TglGetListParameterfvSGIX, wglGetProcAddress('glGetListParameterfvSGIX'));
     glGetListParameterivSGIX := SYSTEM.VAL(TglGetListParameterivSGIX, wglGetProcAddress('glGetListParameterivSGIX'));
     glListParameterfSGIX := SYSTEM.VAL(TglListParameterfSGIX, wglGetProcAddress('glListParameterfSGIX'));
     glListParameterfvSGIX := SYSTEM.VAL(TglListParameterfvSGIX, wglGetProcAddress('glListParameterfvSGIX'));
     glListParameteriSGIX := SYSTEM.VAL(TglListParameteriSGIX, wglGetProcAddress('glListParameteriSGIX'));
     glListParameterivSGIX := SYSTEM.VAL(TglListParameterivSGIX, wglGetProcAddress('glListParameterivSGIX'));
*)
END Read_GL_SGIX_list_priority;

PROCEDURE Read_GL_SGIX_pixel_texture;
BEGIN
(*     glPixelTexGenSGIX := SYSTEM.VAL(TglPixelTexGenSGIX, wglGetProcAddress('glPixelTexGenSGIX'));
*)
END Read_GL_SGIX_pixel_texture;

PROCEDURE Read_GL_SGIX_polynomial_ffd;
BEGIN
(*     glDeformationMap3dSGIX := SYSTEM.VAL(TglDeformationMap3dSGIX, wglGetProcAddress('glDeformationMap3dSGIX'));
     glDeformationMap3fSGIX := SYSTEM.VAL(TglDeformationMap3fSGIX, wglGetProcAddress('glDeformationMap3fSGIX'));
     glDeformSGIX := SYSTEM.VAL(TglDeformSGIX, wglGetProcAddress('glDeformSGIX'));
     glLoadIdentityDeformationMapSGIX := SYSTEM.VAL(TglLoadIdentityDeformationMapSGIX, wglGetProcAddress('glLoadIdentityDeformationMapSGIX'));
*)
END Read_GL_SGIX_polynomial_ffd;

PROCEDURE Read_GL_SGIX_reference_plane;
BEGIN
(*     glReferencePlaneSGIX := SYSTEM.VAL(TglReferencePlaneSGIX, wglGetProcAddress('glReferencePlaneSGIX'));
*)
END Read_GL_SGIX_reference_plane;

PROCEDURE Read_GL_SGIX_sprite;
BEGIN
(*     glSpriteParameterfSGIX := SYSTEM.VAL(TglSpriteParameterfSGIX, wglGetProcAddress('glSpriteParameterfSGIX'));
     glSpriteParameterfvSGIX := SYSTEM.VAL(TglSpriteParameterfvSGIX, wglGetProcAddress('glSpriteParameterfvSGIX'));
     glSpriteParameteriSGIX := SYSTEM.VAL(TglSpriteParameteriSGIX, wglGetProcAddress('glSpriteParameteriSGIX'));
     glSpriteParameterivSGIX := SYSTEM.VAL(TglSpriteParameterivSGIX, wglGetProcAddress('glSpriteParameterivSGIX'));
*)
END Read_GL_SGIX_sprite;

PROCEDURE Read_GL_SGIX_tag_sample_buffer;
BEGIN
(*     glTagSampleBufferSGIX := SYSTEM.VAL(TglTagSampleBufferSGIX, wglGetProcAddress('glTagSampleBufferSGIX'));
*)
END Read_GL_SGIX_tag_sample_buffer;

PROCEDURE Read_GL_SGI_color_table;
BEGIN
(*     glColorTableSGI := SYSTEM.VAL(TglColorTableSGI, wglGetProcAddress('glColorTableSGI'));
     glColorTableParameterfvSGI := SYSTEM.VAL(TglColorTableParameterfvSGI, wglGetProcAddress('glColorTableParameterfvSGI'));
     glColorTableParameterivSGI := SYSTEM.VAL(TglColorTableParameterivSGI, wglGetProcAddress('glColorTableParameterivSGI'));
     glCopyColorTableSGI := SYSTEM.VAL(TglCopyColorTableSGI, wglGetProcAddress('glCopyColorTableSGI'));
     glGetColorTableSGI := SYSTEM.VAL(TglGetColorTableSGI, wglGetProcAddress('glGetColorTableSGI'));
     glGetColorTableParameterfvSGI := SYSTEM.VAL(TglGetColorTableParameterfvSGI, wglGetProcAddress('glGetColorTableParameterfvSGI'));
     glGetColorTableParameterivSGI := SYSTEM.VAL(TglGetColorTableParameterivSGI, wglGetProcAddress('glGetColorTableParameterivSGI'));
*)
END Read_GL_SGI_color_table;

PROCEDURE Read_GL_SUNX_constant_data;
BEGIN
(*     glFinishTextureSUNX := SYSTEM.VAL(TglFinishTextureSUNX, wglGetProcAddress('glFinishTextureSUNX'));
*)
END Read_GL_SUNX_constant_data;

PROCEDURE Read_GL_SUN_global_alpha;
BEGIN
(*     glGlobalAlphaFactorbSUN := SYSTEM.VAL(TglGlobalAlphaFactorbSUN, wglGetProcAddress('glGlobalAlphaFactorbSUN'));
     glGlobalAlphaFactorsSUN := SYSTEM.VAL(TglGlobalAlphaFactorsSUN, wglGetProcAddress('glGlobalAlphaFactorsSUN'));
     glGlobalAlphaFactoriSUN := SYSTEM.VAL(TglGlobalAlphaFactoriSUN, wglGetProcAddress('glGlobalAlphaFactoriSUN'));
     glGlobalAlphaFactorfSUN := SYSTEM.VAL(TglGlobalAlphaFactorfSUN, wglGetProcAddress('glGlobalAlphaFactorfSUN'));
     glGlobalAlphaFactordSUN := SYSTEM.VAL(TglGlobalAlphaFactordSUN, wglGetProcAddress('glGlobalAlphaFactordSUN'));
     glGlobalAlphaFactorubSUN := SYSTEM.VAL(TglGlobalAlphaFactorubSUN, wglGetProcAddress('glGlobalAlphaFactorubSUN'));
     glGlobalAlphaFactorusSUN := SYSTEM.VAL(TglGlobalAlphaFactorusSUN, wglGetProcAddress('glGlobalAlphaFactorusSUN'));
     glGlobalAlphaFactoruiSUN := SYSTEM.VAL(TglGlobalAlphaFactoruiSUN, wglGetProcAddress('glGlobalAlphaFactoruiSUN'));
*)
END Read_GL_SUN_global_alpha;

PROCEDURE Read_GL_SUN_mesh_array;
BEGIN
(*     glDrawMeshArraysSUN := SYSTEM.VAL(TglDrawMeshArraysSUN, wglGetProcAddress('glDrawMeshArraysSUN'));
*)
END Read_GL_SUN_mesh_array;

PROCEDURE Read_GL_SUN_triangle_list;
BEGIN
(*     glReplacementCodeuiSUN := SYSTEM.VAL(TglReplacementCodeuiSUN, wglGetProcAddress('glReplacementCodeuiSUN'));
     glReplacementCodeusSUN := SYSTEM.VAL(TglReplacementCodeusSUN, wglGetProcAddress('glReplacementCodeusSUN'));
     glReplacementCodeubSUN := SYSTEM.VAL(TglReplacementCodeubSUN, wglGetProcAddress('glReplacementCodeubSUN'));
     glReplacementCodeuivSUN := SYSTEM.VAL(TglReplacementCodeuivSUN, wglGetProcAddress('glReplacementCodeuivSUN'));
     glReplacementCodeusvSUN := SYSTEM.VAL(TglReplacementCodeusvSUN, wglGetProcAddress('glReplacementCodeusvSUN'));
     glReplacementCodeubvSUN := SYSTEM.VAL(TglReplacementCodeubvSUN, wglGetProcAddress('glReplacementCodeubvSUN'));
     glReplacementCodePointerSUN := SYSTEM.VAL(TglReplacementCodePointerSUN, wglGetProcAddress('glReplacementCodePointerSUN'));
*)
END Read_GL_SUN_triangle_list;

PROCEDURE Read_GL_SUN_vertex;
BEGIN
(*     glColor4ubVertex2fSUN := SYSTEM.VAL(TglColor4ubVertex2fSUN, wglGetProcAddress('glColor4ubVertex2fSUN'));
     glColor4ubVertex2fvSUN := SYSTEM.VAL(TglColor4ubVertex2fvSUN, wglGetProcAddress('glColor4ubVertex2fvSUN'));
     glColor4ubVertex3fSUN := SYSTEM.VAL(TglColor4ubVertex3fSUN, wglGetProcAddress('glColor4ubVertex3fSUN'));
     glColor4ubVertex3fvSUN := SYSTEM.VAL(TglColor4ubVertex3fvSUN, wglGetProcAddress('glColor4ubVertex3fvSUN'));
     glColor3fVertex3fSUN := SYSTEM.VAL(TglColor3fVertex3fSUN, wglGetProcAddress('glColor3fVertex3fSUN'));
     glColor3fVertex3fvSUN := SYSTEM.VAL(TglColor3fVertex3fvSUN, wglGetProcAddress('glColor3fVertex3fvSUN'));
     glNormal3fVertex3fSUN := SYSTEM.VAL(TglNormal3fVertex3fSUN, wglGetProcAddress('glNormal3fVertex3fSUN'));
     glNormal3fVertex3fvSUN := SYSTEM.VAL(TglNormal3fVertex3fvSUN, wglGetProcAddress('glNormal3fVertex3fvSUN'));
     glColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fSUN, wglGetProcAddress('glColor4fNormal3fVertex3fSUN'));
     glColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fvSUN, wglGetProcAddress('glColor4fNormal3fVertex3fvSUN'));
     glTexCoord2fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fVertex3fSUN, wglGetProcAddress('glTexCoord2fVertex3fSUN'));
     glTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fVertex3fvSUN, wglGetProcAddress('glTexCoord2fVertex3fvSUN'));
     glTexCoord4fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fVertex4fSUN, wglGetProcAddress('glTexCoord4fVertex4fSUN'));
     glTexCoord4fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fVertex4fvSUN, wglGetProcAddress('glTexCoord4fVertex4fvSUN'));
     glTexCoord2fColor4ubVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fSUN, wglGetProcAddress('glTexCoord2fColor4ubVertex3fSUN'));
     glTexCoord2fColor4ubVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fvSUN, wglGetProcAddress('glTexCoord2fColor4ubVertex3fvSUN'));
     glTexCoord2fColor3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fSUN, wglGetProcAddress('glTexCoord2fColor3fVertex3fSUN'));
     glTexCoord2fColor3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fvSUN, wglGetProcAddress('glTexCoord2fColor3fVertex3fvSUN'));
     glTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fSUN, wglGetProcAddress('glTexCoord2fNormal3fVertex3fSUN'));
     glTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fvSUN, wglGetProcAddress('glTexCoord2fNormal3fVertex3fvSUN'));
     glTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fSUN, wglGetProcAddress('glTexCoord2fColor4fNormal3fVertex3fSUN'));
     glTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fvSUN, wglGetProcAddress('glTexCoord2fColor4fNormal3fVertex3fvSUN'));
     glTexCoord4fColor4fNormal3fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fSUN, wglGetProcAddress('glTexCoord4fColor4fNormal3fVertex4fSUN'));
     glTexCoord4fColor4fNormal3fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fvSUN, wglGetProcAddress('glTexCoord4fColor4fNormal3fVertex4fvSUN'));
     glReplacementCodeuiVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fSUN, wglGetProcAddress('glReplacementCodeuiVertex3fSUN'));
     glReplacementCodeuiVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiVertex3fvSUN'));
     glReplacementCodeuiColor4ubVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fSUN, wglGetProcAddress('glReplacementCodeuiColor4ubVertex3fSUN'));
     glReplacementCodeuiColor4ubVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiColor4ubVertex3fvSUN'));
     glReplacementCodeuiColor3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiColor3fVertex3fSUN'));
     glReplacementCodeuiColor3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiColor3fVertex3fvSUN'));
     glReplacementCodeuiNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiNormal3fVertex3fSUN'));
     glReplacementCodeuiNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiNormal3fVertex3fvSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN, wglGetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN'));
*)
END Read_GL_SUN_vertex;

PROCEDURE Read_WGL_ARB_buffer_region;
BEGIN
     wglCreateBufferRegionARB := SYSTEM.VAL(TwglCreateBufferRegionARB, wglGetProcAddress('wglCreateBufferRegionARB'));
     wglDeleteBufferRegionARB := SYSTEM.VAL(TwglDeleteBufferRegionARB, wglGetProcAddress('wglDeleteBufferRegionARB'));
     wglSaveBufferRegionARB := SYSTEM.VAL(TwglSaveBufferRegionARB, wglGetProcAddress('wglSaveBufferRegionARB'));
     wglRestoreBufferRegionARB := SYSTEM.VAL(TwglRestoreBufferRegionARB, wglGetProcAddress('wglRestoreBufferRegionARB'));
END Read_WGL_ARB_buffer_region;

PROCEDURE Read_WGL_ARB_extensionsxstring;
BEGIN
     wglGetExtensionsStringARB := SYSTEM.VAL(TwglGetExtensionsStringARB, wglGetProcAddress('wglGetExtensionsStringARB'));
END Read_WGL_ARB_extensionsxstring;

PROCEDURE Read_WGL_ARB_make_current_read;
BEGIN
     wglMakeContextCurrentARB := SYSTEM.VAL(TwglMakeContextCurrentARB, wglGetProcAddress('wglMakeContextCurrentARB'));
     wglGetCurrentReadDCARB := SYSTEM.VAL(TwglGetCurrentReadDCARB, wglGetProcAddress('wglGetCurrentReadDCARB'));
END Read_WGL_ARB_make_current_read;

PROCEDURE Read_WGL_ARB_pbuffer;
BEGIN
     wglCreatePbufferARB := SYSTEM.VAL(TwglCreatePbufferARB, wglGetProcAddress('wglCreatePbufferARB'));
     wglGetPbufferDCARB := SYSTEM.VAL(TwglGetPbufferDCARB, wglGetProcAddress('wglGetPbufferDCARB'));
     wglReleasePbufferDCARB := SYSTEM.VAL(TwglReleasePbufferDCARB, wglGetProcAddress('wglReleasePbufferDCARB'));
     wglDestroyPbufferARB := SYSTEM.VAL(TwglDestroyPbufferARB, wglGetProcAddress('wglDestroyPbufferARB'));
     wglQueryPbufferARB := SYSTEM.VAL(TwglQueryPbufferARB, wglGetProcAddress('wglQueryPbufferARB'));
END Read_WGL_ARB_pbuffer;

PROCEDURE Read_WGL_ARB_pixel_format;
BEGIN
     wglGetPixelFormatAttribivARB := SYSTEM.VAL(TwglGetPixelFormatAttribivARB, wglGetProcAddress('wglGetPixelFormatAttribivARB'));
     wglGetPixelFormatAttribfvARB := SYSTEM.VAL(TwglGetPixelFormatAttribfvARB, wglGetProcAddress('wglGetPixelFormatAttribfvARB'));
     wglChoosePixelFormatARB := SYSTEM.VAL(TwglChoosePixelFormatARB, wglGetProcAddress('wglChoosePixelFormatARB'));
END Read_WGL_ARB_pixel_format;

PROCEDURE Read_WGL_ARB_pixel_format_float;
BEGIN
     wglClampColorARB := SYSTEM.VAL(TwglClampColorARB, wglGetProcAddress('wglClampColorARB'));
END Read_WGL_ARB_pixel_format_float;

PROCEDURE Read_WGL_ARB_render_texture;
BEGIN
     wglBindTexImageARB := SYSTEM.VAL(TwglBindTexImageARB, wglGetProcAddress('wglBindTexImageARB'));
     wglReleaseTexImageARB := SYSTEM.VAL(TwglReleaseTexImageARB, wglGetProcAddress('wglReleaseTexImageARB'));
     wglSetPbufferAttribARB := SYSTEM.VAL(TwglSetPbufferAttribARB, wglGetProcAddress('wglSetPbufferAttribARB'));
END Read_WGL_ARB_render_texture;

PROCEDURE Read_WGL_ARB_create_context;
BEGIN
     wglCreateContextAttribsARB := SYSTEM.VAL(TwglCreateContextAttribsARB, wglGetProcAddress('wglCreateContextAttribsARB'));
END Read_WGL_ARB_create_context;

PROCEDURE Read_WGL_AMD_gpu_association;
BEGIN
     wglGetGPUIDsAMD := SYSTEM.VAL(TwglGetGPUIDsAMD, wglGetProcAddress('wglGetGPUIDsAMD'));
     wglGetGPUInfoAMD := SYSTEM.VAL(TwglGetGPUInfoAMD, wglGetProcAddress('wglGetGPUInfoAMD'));
     wglGetContextGPUIDAMD := SYSTEM.VAL(TwglGetContextGPUIDAMD, wglGetProcAddress('wglGetContextGPUIDAMD'));
     wglCreateAssociatedContextAMD := SYSTEM.VAL(TwglCreateAssociatedContextAMD, wglGetProcAddress('wglCreateAssociatedContextAMD'));
     wglCreateAssociatedContextAttribsAMD := SYSTEM.VAL(TwglCreateAssociatedContextAttribsAMD, wglGetProcAddress('wglCreateAssociatedContextAttribsAMD'));
     wglDeleteAssociatedContextAMD := SYSTEM.VAL(TwglDeleteAssociatedContextAMD, wglGetProcAddress('wglDeleteAssociatedContextAMD'));
     wglMakeAssociatedContextCurrentAMD := SYSTEM.VAL(TwglMakeAssociatedContextCurrentAMD, wglGetProcAddress('wglMakeAssociatedContextCurrentAMD'));
     wglGetCurrentAssociatedContextAMD := SYSTEM.VAL(TwglGetCurrentAssociatedContextAMD, wglGetProcAddress('wglGetCurrentAssociatedContextAMD'));
     wglBlitContextFramebufferAMD := SYSTEM.VAL(TwglBlitContextFramebufferAMD, wglGetProcAddress('wglBlitContextFramebufferAMD'));
END Read_WGL_AMD_gpu_association;

PROCEDURE Read_WGL_EXT_display_color_table;
BEGIN
     wglCreateDisplayColorTableEXT := SYSTEM.VAL(TwglCreateDisplayColorTableEXT, wglGetProcAddress('wglCreateDisplayColorTableEXT'));
     wglLoadDisplayColorTableEXT := SYSTEM.VAL(TwglLoadDisplayColorTableEXT, wglGetProcAddress('wglLoadDisplayColorTableEXT'));
     wglBindDisplayColorTableEXT := SYSTEM.VAL(TwglBindDisplayColorTableEXT, wglGetProcAddress('wglBindDisplayColorTableEXT'));
     wglDestroyDisplayColorTableEXT := SYSTEM.VAL(TwglDestroyDisplayColorTableEXT, wglGetProcAddress('wglDestroyDisplayColorTableEXT'));
END Read_WGL_EXT_display_color_table;

PROCEDURE Read_WGL_EXT_extensionsxstring;
BEGIN
     wglGetExtensionsStringEXT := SYSTEM.VAL(TwglGetExtensionsStringEXT, wglGetProcAddress('wglGetExtensionsStringEXT'));
END Read_WGL_EXT_extensionsxstring;

PROCEDURE Read_WGL_EXT_make_current_read;
BEGIN
     wglMakeContextCurrentEXT := SYSTEM.VAL(TwglMakeContextCurrentEXT, wglGetProcAddress('wglMakeContextCurrentEXT'));
     wglGetCurrentReadDCEXT := SYSTEM.VAL(TwglGetCurrentReadDCEXT, wglGetProcAddress('wglGetCurrentReadDCEXT'));
END Read_WGL_EXT_make_current_read;

PROCEDURE Read_WGL_EXT_pbuffer;
BEGIN
     wglCreatePbufferEXT := SYSTEM.VAL(TwglCreatePbufferEXT, wglGetProcAddress('wglCreatePbufferEXT'));
     wglGetPbufferDCEXT := SYSTEM.VAL(TwglGetPbufferDCEXT, wglGetProcAddress('wglGetPbufferDCEXT'));
     wglReleasePbufferDCEXT := SYSTEM.VAL(TwglReleasePbufferDCEXT, wglGetProcAddress('wglReleasePbufferDCEXT'));
     wglDestroyPbufferEXT := SYSTEM.VAL(TwglDestroyPbufferEXT, wglGetProcAddress('wglDestroyPbufferEXT'));
     wglQueryPbufferEXT := SYSTEM.VAL(TwglQueryPbufferEXT, wglGetProcAddress('wglQueryPbufferEXT'));
END Read_WGL_EXT_pbuffer;

PROCEDURE Read_WGL_EXT_pixel_format;
BEGIN
     wglGetPixelFormatAttribivEXT := SYSTEM.VAL(TwglGetPixelFormatAttribivEXT, wglGetProcAddress('wglGetPixelFormatAttribivEXT'));
     wglGetPixelFormatAttribfvEXT := SYSTEM.VAL(TwglGetPixelFormatAttribfvEXT, wglGetProcAddress('wglGetPixelFormatAttribfvEXT'));
     wglChoosePixelFormatEXT := SYSTEM.VAL(TwglChoosePixelFormatEXT, wglGetProcAddress('wglChoosePixelFormatEXT'));
END Read_WGL_EXT_pixel_format;

PROCEDURE Read_WGL_EXT_swap_control;
BEGIN
     wglSwapIntervalEXT := SYSTEM.VAL(TwglSwapIntervalEXT, wglGetProcAddress('wglSwapIntervalEXT'));
     wglGetSwapIntervalEXT := SYSTEM.VAL(TwglGetSwapIntervalEXT, wglGetProcAddress('wglGetSwapIntervalEXT'));
END Read_WGL_EXT_swap_control;

PROCEDURE Read_WGL_I3D_digital_video_control;
BEGIN
     wglGetDigitalVideoParametersI3D := SYSTEM.VAL(TwglGetDigitalVideoParametersI3D, wglGetProcAddress('wglGetDigitalVideoParametersI3D'));
     wglSetDigitalVideoParametersI3D := SYSTEM.VAL(TwglSetDigitalVideoParametersI3D, wglGetProcAddress('wglSetDigitalVideoParametersI3D'));
END Read_WGL_I3D_digital_video_control;

PROCEDURE Read_WGL_I3D_gamma;
BEGIN
     wglGetGammaTableParametersI3D := SYSTEM.VAL(TwglGetGammaTableParametersI3D, wglGetProcAddress('wglGetGammaTableParametersI3D'));
     wglSetGammaTableParametersI3D := SYSTEM.VAL(TwglSetGammaTableParametersI3D, wglGetProcAddress('wglSetGammaTableParametersI3D'));
     wglGetGammaTableI3D := SYSTEM.VAL(TwglGetGammaTableI3D, wglGetProcAddress('wglGetGammaTableI3D'));
     wglSetGammaTableI3D := SYSTEM.VAL(TwglSetGammaTableI3D, wglGetProcAddress('wglSetGammaTableI3D'));
END Read_WGL_I3D_gamma;

PROCEDURE Read_WGL_I3D_genlock;
BEGIN
     wglEnableGenlockI3D := SYSTEM.VAL(TwglEnableGenlockI3D, wglGetProcAddress('wglEnableGenlockI3D'));
     wglDisableGenlockI3D := SYSTEM.VAL(TwglDisableGenlockI3D, wglGetProcAddress('wglDisableGenlockI3D'));
     wglIsEnabledGenlockI3D := SYSTEM.VAL(TwglIsEnabledGenlockI3D, wglGetProcAddress('wglIsEnabledGenlockI3D'));
     wglGenlockSourceI3D := SYSTEM.VAL(TwglGenlockSourceI3D, wglGetProcAddress('wglGenlockSourceI3D'));
     wglGetGenlockSourceI3D := SYSTEM.VAL(TwglGetGenlockSourceI3D, wglGetProcAddress('wglGetGenlockSourceI3D'));
     wglGenlockSourceEdgeI3D := SYSTEM.VAL(TwglGenlockSourceEdgeI3D, wglGetProcAddress('wglGenlockSourceEdgeI3D'));
     wglGetGenlockSourceEdgeI3D := SYSTEM.VAL(TwglGetGenlockSourceEdgeI3D, wglGetProcAddress('wglGetGenlockSourceEdgeI3D'));
     wglGenlockSampleRateI3D := SYSTEM.VAL(TwglGenlockSampleRateI3D, wglGetProcAddress('wglGenlockSampleRateI3D'));
     wglGetGenlockSampleRateI3D := SYSTEM.VAL(TwglGetGenlockSampleRateI3D, wglGetProcAddress('wglGetGenlockSampleRateI3D'));
     wglGenlockSourceDelayI3D := SYSTEM.VAL(TwglGenlockSourceDelayI3D, wglGetProcAddress('wglGenlockSourceDelayI3D'));
     wglGetGenlockSourceDelayI3D := SYSTEM.VAL(TwglGetGenlockSourceDelayI3D, wglGetProcAddress('wglGetGenlockSourceDelayI3D'));
     wglQueryGenlockMaxSourceDelayI3D := SYSTEM.VAL(TwglQueryGenlockMaxSourceDelayI3D, wglGetProcAddress('wglQueryGenlockMaxSourceDelayI3D'));
END Read_WGL_I3D_genlock;

PROCEDURE Read_WGL_I3D_image_buffer;
BEGIN
     wglCreateImageBufferI3D := SYSTEM.VAL(TwglCreateImageBufferI3D, wglGetProcAddress('wglCreateImageBufferI3D'));
     wglDestroyImageBufferI3D := SYSTEM.VAL(TwglDestroyImageBufferI3D, wglGetProcAddress('wglDestroyImageBufferI3D'));
     wglAssociateImageBufferEventsI3D := SYSTEM.VAL(TwglAssociateImageBufferEventsI3D, wglGetProcAddress('wglAssociateImageBufferEventsI3D'));
     wglReleaseImageBufferEventsI3D := SYSTEM.VAL(TwglReleaseImageBufferEventsI3D, wglGetProcAddress('wglReleaseImageBufferEventsI3D'));
END Read_WGL_I3D_image_buffer;

PROCEDURE Read_WGL_I3D_swap_frame_lock;
BEGIN
     wglEnableFrameLockI3D := SYSTEM.VAL(TwglEnableFrameLockI3D, wglGetProcAddress('wglEnableFrameLockI3D'));
     wglDisableFrameLockI3D := SYSTEM.VAL(TwglDisableFrameLockI3D, wglGetProcAddress('wglDisableFrameLockI3D'));
     wglIsEnabledFrameLockI3D := SYSTEM.VAL(TwglIsEnabledFrameLockI3D, wglGetProcAddress('wglIsEnabledFrameLockI3D'));
     wglQueryFrameLockMasterI3D := SYSTEM.VAL(TwglQueryFrameLockMasterI3D, wglGetProcAddress('wglQueryFrameLockMasterI3D'));
END Read_WGL_I3D_swap_frame_lock;

PROCEDURE Read_WGL_I3D_swap_frame_usage;
BEGIN
     wglGetFrameUsageI3D := SYSTEM.VAL(TwglGetFrameUsageI3D, wglGetProcAddress('wglGetFrameUsageI3D'));
     wglBeginFrameTrackingI3D := SYSTEM.VAL(TwglBeginFrameTrackingI3D, wglGetProcAddress('wglBeginFrameTrackingI3D'));
     wglEndFrameTrackingI3D := SYSTEM.VAL(TwglEndFrameTrackingI3D, wglGetProcAddress('wglEndFrameTrackingI3D'));
     wglQueryFrameTrackingI3D := SYSTEM.VAL(TwglQueryFrameTrackingI3D, wglGetProcAddress('wglQueryFrameTrackingI3D'));
END Read_WGL_I3D_swap_frame_usage;

PROCEDURE Read_WGL_NV_vertex_array_range;
BEGIN
     wglAllocateMemoryNV := SYSTEM.VAL(TwglAllocateMemoryNV, wglGetProcAddress('wglAllocateMemoryNV'));
     wglFreeMemoryNV := SYSTEM.VAL(TwglFreeMemoryNV, wglGetProcAddress('wglFreeMemoryNV'));
END Read_WGL_NV_vertex_array_range;

PROCEDURE Read_WGL_NV_present_video;
BEGIN
     wglEnumerateVideoDevicesNV := SYSTEM.VAL(TwglEnumerateVideoDevicesNV, wglGetProcAddress('wglEnumerateVideoDevicesNV'));
(*     wglBindVideoDeviceNV := SYSTEM.VAL(TwglBindVideoDeviceNV, wglGetProcAddress('wglBindVideoDeviceNV')); *)
     wglQueryCurrentContextNV := SYSTEM.VAL(TwglQueryCurrentContextNV, wglGetProcAddress('wglQueryCurrentContextNV'));
END Read_WGL_NV_present_video;

PROCEDURE Read_WGL_NV_video_output;
BEGIN
     wglGetVideoDeviceNV := SYSTEM.VAL(TwglGetVideoDeviceNV, wglGetProcAddress('wglGetVideoDeviceNV'));
     wglReleaseVideoDeviceNV := SYSTEM.VAL(TwglReleaseVideoDeviceNV, wglGetProcAddress('wglReleaseVideoDeviceNV'));
     wglBindVideoImageNV := SYSTEM.VAL(TwglBindVideoImageNV, wglGetProcAddress('wglBindVideoImageNV'));
     wglReleaseVideoImageNV := SYSTEM.VAL(TwglReleaseVideoImageNV, wglGetProcAddress('wglReleaseVideoImageNV'));
     wglSendPbufferToVideoNV := SYSTEM.VAL(TwglSendPbufferToVideoNV, wglGetProcAddress('wglSendPbufferToVideoNV'));
     wglGetVideoInfoNV := SYSTEM.VAL(TwglGetVideoInfoNV, wglGetProcAddress('wglGetVideoInfoNV'));
END Read_WGL_NV_video_output;

PROCEDURE Read_WGL_NV_swap_group;
BEGIN
     wglJoinSwapGroupNV := SYSTEM.VAL(TwglJoinSwapGroupNV, wglGetProcAddress('wglJoinSwapGroupNV'));
     wglBindSwapBarrierNV := SYSTEM.VAL(TwglBindSwapBarrierNV, wglGetProcAddress('wglBindSwapBarrierNV'));
     wglQuerySwapGroupNV := SYSTEM.VAL(TwglQuerySwapGroupNV, wglGetProcAddress('wglQuerySwapGroupNV'));
     wglQueryMaxSwapGroupsNV := SYSTEM.VAL(TwglQueryMaxSwapGroupsNV, wglGetProcAddress('wglQueryMaxSwapGroupsNV'));
     wglQueryFrameCountNV := SYSTEM.VAL(TwglQueryFrameCountNV, wglGetProcAddress('wglQueryFrameCountNV'));
     wglResetFrameCountNV := SYSTEM.VAL(TwglResetFrameCountNV, wglGetProcAddress('wglResetFrameCountNV'));
END Read_WGL_NV_swap_group;

PROCEDURE Read_WGL_NV_gpu_affinity;
BEGIN
     wglEnumGpusNV := SYSTEM.VAL(TwglEnumGpusNV, wglGetProcAddress('wglEnumGpusNV'));
     wglEnumGpuDevicesNV := SYSTEM.VAL(TwglEnumGpuDevicesNV, wglGetProcAddress('wglEnumGpuDevicesNV'));
     wglCreateAffinityDCNV := SYSTEM.VAL(TwglCreateAffinityDCNV, wglGetProcAddress('wglCreateAffinityDCNV'));
     wglEnumGpusFromAffinityDCNV := SYSTEM.VAL(TwglEnumGpusFromAffinityDCNV, wglGetProcAddress('wglEnumGpusFromAffinityDCNV'));
     wglDeleteDCNV := SYSTEM.VAL(TwglDeleteDCNV, wglGetProcAddress('wglDeleteDCNV'));
END Read_WGL_NV_gpu_affinity;

PROCEDURE Read_WGL_NV_video_capture;
BEGIN
     wglBindVideoCaptureDeviceNV := SYSTEM.VAL(TwglBindVideoCaptureDeviceNV, wglGetProcAddress('wglBindVideoCaptureDeviceNV'));
     wglEnumerateVideoCaptureDevicesNV := SYSTEM.VAL(TwglEnumerateVideoCaptureDevicesNV, wglGetProcAddress('wglEnumerateVideoCaptureDevicesNV'));
     wglLockVideoCaptureDeviceNV := SYSTEM.VAL(TwglLockVideoCaptureDeviceNV, wglGetProcAddress('wglLockVideoCaptureDeviceNV'));
     wglQueryVideoCaptureDeviceNV := SYSTEM.VAL(TwglQueryVideoCaptureDeviceNV, wglGetProcAddress('wglQueryVideoCaptureDeviceNV'));
     wglReleaseVideoCaptureDeviceNV := SYSTEM.VAL(TwglReleaseVideoCaptureDeviceNV, wglGetProcAddress('wglReleaseVideoCaptureDeviceNV'));
END Read_WGL_NV_video_capture;

PROCEDURE Read_WGL_NV_copy_image;
BEGIN
     wglCopyImageSubDataNV := SYSTEM.VAL(TwglCopyImageSubDataNV, wglGetProcAddress('wglCopyImageSubDataNV'));
END Read_WGL_NV_copy_image;

PROCEDURE Read_WGL_OML_sync_control;
BEGIN
     wglGetSyncValuesOML := SYSTEM.VAL(TwglGetSyncValuesOML, wglGetProcAddress('wglGetSyncValuesOML'));
     wglGetMscRateOML := SYSTEM.VAL(TwglGetMscRateOML, wglGetProcAddress('wglGetMscRateOML'));
     wglSwapBuffersMscOML := SYSTEM.VAL(TwglSwapBuffersMscOML, wglGetProcAddress('wglSwapBuffersMscOML'));
     wglSwapLayerBuffersMscOML := SYSTEM.VAL(TwglSwapLayerBuffersMscOML, wglGetProcAddress('wglSwapLayerBuffersMscOML'));
     wglWaitForMscOML := SYSTEM.VAL(TwglWaitForMscOML, wglGetProcAddress('wglWaitForMscOML'));
     wglWaitForSbcOML := SYSTEM.VAL(TwglWaitForSbcOML, wglGetProcAddress('wglWaitForSbcOML'));
END Read_WGL_OML_sync_control;

PROCEDURE Read_WGL_3DL_stereo_control;
BEGIN
(*     wglSetStereoEmitterState3DL := SYSTEM.VAL(TwglSetStereoEmitterState3DL, wglGetProcAddress('wglSetStereoEmitterState3DL'));*)
END Read_WGL_3DL_stereo_control;

PROCEDURE Read_WIN_draw_range_elements;
BEGIN
     glDrawRangeElementsWIN := SYSTEM.VAL(TglDrawRangeElementsWIN, wglGetProcAddress('glDrawRangeElementsWIN'));
END Read_WIN_draw_range_elements;

PROCEDURE Read_WIN_swap_hint;
BEGIN
     glAddSwapHintRectWIN := SYSTEM.VAL(TglAddSwapHintRectWIN, wglGetProcAddress('glAddSwapHintRectWIN'));
END Read_WIN_swap_hint;


(***********************)

PROCEDURE ReadExtensions*;
BEGIN
    
	ReadOpenGLCore;
	   KernelLog.String(" ReadExtensions ");
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

(* IFDEF DGL_WIN *)
  Read_WGL_ARB_buffer_region;
  Read_WGL_ARB_extensionsxstring;
  Read_WGL_ARB_make_current_read;
  Read_WGL_ARB_pbuffer;
  Read_WGL_ARB_pixel_format;
  Read_WGL_ARB_pixel_format_float;
  Read_WGL_ARB_render_texture;
  Read_WGL_ARB_create_context;
  Read_WGL_AMD_gpu_association;
  Read_WGL_EXT_display_color_table;
  Read_WGL_EXT_extensionsxstring;
  Read_WGL_EXT_make_current_read;
  Read_WGL_EXT_pbuffer;
  Read_WGL_EXT_pixel_format;
  Read_WGL_EXT_swap_control;
  Read_WGL_I3D_digital_video_control;
  Read_WGL_I3D_gamma;
  Read_WGL_I3D_genlock;
  Read_WGL_I3D_image_buffer;
  Read_WGL_I3D_swap_frame_lock;
  Read_WGL_I3D_swap_frame_usage;
  Read_WGL_NV_vertex_array_range;
  Read_WGL_NV_present_video;
  Read_WGL_NV_video_output;
  Read_WGL_NV_swap_group;
  Read_WGL_NV_gpu_affinity;
  Read_WGL_NV_video_capture;
  Read_WGL_NV_copy_image;
  Read_WGL_OML_sync_control;
  Read_WGL_3DL_stereo_control;

  Read_WIN_draw_range_elements;
  Read_WIN_swap_hint;
  
(* ENDIF *)
KernelLog.String(" Ok. ");  KernelLog.Ln; 
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
BEGIN {EXCLUSIVE}
	sadr := glGetString(name);
	RETURN GetStringFromAddr(sadr);	
END GLGetString;

PROCEDURE GLUGetString*(name: GLenum): Strings.String;
VAR  sadr: LONGINT;
BEGIN {EXCLUSIVE}
  	sadr := gluGetString(name); 
	RETURN GetStringFromAddr(sadr);	
END GLUGetString;

PROCEDURE GLUErrorString*(err: GLenum):Strings.String;
VAR  sadr: LONGINT;
BEGIN {EXCLUSIVE}
  	sadr := gluErrorString(err); 
	RETURN GetStringFromAddr(sadr);	
END GLUErrorString;


PROCEDURE wglEXTStrings*(): Strings.String;
VAR  sadr: LONGINT;
BEGIN {EXCLUSIVE}
	sadr := wglGetExtensionsStringEXT(); 
	RETURN GetStringFromAddr(sadr);
END wglEXTStrings;

PROCEDURE wglARBStrings*(): Strings.String;
VAR  sadr: LONGINT;
BEGIN {EXCLUSIVE}
	sadr := wglGetExtensionsStringARB(wglGetCurrentDC());
	RETURN GetStringFromAddr(sadr);
END wglARBStrings;

PROCEDURE ReadCoreVersion*;
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
  

	PROCEDURE TrimAndSplitVersionString(CONST Buffer: ARRAY OF CHAR; VAR Max, Min: LONGINT);
	 VAR
	    Separator,i : LONGINT;
	BEGIN
	i := 0;
	Separator := Strings.Pos('.', Buffer);
	(* At least one number must be before and one after the dot. *)
	IF (Separator > 0) & (Separator < Strings.Length(Buffer)) & ((isNumber(Buffer[Separator - 1])) &
	      isNumber(Buffer[Separator + 1])) THEN
	      Max := ORD(Buffer[Separator + 1]);
	      Min := ORD(Buffer[Separator - 1]);
	ELSE
	      Max := 0;
	      Min := 0;
	END;      
	END TrimAndSplitVersionString;

BEGIN
  (* determine version of implementation
   GL *)
  IF glGetString = NIL THEN
    Kernel32.GetProcAddress(GL_LibHandle, "glGetString", SYSTEM.VAL(LONGINT,glGetString));
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
	buffer0, buffer1, buffer2, buffer3: Strings.String;
	len0, len1, len2: LONGINT;
BEGIN
  (* generel extension string *)
	IF glGetString = NIL THEN
		Kernel32.GetProcAddress(GL_LibHandle, "glGetString", SYSTEM.VAL(LONGINT,glGetString));
	END;  
  
	IF glGetString # NIL THEN
		buffer0 := GLGetString(GLC.GL_EXTENSIONS);
		len0 := Strings.Length(buffer0^)
	END;
  
  
  IF (GL_LibHandle # 0 ) THEN
    
      (* wglGetExtensionsStringEXT *)
       IF wglGetExtensionsStringEXT = NIL  THEN
	       	KernelLog.String("1- wglGetExtensionsStringEXT = NIL"); KernelLog.Ln; 
	          wglGetExtensionsStringEXT := SYSTEM.VAL(TwglGetExtensionsStringEXT, wglGetProcAddress('wglGetExtensionsStringEXT'));
          
	         	KernelLog.String("2- wglGetExtensionsStringEXT = NIL: "); KernelLog.Boolean(wglGetExtensionsStringEXT = NIL); KernelLog.Ln; 
       END;
	IF wglGetExtensionsStringEXT # NIL THEN
		buffer1 := wglEXTStrings();
		len1 := Strings.Length(buffer1^);
	END;

      (* wglGetExtensionsStringARB*)
	IF wglGetExtensionsStringARB = NIL THEN 
	    KernelLog.String("1- wglGetExtensionsStringARB = NIL"); KernelLog.Ln;     
		wglGetExtensionsStringARB := SYSTEM.VAL(TwglGetExtensionsStringARB, wglGetProcAddress('wglGetExtensionsStringARB'));
	     KernelLog.String("2- wglGetExtensionsStringARB = NIL: "); KernelLog.Boolean(wglGetExtensionsStringARB = NIL); KernelLog.Ln;   
	END;  
	IF wglGetExtensionsStringARB # NIL THEN        
		buffer2 :=  wglARBStrings();
		len2 := Strings.Length(buffer2^);
      END;  
 END;

NEW(buffer3, len0 + len1 + len2 + 6);
Strings.Append(buffer3^, " ");  
Strings.Append(buffer3^, buffer0^); Strings.Append(buffer3^, " "); 
Strings.Append(buffer3^, buffer1^); Strings.Append(buffer3^, " "); 
Strings.Append(buffer3^, buffer2^); Strings.Append(buffer3^, " "); 
RETURN buffer3;
END Int_GetExtensionString;


PROCEDURE Int_CheckExtension( allextensions: Strings.String; CONST thisextension: ARRAY OF CHAR): BOOLEAN;
BEGIN
  RETURN Strings.Pos(thisextension, allextensions^) > 0;
END Int_CheckExtension;


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

  (* WGL_WINDOWS *)
  (* === WGL ===================================================================== *)
  WGL_3DFX_multisample := Int_CheckExtension(Buffer, 'WGL_3DFX_multisample');
  WGL_ARB_buffer_region := Int_CheckExtension(Buffer, 'WGL_ARB_buffer_region');
  WGL_ARB_extensionsxstring := Int_CheckExtension(Buffer, 'WGL_ARB_extensionsxstring');
  WGL_ARB_make_current_read := Int_CheckExtension(Buffer, 'WGL_ARB_make_current_read');
  WGL_ARB_multisample := Int_CheckExtension(Buffer, 'WGL_ARB_multisample');
  WGL_ARB_pbuffer := Int_CheckExtension(Buffer, 'WGL_ARB_pbuffer');
  WGL_ARB_pixel_format := Int_CheckExtension(Buffer, 'WGL_ARB_pixel_format');
  WGL_ARB_pixel_format_float := Int_CheckExtension(Buffer, 'WGL_ARB_pixel_format_float');
  WGL_ARB_render_texture := Int_CheckExtension(Buffer, 'WGL_ARB_render_texture');
  WGL_ARB_create_context := Int_CheckExtension(Buffer, 'WGL_ARB_create_context');
  WGL_ARB_create_context_profile := Int_CheckExtension(Buffer, 'WGL_ARB_create_context_profile');
  WGL_ARB_framebuffer_sRGB := Int_CheckExtension(Buffer, 'WGL_ARB_framebuffer_sRGB');
  WGL_ARB_create_context_robustness := Int_CheckExtension(Buffer, 'WGL_ARB_create_context_robustness');
  WGL_ATI_pixel_format_float := Int_CheckExtension(Buffer, 'WGL_ATI_pixel_format_float');
  WGL_AMD_gpu_association := Int_CheckExtension(Buffer, 'WGL_AMD_gpu_association');
  WGL_EXT_depth_float := Int_CheckExtension(Buffer, 'WGL_EXT_depth_float');
  WGL_EXT_display_color_table := Int_CheckExtension(Buffer, 'WGL_EXT_display_color_table');
  WGL_EXT_extensionsxstring := Int_CheckExtension(Buffer, 'WGL_EXT_extensionsxstring');
  WGL_EXT_make_current_read := Int_CheckExtension(Buffer, 'WGL_EXT_make_current_read');
  WGL_EXT_multisample := Int_CheckExtension(Buffer, 'WGL_EXT_multisample');
  WGL_EXT_pbuffer := Int_CheckExtension(Buffer, 'WGL_EXT_pbuffer');
  WGL_EXT_pixel_format := Int_CheckExtension(Buffer, 'WGL_EXT_pixel_format');
  WGL_EXT_swap_control := Int_CheckExtension(Buffer, 'WGL_EXT_swap_control');
  WGL_EXT_create_context_es2_profile := Int_CheckExtension(Buffer, 'WGL_EXT_create_context_es2_profile');
  WGL_I3D_digital_video_control := Int_CheckExtension(Buffer, 'WGL_I3D_digital_video_control');
  WGL_I3D_gamma := Int_CheckExtension(Buffer, 'WGL_I3D_gamma');
  WGL_I3D_genlock := Int_CheckExtension(Buffer, 'WGL_I3D_genlock');
  WGL_I3D_image_buffer := Int_CheckExtension(Buffer, 'WGL_I3D_image_buffer');
  WGL_I3D_swap_frame_lock := Int_CheckExtension(Buffer, 'WGL_I3D_swap_frame_lock');
  WGL_I3D_swap_frame_usage := Int_CheckExtension(Buffer, 'WGL_I3D_swap_frame_usage');
  WGL_NV_float_buffer := Int_CheckExtension(Buffer, 'WGL_NV_float_buffer');
  WGL_NV_render_depth_texture := Int_CheckExtension(Buffer, 'WGL_NV_render_depth_texture');
  WGL_NV_render_texture_rectangle := Int_CheckExtension(Buffer, 'WGL_NV_render_texture_rectangle');
  WGL_NV_vertex_array_range := Int_CheckExtension(Buffer, 'WGL_NV_vertex_array_range');
  WGL_NV_present_video := Int_CheckExtension(Buffer, 'WGL_NV_present_video');
  WGL_NV_video_output := Int_CheckExtension(Buffer, 'WGL_NV_video_output');
  WGL_NV_swap_group := Int_CheckExtension(Buffer, 'WGL_NV_swap_group');
  WGL_NV_gpu_affinity := Int_CheckExtension(Buffer, 'WGL_NV_gpu_affinity');
  WGL_NV_video_capture := Int_CheckExtension(Buffer, 'WGL_NV_video_capture');
  WGL_NV_copy_image := Int_CheckExtension(Buffer, 'WGL_NV_copy_image');
  WGL_NV_multisample_coverage := Int_CheckExtension(Buffer, 'WGL_NV_multisample_coverage');
  WGL_OML_sync_control := Int_CheckExtension(Buffer, 'WGL_OML_sync_control');
  WGL_3DL_stereo_control := Int_CheckExtension(Buffer, 'WGL_3DL_stereo_control');

  WIN_draw_range_elements := Int_CheckExtension(Buffer, 'WIN_draw_range_elements');
  WIN_swap_hint := Int_CheckExtension(Buffer, 'WIN_swap_hint');
  
  (* ImplementationRead := TRUE; *)
END ReadImplementationProperties;

PROCEDURE OnClose;
VAR res: LONGINT;
BEGIN {EXCLUSIVE}
DelFCR();

 IF GLU_LibHandle # Kernel32.NULL THEN
       res := Kernel32.FreeLibrary(GLU_LibHandle);
       KernelLog.String(GLU_LibName); KernelLog.String(" unloaded."); KernelLog.Ln; 
END;	 

 IF GL_LibHandle # Kernel32.NULL THEN
       res := Kernel32.FreeLibrary(GL_LibHandle);
       KernelLog.String(GL_LibName); KernelLog.String(" unloaded."); KernelLog.Ln; 
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
  *)
 oldfcr := FCR();
 newfcr := SYSTEM.VAL(SET, 133FH);

END OpenGL.

