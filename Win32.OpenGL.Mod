MODULE OpenGL; (** AUTHOR "fnecati"; PURPOSE "OpenGL binding for WinAos"; *)

IMPORT SYSTEM, Kernel32, Modules,  Strings, GLC := OpenGLConst, KernelLog;

(*
	Compiler.Compile OpenGLConst.Mod Win32.OpenGL.Mod WinApi.Mod ~

==============================================================================
        OpenGL 4.2 - Headertranslation
        Version 4.2
        Date : 08.08.2011
        Works with : WinAos
==============================================================================
 *)


VAR
	 (* handle to library *)
 	GL_LibHandle-: LONGINT;
	GLU_LibHandle-:LONGINT;
	oldfcr, newfcr: SET;  (* for FPU Control registers *)

CONST
  debug = FALSE; (* used in ReadImplementationProperties, when extension is not available *)
  GL_LibName = 'opengl32.dll';
  GLU_LibName = 'glu32.dll';

TYPE
  HDC * = Kernel32.HANDLE;
  HGLRC * = Kernel32.HANDLE;


  ADDRESS * = Kernel32.ADDRESS;
  AnsiChar* = POINTER TO ARRAY OF CHAR;

  PAnsiChar * = ADDRESS;
  THandle * = LONGINT;



  GLenum * = LONGINT;
  GLboolean * = LONGINT;
  GLbitfield * = LONGINT; (*SET;*)
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

  Pointer * = ADDRESS;


  PInteger * = POINTER TO ARRAY OF  GLint;
  PPointer * = ADDRESS;
  Integer * = LONGINT;
  Cardinal * = LONGINT;
  PCardinal * = ADDRESS;
  WORD * = INTEGER;
  DWORD * = LONGINT;

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
   PGLhalfNV * = ADDRESS; (*POINTER TO ARRAY OF GLhalfNV;*)

 (* GL_ARB_shader_objects *)
  PGLHandleARB * = ADDRESS ;
  GLHandleARB * = ADDRESS;
  GLcharARB * = AnsiChar;
  PGLcharARB * = PAnsiChar;
  PPGLcharARB * =  ADDRESS; (* POINTER TO ARRAY OF PGLcharARB; *)

(* GL_VERSION_1_5 *)
  GLintptr* = GLint;
  GLsizeiptr* = GLsizei;

 (* GL_ARB_vertex_buffer_object *)
  GLintptrARB* = GLint;
  GLsizeiptrARB* = GLsizei;

  (* GL_VERSION_2_0 *)
  GLHandle * = GLuint;
  PGLchar * = PAnsiChar;
  PPGLchar * = POINTER TO ARRAY OF PGLchar;

  (* GL_EXT_timer_query*)
  GLint64EXT * = GLint64;
  PGLint64EXT * = ADDRESS; (*POINTER TO ARRAY OF GLint64EXT;*)


  GLuint64EXT * = GLuint64;
  PGLuint64EXT * = ADDRESS; (*POINTER TO ARRAY OF GLuint64EXT;*)

(*  WGL_ARB_pbuffer *)
  HPBUFFERARB * = THandle;

  (* WGL_EXT_pbuffer*)
  HPBUFFEREXT * = THandle;

  (* WGL_NV_present_video *)
  PHVIDEOOUTPUTDEVICENV * = ADDRESS; (*POINTER TO ARRAY OF HVIDEOOUTPUTDEVICENV;*)
  HVIDEOOUTPUTDEVICENV * = THandle;

  (* WGL_NV_video_output*)
   HPVIDEODEV * = THandle;
  PHPVIDEODEV * =  ADDRESS; (*POINTER TO ARRAY OF HPVIDEODEV;*)



  HPGPUNV * = THandle;
  HGPUNV * = THandle;

(*/ WGL_NV_gpu_affinity *)
  PHPGPUNV * = ADDRESS; (*POINTER TO ARRAY OF HPGPUNV;*)
  PHGPUNV * = ADDRESS; (*POINTER TO ARRAY OF HGPUNV;*)

  (* WGL_NV_video_capture *)
  HVIDEOINPUTDEVICENV * = THandle;
  PHVIDEOINPUTDEVICENV * = ADDRESS; (*POINTER TO ARRAY OF HVIDEOINPUTDEVICENV;*)

  (* ARB_sync*)
  GLsync * = Pointer;

 (* GL_ARB_cl_event *)
  (* These incomplete types let us declare types compatible with OpenCL's cl_context and cl_event } *)
  _cl_context = LONGINT;
  _cl_event = LONGINT;
  p_cl_context = POINTER TO ARRAY OF _cl_context;
  p_cl_event = POINTER TO ARRAY OF _cl_event;


  (* GL_ARB_debug_output *)
  TglDebugProcARB = PROCEDURE {WINAPI} (source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST xmessage: PGLchar; userParam: PGLvoid);

  (* GL_AMD_debug_output *)
  TglDebugProcAMD = PROCEDURE {WINAPI} (id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; CONST xmessage: PGLchar; userParam: PGLvoid);

 (* GL_NV_vdpau_interop *)
  GLvdpauSurfaceNV = GLintptr;
  PGLvdpauSurfaceNV =  ADDRESS; (*POINTER TO ARRAY OF GLvdpauSurfaceNV;*)

(*    Datatypes corresponding to GL's types TGL(name)(type)(count) *)
  TGLVectorub2 * = ARRAY 2 OF GLubyte;
  TGLVectori2  * = ARRAY 2 OF GLint;
  TGLVectorf2  * = ARRAY 2 OF GLfloat;
  TGLVectord2  * = ARRAY 2 OF GLdouble;
  TGLVectorp2  * = ARRAY 2 OF Pointer;

  TGLVectorub3 * = ARRAY 3 OF GLubyte;
  TGLVectori3  * = ARRAY 3 OF GLint;
  TGLVectorf3  * = ARRAY 3 OF GLfloat;
  TGLVectord3  * = ARRAY 3 OF GLdouble;
  TGLVectorp3  * = ARRAY 3 OF Pointer;

  TGLVectorub4 * = ARRAY 4 OF GLubyte;
  TGLVectori4  * = ARRAY 4 OF GLint;
  TGLVectorf4  * = ARRAY 4 OF GLfloat;
  TGLVectord4  * = ARRAY 4 OF GLdouble;
  TGLVectorp4  * = ARRAY 4 OF Pointer;

  TGLArrayf4 * = TGLVectorf4;
  TGLArrayf3 * = TGLVectorf3;
  TGLArrayd3 * = TGLVectord3;
  TGLArrayi4 * = TGLVectori4;
  TGLArrayp4 * = TGLVectorp4;

  TGlMatrixub3 * = ARRAY 3,3 OF GLubyte;
  TGlMatrixi3  * = ARRAY 3,3 OF GLint;
  TGLMatrixf3  * = ARRAY 3,3 OF GLfloat;
  TGLMatrixd3  * = ARRAY 3,3 OF GLdouble;

  TGlMatrixub4 * = ARRAY 4,4 OF GLubyte;
  TGlMatrixi4  * = ARRAY 4,4 OF GLint;
  TGLMatrixf4  * = ARRAY 4,4 OF GLfloat;
  TGLMatrixd4  * = ARRAY 4,4 OF GLdouble;

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
  TGLUQuadricErrorProc * = PROCEDURE {WINAPI}(errorCode: GLenum);
  (* GLUTessCallback *)
  TGLUTessBeginProc * = PROCEDURE {WINAPI}(AType: GLenum);
  TGLUTessEdgeFlagProc * = PROCEDURE {WINAPI} (Flag: GLboolean);
  TGLUTessVertexProc * = PROCEDURE {WINAPI} (VertexData: Pointer);
  TGLUTessEndProc * = PROCEDURE {WINAPI};
  TGLUTessErrorProc * = PROCEDURE {WINAPI}(ErrNo: GLenum);
  TGLUTessCombineProc * = PROCEDURE {WINAPI}(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer);
  TGLUTessBeginDataProc * = PROCEDURE {WINAPI} (AType: GLenum; UserData: Pointer);
  TGLUTessEdgeFlagDataProc * = PROCEDURE {WINAPI}(Flag: GLboolean; UserData: Pointer);
  TGLUTessVertexDataProc * = PROCEDURE {WINAPI}(VertexData: Pointer; UserData: Pointer);
  TGLUTessEndDataProc * = PROCEDURE {WINAPI}(UserData: Pointer);
  TGLUTessErrorDataProc * = PROCEDURE {WINAPI}(ErrNo: GLenum; UserData: Pointer);
  TGLUTessCombineDataProc * = PROCEDURE {WINAPI}(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer; UserData: Pointer);
  (* GLUNurbsCallback *)
  TGLUNurbsErrorProc * = PROCEDURE {WINAPI} (ErrorCode: GLenum);

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
  GL_VERSION_4_2* ,
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
  GL_ARB_vertexxtype_2_10_10_10_rev* ,
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
  (* GL 4.2 *)
  GL_ARB_base_instance* ,
  GL_ARB_shading_language_420pack* ,
  GL_ARB_transform_feedback_instanced* ,
  GL_ARB_compressed_texture_pixel_storage* ,
  GL_ARB_conservative_depth* ,
  GL_ARB_internalformat_query* ,
  GL_ARB_map_buffer_alignment* ,
  GL_ARB_shader_atomic_counters* ,
  GL_ARB_shader_image_load_store* ,
  GL_ARB_shading_language_packing* ,
  GL_ARB_texture_storage* ,
  (* * *)
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
  WGL_NV_DX_interop* ,
  WGL_OML_sync_control* ,
  WGL_3DL_stereo_control* ,
  WIN_draw_range_elements* ,
  WIN_swap_hint*: BOOLEAN;


TYPE

  (*! GL_VERSION_1_0 *)
  TglCullFace = PROCEDURE {WINAPI} (mode: GLenum);
  TglFrontFace = PROCEDURE {WINAPI} (mode: GLenum);
  TglHint = PROCEDURE {WINAPI} (target: GLenum; mode: GLenum);
  TglLineWidth = PROCEDURE {WINAPI} (width: GLfloat);
  TglPointSize = PROCEDURE {WINAPI} (size: GLfloat);
  TglPolygonMode = PROCEDURE {WINAPI} (face: GLenum; mode: GLenum);
  TglScissor = PROCEDURE {WINAPI} (x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglTexParameterf = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLfloat);
  TglTexParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexParameteri = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLint);
  TglTexParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglTexImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglDrawBuffer = PROCEDURE {WINAPI} (mode: GLenum);
  TglClear = PROCEDURE {WINAPI} (mask: GLbitfield);
  TglClearColor = PROCEDURE {WINAPI} (red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);
  TglClearStencil = PROCEDURE {WINAPI} (s: GLint);
  TglClearDepth = PROCEDURE {WINAPI} (depth: GLclampd);
  TglStencilMask = PROCEDURE {WINAPI} (mask: GLuint);
  TglColorMask = PROCEDURE {WINAPI} (red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean);
  TglDepthMask = PROCEDURE {WINAPI} (flag: GLboolean);
  TglDisable = PROCEDURE {WINAPI} (cap: GLenum);
  TglEnable = PROCEDURE {WINAPI} (cap: GLenum);
  TglFinish = PROCEDURE {WINAPI} ();
  TglFlush = PROCEDURE {WINAPI} ();
  TglBlendFunc = PROCEDURE {WINAPI} (sfactor: GLenum; dfactor: GLenum);
  TglLogicOp = PROCEDURE {WINAPI} (opcode: GLenum);
  TglStencilFunc = PROCEDURE {WINAPI} (func: GLenum; ref: GLint; mask: GLuint);
  TglStencilOp = PROCEDURE {WINAPI} (fail: GLenum; zfail: GLenum; zpass: GLenum);
  TglDepthFunc = PROCEDURE {WINAPI} (func: GLenum);
  TglPixelStoref = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPixelStorei = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglReadBuffer = PROCEDURE {WINAPI} (mode: GLenum);
  TglReadPixels = PROCEDURE {WINAPI} (x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglGetBooleanv = PROCEDURE {WINAPI} (pname: GLenum; params: PGLboolean);
  TglGetDoublev = PROCEDURE {WINAPI} (pname: GLenum; params: PGLdouble);
  TglGetError = PROCEDURE {WINAPI} (): GLenum;
  TglGetFloatv = PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);
  TglGetIntegerv* = PROCEDURE {WINAPI} (pname: GLenum; params: PGLint);
  TglGetString* =  PROCEDURE {WINAPI} (name: GLenum): ADDRESS;
  TglGetTexImage = PROCEDURE {WINAPI} (target: GLenum; level: GLint; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglGetTexParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexLevelParameterfv = PROCEDURE {WINAPI} (target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetTexLevelParameteriv = PROCEDURE {WINAPI} (target: GLenum; level: GLint; pname: GLenum; params: PGLint);
  TglIsEnabled =  PROCEDURE {WINAPI} (cap: GLenum): GLboolean;
  TglDepthRange = PROCEDURE {WINAPI} (zNear: GLclampd; zFar: GLclampd);
  TglViewport = PROCEDURE {WINAPI} (x: GLint; y: GLint; width: GLsizei; height: GLsizei);

  (*! GL_VERSION_1_1 *)
  TglDrawArrays = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei);
  TglDrawElements = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; xtype: GLenum;  indices: PGLvoid);
  TglGetPointerv = PROCEDURE {WINAPI} (pname: GLenum; params: PGLvoid);
  TglPolygonOffset = PROCEDURE {WINAPI} (factor: GLfloat; units: GLfloat);
  TglCopyTexImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTexImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTexSubImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTexSubImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglTexSubImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglBindTexture = PROCEDURE {WINAPI} (target: GLenum; texture: GLuint);
  TglDeleteTextures = PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint);
  TglGenTextures = PROCEDURE {WINAPI} (n: GLsizei; textures: PGLuint);

(*! ifdef DEPRECATED *)
  TglAccum = PROCEDURE {WINAPI} (op: GLenum; value: GLfloat);
  TglAlphaFunc = PROCEDURE {WINAPI} (func: GLenum; ref: GLclampf);
  TglAreTexturesResident =  PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint; residences: PGLboolean): GLboolean;
  TglArrayElement = PROCEDURE {WINAPI} (i: GLint);
  TglBegin = PROCEDURE {WINAPI} (mode: GLenum);
  TglBitmap = PROCEDURE {WINAPI} (width: GLsizei; height: GLsizei; xorig: GLfloat; yorig: GLfloat; xmove: GLfloat; ymove: GLfloat;  bitmap: PGLubyte);
  TglCallList = PROCEDURE {WINAPI} (list: GLuint);
  TglCallLists = PROCEDURE {WINAPI} (n: GLsizei; xtype: GLenum;  lists: PGLvoid);
  TglClearAccum = PROCEDURE {WINAPI} (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);
  TglClearIndex = PROCEDURE {WINAPI} (c: GLfloat);
  TglClipPlane = PROCEDURE {WINAPI} (plane: GLenum;  equation: PGLdouble);
  TglColor3b = PROCEDURE {WINAPI} (red: GLbyte; green: GLbyte; blue: GLbyte);
  TglColor3bv = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglColor3d = PROCEDURE {WINAPI} (red: GLdouble; green: GLdouble; blue: GLdouble);
  TglColor3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglColor3f = PROCEDURE {WINAPI} (red: GLfloat; green: GLfloat; blue: GLfloat);
  TglColor3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglColor3i = PROCEDURE {WINAPI} (red: GLint; green: GLint; blue: GLint);
  TglColor3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglColor3s = PROCEDURE {WINAPI} (red: GLshort; green: GLshort; blue: GLshort);
  TglColor3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglColor3ub = PROCEDURE {WINAPI} (red: GLubyte; green: GLubyte; blue: GLubyte);
  TglColor3ubv = PROCEDURE {WINAPI} ( v: PGLubyte);
  TglColor3ui = PROCEDURE {WINAPI} (red: GLuint; green: GLuint; blue: GLuint);
  TglColor3uiv = PROCEDURE {WINAPI} ( v: PGLuint);
  TglColor3us = PROCEDURE {WINAPI} (red: GLushort; green: GLushort; blue: GLushort);
  TglColor3usv = PROCEDURE {WINAPI} ( v: PGLushort);
  TglColor4b = PROCEDURE {WINAPI} (red: GLbyte; green: GLbyte; blue: GLbyte; alpha: GLbyte);
  TglColor4bv = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglColor4d = PROCEDURE {WINAPI} (red: GLdouble; green: GLdouble; blue: GLdouble; alpha: GLdouble);
  TglColor4dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglColor4f = PROCEDURE {WINAPI} (red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);
  TglColor4fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglColor4i = PROCEDURE {WINAPI} (red: GLint; green: GLint; blue: GLint; alpha: GLint);
  TglColor4iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglColor4s = PROCEDURE {WINAPI} (red: GLshort; green: GLshort; blue: GLshort; alpha: GLshort);
  TglColor4sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglColor4ub = PROCEDURE {WINAPI} (red: GLubyte; green: GLubyte; blue: GLubyte; alpha: GLubyte);
  TglColor4ubv = PROCEDURE {WINAPI} ( v: PGLubyte);
  TglColor4ui = PROCEDURE {WINAPI} (red: GLuint; green: GLuint; blue: GLuint; alpha: GLuint);
  TglColor4uiv = PROCEDURE {WINAPI} ( v: PGLuint);
  TglColor4us = PROCEDURE {WINAPI} (red: GLushort; green: GLushort; blue: GLushort; alpha: GLushort);
  TglColor4usv = PROCEDURE {WINAPI} ( v: PGLushort);
  TglColorMaterial = PROCEDURE {WINAPI} (face: GLenum; mode: GLenum);
  TglColorPointer = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglCopyPixels = PROCEDURE {WINAPI} (x: GLint; y: GLint; width: GLsizei; height: GLsizei; xtype: GLenum);
  TglDeleteLists = PROCEDURE {WINAPI} (list: GLuint; range: GLsizei);
  TglDisableClientState = PROCEDURE {WINAPI} (xarray: GLenum);
  TglDrawPixels = PROCEDURE {WINAPI} (width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglEdgeFlag = PROCEDURE {WINAPI} (flag: GLboolean);
  TglEdgeFlagPointer = PROCEDURE {WINAPI} (stride: GLsizei; xpointer: PGLvoid);
  TglEdgeFlagv = PROCEDURE {WINAPI} ( flag: PGLboolean);
  TglEnableClientState = PROCEDURE {WINAPI} (xarray: GLenum);
  TglEnd = PROCEDURE {WINAPI} ();
  TglEndList = PROCEDURE {WINAPI} ();
  TglEvalCoord1d = PROCEDURE {WINAPI} (u: GLdouble);
  TglEvalCoord1dv = PROCEDURE {WINAPI} ( u: PGLdouble);
  TglEvalCoord1f = PROCEDURE {WINAPI} (u: GLfloat);
  TglEvalCoord1fv = PROCEDURE {WINAPI} ( u: PGLfloat);
  TglEvalCoord2d = PROCEDURE {WINAPI} (u: GLdouble; v: GLdouble);
  TglEvalCoord2dv = PROCEDURE {WINAPI} ( u: PGLdouble);
  TglEvalCoord2f = PROCEDURE {WINAPI} (u: GLfloat; v: GLfloat);
  TglEvalCoord2fv = PROCEDURE {WINAPI} ( u: PGLfloat);
  TglEvalMesh1 = PROCEDURE {WINAPI} (mode: GLenum; i1: GLint; i2: GLint);
  TglEvalMesh2 = PROCEDURE {WINAPI} (mode: GLenum; i1: GLint; i2: GLint; j1: GLint; j2: GLint);
  TglEvalPoint1 = PROCEDURE {WINAPI} (i: GLint);
  TglEvalPoint2 = PROCEDURE {WINAPI} (i: GLint; j: GLint);
  TglFeedbackBuffer = PROCEDURE {WINAPI} (size: GLsizei; xtype: GLenum; buffer: PGLfloat);
  TglFogf = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglFogfv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);
  TglFogi = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglFogiv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLint);
  TglFrustum = PROCEDURE {WINAPI} (left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglGenLists =  PROCEDURE {WINAPI} (range: GLsizei): GLuint;
  TglGetClipPlane = PROCEDURE {WINAPI} (plane: GLenum; equation: PGLdouble);
  TglGetLightfv = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLfloat);
  TglGetLightiv = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLint);
  TglGetMapdv = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; v: PGLdouble);
  TglGetMapfv = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; v: PGLfloat);
  TglGetMapiv = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; v: PGLint);
  TglGetMaterialfv = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMaterialiv = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLint);
  TglGetPixelMapfv = PROCEDURE {WINAPI} (map: GLenum; values: PGLfloat);
  TglGetPixelMapuiv = PROCEDURE {WINAPI} (map: GLenum; values: PGLuint);
  TglGetPixelMapusv = PROCEDURE {WINAPI} (map: GLenum; values: PGLushort);
  TglGetPolygonStipple = PROCEDURE {WINAPI} (mask: PGLubyte);
  TglGetTexEnvfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexEnviv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexGendv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; params: PGLdouble);
  TglGetTexGenfv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexGeniv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; params: PGLint);
  TglIndexMask = PROCEDURE {WINAPI} (mask: GLuint);
  TglIndexPointer = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglIndexd = PROCEDURE {WINAPI} (c: GLdouble);
  TglIndexdv = PROCEDURE {WINAPI} ( c: PGLdouble);
  TglIndexf = PROCEDURE {WINAPI} (c: GLfloat);
  TglIndexfv = PROCEDURE {WINAPI} ( c: PGLfloat);
  TglIndexi = PROCEDURE {WINAPI} (c: GLint);
  TglIndexiv = PROCEDURE {WINAPI} ( c: PGLint);
  TglIndexs = PROCEDURE {WINAPI} (c: GLshort);
  TglIndexsv = PROCEDURE {WINAPI} ( c: PGLshort);
  TglIndexub = PROCEDURE {WINAPI} (c: GLubyte);
  TglIndexubv = PROCEDURE {WINAPI} ( c: PGLubyte);
  TglInitNames = PROCEDURE {WINAPI} ();
  TglInterleavedArrays = PROCEDURE {WINAPI} (format: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglIsList =  PROCEDURE {WINAPI} (list: GLuint): BOOLEAN;
  TglIsTexture =  PROCEDURE {WINAPI} (texture: GLuint): BOOLEAN;
  TglLightModelf = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglLightModelfv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);
  TglLightModeli = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglLightModeliv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLint);
  TglLightf = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; param: GLfloat);
  TglLightfv = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum;   params: PGLfloat);
  TglLighti = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; param: GLint);
  TglLightiv = PROCEDURE {WINAPI} (light: GLenum; pname: GLenum;  params: PGLint);
  TglLineStipple = PROCEDURE {WINAPI} (factor: GLint; pattern: GLushort);
  TglListBase = PROCEDURE {WINAPI} (base: GLuint);
  TglLoadIdentity = PROCEDURE {WINAPI} ();
  TglLoadMatrixd = PROCEDURE {WINAPI} ( m: PGLdouble);
  TglLoadMatrixf = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglLoadName = PROCEDURE {WINAPI} (name: GLuint);
  TglMap1d = PROCEDURE {WINAPI} (target: GLenum; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint;  points: PGLdouble);
  TglMap1f = PROCEDURE {WINAPI} (target: GLenum; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; points: PGLfloat);
  TglMap2d = PROCEDURE {WINAPI} (target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; points: PGLdouble);
  TglMap2f = PROCEDURE {WINAPI} (target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; points: PGLfloat);
  TglMapGrid1d = PROCEDURE {WINAPI} (un: GLint; u1: GLdouble; u2: GLdouble);
  TglMapGrid1f = PROCEDURE {WINAPI} (un: GLint; u1: GLfloat; u2: GLfloat);
  TglMapGrid2d = PROCEDURE {WINAPI} (un: GLint; u1: GLdouble; u2: GLdouble; vn: GLint; v1: GLdouble; v2: GLdouble);
  TglMapGrid2f = PROCEDURE {WINAPI} (un: GLint; u1: GLfloat; u2: GLfloat; vn: GLint; v1: GLfloat; v2: GLfloat);
  TglMaterialf = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; param: GLfloat);
  TglMaterialfv = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum;  params:  PGLfloat);
  TglMateriali = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; param: GLint);
  TglMaterialiv = PROCEDURE {WINAPI} (face: GLenum; pname: GLenum;  params: PGLint);
  TglMatrixMode = PROCEDURE {WINAPI} (mode: GLenum);
  TglMultMatrixd = PROCEDURE {WINAPI} ( m: PGLdouble);
  TglMultMatrixf = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglNewList = PROCEDURE {WINAPI} (list: GLuint; mode: GLenum);
  TglNormal3b = PROCEDURE {WINAPI} (nx: GLbyte; ny: GLbyte; nz: GLbyte);
  TglNormal3bv = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglNormal3d = PROCEDURE {WINAPI} (nx: GLdouble; ny: GLdouble; nz: GLdouble);
  TglNormal3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglNormal3f = PROCEDURE {WINAPI} (nx: GLfloat; ny: GLfloat; nz: GLfloat);
  TglNormal3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglNormal3i = PROCEDURE {WINAPI} (nx: GLint; ny: GLint; nz: GLint);
  TglNormal3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglNormal3s = PROCEDURE {WINAPI} (nx: GLshort; ny: GLshort; nz: GLshort);
  TglNormal3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglNormalPointer = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglOrtho = PROCEDURE {WINAPI} (left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglPassThrough = PROCEDURE {WINAPI} (token: GLfloat);
  TglPixelMapfv = PROCEDURE {WINAPI} (map: GLenum; mapsize: GLsizei;  values: PGLfloat);
  TglPixelMapuiv = PROCEDURE {WINAPI} (map: GLenum; mapsize: GLsizei;  values: PGLuint);
  TglPixelMapusv = PROCEDURE {WINAPI} (map: GLenum; mapsize: GLsizei;  values: PGLushort);
  TglPixelTransferf = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPixelTransferi = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglPixelZoom = PROCEDURE {WINAPI} (xfactor: GLfloat; yfactor: GLfloat);
  TglPolygonStipple = PROCEDURE {WINAPI} ( mask: PGLubyte);
  TglPopAttrib = PROCEDURE {WINAPI} ();
  TglPopClientAttrib = PROCEDURE {WINAPI} ();
  TglPopMatrix = PROCEDURE {WINAPI} ();
  TglPopName = PROCEDURE {WINAPI} ();
  TglPrioritizeTextures = PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint;  priorities: PGLclampf);
  TglPushAttrib = PROCEDURE {WINAPI} (mask: GLbitfield);
  TglPushClientAttrib = PROCEDURE {WINAPI} (mask: GLbitfield);
  TglPushMatrix = PROCEDURE {WINAPI} ();
  TglPushName = PROCEDURE {WINAPI} (name: GLuint);
  TglRasterPos2d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble);
  TglRasterPos2dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglRasterPos2f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat);
  TglRasterPos2fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglRasterPos2i = PROCEDURE {WINAPI} (x: GLint; y: GLint);
  TglRasterPos2iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglRasterPos2s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort);
  TglRasterPos2sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglRasterPos3d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglRasterPos3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglRasterPos3f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglRasterPos3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglRasterPos3i = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint);
  TglRasterPos3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglRasterPos3s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort);
  TglRasterPos3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglRasterPos4d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglRasterPos4dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglRasterPos4f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglRasterPos4fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglRasterPos4i = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint; w: GLint);
  TglRasterPos4iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglRasterPos4s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglRasterPos4sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglRectd = PROCEDURE {WINAPI} (x1: GLdouble; y1: GLdouble; x2: GLdouble; y2: GLdouble);
  TglRectdv = PROCEDURE {WINAPI} ( v1: PGLdouble;  v2: PGLdouble);
  TglRectf = PROCEDURE {WINAPI} (x1: GLfloat; y1: GLfloat; x2: GLfloat; y2: GLfloat);
  TglRectfv = PROCEDURE {WINAPI} ( v1: PGLfloat;  v2: PGLfloat);
  TglRecti = PROCEDURE {WINAPI} (x1: GLint; y1: GLint; x2: GLint; y2: GLint);
  TglRectiv = PROCEDURE {WINAPI} ( v1: PGLint;  v2: PGLint);
  TglRects = PROCEDURE {WINAPI} (x1: GLshort; y1: GLshort; x2: GLshort; y2: GLshort);
  TglRectsv = PROCEDURE {WINAPI} ( v1: PGLshort;  v2: PGLshort);
  TglRenderMode =  PROCEDURE {WINAPI} (mode: GLenum): GLint;
  TglRotated = PROCEDURE {WINAPI} (anTgle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);
  TglRotatef = PROCEDURE {WINAPI} ( angle, x, y, z: GLfloat);
  TglScaled = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglScalef = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglSelectBuffer = PROCEDURE {WINAPI} (size: GLsizei; buffer: PGLuint);
  TglShadeModel = PROCEDURE {WINAPI} (mode: GLenum);
  TglTexCoord1d = PROCEDURE {WINAPI} (s: GLdouble);
  TglTexCoord1dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglTexCoord1f = PROCEDURE {WINAPI} (s: GLfloat);
  TglTexCoord1fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglTexCoord1i = PROCEDURE {WINAPI} (s: GLint);
  TglTexCoord1iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglTexCoord1s = PROCEDURE {WINAPI} (s: GLshort);
  TglTexCoord1sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglTexCoord2d = PROCEDURE {WINAPI} (s: GLdouble; t: GLdouble);
  TglTexCoord2dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglTexCoord2f = PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat);
  TglTexCoord2fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglTexCoord2i = PROCEDURE {WINAPI} (s: GLint; t: GLint);
  TglTexCoord2iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglTexCoord2s = PROCEDURE {WINAPI} (s: GLshort; t: GLshort);
  TglTexCoord2sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglTexCoord3d = PROCEDURE {WINAPI} (s: GLdouble; t: GLdouble; r: GLdouble);
  TglTexCoord3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglTexCoord3f = PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; r: GLfloat);
  TglTexCoord3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglTexCoord3i = PROCEDURE {WINAPI} (s: GLint; t: GLint; r: GLint);
  TglTexCoord3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglTexCoord3s = PROCEDURE {WINAPI} (s: GLshort; t: GLshort; r: GLshort);
  TglTexCoord3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglTexCoord4d = PROCEDURE {WINAPI} (s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglTexCoord4dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglTexCoord4f = PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglTexCoord4fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglTexCoord4i = PROCEDURE {WINAPI} (s: GLint; t: GLint; r: GLint; q: GLint);
  TglTexCoord4iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglTexCoord4s = PROCEDURE {WINAPI} (s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglTexCoord4sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglTexCoordPointer = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglTexEnvf = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLfloat);
  TglTexEnvfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexEnvi = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLint);
  TglTexEnviv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglTexGend = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; param: GLdouble);
  TglTexGendv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum;  params: PGLdouble);
  TglTexGenf = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; param: GLfloat);
  TglTexGenfv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexGeni = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum; param: GLint);
  TglTexGeniv = PROCEDURE {WINAPI} (coord: GLenum; pname: GLenum;  params: PGLint);


  TglTranslated = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglTranslatef = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertex2d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble);
  TglVertex2dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglVertex2f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat);
  TglVertex2fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglVertex2i = PROCEDURE {WINAPI} (x: GLint; y: GLint);
  TglVertex2iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglVertex2s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort);
  TglVertex2sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglVertex3d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertex3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglVertex3f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertex3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglVertex3i = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint);
  TglVertex3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglVertex3s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort);
  TglVertex3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglVertex4d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertex4dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglVertex4f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertex4fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglVertex4i = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertex4iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglVertex4s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertex4sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglVertexPointer = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
(*! endif *)

  (*! GL_VERSION_1_2 *)
  TglBlendColor* = PROCEDURE {WINAPI} (red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);
  TglBlendEquation = PROCEDURE {WINAPI} (mode: GLenum);
  TglDrawRangeElements = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; xtype: GLenum;  indices: PGLvoid);
  TglTexImage3D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage3D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglCopyTexSubImage3D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);

 (*! ifdef DEPRECATED 1.2 *)
  TglColorTable = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  table: PGLvoid);
  TglColorTableParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglColorTableParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyColorTable = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglGetColorTable = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; table: PGLvoid);
  TglGetColorTableParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetColorTableParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglColorSubTable = PROCEDURE {WINAPI} (target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; xtype: GLenum;  data: PGLvoid);
  TglCopyColorSubTable = PROCEDURE {WINAPI} (target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);
  TglConvolutionFilter1D = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionFilter2D = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionParameterf = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: GLfloat);
  TglConvolutionParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglConvolutionParameteri = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: GLint);
  TglConvolutionParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyConvolutionFilter1D = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglCopyConvolutionFilter2D = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetConvolutionFilter = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglGetConvolutionParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetConvolutionParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetSeparableFilter = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);
  TglSeparableFilter2D = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  row: PGLvoid;  column: PGLvoid);
  TglGetHistogram = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetHistogramParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetHistogramParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetMinmax = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetMinmaxParameterfv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMinmaxParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglHistogram = PROCEDURE {WINAPI} (target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);
  TglMinmax = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; sink: GLboolean);
  TglResetHistogram = PROCEDURE {WINAPI} (target: GLenum);
  TglResetMinmax = PROCEDURE {WINAPI} (target: GLenum);
(*! endif *)

  (*! GL_VERSION_1_3 *)
  TglActiveTexture = PROCEDURE {WINAPI} (texture: GLenum);
  TglSampleCoverage = PROCEDURE {WINAPI} (value: GLclampf; invert: GLboolean);
  TglCompressedTexImage3D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage3D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage2D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage1D = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglGetCompressedTexImage = PROCEDURE {WINAPI} (target: GLenum; level: GLint; img: PGLvoid);

(*! ifdef DEPRECATED 1.3 *)
  TglClientActiveTexture = PROCEDURE {WINAPI} (texture: GLenum);
  TglMultiTexCoord1d = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble);
  TglMultiTexCoord1dv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord1f = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat);
  TglMultiTexCoord1fv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord1i = PROCEDURE {WINAPI} (target: GLenum; s: GLint);
  TglMultiTexCoord1iv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord1s = PROCEDURE {WINAPI} (target: GLenum; s: GLshort);
  TglMultiTexCoord1sv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord2d = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble);
  TglMultiTexCoord2dv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord2f = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat);
  TglMultiTexCoord2fv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord2i = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint);
  TglMultiTexCoord2iv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord2s = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort);
  TglMultiTexCoord2sv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord3d = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);
  TglMultiTexCoord3dv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord3f = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);
  TglMultiTexCoord3fv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord3i = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint; r: GLint);
  TglMultiTexCoord3iv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord3s = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort; r: GLshort);
  TglMultiTexCoord3sv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord4d = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglMultiTexCoord4dv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord4f = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglMultiTexCoord4fv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord4i = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);
  TglMultiTexCoord4iv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord4s = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglMultiTexCoord4sv = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglLoadTransposeMatrixf = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglLoadTransposeMatrixd = PROCEDURE {WINAPI} ( m: PGLdouble);
  TglMultTransposeMatrixf = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglMultTransposeMatrixd = PROCEDURE {WINAPI} ( m: PGLdouble);
(*! endif *)


  (*! GL_VERSION_1_4 *)
  TglBlendFuncSeparate = PROCEDURE {WINAPI} (sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);
  TglMultiDrawArrays = PROCEDURE {WINAPI} (mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  TglMultiDrawElements = PROCEDURE {WINAPI} (mode: GLenum;  count: PGLsizei; xtype: GLenum;  indices: PGLvoid; primcount: GLsizei);
  TglPointParameterf = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPointParameterfv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);
  TglPointParameteri = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglPointParameteriv = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLint);

  (*! ifdef DEPRECATED 1.4 *)
  TglFogCoordf = PROCEDURE {WINAPI} (coord: GLfloat);
  TglFogCoordfv = PROCEDURE {WINAPI} ( coord: PGLfloat);
  TglFogCoordd = PROCEDURE {WINAPI} (coord: GLdouble);
  TglFogCoorddv = PROCEDURE {WINAPI} ( coord: PGLdouble);
  TglFogCoordPointer = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglSecondaryColor3b = PROCEDURE {WINAPI} (red: GLbyte; green: GLbyte; blue: GLbyte);
  TglSecondaryColor3bv = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglSecondaryColor3d = PROCEDURE {WINAPI} (red: GLdouble; green: GLdouble; blue: GLdouble);
  TglSecondaryColor3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglSecondaryColor3f = PROCEDURE {WINAPI} (red: GLfloat; green: GLfloat; blue: GLfloat);
  TglSecondaryColor3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglSecondaryColor3i = PROCEDURE {WINAPI} (red: GLint; green: GLint; blue: GLint);
  TglSecondaryColor3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglSecondaryColor3s = PROCEDURE {WINAPI} (red: GLshort; green: GLshort; blue: GLshort);
  TglSecondaryColor3sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglSecondaryColor3ub = PROCEDURE {WINAPI} (red: GLubyte; green: GLubyte; blue: GLubyte);
  TglSecondaryColor3ubv = PROCEDURE {WINAPI} ( v: PGLubyte);
  TglSecondaryColor3ui = PROCEDURE {WINAPI} (red: GLuint; green: GLuint; blue: GLuint);
  TglSecondaryColor3uiv = PROCEDURE {WINAPI} ( v: PGLuint);
  TglSecondaryColor3us = PROCEDURE {WINAPI} (red: GLushort; green: GLushort; blue: GLushort);
  TglSecondaryColor3usv = PROCEDURE {WINAPI} ( v: PGLushort);
  TglSecondaryColorPointer = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglWindowPos2d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble);
  TglWindowPos2dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos2f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat);
  TglWindowPos2fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos2i = PROCEDURE {WINAPI} (x: GLint; y: GLint);
  TglWindowPos2iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos2s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort);
  TglWindowPos2sv = PROCEDURE {WINAPI} ( v: PGLshort);
  TglWindowPos3d = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dv = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos3f = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fv = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos3i = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint);
  TglWindowPos3iv = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos3s = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3sv = PROCEDURE {WINAPI} ( v: PGLshort);
(*! endif *)

  (*! GL_VERSION_1_5 *)
  TglGenQueries = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglDeleteQueries = PROCEDURE {WINAPI} (n: GLsizei;  ids: PGLuint);
  TglIsQuery = PROCEDURE {WINAPI} (id: GLuint): BOOLEAN;
  TglBeginQuery = PROCEDURE {WINAPI} (target: GLenum; id: GLuint);
  TglEndQuery = PROCEDURE {WINAPI} (target: GLenum);
  TglGetQueryiv = PROCEDURE {WINAPI} (target, pname: GLenum; params: PGLint);
  TglGetQueryObjectiv = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint);
  TglGetQueryObjectuiv = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLuint);
  TglBindBuffer = PROCEDURE {WINAPI} (target: GLenum; buffer: GLuint);
  TglDeleteBuffers = PROCEDURE {WINAPI} (n: GLsizei;  buffers: PGLuint );
  TglGenBuffers = PROCEDURE {WINAPI} (n: GLsizei;  buffers: PGLuint);
  TglIsBuffer = PROCEDURE {WINAPI} (buffer: GLuint): GLboolean;
  TglBufferData = PROCEDURE {WINAPI} (target: GLenum; size: GLsizei;  data: ADDRESS; usage: GLenum);
  TglBufferSubData = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; size: GLsizei;  data: PGLvoid);
  TglGetBufferSubData = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; size: GLsizei; data: PGLvoid);
  TglMapBuffer = PROCEDURE {WINAPI} (target: GLenum; access: GLenum): PGLvoid;
  TglUnmapBuffer = PROCEDURE {WINAPI} (target: GLenum): GLboolean;
  TglGetBufferParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetBufferPointerv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLvoid);

  (*! GL_VERSION_2_0 *)
  TglBlendEquationSeparate = PROCEDURE {WINAPI} (modeRGB: GLenum; modeAlpha: GLenum);
  TglDrawBuffers = PROCEDURE {WINAPI} (n: GLsizei;  bufs: PGLenum);
  TglStencilOpSeparate = PROCEDURE {WINAPI} (face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum);
  TglStencilFuncSeparate = PROCEDURE {WINAPI} (frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint);
  TglStencilMaskSeparate = PROCEDURE {WINAPI} (face: GLenum; mask: GLuint);
  TglAttachShader = PROCEDURE {WINAPI} (programObj, shaderObj: GLHandle);
  TglBindAttribLocation = PROCEDURE {WINAPI} (programObj: GLHandle; index: GLuint; name: PGLchar);
  TglCompileShader = PROCEDURE {WINAPI} (shaderObj: GLHandle);
  TglCreateProgram = PROCEDURE {WINAPI} (): GLHandle;
  TglCreateShader = PROCEDURE {WINAPI} (shaderType: GLenum): GLHandle;
  TglDeleteProgram = PROCEDURE {WINAPI} (programObj: GLHandle);
  TglDeleteShader = PROCEDURE {WINAPI} (shaderObj: GLHandle);
  TglDetachShader = PROCEDURE {WINAPI} (programObj, shaderObj: GLHandle);
  TglDisableVertexAttribArray = PROCEDURE {WINAPI} (index: GLuint);
  TglEnableVertexAttribArray = PROCEDURE {WINAPI} (index: GLuint);
  TglGetActiveAttrib = PROCEDURE {WINAPI} (programObj: GLHandle; index: GLuint; maxlength: GLsizei; VAR length: GLint; VAR size: GLint; VAR xtype: GLenum; name: PGLchar);
  TglGetActiveUniform = PROCEDURE {WINAPI} (programObj: GLHandle; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLchar);
  TglGetAttachedShaders = PROCEDURE {WINAPI} (programObj: GLHandle; MaxCount: GLsizei; VAR Count: GLint; shaders: PGLuint);
  TglGetAttribLocation = PROCEDURE {WINAPI} (programObj: GLHandle; CONST chars: ARRAY OF CHAR): GLint;
  TglGetProgramiv = PROCEDURE {WINAPI} (programObj: GLHandle; pname: GLenum; params: PGLint);
  TglGetProgramInfoLog = PROCEDURE {WINAPI} (programObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar);
  TglGetShaderiv = PROCEDURE {WINAPI} (shaderObj: GLHandle; pname: GLenum; params: PGLint);
  TglGetShaderInfoLog = PROCEDURE {WINAPI} (shaderObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar);
  TglGetShaderSource = PROCEDURE {WINAPI} (shaderObj: GLHandle; maxlength: GLsizei; VAR length: GLsizei; source: PGLchar);
  TglGetUniformLocation = PROCEDURE {WINAPI} (programObj: GLHandle; CONST char: ARRAY OF CHAR): GLint;
  TglGetUniformfv = PROCEDURE {WINAPI} (programObj: GLHandle; location: GLint; params: PGLfloat);
  TglGetUniformiv = PROCEDURE {WINAPI} (programObj: GLHandle; location: GLint; params: PGLint);
  TglGetVertexAttribfv = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribiv = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointerv = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgram = PROCEDURE {WINAPI} (programObj: GLHandle) : GLboolean;
  TglIsShader = PROCEDURE {WINAPI} (shaderObj: GLHandle) : GLboolean;
  TglLinkProgram = PROCEDURE {WINAPI} (programObj: GLHandle);
  TglShaderSource = PROCEDURE {WINAPI} (shaderObj: GLHandle; count: GLsizei; xstring: PGLchar; lengths: PGLint);
  TglUseProgram = PROCEDURE {WINAPI} (programObj: GLHandle);
  TglUniform1f = PROCEDURE {WINAPI} (location: GLint; v0: GLfloat);
  TglUniform2f = PROCEDURE {WINAPI} (location: GLint; v0, v1: GLfloat);
  TglUniform3f = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2: GLfloat);
  TglUniform4f = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2, v3: GLfloat);
  TglUniform1i = PROCEDURE {WINAPI} (location: GLint; v0: GLint);
  TglUniform2i = PROCEDURE {WINAPI} (location: GLint; v0, v1: GLint);
  TglUniform3i = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2: GLint);
  TglUniform4i = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2, v3: GLint);
  TglUniform1fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform2fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform3fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform4fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform1iv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform2iv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform3iv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform4iv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniformMatrix2fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglValidateProgram = PROCEDURE {WINAPI} (programObj: GLHandle);
  TglVertexAttrib1d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble);
  TglVertexAttrib1dv = PROCEDURE {WINAPI} (index: GLuint;   v: PGLdouble);
  TglVertexAttrib1f = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat);
  TglVertexAttrib1fv = PROCEDURE {WINAPI} (index: GLuint;   v: PGLfloat);
  TglVertexAttrib1s = PROCEDURE {WINAPI} (index: GLuint; x: GLshort);
  TglVertexAttrib1sv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib2d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib2f = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib2s = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2sv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib3d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib3f = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib3s = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3sv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4Nbv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLbyte);
  TglVertexAttrib4Niv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttrib4Nsv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4Nub = PROCEDURE {WINAPI} (index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4Nubv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttrib4Nuiv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttrib4Nusv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLushort);
  TglVertexAttrib4bv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLbyte);
  TglVertexAttrib4d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib4f = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib4iv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttrib4s = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4sv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttrib4uiv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttrib4usv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLushort);
  TglVertexAttribPointer = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei;  xpointer: PGLvoid);

  (*! GL_VERSION_2_1 *)
  TglUniformMatrix2x3fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3x2fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix2x4fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4x2fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3x4fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4x3fv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);

  (*! GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions:
   ARB_framebuffer_object
   ARB_map_buffer_range
   ARB_vertex_array_object  *)
  TglColorMaski = PROCEDURE {WINAPI} (index_: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean);
  TglGetBooleani_v = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PGLboolean);
  TglGetIntegeri_v = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PGLint);
  TglEnablei = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint);
  TglDisablei = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint);
  TglIsEnabledi = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint): GLboolean;
  TglBeginTransformFeedback = PROCEDURE {WINAPI} (primitiveMode: GLenum);
  TglEndTransformFeedback = PROCEDURE {WINAPI} ();
  TglBindBufferRange = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei);
  TglBindBufferBase = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryings = PROCEDURE {WINAPI} (xprogram: GLuint; count: GLsizei;  varyings: PPGLchar; bufferMode: GLenum);
  TglGetTransformFeedbackVarying = PROCEDURE {WINAPI} (xprogram: GLuint; index_: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; type_: PGLsizei; name: PGLchar);
  TglClampColor = PROCEDURE {WINAPI} (targe: GLenum; clamp: GLenum);
  TglBeginConditionalRender = PROCEDURE {WINAPI} (id: GLuint; mode: GLenum);
  TglEndConditionalRender = PROCEDURE {WINAPI} ();
  TglVertexAttribIPointer = PROCEDURE {WINAPI} (index_: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribIiv = PROCEDURE {WINAPI} (index_: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribIuiv = PROCEDURE {WINAPI} (index_: GLuint; pname: GLenum; params: PGLuint);
  TglVertexAttribI1i = PROCEDURE {WINAPI} (index_: GLuint; x: GLint);
  TglVertexAttribI2i = PROCEDURE {WINAPI} (index_: GLuint; x: GLint; y: GLint);
  TglVertexAttribI3i = PROCEDURE {WINAPI} (index_: GLuint; x: GLint; y: GLint; z: GLint);
  TglVertexAttribI4i = PROCEDURE {WINAPI} (index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexAttribI1ui = PROCEDURE {WINAPI} (index_: GLuint; x: GLuint);
  TglVertexAttribI2ui = PROCEDURE {WINAPI} (index_: GLuint; x: GLuint; y: GLuint);
  TglVertexAttribI3ui = PROCEDURE {WINAPI} (index_: GLuint; x: GLuint; y: GLuint; z: GLuint);
  TglVertexAttribI4ui = PROCEDURE {WINAPI} (index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglVertexAttribI1iv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLint);
  TglVertexAttribI2iv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLint);
  TglVertexAttribI3iv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLint);
  TglVertexAttribI4iv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLint);
  TglVertexAttribI1uiv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLuint);
  TglVertexAttribI2uiv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLuint);
  TglVertexAttribI3uiv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLuint);
  TglVertexAttribI4uiv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLuint);
  TglVertexAttribI4bv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLbyte);
  TglVertexAttribI4sv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLshort);
  TglVertexAttribI4ubv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLubyte);
  TglVertexAttribI4usv = PROCEDURE {WINAPI} (index_: GLuint;  v: PGLushort);
  TglGetUniformuiv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; params: PGLuint);
  TglBindFragDataLocation = PROCEDURE {WINAPI} (xprogram: GLuint; color: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataLocation = PROCEDURE {WINAPI} (xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;
  TglUniform1ui = PROCEDURE {WINAPI} (location: GLint; v0: GLuint);
  TglUniform2ui = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint);
  TglUniform3ui = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglUniform4ui = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglUniform1uiv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform2uiv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform3uiv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform4uiv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglTexParameterIiv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglTexParameterIuiv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetTexParameterIiv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterIuiv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLuint);
  TglClearBufferiv = PROCEDURE {WINAPI} (buffer: GLenum; drawbuffer: GLint;  value: PGLint);
  TglClearBufferuiv = PROCEDURE {WINAPI} (buffer: GLenum; drawbuffer: GLint;  value: PGLuint);
  TglClearBufferfv = PROCEDURE {WINAPI} (buffer: GLenum; drawbuffer: GLint;  value: PGLfloat);
  TglClearBufferfi = PROCEDURE {WINAPI} (buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint);
  TglGetStringi = PROCEDURE {WINAPI} (name: GLenum; index: GLuint): PGLubyte;

  (*! GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions:
   ARB_copy_buffer
   ARB_uniform_buffer_object  *)
  TglDrawArraysInstanced = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstanced = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei);
  TglTexBuffer = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; buffer: GLuint);
  TglPrimitiveRestartIndex = PROCEDURE {WINAPI} (index_: GLuint);

  (*! GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions:
   ARB_draw_elements_base_vertex
   ARB_provoking_vertex
   ARB_sync
   ARB_texture_multisample  *)
  TglGetInteger64i_v = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PGLint64);
  TglGetBufferParameteri64v = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint64);
  TglFramebufferTexture = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
  (*TglFramebufferTextureFace = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); *)

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
  (* ARB_vertexxtype_2_10_10_10_rev *)
  TglVertexAttribDivisor = PROCEDURE {WINAPI} (index: GLuint; divisor: GLuint);


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
  TglMinSampleShading = PROCEDURE {WINAPI} (value: GLclampf);
  TglBlendEquationi = PROCEDURE {WINAPI} (buf: GLuint; mode: GLenum);
  TglBlendEquationSeparatei = PROCEDURE {WINAPI} (buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);
  TglBlendFunci = PROCEDURE {WINAPI} (buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparatei = PROCEDURE {WINAPI} (buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);

  (*! GL_VERSION_4_1 *)
  (* OpenGL 4.1 also reuses entry points from these extensions: *)
  (* ARB_ES2_compatibility *)
  (* ARB_get_program_binary *)
  (* ARB_separate_shader_objects *)
  (* ARB_shader_precision (no entry points) *)
  (* ARB_vertex_attrib_64bit *)
  (* ARB_viewport_array *)


 (* GL_3DFX_tbuffer *)
  TglTbufferMask3DFX = PROCEDURE {WINAPI} (mask: GLuint);
(****************************************)
  (* GL_APPLE_element_array *)
  TglElementPointerAPPLE = PROCEDURE {WINAPI} (xtype:  GLenum; xpointer: PGLvoid);
  TglDrawElementArrayAPPLE = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei);
  TglDrawRangeElementArrayAPPLE = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; xend: GLuint; first: GLint; count: GLsizei);
  TglMultiDrawElementArrayAPPLE = PROCEDURE {WINAPI} (mode: GLenum;  first: PGLint;  count: PGLsizei; primcount: GLsizei);
  TglMultiDrawRangeElementArrayAPPLE = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; xend: GLuint;  first: PGLint; count: PGLsizei; primcount: GLsizei);

  (* GL_APPLE_fence *)
  TglGenFencesAPPLE = PROCEDURE {WINAPI} (n: GLsizei; fences: PGLuint);
  TglDeleteFencesAPPLE = PROCEDURE {WINAPI} (n: GLsizei; fences: PGLuint);
  TglSetFenceAPPLE = PROCEDURE {WINAPI} (fence: GLuint);
  TglIsFenceAPPLE = PROCEDURE {WINAPI} (fence: GLuint): GLboolean;
  TglTestFenceAPPLE = PROCEDURE {WINAPI} (fence: GLuint): GLboolean;
  TglFinishFenceAPPLE= PROCEDURE {WINAPI} (fence: GLuint);
  TglTestObjectAPPLE = PROCEDURE {WINAPI} (_object: GLenum; name: GLuint): GLboolean;
  TglFinishObjectAPPLE= PROCEDURE {WINAPI} (_object: GLenum; name: GLint);

  (* GL_APPLE_vertex_array_object *)
  TglBindVertexArrayAPPLE = PROCEDURE {WINAPI} (xarray: GLuint);
  TglDeleteVertexArraysAPPLE = PROCEDURE {WINAPI} (n: GLsizei; xarrays: PGLuint);
  TglGenVertexArraysAPPLE = PROCEDURE {WINAPI} (n: GLsizei; xarrays: PGLuint);
  TglIsVertexArrayAPPLE = PROCEDURE {WINAPI} (narray: GLuint): GLboolean;

  (*  GL_APPLE_vertex_array_range *)
  TglVertexArrayRangeAPPLE = PROCEDURE {WINAPI} (length: GLsizei; xpointer: PGLvoid);
  TglFlushVertexArrayRangeAPPLE = PROCEDURE {WINAPI} (length: GLsizei; xpointer: PGLvoid);
  TglVertexArrayParameteriAPPLE = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);

  (*  GL_APPLE_texture_range *)
  TglTextureRangeAPPLE = PROCEDURE {WINAPI} (target: GLenum; xlength: GLsizei; xpointer: PGLvoid);
  TglGetTexParameterPointervAPPLE = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PPGLvoid);

  (*  GL_APPLE_vertex_program_evaluators *)
  TglEnableVertexAttribAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; pname: GLenum);
  TglDisableVertexAttribAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; pname: GLenum);
  TglIsVertexAttribEnabledAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; pname: GLenum): GLboolean;
  TglMapVertexAttrib1dAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint; points: PGLdouble);
  TglMapVertexAttrib1fAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; points: PGLfloat);
  TglMapVertexAttrib2dAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; points: PGLdouble);
  TglMapVertexAttrib2fAPPLE = PROCEDURE {WINAPI} (indexx: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; ustride: GLint; order: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; points: GLfloat);

  (*  GL_APPLE_object_purgeable *)
  TglObjectPurgeableAPPLE = PROCEDURE {WINAPI} (objectType: GLenum; name: GLuint; option: GLenum): GLenum;
  TglObjectUnpurgeableAPPLE = PROCEDURE {WINAPI} (objectType: GLenum; name: GLuint; option: GLenum): GLenum;
  TglGetObjectParameterivAPPLE = PROCEDURE {WINAPI} (objectType: GLenum; name: GLuint; pname: GLenum; params: PGLint);

(**********************************)
  (* GL_ARB_matrix_palette *)
  TglCurrentPaletteMatrixARB = PROCEDURE {WINAPI} (index: GLint);
  TglMatrixIndexubvARB = PROCEDURE {WINAPI} (size: GLint;  indices: PGLubyte);
  TglMatrixIndexusvARB = PROCEDURE {WINAPI} (size: GLint;  indices: PGLushort);
  TglMatrixIndexuivARB = PROCEDURE {WINAPI} (size: GLint;  indices: PGLuint);
  TglMatrixIndexPointerARB = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_ARB_multisample *)
  TglSampleCoverageARB = PROCEDURE {WINAPI} (value: GLclampf; invert: GLboolean);

  (* GL_ARB_multitexture *)
  TglActiveTextureARB = PROCEDURE {WINAPI} (texture: GLenum);
  TglClientActiveTextureARB = PROCEDURE {WINAPI} (texture: GLenum);
  TglMultiTexCoord1dARB = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble);
  TglMultiTexCoord1dvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord1fARB = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat);
  TglMultiTexCoord1fvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord1iARB = PROCEDURE {WINAPI} (target: GLenum; s: GLint);
  TglMultiTexCoord1ivARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord1sARB = PROCEDURE {WINAPI} (target: GLenum; s: GLshort);
  TglMultiTexCoord1svARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord2dARB = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble);
  TglMultiTexCoord2dvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord2fARB = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat);
  TglMultiTexCoord2fvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord2iARB = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint);
  TglMultiTexCoord2ivARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord2sARB = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort);
  TglMultiTexCoord2svARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord3dARB = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);
  TglMultiTexCoord3dvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord3fARB = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);
  TglMultiTexCoord3fvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord3iARB = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint; r: GLint);
  TglMultiTexCoord3ivARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord3sARB = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort; r: GLshort);
  TglMultiTexCoord3svARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);
  TglMultiTexCoord4dARB = PROCEDURE {WINAPI} (target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglMultiTexCoord4dvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLdouble);
  TglMultiTexCoord4fARB = PROCEDURE {WINAPI} (target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglMultiTexCoord4fvARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLfloat);
  TglMultiTexCoord4iARB = PROCEDURE {WINAPI} (target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);
  TglMultiTexCoord4ivARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLint);
  TglMultiTexCoord4sARB = PROCEDURE {WINAPI} (target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglMultiTexCoord4svARB = PROCEDURE {WINAPI} (target: GLenum;  v: PGLshort);

  (* GL_ARB_point_parameters *)
  TglPointParameterfARB = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPointParameterfvARB = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);

  (* GL_ARB_texture_compression *)
  TglCompressedTexImage3DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage2DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage1DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage3DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage2DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage1DARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglGetCompressedTexImageARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; img: PGLvoid);

  (* GL_ARB_transpose_matrix *)
  TglLoadTransposeMatrixfARB = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglLoadTransposeMatrixdARB = PROCEDURE {WINAPI} ( m: PGLdouble);
  TglMultTransposeMatrixfARB = PROCEDURE {WINAPI} ( m: PGLfloat);
  TglMultTransposeMatrixdARB = PROCEDURE {WINAPI} ( m: PGLdouble);

  (* GL_ARB_vertex_blend *)
  TglWeightbvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLbyte);
  TglWeightsvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLshort);
  TglWeightivARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLint);
  TglWeightfvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLfloat);
  TglWeightdvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLdouble);
  TglWeightubvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLubyte);
  TglWeightusvARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLushort);
  TglWeightuivARB = PROCEDURE {WINAPI} (size: GLint;  weights: PGLuint);
  TglWeightPointerARB = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglVertexBlendARB = PROCEDURE {WINAPI} (count: GLint);

  (* GL_ARB_vertex_buffer_object *)
  TglBindBufferARB = PROCEDURE {WINAPI} (target: GLenum; buffer: GLuint);
  TglDeleteBuffersARB = PROCEDURE {WINAPI} (n: GLsizei;  buffers: PGLuint);
  TglGenBuffersARB = PROCEDURE {WINAPI} (n: GLsizei; buffers: PGLuint );
  TglIsBufferARB = PROCEDURE {WINAPI} (buffer: GLuint): GLboolean;
  TglBufferDataARB = PROCEDURE {WINAPI} (target: GLenum; size: GLsizei;  data: PGLvoid; usage: GLenum);
  TglBufferSubDataARB = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; size: GLsizei;  data: PGLvoid);
  TglGetBufferSubDataARB = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; size: GLsizei; data: PGLvoid);
  TglMapBufferARB = PROCEDURE {WINAPI} (target: GLenum; access: GLenum): PGLvoid;
  TglUnmapBufferARB = PROCEDURE {WINAPI} ( target: GLenum): GLboolean;
  TglGetBufferParameterivARB = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetBufferPointervARB = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLvoid);

  (* GL_ARB_vertex_program *)
  TglVertexAttrib1dARB = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble);
  TglVertexAttrib1dvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib1fARB = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat);
  TglVertexAttrib1fvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib1sARB = PROCEDURE {WINAPI} (index: GLuint; x: GLshort);
  TglVertexAttrib1svARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib2dARB = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib2fARB = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib2sARB = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2svARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib3dARB = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib3fARB = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib3sARB = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3svARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4NbvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLbyte);
  TglVertexAttrib4NivARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttrib4NsvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4NubARB = PROCEDURE {WINAPI} (index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4NubvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttrib4NuivARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttrib4NusvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLushort);
  TglVertexAttrib4bvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLbyte);
  TglVertexAttrib4dARB = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib4fARB = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib4ivARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttrib4sARB = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4svARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttrib4uivARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttrib4usvARB = PROCEDURE {WINAPI} (index: GLuint;  v: PGLushort);
  TglVertexAttribPointerARB = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei; xpointer: PGLvoid);
  TglEnableVertexAttribArrayARB = PROCEDURE {WINAPI} (index: GLuint);
  TglDisableVertexAttribArrayARB = PROCEDURE {WINAPI} (index: GLuint);
  TglProgramStringARB = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; len: GLsizei;  xstring: PGLvoid);
  TglBindProgramARB = PROCEDURE {WINAPI} (target: GLenum; xprogram: GLuint);
  TglDeleteProgramsARB = PROCEDURE {WINAPI} (n: GLsizei;  programs: PGLuint);
  TglGenProgramsARB = PROCEDURE {WINAPI} (n: GLsizei; programs: PGLuint);
  TglProgramEnvParameter4dARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramEnvParameter4dvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLdouble);
  TglProgramEnvParameter4fARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramEnvParameter4fvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLfloat);
  TglProgramLocalParameter4dARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramLocalParameter4dvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLdouble);
  TglProgramLocalParameter4fARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramLocalParameter4fvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLfloat);
  TglGetProgramEnvParameterdvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLdouble);
  TglGetProgramEnvParameterfvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLfloat);
  TglGetProgramLocalParameterdvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLdouble);
  TglGetProgramLocalParameterfvARB = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLfloat);
  TglGetProgramivARB = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetProgramStringARB = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; _string: PGLvoid);
  TglGetVertexAttribdvARB = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetVertexAttribfvARB = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribivARB = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointervARB = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgramARB = PROCEDURE {WINAPI} (xprogram: GLuint): GLboolean;

  (* GL_ARB_window_pos *)
  TglWindowPos2dARB = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble);
  TglWindowPos2dvARB = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos2fARB = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat);
  TglWindowPos2fvARB = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos2iARB = PROCEDURE {WINAPI} (x: GLint; y: GLint);
  TglWindowPos2ivARB = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos2sARB = PROCEDURE {WINAPI} (x: GLshort; y: GLshort);
  TglWindowPos2svARB = PROCEDURE {WINAPI} ( v: PGLshort);
  TglWindowPos3dARB = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dvARB = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos3fARB = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fvARB = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos3iARB = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint);
  TglWindowPos3ivARB = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos3sARB = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3svARB = PROCEDURE {WINAPI} ( v: PGLshort);

  (* GL_ARB_draw_buffers *)
  TglDrawBuffersARB = PROCEDURE {WINAPI} (n: GLsizei; bufs: PGLenum);

  (* GL_ARB_color_buffer_float *)
  TglClampColorARB = PROCEDURE {WINAPI} (target: GLenum; clamp: GLenum);

  (* GL_ARB_vertex_shader *)
  TglGetActiveAttribARB = PROCEDURE {WINAPI} (programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLcharARB);
  TglGetAttribLocationARB = PROCEDURE {WINAPI} (programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint;
  TglBindAttribLocationARB = PROCEDURE {WINAPI} (programObj: GLHandleARB; index: GLuint; CONST name: ARRAY OF CHAR);

  (* GL_ARB_shader_objects *)
  TglDeleteObjectARB = PROCEDURE {WINAPI} (Obj: GLHandleARB);
  TglGetHandleARB = PROCEDURE {WINAPI} (pname: GLenum): GLHandleARB;
  TglDetachObjectARB = PROCEDURE {WINAPI} (container, attached: GLHandleARB);
  TglCreateShaderObjectARB = PROCEDURE {WINAPI} (shaderType: GLenum): GLHandleARB;
  TglShaderSourceARB = PROCEDURE {WINAPI} (shaderObj: GLHandleARB; count: GLsizei; xstring: PPGLcharARB; lengths: PGLint);
  TglCompileShaderARB = PROCEDURE {WINAPI} (shaderObj: GLHandleARB);
  TglCreateProgramObjectARB = PROCEDURE {WINAPI} (): GLHandleARB;
  TglAttachObjectARB = PROCEDURE {WINAPI} (programObj, shaderObj: GLHandleARB);
  TglLinkProgramARB = PROCEDURE {WINAPI} (programObj: GLHandleARB);
  TglUseProgramObjectARB = PROCEDURE {WINAPI} (programObj: GLHandleARB);
  TglValidateProgramARB = PROCEDURE {WINAPI} (programObj: GLHandleARB);
  TglUniform1fARB = PROCEDURE {WINAPI} (location: GLint; v0: GLfloat);
  TglUniform2fARB = PROCEDURE {WINAPI} (location: GLint; v0, v1: GLfloat);
  TglUniform3fARB = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2: GLfloat);
  TglUniform4fARB = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2, v3: GLfloat);
  TglUniform1iARB = PROCEDURE {WINAPI} (location: GLint; v0: GLint);
  TglUniform2iARB = PROCEDURE {WINAPI} (location: GLint; v0, v1: GLint);
  TglUniform3iARB = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2: GLint);
  TglUniform4iARB = PROCEDURE {WINAPI} (location: GLint; v0, v1, v2, v3: GLint);
  TglUniform1fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform2fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform3fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform4fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform1ivARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform2ivARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform3ivARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniform4ivARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; value: PGLint);
  TglUniformMatrix2fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4fvARB = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglGetObjectParameterfvARB = PROCEDURE {WINAPI} (Obj: GLHandleARB; pname: GLenum; params: PGLfloat);
  TglGetObjectParameterivARB = PROCEDURE {WINAPI} (Obj: GLHandleARB; pname: GLenum; params: PGLint);
  TglGetInfoLogARB = PROCEDURE {WINAPI} (shaderObj: GLHandleARB; maxLength: GLsizei; VAR length: GLint; infoLog: PGLcharARB);
  TglGetAttachedObjectsARB = PROCEDURE {WINAPI} (programobj: GLHandleARB; maxCount: GLsizei; VAR count: GLsizei; objects: PGLHandleARB);
  TglGetUniformLocationARB = PROCEDURE {WINAPI} (programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint;
  TglGetActiveUniformARB = PROCEDURE {WINAPI} (programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLcharARB);
  TglGetUniformfvARB = PROCEDURE {WINAPI} (programObj: GLHandleARB; location: GLint; params: PGLfloat);
  TglGetUniformivARB = PROCEDURE {WINAPI} (programObj: GLHandleARB; location: GLint; params: PGLint);
  TglGetShaderSourceARB = PROCEDURE {WINAPI} (shader: GLHandleARB; maxLength: GLsizei; VAR length: GLsizei; source: PGLcharARB);

  (* GL_ARB_Occlusion_Query *)
  TglGenQueriesARB = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglDeleteQueriesARB = PROCEDURE {WINAPI} (n: GLsizei;  ids: PGLuint);
  TglIsQueryARB = PROCEDURE {WINAPI} (id: GLuint): BOOLEAN;
  TglBeginQueryARB = PROCEDURE {WINAPI} (target: GLenum; id: GLuint);
  TglEndQueryARB = PROCEDURE {WINAPI} (target: GLenum);
  TglGetQueryivARB = PROCEDURE {WINAPI} (target, pname: GLenum; params: PGLint);
  TglGetQueryObjectivARB = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint);
  TglGetQueryObjectuivARB = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLuint);

  (* GL_ARB_draw_instanced *)
  TglDrawArraysInstancedARB = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstancedARB = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei);

  (* GL_ARB_framebuffer_object *)
  TglIsRenderbuffer = PROCEDURE {WINAPI} (renderbuffer: GLuint): GLboolean;
  TglBindRenderbuffer = PROCEDURE {WINAPI} (target: GLenum; renderbuffer: GLuint);
  TglDeleteRenderbuffers = PROCEDURE {WINAPI} (n: GLsizei;  renderbuffers: PGLuint);
  TglGenRenderbuffers = PROCEDURE {WINAPI} (n: GLsizei; renderbuffers: PGLuint);
  TglRenderbufferStorage = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetRenderbufferParameteriv = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglIsFramebuffer = PROCEDURE {WINAPI} (framebuffer: GLuint): GLboolean;
  TglBindFramebuffer = PROCEDURE {WINAPI} (target: GLenum; framebuffer: GLuint);
  TglDeleteFramebuffers = PROCEDURE {WINAPI} (n: GLsizei;  framebuffers: PGLuint);
  TglGenFramebuffers = PROCEDURE {WINAPI} (n: GLsizei; framebuffers: PGLuint);
  TglCheckFramebufferStatus = PROCEDURE {WINAPI} (target: GLenum): GLenum;
  TglFramebufferTexture1D = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture2D = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture3D = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglFramebufferRenderbuffer = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetFramebufferAttachmentParameteriv = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateMipmap = PROCEDURE {WINAPI} (target: GLenum);
  TglBlitFramebuffer = PROCEDURE {WINAPI} (srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum);
  TglRenderbufferStorageMultisample = PROCEDURE {WINAPI} (target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglFramebufferTextureLayer = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);

  (* GL_ARB_geometry_shader4 *)
  TglProgramParameteriARB = PROCEDURE {WINAPI} (xprogram: GLuint; pname: GLenum; value: GLint);
  TglFramebufferTextureARB = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTextureLayerARB = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);
  TglFramebufferTextureFaceARB = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);

  (* GL_ARB_instanced_arrays *)
  TglVertexAttribDivisorARB = PROCEDURE {WINAPI} (index_: GLuint; divisor: GLuint);

  (* GL_ARB_map_buffer_range *)
  TglMapBufferRange = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; length: GLsizei; access: GLbitfield): PGLvoid;
  TglFlushMappedBufferRange = PROCEDURE {WINAPI} (target: GLenum; offset: GLsizei; length: GLsizei);

  (* GL_ARB_texture_buffer_object *)
  TglTexBufferARB = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; buffer: GLuint);

  (* GL_ARB_vertex_array_object *)
  TglBindVertexArray = PROCEDURE {WINAPI} (array_: GLuint);
  TglDeleteVertexArrays = PROCEDURE {WINAPI} (n: GLsizei;  arrays: PGLuint);
  TglGenVertexArrays = PROCEDURE {WINAPI} (n: GLsizei; arrays: PGLuint);
  TglIsVertexArray = PROCEDURE {WINAPI} (array_: GLuint): GLboolean;

  (* GL_ARB_uniform_buffer_object *)
  TglGetUniformIndices = PROCEDURE {WINAPI} (xprogram: GLuint; uniformCount: GLsizei;  uniformNames: PPGLchar; uniformIndices: PGLuint);
  TglGetActiveUniformsiv = PROCEDURE {WINAPI} (xprogram: GLuint; uniformCount: GLsizei;  uniformIndices: PGLuint; pname: GLenum; params: PGLint);
  TglGetActiveUniformName = PROCEDURE {WINAPI} (xprogram: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar);
  TglGetUniformBlockIndex = PROCEDURE {WINAPI} (xprogram: GLuint; CONST uniformBlockName: ARRAY OF CHAR): GLuint;
  TglGetActiveUniformBlockiv = PROCEDURE {WINAPI} (xprogram: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint);
  TglGetActiveUniformBlockName = PROCEDURE {WINAPI} (xprogram: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar);
  TglUniformBlockBinding = PROCEDURE {WINAPI} (xprogram: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint);

  (* GL_ARB_copy_buffer *)
  TglCopyBufferSubData = PROCEDURE {WINAPI} (readTarget: GLenum; writeTarget: GLenum; readOffset: GLint; writeOffset: GLint; size: GLsizei);

  (* GL_ARB_draw_elements_base_vertex *)
  TglDrawElementsBaseVertex = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; basevertex: GLint);
  TglDrawRangeElementsBaseVertex = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum;  indices: PGLvoid; basevertex: GLint);
  TglDrawElementsInstancedBaseVertex = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei; basevertex: GLint);
  TglMultiDrawElementsBaseVertex = PROCEDURE {WINAPI} (mode: GLenum;  count: PGLsizei; type_: GLenum;  indices: PPGLvoid; primcount: GLsizei;  basevertex: PGLint);

  (* GL_ARB_provoking_vertex *)
  TglProvokingVertex = PROCEDURE {WINAPI} (mode: GLenum);

  (* GL_ARB_sync *)
  TglFenceSync = PROCEDURE {WINAPI} (condition: GLenum; flags: GLbitfield): GLsync;
  TglIsSync = PROCEDURE {WINAPI} (sync: GLsync): GLboolean;
  TglDeleteSync = PROCEDURE {WINAPI} (sync: GLsync);
  TglClientWaitSync = PROCEDURE {WINAPI} (sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum;
  TglWaitSync = PROCEDURE {WINAPI} (sync: GLsync; flags: GLbitfield; timeout: GLuint64);
  TglGetInteger64v = PROCEDURE {WINAPI} (pname: GLenum; params: PGLint64);
  TglGetSynciv = PROCEDURE {WINAPI} (sync: GLsync; pname: GLenum; butSize: GLsizei; length: PGLsizei; values: PGLint);

  (* GL_ARB_texture_multisample *)
  TglTexImage2DMultisample = PROCEDURE {WINAPI} (target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean);
  TglTexImage3DMultisample = PROCEDURE {WINAPI} (target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean);
  TglGetMultisamplefv = PROCEDURE {WINAPI} (pname: GLenum; index_: GLuint; val: PGLfloat);
  TglSampleMaski = PROCEDURE {WINAPI} (index_: GLuint; mask: GLbitfield);

  (* GL_ARB_draw_buffers_blend *)
  TglBlendEquationiARB = PROCEDURE {WINAPI} (buf: GLuint; mode: GLenum);
  TglBlendEquationSeparateiARB = PROCEDURE {WINAPI} (buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);
  TglBlendFunciARB = PROCEDURE {WINAPI} (buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparateiARB = PROCEDURE {WINAPI} (buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);

  (* GL_ARB_sample_shading *)
  TglMinSampleShadingARB = PROCEDURE {WINAPI} (value: GLclampf);

    (*  GL_ARB_shading_language_include *)
  TglNamedStringARB = PROCEDURE {WINAPI} (type_: GLenum; namelen: GLint; CONST name: ARRAY OF CHAR; stringlen: GLint; CONST xstring: ARRAY OF CHAR);
  TglDeleteNamedStringARB = PROCEDURE {WINAPI} (namelen: GLint; CONST name: ARRAY OF CHAR);
  TglCompileShaderIncludeARB = PROCEDURE {WINAPI} (shader: GLuint; count: GLsizei;  path: PPGLchar;  length: PGLint);
  TglIsNamedStringARB = PROCEDURE {WINAPI} (namelen: GLint; CONST name: ARRAY OF CHAR): GLboolean;
  TglGetNamedStringARB = PROCEDURE {WINAPI} (namelen: GLint; CONST name: ARRAY OF CHAR; bufSize: GLsizei; stringlen: GLint; xstring: PGLchar);
  TglGetNamedStringivARB = PROCEDURE {WINAPI} (namelen: GLint; CONST name: ARRAY OF CHAR; pname: GLenum; params: PGLint);

  (*  GL_ARB_blend_func_extended *)
  TglBindFragDataLocationIndexed = PROCEDURE {WINAPI} (xprogram: GLuint; colorNumber: GLuint; index: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataIndex = PROCEDURE {WINAPI} (xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;

  (*  GL_ARB_sampler_objects *)
  TglGenSamplers = PROCEDURE {WINAPI} (count: GLsizei; samplers: PGLuint);
  TglDeleteSamplers = PROCEDURE {WINAPI} (count: GLsizei;  samplers: PGLuint);
  TglIsSampler = PROCEDURE {WINAPI} (sampler: GLuint): GLboolean;
  TglBindSampler = PROCEDURE {WINAPI} (unit_: GLuint; sampler: GLuint);
  TglSamplerParameteri = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; param: GLint);
  TglSamplerParameteriv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum;  param: PGLint);
  TglSamplerParameterf = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; param: GLfloat);
  TglSamplerParameterfv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum;  param: PGLfloat);
  TglSamplerParameterIiv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum;  param: PGLint);
  TglSamplerParameterIuiv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum;  param: PGLuint);
  TglGetSamplerParameteriv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; params: PGLint);
  TglGetSamplerParameterIiv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; params: PGLint);
  TglGetSamplerParameterfv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; params: PGLfloat);
  TglGetSamplerParameterIuiv = PROCEDURE {WINAPI} (sampler: GLuint; pname: GLenum; params: PGLuint);

  (*  GL_ARB_timer_query *)
  TglQueryCounter = PROCEDURE {WINAPI} (id: GLuint; target: GLenum);
  TglGetQueryObjecti64v = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint64);
  TglGetQueryObjectui64v = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLuint64);

  (*  GL_ARB_vertexxtype_2_10_10_10_rev *)
  TglVertexP2ui = PROCEDURE {WINAPI} (type_: GLenum; value: GLuint);
  TglVertexP2uiv = PROCEDURE {WINAPI} (type_: GLenum;  value: PGLuint);
  TglVertexP3ui = PROCEDURE {WINAPI} (type_: GLenum; value: GLuint);
  TglVertexP3uiv = PROCEDURE {WINAPI} (type_: GLenum;  value: PGLuint);
  TglVertexP4ui = PROCEDURE {WINAPI} (type_: GLenum; value: GLuint);
  TglVertexP4uiv = PROCEDURE {WINAPI} (type_: GLenum;  value: PGLuint);
  TglTexCoordP1ui = PROCEDURE {WINAPI} (type_: GLenum; coords: GLuint);
  TglTexCoordP1uiv = PROCEDURE {WINAPI} (type_: GLenum;  coords: PGLuint);
  TglTexCoordP2ui = PROCEDURE {WINAPI} (type_: GLenum; coords: GLuint);
  TglTexCoordP2uiv = PROCEDURE {WINAPI} (type_: GLenum;  coords: PGLuint);
  TglTexCoordP3ui = PROCEDURE {WINAPI} (type_: GLenum; coords: GLuint);
  TglTexCoordP3uiv = PROCEDURE {WINAPI} (type_: GLenum;  coords: PGLuint);
  TglTexCoordP4ui = PROCEDURE {WINAPI} (type_: GLenum; coords: GLuint);
  TglTexCoordP4uiv = PROCEDURE {WINAPI} (type_: GLenum;  coords: PGLuint);
  TglMultiTexCoordP1ui = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP1uiv = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum;  coords: PGLuint);
  TglMultiTexCoordP2ui = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP2uiv = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: PGLuint);
  TglMultiTexCoordP3ui = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP3uiv = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: PGLuint);
  TglMultiTexCoordP4ui = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP4uiv = PROCEDURE {WINAPI} (texture: GLenum; type_: GLenum; coords: PGLuint);
  TglNormalP3ui = PROCEDURE {WINAPI} (type_: GLenum; coords: GLuint);
  TglNormalP3uiv = PROCEDURE {WINAPI} (type_: GLenum;  coords: PGLuint);
  TglColorP3ui = PROCEDURE {WINAPI} (type_: GLenum; color: GLuint);
  TglColorP3uiv = PROCEDURE {WINAPI} (type_: GLenum;  color: PGLuint);
  TglColorP4ui = PROCEDURE {WINAPI} (type_: GLenum; color: GLuint);
  TglColorP4uiv = PROCEDURE {WINAPI} (type_: GLenum;  color: GLuint);
  TglSecondaryColorP3ui = PROCEDURE {WINAPI} (type_: GLenum; color: GLuint);
  TglSecondaryColorP3uiv = PROCEDURE {WINAPI} (type_: GLenum;  color: PGLuint);
  TglVertexAttribP1ui = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP1uiv = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP2ui = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP2uiv = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP3ui = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP3uiv = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP4ui = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP4uiv = PROCEDURE {WINAPI} (index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);

  (*  GL_ARB_draw_indirect *)
  TglDrawArraysIndirect = PROCEDURE {WINAPI} (mode: GLenum;  indirect: PGLvoid);
  TglDrawElementsIndirect = PROCEDURE {WINAPI} (mode: GLenum; xtype: GLenum;  indirect: PGLvoid);

  (*  GL_ARB_gpu_shader_fp64 *)
  TglUniform1d = PROCEDURE {WINAPI} (location: GLint; x: GLdouble);
  TglUniform2d = PROCEDURE {WINAPI} (location: GLint; x: GLdouble; y: GLdouble);
  TglUniform3d = PROCEDURE {WINAPI} (location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglUniform4d = PROCEDURE {WINAPI} (location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglUniform1dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform2dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform3dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform4dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniformMatrix2dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix2x3dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix2x4dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3x2dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3x4dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4x2dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4x3dv = PROCEDURE {WINAPI} (location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglGetUniformdv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; params: PGLdouble);

  (*  GL_ARB_shader_subroutine *)
  TglGetSubroutineUniformLocation = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; CONST name: ARRAY OF CHAR): GLint;
  TglGetSubroutineIndex = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; CONST name: ARRAY OF CHAR): GLuint;
  TglGetActiveSubroutineUniformiv = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint);
  TglGetActiveSubroutineUniformName = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar);
  TglGetActiveSubroutineName = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar);
  TglUniformSubroutinesuiv = PROCEDURE {WINAPI} (shadertype: GLenum; count: GLsizei;  indices: PGLuint);
  TglGetUniformSubroutineuiv = PROCEDURE {WINAPI} (shadertype: GLenum; location: GLint; params: PGLuint);
  TglGetProgramStageiv = PROCEDURE {WINAPI} (xprogram: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint);

  (*  GL_ARB_tessellation_shader *)
  TglPatchParameteri = PROCEDURE {WINAPI} (pname: GLenum; value: GLint);
  TglPatchParameterfv = PROCEDURE {WINAPI} (pname: GLenum;  values: PGLfloat);

  (*  GL_ARB_transform_feedback2 *)
  TglBindTransformFeedback = PROCEDURE {WINAPI} (target: GLenum; id: GLuint);
  TglDeleteTransformFeedbacks = PROCEDURE {WINAPI} (n: GLsizei;  ids: PGLuint);
  TglGenTransformFeedbacks = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglIsTransformFeedback = PROCEDURE {WINAPI} (id: GLuint): GLboolean;
  TglPauseTransformFeedback = PROCEDURE {WINAPI} ();
  TglResumeTransformFeedback = PROCEDURE {WINAPI} ();
  TglDrawTransformFeedback = PROCEDURE {WINAPI} (mode: GLenum; id: GLuint);

  (*  GL_ARB_transform_feedback3 *)
  TglDrawTransformFeedbackStream = PROCEDURE {WINAPI} (mode: GLenum; id: GLuint; stream: GLuint);
  TglBeginQueryIndexed = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; id: GLuint);
  TglEndQueryIndexed = PROCEDURE {WINAPI} (target: GLenum; index: GLuint);
  TglGetQueryIndexediv = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; pname: GLenum; params: PGLint);

  (*  GL_ARB_ES2_compatibility *)
  TglReleaseShaderCompiler = PROCEDURE {WINAPI} ();
  TglShaderBinary = PROCEDURE {WINAPI} (count: GLsizei;  shaders: PGLuint; binaryformat: GLenum;  binary: PGLvoid; length: GLsizei);
  TglGetShaderPrecisionFormat = PROCEDURE {WINAPI} (shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint);
  TglDepthRangef = PROCEDURE {WINAPI} (n: GLclampf; f: GLclampf);
  TglClearDepthf = PROCEDURE {WINAPI} (d: GLclampf);

  (* GL_ARB_get_program_binary *)
  TglGetProgramBinary = PROCEDURE {WINAPI} (xprogram: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid);
  TglProgramBinary = PROCEDURE {WINAPI} (xprogram: GLuint; binaryFormat: GLenum;  binary: PGLvoid; length: GLsizei);
  TglProgramParameteri = PROCEDURE {WINAPI} (xprogram: GLuint; pname: GLenum; value: GLint);

  (* GL_ARB_separate_shader_objects*)
  TglUseProgramStages = PROCEDURE {WINAPI} (pipeline: GLuint; stages: GLbitfield; xprogram: GLuint);
  TglActiveShaderProgram = PROCEDURE {WINAPI} (pipeline: GLuint; xprogram: GLuint);
  TglCreateShaderProgramv = PROCEDURE {WINAPI} (type_: GLenum; count: GLsizei;  strings: PPGLchar): GLuint;
  TglBindProgramPipeline = PROCEDURE {WINAPI} (pipeline: GLuint);
  TglDeleteProgramPipelines = PROCEDURE {WINAPI} (n: GLsizei;  pipelines: PGLuint);
  TglGenProgramPipelines = PROCEDURE {WINAPI} (n: GLsizei; pipelines: PGLuint);
  TglIsProgramPipeline = PROCEDURE {WINAPI} (pipeline: GLuint): GLboolean;
  TglGetProgramPipelineiv = PROCEDURE {WINAPI} (pipeline: GLuint; pname: GLenum; params: PGLint);
  TglProgramUniform1i = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint);
  TglProgramUniform1iv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform1f = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat);
  TglProgramUniform1fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform1d = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLdouble);
  TglProgramUniform1dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform1ui = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint);
  TglProgramUniform1uiv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform2i = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint);
  TglProgramUniform2iv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform2f = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);
  TglProgramUniform2fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform2d = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble);
  TglProgramUniform2dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform2ui = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint);
  TglProgramUniform2uiv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform3i = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);
  TglProgramUniform3iv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform3f = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);
  TglProgramUniform3fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform3d = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble);
  TglProgramUniform3dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform3ui = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglProgramUniform3uiv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform4i = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);
  TglProgramUniform4iv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform4f = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);
  TglProgramUniform4fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform4d = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble);
  TglProgramUniform4dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform4ui = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglProgramUniform4uiv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniformMatrix2fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x3fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x2fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x4fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x2fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x4fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x3fv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x3dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x2dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x4dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x2dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x4dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x3dv = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglValidateProgramPipeline = PROCEDURE {WINAPI} (pipeline: GLuint);
  TglGetProgramPipelineInfoLog = PROCEDURE {WINAPI} (pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar);

  (* GL_ARB_vertex_attrib_64bit *)
  TglVertexAttribL1d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble);
  TglVertexAttribL2d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttribL3d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttribL4d = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttribL1dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL2dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL3dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL4dv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribLPointer = PROCEDURE {WINAPI} (index: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribLdv = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLdouble);

  (* GL_ARB_viewport_array*)
  TglViewportArrayv = PROCEDURE {WINAPI} (first: GLuint; count: GLsizei;  v: PGLfloat);
  TglViewportIndexedf = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat);
  TglViewportIndexedfv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglScissorArrayv = PROCEDURE {WINAPI} (first: GLuint; count: GLsizei;  v: PGLint);
  TglScissorIndexed = PROCEDURE {WINAPI} (index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei);
  TglScissorIndexedv = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglDepthRangeArrayv = PROCEDURE {WINAPI} (first: GLuint; count: GLsizei;  v: PGLclampd);
  TglDepthRangeIndexed = PROCEDURE {WINAPI} (index: GLuint; n: GLclampd; f: GLclampd);
  TglGetFloati_v = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; data: PGLfloat);
  TglGetDoublei_v = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; data: PGLdouble);

(**********************************************)
 (*! GL 4.2 *)

  (*  GL_ARB_base_instance *)
  TglDrawArraysInstancedBaseInstance = PROCEDURE {WINAPI} (mode : GLenum; first : GLint; count :GLsizei; primcount : GLsizei; baseinstance : GLuint);
  TglDrawElementsInstancedBaseInstance = PROCEDURE {WINAPI} (mode : GLenum; count : GLsizei; xtype : GLenum; indices : PGLvoid; primcount : GLsizei; baseinstance : GLuint);
  TglDrawElementsInstancedBaseVertexBaseInstance = PROCEDURE {WINAPI} (mode : GLenum; count : GLsizei; xtype : GLenum; indices : PGLvoid; primcount :GLsizei; basevertex : GLint; baseinstance : GLuint);

  (*  GL_ARB_transform_feedback_instanced *)
  TglDrawTransformFeedbackInstanced = PROCEDURE {WINAPI} (mode : GLenum; id : GLuint; primcount : GLsizei);
  TglDrawTransformFeedbackStreamInstanced = PROCEDURE {WINAPI} (mode : GLenum; id : GLuint; stream : GLuint; primcount : GLsizei);

  (*  GL_ARB_internalformat_query *)
  TglGetInternalformativ = PROCEDURE {WINAPI} (target : GLenum; internalformat : GLenum; pname : GLenum; bufSize : GLsizei; params : PGLint);

  (*  GL_ARB_shader_atomic_counters *)
  TglGetActiveAtomicCounterBufferiv = PROCEDURE {WINAPI} (xprogram : GLuint; bufferIndex : GLuint; pname : GLenum; params : PGLint);

  (* / GL_ARB_shader_image_load_store *)
  TglBindImageTexture = PROCEDURE {WINAPI} (xunit : GLuint; texture : GLuint; level :GLint; layered : GLboolean; layer : GLint; access : GLenum; format : GLenum);
  TglMemoryBarrier = PROCEDURE {WINAPI} (barriers : GLbitfield);

  (*  GL_ARB_texture_storage *)
  TglTexStorage1D = PROCEDURE {WINAPI} (target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei);
  TglTexStorage2D = PROCEDURE {WINAPI} (target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei);
  TglTexStorage3D = PROCEDURE {WINAPI} (target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei);
  TglTextureStorage1DEXT = PROCEDURE {WINAPI} (texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei);
  TglTextureStorage2DEXT = PROCEDURE {WINAPI} (texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei);
  TglTextureStorage3DEXT = PROCEDURE {WINAPI} (texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei);


(**********************************************)

  (* GL_ARB_cl_event *)
  TglCreateSyncFromCLeventARB = PROCEDURE {WINAPI} (context: p_cl_context; event: p_cl_event; flags: GLbitfield): GLsync;

  (* GL_ARB_debug_output*)
  TglDebugMessageControlARB = PROCEDURE {WINAPI} (source: GLenum; type_: GLenum; severity: GLenum; count: GLsizei;  ids: PGLuint; enabled: GLboolean);
  TglDebugMessageInsertARB = PROCEDURE {WINAPI} (source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei;  buf: PGLchar);
 (* TglDebugMessageCallbackARB = PROCEDURE {WINAPI} (callback: TglDebugProcARB;  userParam: PGLvoid); *)
  TglGetDebugMessageLogARB = PROCEDURE {WINAPI} (count: GLuint; bufsize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint;

  (* GL_ARB_robustness*)
  TglGetGraphicsResetStatusARB = PROCEDURE {WINAPI} (): GLenum;
  TglGetnMapdvARB = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble);
  TglGetnMapfvARB = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat);
  TglGetnMapivARB = PROCEDURE {WINAPI} (target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint);
  TglGetnPixelMapfvARB = PROCEDURE {WINAPI} (map: GLenum; bufSize: GLsizei; values: PGLfloat);
  TglGetnPixelMapuivARB = PROCEDURE {WINAPI} (map: GLenum; bufSize: GLsizei; values: PGLuint);
  TglGetnPixelMapusvARB = PROCEDURE {WINAPI} (map: GLenum; bufSize: GLsizei; values: PGLushort);
  TglGetnPolygonStippleARB = PROCEDURE {WINAPI} (bufSize: GLsizei; pattern: PGLubyte);
  TglGetnColorTableARB = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; table: PGLvoid);
  TglGetnConvolutionFilterARB = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; image: PGLvoid);
  TglGetnSeparableFilterARB = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; type_: GLenum; rowBufSize: GLsizei; row: PGLvoid; columnBufSize: GLsizei; column: PGLvoid; span: PGLvoid);
  TglGetnHistogramARB = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid);
  TglGetnMinmaxARB = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid);
  TglGetnTexImageARB = PROCEDURE {WINAPI} (target: GLenum; level: GLint; format: GLenum; type_: GLenum; bufSize: GLsizei; img: PGLvoid);
  TglReadnPixelsARB = PROCEDURE {WINAPI} (x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; bufSize: GLsizei; data: PGLvoid);
  TglGetnCompressedTexImageARB = PROCEDURE {WINAPI} (target: GLenum; lod: GLint; bufSize: GLsizei; img: PGLvoid);
  TglGetnUniformfvARB = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat);
  TglGetnUniformivARB = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLint);
  TglGetnUniformuivARB = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint);
  TglGetnUniformdvARB = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble);

  (* GL_ATI_draw_buffers *)
  TglDrawBuffersATI = PROCEDURE {WINAPI} (n: GLsizei;  bufs: PGLenum);

  (* GL_ATI_element_array *)
  TglElementPointerATI = PROCEDURE {WINAPI} (xtype: GLenum;  xpointer: PGLvoid);
  TglDrawElementArrayATI = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei);
  TglDrawRangeElementArrayATI = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei);

  (* GL_ATI_envmap_bumpmap *)
  TglTexBumpParameterivATI = PROCEDURE {WINAPI} (pname: GLenum;  param: PGLint);
  TglTexBumpParameterfvATI = PROCEDURE {WINAPI} (pname: GLenum;  param: PGLfloat);
  TglGetTexBumpParameterivATI = PROCEDURE {WINAPI} (pname: GLenum; param: PGLint);
  TglGetTexBumpParameterfvATI = PROCEDURE {WINAPI} (pname: GLenum; param: PGLfloat);

  (* GL_ATI_fragment_shader *)
  TglGenFragmentShadersATI = PROCEDURE {WINAPI} (range: GLuint): GLuint;
  TglBindFragmentShaderATI = PROCEDURE {WINAPI} (id: GLuint);
  TglDeleteFragmentShaderATI = PROCEDURE {WINAPI} (id: GLuint);
  TglBeginFragmentShaderATI = PROCEDURE {WINAPI} ();
  TglEndFragmentShaderATI = PROCEDURE {WINAPI} ();
  TglPassTexCoordATI = PROCEDURE {WINAPI} (dst: GLuint; coord: GLuint; swizzle: GLenum);
  TglSampleMapATI = PROCEDURE {WINAPI} (dst: GLuint; interp: GLuint; swizzle: GLenum);
  TglColorFragmentOp1ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint);
  TglColorFragmentOp2ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint);
  TglColorFragmentOp3ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint);
  TglAlphaFragmentOp1ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint);
  TglAlphaFragmentOp2ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint);
  TglAlphaFragmentOp3ATI = PROCEDURE {WINAPI} (op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint);
  TglSetFragmentShaderConstantATI = PROCEDURE {WINAPI} (dst: GLuint;  value: PGLfloat);

  (* GL_ATI_map_object_buffer *)
  TglMapObjectBufferATI = PROCEDURE {WINAPI} (buffer: GLuint): PGLvoid;
  TglUnmapObjectBufferATI = PROCEDURE {WINAPI} (buffer: GLuint);

  (* GL_ATI_pn_triangles *)
  TglPNTrianglesiATI = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglPNTrianglesfATI = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);

  (* GL_ATI_separate_stencil *)
  TglStencilOpSeparateATI = PROCEDURE {WINAPI} (face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum);
  TglStencilFuncSeparateATI = PROCEDURE {WINAPI} (frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint);

  (* GL_ATI_vertex_array_object *)
  TglNewObjectBufferATI = PROCEDURE {WINAPI} (size: GLsizei;  xpointer: PGLvoid; usage: GLenum): GLuint;
  TglIsObjectBufferATI = PROCEDURE {WINAPI} (buffer: GLuint): GLboolean;
  TglUpdateObjectBufferATI = PROCEDURE {WINAPI} (buffer: GLuint; offset: GLuint; size: GLsizei;  xpointer: PGLvoid; preserve: GLenum);
  TglGetObjectBufferfvATI = PROCEDURE {WINAPI} (buffer: GLuint; pname: GLenum; params: PGLfloat);
  TglGetObjectBufferivATI = PROCEDURE {WINAPI} (buffer: GLuint; pname: GLenum; params: PGLint);
  TglFreeObjectBufferATI = PROCEDURE {WINAPI} (buffer: GLuint);
  TglArrayObjectATI = PROCEDURE {WINAPI} (xarray: GLenum; size: GLint; xtype: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetArrayObjectfvATI = PROCEDURE {WINAPI} (xarray: GLenum; pname: GLenum; params: PGLfloat);
  TglGetArrayObjectivATI = PROCEDURE {WINAPI} (xarray: GLenum; pname: GLenum; params: PGLint);
  TglVariantArrayObjectATI = PROCEDURE {WINAPI} (id: GLuint; xtype: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetVariantArrayObjectfvATI = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVariantArrayObjectivATI = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint);

  (* GL_ATI_vertex_attrib_array_object *)
  TglVertexAttribArrayObjectATI = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetVertexAttribArrayObjectfvATI = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribArrayObjectivATI = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint);

  (* GL_ATI_vertex_streams *)
  TglVertexStream1sATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLshort);
  TglVertexStream1svATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLshort);
  TglVertexStream1iATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLint);
  TglVertexStream1ivATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLint);
  TglVertexStream1fATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLfloat);
  TglVertexStream1fvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLfloat);
  TglVertexStream1dATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLdouble);
  TglVertexStream1dvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLdouble);
  TglVertexStream2sATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLshort; y: GLshort);
  TglVertexStream2svATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLshort);
  TglVertexStream2iATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLint; y: GLint);
  TglVertexStream2ivATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLint);
  TglVertexStream2fATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLfloat; y: GLfloat);
  TglVertexStream2fvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLfloat);
  TglVertexStream2dATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLdouble; y: GLdouble);
  TglVertexStream2dvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLdouble);
  TglVertexStream3sATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLshort; y: GLshort; z: GLshort);
  TglVertexStream3svATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLshort);
  TglVertexStream3iATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLint; y: GLint; z: GLint);
  TglVertexStream3ivATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLint);
  TglVertexStream3fATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexStream3fvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLfloat);
  TglVertexStream3dATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexStream3dvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLdouble);
  TglVertexStream4sATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexStream4svATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLshort);
  TglVertexStream4iATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexStream4ivATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLint);
  TglVertexStream4fATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexStream4fvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLfloat);
  TglVertexStream4dATI = PROCEDURE {WINAPI} (stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexStream4dvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLdouble);
  TglNormalStream3bATI = PROCEDURE {WINAPI} (stream: GLenum; nx: GLbyte; ny: GLbyte; nz: GLbyte);
  TglNormalStream3bvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLbyte);
  TglNormalStream3sATI = PROCEDURE {WINAPI} (stream: GLenum; nx: GLshort; ny: GLshort; nz: GLshort);
  TglNormalStream3svATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLshort);
  TglNormalStream3iATI = PROCEDURE {WINAPI} (stream: GLenum; nx: GLint; ny: GLint; nz: GLint);
  TglNormalStream3ivATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLint);
  TglNormalStream3fATI = PROCEDURE {WINAPI} (stream: GLenum; nx: GLfloat; ny: GLfloat; nz: GLfloat);
  TglNormalStream3fvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLfloat);
  TglNormalStream3dATI = PROCEDURE {WINAPI} (stream: GLenum; nx: GLdouble; ny: GLdouble; nz: GLdouble);
  TglNormalStream3dvATI = PROCEDURE {WINAPI} (stream: GLenum;  coords: PGLdouble);
  TglClientActiveVertexStreamATI = PROCEDURE {WINAPI} (stream: GLenum);
  TglVertexBlendEnviATI = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglVertexBlendEnvfATI = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);

  (* GL_AMD_performance_monitor *)
  TglGetPerfMonitorGroupsAMD = PROCEDURE {WINAPI} (numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint);
  TglGetPerfMonitorCountersAMD = PROCEDURE {WINAPI} (group: GLuint; numCounters: PGLint; maxActiveCouters: PGLint; counterSize: GLsizei; counters: PGLuint);
  TglGetPerfMonitorGroupStringAMD = PROCEDURE {WINAPI} (group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar);
  TglGetPerfMonitorCounterStringAMD = PROCEDURE {WINAPI} (group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar);
  TglGetPerfMonitorCounterInfoAMD = PROCEDURE {WINAPI} (group: GLuint; counter: GLuint; pname: GLenum; data: Pointer);
  TglGenPerfMonitorsAMD = PROCEDURE {WINAPI} (n: GLsizei; monitors: PGLuint);
  TglDeletePerfMonitorsAMD = PROCEDURE {WINAPI} (n: GLsizei; monitors: PGLuint);
  TglSelectPerfMonitorCountersAMD = PROCEDURE {WINAPI} (monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; counterList: PGLuint);
  TglBeginPerfMonitorAMD = PROCEDURE {WINAPI} (monitor: GLuint);
  TglEndPerfMonitorAMD = PROCEDURE {WINAPI} (monitor: GLuint);
  TglGetPerfMonitorCounterDataAMD = PROCEDURE {WINAPI} (monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint);

  (* GL_AMD_vertex_shader_tesselator *)
  TglTessellationFactorAMD = PROCEDURE {WINAPI} (factor: GLfloat);
  TglTessellationModeAMD = PROCEDURE {WINAPI} (mode: GLenum);

  (* GL_AMD_draw_buffers_blend *)
  TglBlendFuncIndexedAMD = PROCEDURE {WINAPI} (buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparateIndexedAMD = PROCEDURE {WINAPI} (buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);
  TglBlendEquationIndexedAMD = PROCEDURE {WINAPI} (buf: GLuint; mode: GLenum);
  TglBlendEquationSeparateIndexedAMD = PROCEDURE {WINAPI} (buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);

  (* GL_AMD_name_gen_delete *)
  TglGenNamesAMD = PROCEDURE {WINAPI} (identifier: GLenum; num: GLuint; names: PGLuint);
  TglDeleteNamesAMD = PROCEDURE {WINAPI} (identifier: GLenum; num: GLuint;  names: PGLuint);
  TglIsNameAMD = PROCEDURE {WINAPI} (identifier: GLenum; name: GLuint): GLboolean;

  (* GL_AMD_debug_output *)
  TglDebugMessageEnableAMD = PROCEDURE {WINAPI} (category: GLenum; severity: GLenum; count: GLsizei;  ids: PGLuint; enabled: GLboolean);
  TglDebugMessageInsertAMD = PROCEDURE {WINAPI} (category: GLenum; severity: GLenum; id: GLuint; length: GLsizei;  buf: PGLchar);
 (* TglDebugMessageCallbackAMD = PROCEDURE {WINAPI} (callback: TGLDebugProcAMD; userParam: PGLvoid);  *)
  TglGetDebugMessageLogAMD = PROCEDURE {WINAPI} (count: GLuint; bufsize: GLsizei; categories: PGLenum; severities: PGLuint; ids: PGLuint; lengths: PGLsizei; message: PGLchar): GLuint;

  (* GL_EXT_blend_color *)
  TglBlendColorEXT = PROCEDURE {WINAPI} (red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);

  (* GL_EXT_blend_func_separate *)
  TglBlendFuncSeparateEXT = PROCEDURE {WINAPI} (sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);

  (* GL_EXT_blend_minmax *)
  TglBlendEquationEXT = PROCEDURE {WINAPI} (mode: GLenum);

  (* GL_EXT_color_subtable *)
  TglColorSubTableEXT = PROCEDURE {WINAPI} (target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; xtype: GLenum;  data: PGLvoid);
  TglCopyColorSubTableEXT = PROCEDURE {WINAPI} (target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);

  (* GL_EXT_compiled_vertex_array *)
  TglLockArraysEXT = PROCEDURE {WINAPI} (first: GLint; count: GLsizei);
  TglUnlockArraysEXT = PROCEDURE {WINAPI} ();

  (* GL_EXT_convolution *)
  TglConvolutionFilter1DEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglConvolutionFilter2DEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionParameterfEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: GLfloat);
  TglConvolutionParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglConvolutionParameteriEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: GLint);
  TglConvolutionParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyConvolutionFilter1DEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglCopyConvolutionFilter2DEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetConvolutionFilterEXT = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglGetConvolutionParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetConvolutionParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetSeparableFilterEXT = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);
  TglSeparableFilter2DEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  row: PGLvoid;  column: PGLvoid);

  (* GL_EXT_coordinate_frame *)
  TglTangent3bEXT = PROCEDURE {WINAPI} (tx: GLbyte; ty: GLbyte; tz: GLbyte);
  TglTangent3bvEXT = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglTangent3dEXT = PROCEDURE {WINAPI} (tx: GLdouble; ty: GLdouble; tz: GLdouble);
  TglTangent3dvEXT = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglTangent3fEXT = PROCEDURE {WINAPI} (tx: GLfloat; ty: GLfloat; tz: GLfloat);
  TglTangent3fvEXT = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglTangent3iEXT = PROCEDURE {WINAPI} (tx: GLint; ty: GLint; tz: GLint);
  TglTangent3ivEXT = PROCEDURE {WINAPI} ( v: PGLint);
  TglTangent3sEXT = PROCEDURE {WINAPI} (tx: GLshort; ty: GLshort; tz: GLshort);
  TglTangent3svEXT = PROCEDURE {WINAPI} ( v: PGLshort);
  TglBinormal3bEXT = PROCEDURE {WINAPI} (bx: GLbyte; by: GLbyte; bz: GLbyte);
  TglBinormal3bvEXT = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglBinormal3dEXT = PROCEDURE {WINAPI} (bx: GLdouble; by: GLdouble; bz: GLdouble);
  TglBinormal3dvEXT = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglBinormal3fEXT = PROCEDURE {WINAPI} (bx: GLfloat; by: GLfloat; bz: GLfloat);
  TglBinormal3fvEXT = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglBinormal3iEXT = PROCEDURE {WINAPI} (bx: GLint; by: GLint; bz: GLint);
  TglBinormal3ivEXT = PROCEDURE {WINAPI} ( v: PGLint);
  TglBinormal3sEXT = PROCEDURE {WINAPI} (bx: GLshort; by: GLshort; bz: GLshort);
  TglBinormal3svEXT = PROCEDURE {WINAPI} ( v: PGLshort);
  TglTangentPointerEXT = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglBinormalPointerEXT = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_copy_texture *)
  TglCopyTexImage1DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTexImage2DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTexSubImage1DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTexSubImage2DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglCopyTexSubImage3DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);

  (* GL_EXT_cull_vertex *)
  TglCullParameterdvEXT = PROCEDURE {WINAPI} (pname: GLenum; params: PGLdouble);
  TglCullParameterfvEXT = PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);

  (* GL_EXT_draw_range_elements *)
  TglDrawRangeElementsEXT = PROCEDURE {WINAPI} (mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; xtype: GLenum;  indices: PGLvoid);

  (* GL_EXT_fog_coord *)
  TglFogCoordfEXT = PROCEDURE {WINAPI} (coord: GLfloat);
  TglFogCoordfvEXT = PROCEDURE {WINAPI} ( coord: PGLfloat);
  TglFogCoorddEXT = PROCEDURE {WINAPI} (coord: GLdouble);
  TglFogCoorddvEXT = PROCEDURE {WINAPI} ( coord: PGLdouble);
  TglFogCoordPointerEXT = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_framebuffer_object *)
  TglIsRenderbufferEXT = PROCEDURE {WINAPI} (renderbuffer: GLuint): BOOLEAN;
  TglBindRenderbufferEXT = PROCEDURE {WINAPI} (target: GLenum; renderbuffer: GLuint);
  TglDeleteRenderbuffersEXT = PROCEDURE {WINAPI} (n: GLsizei;  renderbuffers: PGLuint);
  TglGenRenderbuffersEXT = PROCEDURE {WINAPI} (n: GLsizei; renderbuffers: PGLuint);
  TglRenderbufferStorageEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetRenderbufferParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglIsFramebufferEXT = PROCEDURE {WINAPI} (framebuffer: GLuint): BOOLEAN;
  TglBindFramebufferEXT = PROCEDURE {WINAPI} (target: GLenum; framebuffer: GLuint);
  TglDeleteFramebuffersEXT = PROCEDURE {WINAPI} (n: GLsizei;  framebuffers: PGLuint);
  TglGenFramebuffersEXT = PROCEDURE {WINAPI} (n: GLsizei; framebuffers: PGLuint);
  TglCheckFramebufferStatusEXT = PROCEDURE {WINAPI} (target: GLenum): GLenum;
  TglFramebufferTexture1DEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture2DEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture3DEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglFramebufferRenderbufferEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetFramebufferAttachmentParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateMipmapEXT = PROCEDURE {WINAPI} (target: GLenum);

  (* GL_EXT_histogram *)
  TglGetHistogramEXT = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetHistogramParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetHistogramParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetMinmaxEXT = PROCEDURE {WINAPI} (target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetMinmaxParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMinmaxParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglHistogramEXT = PROCEDURE {WINAPI} (target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);
  TglMinmaxEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; sink: GLboolean);
  TglResetHistogramEXT = PROCEDURE {WINAPI} (target: GLenum);
  TglResetMinmaxEXT = PROCEDURE {WINAPI} (target: GLenum);

  (* GL_EXT_index_func *)
  TglIndexFuncEXT = PROCEDURE {WINAPI} (func: GLenum; ref: GLclampf);

  (* GL_EXT_index_material *)
  TglIndexMaterialEXT = PROCEDURE {WINAPI} (face: GLenum; mode: GLenum);

  (* GL_EXT_light_texture *)
  TglApplyTextureEXT = PROCEDURE {WINAPI} (mode: GLenum);
  TglTextureLightEXT = PROCEDURE {WINAPI} (pname: GLenum);
  TglTextureMaterialEXT = PROCEDURE {WINAPI} (face: GLenum; mode: GLenum);

  (* GL_EXT_multi_draw_arrays *)
  TglMultiDrawArraysEXT = PROCEDURE {WINAPI} (mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  TglMultiDrawElementsEXT = PROCEDURE {WINAPI} (mode: GLenum;  count: PGLsizei; xtype: GLenum;  indices: PGLvoid; primcount: GLsizei);

  (* GL_EXT_multisample *)
  TglSampleMaskEXT = PROCEDURE {WINAPI} (value: GLclampf; invert: GLboolean);
  TglSamplePatternEXT = PROCEDURE {WINAPI} (pattern: GLenum);

  (* GL_EXT_paletted_texture *)
  TglColorTableEXT = PROCEDURE {WINAPI} (target: GLenum; internalFormat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  table: PGLvoid);
  TglGetColorTableEXT = PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype: GLenum; data: PGLvoid);
  TglGetColorTableParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetColorTableParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_EXT_pixel_transform *)
  TglPixelTransformParameteriEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLint);
  TglPixelTransformParameterfEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLfloat);
  TglPixelTransformParameterivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglPixelTransformParameterfvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);

  (* GL_EXT_point_parameters *)
  TglPointParameterfEXT = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPointParameterfvEXT = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);

  (* GL_EXT_polygon_offset *)
  TglPolygonOffsetEXT = PROCEDURE {WINAPI} (factor: GLfloat; bias: GLfloat);

  (* GL_EXT_secondary_color *)
  TglSecondaryColor3bEXT = PROCEDURE {WINAPI} (red: GLbyte; green: GLbyte; blue: GLbyte);
  TglSecondaryColor3bvEXT = PROCEDURE {WINAPI} ( v: PGLbyte);
  TglSecondaryColor3dEXT = PROCEDURE {WINAPI} (red: GLdouble; green: GLdouble; blue: GLdouble);
  TglSecondaryColor3dvEXT = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglSecondaryColor3fEXT = PROCEDURE {WINAPI} (red: GLfloat; green: GLfloat; blue: GLfloat);
  TglSecondaryColor3fvEXT = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglSecondaryColor3iEXT = PROCEDURE {WINAPI} (red: GLint; green: GLint; blue: GLint);
  TglSecondaryColor3ivEXT = PROCEDURE {WINAPI} ( v: PGLint);
  TglSecondaryColor3sEXT = PROCEDURE {WINAPI} (red: GLshort; green: GLshort; blue: GLshort);
  TglSecondaryColor3svEXT = PROCEDURE {WINAPI} ( v: PGLshort);
  TglSecondaryColor3ubEXT = PROCEDURE {WINAPI} (red: GLubyte; green: GLubyte; blue: GLubyte);
  TglSecondaryColor3ubvEXT = PROCEDURE {WINAPI} ( v: PGLubyte);
  TglSecondaryColor3uiEXT = PROCEDURE {WINAPI} (red: GLuint; green: GLuint; blue: GLuint);
  TglSecondaryColor3uivEXT = PROCEDURE {WINAPI} ( v: PGLuint);
  TglSecondaryColor3usEXT = PROCEDURE {WINAPI} (red: GLushort; green: GLushort; blue: GLushort);
  TglSecondaryColor3usvEXT = PROCEDURE {WINAPI} ( v: PGLushort);
  TglSecondaryColorPointerEXT = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_stencil_two_side *)
  TglActiveStencilFaceEXT = PROCEDURE {WINAPI} (face: GLenum);

  (* GL_EXT_subtexture *)
  TglTexSubImage1DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage2DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);

  (* GL_EXT_texture3D *)
  TglTexImage3DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage3DEXT = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);

  (* GL_EXT_texture_object *)
  TglAreTexturesResidentEXT = PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint; residences: PGLboolean): GLboolean;
  TglBindTextureEXT = PROCEDURE {WINAPI} (target: GLenum; texture: GLuint);
  TglDeleteTexturesEXT = PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint);
  TglGenTexturesEXT = PROCEDURE {WINAPI} (n: GLsizei; textures: PGLuint);
  TglIsTextureEXT = PROCEDURE {WINAPI} (texture: GLuint): GLboolean;
  TglPrioritizeTexturesEXT = PROCEDURE {WINAPI} (n: GLsizei;  textures: PGLuint;  priorities: PGLclampf);

  (* GL_EXT_texture_perturb_normal *)
  TglTextureNormalEXT = PROCEDURE {WINAPI} (mode: GLenum);

  (* GL_EXT_vertex_array *)
  TglArrayElementEXT = PROCEDURE {WINAPI} (i: GLint);
  TglColorPointerEXT = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglDrawArraysEXT = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei);
  TglEdgeFlagPointerEXT = PROCEDURE {WINAPI} (stride: GLsizei; count: GLsizei;  xpointer: PGLboolean);
  TglGetPointervEXT = PROCEDURE {WINAPI} (pname: GLenum; params: PGLvoid);
  TglIndexPointerEXT = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglNormalPointerEXT = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglTexCoordPointerEXT = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglVertexPointerEXT = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_vertex_shader *)
  TglBeginVertexShaderEXT = PROCEDURE {WINAPI} ();
  TglEndVertexShaderEXT = PROCEDURE {WINAPI} ();
  TglBindVertexShaderEXT = PROCEDURE {WINAPI} (id: GLuint);
  TglGenVertexShadersEXT = PROCEDURE {WINAPI} (range: GLuint): GLuint;
  TglDeleteVertexShaderEXT = PROCEDURE {WINAPI} (id: GLuint);
  TglShaderOp1EXT = PROCEDURE {WINAPI} (op: GLenum; res: GLuint; arg1: GLuint);
  TglShaderOp2EXT = PROCEDURE {WINAPI} (op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint);
  TglShaderOp3EXT = PROCEDURE {WINAPI} (op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint; arg3: GLuint);
  TglSwizzleEXT = PROCEDURE {WINAPI} (res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum);
  TglWriteMaskEXT = PROCEDURE {WINAPI} (res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum);
  TglInsertComponentEXT = PROCEDURE {WINAPI} (res: GLuint; src: GLuint; num: GLuint);
  TglExtractComponentEXT = PROCEDURE {WINAPI} (res: GLuint; src: GLuint; num: GLuint);
  TglGenSymbolsEXT = PROCEDURE {WINAPI} (datatype: GLenum; storagetype: GLenum; range: GLenum; components: GLuint): GLuint;
  TglSetInvariantEXT = PROCEDURE {WINAPI} (id: GLuint; xtype: GLenum;  addr: PGLvoid);
  TglSetLocalConstantEXT = PROCEDURE {WINAPI} (id: GLuint; xtype: GLenum;  addr: PGLvoid);
  TglVariantbvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLbyte);
  TglVariantsvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLshort);
  TglVariantivEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLint);
  TglVariantfvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLfloat);
  TglVariantdvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLdouble);
  TglVariantubvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLubyte);
  TglVariantusvEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLushort);
  TglVariantuivEXT = PROCEDURE {WINAPI} (id: GLuint;  addr: PGLuint);
  TglVariantPointerEXT = PROCEDURE {WINAPI} (id: GLuint; xtype: GLenum; stride: GLuint;  addr: PGLvoid);
  TglEnableVariantClientStateEXT = PROCEDURE {WINAPI} (id: GLuint);
  TglDisableVariantClientStateEXT = PROCEDURE {WINAPI} (id: GLuint);
  TglBindLightParameterEXT = PROCEDURE {WINAPI} (light: GLenum; value: GLenum): GLuint;
  TglBindMaterialParameterEXT = PROCEDURE {WINAPI} (face: GLenum; value: GLenum): GLuint;
  TglBindTexGenParameterEXT = PROCEDURE {WINAPI} (xunit: GLenum; coord: GLenum; value: GLenum): GLuint;
  TglBindTextureUnitParameterEXT = PROCEDURE {WINAPI} ( xunit: GLenum; value: GLenum): GLuint;
  TglBindParameterEXT = PROCEDURE {WINAPI} (value: GLenum): GLuint;
  TglIsVariantEnabledEXT = PROCEDURE {WINAPI} (id: GLuint; cap: GLenum): GLboolean;
  TglGetVariantBooleanvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLboolean);
  TglGetVariantIntegervEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLint);
  TglGetVariantFloatvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLfloat);
  TglGetVariantPointervEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLvoid);
  TglGetInvariantBooleanvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLboolean);
  TglGetInvariantIntegervEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLint);
  TglGetInvariantFloatvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLfloat);
  TglGetLocalConstantBooleanvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLboolean);
  TglGetLocalConstantIntegervEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLint);
  TglGetLocalConstantFloatvEXT = PROCEDURE {WINAPI} (id: GLuint; value: GLenum; data: PGLfloat);

  (* GL_EXT_vertex_weighting *)
  TglVertexWeightfEXT = PROCEDURE {WINAPI} (weight: GLfloat);
  TglVertexWeightfvEXT = PROCEDURE {WINAPI} ( weight: PGLfloat);
  TglVertexWeightPointerEXT = PROCEDURE {WINAPI} (size: GLsizei; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_stencil_clear_tag *)
  TglStencilClearTagEXT = PROCEDURE {WINAPI} (stencilTagBits: GLsizei; stencilClearTag: GLuint);

  (* GL_EXT_framebuffer_blit *)
  TglBlitFramebufferEXT = PROCEDURE {WINAPI} (srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum);

  (* GL_EXT_framebuffer_multisample *)
  TglRenderbufferStorageMultisampleEXT = PROCEDURE {WINAPI} (target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);

  (* GL_EXT_timer_query *)
  TglGetQueryObjecti64vEXT = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetQueryObjectui64vEXT = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLuint64EXT);

  (* GL_EXT_gpu_program_parameters *)
  TglProgramEnvParameters4fvEXT = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLfloat);
  TglProgramLocalParameters4fvEXT = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLfloat);

  (* GL_EXT_bindable_uniform *)
  TglUniformBufferEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; buffer: GLuint);
  TglGetUniformBufferSizeEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint): GLint;
  TglGetUniformOffsetEXT = PROCEDURE {WINAPI} ( xprogram: GLuint; location: GLint): PGLint;

  (* GL_EXT_draw_buffers2 *)
  TglColorMaskIndexedEXT = PROCEDURE {WINAPI} (buf: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean);
  TglGetBooleanIndexedvEXT = PROCEDURE {WINAPI} (value: GLenum; index: GLuint; data: PGLboolean);
  TglGetIntegerIndexedvEXT = PROCEDURE {WINAPI} (value: GLenum; index: GLuint; data: PGLint);
  TglEnableIndexedEXT = PROCEDURE {WINAPI} (target: GLenum; index: GLuint);
  TglDisableIndexedEXT = PROCEDURE {WINAPI} (target: GLenum; index: GLuint);
  TglIsEnabledIndexedEXT = PROCEDURE {WINAPI} (target: GLenum; index: GLuint): GLboolean;

  (* GL_EXT_draw_instanced *)
  TglDrawArraysInstancedEXT = PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstancedEXT = PROCEDURE {WINAPI} (mode: GLenum; count: GLsizei; xtype: GLenum;  indices: Pointer; primcount: GLsizei);

  (* GL_EXT_geometry_shader4 *)
  TglProgramParameteriEXT = PROCEDURE {WINAPI} (xprogram: GLuint; pname: GLenum; value: GLint);
  TglFramebufferTextureEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
(*  TglFramebufferTextureLayerEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);  *)
  TglFramebufferTextureFaceEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);

  (* GL_EXT_gpu_shader4 *)
  TglVertexAttribI1iEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLint);
  TglVertexAttribI2iEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLint; y: GLint);
  TglVertexAttribI3iEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLint; y: GLint; z: GLint);
  TglVertexAttribI4iEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexAttribI1uiEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLuint);
  TglVertexAttribI2uiEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLuint; y: GLuint);
  TglVertexAttribI3uiEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLuint; y: GLuint; z: GLuint);
  TglVertexAttribI4uiEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglVertexAttribI1ivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttribI2ivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttribI3ivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttribI4ivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint);
  TglVertexAttribI1uivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttribI2uivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttribI3uivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttribI4uivEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint);
  TglVertexAttribI4bvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLbyte);
  TglVertexAttribI4svEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttribI4ubvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttribI4usvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLushort);
  TglVertexAttribIPointerEXT = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: Pointer);
  TglGetVertexAttribIivEXT = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribIuivEXT = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLuint);
  TglUniform1uiEXT = PROCEDURE {WINAPI} (location: GLint; v0: GLuint);
  TglUniform2uiEXT = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint);
  TglUniform3uiEXT = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglUniform4uiEXT = PROCEDURE {WINAPI} (location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglUniform1uivEXT = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform2uivEXT = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform3uivEXT = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform4uivEXT = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint);
  TglGetUniformuivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; params: PGLuint);
  TglBindFragDataLocationEXT = PROCEDURE {WINAPI} (xprogram: GLuint; colorNumber: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataLocationEXT = PROCEDURE {WINAPI} (xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;

  (* GL_EXT_texture_array *)
  TglFramebufferTextureLayerEXT = PROCEDURE {WINAPI} (target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);

  (* GL_EXT_texture_buffer_object *)
  TglTexBufferEXT = PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; buffer: GLuint);

  (* GL_EXT_texture_integer *)
  TglClearColorIiEXT = PROCEDURE {WINAPI} (r: GLint; g: GLint; b: GLint; a: GLint);
  TglClearColorIuiEXT = PROCEDURE {WINAPI} (r: GLuint; g: GLuint; b: GLuint; a: GLuint);
  TglTexParameterIivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglTexParameterIuivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLuint);
  TglGetTexParameterIivEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterIiuvEXT = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLuint);

  (* GL_HP_image_transform *)
  TglImageTransformParameteriHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLint);
  TglImageTransformParameterfHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; param: GLfloat);
  TglImageTransformParameterivHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglImageTransformParameterfvHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetImageTransformParameterivHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetImageTransformParameterfvHP = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_EXT_depth_bounds_test *)
  TglDepthBoundsEXT = PROCEDURE {WINAPI} (zmin: GLclampd; zmax: GLclampd);

  (* GL_EXT_blend_equation_separate *)
  TglBlendEquationSeparateEXT = PROCEDURE {WINAPI} (modeRGB: GLenum; modeAlpha: GLenum);

  (* GL_EXT_transform_feedback *)
  TglBeginTransformFeedbackEXT = PROCEDURE {WINAPI} (primitiveMode: GLenum);
  TglEndTransformFeedbackEXT = PROCEDURE {WINAPI} ();
  TglBindBufferRangeEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei);
  TglBindBufferOffsetEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei);
  TglBindBufferBaseEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryingsEXT = PROCEDURE {WINAPI} (xprogram: GLuint; count: GLsizei;  locations: PGLint; bufferMode: GLenum);
  TglGetTransformFeedbackVaryingEXT = PROCEDURE {WINAPI} (xprogram: GLuint; index_: GLuint; location: PGLint);

  (* GL_EXT_direct_state_access *)
  TglClientAttribDefaultEXT = PROCEDURE {WINAPI} (mask: GLbitfield);
  TglPushClientAttribDefaultEXT = PROCEDURE {WINAPI} (mask: GLbitfield);
  TglMatrixLoadfEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLfloat);
  TglMatrixLoaddEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLdouble);
  TglMatrixMultfEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLfloat);
  TglMatrixMultdEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLdouble);
  TglMatrixLoadIdentityEXT = PROCEDURE {WINAPI} (mode: GLenum);
  TglMatrixRotatefEXT = PROCEDURE {WINAPI} (mode: GLenum; angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixRotatedEXT = PROCEDURE {WINAPI} (mode: GLenum; angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixScalefEXT = PROCEDURE {WINAPI} (mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixScaledEXT = PROCEDURE {WINAPI} (mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixTranslatefEXT = PROCEDURE {WINAPI} (mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixTranslatedEXT = PROCEDURE {WINAPI} (mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixFrustumEXT = PROCEDURE {WINAPI} (mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglMatrixOrthoEXT = PROCEDURE {WINAPI} (mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglMatrixPopEXT = PROCEDURE {WINAPI} (mode: GLenum);
  TglMatrixPushEXT = PROCEDURE {WINAPI} (mode: GLenum);
  TglMatrixLoadTransposefEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLfloat);
  TglMatrixLoadTransposedEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLdouble);
  TglMatrixMultTransposefEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLfloat);
  TglMatrixMultTransposedEXT = PROCEDURE {WINAPI} (mode: GLenum;  m: PGLdouble);
  TglTextureParameterfEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; param: GLfloat);
  TglTextureParameterfvEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTextureParameteriEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; param: GLint);
  TglTextureParameterivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglTextureImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyTextureImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTextureImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTextureSubImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTextureSubImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetTextureImageEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);
  TglGetTextureParameterfvEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTextureParameterivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetTextureLevelParameterfvEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetTextureLevelParameterivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: GLint);
  TglTextureImage3DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage3DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyTextureSubImage3DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglMultiTexParameterfEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexParameterfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexParameteriEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexParameterivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyMultiTexImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyMultiTexImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyMultiTexSubImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyMultiTexSubImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetMultiTexImageEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);
  TglGetMultiTexParameterfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexParameterivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexLevelParameterfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetMultiTexLevelParameterivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLint);
  TglMultiTexImage3DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage3DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum;  pixels:PGLvoid);
  TglCopyMultiTexSubImage3DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglBindMultiTextureEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; texture: GLuint);
  TglEnableClientStateIndexedEXT = PROCEDURE {WINAPI} (array_: GLenum; index_: GLuint);
  TglDisableClientStateIndexedEXT = PROCEDURE {WINAPI} (array_: GLenum; index_: GLuint);
  TglMultiTexCoordPointerEXT = PROCEDURE {WINAPI} (texunit: GLenum; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglMultiTexEnvfEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexEnvfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexEnviEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexEnvivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexGendEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLdouble);
  TglMultiTexGendvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLdouble);
  TglMultiTexGenfEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexGenfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexGeniEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexGenivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglGetMultiTexEnvfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexEnvivEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexGendvEXT = PROCEDURE {WINAPI} (texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLdouble);
  TglGetMultiTexGenfvEXT = PROCEDURE {WINAPI} (texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexGenivEXT = PROCEDURE {WINAPI} (texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLint);
  TglGetFloatIndexedvEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PGLfloat);
  TglGetDoubleIndexedvEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PGLdouble);
  TglGetPointerIndexedvEXT = PROCEDURE {WINAPI} (target: GLenum; index_: GLuint; data: PPGLvoid);
  TglCompressedTextureImage3DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage3DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage2DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage1DEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglGetCompressedTextureImageEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; lod: GLint; img: PGLvoid);
  TglCompressedMultiTexImage3DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage3DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage2DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage1DEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglGetCompressedMultiTexImageEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; lod: GLint; img: PGLvoid);
  TglNamedProgramStringEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; format: GLenum; len: GLsizei;  string_: PGLvoid);
  TglNamedProgramLocalParameter4dEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglNamedProgramLocalParameter4dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLdouble);
  TglNamedProgramLocalParameter4fEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglNamedProgramLocalParameter4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLfloat);
  TglGetNamedProgramLocalParameterdvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLdouble);
  TglGetNamedProgramLocalParameterfvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLfloat);
  TglGetNamedProgramivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetNamedProgramStringEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; pname: GLenum; string_: PGLvoid);
  TglNamedProgramLocalParameters4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLfloat);
  TglNamedProgramLocalParameterI4iEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglNamedProgramLocalParameterI4ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLint);
  TglNamedProgramLocalParametersI4ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLint);
  TglNamedProgramLocalParameterI4uiEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglNamedProgramLocalParameterI4uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLuint);
  TglNamedProgramLocalParametersI4uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLuint);
  TglGetNamedProgramLocalParameterIivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLint);
  TglGetNamedProgramLocalParameterIuivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLuint);
  TglTextureParameterIivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglTextureParameterIuivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetTextureParameterIivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetTextureParameterIuivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);
  TglMultiTexParameterIivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexParameterIuivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetMultiTexParameterIivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexParameterIuivEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);
  TglProgramUniform1fEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat);
  TglProgramUniform2fEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);
  TglProgramUniform3fEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);
  TglProgramUniform4fEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);
  TglProgramUniform1iEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint);
  TglProgramUniform2iEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint);
  TglProgramUniform3iEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);
  TglProgramUniform4iEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);
  TglProgramUniform1fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform2fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform3fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform1ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform2ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform3ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform4ivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniformMatrix2fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x3fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x2fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x2fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x4fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x3fvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniform1uiEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint);
  TglProgramUniform2uiEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint);
  TglProgramUniform3uiEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglProgramUniform4uiEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglProgramUniform1uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform2uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform3uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform4uivEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglNamedBufferDataEXT = PROCEDURE {WINAPI} (buffer: GLuint; size: GLsizei;  data: PGLvoid; usage: GLenum);
  TglNamedBufferSubDataEXT = PROCEDURE {WINAPI} (buffer: GLuint; offset: GLintptr; size: GLsizeiptr;  data: PGLvoid);
  TglMapNamedBufferEXT = PROCEDURE {WINAPI} (buffer: GLuint; access: GLenum): PGLvoid;
  TglUnmapNamedBufferEXT = PROCEDURE {WINAPI} (buffer: GLuint): GLboolean;
  TglMapNamedBufferRangeEXT = PROCEDURE {WINAPI} (buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): PGLvoid;
  TglFlushMappedNamedBufferRangeEXT = PROCEDURE {WINAPI} (buffer: GLuint; offset: GLintptr; length: GLsizeiptr);
  TglNamedCopyBufferSubDataEXT = PROCEDURE {WINAPI} (readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr);
  TglGetNamedBufferParameterivEXT = PROCEDURE {WINAPI} (buffer: GLuint; pname: GLenum; params: PGLint);
  TglGetNamedBufferPointervEXT = PROCEDURE {WINAPI} (buffer: GLuint; pname: GLenum; params: PPGLvoid);
  TglGetNamedBufferSubDataEXT = PROCEDURE {WINAPI} (buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: PGLvoid);
  TglTextureBufferEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint);
  TglMultiTexBufferEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; interformat: GLenum; buffer: GLuint);
  TglNamedRenderbufferStorageEXT = PROCEDURE {WINAPI} (renderbuffer: GLuint; interformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetNamedRenderbufferParameterivEXT = PROCEDURE {WINAPI} (renderbuffer: GLuint; pname: GLenum; params: PGLint);
  TglCheckNamedFramebufferStatusEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; target: GLenum): GLenum;
  TglNamedFramebufferTexture1DEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTexture2DEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTexture3DEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglNamedFramebufferRenderbufferEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetNamedFramebufferAttachmentParameterivEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateTextureMipmapEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum);
  TglGenerateMultiTexMipmapEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum);
  TglFramebufferDrawBufferEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; mode: GLenum);
  TglFramebufferDrawBuffersEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; n: GLsizei;  bufs: PGLenum);
  TglFramebufferReadBufferEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; mode: GLenum);
  TglGetFramebufferParameterivEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; pname: GLenum; params: PGLint);
  TglNamedRenderbufferStorageMultisampleEXT = PROCEDURE {WINAPI} (renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglNamedRenderbufferStorageMultisampleCoverageEXT = PROCEDURE {WINAPI} (renderbuffer: GLuint; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglNamedFramebufferTextureEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTextureLayerEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);
  TglNamedFramebufferTextureFaceEXT = PROCEDURE {WINAPI} (framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);
  TglTextureRenderbufferEXT = PROCEDURE {WINAPI} (texture: GLuint; target: GLenum; renderbuffer: GLuint);
  TglMultiTexRenderbufferEXT = PROCEDURE {WINAPI} (texunit: GLenum; target: GLenum; renderbuffer: GLuint);
  TglProgramUniform1dEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLdouble);
  TglProgramUniform2dEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble);
  TglProgramUniform3dEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglProgramUniform4dEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramUniform1dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform2dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform3dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform4dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniformMatrix2dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x3dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x4dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x2dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x4dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x2dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x3dvEXT = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);

  (* GL_EXT_separate_shader_objects *)
  TglUseShaderProgramEXT = PROCEDURE {WINAPI} (xtype: GLenum; xprogram: GLuint);
  TglActiveProgramEXT = PROCEDURE {WINAPI} (xprogram: GLuint);
  TglCreateShaderProgramEXT = PROCEDURE {WINAPI} (xtype: GLenum; CONST xstring: ARRAY OF CHAR): GLuint;

   (* GL_EXT_shader_image_load_store *)
  TglBindImageTextureEXT = PROCEDURE {WINAPI} (index: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLint);
  TglMemoryBarrierEXT = PROCEDURE {WINAPI} (barriers: GLbitfield);

  (* GL_EXT_vertex_attrib_64bit *)
  TglVertexAttribL1dEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble);
  TglVertexAttribL2dEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttribL3dEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttribL4dEXT = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttribL1dvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL2dvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL3dvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribL4dvEXT = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttribLPointerEXT = PROCEDURE {WINAPI} (index: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribLdvEXT = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLdouble);
  TglVertexArrayVertexAttribLOffsetEXT = PROCEDURE {WINAPI} (vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; offset: GLintptr);

(***************************)
  (*  GL_IBM_multimode_draw_arrays *)
  TglMultiModeDrawArraysIBM = PROCEDURE {WINAPI} (mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei; modestride: GLint);
  TglMultiModeDrawElementsIBM = PROCEDURE {WINAPI} (mode: PGLenum; count: PGLsizei; xtype:  GLenum; indices: PGLvoid; primcount: GLsizei; modestride: GLint);

  (*  GL_IBM_vertex_array_lists *)
  TglColorPointerListIBM = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglSecondaryColorPointerListIBM = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglEdgeFlagPointerListIBM = PROCEDURE {WINAPI} (stride: GLint; xpointer: PGLboolean; ptrstride: GLint);
  TglFogCoordPointerListIBM = PROCEDURE {WINAPI} (xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglIndexPointerListIBM = PROCEDURE {WINAPI} (xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglNormalPointerListIBM = PROCEDURE {WINAPI} (xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglTexCoordPointerListIBM = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglVertexPointerListIBM = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);

  (*  GL_INGR_blend_func_separate *)
  TglBlendFuncSeparateINGR = PROCEDURE {WINAPI} (sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);

  (*  GL_INTEL_parallel_arrays *)
  TglVertexPointervINTEL = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; xpointer: PGLvoid);
  TglNormalPointervINTEL = PROCEDURE {WINAPI} (xtype:  GLenum; xpointer: PGLvoid);
  TglColorPointervINTEL = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; xpointer: PGLvoid);
  TglTexCoordPointervINTEL = PROCEDURE {WINAPI} (size: GLint; xtype:  GLenum; xpointer: PGLvoid);


(***************************)
  (*  GL_MESA_resize_buffers *)
  TglResizeBuffersMESA = PROCEDURE {WINAPI} ();

  (* GL_MESA_window_pos *)
  TglWindowPos2dMESA = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble);
  TglWindowPos2dvMESA = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos2fMESA = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat);
  TglWindowPos2fvMESA = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos2iMESA = PROCEDURE {WINAPI} (x: GLint; y: GLint);
  TglWindowPos2ivMESA = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos2sMESA = PROCEDURE {WINAPI} (x: GLshort; y: GLshort);
  TglWindowPos2svMESA = PROCEDURE {WINAPI} ( v: PGLshort);
  TglWindowPos3dMESA = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dvMESA = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos3fMESA = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fvMESA = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos3iMESA = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint);
  TglWindowPos3ivMESA = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos3sMESA = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3svMESA = PROCEDURE {WINAPI} ( v: PGLshort);
  TglWindowPos4dMESA = PROCEDURE {WINAPI} (x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglWindowPos4dvMESA = PROCEDURE {WINAPI} ( v: PGLdouble);
  TglWindowPos4fMESA = PROCEDURE {WINAPI} (x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglWindowPos4fvMESA = PROCEDURE {WINAPI} ( v: PGLfloat);
  TglWindowPos4iMESA = PROCEDURE {WINAPI} (x: GLint; y: GLint; z: GLint; w: GLint);
  TglWindowPos4ivMESA = PROCEDURE {WINAPI} ( v: PGLint);
  TglWindowPos4sMESA = PROCEDURE {WINAPI} (x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglWindowPos4svMESA = PROCEDURE {WINAPI} ( v: PGLshort);

  (* GL_NV_evaluators *)
  TglMapControlPointsNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; xtype: GLenum; ustride: GLsizei; vstride: GLsizei; uorder: GLint; vorder: GLint; _packed: GLboolean;  points: PGLvoid);
  TglMapParameterivNV = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLint);
  TglMapParameterfvNV = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetMapControlPointsNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; xtype: GLenum; ustride: GLsizei; vstride: GLsizei; _packed: GLboolean; points: PGLvoid);
  TglGetMapParameterivNV = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglGetMapParameterfvNV = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMapAttribParameterivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; pname: GLenum; params: PGLint);
  TglGetMapAttribParameterfvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat);
  TglEvalMapsNV = PROCEDURE {WINAPI} (target: GLenum; mode: GLenum);

  (* GL_NV_fence *)
  TglDeleteFencesNV = PROCEDURE {WINAPI} (n: GLsizei;  fences: PGLuint);
  TglGenFencesNV = PROCEDURE {WINAPI} (n: GLsizei; fences: PGLuint);
  TglIsFenceNV = PROCEDURE {WINAPI} (fence: GLuint): GLboolean;
  TglTestFenceNV = PROCEDURE {WINAPI} (fence: GLuint): GLboolean;
  TglGetFenceivNV = PROCEDURE {WINAPI} (fence: GLuint; pname: GLenum; params: PGLint);
  TglFinishFenceNV = PROCEDURE {WINAPI} (fence: GLuint);
  TglSetFenceNV = PROCEDURE {WINAPI} (fence: GLuint; condition: GLenum);

  (* GL_NV_fragment_program *)
  TglProgramNamedParameter4fNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramNamedParameter4dNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramNamedParameter4fvNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR;  v: PGLfloat);
  TglProgramNamedParameter4dvNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR;  v: PGLdouble);
  TglGetProgramNamedParameterfvNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; params: PGLfloat);
  TglGetProgramNamedParameterdvNV = PROCEDURE {WINAPI} (id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; params: PGLdouble);

  (* GL_NV_half_float *)
  TglVertex2hNV = PROCEDURE {WINAPI} (x: GLhalfNV; y: GLhalfNV);
  TglVertex2hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglVertex3hNV = PROCEDURE {WINAPI} (x: GLhalfNV; y: GLhalfNV; z: GLhalfNV);
  TglVertex3hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglVertex4hNV = PROCEDURE {WINAPI} (x: GLhalfNV; y: GLhalfNV; z: GLhalfNV; w: GLhalfNV);
  TglVertex4hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglNormal3hNV = PROCEDURE {WINAPI} (nx: GLhalfNV; ny: GLhalfNV; nz: GLhalfNV);
  TglNormal3hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglColor3hNV = PROCEDURE {WINAPI} (red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV);
  TglColor3hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglColor4hNV = PROCEDURE {WINAPI} (red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV; alpha: GLhalfNV);
  TglColor4hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglTexCoord1hNV = PROCEDURE {WINAPI} (s: GLhalfNV);
  TglTexCoord1hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglTexCoord2hNV = PROCEDURE {WINAPI} (s: GLhalfNV; t: GLhalfNV);
  TglTexCoord2hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglTexCoord3hNV = PROCEDURE {WINAPI} (s: GLhalfNV; t: GLhalfNV; r: GLhalfNV);
  TglTexCoord3hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglTexCoord4hNV = PROCEDURE {WINAPI} (s: GLhalfNV; t: GLhalfNV; r: GLhalfNV; q: GLhalfNV);
  TglTexCoord4hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglMultiTexCoord1hNV = PROCEDURE {WINAPI} (target: GLenum; s: GLhalfNV);
  TglMultiTexCoord1hvNV = PROCEDURE {WINAPI} (target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord2hNV = PROCEDURE {WINAPI} (target: GLenum; s: GLhalfNV; t: GLhalfNV);
  TglMultiTexCoord2hvNV = PROCEDURE {WINAPI} (target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord3hNV = PROCEDURE {WINAPI} (target: GLenum; s: GLhalfNV; t: GLhalfNV; r: GLhalfNV);
  TglMultiTexCoord3hvNV = PROCEDURE {WINAPI} (target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord4hNV = PROCEDURE {WINAPI} (target: GLenum; s: GLhalfNV; t: GLhalfNV; r: GLhalfNV; q: GLhalfNV);
  TglMultiTexCoord4hvNV = PROCEDURE {WINAPI} (target: GLenum;  v: PGLhalfNV);
  TglFogCoordhNV = PROCEDURE {WINAPI} (fog: GLhalfNV);
  TglFogCoordhvNV = PROCEDURE {WINAPI} ( fog: PGLhalfNV);
  TglSecondaryColor3hNV = PROCEDURE {WINAPI} (red: GLhalfNV; green: GLhalfNV; blue: GLhalfNV);
  TglSecondaryColor3hvNV = PROCEDURE {WINAPI} ( v: PGLhalfNV);
  TglVertexWeighthNV = PROCEDURE {WINAPI} (weight: GLhalfNV);
  TglVertexWeighthvNV = PROCEDURE {WINAPI} ( weight: PGLhalfNV);
  TglVertexAttrib1hNV = PROCEDURE {WINAPI} (index: GLuint; x: GLhalfNV);
  TglVertexAttrib1hvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib2hNV = PROCEDURE {WINAPI} (index: GLuint; x: GLhalfNV; y: GLhalfNV);
  TglVertexAttrib2hvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib3hNV = PROCEDURE {WINAPI} (index: GLuint; x: GLhalfNV; y: GLhalfNV; z: GLhalfNV);
  TglVertexAttrib3hvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib4hNV = PROCEDURE {WINAPI} (index: GLuint; x: GLhalfNV; y: GLhalfNV; z: GLhalfNV; w: GLhalfNV);
  TglVertexAttrib4hvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLhalfNV);
  TglVertexAttribs1hvNV = PROCEDURE {WINAPI} (index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs2hvNV = PROCEDURE {WINAPI} (index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs3hvNV = PROCEDURE {WINAPI} (index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs4hvNV = PROCEDURE {WINAPI} (index: GLuint; n: GLsizei;  v: PGLhalfNV);

  (* GL_NV_occlusion_query *)
  TglGenOcclusionQueriesNV = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglDeleteOcclusionQueriesNV = PROCEDURE {WINAPI} (n: GLsizei;  ids: PGLuint);
  TglIsOcclusionQueryNV = PROCEDURE {WINAPI} (id: GLuint): GLboolean;
  TglBeginOcclusionQueryNV = PROCEDURE {WINAPI} (id: GLuint);
  TglEndOcclusionQueryNV = PROCEDURE {WINAPI} ();
  TglGetOcclusionQueryivNV = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint);
  TglGetOcclusionQueryuivNV = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLuint);

  (* GL_NV_pixel_data_range *)
  TglPixelDataRangeNV = PROCEDURE {WINAPI} (target: GLenum; length: GLsizei; xpointer: PGLvoid);
  TglFlushPixelDataRangeNV = PROCEDURE {WINAPI} (target: GLenum);

  (* GL_NV_point_sprite *)
  TglPointParameteriNV = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglPointParameterivNV = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLint);

  (* GL_NV_primitive_restart *)
  TglPrimitiveRestartNV = PROCEDURE {WINAPI} ();
  TglPrimitiveRestartIndexNV = PROCEDURE {WINAPI} (index: GLuint);

  (* GL_NV_register_combiners *)
  TglCombinerParameterfvNV = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLfloat);
  TglCombinerParameterfNV = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglCombinerParameterivNV = PROCEDURE {WINAPI} (pname: GLenum;  params: PGLint);
  TglCombinerParameteriNV = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglCombinerInputNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum);
  TglCombinerOutputNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; abOutput: GLenum; cdOutput: GLenum; sumOutput: GLenum; scale: GLenum; bias: GLenum; abDotProduct: GLboolean; cdDotProduct: GLboolean; muxSum: GLboolean);
  TglFinalCombinerInputNV = PROCEDURE {WINAPI} (variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum);
  TglGetCombinerInputParameterfvNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLfloat);
  TglGetCombinerInputParameterivNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLint);
  TglGetCombinerOutputParameterfvNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; pname: GLenum; params: PGLfloat);
  TglGetCombinerOutputParameterivNV = PROCEDURE {WINAPI} (stage: GLenum; portion: GLenum; pname: GLenum; params: PGLint);
  TglGetFinalCombinerInputParameterfvNV = PROCEDURE {WINAPI} (variable: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFinalCombinerInputParameterivNV = PROCEDURE {WINAPI} (variable: GLenum; pname: GLenum; params: PGLint);

  (* GL_NV_register_combiners2*)
  TglCombinerStageParameterfvNV = PROCEDURE {WINAPI} (stage: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetCombinerStageParameterfvNV = PROCEDURE {WINAPI} (stage: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_NV_vertex_array_range *)
  TglFlushVertexArrayRangeNV = PROCEDURE {WINAPI} ();
  TglVertexArrayRangeNV = PROCEDURE {WINAPI} (length: GLsizei;  xpointer: PGLvoid);

  (* GL_NV_vertex_program *)
  TglAreProgramsResidentNV = PROCEDURE {WINAPI} (n: GLsizei;  programs: PGLuint; residences: PGLboolean): GLboolean;
  TglBindProgramNV = PROCEDURE {WINAPI} (target: GLenum; id: GLuint);
  TglDeleteProgramsNV = PROCEDURE {WINAPI} (n: GLsizei;  programs: PGLuint);
  TglExecuteProgramNV = PROCEDURE {WINAPI} (target: GLenum; id: GLuint;  params: PGLfloat);
  TglGenProgramsNV = PROCEDURE {WINAPI} (n: GLsizei; programs: PGLuint);
  TglGetProgramParameterdvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetProgramParameterfvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetProgramivNV = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; params: PGLint);
  TglGetProgramStringNV = PROCEDURE {WINAPI} (id: GLuint; pname: GLenum; xprogram: PGLubyte);
  TglGetTrackMatrixivNV = PROCEDURE {WINAPI} (target: GLenum; address: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribdvNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetVertexAttribfvNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribivNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointervNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgramNV = PROCEDURE {WINAPI} (id: GLuint): GLboolean;
  TglLoadProgramNV = PROCEDURE {WINAPI} (target: GLenum; id: GLuint; len: GLsizei;  xprogram: PGLubyte);
  TglProgramParameter4dNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramParameter4dvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  v: PGLdouble);
  TglProgramParameter4fNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramParameter4fvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  v: PGLfloat);
  TglProgramParameters4dvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLuint;  v: PGLdouble);
  TglProgramParameters4fvNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLuint;  v: PGLfloat);
  TglRequestResidentProgramsNV = PROCEDURE {WINAPI} (n: GLsizei;  programs: PGLuint);
  TglTrackMatrixNV = PROCEDURE {WINAPI} (target: GLenum; address: GLuint; matrix: GLenum; transform: GLenum);
  TglVertexAttribPointerNV = PROCEDURE {WINAPI} (index: GLuint; fsize: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglVertexAttrib1dNV = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble);
  TglVertexAttrib1dvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib1fNV = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat);
  TglVertexAttrib1fvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib1sNV = PROCEDURE {WINAPI} (index: GLuint; x: GLshort);
  TglVertexAttrib1svNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib2dNV = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib2fNV = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib2sNV = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2svNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib3dNV = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib3fNV = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib3sNV = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3svNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4dNV = PROCEDURE {WINAPI} (index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLdouble);
  TglVertexAttrib4fNV = PROCEDURE {WINAPI} (index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLfloat);
  TglVertexAttrib4sNV = PROCEDURE {WINAPI} (index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4svNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubNV = PROCEDURE {WINAPI} (index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4ubvNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLubyte);
  TglVertexAttribs1dvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs1fvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs1svNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs2dvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs2fvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs2svNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs3dvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs3fvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs3svNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs4dvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs4fvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs4svNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs4ubvNV = PROCEDURE {WINAPI} (index: GLuint; count: GLsizei;  v: PGLubyte);

  (* GL_NV_depth_buffer_float *)
  TglDepthRangedNV = PROCEDURE {WINAPI} (n: GLdouble; f: GLdouble);
  TglClearDepthdNV = PROCEDURE {WINAPI} (d: GLdouble);
  TglDepthBoundsdNV = PROCEDURE {WINAPI} (zmin: GLdouble; zmax: GLdouble);

  (* GL_NV_framebuffer_multisample_coverage *)
  TglRenderbufferStorageMultsampleCoverageNV = PROCEDURE {WINAPI} (target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);

  (* GL_NV_geometry_program4 *)
  TglProgramVertexLimitNV = PROCEDURE {WINAPI} (target: GLenum; limit: GLint);

  (* GL_NV_gpu_program4 *)
  TglProgramLocalParameterI4iNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglProgramLocalParameterI4ivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLint);
  TglProgramLocalParametersI4ivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLint);
  TglProgramLocalParameterI4uiNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglProgramLocalParameterI4uivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLuint);
  TglProgramLocalParametersI4uivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLuint);
  TglProgramEnvParameterI4iNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglProgramEnvParameterI4ivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLint);
  TglProgramEnvParametersI4ivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLint);
  TglProgramEnvParameterI4uiNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglProgramEnvParameterI4uivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint;  params: PGLuint);
  TglProgramEnvParametersI4uivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; count: GLsizei;  params: PGLuint);
  TglGetProgramLocalParameterIivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLint);
  TglGetProgramLocalParameterIuivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLuint);
  TglGetProgramEnvParameterIivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLint);
  TglGetProgramEnvParameterIuivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; params: PGLuint);

  (* GL_NV_parameter_buffer_object *)
  TglProgramBufferParametersfvNV = PROCEDURE {WINAPI} (target: GLenum; buffer: GLuint; index: GLuint; count: GLsizei;  params: PGLfloat);
  TglProgramBufferParametersIivNV = PROCEDURE {WINAPI} (target: GLenum; buffer: GLuint; index: GLuint; count: GLsizei;  params: GLint);
  TglProgramBufferParametersIuivNV = PROCEDURE {WINAPI} (target: GLenum; buffer: GLuint; index: GLuint; count: GLuint;  params: PGLuint);

  (* GL_NV_transform_feedback *)
  TglBeginTransformFeedbackNV = PROCEDURE {WINAPI} (primitiveMode: GLenum);
  TglEndTransformFeedbackNV = PROCEDURE {WINAPI} ();
  TglTransformFeedbackAttribsNV = PROCEDURE {WINAPI} (count: GLsizei;  attribs: GLint; bufferMode: GLenum);
  TglBindBufferRangeNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; buffer: GLuint; offset: GLint; size: GLsizei);
  TglBindBufferOffsetNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; buffer: GLuint; offset: GLint);
  TglBindBufferBaseNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryingsNV = PROCEDURE {WINAPI} (xprogram: GLuint; count: GLsizei;  varyings: PPGLchar; bufferMode: GLenum);
  TglActiveVaryingNV = PROCEDURE {WINAPI} (xprogram: GLuint; CONST name: ARRAY OF CHAR);
  TglGetVaryingLocationNV = PROCEDURE {WINAPI} (xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;
  TglGetActiveVaryingNV = PROCEDURE {WINAPI} (xprogram: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; xtype: PGLenum; name: PGLchar);
  TglGetTransformFeedbackVaryingNV = PROCEDURE {WINAPI} (xprogram: GLuint; index: GLuint; location: PGLint);
   TglTransformFeedbackStreamAttribsNV = PROCEDURE {WINAPI} (count: GLsizei;  attribs: PGLint; nbuffers: GLsizei;  bufstreams: PGLint; bufferMode: GLenum);

  (* GL_NV_conditional_render *)
  TglBeginConditionalRenderNV = PROCEDURE {WINAPI} (id: GLuint; mode: GLenum);
  TglEndConditionalRenderNV = PROCEDURE {WINAPI} ();

  (* GL_NV_present_video *)
  TglPresentFrameKeyedNV = PROCEDURE {WINAPI} (video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDuratioId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; key0: GLuint; target1: GLenum; fill1: GLuint; key1: GLuint);
  TglPresentFrameDualFillNV = PROCEDURE {WINAPI} (video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDurationId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; target1: GLenum; fill1: GLuint; target2: GLenum; fill2: GLuint; target3: GLenum; fill3: GLuint);
  TglGetVideoivNV = PROCEDURE {WINAPI} (video_slot: GLuint; pname: GLenum; params: PGLint);
  TglGetVideouivNV = PROCEDURE {WINAPI} (video_slot: GLuint; pname: GLenum; params: PGLuint);
  TglGetVideoi64vNV = PROCEDURE {WINAPI} (video_slot: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetVideoui64vNV = PROCEDURE {WINAPI} (video_slot: GLuint; pname: GLenum; params: PGLuint64EXT);
(*  TglVideoParameterivNV = PROCEDURE {WINAPI} (video_slot: GLuint; pname: GLenum;  params: PGLint);  *)

  (* GL_NV_explicit_multisample *)
  TglGetMultisamplefvNV = PROCEDURE {WINAPI} (pname: GLenum; index: GLuint; val: PGLfloat);
  TglSampleMaskIndexedNV = PROCEDURE {WINAPI} (index: GLuint; mask: GLbitfield);
  TglTexRenderbufferNV = PROCEDURE {WINAPI} (target: GLenum; renderbuffer: GLuint);

  (* GL_NV_transform_feedback2 *)
  TglBindTransformFeedbackNV = PROCEDURE {WINAPI} (target: GLenum; id: GLuint);
  TglDeleteTransformFeedbacksNV = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglGenTransformFeedbacksNV = PROCEDURE {WINAPI} (n: GLsizei; ids: PGLuint);
  TglIsTransformFeedbackNV = PROCEDURE {WINAPI} (id: GLuint): GLboolean;
  TglPauseTransformFeedbackNV = PROCEDURE {WINAPI} ();
  TglResumeTransformFeedbackNV = PROCEDURE {WINAPI} ();
  TglDrawTransformFeedbackNV = PROCEDURE {WINAPI} (mode: GLenum; id: GLuint);

  (* GL_NV_video_capture *)
  TglBeginVideoCaptureNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint);
  TglBindVideoCaptureStreamBufferNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; offset: GLsizei);
  TglBindVideoCaptureStreamTextureNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; target: GLenum; texture: GLuint);
  TglEndVideoCaptureNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint);
  TglGetVideoCaptureivNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; pname: GLenum; params: PGLint);
  TglGetVideoCaptureStreamivNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLint);
  TglGetVideoCaptureStreamfvNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVideoCaptureStreamdvNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLdouble);
  TglVideoCaptureNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; sequence_num: PGLuint; capture_time: PGLuint64EXT): GLenum;
  TglVideoCaptureStreamParameterivNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLint);
  TglVideoCaptureStreamParameterfvNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLfloat);
  TglVideoCaptureStreamParameterdvNV = PROCEDURE {WINAPI} (video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLdouble);

  (* GL_NV_copy_image *)
  TglCopyImageSubDataNV = PROCEDURE {WINAPI} (srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei);

    (* GL_NV_shader_buffer_load *)
  TglMakeBufferResidentNV = PROCEDURE {WINAPI} (target: GLenum; access: GLenum);
  TglMakeBufferNonResidentNV = PROCEDURE {WINAPI} (target: GLenum);
  TglIsBufferResidentNV = PROCEDURE {WINAPI} (target: GLenum): GLboolean;
  TglMakeNamedBufferResidentNV = PROCEDURE {WINAPI} (buffer: GLuint; access: GLenum);
  TglMakeNamedBufferNonResidentNV = PROCEDURE {WINAPI} (buffer: GLuint);
  TglIsNamedBufferResidentNV = PROCEDURE {WINAPI} (buffer: GLuint): GLboolean;
  TglGetBufferParameterui64vNV = PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLuint64EXT);
  TglGetNamedBufferParameterui64vNV = PROCEDURE {WINAPI} (buffer: GLuint; pname: GLenum; params: PGLuint64EXT);
  TglGetIntegerui64vNV = PROCEDURE {WINAPI} (value: GLenum; result: PGLuint64EXT);
  TglUniformui64NV = PROCEDURE {WINAPI} (location: GLint; value: GLuint64EXT);
  TglUniformui64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglGetUniformui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; params: PGLuint64EXT);
  TglProgramUniformui64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; value: GLuint64EXT);
  TglProgramUniformui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);

  (* GL_NV_vertex_buffer_unified_memory *)
  TglBufferAddressRangeNV = PROCEDURE {WINAPI} (pname: GLenum; index: GLuint; adress: GLuint64EXT; length: GLsizei);
  TglVertexFormatNV = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei);
  TglNormalFormatNV = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei);
  TglColorFormatNV = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei);
  TglIndexFormatNV = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei);
  TglTexCoordFormatNV = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei);
  TglEdgeFlagFormatNV = PROCEDURE {WINAPI} (stride: GLsizei);
  TglSecondaryColorFormatNV = PROCEDURE {WINAPI} (size: GLint; xtype: GLenum; stride: GLsizei);
  TglFogCoordFormatNV = PROCEDURE {WINAPI} (xtype: GLenum; stride: GLsizei);
  TglVertexAttribFormatNV = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei);
  TglVertexAttribIFormatNV = PROCEDURE {WINAPI} (index: GLuint; size: GLint; xtype: GLenum; stride: GLsizei);
  TglGetIntegerui64i_vNV = PROCEDURE {WINAPI} (value: GLenum; index: GLuint; Result: PGLuint64EXT);

   (* GL_NV_gpu_program5 *)
  TglProgramSubroutineParametersuivNV = PROCEDURE {WINAPI} (target: GLenum; count: GLsizei;  params: PGLuint);
  TglGetProgramSubroutineParameteruivNV = PROCEDURE {WINAPI} (target: GLenum; index: GLuint; param: PGLuint);

    (*  GL_NV_gpu_shader5 *)
  TglUniform1i64NV = PROCEDURE {WINAPI} (location: GLint; x: GLint64EXT);
  TglUniform2i64NV = PROCEDURE {WINAPI} (location: GLint; x: GLint64EXT; y: GLint64EXT);
  TglUniform3i64NV = PROCEDURE {WINAPI} (location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglUniform4i64NV = PROCEDURE {WINAPI} (location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglUniform1i64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform2i64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform3i64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform4i64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform1ui64NV = PROCEDURE {WINAPI} (location: GLint; x: GLuint64EXT);
  TglUniform2ui64NV = PROCEDURE {WINAPI} (location: GLint; x: GLuint64EXT; y: GLuint64EXT);
  TglUniform3ui64NV = PROCEDURE {WINAPI} (location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglUniform4ui64NV = PROCEDURE {WINAPI} (location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglUniform1ui64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform2ui64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform3ui64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform4ui64vNV = PROCEDURE {WINAPI} (location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglGetUniformi64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; params: PGLint64EXT);
  TglProgramUniform1i64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLint64EXT);
  TglProgramUniform2i64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT);
  TglProgramUniform3i64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglProgramUniform4i64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglProgramUniform1i64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform2i64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform3i64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform4i64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform1ui64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLuint64EXT);
  TglProgramUniform2ui64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT);
  TglProgramUniform3ui64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglProgramUniform4ui64NV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglProgramUniform1ui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform2ui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform3ui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform4ui64vNV = PROCEDURE {WINAPI} (xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);

  (* GL_NV_vertex_attrib_integer_64bit *)
  TglVertexAttribL1i64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLint64EXT);
  TglVertexAttribL2i64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLint64EXT; y: GLint64EXT);
  TglVertexAttribL3i64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglVertexAttribL4i64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglVertexAttribL1i64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL2i64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL3i64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL4i64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL1ui64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLuint64EXT);
  TglVertexAttribL2ui64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLuint64EXT; y: GLuint64EXT);
  TglVertexAttribL3ui64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglVertexAttribL4ui64NV = PROCEDURE {WINAPI} (index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglVertexAttribL1ui64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL2ui64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL3ui64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL4ui64vNV = PROCEDURE {WINAPI} (index: GLuint;  v: PGLuint64EXT);
  TglGetVertexAttribLi64vNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetVertexAttribLui64vNV = PROCEDURE {WINAPI} (index: GLuint; pname: GLenum; params: PGLuint64EXT);
  TglVertexAttribLFormatNV = PROCEDURE {WINAPI} (index: GLuint; size: GLint; type_: GLenum; stride: GLsizei);

  (* GL_NV_vdpau_interop *)
  TglVDPAUInitNV = PROCEDURE {WINAPI} ( vdpDevice: PGLvoid;  getProcAddress: PGLvoid);
  TglVDPAUFiniNV = PROCEDURE {WINAPI} ;
  TglVDPAURegisterVideoSurfaceNV = PROCEDURE {WINAPI} (vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei;  textureNames: PGLuint): GLvdpauSurfaceNV;
  TglVDPAURegisterOutputSurfaceNV = PROCEDURE {WINAPI} (vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei;  textureNames: PGLuint): GLvdpauSurfaceNV;
  TglVDPAUIsSurfaceNV = PROCEDURE {WINAPI} (surface: GLvdpauSurfaceNV);
  TglVDPAUUnregisterSurfaceNV = PROCEDURE {WINAPI} (surface: GLvdpauSurfaceNV);
  TglVDPAUGetSurfaceivNV = PROCEDURE {WINAPI} (surface: GLvdpauSurfaceNV; pname: GLenum; bufSize: GLsizei; length: PGLsizei; values: PGLint);
  TglVDPAUSurfaceAccessNV = PROCEDURE {WINAPI} (surface: GLvdpauSurfaceNV; access: GLenum);
  TglVDPAUMapSurfacesNV = PROCEDURE {WINAPI} (numSurfaces: GLsizei;  surfaces: PGLvdpauSurfaceNV);
  TglVDPAUUnmapSurfacesNV = PROCEDURE {WINAPI} (numSurface: GLsizei;  surfaces: PGLvdpauSurfaceNV);

  (* GL_NV_texture_barrier *)
  TglTextureBarrierNV = PROCEDURE {WINAPI} ;
(********************************************************)
 (*  GL_PGI_misc_hints *)
  TglHintPGI = PROCEDURE {WINAPI} (target: GLenum; mode: GLint);

  (*  GL_SGIS_detail_texture *)
  TglDetailTexFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; n: GLsizei; points: PGLfloat);
  TglGetDetailTexFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; points: PGLfloat);

  (*  GL_SGIS_fog_function *)
  TglFogFuncSGIS = PROCEDURE {WINAPI} (n: GLsizei; points: PGLfloat);
  TglGetFogFuncSGIS = PROCEDURE {WINAPI} (points: PGLfloat);

  (*  GL_SGIS_multisample *)
  TglSampleMaskSGIS = PROCEDURE {WINAPI} (value: GLclampf; invert: GLboolean);
  TglSamplePatternSGIS = PROCEDURE {WINAPI} (pattern: GLenum);

  (*  GL_SGIS_pixel_texture *)
  TglPixelTexGenParameteriSGIS = PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglPixelTexGenParameterivSGIS = PROCEDURE {WINAPI} (pname: GLenum; params: PGLint);
  TglPixelTexGenParameterfSGIS = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPixelTexGenParameterfvSGIS = PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);
  TglGetPixelTexGenParameterivSGIS = PROCEDURE {WINAPI} (pname: GLenum; params: PGLint);
  TglGetPixelTexGenParameterfvSGIS = PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);

  (*  GL_SGIS_point_parameters *)
  TglPointParameterfSGIS = PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglPointParameterfvSGIS = PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);

  (*  GL_SGIS_sharpen_texture *)
  TglSharpenTexFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; n: GLsizei; points: PGLfloat);
  TglGetSharpenTexFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; points: PGLfloat);

  (*  GL_SGIS_texture4D *)
  TglTexImage4DSGIS = PROCEDURE {WINAPI} (target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; border: GLint; format: GLenum; xtype:  GLenum; pixels: PGLvoid);
  TglTexSubImage4DSGIS = PROCEDURE {WINAPI} (target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; woffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; format: GLenum; xtype:  GLenum; pixels: PGLvoid);

  (*  GL_SGIS_texture_color_mask *)
  TglTextureColorMaskSGIS = PROCEDURE {WINAPI} (red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean);

  (*  GL_SGIS_texture_filter4 *)
  TglGetTexFilterFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; filter: GLenum; weights: PGLfloat);
  TglTexFilterFuncSGIS = PROCEDURE {WINAPI} (target: GLenum; filter: GLenum; n: GLsizei; weights: PGLfloat);

  (*  GL_SGIX_async *)
  TglAsyncMarkerSGIX = PROCEDURE {WINAPI} (marker: GLuint);
  TglFinishAsyncSGIX = PROCEDURE {WINAPI} (markerp: PGLuint): GLint;
  TglPollAsyncSGIX = PROCEDURE {WINAPI} (markerp: PGLuint): GLint;
  TglGenAsyncMarkersSGIX = PROCEDURE {WINAPI} (range: GLsizei): GLuint;
  TglDeleteAsyncMarkersSGIX = PROCEDURE {WINAPI} (marker: GLuint; range: GLsizei);
  TglIsAsyncMarkerSGIX = PROCEDURE {WINAPI} (marker: GLuint): GLboolean;

  (*  GL_SGIX_flush_raster *)
  TglFlushRasterSGIX= PROCEDURE {WINAPI} ();

  (*  GL_SGIX_fragment_lighting *)
  TglFragmentColorMaterialSGIX= PROCEDURE {WINAPI} (face: GLenum; mode: GLenum);
  TglFragmentLightfSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; param: GLfloat);
  TglFragmentLightfvSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLfloat);
  TglFragmentLightiSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; param: GLint);
  TglFragmentLightivSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLint);
  TglFragmentLightModelfSGIX= PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglFragmentLightModelfvSGIX= PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);
  TglFragmentLightModeliSGIX= PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglFragmentLightModelivSGIX= PROCEDURE {WINAPI} (pname: GLenum; params: PGLint);
  TglFragmentMaterialfSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; param: GLfloat);
  TglFragmentMaterialfvSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLfloat);
  TglFragmentMaterialiSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; param: GLint);
  TglFragmentMaterialivSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLint);
  TglGetFragmentLightfvSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFragmentLightivSGIX= PROCEDURE {WINAPI} (light: GLenum; pname: GLenum; params: PGLint);
  TglGetFragmentMaterialfvSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFragmentMaterialivSGIX= PROCEDURE {WINAPI} (face: GLenum; pname: GLenum; params: PGLint);
  TglLightEnviSGIX= PROCEDURE {WINAPI} (pname: GLenum; param: GLint);

  (*  GL_SGIX_framezoom *)
  TglFrameZoomSGIX= PROCEDURE {WINAPI} (factor: GLint);

  (*  GL_SGIX_igloo_interface *)
  TglIglooInterfaceSGIX= PROCEDURE {WINAPI} (pname: GLenum; params: PGLvoid);

  (*  GL_SGIX_instruments *)
  TglGetInstrumentsSGIX = PROCEDURE {WINAPI} (): GLint;
  TglInstrumentsBufferSGIX= PROCEDURE {WINAPI} (size: GLsizei; buffer: PGLint);
  TglPollInstrumentsSGIX = PROCEDURE {WINAPI} (marker_p: PGLint): GLint;
  TglReadInstrumentsSGIX= PROCEDURE {WINAPI} (marker: GLint);
  TglStartInstrumentsSGIX= PROCEDURE {WINAPI} ();
  TglStopInstrumentsSGIX= PROCEDURE {WINAPI} (marker: GLint);

  (*  GL_SGIX_list_priority *)
  TglGetListParameterfvSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; params: PGLfloat);
  TglGetListParameterivSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; params: PGLint);
  TglListParameterfSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; param: GLfloat);
  TglListParameterfvSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; params: PGLfloat);
  TglListParameteriSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; param: GLint);
  TglListParameterivSGIX= PROCEDURE {WINAPI} (list: GLuint; pname: GLenum; params: PGLint);

  (*  GL_SGIX_pixel_texture *)
  TglPixelTexGenSGIX= PROCEDURE {WINAPI} (mode: GLenum);

  (*  GL_SGIX_polynomial_ffd *)
  TglDeformationMap3dSGIX= PROCEDURE {WINAPI} (target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; w1: GLdouble; w2: GLdouble; wstride: GLint; worder: GLint; points: PGLdouble);
  TglDeformationMap3fSGIX= PROCEDURE {WINAPI} (target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; w1: GLfloat; w2: GLfloat; wstride: GLint; worder: GLint; points: PGLfloat);
  TglDeformSGIX= PROCEDURE {WINAPI} (mask: GLbitfield);
  TglLoadIdentityDeformationMapSGIX= PROCEDURE {WINAPI} (mask: GLbitfield);

  (*  GL_SGIX_reference_plane *)
  TglReferencePlaneSGIX= PROCEDURE {WINAPI} ( equation: PGLdouble);

  (*  GL_SGIX_sprite *)
  TglSpriteParameterfSGIX= PROCEDURE {WINAPI} (pname: GLenum; param: GLfloat);
  TglSpriteParameterfvSGIX= PROCEDURE {WINAPI} (pname: GLenum; params: PGLfloat);
  TglSpriteParameteriSGIX= PROCEDURE {WINAPI} (pname: GLenum; param: GLint);
  TglSpriteParameterivSGIX= PROCEDURE {WINAPI} (pname: GLenum; params: PGLint);

  (*  GL_SGIX_tag_sample_buffer *)
  TglTagSampleBufferSGIX= PROCEDURE {WINAPI} ();

  (*  GL_SGI_color_table *)
  TglColorTableSGI= PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype:  GLenum; table: PGLvoid);
  TglColorTableParameterfvSGI= PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglColorTableParameterivSGI= PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);
  TglCopyColorTableSGI= PROCEDURE {WINAPI} (target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglGetColorTableSGI= PROCEDURE {WINAPI} (target: GLenum; format: GLenum; xtype:  GLenum; table: PGLvoid);
  TglGetColorTableParameterfvSGI= PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetColorTableParameterivSGI= PROCEDURE {WINAPI} (target: GLenum; pname: GLenum; params: PGLint);

  (*  GL_SUNX_constant_data *)
  TglFinishTextureSUNX= PROCEDURE {WINAPI} ();

  (*  GL_SUN_global_alpha *)
  TglGlobalAlphaFactorbSUN= PROCEDURE {WINAPI} (factor: GLbyte);
  TglGlobalAlphaFactorsSUN= PROCEDURE {WINAPI} (factor: GLshort);
  TglGlobalAlphaFactoriSUN= PROCEDURE {WINAPI} (factor: GLint);
  TglGlobalAlphaFactorfSUN= PROCEDURE {WINAPI} (factor: GLfloat);
  TglGlobalAlphaFactordSUN= PROCEDURE {WINAPI} (factor: GLdouble);
  TglGlobalAlphaFactorubSUN= PROCEDURE {WINAPI} (factor: GLubyte);
  TglGlobalAlphaFactorusSUN= PROCEDURE {WINAPI} (factor: GLushort);
  TglGlobalAlphaFactoruiSUN= PROCEDURE {WINAPI} (factor: GLuint);

  (*  GL_SUN_mesh_array *)
  TglDrawMeshArraysSUN= PROCEDURE {WINAPI} (mode: GLenum; first: GLint; count: GLsizei; width: GLsizei);

  (*  GL_SUN_triangle_list *)
  TglReplacementCodeuiSUN= PROCEDURE {WINAPI} (code: GLuint);
  TglReplacementCodeusSUN= PROCEDURE {WINAPI} (code: GLushort);
  TglReplacementCodeubSUN= PROCEDURE {WINAPI} (code: GLubyte);
  TglReplacementCodeuivSUN= PROCEDURE {WINAPI} ( code: PGLuint);
  TglReplacementCodeusvSUN= PROCEDURE {WINAPI} ( code: PGLushort);
  TglReplacementCodeubvSUN= PROCEDURE {WINAPI} ( code: PGLubyte);
  TglReplacementCodePointerSUN= PROCEDURE {WINAPI} (xtype:  GLenum; stride: GLsizei; xpointer: PGLvoid);

  (*  GL_SUN_vertex *)
  TglColor4ubVertex2fSUN= PROCEDURE {WINAPI} (r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat);
  TglColor4ubVertex2fvSUN= PROCEDURE {WINAPI} ( c: PGLubyte;  v: PGLfloat);
  TglColor4ubVertex3fSUN= PROCEDURE {WINAPI} (r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor4ubVertex3fvSUN= PROCEDURE {WINAPI} (c: PGLubyte; v: PGLfloat);
  TglColor3fVertex3fSUN= PROCEDURE {WINAPI} (r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor3fVertex3fvSUN= PROCEDURE {WINAPI} (c: PGLfloat; v: PGLfloat);
  TglNormal3fVertex3fSUN= PROCEDURE {WINAPI} (nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglNormal3fVertex3fvSUN= PROCEDURE {WINAPI} (n: PGLfloat; v: PGLfloat);
  TglColor4fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor4fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} (c: PGLfloat; n: PGLfloat; v: PGLfloat);
  TglTexCoord2fVertex3fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fVertex3fvSUN= PROCEDURE {WINAPI} (tc: PGLfloat; v: PGLfloat);
  TglTexCoord4fVertex4fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglTexCoord4fVertex4fvSUN= PROCEDURE {WINAPI} (tc: PGLfloat; v: PGLfloat);
  TglTexCoord2fColor4ubVertex3fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor4ubVertex3fvSUN= PROCEDURE {WINAPI} (tc: PGLfloat; c: PGLubyte; v: PGLfloat);
  TglTexCoord2fColor3fVertex3fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor3fVertex3fvSUN= PROCEDURE {WINAPI} (tc: PGLfloat; c: PGLfloat; v: PGLfloat);
  TglTexCoord2fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( tc: PGLfloat;  n: PGLfloat; v: PGLfloat);
  TglTexCoord2fColor4fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor4fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglTexCoord4fColor4fNormal3fVertex4fSUN= PROCEDURE {WINAPI} (s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglTexCoord4fColor4fNormal3fVertex4fvSUN= PROCEDURE {WINAPI} ( tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  v: PGLfloat);
  TglReplacementCodeuiColor4ubVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor4ubVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  c: PGLubyte;  v: PGLfloat);
  TglReplacementCodeuiColor3fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor3fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  c: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiNormal3fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiColor4fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor4fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  tc: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  tc: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN= PROCEDURE {WINAPI} (rc: GLuint; s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN= PROCEDURE {WINAPI} ( rc: PGLuint;  tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);


 (*! window support functions WINDOWS *)
(* ************************************************* *)

  TwglGetProcAddress = PROCEDURE {WINAPI} (  CONST ProcName: ARRAY OF CHAR): Pointer;
  TwglCopyContext = PROCEDURE {WINAPI} (p1: HGLRC; p2: HGLRC; p3: Cardinal): BOOLEAN;
  TwglCreateContext = PROCEDURE {WINAPI} (DC: HDC): HGLRC;
  TwglCreateLayerContext = PROCEDURE {WINAPI} (p1: HDC; p2: Integer): HGLRC;
  TwglDeleteContext = PROCEDURE {WINAPI} (p1: HGLRC): BOOLEAN;
  (*TwglDescribeLayerPlane  = PROCEDURE {WINAPI} (p1: HDC; p2, p3: LONGINT; p4: LONGINT; p5: PLayerPlaneDescriptor): BOOLEAN; *)
  TwglGetCurrentContext = PROCEDURE {WINAPI}(): HGLRC;
  TwglGetCurrentDC = PROCEDURE {WINAPI}(): HDC;
  TwglGetLayerPaletteEntries = PROCEDURE {WINAPI} (p1: HDC; p2, p3, p4: Integer; varpcr: ADDRESS): Integer;
  TwglMakeCurrent = PROCEDURE {WINAPI} (DC: HDC; p2: HGLRC): BOOLEAN;
  TwglRealizeLayerPalette  = PROCEDURE {WINAPI} (p1: HDC; p2: Integer; p3: BOOLEAN): BOOLEAN;
  TwglSetLayerPaletteEntries  = PROCEDURE {WINAPI} (p1: HDC; p2, p3, p4: Integer;  varpcr: ADDRESS): Integer;
  TwglShareLists = PROCEDURE {WINAPI} (p1, p2: HGLRC): BOOLEAN;
  TwglSwapLayerBuffers  = PROCEDURE {WINAPI} (p1: HDC; p2: Cardinal): BOOLEAN;
(*  TwglSwapMultipleBuffers  = PROCEDURE {WINAPI} (p1: UINT; CONST p2: PWGLSWAP): DWORD; *)
  TwglUseFontBitmapsA  = PROCEDURE {WINAPI} (DC: HDC; p2, p3, p4: DWORD): BOOLEAN;
  TwglUseFontBitmapsW  = PROCEDURE {WINAPI} (DC: HDC; p2, p3, p4: DWORD): BOOLEAN;
  TwglUseFontBitmaps  = PROCEDURE {WINAPI} (DC: HDC; p2, p3, p4: DWORD): BOOLEAN;

 (* TwglUseFontOutlinesA  = PROCEDURE {WINAPI} (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN;
  TwglUseFontOutlinesW  = PROCEDURE {WINAPI} (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN;
  TwglUseFontOutlines  = PROCEDURE {WINAPI} (p1: HDC; p2, p3, p4: DWORD; p5, p6: Single; p7: Integer; p8: PGlyphMetricsFloat): BOOLEAN;
*)

  (* WGL_ARB_buffer_region *)
  TwglCreateBufferRegionARB  = PROCEDURE {WINAPI} (hDC: HDC; iLayerPlane: GLint; uType: GLuint): THandle;
  TwglDeleteBufferRegionARB  = PROCEDURE {WINAPI}(hRegion: THandle);
  TwglSaveBufferRegionARB  = PROCEDURE {WINAPI} (hRegion: THandle; x: GLint; y: GLint; width: GLint; height: GLint): BOOLEAN;
  TwglRestoreBufferRegionARB  = PROCEDURE {WINAPI} (hRegion: THandle; x: GLint; y: GLint; width: GLint; height: GLint; xSrc: GLint; ySrc: GLint): BOOLEAN;

  (* WGL_ARB_extensionsxstring *)
  TwglGetExtensionsStringARB = PROCEDURE {WINAPI} (hdc: HDC): ADDRESS;


  (* WGL_ARB_make_current_read *)
  TwglMakeContextCurrentARB  = PROCEDURE {WINAPI} (hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): BOOLEAN;
  TwglGetCurrentReadDCARB  = PROCEDURE {WINAPI} (): HDC;

  (* WGL_ARB_pbuffer *)
  TwglCreatePbufferARB  = PROCEDURE {WINAPI} (hDC: HDC; iPixelFormat: GLint; iWidth: GLint; iHeight: GLint;  piAttribList:  PGLint): HPBUFFERARB;
  TwglGetPbufferDCARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB): HDC;
  TwglReleasePbufferDCARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; hDC: HDC): GLint;
  TwglDestroyPbufferARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB): BOOLEAN;
  TwglQueryPbufferARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; iAttribute: GLint;  piValue: ADDRESS (*GLint*)): BOOLEAN;

  (* WGL_ARB_pixel_format *)
  TwglGetPixelFormatAttribivARB  = PROCEDURE {WINAPI} (hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; CONST piAttributes: PGLint; piValues: PGLint): BOOLEAN;
  TwglGetPixelFormatAttribfvARB  = PROCEDURE {WINAPI} (hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; CONST piAttributes: PGLint; pfValues: PGLfloat): BOOLEAN;
  TwglChoosePixelFormatARB  = PROCEDURE {WINAPI} (hdc: HDC;  piAttribIList: ADDRESS (*PGLint*);  pfAttribFList: ADDRESS (* PGLfloat*); nMaxFormats: GLuint; (*VAR*) piFormats: ADDRESS;(*GLint; VAR*) nNumFormats: ADDRESS(*GLuint*)): BOOLEAN;

  (* WGL_ARB_color_buffer_float *)
  TwglClampColorARB  = PROCEDURE {WINAPI}(target: GLenum; clamp: GLenum);

  (* WGL_ARB_render_texture *)
  TwglBindTexImageARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; iBuffer: GLint): BOOLEAN;
  TwglReleaseTexImageARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; iBuffer: GLint): BOOLEAN;
  TwglSetPbufferAttribARB  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; CONST piAttribList: PGLint): BOOLEAN;

  (* WGL_ARB_create_context *)
  TwglCreateContextAttribsARB  = PROCEDURE {WINAPI} (hDC: HDC; hShareContext: HGLRC;  attribList: ADDRESS (*PGLint*)): HGLRC;

  (* WGL_AMD_gpu_association *)
  TwglGetGPUIDsAMD  = PROCEDURE {WINAPI} (maxCount: Cardinal; ids: PCardinal): Cardinal;
  TwglGetGPUInfoAMD  = PROCEDURE {WINAPI} (id: Cardinal; property_: Integer; dataType: GLenum; size: Cardinal; data: Pointer): Integer;
  TwglGetContextGPUIDAMD  = PROCEDURE {WINAPI} (hglrc: HGLRC): Cardinal;
  TwglCreateAssociatedContextAMD  = PROCEDURE {WINAPI} (id: Cardinal): HGLRC;
  TwglCreateAssociatedContextAttribsAMD  = PROCEDURE {WINAPI} (id: Cardinal; hShareContext: HGLRC; CONST attribList: PInteger): HGLRC;
  TwglDeleteAssociatedContextAMD  = PROCEDURE {WINAPI} (hglrc: HGLRC): BOOLEAN;
  TwglMakeAssociatedContextCurrentAMD  = PROCEDURE {WINAPI} (hglrc: HGLRC): BOOLEAN;
  TwglGetCurrentAssociatedContextAMD  = PROCEDURE {WINAPI} (): HGLRC;
  TwglBlitContextFramebufferAMD  = PROCEDURE {WINAPI}(dstCtx: HGLRC; srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum);

  (* WGL_EXT_display_color_table *)
  TwglCreateDisplayColorTableEXT  = PROCEDURE {WINAPI} (id: GLushort): GLboolean;
  TwglLoadDisplayColorTableEXT  = PROCEDURE {WINAPI} (table: PGLushort; length: GLuint): GLboolean;
  TwglBindDisplayColorTableEXT  = PROCEDURE {WINAPI} (id: GLushort): GLboolean;
  TwglDestroyDisplayColorTableEXT  = PROCEDURE {WINAPI}(id: GLushort);

  (* WGL_EXT_extensionsxstring *)
  TwglGetExtensionsStringEXT  = PROCEDURE {WINAPI} (): ADDRESS;

  (* WGL_EXT_make_current_read *)
  TwglMakeContextCurrentEXT  = PROCEDURE {WINAPI} (hDrawDC: HDC; hReadDC: HDC; hglrc: HGLRC): BOOLEAN;
  TwglGetCurrentReadDCEXT  = PROCEDURE {WINAPI} (): HDC;

  (* WGL_EXT_pbuffer *)
  TwglCreatePbufferEXT  = PROCEDURE {WINAPI} (hDC: HDC; iPixelFormat: GLint; iWidth: GLint; iHeight: GLint; CONST piAttribList: PGLint): HPBUFFEREXT;
  TwglGetPbufferDCEXT  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFEREXT): HDC;
  TwglReleasePbufferDCEXT  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFEREXT; hDC: HDC): GLint;
  TwglDestroyPbufferEXT  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFEREXT): BOOLEAN;
  TwglQueryPbufferEXT  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFEREXT; iAttribute: GLint; piValue: PGLint): BOOLEAN;

  (* WGL_EXT_pixel_format *)
  TwglGetPixelFormatAttribivEXT  = PROCEDURE {WINAPI} (hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; piAttributes: PGLint; piValues: PGLint): BOOLEAN;
  TwglGetPixelFormatAttribfvEXT  = PROCEDURE {WINAPI} (hdc: HDC; iPixelFormat: GLint; iLayerPlane: GLint; nAttributes: GLuint; piAttributes: PGLint; pfValues: PGLfloat): BOOLEAN;
  TwglChoosePixelFormatEXT  = PROCEDURE {WINAPI} (hdc: HDC; CONST piAttribIList: PGLint; CONST pfAttribFList: PGLfloat; nMaxFormats: GLuint; piFormats: PGLint; nNumFormats: PGLuint): BOOLEAN;

  (* WGL_EXT_swap_control *)
  TwglSwapIntervalEXT  = PROCEDURE {WINAPI} (interval: GLint): BOOLEAN;
  TwglGetSwapIntervalEXT  = PROCEDURE {WINAPI} ( ): GLint;

  (* WGL_I3D_digital_video_control *)
  TwglGetDigitalVideoParametersI3D  = PROCEDURE {WINAPI} (hDC: HDC; iAttribute: GLint; piValue: PGLint): BOOLEAN;
  TwglSetDigitalVideoParametersI3D  = PROCEDURE {WINAPI} (hDC: HDC; iAttribute: GLint; CONST piValue: PGLint): BOOLEAN;

  (* WGL_I3D_gamma *)
  TwglGetGammaTableParametersI3D  = PROCEDURE {WINAPI} (hDC: HDC; iAttribute: GLint; piValue: PGLint): BOOLEAN;
  TwglSetGammaTableParametersI3D  = PROCEDURE {WINAPI} (hDC: HDC; iAttribute: GLint; CONST piValue: PGLint): BOOLEAN;
  TwglGetGammaTableI3D  = PROCEDURE {WINAPI} (hDC: HDC; iEntries: GLint; puRed: PGLushort; puGreen: PGLushort; puBlue: PGLushort): BOOLEAN;
  TwglSetGammaTableI3D  = PROCEDURE {WINAPI} (hDC: HDC; iEntries: GLint; CONST puRed: PGLushort; CONST puGreen: PGLushort; CONST puBlue: PGLushort): BOOLEAN;

  (* WGL_I3D_genlock *)
  TwglEnableGenlockI3D  = PROCEDURE {WINAPI} (hDC: HDC): BOOLEAN;
  TwglDisableGenlockI3D  = PROCEDURE {WINAPI} ( hDC: HDC): BOOLEAN;
  TwglIsEnabledGenlockI3D  = PROCEDURE {WINAPI} (hDC: HDC; pFlag: BOOLEAN): BOOLEAN;
  TwglGenlockSourceI3D  = PROCEDURE {WINAPI} (hDC: HDC; uSource: GLuint): BOOLEAN;
  TwglGetGenlockSourceI3D  = PROCEDURE {WINAPI} (hDC: HDC; uSource: PGLuint): BOOLEAN;
  TwglGenlockSourceEdgeI3D  = PROCEDURE {WINAPI} (hDC: HDC; uEdge: GLuint): BOOLEAN;
  TwglGetGenlockSourceEdgeI3D  = PROCEDURE {WINAPI} (hDC: HDC; uEdge: PGLuint): BOOLEAN;
  TwglGenlockSampleRateI3D  = PROCEDURE {WINAPI} (hDC: HDC; uRate: GLuint): BOOLEAN;
  TwglGetGenlockSampleRateI3D  = PROCEDURE {WINAPI} (hDC: HDC; uRate: PGLuint): BOOLEAN;
  TwglGenlockSourceDelayI3D  = PROCEDURE {WINAPI} ( hDC: HDC; uDelay: GLuint): BOOLEAN;
  TwglGetGenlockSourceDelayI3D  = PROCEDURE {WINAPI} (hDC: HDC; uDelay: PGLuint): BOOLEAN;
  TwglQueryGenlockMaxSourceDelayI3D  = PROCEDURE {WINAPI} (hDC: HDC; uMaxLineDelay: PGLuint; uMaxPixelDelay: PGLuint): BOOLEAN;

  (* WGL_I3D_image_buffer *)
  TwglCreateImageBufferI3D  = PROCEDURE {WINAPI} (hDC: HDC; dwSize: GLuint; uFlags: GLuint): GLvoid;
  TwglDestroyImageBufferI3D  = PROCEDURE {WINAPI} (hDC: HDC; pAddress: GLvoid): BOOLEAN;
  TwglAssociateImageBufferEventsI3D  = PROCEDURE {WINAPI} (hDC: HDC; CONST pEvent: THandle; CONST pAddress: PGLvoid; CONST pSize: PGLuint; count: GLuint): BOOLEAN;
  TwglReleaseImageBufferEventsI3D  = PROCEDURE {WINAPI} (hDC: HDC; CONST pAddress: PGLvoid; count: GLuint): BOOLEAN;

  (* WGL_I3D_swap_frame_lock *)
  TwglEnableFrameLockI3D  = PROCEDURE {WINAPI} ( ): BOOLEAN;
  TwglDisableFrameLockI3D  = PROCEDURE {WINAPI} ( ): BOOLEAN;
  TwglIsEnabledFrameLockI3D  = PROCEDURE {WINAPI} (pFlag: BOOLEAN): BOOLEAN;
  TwglQueryFrameLockMasterI3D  = PROCEDURE {WINAPI} (pFlag: BOOLEAN): BOOLEAN;

  (* WGL_I3D_swap_frame_usage *)
  TwglGetFrameUsageI3D  = PROCEDURE {WINAPI} (pUsage: PGLfloat): BOOLEAN;
  TwglBeginFrameTrackingI3D  = PROCEDURE {WINAPI} ( ): BOOLEAN;
  TwglEndFrameTrackingI3D  = PROCEDURE {WINAPI} (): BOOLEAN;
  TwglQueryFrameTrackingI3D  = PROCEDURE {WINAPI} (pFrameCount: PGLuint; pMissedFrames: PGLuint; pLastMissedUsage: PGLfloat): BOOLEAN;

  (* WGL_NV_vertex_array_range *)
  TwglAllocateMemoryNV  = PROCEDURE {WINAPI}(size: GLsizei; readfreq: GLfloat; writefreq: GLfloat; priority: GLfloat);
  TwglFreeMemoryNV  = PROCEDURE {WINAPI}(_pointer: Pointer);

  (* WGL_NV_present_video  *)
  TwglEnumerateVideoDevicesNV  = PROCEDURE {WINAPI} (hdc: HDC; phDeviceList: PHVIDEOOUTPUTDEVICENV): Integer;
  TwglBindVideoDeviceNV  = PROCEDURE {WINAPI} (hd: HDC; uVideoSlot: Cardinal; hVideoDevice: HVIDEOOUTPUTDEVICENV; piAttribList: PInteger): BOOLEAN;
  TwglQueryCurrentContextNV  = PROCEDURE {WINAPI} (iAttribute: Integer; piValue: PInteger): BOOLEAN;

  (* WGL_NV_video_output *)
  TwglGetVideoDeviceNV  = PROCEDURE {WINAPI} (hDC: HDC; numDevices: Integer; hVideoDevice: PHPVIDEODEV): BOOLEAN;
  TwglReleaseVideoDeviceNV  = PROCEDURE {WINAPI} (hVideoDevice: HPVIDEODEV): BOOLEAN;
  TwglBindVideoImageNV  = PROCEDURE {WINAPI} (hVideoDevice: HPVIDEODEV; hPbuffer: HPBUFFERARB; iVideoBuffer: Integer): BOOLEAN;
  TwglReleaseVideoImageNV  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; iVideoBuffer: Integer): BOOLEAN;
  TwglSendPbufferToVideoNV  = PROCEDURE {WINAPI} (hPbuffer: HPBUFFERARB; iBufferType: Integer; pulCounterPbuffer: PCardinal; bBlock: BOOLEAN): BOOLEAN;
  TwglGetVideoInfoNV  = PROCEDURE {WINAPI} (hpVideoDevice: HPVIDEODEV; pulCounterOutputPbuffer: PCardinal; pulCounterOutputVideo: PCardinal): BOOLEAN;

  (* WGL_NV_swap_group *)
  TwglJoinSwapGroupNV  = PROCEDURE {WINAPI} (hDC: HDC; group: GLuint): BOOLEAN;
  TwglBindSwapBarrierNV  = PROCEDURE {WINAPI} (group: GLuint; barrier: GLuint): BOOLEAN;
  TwglQuerySwapGroupNV  = PROCEDURE {WINAPI} (hDC: HDC; group: PGLuint; barrier: PGLuint): BOOLEAN;
  TwglQueryMaxSwapGroupsNV  = PROCEDURE {WINAPI} (hDC: HDC; mxGroups: PGLuint; maxBarriers: PGLuint): BOOLEAN;
  TwglQueryFrameCountNV  = PROCEDURE {WINAPI} (hDC: HDC; count: PGLuint): BOOLEAN;
  TwglResetFrameCountNV  = PROCEDURE {WINAPI} (hDC: HDC): BOOLEAN;

  (* WGL_NV_gpu_affinity *)
  TwglEnumGpusNV  = PROCEDURE {WINAPI} (iGpuIndex: Cardinal; phGpu: PHGPUNV): BOOLEAN;
  TwglEnumGpuDevicesNV  = PROCEDURE {WINAPI} (hGpu: HGPUNV; iDeviceIndex: Cardinal; lpGpuDevice: PGPU_DEVICE): BOOLEAN;
  TwglCreateAffinityDCNV  = PROCEDURE {WINAPI} ( CONST phGpuList: PHGPUNV): HDC;
  TwglEnumGpusFromAffinityDCNV  = PROCEDURE {WINAPI} (hAffinityDC: HDC; iGpuIndex: Cardinal; hGpu: PHGPUNV): BOOLEAN;
  TwglDeleteDCNV  = PROCEDURE {WINAPI} (hDC: HDC): BOOLEAN;

  (* WGL_NV_video_capture *)
  TwglBindVideoCaptureDeviceNV  = PROCEDURE {WINAPI} (uVideoSlot: Cardinal; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN;
  TwglEnumerateVideoCaptureDevicesNV  = PROCEDURE {WINAPI} (hDc: HDC; phDeviceList: PHVIDEOINPUTDEVICENV): Cardinal;
  TwglLockVideoCaptureDeviceNV  = PROCEDURE {WINAPI} (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN;
  TwglQueryVideoCaptureDeviceNV  = PROCEDURE {WINAPI} (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV; iAttribute: Integer; piValue: PInteger): BOOLEAN;
  TwglReleaseVideoCaptureDeviceNV  = PROCEDURE {WINAPI} (hDc: HDC; hDevice: HVIDEOINPUTDEVICENV): BOOLEAN;

  (* WGL_NV_copy_image *)
  TwglCopyImageSubDataNV  = PROCEDURE {WINAPI} (hSrcRc: HGLRC; srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; hDstRC: HGLRC; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei): BOOLEAN;

  (* WGL_OML_sync_control *)
  TwglGetSyncValuesOML  = PROCEDURE {WINAPI} (hdc: HDC; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN;
  TwglGetMscRateOML  = PROCEDURE {WINAPI} (hdc: HDC; numerator: PGLint; denominator: PGLint): BOOLEAN;
  TwglSwapBuffersMscOML  = PROCEDURE {WINAPI} (hdc: HDC; target_msc: GLint64; divisor: GLint64; remainder: GLint64): GLint64;
  TwglSwapLayerBuffersMscOML  = PROCEDURE {WINAPI} (hdc: HDC; fuPlanes: GLint; target_msc: GLint64; divisor: GLint64; remainder: GLint64): GLint64;
  TwglWaitForMscOML  = PROCEDURE {WINAPI} (hdc: HDC; target_msc: GLint64; divisor: GLint64; remainder: GLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN;
  TwglWaitForSbcOML  = PROCEDURE {WINAPI} (hdc: HDC; target_sbc: GLint64; ust: PGLint64; msc: PGLint64; sbc: PGLint64): BOOLEAN;


  (* WGL_3DL_stereo_control *)
(*  wglSetStereoEmitterState3DL  = PROCEDURE {WINAPI} (hDC: HDC; uState: UINT): BOOLEAN; *)

  (* WIN_draw_range_elements *)
  TglDrawRangeElementsWIN  = PROCEDURE {WINAPI}(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; _type: GLenum; CONST indices: PGLvoid);

  (* WIN_swap_hint *)
  TglAddSwapHintRectWIN  = PROCEDURE {WINAPI}(x: GLint; y: GLint; width: GLsizei; height: GLsizei);
 (* ENDIF *)


  (*! GL utility functions and procedures *)
VAR

  gluErrorString - : PROCEDURE {WINAPI} (errCode: GLenum): ADDRESS; (* AnsiChar; *)
  gluGetString - : PROCEDURE {WINAPI} (name: GLenum): ADDRESS;
  gluOrtho2D - : PROCEDURE {WINAPI}(left, right, bottom, top: GLdouble);
  gluPerspective - : PROCEDURE {WINAPI}(fovy, aspect, zNear, zFar: GLdouble);
  gluPickMatrix - : PROCEDURE {WINAPI}(x, y, width, height: GLdouble; CONST viewport: TVector4i);
  gluLookAt - : PROCEDURE {WINAPI}(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: GLdouble);
  gluProject - : PROCEDURE {WINAPI} (objx, objy, objz: GLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; winx, winy, winz: PGLdouble): GLint;
  gluUnProject - : PROCEDURE {WINAPI} (winx, winy, winz: GLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; objx, objy, objz: PGLdouble): GLint;
  gluScaleImage - : PROCEDURE {WINAPI} (format: GLenum; widthin, heightin: GLint; typein: GLenum; datain: Pointer; widthout, heightout: GLint; typeout: GLenum; CONST dataout: Pointer): GLint;
  gluBuild1DMipmaps - : PROCEDURE {WINAPI} (target: GLenum; components, width: GLint; format, atype: GLenum; CONST data: Pointer): GLint;
  gluBuild2DMipmaps - : PROCEDURE {WINAPI} (target: GLenum; components, width, height: GLint; format, atype: GLenum; CONST Data: Pointer): GLint;
  gluNewQuadric - : PROCEDURE {WINAPI}(): TGLUQuadric;
  gluDeleteQuadric - : PROCEDURE {WINAPI}(state: TGLUQuadric);
  gluQuadricNormals - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; normals: GLenum);
  gluQuadricTexture - : PROCEDURE {WINAPI}(quadObject: PGLUQuadric; textureCoords: GLboolean);
  gluQuadricOrientation - : PROCEDURE {WINAPI}(quadObject: PGLUQuadric; orientation: GLenum);
  gluQuadricDrawStyle - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; drawStyle: GLenum);
  gluCylinder - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; baseRadius, topRadius, height: GLdouble; slices, stacks: GLint);
  gluDisk - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; innerRadius, outerRadius: GLdouble; slices, loops: GLint);
  gluPartialDisk - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; innerRadius, outerRadius: GLdouble; slices, loops: GLint; startAngle, sweepAngle: GLdouble);
  gluSphere - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; radius: GLdouble; slices, stacks: GLint);
  gluQuadricCallback - : PROCEDURE {WINAPI}(quadObject: TGLUQuadric; which: GLenum; fn: ADDRESS (*TGLUQuadricErrorProc*));
  gluNewTess - : PROCEDURE {WINAPI}(): PGLUTesselator;
  gluDeleteTess - : PROCEDURE {WINAPI}(tess: PGLUTesselator);
  gluTessBeginPolygon - : PROCEDURE {WINAPI}(tess: PGLUTesselator; polygon_data: Pointer);
  gluTessBeginContour - : PROCEDURE {WINAPI}(tess: PGLUTesselator);
  gluTessVertex - : PROCEDURE {WINAPI}(tess: PGLUTesselator; CONST coords: TGLArrayd3; data: Pointer);
  gluTessEndContour - : PROCEDURE {WINAPI}(tess: PGLUTesselator);
  gluTessEndPolygon - : PROCEDURE {WINAPI}(tess: PGLUTesselator);
  gluTessProperty - : PROCEDURE {WINAPI}(tess: PGLUTesselator; which: GLenum; value: GLdouble);
  gluTessNormal - : PROCEDURE {WINAPI}(tess: PGLUTesselator; x, y, z: GLdouble);
  gluTessCallback - : PROCEDURE {WINAPI}(tess: PGLUTesselator; which: GLenum; fn: Pointer);
  gluGetTessProperty - : PROCEDURE {WINAPI}(tess: PGLUTesselator; which: GLenum; value: PGLdouble);
  gluNewNurbsRenderer - : PROCEDURE {WINAPI}(): PGLUNurbs;
  gluDeleteNurbsRenderer - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluBeginSurface - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluBeginCurve - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluEndCurve - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluEndSurface - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluBeginTrim - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluEndTrim - : PROCEDURE {WINAPI}(nobj: PGLUNurbs);
  gluPwlCurve - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; count: GLint; points: PGLfloat; stride: GLint; atype: GLenum);
  gluNurbsCurve - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; nknots: GLint; knot: PGLfloat; stride: GLint; ctlarray: PGLfloat; order: GLint; atype: GLenum);
  gluNurbsSurface - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; sknot_count: GLint; sknot: PGLfloat; tknot_count: GLint; tknot: PGLfloat; s_stride, t_stride: GLint; ctlarray: PGLfloat; sorder, torder: GLint; atype: GLenum);
  gluLoadSamplingMatrices - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; CONST modelMatrix, projMatrix: TGLMatrixf4; CONST viewport: TVector4i);
  gluNurbsProperty - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; aproperty: GLenum; value: GLfloat);
  gluGetNurbsProperty - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; aproperty: GLenum; value: PGLfloat);
  gluNurbsCallback - : PROCEDURE {WINAPI}(nobj: PGLUNurbs; which: GLenum; fn: TGLUNurbsErrorProc);
  gluBeginPolygon - : PROCEDURE {WINAPI}(tess: PGLUTesselator);
  gluNextContour - : PROCEDURE {WINAPI}(tess: PGLUTesselator; atype: GLenum);
  gluEndPolygon - : PROCEDURE {WINAPI}(tess: PGLUTesselator);

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
  glMinSampleShading-: TglMinSampleShading;
  glBlendEquationi-: TglBlendEquationi;
  glBlendEquationSeparatei-: TglBlendEquationSeparatei;
  glBlendFunci-: TglBlendFunci;
  glBlendFuncSeparatei-: TglBlendFuncSeparatei;


  (* GL_3DFX_tbuffer *)
  glTbufferMask3DFX- : TglTbufferMask3DFX;


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

  (*  GL_ARB_vertexxtype_2_10_10_10_rev *)
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

 (*! GL 4.2 *)

  (* GL_ARB_base_instance *)
  glDrawArraysInstancedBaseInstance- : TglDrawArraysInstancedBaseInstance;
  glDrawElementsInstancedBaseInstance- : TglDrawElementsInstancedBaseInstance;
  glDrawElementsInstancedBaseVertexBaseInstance- : TglDrawElementsInstancedBaseVertexBaseInstance;

  (* GL_ARB_transform_feedback_instanced *)
  glDrawTransformFeedbackInstanced- : TglDrawTransformFeedbackInstanced;
  glDrawTransformFeedbackStreamInstanced- : TglDrawTransformFeedbackStreamInstanced;

  (* GL_ARB_internalformat_query *)
  glGetInternalformativ- : TglGetInternalformativ;

  (* GL_ARB_shader_atomic_counters *)
  glGetActiveAtomicCounterBufferiv- : TglGetActiveAtomicCounterBufferiv;

  (* GL_ARB_shader_image_load_store *)
  glBindImageTexture- : TglBindImageTexture;
  glMemoryBarrier- : TglMemoryBarrier;

  (* GL_ARB_texture_storage *)
  glTexStorage1D- : TglTexStorage1D;
  glTexStorage2D- : TglTexStorage2D;
  glTexStorage3D- : TglTexStorage3D;
  glTextureStorage1DEXT- : TglTextureStorage1DEXT;
  glTextureStorage2DEXT- : TglTextureStorage2DEXT;
  glTextureStorage3DEXT- : TglTextureStorage3DEXT;
  (* * *)

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

(******************************************************)
 (*  GL_PGI_misc_hints *)
  glHintPGI- :  TglHintPGI;

  (*  GL_SGIS_detail_texture *)
  glDetailTexFuncSGIS- :  TglDetailTexFuncSGIS;
  glGetDetailTexFuncSGIS- :  TglGetDetailTexFuncSGIS;

  (*  GL_SGIS_fog_function *)
  glFogFuncSGIS- :  TglFogFuncSGIS;
  glGetFogFuncSGIS- :  TglGetFogFuncSGIS;

  (*  GL_SGIS_multisample *)
  glSampleMaskSGIS- :  TglSampleMaskSGIS;
  glSamplePatternSGIS- :  TglSamplePatternSGIS;

  (*  GL_SGIS_pixel_texture *)
  glPixelTexGenParameteriSGIS- :  TglPixelTexGenParameteriSGIS;
  glPixelTexGenParameterivSGIS- :  TglPixelTexGenParameterivSGIS;
  glPixelTexGenParameterfSGIS- :  TglPixelTexGenParameterfSGIS;
  glPixelTexGenParameterfvSGIS- :  TglPixelTexGenParameterfvSGIS;
  glGetPixelTexGenParameterivSGIS- :  TglGetPixelTexGenParameterivSGIS;
  glGetPixelTexGenParameterfvSGIS- :  TglGetPixelTexGenParameterfvSGIS;

  (*  GL_SGIS_point_parameters *)
  glPointParameterfSGIS- :  TglPointParameterfSGIS;
  glPointParameterfvSGIS- :  TglPointParameterfvSGIS;

  (*  GL_SGIS_sharpen_texture *)
  glSharpenTexFuncSGIS- :  TglSharpenTexFuncSGIS;
  glGetSharpenTexFuncSGIS- :  TglGetSharpenTexFuncSGIS;

  (*  GL_SGIS_texture4D *)
  glTexImage4DSGIS- :  TglTexImage4DSGIS;
  glTexSubImage4DSGIS- :  TglTexSubImage4DSGIS;

  (*  GL_SGIS_texture_color_mask *)
  glTextureColorMaskSGIS- :  TglTextureColorMaskSGIS;

  (*  GL_SGIS_texture_filter4 *)
  glGetTexFilterFuncSGIS- :  TglGetTexFilterFuncSGIS;
  glTexFilterFuncSGIS- :  TglTexFilterFuncSGIS;

  (*  GL_SGIX_async *)
  glAsyncMarkerSGIX- :  TglAsyncMarkerSGIX;
  glFinishAsyncSGIX- :  TglFinishAsyncSGIX;
  glPollAsyncSGIX- :  TglPollAsyncSGIX;
  glGenAsyncMarkersSGIX- :  TglGenAsyncMarkersSGIX;
  glDeleteAsyncMarkersSGIX- :  TglDeleteAsyncMarkersSGIX;
  glIsAsyncMarkerSGIX- :  TglIsAsyncMarkerSGIX;

  (*  GL_SGIX_flush_raster *)
  glFlushRasterSGIX- :  TglFlushRasterSGIX;

  (*  GL_SGIX_fragment_lighting *)
  glFragmentColorMaterialSGIX- :  TglFragmentColorMaterialSGIX;
  glFragmentLightfSGIX- :  TglFragmentLightfSGIX;
  glFragmentLightfvSGIX- :  TglFragmentLightfvSGIX;
  glFragmentLightiSGIX- :  TglFragmentLightiSGIX;
  glFragmentLightivSGIX- :  TglFragmentLightivSGIX;
  glFragmentLightModelfSGIX- :  TglFragmentLightModelfSGIX;
  glFragmentLightModelfvSGIX- :  TglFragmentLightModelfvSGIX;
  glFragmentLightModeliSGIX- :  TglFragmentLightModeliSGIX;
  glFragmentLightModelivSGIX- :  TglFragmentLightModelivSGIX;
  glFragmentMaterialfSGIX- :  TglFragmentMaterialfSGIX;
  glFragmentMaterialfvSGIX- :  TglFragmentMaterialfvSGIX;
  glFragmentMaterialiSGIX- :  TglFragmentMaterialiSGIX;
  glFragmentMaterialivSGIX- :  TglFragmentMaterialivSGIX;
  glGetFragmentLightfvSGIX- :  TglGetFragmentLightfvSGIX;
  glGetFragmentLightivSGIX- :  TglGetFragmentLightivSGIX;
  glGetFragmentMaterialfvSGIX- :  TglGetFragmentMaterialfvSGIX;
  glGetFragmentMaterialivSGIX- :  TglGetFragmentMaterialivSGIX;
  glLightEnviSGIX- :  TglLightEnviSGIX;

  (*  GL_SGIX_framezoom *)
  glFrameZoomSGIX- :  TglFrameZoomSGIX;

  (*  GL_SGIX_igloo_interface *)
  glIglooInterfaceSGIX- :  TglIglooInterfaceSGIX;

  (*  GL_SGIX_instruments *)
  glGetInstrumentsSGIX- :  TglGetInstrumentsSGIX;
  glInstrumentsBufferSGIX- :  TglInstrumentsBufferSGIX;
  glPollInstrumentsSGIX- :  TglPollInstrumentsSGIX;
  glReadInstrumentsSGIX- :  TglReadInstrumentsSGIX;
  glStartInstrumentsSGIX- :  TglStartInstrumentsSGIX;
  glStopInstrumentsSGIX- :  TglStopInstrumentsSGIX;

  (*  GL_SGIX_list_priority *)
  glGetListParameterfvSGIX- :  TglGetListParameterfvSGIX;
  glGetListParameterivSGIX- :  TglGetListParameterivSGIX;
  glListParameterfSGIX- :  TglListParameterfSGIX;
  glListParameterfvSGIX- :  TglListParameterfvSGIX;
  glListParameteriSGIX- :  TglListParameteriSGIX;
  glListParameterivSGIX- :  TglListParameterivSGIX;

  (*  GL_SGIX_pixel_texture *)
  glPixelTexGenSGIX- :  TglPixelTexGenSGIX;

  (*  GL_SGIX_polynomial_ffd *)
  glDeformationMap3dSGIX- :  TglDeformationMap3dSGIX;
  glDeformationMap3fSGIX- :  TglDeformationMap3fSGIX;
  glDeformSGIX- :  TglDeformSGIX;
  glLoadIdentityDeformationMapSGIX- :  TglLoadIdentityDeformationMapSGIX;

  (*  GL_SGIX_reference_plane *)
  glReferencePlaneSGIX- :  TglReferencePlaneSGIX;

  (*  GL_SGIX_sprite *)
  glSpriteParameterfSGIX- :  TglSpriteParameterfSGIX;
  glSpriteParameterfvSGIX- :  TglSpriteParameterfvSGIX;
  glSpriteParameteriSGIX- :  TglSpriteParameteriSGIX;
  glSpriteParameterivSGIX- :  TglSpriteParameterivSGIX;

  (*  GL_SGIX_tag_sample_buffer *)
  glTagSampleBufferSGIX- :  TglTagSampleBufferSGIX;

  (*  GL_SGI_color_table *)
  glColorTableSGI- :  TglColorTableSGI;
  glColorTableParameterfvSGI- :  TglColorTableParameterfvSGI;
  glColorTableParameterivSGI- :  TglColorTableParameterivSGI;
  glCopyColorTableSGI- :  TglCopyColorTableSGI;
  glGetColorTableSGI- :  TglGetColorTableSGI;
  glGetColorTableParameterfvSGI- :  TglGetColorTableParameterfvSGI;
  glGetColorTableParameterivSGI- :  TglGetColorTableParameterivSGI;

  (*  GL_SUNX_constant_data *)
  glFinishTextureSUNX- :  TglFinishTextureSUNX;

  (*  GL_SUN_global_alpha *)
  glGlobalAlphaFactorbSUN- :  TglGlobalAlphaFactorbSUN;
  glGlobalAlphaFactorsSUN- :  TglGlobalAlphaFactorsSUN;
  glGlobalAlphaFactoriSUN- :  TglGlobalAlphaFactoriSUN;
  glGlobalAlphaFactorfSUN- :  TglGlobalAlphaFactorfSUN;
  glGlobalAlphaFactordSUN- :  TglGlobalAlphaFactordSUN;
  glGlobalAlphaFactorubSUN- :  TglGlobalAlphaFactorubSUN;
  glGlobalAlphaFactorusSUN- :  TglGlobalAlphaFactorusSUN;
  glGlobalAlphaFactoruiSUN- :  TglGlobalAlphaFactoruiSUN;

  (*  GL_SUN_mesh_array *)
  glDrawMeshArraysSUN- :  TglDrawMeshArraysSUN;

  (*  GL_SUN_triangle_list *)
  glReplacementCodeuiSUN- :  TglReplacementCodeuiSUN;
  glReplacementCodeusSUN- :  TglReplacementCodeusSUN;
  glReplacementCodeubSUN- :  TglReplacementCodeubSUN;
  glReplacementCodeuivSUN- :  TglReplacementCodeuivSUN;
  glReplacementCodeusvSUN- :  TglReplacementCodeusvSUN;
  glReplacementCodeubvSUN- :  TglReplacementCodeubvSUN;
  glReplacementCodePointerSUN- :  TglReplacementCodePointerSUN;

  (*  GL_SUN_vertex *)
  glColor4ubVertex2fSUN- :  TglColor4ubVertex2fSUN;
  glColor4ubVertex2fvSUN- :  TglColor4ubVertex2fvSUN;
  glColor4ubVertex3fSUN- :  TglColor4ubVertex3fSUN;
  glColor4ubVertex3fvSUN- :  TglColor4ubVertex3fvSUN;
  glColor3fVertex3fSUN- :  TglColor3fVertex3fSUN;
  glColor3fVertex3fvSUN- :  TglColor3fVertex3fvSUN;
  glNormal3fVertex3fSUN- :  TglNormal3fVertex3fSUN;
  glNormal3fVertex3fvSUN- :  TglNormal3fVertex3fvSUN;
  glColor4fNormal3fVertex3fSUN- :  TglColor4fNormal3fVertex3fSUN;
  glColor4fNormal3fVertex3fvSUN- :  TglColor4fNormal3fVertex3fvSUN;
  glTexCoord2fVertex3fSUN- :  TglTexCoord2fVertex3fSUN;
  glTexCoord2fVertex3fvSUN- :  TglTexCoord2fVertex3fvSUN;
  glTexCoord4fVertex4fSUN- :  TglTexCoord4fVertex4fSUN;
  glTexCoord4fVertex4fvSUN- :  TglTexCoord4fVertex4fvSUN;
  glTexCoord2fColor4ubVertex3fSUN- :  TglTexCoord2fColor4ubVertex3fSUN;
  glTexCoord2fColor4ubVertex3fvSUN- :  TglTexCoord2fColor4ubVertex3fvSUN;
  glTexCoord2fColor3fVertex3fSUN- :  TglTexCoord2fColor3fVertex3fSUN;
  glTexCoord2fColor3fVertex3fvSUN- :  TglTexCoord2fColor3fVertex3fvSUN;
  glTexCoord2fNormal3fVertex3fSUN- :  TglTexCoord2fNormal3fVertex3fSUN;
  glTexCoord2fNormal3fVertex3fvSUN- :  TglTexCoord2fNormal3fVertex3fvSUN;
  glTexCoord2fColor4fNormal3fVertex3fSUN- :  TglTexCoord2fColor4fNormal3fVertex3fSUN;
  glTexCoord2fColor4fNormal3fVertex3fvSUN- :  TglTexCoord2fColor4fNormal3fVertex3fvSUN;
  glTexCoord4fColor4fNormal3fVertex4fSUN- :  TglTexCoord4fColor4fNormal3fVertex4fSUN;
  glTexCoord4fColor4fNormal3fVertex4fvSUN- :  TglTexCoord4fColor4fNormal3fVertex4fvSUN;
  glReplacementCodeuiVertex3fSUN- :  TglReplacementCodeuiVertex3fSUN;
  glReplacementCodeuiVertex3fvSUN- :  TglReplacementCodeuiVertex3fvSUN;
  glReplacementCodeuiColor4ubVertex3fSUN- :  TglReplacementCodeuiColor4ubVertex3fSUN;
  glReplacementCodeuiColor4ubVertex3fvSUN- :  TglReplacementCodeuiColor4ubVertex3fvSUN;
  glReplacementCodeuiColor3fVertex3fSUN- :  TglReplacementCodeuiColor3fVertex3fSUN;
  glReplacementCodeuiColor3fVertex3fvSUN- :  TglReplacementCodeuiColor3fVertex3fvSUN;
  glReplacementCodeuiNormal3fVertex3fSUN- :  TglReplacementCodeuiNormal3fVertex3fSUN;
  glReplacementCodeuiNormal3fVertex3fvSUN- :  TglReplacementCodeuiNormal3fVertex3fvSUN;
  glReplacementCodeuiColor4fNormal3fVertex3fSUN- :  TglReplacementCodeuiColor4fNormal3fVertex3fSUN;
  glReplacementCodeuiColor4fNormal3fVertex3fvSUN- :  TglReplacementCodeuiColor4fNormal3fVertex3fvSUN;
  glReplacementCodeuiTexCoord2fVertex3fSUN- :  TglReplacementCodeuiTexCoord2fVertex3fSUN;
  glReplacementCodeuiTexCoord2fVertex3fvSUN- :  TglReplacementCodeuiTexCoord2fVertex3fvSUN;
  glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN- :  TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN;
  glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN- :  TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN;
  glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN- :  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN;
  glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN- :  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN;

(******************************************************)

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


   (** wrapper procedure *)
  PROCEDURE GetProcAddress*(CONST funcName: ARRAY OF CHAR): ADDRESS;
  VAR address: ADDRESS;
  BEGIN
  	  	Kernel32.GetProcAddress(GL_LibHandle, funcName, address);
	  	IF (address = 0) & (wglGetProcAddress # NIL) THEN
			address := wglGetProcAddress(funcName);
		END;
	RETURN address;
  END GetProcAddress;

PROCEDURE InitOpenGL*;
VAR
  name: ARRAY 64 OF CHAR;
BEGIN {EXCLUSIVE}
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

END InitOpenGL;


PROCEDURE ReadOpenGLCore*;
BEGIN

(*! GL_VERSION_1_0*)
   glCullFace := SYSTEM.VAL(TglCullFace , GetProcAddress('glCullFace')  );
   glFrontFace := SYSTEM.VAL(TglFrontFace , GetProcAddress('glFrontFace')  );
   glHint := SYSTEM.VAL(TglHint , GetProcAddress('glHint')  );
   glLineWidth := SYSTEM.VAL(TglLineWidth , GetProcAddress('glLineWidth')  );
   glPointSize := SYSTEM.VAL(TglPointSize , GetProcAddress('glPointSize')  );
   glPolygonMode := SYSTEM.VAL(TglPolygonMode , GetProcAddress('glPolygonMode')  );
   glScissor := SYSTEM.VAL(TglScissor , GetProcAddress('glScissor')  );
   glTexParameterf := SYSTEM.VAL(TglTexParameterf , GetProcAddress('glTexParameterf')  );
   glTexParameterfv := SYSTEM.VAL(TglTexParameterfv , GetProcAddress('glTexParameterfv')  );
   glTexParameteri := SYSTEM.VAL(TglTexParameteri , GetProcAddress('glTexParameteri')  );
   glTexParameteriv := SYSTEM.VAL(TglTexParameteriv , GetProcAddress('glTexParameteriv')  );
   glTexImage1D := SYSTEM.VAL(TglTexImage1D , GetProcAddress('glTexImage1D')  );
   glTexImage2D := SYSTEM.VAL(TglTexImage2D , GetProcAddress('glTexImage2D')  );
   glDrawBuffer:= SYSTEM.VAL(TglDrawBuffer , GetProcAddress('glDrawBuffer')  );
   glClear := SYSTEM.VAL(TglClear , GetProcAddress('glClear')  );
   glClearColor := SYSTEM.VAL(TglClearColor , GetProcAddress('glClearColor')  );
   glClearStencil := SYSTEM.VAL(TglClearStencil , GetProcAddress('glClearStencil')  );
   glClearDepth := SYSTEM.VAL(TglClearDepth , GetProcAddress('glClearDepth')  );
   glStencilMask := SYSTEM.VAL(TglStencilMask , GetProcAddress('glStencilMask')  );
   glColorMask := SYSTEM.VAL(TglColorMask , GetProcAddress('glColorMask')  );
   glDepthMask := SYSTEM.VAL(TglDepthMask , GetProcAddress('glDepthMask')  );
   glDisable := SYSTEM.VAL(TglDisable , GetProcAddress('glDisable')  );
   glEnable := SYSTEM.VAL(TglEnable , GetProcAddress('glEnable')  );
   glFinish := SYSTEM.VAL(TglFinish , GetProcAddress('glFinish')  );
   glFlush := SYSTEM.VAL(TglFlush , GetProcAddress('glFlush')  );
   glBlendFunc := SYSTEM.VAL(TglBlendFunc , GetProcAddress('glBlendFunc')  );
   glLogicOp := SYSTEM.VAL(TglLogicOp , GetProcAddress('glLogicOp')  );
   glStencilFunc := SYSTEM.VAL(TglStencilFunc , GetProcAddress('glStencilFunc')  );
   glStencilOp := SYSTEM.VAL(TglStencilOp , GetProcAddress('glStencilOp')  );
   glDepthFunc := SYSTEM.VAL(TglDepthFunc , GetProcAddress('glDepthFunc')  );
   glPixelStoref := SYSTEM.VAL(TglPixelStoref , GetProcAddress('glPixelStoref')  );
   glPixelStorei := SYSTEM.VAL(TglPixelStorei , GetProcAddress('glPixelStorei')  );
   glReadBuffer := SYSTEM.VAL(TglReadBuffer , GetProcAddress('glReadBuffer')  );
   glReadPixels := SYSTEM.VAL(TglReadPixels , GetProcAddress('glReadPixels')  );
   glGetBooleanv := SYSTEM.VAL(TglGetBooleanv , GetProcAddress('glGetBooleanv')  );
   glGetDoublev := SYSTEM.VAL(TglGetDoublev , GetProcAddress('glGetDoublev')  );
   glGetError := SYSTEM.VAL(TglGetError , GetProcAddress('glGetError')  );
   glGetFloatv := SYSTEM.VAL(TglGetFloatv , GetProcAddress('glGetFloatv')  );
   glGetIntegerv := SYSTEM.VAL(TglGetIntegerv , GetProcAddress('glGetIntegerv')  );
   glGetString := SYSTEM.VAL(TglGetString , GetProcAddress('glGetString')  );
   glGetTexImage := SYSTEM.VAL(TglGetTexImage , GetProcAddress('glGetTexImage')  );
   glGetTexParameteriv:= SYSTEM.VAL(TglGetTexParameteriv , GetProcAddress('glGetTexParameteriv')  );
   glGetTexParameterfv := SYSTEM.VAL(TglGetTexParameterfv , GetProcAddress('glGetTexParameterfv')  );
   glGetTexLevelParameterfv := SYSTEM.VAL(TglGetTexLevelParameterfv , GetProcAddress('glGetTexLevelParameterfv')  );
   glGetTexLevelParameteriv := SYSTEM.VAL(TglGetTexLevelParameteriv , GetProcAddress('glGetTexLevelParameteriv')  );
   glIsEnabled := SYSTEM.VAL(TglIsEnabled , GetProcAddress('glIsEnabled')  );
   glDepthRange := SYSTEM.VAL(TglDepthRange , GetProcAddress('glDepthRange')  );
   glViewport := SYSTEM.VAL(TglViewport , GetProcAddress('glViewport')  );

  (*! GL_VERSION_1_1*)
   glDrawArrays:= SYSTEM.VAL(TglDrawArrays , GetProcAddress('glDrawArrays')  );
   glDrawElements := SYSTEM.VAL(TglDrawElements , GetProcAddress('glDrawElements')  );
   glGetPointerv := SYSTEM.VAL(TglGetPointerv , GetProcAddress('glGetPointerv')  );
   glPolygonOffset:= SYSTEM.VAL(TglPolygonOffset , GetProcAddress('glPolygonOffset')  );
   glCopyTexImage1D := SYSTEM.VAL(TglCopyTexImage1D , GetProcAddress('glCopyTexImage1D')  );
   glCopyTexImage2D := SYSTEM.VAL(TglCopyTexImage2D , GetProcAddress('glCopyTexImage2D') );
   glCopyTexSubImage1D := SYSTEM.VAL(TglCopyTexSubImage1D , GetProcAddress('glCopyTexSubImage1D'));
   glCopyTexSubImage2D := SYSTEM.VAL(TglCopyTexSubImage2D , GetProcAddress('glCopyTexSubImage2D'));
   glTexSubImage1D := SYSTEM.VAL(TglTexSubImage1D , GetProcAddress('glTexSubImage1D')  );
   glTexSubImage2D := SYSTEM.VAL(TglTexSubImage2D , GetProcAddress('glTexSubImage2D')  );
   glBindTexture := SYSTEM.VAL(TglBindTexture , GetProcAddress('glBindTexture')  );
   glDeleteTextures:= SYSTEM.VAL(TglDeleteTextures , GetProcAddress('glDeleteTextures')  );
   glGenTextures := SYSTEM.VAL(TglGenTextures , GetProcAddress('glGenTextures')  );

(*! ifdef DEPRECATED *)
   glAccum := SYSTEM.VAL(TglAccum , GetProcAddress('glAccum') );
    glAlphaFunc := SYSTEM.VAL(TglAlphaFunc , GetProcAddress('glAlphaFunc') );
    glAreTexturesResident := SYSTEM.VAL(TglAreTexturesResident , GetProcAddress('glAreTexturesResident') );
    glArrayElement := SYSTEM.VAL(TglArrayElement , GetProcAddress('glArrayElement') );
    glBegin := SYSTEM.VAL(TglBegin , GetProcAddress('glBegin') );
    glBitmap := SYSTEM.VAL(TglBitmap , GetProcAddress('glBitmap') );
    glCallList := SYSTEM.VAL(TglCallList , GetProcAddress('glCallList') );
    glCallLists := SYSTEM.VAL(TglCallLists , GetProcAddress('glCallLists') );
    glClearAccum := SYSTEM.VAL(TglClearAccum , GetProcAddress('glClearAccum') );
    glClearIndex := SYSTEM.VAL(TglClearIndex , GetProcAddress('glClearIndex') );
    glClipPlane := SYSTEM.VAL(TglClipPlane , GetProcAddress('glClipPlane') );
    glColor3b := SYSTEM.VAL(TglColor3b , GetProcAddress('glColor3b') );
    glColor3bv := SYSTEM.VAL(TglColor3bv , GetProcAddress('glColor3bv') );
    glColor3d := SYSTEM.VAL(TglColor3d , GetProcAddress('glColor3d') );
    glColor3dv := SYSTEM.VAL(TglColor3dv , GetProcAddress('glColor3dv') );
    glColor3f := SYSTEM.VAL(TglColor3f , GetProcAddress('glColor3f') );
    glColor3fv := SYSTEM.VAL(TglColor3fv , GetProcAddress('glColor3fv') );
    glColor3i := SYSTEM.VAL(TglColor3i , GetProcAddress('glColor3i') );
    glColor3iv := SYSTEM.VAL(TglColor3iv , GetProcAddress('glColor3iv') );
    glColor3s := SYSTEM.VAL(TglColor3s , GetProcAddress('glColor3s') );
    glColor3sv := SYSTEM.VAL(TglColor3sv , GetProcAddress('glColor3sv') );
    glColor3ub := SYSTEM.VAL(TglColor3ub , GetProcAddress('glColor3ub') );
    glColor3ubv := SYSTEM.VAL(TglColor3ubv , GetProcAddress('glColor3ubv') );
    glColor3ui := SYSTEM.VAL(TglColor3ui , GetProcAddress('glColor3ui') );
    glColor3uiv := SYSTEM.VAL(TglColor3uiv , GetProcAddress('glColor3uiv') );
    glColor3us := SYSTEM.VAL(TglColor3us , GetProcAddress('glColor3us') );
    glColor3usv := SYSTEM.VAL(TglColor3usv , GetProcAddress('glColor3usv') );
    glColor4b := SYSTEM.VAL(TglColor4b , GetProcAddress('glColor4b') );
    glColor4bv := SYSTEM.VAL(TglColor4bv , GetProcAddress('glColor4bv') );
    glColor4d := SYSTEM.VAL(TglColor4d , GetProcAddress('glColor4d') );
    glColor4dv := SYSTEM.VAL(TglColor4dv , GetProcAddress('glColor4dv') );
	glColor4f := SYSTEM.VAL(TglColor4f, GetProcAddress('glColor4f'));
	glColor4fv := SYSTEM.VAL(TglColor4fv, GetProcAddress('glColor4fv'));
	glColor4i := SYSTEM.VAL(TglColor4i, GetProcAddress('glColor4i'));
	glColor4iv := SYSTEM.VAL(TglColor4iv, GetProcAddress('glColor4iv'));
	glColor4s := SYSTEM.VAL(TglColor4s, GetProcAddress('glColor4s'));
	glColor4sv := SYSTEM.VAL(TglColor4sv, GetProcAddress('glColor4sv'));
	glColor4ub := SYSTEM.VAL(TglColor4ub, GetProcAddress('glColor4ub'));
	glColor4ubv := SYSTEM.VAL(TglColor4ubv, GetProcAddress('glColor4ubv'));
	glColor4ui := SYSTEM.VAL(TglColor4ui, GetProcAddress('glColor4ui'));
	glColor4uiv := SYSTEM.VAL(TglColor4uiv, GetProcAddress('glColor4uiv'));
	glColor4us := SYSTEM.VAL(TglColor4us, GetProcAddress('glColor4us'));
	glColor4usv := SYSTEM.VAL(TglColor4usv, GetProcAddress('glColor4usv'));
	glColorMaterial := SYSTEM.VAL(TglColorMaterial, GetProcAddress('glColorMaterial'));
	glColorPointer := SYSTEM.VAL(TglColorPointer, GetProcAddress('glColorPointer'));
	glCopyPixels := SYSTEM.VAL(TglCopyPixels, GetProcAddress('glCopyPixels'));
	glDeleteLists := SYSTEM.VAL(TglDeleteLists, GetProcAddress('glDeleteLists'));
	glDisableClientState := SYSTEM.VAL(TglDisableClientState, GetProcAddress('glDisableClientState'));
	glDrawPixels := SYSTEM.VAL(TglDrawPixels, GetProcAddress('glDrawPixels'));
	glEdgeFlag := SYSTEM.VAL(TglEdgeFlag, GetProcAddress('glEdgeFlag'));
	glEdgeFlagPointer := SYSTEM.VAL(TglEdgeFlagPointer, GetProcAddress('glEdgeFlagPointer'));
	glEdgeFlagv := SYSTEM.VAL(TglEdgeFlagv, GetProcAddress('glEdgeFlagv'));
	glEnableClientState := SYSTEM.VAL(TglEnableClientState, GetProcAddress('glEnableClientState'));
	glEnd := SYSTEM.VAL(TglEnd, GetProcAddress('glEnd'));
	glEndList := SYSTEM.VAL(TglEndList, GetProcAddress('glEndList'));
	glEvalCoord1d := SYSTEM.VAL(TglEvalCoord1d, GetProcAddress('glEvalCoord1d'));
	glEvalCoord1dv := SYSTEM.VAL(TglEvalCoord1dv, GetProcAddress('glEvalCoord1dv'));
	glEvalCoord1f := SYSTEM.VAL(TglEvalCoord1f, GetProcAddress('glEvalCoord1f'));
	glEvalCoord1fv := SYSTEM.VAL(TglEvalCoord1fv, GetProcAddress('glEvalCoord1fv'));
	glEvalCoord2d := SYSTEM.VAL(TglEvalCoord2d, GetProcAddress('glEvalCoord2d'));
	glEvalCoord2dv := SYSTEM.VAL(TglEvalCoord2dv, GetProcAddress('glEvalCoord2dv'));
	glEvalCoord2f := SYSTEM.VAL(TglEvalCoord2f, GetProcAddress('glEvalCoord2f'));
	glEvalCoord2fv := SYSTEM.VAL(TglEvalCoord2fv, GetProcAddress('glEvalCoord2fv'));
	glEvalMesh1 := SYSTEM.VAL(TglEvalMesh1, GetProcAddress('glEvalMesh1'));
	glEvalMesh2 := SYSTEM.VAL(TglEvalMesh2, GetProcAddress('glEvalMesh2'));
	glEvalPoint1 := SYSTEM.VAL(TglEvalPoint1, GetProcAddress('glEvalPoint1'));
	glEvalPoint2 := SYSTEM.VAL(TglEvalPoint2, GetProcAddress('glEvalPoint2'));
	glFeedbackBuffer := SYSTEM.VAL(TglFeedbackBuffer, GetProcAddress('glFeedbackBuffer'));
	glFogf := SYSTEM.VAL(TglFogf, GetProcAddress('glFogf'));
	glFogfv := SYSTEM.VAL(TglFogfv, GetProcAddress('glFogfv'));
	glFogi := SYSTEM.VAL(TglFogi, GetProcAddress('glFogi'));
	glFogiv := SYSTEM.VAL(TglFogiv, GetProcAddress('glFogiv'));
	glFrustum := SYSTEM.VAL(TglFrustum, GetProcAddress('glFrustum'));
	glGenLists := SYSTEM.VAL(TglGenLists, GetProcAddress('glGenLists'));
	glGetClipPlane := SYSTEM.VAL(TglGetClipPlane, GetProcAddress('glGetClipPlane'));
	glGetLightfv := SYSTEM.VAL(TglGetLightfv, GetProcAddress('glGetLightfv'));
	glGetLightiv := SYSTEM.VAL(TglGetLightiv, GetProcAddress('glGetLightiv'));
	glGetMapdv := SYSTEM.VAL(TglGetMapdv, GetProcAddress('glGetMapdv'));
	glGetMapfv := SYSTEM.VAL(TglGetMapfv, GetProcAddress('glGetMapfv'));
	glGetMapiv := SYSTEM.VAL(TglGetMapiv, GetProcAddress('glGetMapiv'));
	glGetMaterialfv := SYSTEM.VAL(TglGetMaterialfv, GetProcAddress('glGetMaterialfv'));
	glGetMaterialiv := SYSTEM.VAL(TglGetMaterialiv, GetProcAddress('glGetMaterialiv'));
	glGetPixelMapfv := SYSTEM.VAL(TglGetPixelMapfv, GetProcAddress('glGetPixelMapfv'));
	glGetPixelMapuiv := SYSTEM.VAL(TglGetPixelMapuiv, GetProcAddress('glGetPixelMapuiv'));
	glGetPixelMapusv := SYSTEM.VAL(TglGetPixelMapusv, GetProcAddress('glGetPixelMapusv'));
	glGetPolygonStipple := SYSTEM.VAL(TglGetPolygonStipple, GetProcAddress('glGetPolygonStipple'));
	glGetTexEnvfv := SYSTEM.VAL(TglGetTexEnvfv, GetProcAddress('glGetTexEnvfv'));
	glGetTexEnviv := SYSTEM.VAL(TglGetTexEnviv, GetProcAddress('glGetTexEnviv'));
	glGetTexGendv := SYSTEM.VAL(TglGetTexGendv, GetProcAddress('glGetTexGendv'));
	glGetTexGenfv := SYSTEM.VAL(TglGetTexGenfv, GetProcAddress('glGetTexGenfv'));
	glGetTexGeniv := SYSTEM.VAL(TglGetTexGeniv, GetProcAddress('glGetTexGeniv'));
	glIndexMask := SYSTEM.VAL(TglIndexMask, GetProcAddress('glIndexMask'));
	glIndexPointer := SYSTEM.VAL(TglIndexPointer, GetProcAddress('glIndexPointer'));
	glIndexd := SYSTEM.VAL(TglIndexd, GetProcAddress('glIndexd'));
	glIndexdv := SYSTEM.VAL(TglIndexdv, GetProcAddress('glIndexdv'));
	glIndexf := SYSTEM.VAL(TglIndexf, GetProcAddress('glIndexf'));
	glIndexfv := SYSTEM.VAL(TglIndexfv, GetProcAddress('glIndexfv'));
	glIndexi := SYSTEM.VAL(TglIndexi, GetProcAddress('glIndexi'));
	glIndexiv := SYSTEM.VAL(TglIndexiv, GetProcAddress('glIndexiv'));
	glIndexs := SYSTEM.VAL(TglIndexs, GetProcAddress('glIndexs'));
	glIndexsv := SYSTEM.VAL(TglIndexsv, GetProcAddress('glIndexsv'));
	glIndexub := SYSTEM.VAL(TglIndexub, GetProcAddress('glIndexub'));
	glIndexubv := SYSTEM.VAL(TglIndexubv, GetProcAddress('glIndexubv'));
	glInitNames := SYSTEM.VAL(TglInitNames, GetProcAddress('glInitNames'));
	glInterleavedArrays := SYSTEM.VAL(TglInterleavedArrays, GetProcAddress('glInterleavedArrays'));
	glIsList := SYSTEM.VAL(TglIsList, GetProcAddress('glIsList'));
	glIsTexture := SYSTEM.VAL(TglIsTexture, GetProcAddress('glIsTexture'));
	glLightModelf := SYSTEM.VAL(TglLightModelf, GetProcAddress('glLightModelf'));
	glLightModelfv := SYSTEM.VAL(TglLightModelfv, GetProcAddress('glLightModelfv'));
	glLightModeli := SYSTEM.VAL(TglLightModeli, GetProcAddress('glLightModeli'));
	glLightModeliv := SYSTEM.VAL(TglLightModeliv, GetProcAddress('glLightModeliv'));
	glLightf := SYSTEM.VAL(TglLightf, GetProcAddress('glLightf'));
	glLightfv := SYSTEM.VAL(TglLightfv, GetProcAddress('glLightfv'));
	glLighti := SYSTEM.VAL(TglLighti, GetProcAddress('glLighti'));
	glLightiv := SYSTEM.VAL(TglLightiv, GetProcAddress('glLightiv'));
	glLineStipple := SYSTEM.VAL(TglLineStipple, GetProcAddress('glLineStipple'));
	glListBase := SYSTEM.VAL(TglListBase, GetProcAddress('glListBase'));
	glLoadIdentity := SYSTEM.VAL(TglLoadIdentity, GetProcAddress('glLoadIdentity'));
	glLoadMatrixd := SYSTEM.VAL(TglLoadMatrixd, GetProcAddress('glLoadMatrixd'));
	glLoadMatrixf := SYSTEM.VAL(TglLoadMatrixf, GetProcAddress('glLoadMatrixf'));
	glLoadName := SYSTEM.VAL(TglLoadName, GetProcAddress('glLoadName'));
	glMap1d := SYSTEM.VAL(TglMap1d, GetProcAddress('glMap1d'));
	glMap1f := SYSTEM.VAL(TglMap1f, GetProcAddress('glMap1f'));
	glMap2d := SYSTEM.VAL(TglMap2d, GetProcAddress('glMap2d'));
	glMap2f := SYSTEM.VAL(TglMap2f, GetProcAddress('glMap2f'));
	glMapGrid1d := SYSTEM.VAL(TglMapGrid1d, GetProcAddress('glMapGrid1d'));
	glMapGrid1f := SYSTEM.VAL(TglMapGrid1f, GetProcAddress('glMapGrid1f'));
	glMapGrid2d := SYSTEM.VAL(TglMapGrid2d, GetProcAddress('glMapGrid2d'));
	glMapGrid2f := SYSTEM.VAL(TglMapGrid2f, GetProcAddress('glMapGrid2f'));
	glMaterialf := SYSTEM.VAL(TglMaterialf, GetProcAddress('glMaterialf'));
	glMaterialfv := SYSTEM.VAL(TglMaterialfv, GetProcAddress('glMaterialfv'));
	glMateriali := SYSTEM.VAL(TglMateriali, GetProcAddress('glMateriali'));
	glMaterialiv := SYSTEM.VAL(TglMaterialiv, GetProcAddress('glMaterialiv'));
	glMatrixMode := SYSTEM.VAL(TglMatrixMode, GetProcAddress('glMatrixMode'));
	glMultMatrixd := SYSTEM.VAL(TglMultMatrixd, GetProcAddress('glMultMatrixd'));
	glMultMatrixf := SYSTEM.VAL(TglMultMatrixf, GetProcAddress('glMultMatrixf'));
	glNewList := SYSTEM.VAL(TglNewList, GetProcAddress('glNewList'));
	glNormal3b := SYSTEM.VAL(TglNormal3b, GetProcAddress('glNormal3b'));
	glNormal3bv := SYSTEM.VAL(TglNormal3bv, GetProcAddress('glNormal3bv'));
	glNormal3d := SYSTEM.VAL(TglNormal3d, GetProcAddress('glNormal3d'));
	glNormal3dv := SYSTEM.VAL(TglNormal3dv, GetProcAddress('glNormal3dv'));
	glNormal3f := SYSTEM.VAL(TglNormal3f, GetProcAddress('glNormal3f'));
	glNormal3fv := SYSTEM.VAL(TglNormal3fv, GetProcAddress('glNormal3fv'));
	glNormal3i := SYSTEM.VAL(TglNormal3i, GetProcAddress('glNormal3i'));
	glNormal3iv := SYSTEM.VAL(TglNormal3iv, GetProcAddress('glNormal3iv'));
	glNormal3s := SYSTEM.VAL(TglNormal3s, GetProcAddress('glNormal3s'));
	glNormal3sv := SYSTEM.VAL(TglNormal3sv, GetProcAddress('glNormal3sv'));
	glNormalPointer := SYSTEM.VAL(TglNormalPointer, GetProcAddress('glNormalPointer'));
	glOrtho := SYSTEM.VAL(TglOrtho, GetProcAddress('glOrtho'));
	glPassThrough := SYSTEM.VAL(TglPassThrough, GetProcAddress('glPassThrough'));
	glPixelMapfv := SYSTEM.VAL(TglPixelMapfv, GetProcAddress('glPixelMapfv'));
	glPixelMapuiv := SYSTEM.VAL(TglPixelMapuiv, GetProcAddress('glPixelMapuiv'));
	glPixelMapusv := SYSTEM.VAL(TglPixelMapusv, GetProcAddress('glPixelMapusv'));
	glPixelTransferf := SYSTEM.VAL(TglPixelTransferf, GetProcAddress('glPixelTransferf'));
	glPixelTransferi := SYSTEM.VAL(TglPixelTransferi, GetProcAddress('glPixelTransferi'));
	glPixelZoom := SYSTEM.VAL(TglPixelZoom, GetProcAddress('glPixelZoom'));
	glPolygonStipple := SYSTEM.VAL(TglPolygonStipple, GetProcAddress('glPolygonStipple'));
	glPopAttrib := SYSTEM.VAL(TglPopAttrib, GetProcAddress('glPopAttrib'));
	glPopClientAttrib := SYSTEM.VAL(TglPopClientAttrib, GetProcAddress('glPopClientAttrib'));
	glPopMatrix := SYSTEM.VAL(TglPopMatrix, GetProcAddress('glPopMatrix'));
	glPopName := SYSTEM.VAL(TglPopName, GetProcAddress('glPopName'));
	glPrioritizeTextures := SYSTEM.VAL(TglPrioritizeTextures, GetProcAddress('glPrioritizeTextures'));
	glPushAttrib := SYSTEM.VAL(TglPushAttrib, GetProcAddress('glPushAttrib'));
	glPushClientAttrib := SYSTEM.VAL(TglPushClientAttrib, GetProcAddress('glPushClientAttrib'));
	glPushMatrix := SYSTEM.VAL(TglPushMatrix, GetProcAddress('glPushMatrix'));
	glPushName := SYSTEM.VAL(TglPushName, GetProcAddress('glPushName'));
	glRasterPos2d := SYSTEM.VAL(TglRasterPos2d, GetProcAddress('glRasterPos2d'));
	glRasterPos2dv := SYSTEM.VAL(TglRasterPos2dv, GetProcAddress('glRasterPos2dv'));
	glRasterPos2f := SYSTEM.VAL(TglRasterPos2f, GetProcAddress('glRasterPos2f'));
	glRasterPos2fv := SYSTEM.VAL(TglRasterPos2fv, GetProcAddress('glRasterPos2fv'));
	glRasterPos2i := SYSTEM.VAL(TglRasterPos2i, GetProcAddress('glRasterPos2i'));
	glRasterPos2iv := SYSTEM.VAL(TglRasterPos2iv, GetProcAddress('glRasterPos2iv'));
	glRasterPos2s := SYSTEM.VAL(TglRasterPos2s, GetProcAddress('glRasterPos2s'));
	glRasterPos2sv := SYSTEM.VAL(TglRasterPos2sv, GetProcAddress('glRasterPos2sv'));
	glRasterPos3d := SYSTEM.VAL(TglRasterPos3d, GetProcAddress('glRasterPos3d'));
	glRasterPos3dv := SYSTEM.VAL(TglRasterPos3dv, GetProcAddress('glRasterPos3dv'));
	glRasterPos3f := SYSTEM.VAL(TglRasterPos3f, GetProcAddress('glRasterPos3f'));
	glRasterPos3fv := SYSTEM.VAL(TglRasterPos3fv, GetProcAddress('glRasterPos3fv'));
	glRasterPos3i := SYSTEM.VAL(TglRasterPos3i, GetProcAddress('glRasterPos3i'));
	glRasterPos3iv := SYSTEM.VAL(TglRasterPos3iv, GetProcAddress('glRasterPos3iv'));
	glRasterPos3s := SYSTEM.VAL(TglRasterPos3s, GetProcAddress('glRasterPos3s'));
	glRasterPos3sv := SYSTEM.VAL(TglRasterPos3sv, GetProcAddress('glRasterPos3sv'));
	glRasterPos4d := SYSTEM.VAL(TglRasterPos4d, GetProcAddress('glRasterPos4d'));
	glRasterPos4dv := SYSTEM.VAL(TglRasterPos4dv, GetProcAddress('glRasterPos4dv'));
	glRasterPos4f := SYSTEM.VAL(TglRasterPos4f, GetProcAddress('glRasterPos4f'));
	glRasterPos4fv := SYSTEM.VAL(TglRasterPos4fv, GetProcAddress('glRasterPos4fv'));
	glRasterPos4i := SYSTEM.VAL(TglRasterPos4i, GetProcAddress('glRasterPos4i'));
	glRasterPos4iv := SYSTEM.VAL(TglRasterPos4iv, GetProcAddress('glRasterPos4iv'));
	glRasterPos4s := SYSTEM.VAL(TglRasterPos4s, GetProcAddress('glRasterPos4s'));
	glRasterPos4sv := SYSTEM.VAL(TglRasterPos4sv, GetProcAddress('glRasterPos4sv'));
	glRectd := SYSTEM.VAL(TglRectd, GetProcAddress('glRectd'));
	glRectdv := SYSTEM.VAL(TglRectdv, GetProcAddress('glRectdv'));
	glRectf := SYSTEM.VAL(TglRectf, GetProcAddress('glRectf'));
	glRectfv := SYSTEM.VAL(TglRectfv, GetProcAddress('glRectfv'));
	glRecti := SYSTEM.VAL(TglRecti, GetProcAddress('glRecti'));
	glRectiv := SYSTEM.VAL(TglRectiv, GetProcAddress('glRectiv'));
	glRects := SYSTEM.VAL(TglRects, GetProcAddress('glRects'));
	glRectsv := SYSTEM.VAL(TglRectsv, GetProcAddress('glRectsv'));
	glRenderMode := SYSTEM.VAL(TglRenderMode, GetProcAddress('glRenderMode'));
	glRotated := SYSTEM.VAL(TglRotated, GetProcAddress('glRotated'));
	glRotatef := SYSTEM.VAL(TglRotatef, GetProcAddress('glRotatef'));
	glScaled := SYSTEM.VAL(TglScaled, GetProcAddress('glScaled'));
	glScalef := SYSTEM.VAL(TglScalef, GetProcAddress('glScalef'));
	glSelectBuffer := SYSTEM.VAL(TglSelectBuffer, GetProcAddress('glSelectBuffer'));
	glShadeModel := SYSTEM.VAL(TglShadeModel, GetProcAddress('glShadeModel'));
	glTexCoord1d := SYSTEM.VAL(TglTexCoord1d, GetProcAddress('glTexCoord1d'));
	glTexCoord1dv := SYSTEM.VAL(TglTexCoord1dv, GetProcAddress('glTexCoord1dv'));
	glTexCoord1f := SYSTEM.VAL(TglTexCoord1f, GetProcAddress('glTexCoord1f'));
	glTexCoord1fv := SYSTEM.VAL(TglTexCoord1fv, GetProcAddress('glTexCoord1fv'));
	glTexCoord1i := SYSTEM.VAL(TglTexCoord1i, GetProcAddress('glTexCoord1i'));
	glTexCoord1iv := SYSTEM.VAL(TglTexCoord1iv, GetProcAddress('glTexCoord1iv'));
	glTexCoord1s := SYSTEM.VAL(TglTexCoord1s, GetProcAddress('glTexCoord1s'));
	glTexCoord1sv := SYSTEM.VAL(TglTexCoord1sv, GetProcAddress('glTexCoord1sv'));
	glTexCoord2d := SYSTEM.VAL(TglTexCoord2d, GetProcAddress('glTexCoord2d'));
	glTexCoord2dv := SYSTEM.VAL(TglTexCoord2dv, GetProcAddress('glTexCoord2dv'));
	glTexCoord2f := SYSTEM.VAL(TglTexCoord2f, GetProcAddress('glTexCoord2f'));
	glTexCoord2fv := SYSTEM.VAL(TglTexCoord2fv, GetProcAddress('glTexCoord2fv'));
	glTexCoord2i := SYSTEM.VAL(TglTexCoord2i, GetProcAddress('glTexCoord2i'));
	glTexCoord2iv := SYSTEM.VAL(TglTexCoord2iv, GetProcAddress('glTexCoord2iv'));
	glTexCoord2s := SYSTEM.VAL(TglTexCoord2s, GetProcAddress('glTexCoord2s'));
	glTexCoord2sv := SYSTEM.VAL(TglTexCoord2sv, GetProcAddress('glTexCoord2sv'));
	glTexCoord3d := SYSTEM.VAL(TglTexCoord3d, GetProcAddress('glTexCoord3d'));
	glTexCoord3dv := SYSTEM.VAL(TglTexCoord3dv, GetProcAddress('glTexCoord3dv'));
	glTexCoord3f := SYSTEM.VAL(TglTexCoord3f, GetProcAddress('glTexCoord3f'));
	glTexCoord3fv := SYSTEM.VAL(TglTexCoord3fv, GetProcAddress('glTexCoord3fv'));
	glTexCoord3i := SYSTEM.VAL(TglTexCoord3i, GetProcAddress('glTexCoord3i'));
	glTexCoord3iv := SYSTEM.VAL(TglTexCoord3iv, GetProcAddress('glTexCoord3iv'));
	glTexCoord3s := SYSTEM.VAL(TglTexCoord3s, GetProcAddress('glTexCoord3s'));
	glTexCoord3sv := SYSTEM.VAL(TglTexCoord3sv, GetProcAddress('glTexCoord3sv'));
	glTexCoord4d := SYSTEM.VAL(TglTexCoord4d, GetProcAddress('glTexCoord4d'));
	glTexCoord4dv := SYSTEM.VAL(TglTexCoord4dv, GetProcAddress('glTexCoord4dv'));
	glTexCoord4f := SYSTEM.VAL(TglTexCoord4f, GetProcAddress('glTexCoord4f'));
	glTexCoord4fv := SYSTEM.VAL(TglTexCoord4fv, GetProcAddress('glTexCoord4fv'));
	glTexCoord4i := SYSTEM.VAL(TglTexCoord4i, GetProcAddress('glTexCoord4i'));
	glTexCoord4iv := SYSTEM.VAL(TglTexCoord4iv, GetProcAddress('glTexCoord4iv'));
	glTexCoord4s := SYSTEM.VAL(TglTexCoord4s, GetProcAddress('glTexCoord4s'));
	glTexCoord4sv := SYSTEM.VAL(TglTexCoord4sv, GetProcAddress('glTexCoord4sv'));
	glTexCoordPointer := SYSTEM.VAL(TglTexCoordPointer, GetProcAddress('glTexCoordPointer'));
	glTexEnvf := SYSTEM.VAL(TglTexEnvf, GetProcAddress('glTexEnvf'));
	glTexEnvfv := SYSTEM.VAL(TglTexEnvfv, GetProcAddress('glTexEnvfv'));
	glTexEnvi := SYSTEM.VAL(TglTexEnvi, GetProcAddress('glTexEnvi'));
	glTexEnviv := SYSTEM.VAL(TglTexEnviv, GetProcAddress('glTexEnviv'));
	glTexGend := SYSTEM.VAL(TglTexGend, GetProcAddress('glTexGend'));
	glTexGendv := SYSTEM.VAL(TglTexGendv, GetProcAddress('glTexGendv'));
	glTexGenf := SYSTEM.VAL(TglTexGenf, GetProcAddress('glTexGenf'));
	glTexGenfv := SYSTEM.VAL(TglTexGenfv, GetProcAddress('glTexGenfv'));
	glTexGeni := SYSTEM.VAL(TglTexGeni, GetProcAddress('glTexGeni'));
	glTexGeniv := SYSTEM.VAL(TglTexGeniv, GetProcAddress('glTexGeniv'));
	glTranslated := SYSTEM.VAL(TglTranslated, GetProcAddress('glTranslated'));
	glTranslatef := SYSTEM.VAL(TglTranslatef, GetProcAddress('glTranslatef'));
	glVertex2d := SYSTEM.VAL(TglVertex2d, GetProcAddress('glVertex2d'));
	glVertex2dv := SYSTEM.VAL(TglVertex2dv, GetProcAddress('glVertex2dv'));
	glVertex2f := SYSTEM.VAL(TglVertex2f, GetProcAddress('glVertex2f'));
	glVertex2fv := SYSTEM.VAL(TglVertex2fv, GetProcAddress('glVertex2fv'));
	glVertex2i := SYSTEM.VAL(TglVertex2i, GetProcAddress('glVertex2i'));
	glVertex2iv := SYSTEM.VAL(TglVertex2iv, GetProcAddress('glVertex2iv'));
	glVertex2s := SYSTEM.VAL(TglVertex2s, GetProcAddress('glVertex2s'));
	glVertex2sv := SYSTEM.VAL(TglVertex2sv, GetProcAddress('glVertex2sv'));
	glVertex3d := SYSTEM.VAL(TglVertex3d, GetProcAddress('glVertex3d'));
	glVertex3dv := SYSTEM.VAL(TglVertex3dv, GetProcAddress('glVertex3dv'));
	glVertex3f := SYSTEM.VAL(TglVertex3f, GetProcAddress('glVertex3f'));
	glVertex3fv := SYSTEM.VAL(TglVertex3fv, GetProcAddress('glVertex3fv'));
	glVertex3i := SYSTEM.VAL(TglVertex3i, GetProcAddress('glVertex3i'));
	glVertex3iv := SYSTEM.VAL(TglVertex3iv, GetProcAddress('glVertex3iv'));
	glVertex3s := SYSTEM.VAL(TglVertex3s, GetProcAddress('glVertex3s'));
	glVertex3sv := SYSTEM.VAL(TglVertex3sv, GetProcAddress('glVertex3sv'));
	glVertex4d := SYSTEM.VAL(TglVertex4d, GetProcAddress('glVertex4d'));
	glVertex4dv := SYSTEM.VAL(TglVertex4dv, GetProcAddress('glVertex4dv'));
	glVertex4f := SYSTEM.VAL(TglVertex4f, GetProcAddress('glVertex4f'));
	glVertex4fv := SYSTEM.VAL(TglVertex4fv, GetProcAddress('glVertex4fv'));
	glVertex4i := SYSTEM.VAL(TglVertex4i, GetProcAddress('glVertex4i'));
	glVertex4iv := SYSTEM.VAL(TglVertex4iv, GetProcAddress('glVertex4iv'));
	glVertex4s := SYSTEM.VAL(TglVertex4s, GetProcAddress('glVertex4s'));
	glVertex4sv := SYSTEM.VAL(TglVertex4sv, GetProcAddress('glVertex4sv'));
	glVertexPointer := SYSTEM.VAL(TglVertexPointer, GetProcAddress('glVertexPointer'));
	(* endif *)

  (* GL_VERSION_1_2 *)
    glBlendColor := SYSTEM.VAL(TglBlendColor, GetProcAddress('glBlendColor'));
    glBlendEquation := SYSTEM.VAL(TglBlendEquation, GetProcAddress('glBlendEquation'));
    glDrawRangeElements := SYSTEM.VAL(TglDrawRangeElements, GetProcAddress('glDrawRangeElements'));
    glTexImage3D := SYSTEM.VAL( TglTexImage3D, GetProcAddress('glTexImage3D'));
    glTexSubImage3D := SYSTEM.VAL(TglTexSubImage3D, GetProcAddress('glTexSubImage3D'));
    glCopyTexSubImage3D := SYSTEM.VAL(TglCopyTexSubImage3D, GetProcAddress('glCopyTexSubImage3D'));

  (* GL_VERSION_1_3 *)
   glActiveTexture := SYSTEM.VAL( TglActiveTexture, GetProcAddress('glActiveTexture'));
   glSampleCoverage := SYSTEM.VAL(TglSampleCoverage, GetProcAddress('glSampleCoverage'));
   glCompressedTexImage3D := SYSTEM.VAL(TglCompressedTexImage3D, GetProcAddress('glCompressedTexImage3D'));
   glCompressedTexImage2D := SYSTEM.VAL(TglCompressedTexImage2D, GetProcAddress('glCompressedTexImage2D'));
   glCompressedTexImage1D := SYSTEM.VAL(TglCompressedTexImage1D, GetProcAddress('glCompressedTexImage1D'));
   glCompressedTexSubImage3D := SYSTEM.VAL(TglCompressedTexSubImage3D, GetProcAddress('glCompressedTexSubImage3D'));
   glCompressedTexSubImage2D := SYSTEM.VAL(TglCompressedTexSubImage2D, GetProcAddress('glCompressedTexSubImage2D'));
   glCompressedTexSubImage1D := SYSTEM.VAL(TglCompressedTexSubImage1D, GetProcAddress('glCompressedTexSubImage1D'));
   glGetCompressedTexImage := SYSTEM.VAL(TglGetCompressedTexImage, GetProcAddress('glGetCompressedTexImage'));

  (* GL_VERSION_1_4 *)
   glBlendFuncSeparate := SYSTEM.VAL(TglBlendFuncSeparate  , GetProcAddress('glBlendFuncSeparate'));
   glMultiDrawArrays := SYSTEM.VAL(TglMultiDrawArrays  , GetProcAddress('glMultiDrawArrays'));
   glMultiDrawElements := SYSTEM.VAL(TglMultiDrawElements  , GetProcAddress('glMultiDrawElements'));
   glPointParameterf := SYSTEM.VAL(TglPointParameterf  , GetProcAddress('glPointParameterf'));
   glPointParameterfv := SYSTEM.VAL(TglPointParameterfv  , GetProcAddress('glPointParameterfv'));
   glPointParameteri := SYSTEM.VAL(TglPointParameteri  , GetProcAddress('glPointParameteri'));
   glPointParameteriv := SYSTEM.VAL(TglPointParameteriv  , GetProcAddress('glPointParameteriv'));

  (* GL_VERSION_1_5 *)
   glGenQueries := SYSTEM.VAL(TglGenQueries  , GetProcAddress('glGenQueries'));
   glDeleteQueries := SYSTEM.VAL(TglDeleteQueries  , GetProcAddress('glDeleteQueries'));
   glIsQuery := SYSTEM.VAL(TglIsQuery  , GetProcAddress('glIsQuery'));
   glBeginQuery := SYSTEM.VAL(TglBeginQuery  , GetProcAddress('glBeginQuery'));
   glEndQuery := SYSTEM.VAL(TglEndQuery  , GetProcAddress('glEndQuery'));
   glGetQueryiv := SYSTEM.VAL(TglGetQueryiv  , GetProcAddress('glGetQueryiv'));
   glGetQueryObjectiv := SYSTEM.VAL(TglGetQueryObjectiv  , GetProcAddress('glGetQueryObjectiv'));
   glGetQueryObjectuiv := SYSTEM.VAL(TglGetQueryObjectuiv  , GetProcAddress('glGetQueryObjectuiv'));
   glBindBuffer := SYSTEM.VAL(TglBindBuffer  , GetProcAddress('glBindBuffer'));
   glDeleteBuffers := SYSTEM.VAL(TglDeleteBuffers  , GetProcAddress('glDeleteBuffers'));
   glGenBuffers := SYSTEM.VAL(TglGenBuffers  , GetProcAddress('glGenBuffers'));
   glIsBuffer := SYSTEM.VAL(TglIsBuffer  , GetProcAddress('glIsBuffer'));
   glBufferData := SYSTEM.VAL(TglBufferData  , GetProcAddress('glBufferData'));
   glBufferSubData := SYSTEM.VAL(TglBufferSubData  , GetProcAddress('glBufferSubData'));
   glGetBufferSubData := SYSTEM.VAL(TglGetBufferSubData  , GetProcAddress('glGetBufferSubData'));
   glMapBuffer := SYSTEM.VAL(TglMapBuffer  , GetProcAddress('glMapBuffer'));
   glUnmapBuffer := SYSTEM.VAL(TglUnmapBuffer  , GetProcAddress('glUnmapBuffer'));
   glGetBufferParameteriv := SYSTEM.VAL(TglGetBufferParameteriv  , GetProcAddress('glGetBufferParameteriv'));
   glGetBufferPointerv := SYSTEM.VAL(TglGetBufferPointerv  , GetProcAddress('glGetBufferPointerv'));

  (* GL_VERSION_2_0 *)
   glBlendEquationSeparate := SYSTEM.VAL(TglBlendEquationSeparate  , GetProcAddress('glBlendEquationSeparate'));
   glDrawBuffers := SYSTEM.VAL(TglDrawBuffers  , GetProcAddress('glDrawBuffers'));
   glStencilOpSeparate := SYSTEM.VAL(TglStencilOpSeparate  , GetProcAddress('glStencilOpSeparate'));
   glStencilFuncSeparate := SYSTEM.VAL(TglStencilFuncSeparate  , GetProcAddress('glStencilFuncSeparate'));
   glStencilMaskSeparate := SYSTEM.VAL(TglStencilMaskSeparate  , GetProcAddress('glStencilMaskSeparate'));
   glAttachShader := SYSTEM.VAL(TglAttachShader  , GetProcAddress('glAttachShader'));
   glBindAttribLocation := SYSTEM.VAL(TglBindAttribLocation  , GetProcAddress('glBindAttribLocation'));
   glCompileShader := SYSTEM.VAL(TglCompileShader  , GetProcAddress('glCompileShader'));
   glCreateProgram := SYSTEM.VAL(TglCreateProgram  , GetProcAddress('glCreateProgram'));
   glCreateShader := SYSTEM.VAL(TglCreateShader  , GetProcAddress('glCreateShader'));
   glDeleteProgram := SYSTEM.VAL(TglDeleteProgram  , GetProcAddress('glDeleteProgram'));
   glDeleteShader := SYSTEM.VAL(TglDeleteShader  , GetProcAddress('glDeleteShader'));
   glDetachShader := SYSTEM.VAL(TglDetachShader  , GetProcAddress('glDetachShader'));
   glDisableVertexAttribArray := SYSTEM.VAL(TglDisableVertexAttribArray  , GetProcAddress('glDisableVertexAttribArray'));
   glEnableVertexAttribArray := SYSTEM.VAL(TglEnableVertexAttribArray  , GetProcAddress('glEnableVertexAttribArray'));
   glGetActiveAttrib := SYSTEM.VAL(TglGetActiveAttrib  , GetProcAddress('glGetActiveAttrib'));
   glGetActiveUniform := SYSTEM.VAL(TglGetActiveUniform  , GetProcAddress('glGetActiveUniform'));
   glGetAttachedShaders := SYSTEM.VAL(TglGetAttachedShaders  , GetProcAddress('glGetAttachedShaders'));
   glGetAttribLocation := SYSTEM.VAL(TglGetAttribLocation  , GetProcAddress('glGetAttribLocation'));
   glGetProgramiv := SYSTEM.VAL(TglGetProgramiv  , GetProcAddress('glGetProgramiv'));
   glGetProgramInfoLog := SYSTEM.VAL(TglGetProgramInfoLog  , GetProcAddress('glGetProgramInfoLog'));
   glGetShaderiv := SYSTEM.VAL(TglGetShaderiv  , GetProcAddress('glGetShaderiv'));
   glGetShaderInfoLog := SYSTEM.VAL(TglGetShaderInfoLog  , GetProcAddress('glGetShaderInfoLog'));
   glGetShaderSource := SYSTEM.VAL(TglGetShaderSource  , GetProcAddress('glGetShaderSource'));
   glGetUniformLocation := SYSTEM.VAL(TglGetUniformLocation  , GetProcAddress('glGetUniformLocation'));
   glGetUniformfv := SYSTEM.VAL(TglGetUniformfv  , GetProcAddress('glGetUniformfv'));
   glGetUniformiv := SYSTEM.VAL(TglGetUniformiv  , GetProcAddress('glGetUniformiv'));
   glGetVertexAttribfv := SYSTEM.VAL(TglGetVertexAttribfv  , GetProcAddress('glGetVertexAttribfv'));
   glGetVertexAttribiv := SYSTEM.VAL(TglGetVertexAttribiv  , GetProcAddress('glGetVertexAttribiv'));
   glGetVertexAttribPointerv := SYSTEM.VAL(TglGetVertexAttribPointerv  , GetProcAddress('glGetVertexAttribPointerv'));
   glIsProgram := SYSTEM.VAL(TglIsProgram  , GetProcAddress('glIsProgram'));
   glIsShader := SYSTEM.VAL(TglIsShader  , GetProcAddress('glIsShader'));
   glLinkProgram := SYSTEM.VAL(TglLinkProgram  , GetProcAddress('glLinkProgram'));
   glShaderSource := SYSTEM.VAL(TglShaderSource  , GetProcAddress('glShaderSource'));
   glUseProgram := SYSTEM.VAL(TglUseProgram  , GetProcAddress('glUseProgram'));
   glUniform1f := SYSTEM.VAL(TglUniform1f  , GetProcAddress('glUniform1f'));
   glUniform2f := SYSTEM.VAL(TglUniform2f  , GetProcAddress('glUniform2f'));
   glUniform3f := SYSTEM.VAL(TglUniform3f  , GetProcAddress('glUniform3f'));
   glUniform4f := SYSTEM.VAL(TglUniform4f  , GetProcAddress('glUniform4f'));
   glUniform1i := SYSTEM.VAL(TglUniform1i  , GetProcAddress('glUniform1i'));
   glUniform2i := SYSTEM.VAL(TglUniform2i  , GetProcAddress('glUniform2i'));
   glUniform3i := SYSTEM.VAL(TglUniform3i  , GetProcAddress('glUniform3i'));
   glUniform4i := SYSTEM.VAL(TglUniform4i  , GetProcAddress('glUniform4i'));
   glUniform1fv := SYSTEM.VAL(TglUniform1fv  , GetProcAddress('glUniform1fv'));
   glUniform2fv := SYSTEM.VAL(TglUniform2fv  , GetProcAddress('glUniform2fv'));
   glUniform3fv := SYSTEM.VAL(TglUniform3fv  , GetProcAddress('glUniform3fv'));
   glUniform4fv := SYSTEM.VAL(TglUniform4fv  , GetProcAddress('glUniform4fv'));
   glUniform1iv := SYSTEM.VAL(TglUniform1iv  , GetProcAddress('glUniform1iv'));
   glUniform2iv := SYSTEM.VAL(TglUniform2iv  , GetProcAddress('glUniform2iv'));
   glUniform3iv := SYSTEM.VAL(TglUniform3iv  , GetProcAddress('glUniform3iv'));
   glUniform4iv := SYSTEM.VAL(TglUniform4iv  , GetProcAddress('glUniform4iv'));
   glUniformMatrix2fv := SYSTEM.VAL(TglUniformMatrix2fv  , GetProcAddress('glUniformMatrix2fv'));
   glUniformMatrix3fv := SYSTEM.VAL(TglUniformMatrix3fv  , GetProcAddress('glUniformMatrix3fv'));
   glUniformMatrix4fv := SYSTEM.VAL(TglUniformMatrix4fv  , GetProcAddress('glUniformMatrix4fv'));
   glValidateProgram := SYSTEM.VAL(TglValidateProgram  , GetProcAddress('glValidateProgram'));
   glVertexAttrib1d := SYSTEM.VAL(TglVertexAttrib1d  , GetProcAddress('glVertexAttrib1d'));
   glVertexAttrib1dv := SYSTEM.VAL(TglVertexAttrib1dv  , GetProcAddress('glVertexAttrib1dv'));
   glVertexAttrib1f := SYSTEM.VAL(TglVertexAttrib1f  , GetProcAddress('glVertexAttrib1f'));
   glVertexAttrib1fv := SYSTEM.VAL(TglVertexAttrib1fv  , GetProcAddress('glVertexAttrib1fv'));
   glVertexAttrib1s := SYSTEM.VAL(TglVertexAttrib1s  , GetProcAddress('glVertexAttrib1s'));
   glVertexAttrib1sv := SYSTEM.VAL(TglVertexAttrib1sv  , GetProcAddress('glVertexAttrib1sv'));
   glVertexAttrib2d := SYSTEM.VAL(TglVertexAttrib2d  , GetProcAddress('glVertexAttrib2d'));
   glVertexAttrib2dv := SYSTEM.VAL(TglVertexAttrib2dv  , GetProcAddress('glVertexAttrib2dv'));
   glVertexAttrib2f := SYSTEM.VAL(TglVertexAttrib2f  , GetProcAddress('glVertexAttrib2f'));
   glVertexAttrib2fv := SYSTEM.VAL(TglVertexAttrib2fv  , GetProcAddress('glVertexAttrib2fv'));
   glVertexAttrib2s := SYSTEM.VAL(TglVertexAttrib2s  , GetProcAddress('glVertexAttrib2s'));
   glVertexAttrib2sv := SYSTEM.VAL(TglVertexAttrib2sv  , GetProcAddress('glVertexAttrib2sv'));
   glVertexAttrib3d := SYSTEM.VAL(TglVertexAttrib3d  , GetProcAddress('glVertexAttrib3d'));
   glVertexAttrib3dv := SYSTEM.VAL(TglVertexAttrib3dv  , GetProcAddress('glVertexAttrib3dv'));
   glVertexAttrib3f := SYSTEM.VAL(TglVertexAttrib3f  , GetProcAddress('glVertexAttrib3f'));
   glVertexAttrib3fv := SYSTEM.VAL(TglVertexAttrib3fv  , GetProcAddress('glVertexAttrib3fv'));
   glVertexAttrib3s := SYSTEM.VAL(TglVertexAttrib3s  , GetProcAddress('glVertexAttrib3s'));
   glVertexAttrib3sv := SYSTEM.VAL(TglVertexAttrib3sv  , GetProcAddress('glVertexAttrib3sv'));
   glVertexAttrib4Nbv := SYSTEM.VAL(TglVertexAttrib4Nbv  , GetProcAddress('glVertexAttrib4Nbv'));
   glVertexAttrib4Niv := SYSTEM.VAL(TglVertexAttrib4Niv  , GetProcAddress('glVertexAttrib4Niv'));
   glVertexAttrib4Nsv := SYSTEM.VAL(TglVertexAttrib4Nsv  , GetProcAddress('glVertexAttrib4Nsv'));
   glVertexAttrib4Nub := SYSTEM.VAL(TglVertexAttrib4Nub  , GetProcAddress('glVertexAttrib4Nub'));
   glVertexAttrib4Nubv := SYSTEM.VAL(TglVertexAttrib4Nubv  , GetProcAddress('glVertexAttrib4Nubv'));
   glVertexAttrib4Nuiv := SYSTEM.VAL(TglVertexAttrib4Nuiv  , GetProcAddress('glVertexAttrib4Nuiv'));
   glVertexAttrib4Nusv := SYSTEM.VAL(TglVertexAttrib4Nusv  , GetProcAddress('glVertexAttrib4Nusv'));
   glVertexAttrib4bv := SYSTEM.VAL(TglVertexAttrib4bv  , GetProcAddress('glVertexAttrib4bv'));
   glVertexAttrib4d := SYSTEM.VAL(TglVertexAttrib4d  , GetProcAddress('glVertexAttrib4d'));
   glVertexAttrib4dv := SYSTEM.VAL(TglVertexAttrib4dv  , GetProcAddress('glVertexAttrib4dv'));
   glVertexAttrib4f := SYSTEM.VAL(TglVertexAttrib4f  , GetProcAddress('glVertexAttrib4f'));
   glVertexAttrib4fv := SYSTEM.VAL(TglVertexAttrib4fv  , GetProcAddress('glVertexAttrib4fv'));
   glVertexAttrib4iv := SYSTEM.VAL(TglVertexAttrib4iv  , GetProcAddress('glVertexAttrib4iv'));
   glVertexAttrib4s := SYSTEM.VAL(TglVertexAttrib4s  , GetProcAddress('glVertexAttrib4s'));
   glVertexAttrib4sv := SYSTEM.VAL(TglVertexAttrib4sv  , GetProcAddress('glVertexAttrib4sv'));
   glVertexAttrib4ubv := SYSTEM.VAL(TglVertexAttrib4ubv  , GetProcAddress('glVertexAttrib4ubv'));
   glVertexAttrib4uiv := SYSTEM.VAL(TglVertexAttrib4uiv  , GetProcAddress('glVertexAttrib4uiv'));
   glVertexAttrib4usv := SYSTEM.VAL(TglVertexAttrib4usv  , GetProcAddress('glVertexAttrib4usv'));
   glVertexAttribPointer := SYSTEM.VAL(TglVertexAttribPointer  , GetProcAddress('glVertexAttribPointer'));

  (* GL_VERSION_2_1 *)
   glUniformMatrix2x3fv := SYSTEM.VAL(TglUniformMatrix2x3fv  , GetProcAddress('glUniformMatrix2x3fv'));
   glUniformMatrix3x2fv := SYSTEM.VAL(TglUniformMatrix3x2fv  , GetProcAddress('glUniformMatrix3x2fv'));
   glUniformMatrix2x4fv := SYSTEM.VAL(TglUniformMatrix2x4fv  , GetProcAddress('glUniformMatrix2x4fv'));
   glUniformMatrix4x2fv := SYSTEM.VAL(TglUniformMatrix4x2fv  , GetProcAddress('glUniformMatrix4x2fv'));
   glUniformMatrix3x4fv := SYSTEM.VAL(TglUniformMatrix3x4fv  , GetProcAddress('glUniformMatrix3x4fv'));
   glUniformMatrix4x3fv := SYSTEM.VAL(TglUniformMatrix4x3fv  , GetProcAddress('glUniformMatrix4x3fv'));

  (* GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions: *)
  Read_GL_ARB_framebuffer_object;
  Read_GL_ARB_map_buffer_range;
  Read_GL_ARB_vertex_array_object;

   glColorMaski := SYSTEM.VAL(TglColorMaski  , GetProcAddress('glColorMaski'));
   glGetBooleani_v := SYSTEM.VAL(TglGetBooleani_v  , GetProcAddress('glGetBooleani_v'));
   glGetIntegeri_v := SYSTEM.VAL(TglGetIntegeri_v  , GetProcAddress('glGetIntegeri_v'));
   glEnablei := SYSTEM.VAL(TglEnablei  , GetProcAddress('glEnablei'));
   glDisablei := SYSTEM.VAL(TglDisablei  , GetProcAddress('glDisablei'));
   glIsEnabledi := SYSTEM.VAL(TglIsEnabledi  , GetProcAddress('glIsEnabledi'));
   glBeginTransformFeedback := SYSTEM.VAL(TglBeginTransformFeedback  , GetProcAddress('glBeginTransformFeedback'));
   glEndTransformFeedback := SYSTEM.VAL(TglEndTransformFeedback  , GetProcAddress('glEndTransformFeedback'));
   glBindBufferRange := SYSTEM.VAL(TglBindBufferRange  , GetProcAddress('glBindBufferRange'));
   glBindBufferBase := SYSTEM.VAL(TglBindBufferBase  , GetProcAddress('glBindBufferBase'));
   glTransformFeedbackVaryings := SYSTEM.VAL(TglTransformFeedbackVaryings  , GetProcAddress('glTransformFeedbackVaryings'));
   glGetTransformFeedbackVarying := SYSTEM.VAL(TglGetTransformFeedbackVarying  , GetProcAddress('glGetTransformFeedbackVarying'));
   glClampColor := SYSTEM.VAL(TglClampColor  , GetProcAddress('glClampColor'));
   glBeginConditionalRender := SYSTEM.VAL(TglBeginConditionalRender  , GetProcAddress('glBeginConditionalRender'));
   glEndConditionalRender := SYSTEM.VAL(TglEndConditionalRender  , GetProcAddress('glEndConditionalRender'));
   glVertexAttribI1i := SYSTEM.VAL(TglVertexAttribI1i  , GetProcAddress('glVertexAttribI1i'));
   glVertexAttribI2i := SYSTEM.VAL(TglVertexAttribI2i  , GetProcAddress('glVertexAttribI2i'));
   glVertexAttribI3i := SYSTEM.VAL(TglVertexAttribI3i  , GetProcAddress('glVertexAttribI3i'));
   glVertexAttribI4i := SYSTEM.VAL(TglVertexAttribI4i  , GetProcAddress('glVertexAttribI4i'));
   glVertexAttribI1ui := SYSTEM.VAL(TglVertexAttribI1ui  , GetProcAddress('glVertexAttribI1ui'));
   glVertexAttribI2ui := SYSTEM.VAL(TglVertexAttribI2ui  , GetProcAddress('glVertexAttribI2ui'));
   glVertexAttribI3ui := SYSTEM.VAL(TglVertexAttribI3ui  , GetProcAddress('glVertexAttribI3ui'));
   glVertexAttribI4ui := SYSTEM.VAL(TglVertexAttribI4ui  , GetProcAddress('glVertexAttribI4ui'));
   glVertexAttribI1iv := SYSTEM.VAL(TglVertexAttribI1iv  , GetProcAddress('glVertexAttribI1iv'));
   glVertexAttribI2iv := SYSTEM.VAL(TglVertexAttribI2iv  , GetProcAddress('glVertexAttribI2iv'));
   glVertexAttribI3iv := SYSTEM.VAL(TglVertexAttribI3iv  , GetProcAddress('glVertexAttribI3iv'));
   glVertexAttribI4iv := SYSTEM.VAL(TglVertexAttribI4iv  , GetProcAddress('glVertexAttribI4iv'));
   glVertexAttribI1uiv := SYSTEM.VAL(TglVertexAttribI1uiv  , GetProcAddress('glVertexAttribI1uiv'));
   glVertexAttribI2uiv := SYSTEM.VAL(TglVertexAttribI2uiv  , GetProcAddress('glVertexAttribI2uiv'));
   glVertexAttribI3uiv := SYSTEM.VAL(TglVertexAttribI3uiv  , GetProcAddress('glVertexAttribI3uiv'));
   glVertexAttribI4uiv := SYSTEM.VAL(TglVertexAttribI4uiv  , GetProcAddress('glVertexAttribI4uiv'));
   glVertexAttribI4bv := SYSTEM.VAL(TglVertexAttribI4bv  , GetProcAddress('glVertexAttribI4bv'));
   glVertexAttribI4sv := SYSTEM.VAL(TglVertexAttribI4sv  , GetProcAddress('glVertexAttribI4sv'));
   glVertexAttribI4ubv := SYSTEM.VAL(TglVertexAttribI4ubv  , GetProcAddress('glVertexAttribI4ubv'));
   glVertexAttribI4usv := SYSTEM.VAL(TglVertexAttribI4usv  , GetProcAddress('glVertexAttribI4usv'));
   glVertexAttribIPointer := SYSTEM.VAL(TglVertexAttribIPointer  , GetProcAddress('glVertexAttribIPointer'));
   glGetVertexAttribIiv := SYSTEM.VAL(TglGetVertexAttribIiv  , GetProcAddress('glGetVertexAttribIiv'));
   glGetVertexAttribIuiv := SYSTEM.VAL(TglGetVertexAttribIuiv  , GetProcAddress('glGetVertexAttribIuiv'));
   glGetUniformuiv := SYSTEM.VAL(TglGetUniformuiv  , GetProcAddress('glGetUniformuiv'));
   glBindFragDataLocation := SYSTEM.VAL(TglBindFragDataLocation  , GetProcAddress('glBindFragDataLocation'));
   glGetFragDataLocation := SYSTEM.VAL(TglGetFragDataLocation  , GetProcAddress('glGetFragDataLocation'));
   glUniform1ui := SYSTEM.VAL(TglUniform1ui  , GetProcAddress('glUniform1ui'));
   glUniform2ui := SYSTEM.VAL(TglUniform2ui  , GetProcAddress('glUniform2ui'));
   glUniform3ui := SYSTEM.VAL(TglUniform3ui  , GetProcAddress('glUniform3ui'));
   glUniform4ui := SYSTEM.VAL(TglUniform4ui  , GetProcAddress('glUniform4ui'));
   glUniform1uiv := SYSTEM.VAL(TglUniform1uiv  , GetProcAddress('glUniform1uiv'));
   glUniform2uiv := SYSTEM.VAL(TglUniform2uiv  , GetProcAddress('glUniform2uiv'));
   glUniform3uiv := SYSTEM.VAL(TglUniform3uiv  , GetProcAddress('glUniform3uiv'));
   glUniform4uiv := SYSTEM.VAL(TglUniform4uiv  , GetProcAddress('glUniform4uiv'));
   glTexParameterIiv := SYSTEM.VAL(TglTexParameterIiv  , GetProcAddress('glTexParameterIiv'));
   glTexParameterIuiv := SYSTEM.VAL(TglTexParameterIuiv  , GetProcAddress('glTexParameterIuiv'));
   glGetTexParameterIiv := SYSTEM.VAL(TglGetTexParameterIiv  , GetProcAddress('glGetTexParameterIiv'));
   glGetTexParameterIuiv := SYSTEM.VAL(TglGetTexParameterIuiv  , GetProcAddress('glGetTexParameterIuiv'));
   glClearBufferiv := SYSTEM.VAL(TglClearBufferiv  , GetProcAddress('glClearBufferiv'));
   glClearBufferuiv := SYSTEM.VAL(TglClearBufferuiv  , GetProcAddress('glClearBufferuiv'));
   glClearBufferfv := SYSTEM.VAL(TglClearBufferfv  , GetProcAddress('glClearBufferfv'));
   glClearBufferfi := SYSTEM.VAL(TglClearBufferfi  , GetProcAddress('glClearBufferfi'));
   glGetStringi := SYSTEM.VAL(TglGetStringi  , GetProcAddress('glGetStringi'));

  (* GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions: *)
  Read_GL_ARB_copy_buffer;
  Read_GL_ARB_uniform_buffer_object;

   glDrawArraysInstanced := SYSTEM.VAL(TglDrawArraysInstanced  , GetProcAddress('glDrawArraysInstanced'));
   glDrawElementsInstanced := SYSTEM.VAL(TglDrawElementsInstanced  , GetProcAddress('glDrawElementsInstanced'));
   glTexBuffer := SYSTEM.VAL(TglTexBuffer  , GetProcAddress('glTexBuffer'));
   glPrimitiveRestartIndex := SYSTEM.VAL(TglPrimitiveRestartIndex  , GetProcAddress('glPrimitiveRestartIndex'));

  (* GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions: *)
  Read_GL_ARB_draw_elements_base_vertex;
  Read_GL_ARB_provoking_vertex;
  Read_GL_ARB_sync;
  Read_GL_ARB_texture_multisample;

   glGetInteger64i_v  := SYSTEM.VAL(TglGetInteger64i_v  , GetProcAddress('glGetInteger64i_v'));
   glGetBufferParameteri64v := SYSTEM.VAL(TglGetBufferParameteri64v  , GetProcAddress('glGetBufferParameteri64v'));
   glProgramParameteri := SYSTEM.VAL(TglProgramParameteri  , GetProcAddress('glProgramParameteri'));
   glFramebufferTexture := SYSTEM.VAL(TglFramebufferTexture  , GetProcAddress('glFramebufferTexture'));

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
  	Read_GL_ARB_vertexxtype_2_10_10_10_rev;
     glVertexAttribDivisor := SYSTEM.VAL(TglVertexAttribDivisor, GetProcAddress('glVertexAttribDivisor'));

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
     glMinSampleShading := SYSTEM.VAL(TglMinSampleShading, GetProcAddress('glMinSampleShading'));
     glBlendEquationi := SYSTEM.VAL(TglBlendEquationi, GetProcAddress('glBlendEquationi'));
     glBlendEquationSeparatei := SYSTEM.VAL(TglBlendEquationSeparatei, GetProcAddress('glBlendEquationSeparatei'));
     glBlendFunci := SYSTEM.VAL(TglBlendFunci, GetProcAddress('glBlendFunci'));
     glBlendFuncSeparatei := SYSTEM.VAL(TglBlendFuncSeparatei, GetProcAddress('glBlendFuncSeparatei'));

 (* GL_VERSION_4_1 *)
 	(* OpenGL 4.1 also reuses entry points from these extensions: *)
  	Read_GL_ARB_ES2_compatibility;
  	Read_GL_ARB_get_program_binary;
  	Read_GL_ARB_separate_shader_objects;
  	(* ARB_shader_precision (no entry points) *)
  	Read_GL_ARB_vertex_attrib_64bit;
  	Read_GL_ARB_viewport_array;

 (* GL_VERSION_4_2 *)
  (* OpenGL 4.2 reuses entry points from these extensions: *)
  Read_GL_ARB_base_instance;
  (* Read_GL_ARB_shading_language_420pack; (no entry points) *)
  Read_GL_ARB_transform_feedback_instanced;
  (* Read_GL_ARB_compressed_texture_pixel_storage (no entry points) *)
  (* Read_GL_ARB_conservative_depth; *)
  Read_GL_ARB_internalformat_query;
  (* Read_GL_ARB_map_buffer_alignment;*)
  Read_GL_ARB_shader_atomic_counters;
  Read_GL_ARB_shader_image_load_store;
  (* Read_GL_ARB_shading_language_packing; *)
  Read_GL_ARB_texture_storage;

END ReadOpenGLCore;


PROCEDURE Read_GL_3DFX_tbuffer;
BEGIN
     glTbufferMask3DFX := SYSTEM.VAL(TglTbufferMask3DFX, GetProcAddress('glTbufferMask3DFX'));
END Read_GL_3DFX_tbuffer;

PROCEDURE Read_GL_APPLE_element_array;
BEGIN
     glElementPointerAPPLE := SYSTEM.VAL(TglElementPointerAPPLE, GetProcAddress('glElementPointerAPPLE'));
     glDrawElementArrayAPPLE := SYSTEM.VAL(TglDrawElementArrayAPPLE, GetProcAddress('glDrawElementArrayAPPLE'));
     glDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglDrawRangeElementArrayAPPLE, GetProcAddress('glDrawRangeElementArrayAPPLE'));
     glMultiDrawElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawElementArrayAPPLE, GetProcAddress('glMultiDrawElementArrayAPPLE'));
     glMultiDrawRangeElementArrayAPPLE := SYSTEM.VAL(TglMultiDrawRangeElementArrayAPPLE, GetProcAddress('glMultiDrawRangeElementArrayAPPLE'));

END Read_GL_APPLE_element_array;

PROCEDURE Read_GL_APPLE_fence;
BEGIN
     glGenFencesAPPLE := SYSTEM.VAL(TglGenFencesAPPLE, GetProcAddress('glGenFencesAPPLE'));
     glDeleteFencesAPPLE := SYSTEM.VAL(TglDeleteFencesAPPLE, GetProcAddress('glDeleteFencesAPPLE'));
     glSetFenceAPPLE := SYSTEM.VAL(TglSetFenceAPPLE, GetProcAddress('glSetFenceAPPLE'));
     glIsFenceAPPLE := SYSTEM.VAL(TglIsFenceAPPLE, GetProcAddress('glIsFenceAPPLE'));
     glTestFenceAPPLE := SYSTEM.VAL(TglTestFenceAPPLE, GetProcAddress('glTestFenceAPPLE'));
     glFinishFenceAPPLE := SYSTEM.VAL(TglFinishFenceAPPLE, GetProcAddress('glFinishFenceAPPLE'));
     glTestObjectAPPLE := SYSTEM.VAL(TglTestObjectAPPLE, GetProcAddress('glTestObjectAPPLE'));
     glFinishObjectAPPLE := SYSTEM.VAL(TglFinishObjectAPPLE, GetProcAddress('glFinishObjectAPPLE'));
END Read_GL_APPLE_fence;

PROCEDURE Read_GL_APPLE_vertex_array_object;
BEGIN
     glBindVertexArrayAPPLE := SYSTEM.VAL(TglBindVertexArrayAPPLE, GetProcAddress('glBindVertexArrayAPPLE'));
     glDeleteVertexArraysAPPLE := SYSTEM.VAL(TglDeleteVertexArraysAPPLE, GetProcAddress('glDeleteVertexArraysAPPLE'));
     glGenVertexArraysAPPLE := SYSTEM.VAL(TglGenVertexArraysAPPLE, GetProcAddress('glGenVertexArraysAPPLE'));
     glIsVertexArrayAPPLE := SYSTEM.VAL(TglIsVertexArrayAPPLE, GetProcAddress('glIsVertexArrayAPPLE'));
END Read_GL_APPLE_vertex_array_object;

PROCEDURE Read_GL_APPLE_vertex_array_range;
BEGIN
     glVertexArrayRangeAPPLE := SYSTEM.VAL(TglVertexArrayRangeAPPLE, GetProcAddress('glVertexArrayRangeAPPLE'));
     glFlushVertexArrayRangeAPPLE := SYSTEM.VAL(TglFlushVertexArrayRangeAPPLE, GetProcAddress('glFlushVertexArrayRangeAPPLE'));
     glVertexArrayParameteriAPPLE := SYSTEM.VAL(TglVertexArrayParameteriAPPLE, GetProcAddress('glVertexArrayParameteriAPPLE'));
END Read_GL_APPLE_vertex_array_range;

PROCEDURE Read_GL_APPLE_texture_range;
BEGIN
    glTextureRangeAPPLE := SYSTEM.VAL(TglTextureRangeAPPLE, GetProcAddress('glTextureRangeAPPLE'));
    glGetTexParameterPointervAPPLE := SYSTEM.VAL(TglGetTexParameterPointervAPPLE, GetProcAddress('glGetTexParameterPointervAPPLE'));
END Read_GL_APPLE_texture_range;

PROCEDURE Read_GL_APPLE_vertex_program_evaluators;
BEGIN
     glEnableVertexAttribAPPLE := SYSTEM.VAL(TglEnableVertexAttribAPPLE, GetProcAddress('glEnableVertexAttribAPPLE'));
     glDisableVertexAttribAPPLE := SYSTEM.VAL(TglDisableVertexAttribAPPLE, GetProcAddress('glDisableVertexAttribAPPLE'));
     glIsVertexAttribEnabledAPPLE := SYSTEM.VAL(TglIsVertexAttribEnabledAPPLE, GetProcAddress('glIsVertexAttribEnabledAPPLE'));
     glMapVertexAttrib1dAPPLE := SYSTEM.VAL(TglMapVertexAttrib1dAPPLE, GetProcAddress('glMapVertexAttrib1dAPPLE'));
     glMapVertexAttrib1fAPPLE := SYSTEM.VAL(TglMapVertexAttrib1fAPPLE, GetProcAddress('glMapVertexAttrib1fAPPLE'));
     glMapVertexAttrib2dAPPLE := SYSTEM.VAL(TglMapVertexAttrib2dAPPLE, GetProcAddress('glMapVertexAttrib2dAPPLE'));
     glMapVertexAttrib2fAPPLE := SYSTEM.VAL(TglMapVertexAttrib2fAPPLE, GetProcAddress('glMapVertexAttrib2fAPPLE'));
END Read_GL_APPLE_vertex_program_evaluators;

PROCEDURE Read_GL_APPLE_object_purgeable;
BEGIN
     glObjectPurgeableAPPLE := SYSTEM.VAL(TglObjectPurgeableAPPLE, GetProcAddress('glObjectPurgeableAPPLE'));
     glObjectUnpurgeableAPPLE := SYSTEM.VAL(TglObjectUnpurgeableAPPLE, GetProcAddress('glObjectUnpurgeableAPPLE'));
     glGetObjectParameterivAPPLE := SYSTEM.VAL(TglGetObjectParameterivAPPLE, GetProcAddress('glGetObjectParameterivAPPLE'));
END Read_GL_APPLE_object_purgeable;

PROCEDURE Read_GL_ARB_matrix_palette;
BEGIN
     glCurrentPaletteMatrixARB := SYSTEM.VAL(TglCurrentPaletteMatrixARB, GetProcAddress('glCurrentPaletteMatrixARB'));
     glMatrixIndexubvARB := SYSTEM.VAL(TglMatrixIndexubvARB, GetProcAddress('glMatrixIndexubvARB'));
     glMatrixIndexusvARB := SYSTEM.VAL(TglMatrixIndexusvARB, GetProcAddress('glMatrixIndexusvARB'));
     glMatrixIndexuivARB := SYSTEM.VAL(TglMatrixIndexuivARB, GetProcAddress('glMatrixIndexuivARB'));
     glMatrixIndexPointerARB := SYSTEM.VAL(TglMatrixIndexPointerARB, GetProcAddress('glMatrixIndexPointerARB'));
END Read_GL_ARB_matrix_palette;

PROCEDURE Read_GL_ARB_multisample;
BEGIN
     glSampleCoverageARB := SYSTEM.VAL(TglSampleCoverageARB, GetProcAddress('glSampleCoverageARB'));
END Read_GL_ARB_multisample;

PROCEDURE Read_GL_ARB_multitexture;
BEGIN
     glActiveTextureARB := SYSTEM.VAL(TglActiveTextureARB, GetProcAddress('glActiveTextureARB'));
     glClientActiveTextureARB := SYSTEM.VAL(TglClientActiveTextureARB, GetProcAddress('glClientActiveTextureARB'));
     glMultiTexCoord1dARB := SYSTEM.VAL(TglMultiTexCoord1dARB, GetProcAddress('glMultiTexCoord1dARB'));
     glMultiTexCoord1dvARB := SYSTEM.VAL(TglMultiTexCoord1dvARB, GetProcAddress('glMultiTexCoord1dvARB'));
     glMultiTexCoord1fARB := SYSTEM.VAL(TglMultiTexCoord1fARB, GetProcAddress('glMultiTexCoord1fARB'));
     glMultiTexCoord1fvARB := SYSTEM.VAL(TglMultiTexCoord1fvARB, GetProcAddress('glMultiTexCoord1fvARB'));
     glMultiTexCoord1iARB := SYSTEM.VAL(TglMultiTexCoord1iARB, GetProcAddress('glMultiTexCoord1iARB'));
     glMultiTexCoord1ivARB := SYSTEM.VAL(TglMultiTexCoord1ivARB, GetProcAddress('glMultiTexCoord1ivARB'));
     glMultiTexCoord1sARB := SYSTEM.VAL(TglMultiTexCoord1sARB, GetProcAddress('glMultiTexCoord1sARB'));
     glMultiTexCoord1svARB := SYSTEM.VAL(TglMultiTexCoord1svARB, GetProcAddress('glMultiTexCoord1svARB'));
     glMultiTexCoord2dARB := SYSTEM.VAL(TglMultiTexCoord2dARB, GetProcAddress('glMultiTexCoord2dARB'));
     glMultiTexCoord2dvARB := SYSTEM.VAL(TglMultiTexCoord2dvARB, GetProcAddress('glMultiTexCoord2dvARB'));
     glMultiTexCoord2fARB := SYSTEM.VAL(TglMultiTexCoord2fARB, GetProcAddress('glMultiTexCoord2fARB'));
     glMultiTexCoord2fvARB := SYSTEM.VAL(TglMultiTexCoord2fvARB, GetProcAddress('glMultiTexCoord2fvARB'));
     glMultiTexCoord2iARB := SYSTEM.VAL(TglMultiTexCoord2iARB, GetProcAddress('glMultiTexCoord2iARB'));
     glMultiTexCoord2ivARB := SYSTEM.VAL(TglMultiTexCoord2ivARB, GetProcAddress('glMultiTexCoord2ivARB'));
     glMultiTexCoord2sARB := SYSTEM.VAL(TglMultiTexCoord2sARB, GetProcAddress('glMultiTexCoord2sARB'));
     glMultiTexCoord2svARB := SYSTEM.VAL(TglMultiTexCoord2svARB, GetProcAddress('glMultiTexCoord2svARB'));
     glMultiTexCoord3dARB := SYSTEM.VAL(TglMultiTexCoord3dARB, GetProcAddress('glMultiTexCoord3dARB'));
     glMultiTexCoord3dvARB := SYSTEM.VAL(TglMultiTexCoord3dvARB, GetProcAddress('glMultiTexCoord3dvARB'));
     glMultiTexCoord3fARB := SYSTEM.VAL(TglMultiTexCoord3fARB, GetProcAddress('glMultiTexCoord3fARB'));
     glMultiTexCoord3fvARB := SYSTEM.VAL(TglMultiTexCoord3fvARB, GetProcAddress('glMultiTexCoord3fvARB'));
     glMultiTexCoord3iARB := SYSTEM.VAL(TglMultiTexCoord3iARB, GetProcAddress('glMultiTexCoord3iARB'));
     glMultiTexCoord3ivARB := SYSTEM.VAL(TglMultiTexCoord3ivARB, GetProcAddress('glMultiTexCoord3ivARB'));
     glMultiTexCoord3sARB := SYSTEM.VAL(TglMultiTexCoord3sARB, GetProcAddress('glMultiTexCoord3sARB'));
     glMultiTexCoord3svARB := SYSTEM.VAL(TglMultiTexCoord3svARB, GetProcAddress('glMultiTexCoord3svARB'));
     glMultiTexCoord4dARB := SYSTEM.VAL(TglMultiTexCoord4dARB, GetProcAddress('glMultiTexCoord4dARB'));
     glMultiTexCoord4dvARB := SYSTEM.VAL(TglMultiTexCoord4dvARB, GetProcAddress('glMultiTexCoord4dvARB'));
     glMultiTexCoord4fARB := SYSTEM.VAL(TglMultiTexCoord4fARB, GetProcAddress('glMultiTexCoord4fARB'));
     glMultiTexCoord4fvARB := SYSTEM.VAL(TglMultiTexCoord4fvARB, GetProcAddress('glMultiTexCoord4fvARB'));
     glMultiTexCoord4iARB := SYSTEM.VAL(TglMultiTexCoord4iARB, GetProcAddress('glMultiTexCoord4iARB'));
     glMultiTexCoord4ivARB := SYSTEM.VAL(TglMultiTexCoord4ivARB, GetProcAddress('glMultiTexCoord4ivARB'));
     glMultiTexCoord4sARB := SYSTEM.VAL(TglMultiTexCoord4sARB, GetProcAddress('glMultiTexCoord4sARB'));
     glMultiTexCoord4svARB := SYSTEM.VAL(TglMultiTexCoord4svARB, GetProcAddress('glMultiTexCoord4svARB'));
END Read_GL_ARB_multitexture;

PROCEDURE Read_GL_ARB_point_parameters;
BEGIN
     glPointParameterfARB := SYSTEM.VAL(TglPointParameterfARB, GetProcAddress('glPointParameterfARB'));
     glPointParameterfvARB := SYSTEM.VAL(TglPointParameterfvARB, GetProcAddress('glPointParameterfvARB'));
END Read_GL_ARB_point_parameters;

PROCEDURE Read_GL_ARB_texture_compression;
BEGIN
     glCompressedTexImage3DARB := SYSTEM.VAL(TglCompressedTexImage3DARB, GetProcAddress('glCompressedTexImage3DARB'));
     glCompressedTexImage2DARB := SYSTEM.VAL(TglCompressedTexImage2DARB, GetProcAddress('glCompressedTexImage2DARB'));
     glCompressedTexImage1DARB := SYSTEM.VAL(TglCompressedTexImage1DARB, GetProcAddress('glCompressedTexImage1DARB'));
     glCompressedTexSubImage3DARB := SYSTEM.VAL(TglCompressedTexSubImage3DARB, GetProcAddress('glCompressedTexSubImage3DARB'));
     glCompressedTexSubImage2DARB := SYSTEM.VAL(TglCompressedTexSubImage2DARB, GetProcAddress('glCompressedTexSubImage2DARB'));
     glCompressedTexSubImage1DARB := SYSTEM.VAL(TglCompressedTexSubImage1DARB, GetProcAddress('glCompressedTexSubImage1DARB'));
     glGetCompressedTexImageARB := SYSTEM.VAL(TglGetCompressedTexImageARB, GetProcAddress('glGetCompressedTexImageARB'));
END Read_GL_ARB_texture_compression;

PROCEDURE Read_GL_ARB_transpose_matrix;
BEGIN
     glLoadTransposeMatrixfARB := SYSTEM.VAL(TglLoadTransposeMatrixfARB, GetProcAddress('glLoadTransposeMatrixfARB'));
     glLoadTransposeMatrixdARB := SYSTEM.VAL(TglLoadTransposeMatrixdARB, GetProcAddress('glLoadTransposeMatrixdARB'));
     glMultTransposeMatrixfARB := SYSTEM.VAL(TglMultTransposeMatrixfARB, GetProcAddress('glMultTransposeMatrixfARB'));
     glMultTransposeMatrixdARB := SYSTEM.VAL(TglMultTransposeMatrixdARB, GetProcAddress('glMultTransposeMatrixdARB'));
END Read_GL_ARB_transpose_matrix;

PROCEDURE Read_GL_ARB_vertex_blend;
BEGIN
     glWeightbvARB := SYSTEM.VAL(TglWeightbvARB, GetProcAddress('glWeightbvARB'));
     glWeightsvARB := SYSTEM.VAL(TglWeightsvARB, GetProcAddress('glWeightsvARB'));
     glWeightivARB := SYSTEM.VAL(TglWeightivARB, GetProcAddress('glWeightivARB'));
     glWeightfvARB := SYSTEM.VAL(TglWeightfvARB, GetProcAddress('glWeightfvARB'));
     glWeightdvARB := SYSTEM.VAL(TglWeightdvARB, GetProcAddress('glWeightdvARB'));
     glWeightubvARB := SYSTEM.VAL(TglWeightubvARB, GetProcAddress('glWeightubvARB'));
     glWeightusvARB := SYSTEM.VAL(TglWeightusvARB, GetProcAddress('glWeightusvARB'));
     glWeightuivARB := SYSTEM.VAL(TglWeightuivARB, GetProcAddress('glWeightuivARB'));
     glWeightPointerARB := SYSTEM.VAL(TglWeightPointerARB, GetProcAddress('glWeightPointerARB'));
     glVertexBlendARB := SYSTEM.VAL(TglVertexBlendARB, GetProcAddress('glVertexBlendARB'));
END Read_GL_ARB_vertex_blend;

PROCEDURE Read_GL_ARB_vertex_buffer_object;
BEGIN
     glBindBufferARB := SYSTEM.VAL(TglBindBufferARB, GetProcAddress('glBindBufferARB'));
     glDeleteBuffersARB := SYSTEM.VAL(TglDeleteBuffersARB, GetProcAddress('glDeleteBuffersARB'));
     glGenBuffersARB := SYSTEM.VAL(TglGenBuffersARB, GetProcAddress('glGenBuffersARB'));
     glIsBufferARB := SYSTEM.VAL(TglIsBufferARB, GetProcAddress('glIsBufferARB'));
     glBufferDataARB := SYSTEM.VAL(TglBufferDataARB, GetProcAddress('glBufferDataARB'));
     glBufferSubDataARB := SYSTEM.VAL(TglBufferSubData, GetProcAddress('glBufferSubDataARB'));
     glGetBufferSubDataARB := SYSTEM.VAL(TglGetBufferSubDataARB, GetProcAddress('glGetBufferSubDataARB'));
     glMapBufferARB := SYSTEM.VAL(TglMapBufferARB, GetProcAddress('glMapBufferARB'));
     glUnmapBufferARB := SYSTEM.VAL(TglUnmapBufferARB, GetProcAddress('glUnmapBufferARB'));
     glGetBufferParameterivARB := SYSTEM.VAL(TglGetBufferParameterivARB, GetProcAddress('glGetBufferParameterivARB'));
     glGetBufferPointervARB := SYSTEM.VAL(TglGetBufferPointervARB, GetProcAddress('glGetBufferPointervARB'));
END Read_GL_ARB_vertex_buffer_object;

PROCEDURE Read_GL_ARB_vertex_program;
BEGIN
     glVertexAttrib1dARB := SYSTEM.VAL(TglVertexAttrib1dARB, GetProcAddress('glVertexAttrib1dARB'));
     glVertexAttrib1dvARB := SYSTEM.VAL(TglVertexAttrib1dvARB, GetProcAddress('glVertexAttrib1dvARB'));
     glVertexAttrib1fARB := SYSTEM.VAL(TglVertexAttrib1fARB, GetProcAddress('glVertexAttrib1fARB'));
     glVertexAttrib1fvARB := SYSTEM.VAL(TglVertexAttrib1fvARB, GetProcAddress('glVertexAttrib1fvARB'));
     glVertexAttrib1sARB := SYSTEM.VAL(TglVertexAttrib1sARB, GetProcAddress('glVertexAttrib1sARB'));
     glVertexAttrib1svARB := SYSTEM.VAL(TglVertexAttrib1svARB, GetProcAddress('glVertexAttrib1svARB'));
     glVertexAttrib2dARB := SYSTEM.VAL(TglVertexAttrib2dARB, GetProcAddress('glVertexAttrib2dARB'));
     glVertexAttrib2dvARB := SYSTEM.VAL(TglVertexAttrib2dvARB, GetProcAddress('glVertexAttrib2dvARB'));
     glVertexAttrib2fARB := SYSTEM.VAL(TglVertexAttrib2fARB, GetProcAddress('glVertexAttrib2fARB'));
     glVertexAttrib2fvARB := SYSTEM.VAL(TglVertexAttrib2fvARB, GetProcAddress('glVertexAttrib2fvARB'));
     glVertexAttrib2sARB := SYSTEM.VAL(TglVertexAttrib2sARB, GetProcAddress('glVertexAttrib2sARB'));
     glVertexAttrib2svARB := SYSTEM.VAL(TglVertexAttrib2svARB, GetProcAddress('glVertexAttrib2svARB'));
     glVertexAttrib3dARB := SYSTEM.VAL(TglVertexAttrib3dARB, GetProcAddress('glVertexAttrib3dARB'));
     glVertexAttrib3dvARB := SYSTEM.VAL(TglVertexAttrib3dvARB, GetProcAddress('glVertexAttrib3dvARB'));
     glVertexAttrib3fARB := SYSTEM.VAL(TglVertexAttrib3fARB, GetProcAddress('glVertexAttrib3fARB'));
     glVertexAttrib3fvARB := SYSTEM.VAL(TglVertexAttrib3fvARB, GetProcAddress('glVertexAttrib3fvARB'));
     glVertexAttrib3sARB := SYSTEM.VAL(TglVertexAttrib3sARB, GetProcAddress('glVertexAttrib3sARB'));
     glVertexAttrib3svARB := SYSTEM.VAL(TglVertexAttrib3svARB, GetProcAddress('glVertexAttrib3svARB'));
     glVertexAttrib4NbvARB := SYSTEM.VAL(TglVertexAttrib4NbvARB, GetProcAddress('glVertexAttrib4NbvARB'));
     glVertexAttrib4NivARB := SYSTEM.VAL(TglVertexAttrib4NivARB, GetProcAddress('glVertexAttrib4NivARB'));
     glVertexAttrib4NsvARB := SYSTEM.VAL(TglVertexAttrib4NsvARB, GetProcAddress('glVertexAttrib4NsvARB'));
     glVertexAttrib4NubARB := SYSTEM.VAL(TglVertexAttrib4NubARB, GetProcAddress('glVertexAttrib4NubARB'));
     glVertexAttrib4NubvARB := SYSTEM.VAL(TglVertexAttrib4NubvARB, GetProcAddress('glVertexAttrib4NubvARB'));
     glVertexAttrib4NuivARB := SYSTEM.VAL(TglVertexAttrib4NuivARB, GetProcAddress('glVertexAttrib4NuivARB'));
     glVertexAttrib4NusvARB := SYSTEM.VAL(TglVertexAttrib4NusvARB, GetProcAddress('glVertexAttrib4NusvARB'));
     glVertexAttrib4bvARB := SYSTEM.VAL(TglVertexAttrib4bvARB, GetProcAddress('glVertexAttrib4bvARB'));
     glVertexAttrib4dARB := SYSTEM.VAL(TglVertexAttrib4dARB, GetProcAddress('glVertexAttrib4dARB'));
     glVertexAttrib4dvARB := SYSTEM.VAL(TglVertexAttrib4dvARB, GetProcAddress('glVertexAttrib4dvARB'));
     glVertexAttrib4fARB := SYSTEM.VAL(TglVertexAttrib4fARB, GetProcAddress('glVertexAttrib4fARB'));
     glVertexAttrib4fvARB := SYSTEM.VAL(TglVertexAttrib4fvARB, GetProcAddress('glVertexAttrib4fvARB'));
     glVertexAttrib4ivARB := SYSTEM.VAL(TglVertexAttrib4ivARB, GetProcAddress('glVertexAttrib4ivARB'));
     glVertexAttrib4sARB := SYSTEM.VAL(TglVertexAttrib4sARB, GetProcAddress('glVertexAttrib4sARB'));
     glVertexAttrib4svARB := SYSTEM.VAL(TglVertexAttrib4svARB, GetProcAddress('glVertexAttrib4svARB'));
     glVertexAttrib4ubvARB := SYSTEM.VAL(TglVertexAttrib4ubvARB, GetProcAddress('glVertexAttrib4ubvARB'));
     glVertexAttrib4uivARB := SYSTEM.VAL(TglVertexAttrib4uivARB, GetProcAddress('glVertexAttrib4uivARB'));
     glVertexAttrib4usvARB := SYSTEM.VAL(TglVertexAttrib4usvARB, GetProcAddress('glVertexAttrib4usvARB'));
     glVertexAttribPointerARB := SYSTEM.VAL(TglVertexAttribPointerARB, GetProcAddress('glVertexAttribPointerARB'));
     glEnableVertexAttribArrayARB := SYSTEM.VAL(TglEnableVertexAttribArrayARB, GetProcAddress('glEnableVertexAttribArrayARB'));
     glDisableVertexAttribArrayARB := SYSTEM.VAL(TglDisableVertexAttribArrayARB, GetProcAddress('glDisableVertexAttribArrayARB'));
     glProgramStringARB := SYSTEM.VAL(TglProgramStringARB, GetProcAddress('glProgramStringARB'));
     glBindProgramARB := SYSTEM.VAL(TglBindProgramARB, GetProcAddress('glBindProgramARB'));
     glDeleteProgramsARB := SYSTEM.VAL(TglDeleteProgramsARB, GetProcAddress('glDeleteProgramsARB'));
     glGenProgramsARB := SYSTEM.VAL(TglGenProgramsARB, GetProcAddress('glGenProgramsARB'));
     glProgramEnvParameter4dARB := SYSTEM.VAL(TglProgramEnvParameter4dARB, GetProcAddress('glProgramEnvParameter4dARB'));
     glProgramEnvParameter4dvARB := SYSTEM.VAL(TglProgramEnvParameter4dvARB, GetProcAddress('glProgramEnvParameter4dvARB'));
     glProgramEnvParameter4fARB := SYSTEM.VAL(TglProgramEnvParameter4fARB, GetProcAddress('glProgramEnvParameter4fARB'));
     glProgramEnvParameter4fvARB := SYSTEM.VAL(TglProgramEnvParameter4fvARB, GetProcAddress('glProgramEnvParameter4fvARB'));
     glProgramLocalParameter4dARB := SYSTEM.VAL(TglProgramLocalParameter4dARB, GetProcAddress('glProgramLocalParameter4dARB'));
     glProgramLocalParameter4dvARB := SYSTEM.VAL(TglProgramLocalParameter4dvARB, GetProcAddress('glProgramLocalParameter4dvARB'));
     glProgramLocalParameter4fARB := SYSTEM.VAL(TglProgramLocalParameter4fARB, GetProcAddress('glProgramLocalParameter4fARB'));
     glProgramLocalParameter4fvARB := SYSTEM.VAL(TglProgramLocalParameter4fvARB, GetProcAddress('glProgramLocalParameter4fvARB'));
     glGetProgramEnvParameterdvARB := SYSTEM.VAL(TglGetProgramEnvParameterdvARB, GetProcAddress('glGetProgramEnvParameterdvARB'));
     glGetProgramEnvParameterfvARB := SYSTEM.VAL(TglGetProgramEnvParameterfvARB, GetProcAddress('glGetProgramEnvParameterfvARB'));
     glGetProgramLocalParameterdvARB := SYSTEM.VAL(TglGetProgramLocalParameterdvARB, GetProcAddress('glGetProgramLocalParameterdvARB'));
     glGetProgramLocalParameterfvARB := SYSTEM.VAL(TglGetProgramLocalParameterfvARB, GetProcAddress('glGetProgramLocalParameterfvARB'));
     glGetProgramivARB := SYSTEM.VAL(TglGetProgramivARB, GetProcAddress('glGetProgramivARB'));
     glGetProgramStringARB := SYSTEM.VAL(TglGetProgramStringARB, GetProcAddress('glGetProgramStringARB'));
     glGetVertexAttribdvARB := SYSTEM.VAL(TglGetVertexAttribdvARB, GetProcAddress('glGetVertexAttribdvARB'));
     glGetVertexAttribfvARB := SYSTEM.VAL(TglGetVertexAttribfvARB, GetProcAddress('glGetVertexAttribfvARB'));
     glGetVertexAttribivARB := SYSTEM.VAL(TglGetVertexAttribivARB, GetProcAddress('glGetVertexAttribivARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, GetProcAddress('glGetVertexAttribPointervARB'));
     glIsProgramARB := SYSTEM.VAL(TglIsProgramARB, GetProcAddress('glIsProgramARB'));
END Read_GL_ARB_vertex_program;

PROCEDURE Read_GL_ARB_window_pos;
BEGIN
     glWindowPos2dARB := SYSTEM.VAL(TglWindowPos2dARB, GetProcAddress('glWindowPos2dARB'));
     glWindowPos2dvARB := SYSTEM.VAL(TglWindowPos2dvARB, GetProcAddress('glWindowPos2dvARB'));
     glWindowPos2fARB := SYSTEM.VAL(TglWindowPos2fARB, GetProcAddress('glWindowPos2fARB'));
     glWindowPos2fvARB := SYSTEM.VAL(TglWindowPos2fvARB, GetProcAddress('glWindowPos2fvARB'));
     glWindowPos2iARB := SYSTEM.VAL(TglWindowPos2iARB, GetProcAddress('glWindowPos2iARB'));
     glWindowPos2ivARB := SYSTEM.VAL(TglWindowPos2ivARB, GetProcAddress('glWindowPos2ivARB'));
     glWindowPos2sARB := SYSTEM.VAL(TglWindowPos2sARB, GetProcAddress('glWindowPos2sARB'));
     glWindowPos2svARB := SYSTEM.VAL(TglWindowPos2svARB, GetProcAddress('glWindowPos2svARB'));
     glWindowPos3dARB := SYSTEM.VAL(TglWindowPos3dARB, GetProcAddress('glWindowPos3dARB'));
     glWindowPos3dvARB := SYSTEM.VAL(TglWindowPos3dvARB, GetProcAddress('glWindowPos3dvARB'));
     glWindowPos3fARB := SYSTEM.VAL(TglWindowPos3fARB, GetProcAddress('glWindowPos3fARB'));
     glWindowPos3fvARB := SYSTEM.VAL(TglWindowPos3fvARB, GetProcAddress('glWindowPos3fvARB'));
     glWindowPos3iARB := SYSTEM.VAL(TglWindowPos3iARB, GetProcAddress('glWindowPos3iARB'));
     glWindowPos3ivARB := SYSTEM.VAL(TglWindowPos3ivARB, GetProcAddress('glWindowPos3ivARB'));
     glWindowPos3sARB := SYSTEM.VAL(TglWindowPos3sARB, GetProcAddress('glWindowPos3sARB'));
     glWindowPos3svARB := SYSTEM.VAL(TglWindowPos3svARB, GetProcAddress('glWindowPos3svARB'));
END Read_GL_ARB_window_pos;

PROCEDURE Read_GL_ARB_draw_buffers;
BEGIN
     glDrawBuffersARB := SYSTEM.VAL(TglDrawBuffersARB, GetProcAddress('glDrawBuffersARB'));
END Read_GL_ARB_draw_buffers;

PROCEDURE Read_GL_ARB_color_buffer_float;
BEGIN
     glClampColorARB := SYSTEM.VAL(TglClampColorARB, GetProcAddress('glClampColorARB'));
END Read_GL_ARB_color_buffer_float;

PROCEDURE Read_GL_ARB_Shader_Objects;
BEGIN
(*  GL_ARB_Shader_Objects *)
     glCreateShaderObjectARB := SYSTEM.VAL(TglCreateShaderObjectARB, GetProcAddress('glCreateShaderObjectARB'));
     glShaderSourceARB := SYSTEM.VAL(TglShaderSourceARB, GetProcAddress('glShaderSourceARB'));
     glCompileShaderARB := SYSTEM.VAL(TglCompileShaderARB, GetProcAddress('glCompileShaderARB'));
     glDeleteObjectARB := SYSTEM.VAL(TglDeleteObjectARB, GetProcAddress('glDeleteObjectARB'));
     glGetHandleARB := SYSTEM.VAL(TglGetHandleARB, GetProcAddress('glGetHandleARB'));
     glDetachObjectARB := SYSTEM.VAL(TglDetachObjectARB, GetProcAddress('glDetachObjectARB'));
     glCreateProgramObjectARB := SYSTEM.VAL(TglCreateProgramObjectARB, GetProcAddress('glCreateProgramObjectARB'));
     glAttachObjectARB := SYSTEM.VAL(TglAttachObjectARB, GetProcAddress('glAttachObjectARB'));
     glLinkProgramARB := SYSTEM.VAL(TglLinkProgramARB, GetProcAddress('glLinkProgramARB'));
     glUseProgramObjectARB := SYSTEM.VAL(TglUseProgramObjectARB, GetProcAddress('glUseProgramObjectARB'));
     glValidateProgramARB := SYSTEM.VAL(TglValidateProgramARB, GetProcAddress('glValidateProgramARB'));
     glGetObjectParameterfvARB := SYSTEM.VAL(TglGetObjectParameterfvARB, GetProcAddress('glGetObjectParameterfvARB'));
     glGetObjectParameterivARB := SYSTEM.VAL(TglGetObjectParameterivARB, GetProcAddress('glGetObjectParameterivARB'));
     glGetActiveUniformARB := SYSTEM.VAL(TglGetActiveUniformARB, GetProcAddress('glGetActiveUniformARB'));
     glGetAttachedObjectsARB := SYSTEM.VAL(TglGetAttachedObjectsARB, GetProcAddress('glGetAttachedObjectsARB'));
     glGetShaderSourceARB := SYSTEM.VAL(TglGetShaderSourceARB, GetProcAddress('glGetShaderSourceARB'));
     glGetUniformfvARB := SYSTEM.VAL(TglGetUniformfvARB, GetProcAddress('glGetUniformfvARB'));
     glGetUniformivARB := SYSTEM.VAL(TglGetUniformivARB, GetProcAddress('glGetUniformivARB'));
     glGetUniformLocationARB := SYSTEM.VAL(TglGetUniformLocationARB, GetProcAddress('glGetUniformLocationARB'));
     glGetInfoLogARB := SYSTEM.VAL(TglGetInfoLogARB, GetProcAddress('glGetInfoLogARB'));
     glUniform1fARB := SYSTEM.VAL(TglUniform1fARB, GetProcAddress('glUniform1fARB'));
     glUniform2fARB := SYSTEM.VAL(TglUniform2fARB, GetProcAddress('glUniform2fARB'));
     glUniform3fARB := SYSTEM.VAL(TglUniform3fARB, GetProcAddress('glUniform3fARB'));
     glUniform4fARB := SYSTEM.VAL(TglUniform4fARB, GetProcAddress('glUniform4fARB'));
     glUniform1iARB := SYSTEM.VAL(TglUniform1iARB, GetProcAddress('glUniform1iARB'));
     glUniform2iARB := SYSTEM.VAL(TglUniform2iARB, GetProcAddress('glUniform2iARB'));
     glUniform3iARB := SYSTEM.VAL(TglUniform3iARB, GetProcAddress('glUniform3iARB'));
     glUniform4iARB := SYSTEM.VAL(TglUniform4iARB, GetProcAddress('glUniform4iARB'));
     glUniform1fvARB := SYSTEM.VAL(TglUniform1fvARB, GetProcAddress('glUniform1fvARB'));
     glUniform2fvARB := SYSTEM.VAL(TglUniform2fvARB, GetProcAddress('glUniform2fvARB'));
     glUniform3fvARB := SYSTEM.VAL(TglUniform3fvARB, GetProcAddress('glUniform3fvARB'));
     glUniform4fvARB := SYSTEM.VAL(TglUniform4fvARB, GetProcAddress('glUniform4fvARB'));
     glUniform1ivARB := SYSTEM.VAL(TglUniform1ivARB, GetProcAddress('glUniform1ivARB'));
     glUniform2ivARB := SYSTEM.VAL(TglUniform2ivARB, GetProcAddress('glUniform2ivARB'));
     glUniform3ivARB := SYSTEM.VAL(TglUniform3ivARB, GetProcAddress('glUniform3ivARB'));
     glUniform4ivARB := SYSTEM.VAL(TglUniform4ivARB, GetProcAddress('glUniform4ivARB'));
     glUniformMatrix2fvARB := SYSTEM.VAL(TglUniformMatrix2fvARB, GetProcAddress('glUniformMatrix2fvARB'));
     glUniformMatrix3fvARB := SYSTEM.VAL(TglUniformMatrix3fvARB, GetProcAddress('glUniformMatrix3fvARB'));
     glUniformMatrix4fvARB := SYSTEM.VAL(TglUniformMatrix4fvARB, GetProcAddress('glUniformMatrix4fvARB'));

	(* GL_ARB_vertex_shader *)
     glGetActiveAttribARB := SYSTEM.VAL(TglGetActiveAttribARB, GetProcAddress('glGetActiveAttribARB'));
     glGetAttribLocationARB := SYSTEM.VAL(TglGetAttribLocationARB, GetProcAddress('glGetAttribLocationARB'));
     glBindAttribLocationARB := SYSTEM.VAL(TglBindAttribLocationARB, GetProcAddress('glBindAttribLocationARB'));
     glGetVertexAttribPointervARB := SYSTEM.VAL(TglGetVertexAttribPointervARB, GetProcAddress('glGetVertexAttribPointervARB'));
END Read_GL_ARB_Shader_Objects;

PROCEDURE Read_GL_ARB_occlusion_query;
BEGIN
     glGenQueriesARB := SYSTEM.VAL(TglGenQueriesARB, GetProcAddress('glGenQueriesARB'));
     glDeleteQueriesARB := SYSTEM.VAL(TglDeleteQueriesARB, GetProcAddress('glDeleteQueriesARB'));
     glIsQueryARB := SYSTEM.VAL(TglIsQueryARB, GetProcAddress('glIsQueryARB'));
     glBeginQueryARB := SYSTEM.VAL(TglBeginQueryARB, GetProcAddress('glBeginQueryARB'));
     glEndQueryARB := SYSTEM.VAL(TglEndQueryARB, GetProcAddress('glEndQueryARB'));
     glGetQueryivARB := SYSTEM.VAL(TglGetQueryivARB, GetProcAddress('glGetQueryivARB'));
     glGetQueryObjectivARB := SYSTEM.VAL(TglGetQueryObjectivARB, GetProcAddress('glGetQueryObjectivARB'));
     glGetQueryObjectuivARB := SYSTEM.VAL(TglGetQueryObjectuivARB, GetProcAddress('glGetQueryObjectuivARB'));
END Read_GL_ARB_occlusion_query;

PROCEDURE Read_GL_ARB_draw_instanced;
BEGIN
     glDrawArraysInstancedARB := SYSTEM.VAL(TglDrawArraysInstancedARB, GetProcAddress('glDrawArraysInstancedARB'));
     glDrawElementsInstancedARB := SYSTEM.VAL(TglDrawElementsInstancedARB, GetProcAddress('glDrawElementsInstancedARB'));
END Read_GL_ARB_draw_instanced;

PROCEDURE Read_GL_ARB_framebuffer_object;
BEGIN
     glIsRenderbuffer := SYSTEM.VAL(TglIsRenderbuffer, GetProcAddress('glIsRenderbuffer'));
     glBindRenderbuffer := SYSTEM.VAL(TglBindRenderbuffer, GetProcAddress('glBindRenderbuffer'));
     glDeleteRenderbuffers := SYSTEM.VAL(TglDeleteRenderbuffers, GetProcAddress('glDeleteRenderbuffers'));
     glGenRenderbuffers := SYSTEM.VAL(TglGenRenderbuffers, GetProcAddress('glGenRenderbuffers'));
     glRenderbufferStorage := SYSTEM.VAL(TglRenderbufferStorage, GetProcAddress('glRenderbufferStorage'));
     glGetRenderbufferParameteriv := SYSTEM.VAL(TglGetRenderbufferParameteriv, GetProcAddress('glGetRenderbufferParameteriv'));
     glIsFramebuffer := SYSTEM.VAL(TglIsFramebuffer, GetProcAddress('glIsFramebuffer'));
     glBindFramebuffer := SYSTEM.VAL(TglBindFramebuffer, GetProcAddress('glBindFramebuffer'));
     glDeleteFramebuffers := SYSTEM.VAL(TglDeleteFramebuffers, GetProcAddress('glDeleteFramebuffers'));
     glGenFramebuffers := SYSTEM.VAL(TglGenFramebuffers, GetProcAddress('glGenFramebuffers'));
     glCheckFramebufferStatus := SYSTEM.VAL(TglCheckFramebufferStatus, GetProcAddress('glCheckFramebufferStatus'));
     glFramebufferTexture1D := SYSTEM.VAL(TglFramebufferTexture1D, GetProcAddress('glFramebufferTexture1D'));
     glFramebufferTexture2D := SYSTEM.VAL(TglFramebufferTexture2D, GetProcAddress('glFramebufferTexture2D'));
     glFramebufferTexture3D := SYSTEM.VAL(TglFramebufferTexture3D, GetProcAddress('glFramebufferTexture3D'));
     glFramebufferRenderbuffer := SYSTEM.VAL(TglFramebufferRenderbuffer, GetProcAddress('glFramebufferRenderbuffer'));
     glGetFramebufferAttachmentParameteriv := SYSTEM.VAL(TglGetFramebufferAttachmentParameteriv, GetProcAddress('glGetFramebufferAttachmentParameteriv'));
     glGenerateMipmap := SYSTEM.VAL(TglGenerateMipmap, GetProcAddress('glGenerateMipmap'));
     glBlitFramebuffer := SYSTEM.VAL(TglBlitFramebuffer, GetProcAddress('glBlitFramebuffer'));
     glRenderbufferStorageMultisample := SYSTEM.VAL(TglRenderbufferStorageMultisample, GetProcAddress('glRenderbufferStorageMultisample'));
     glFramebufferTextureLayer := SYSTEM.VAL(TglFramebufferTextureLayer, GetProcAddress('glFramebufferTextureLayer'));
END Read_GL_ARB_framebuffer_object;

PROCEDURE Read_GL_ARB_geometry_shader4;
BEGIN
     glProgramParameteriARB := SYSTEM.VAL(TglProgramParameteriARB, GetProcAddress('glProgramParameteriARB'));
     glFramebufferTextureARB := SYSTEM.VAL(TglFramebufferTextureARB, GetProcAddress('glFramebufferTextureARB'));
     glFramebufferTextureLayerARB := SYSTEM.VAL(TglFramebufferTextureLayerARB, GetProcAddress('glFramebufferTextureLayerARB'));
     glFramebufferTextureFaceARB := SYSTEM.VAL(TglFramebufferTextureFaceARB, GetProcAddress('glFramebufferTextureFaceARB'));
END Read_GL_ARB_geometry_shader4;

PROCEDURE Read_GL_ARB_instanced_arrays;
BEGIN
     glVertexAttribDivisorARB := SYSTEM.VAL(TglVertexAttribDivisorARB, GetProcAddress('glVertexAttribDivisorARB'));
END Read_GL_ARB_instanced_arrays;

PROCEDURE Read_GL_ARB_map_buffer_range;
BEGIN
     glMapBufferRange := SYSTEM.VAL(TglMapBufferRange, GetProcAddress('glMapBufferRange'));
     glFlushMappedBufferRange := SYSTEM.VAL(TglFlushMappedBufferRange, GetProcAddress('glFlushMappedBufferRange'));
END Read_GL_ARB_map_buffer_range;

PROCEDURE Read_GL_ARB_texture_buffer_object;
BEGIN
     glTexBufferARB := SYSTEM.VAL(TglTexBufferARB, GetProcAddress('glTexBufferARB'));
END Read_GL_ARB_texture_buffer_object;

PROCEDURE Read_GL_ARB_vertex_array_object;
BEGIN
     glBindVertexArray := SYSTEM.VAL(TglBindVertexArray, GetProcAddress('glBindVertexArray'));
     glDeleteVertexArrays := SYSTEM.VAL(TglDeleteVertexArrays, GetProcAddress('glDeleteVertexArrays'));
     glGenVertexArrays := SYSTEM.VAL(TglGenVertexArrays, GetProcAddress('glGenVertexArrays'));
     glIsVertexArray := SYSTEM.VAL(TglIsVertexArray, GetProcAddress('glIsVertexArray'));
END Read_GL_ARB_vertex_array_object;

PROCEDURE Read_GL_ARB_uniform_buffer_object;
BEGIN
     glGetUniformIndices := SYSTEM.VAL(TglGetUniformIndices, GetProcAddress('glGetUniformIndices'));
     glGetActiveUniformsiv := SYSTEM.VAL(TglGetActiveUniformsiv, GetProcAddress('glGetActiveUniformsiv'));
     glGetActiveUniformName := SYSTEM.VAL(TglGetActiveUniformName, GetProcAddress('glGetActiveUniformName'));
     glGetUniformBlockIndex := SYSTEM.VAL(TglGetUniformBlockIndex, GetProcAddress('glGetUniformBlockIndex'));
     glGetActiveUniformBlockiv := SYSTEM.VAL(TglGetActiveUniformBlockiv, GetProcAddress('glGetActiveUniformBlockiv'));
     glGetActiveUniformBlockName := SYSTEM.VAL(TglGetActiveUniformBlockName, GetProcAddress('glGetActiveUniformBlockName'));
     glUniformBlockBinding := SYSTEM.VAL(TglUniformBlockBinding, GetProcAddress('glUniformBlockBinding'));
END Read_GL_ARB_uniform_buffer_object;

PROCEDURE Read_GL_ARB_copy_buffer;
BEGIN
     glCopyBufferSubData := SYSTEM.VAL(TglCopyBufferSubData, GetProcAddress('glCopyBufferSubData'));
END Read_GL_ARB_copy_buffer;

PROCEDURE Read_GL_ARB_draw_elements_base_vertex;
BEGIN
     glDrawElementsBaseVertex := SYSTEM.VAL(TglDrawElementsBaseVertex, GetProcAddress('glDrawElementsBaseVertex'));
     glDrawRangeElementsBaseVertex := SYSTEM.VAL(TglDrawRangeElementsBaseVertex, GetProcAddress('glDrawRangeElementsBaseVertex'));
     glDrawElementsInstancedBaseVertex := SYSTEM.VAL(TglDrawElementsInstancedBaseVertex, GetProcAddress('glDrawElementsInstancedBaseVertex'));
     glMultiDrawElementsBaseVertex := SYSTEM.VAL(TglMultiDrawElementsBaseVertex, GetProcAddress('glMultiDrawElementsBaseVertex'));
END Read_GL_ARB_draw_elements_base_vertex;

PROCEDURE Read_GL_ARB_provoking_vertex;
BEGIN
     glProvokingVertex := SYSTEM.VAL(TglProvokingVertex, GetProcAddress('glProvokingVertex'));
END Read_GL_ARB_provoking_vertex;

PROCEDURE Read_GL_ARB_sync;
BEGIN
     glFenceSync := SYSTEM.VAL(TglFenceSync, GetProcAddress('glFenceSync'));
     glIsSync := SYSTEM.VAL(TglIsSync, GetProcAddress('glIsSync'));
     glDeleteSync := SYSTEM.VAL(TglDeleteSync, GetProcAddress('glDeleteSync'));
     glClientWaitSync := SYSTEM.VAL(TglClientWaitSync, GetProcAddress('glClientWaitSync'));
     glWaitSync := SYSTEM.VAL(TglWaitSync, GetProcAddress('glWaitSync'));
     glGetInteger64v := SYSTEM.VAL(TglGetInteger64v, GetProcAddress('glGetInteger64v'));
     glGetSynciv := SYSTEM.VAL(TglGetSynciv, GetProcAddress('glGetSynciv'));
END Read_GL_ARB_sync;

PROCEDURE Read_GL_ARB_texture_multisample;
BEGIN
     glTexImage2DMultisample := SYSTEM.VAL(TglTexImage2DMultisample, GetProcAddress('glTexImage2DMultisample'));
     glTexImage3DMultisample := SYSTEM.VAL(TglTexImage3DMultisample, GetProcAddress('glTexImage3DMultisample'));
     glGetMultisamplefv := SYSTEM.VAL(TglGetMultisamplefv, GetProcAddress('glGetMultisamplefv'));
     glSampleMaski := SYSTEM.VAL(TglSampleMaski, GetProcAddress('glSampleMaski'));
END Read_GL_ARB_texture_multisample;

PROCEDURE Read_GL_ARB_draw_buffers_blend;
BEGIN
     glBlendEquationiARB := SYSTEM.VAL(TglBlendEquationiARB, GetProcAddress('glBlendEquationiARB'));
     glBlendEquationSeparateiARB := SYSTEM.VAL(TglBlendEquationSeparateiARB, GetProcAddress('glBlendEquationSeparateiARB'));
     glBlendFunciARB := SYSTEM.VAL(TglBlendFunciARB, GetProcAddress('glBlendFunciARB'));
     glBlendFuncSeparateiARB := SYSTEM.VAL(TglBlendFuncSeparateiARB, GetProcAddress('glBlendFuncSeparateiARB'));
END Read_GL_ARB_draw_buffers_blend;

PROCEDURE Read_GL_ARB_sample_shading;
BEGIN
     glMinSampleShadingARB := SYSTEM.VAL(TglMinSampleShadingARB, GetProcAddress('glMinSampleShadingARB'));
END Read_GL_ARB_sample_shading;

PROCEDURE Read_GL_ARB_shading_language_include;
BEGIN
     glNamedStringARB := SYSTEM.VAL(TglNamedStringARB, GetProcAddress('glNamedStringARB'));
     glDeleteNamedStringARB := SYSTEM.VAL(TglDeleteNamedStringARB, GetProcAddress('glDeleteNamedStringARB'));
     glCompileShaderIncludeARB := SYSTEM.VAL(TglCompileShaderIncludeARB, GetProcAddress('glCompileShaderIncludeARB'));
     glIsNamedStringARB := SYSTEM.VAL(TglIsNamedStringARB, GetProcAddress('glIsNamedStringARB'));
     glGetNamedStringARB := SYSTEM.VAL(TglGetNamedStringARB, GetProcAddress('glGetNamedStringARB'));
     glGetNamedStringivARB := SYSTEM.VAL(TglGetNamedStringivARB, GetProcAddress('glGetNamedStringivARB'));
END Read_GL_ARB_shading_language_include;

PROCEDURE Read_GL_ARB_blend_func_extended;
BEGIN
     glBindFragDataLocationIndexed := SYSTEM.VAL(TglBindFragDataLocationIndexed, GetProcAddress('glBindFragDataLocationIndexed'));
     glGetFragDataIndex := SYSTEM.VAL(TglGetFragDataIndex, GetProcAddress('glGetFragDataIndex'));
END Read_GL_ARB_blend_func_extended;

PROCEDURE Read_GL_ARB_sampler_objects;
BEGIN
     glGenSamplers := SYSTEM.VAL(TglGenSamplers, GetProcAddress('glGenSamplers'));
     glDeleteSamplers := SYSTEM.VAL(TglDeleteSamplers, GetProcAddress('glDeleteSamplers'));
     glIsSampler := SYSTEM.VAL(TglIsSampler, GetProcAddress('glIsSampler'));
     glBindSampler := SYSTEM.VAL(TglBindSampler, GetProcAddress('glBindSampler'));
     glSamplerParameteri := SYSTEM.VAL(TglSamplerParameteri, GetProcAddress('glSamplerParameteri'));
     glSamplerParameteriv := SYSTEM.VAL(TglSamplerParameteriv, GetProcAddress('glSamplerParameteriv'));
     glSamplerParameterf := SYSTEM.VAL(TglSamplerParameterf, GetProcAddress('glSamplerParameterf'));
     glSamplerParameterfv := SYSTEM.VAL(TglSamplerParameterfv, GetProcAddress('glSamplerParameterfv'));
     glSamplerParameterIiv := SYSTEM.VAL(TglSamplerParameterIiv, GetProcAddress('glSamplerParameterIiv'));
     glSamplerParameterIuiv := SYSTEM.VAL(TglSamplerParameterIuiv, GetProcAddress('glSamplerParameterIuiv'));
     glGetSamplerParameteriv := SYSTEM.VAL(TglGetSamplerParameteriv, GetProcAddress('glGetSamplerParameteriv'));
     glGetSamplerParameterIiv := SYSTEM.VAL(TglGetSamplerParameterIiv, GetProcAddress('glGetSamplerParameterIiv'));
     glGetSamplerParameterfv := SYSTEM.VAL(TglGetSamplerParameterfv, GetProcAddress('glGetSamplerParameterfv'));
     glGetSamplerParameterIuiv := SYSTEM.VAL(TglGetSamplerParameterIuiv, GetProcAddress('glGetSamplerParameterIuiv'));
END Read_GL_ARB_sampler_objects;

PROCEDURE Read_GL_ARB_timer_query;
BEGIN
     glQueryCounter := SYSTEM.VAL(TglQueryCounter, GetProcAddress('glQueryCounter'));
     glGetQueryObjecti64v := SYSTEM.VAL(TglGetQueryObjecti64v, GetProcAddress('glGetQueryObjecti64v'));
     glGetQueryObjectui64v := SYSTEM.VAL(TglGetQueryObjectui64v, GetProcAddress('glGetQueryObjectui64v'));
END Read_GL_ARB_timer_query;

PROCEDURE Read_GL_ARB_vertexxtype_2_10_10_10_rev;
BEGIN
     glVertexP2ui := SYSTEM.VAL(TglVertexP2ui, GetProcAddress('glVertexP2ui'));
     glVertexP2uiv := SYSTEM.VAL(TglVertexP2uiv, GetProcAddress('glVertexP2uiv'));
     glVertexP3ui := SYSTEM.VAL(TglVertexP3ui, GetProcAddress('glVertexP3ui'));
     glVertexP3uiv := SYSTEM.VAL(TglVertexP3uiv, GetProcAddress('glVertexP3uiv'));
     glVertexP4ui := SYSTEM.VAL(TglVertexP4ui, GetProcAddress('glVertexP4ui'));
     glVertexP4uiv := SYSTEM.VAL(TglVertexP4uiv, GetProcAddress('glVertexP4uiv'));
     glTexCoordP1ui := SYSTEM.VAL(TglTexCoordP1ui, GetProcAddress('glTexCoordP1ui'));
     glTexCoordP1uiv := SYSTEM.VAL(TglTexCoordP1uiv, GetProcAddress('glTexCoordP1uiv'));
     glTexCoordP2ui := SYSTEM.VAL(TglTexCoordP2ui, GetProcAddress('glTexCoordP2ui'));
     glTexCoordP2uiv := SYSTEM.VAL(TglTexCoordP2uiv, GetProcAddress('glTexCoordP2uiv'));
     glTexCoordP3ui := SYSTEM.VAL(TglTexCoordP3ui, GetProcAddress('glTexCoordP3ui'));
     glTexCoordP3uiv := SYSTEM.VAL(TglTexCoordP3uiv, GetProcAddress('glTexCoordP3uiv'));
     glTexCoordP4ui := SYSTEM.VAL(TglTexCoordP4ui, GetProcAddress('glTexCoordP4ui'));
     glTexCoordP4uiv := SYSTEM.VAL(TglTexCoordP4uiv, GetProcAddress('glTexCoordP4uiv'));
     glMultiTexCoordP1ui := SYSTEM.VAL(TglMultiTexCoordP1ui, GetProcAddress('glMultiTexCoordP1ui'));
     glMultiTexCoordP1uiv := SYSTEM.VAL(TglMultiTexCoordP1uiv, GetProcAddress('glMultiTexCoordP1uiv'));
     glMultiTexCoordP2ui := SYSTEM.VAL(TglMultiTexCoordP2ui, GetProcAddress('glMultiTexCoordP2ui'));
     glMultiTexCoordP2uiv := SYSTEM.VAL(TglMultiTexCoordP2uiv, GetProcAddress('glMultiTexCoordP2uiv'));
     glMultiTexCoordP3ui := SYSTEM.VAL(TglMultiTexCoordP3ui, GetProcAddress('glMultiTexCoordP3ui'));
     glMultiTexCoordP3uiv := SYSTEM.VAL(TglMultiTexCoordP3uiv, GetProcAddress('glMultiTexCoordP3uiv'));
     glMultiTexCoordP4ui := SYSTEM.VAL(TglMultiTexCoordP4ui, GetProcAddress('glMultiTexCoordP4ui'));
     glMultiTexCoordP4uiv := SYSTEM.VAL(TglMultiTexCoordP4uiv, GetProcAddress('glMultiTexCoordP4uiv'));
     glNormalP3ui := SYSTEM.VAL(TglNormalP3ui, GetProcAddress('glNormalP3ui'));
     glNormalP3uiv := SYSTEM.VAL(TglNormalP3uiv, GetProcAddress('glNormalP3uiv'));
     glColorP3ui := SYSTEM.VAL(TglColorP3ui, GetProcAddress('glColorP3ui'));
     glColorP3uiv := SYSTEM.VAL(TglColorP3uiv, GetProcAddress('glColorP3uiv'));
     glColorP4ui := SYSTEM.VAL(TglColorP4ui, GetProcAddress('glColorP4ui'));
     glColorP4uiv := SYSTEM.VAL(TglColorP4uiv, GetProcAddress('glColorP4uiv'));
     glSecondaryColorP3ui := SYSTEM.VAL(TglSecondaryColorP3ui, GetProcAddress('glSecondaryColorP3ui'));
     glSecondaryColorP3uiv := SYSTEM.VAL(TglSecondaryColorP3uiv, GetProcAddress('glSecondaryColorP3uiv'));
     glVertexAttribP1ui := SYSTEM.VAL(TglVertexAttribP1ui, GetProcAddress('glVertexAttribP1ui'));
     glVertexAttribP1uiv := SYSTEM.VAL(TglVertexAttribP1uiv, GetProcAddress('glVertexAttribP1uiv'));
     glVertexAttribP2ui := SYSTEM.VAL(TglVertexAttribP2ui, GetProcAddress('glVertexAttribP2ui'));
     glVertexAttribP2uiv := SYSTEM.VAL(TglVertexAttribP2uiv, GetProcAddress('glVertexAttribP2uiv'));
     glVertexAttribP3ui := SYSTEM.VAL(TglVertexAttribP3ui, GetProcAddress('glVertexAttribP3ui'));
     glVertexAttribP3uiv := SYSTEM.VAL(TglVertexAttribP3uiv, GetProcAddress('glVertexAttribP3uiv'));
     glVertexAttribP4ui := SYSTEM.VAL(TglVertexAttribP4ui, GetProcAddress('glVertexAttribP4ui'));
     glVertexAttribP4uiv := SYSTEM.VAL(TglVertexAttribP4uiv, GetProcAddress('glVertexAttribP4uiv'));
END Read_GL_ARB_vertexxtype_2_10_10_10_rev;

PROCEDURE Read_GL_ARB_draw_indirect;
BEGIN
     glDrawArraysIndirect := SYSTEM.VAL(TglDrawArraysIndirect, GetProcAddress('glDrawArraysIndirect'));
     glDrawElementsIndirect := SYSTEM.VAL(TglDrawElementsIndirect, GetProcAddress('glDrawElementsIndirect'));
END Read_GL_ARB_draw_indirect;

PROCEDURE Read_GL_ARB_gpu_shader_fp64;
BEGIN
     glUniform1d := SYSTEM.VAL(TglUniform1d, GetProcAddress('glUniform1d'));
     glUniform2d := SYSTEM.VAL(TglUniform2d, GetProcAddress('glUniform2d'));
     glUniform3d := SYSTEM.VAL(TglUniform3d, GetProcAddress('glUniform3d'));
     glUniform4d := SYSTEM.VAL(TglUniform4d, GetProcAddress('glUniform4d'));
     glUniform1dv := SYSTEM.VAL(TglUniform1dv, GetProcAddress('glUniform1dv'));
     glUniform2dv := SYSTEM.VAL(TglUniform2dv, GetProcAddress('glUniform2dv'));
     glUniform3dv := SYSTEM.VAL(TglUniform3dv, GetProcAddress('glUniform3dv'));
     glUniform4dv := SYSTEM.VAL(TglUniform4dv, GetProcAddress('glUniform4dv'));
     glUniformMatrix2dv := SYSTEM.VAL(TglUniformMatrix2dv, GetProcAddress('glUniformMatrix2dv'));
     glUniformMatrix3dv := SYSTEM.VAL(TglUniformMatrix3dv, GetProcAddress('glUniformMatrix3dv'));
     glUniformMatrix4dv := SYSTEM.VAL(TglUniformMatrix4dv, GetProcAddress('glUniformMatrix4dv'));
     glUniformMatrix2x3dv := SYSTEM.VAL(TglUniformMatrix2x3dv, GetProcAddress('glUniformMatrix2x3dv'));
     glUniformMatrix2x4dv := SYSTEM.VAL(TglUniformMatrix2x4dv, GetProcAddress('glUniformMatrix2x4dv'));
     glUniformMatrix3x2dv := SYSTEM.VAL(TglUniformMatrix3x2dv, GetProcAddress('glUniformMatrix3x2dv'));
     glUniformMatrix3x4dv := SYSTEM.VAL(TglUniformMatrix3x4dv, GetProcAddress('glUniformMatrix3x4dv'));
     glUniformMatrix4x2dv := SYSTEM.VAL(TglUniformMatrix4x2dv, GetProcAddress('glUniformMatrix4x2dv'));
     glUniformMatrix4x3dv := SYSTEM.VAL(TglUniformMatrix4x3dv, GetProcAddress('glUniformMatrix4x3dv'));
     glGetUniformdv := SYSTEM.VAL(TglGetUniformdv, GetProcAddress('glGetUniformdv'));
END Read_GL_ARB_gpu_shader_fp64;

PROCEDURE Read_GL_ARB_shader_subroutine;
BEGIN
     glGetSubroutineUniformLocation := SYSTEM.VAL(TglGetSubroutineUniformLocation, GetProcAddress('glGetSubroutineUniformLocation'));
     glGetSubroutineIndex := SYSTEM.VAL(TglGetSubroutineIndex, GetProcAddress('glGetSubroutineIndex'));
     glGetActiveSubroutineUniformiv := SYSTEM.VAL(TglGetActiveSubroutineUniformiv, GetProcAddress('glGetActiveSubroutineUniformiv'));
     glGetActiveSubroutineUniformName := SYSTEM.VAL(TglGetActiveSubroutineUniformName, GetProcAddress('glGetActiveSubroutineUniformName'));
     glGetActiveSubroutineName := SYSTEM.VAL(TglGetActiveSubroutineName, GetProcAddress('glGetActiveSubroutineName'));
     glUniformSubroutinesuiv := SYSTEM.VAL(TglUniformSubroutinesuiv, GetProcAddress('glUniformSubroutinesuiv'));
     glGetUniformSubroutineuiv := SYSTEM.VAL(TglGetUniformSubroutineuiv, GetProcAddress('glGetUniformSubroutineuiv'));
     glGetProgramStageiv := SYSTEM.VAL(TglGetProgramStageiv, GetProcAddress('glGetProgramStageiv'));
END Read_GL_ARB_shader_subroutine;

PROCEDURE Read_GL_ARB_tessellation_shader;
BEGIN
     glPatchParameteri := SYSTEM.VAL(TglPatchParameteri, GetProcAddress('glPatchParameteri'));
     glPatchParameterfv := SYSTEM.VAL(TglPatchParameterfv, GetProcAddress('glPatchParameterfv'));
END Read_GL_ARB_tessellation_shader;

PROCEDURE Read_GL_ARB_transform_feedback2;
BEGIN
     glBindTransformFeedback := SYSTEM.VAL(TglBindTransformFeedback, GetProcAddress('glBindTransformFeedback'));
     glDeleteTransformFeedbacks := SYSTEM.VAL(TglDeleteTransformFeedbacks, GetProcAddress('glDeleteTransformFeedbacks'));
     glGenTransformFeedbacks := SYSTEM.VAL(TglGenTransformFeedbacks, GetProcAddress('glGenTransformFeedbacks'));
     glIsTransformFeedback := SYSTEM.VAL(TglIsTransformFeedback, GetProcAddress('glIsTransformFeedback'));
     glPauseTransformFeedback := SYSTEM.VAL(TglPauseTransformFeedback, GetProcAddress('glPauseTransformFeedback'));
     glResumeTransformFeedback := SYSTEM.VAL(TglResumeTransformFeedback, GetProcAddress('glResumeTransformFeedback'));
     glDrawTransformFeedback := SYSTEM.VAL(TglDrawTransformFeedback, GetProcAddress('glDrawTransformFeedback'));
END Read_GL_ARB_transform_feedback2;

PROCEDURE Read_GL_ARB_transform_feedback3;
BEGIN
     glDrawTransformFeedbackStream := SYSTEM.VAL(TglDrawTransformFeedbackStream, GetProcAddress('glDrawTransformFeedbackStream'));
     glBeginQueryIndexed := SYSTEM.VAL(TglBeginQueryIndexed, GetProcAddress('glBeginQueryIndexed'));
     glEndQueryIndexed := SYSTEM.VAL(TglEndQueryIndexed, GetProcAddress('glEndQueryIndexed'));
     glGetQueryIndexediv := SYSTEM.VAL(TglGetQueryIndexediv, GetProcAddress('glGetQueryIndexediv'));
END Read_GL_ARB_transform_feedback3;

PROCEDURE Read_GL_ARB_ES2_compatibility;
BEGIN
     glReleaseShaderCompiler := SYSTEM.VAL(TglReleaseShaderCompiler, GetProcAddress('glReleaseShaderCompiler'));
     glShaderBinary := SYSTEM.VAL(TglShaderBinary, GetProcAddress('glShaderBinary'));
     glGetShaderPrecisionFormat := SYSTEM.VAL(TglGetShaderPrecisionFormat, GetProcAddress('glGetShaderPrecisionFormat'));
     glDepthRangef := SYSTEM.VAL(TglDepthRangef, GetProcAddress('glDepthRangef'));
     glClearDepthf := SYSTEM.VAL(TglClearDepthf, GetProcAddress('glClearDepthf'));
END Read_GL_ARB_ES2_compatibility;

PROCEDURE Read_GL_ARB_get_program_binary;
BEGIN
     glGetProgramBinary := SYSTEM.VAL(TglGetProgramBinary, GetProcAddress('glGetProgramBinary'));
     glProgramBinary := SYSTEM.VAL(TglProgramBinary, GetProcAddress('glProgramBinary'));
     glProgramParameteri := SYSTEM.VAL(TglProgramParameteri, GetProcAddress('glProgramParameteri'));
END Read_GL_ARB_get_program_binary;

PROCEDURE Read_GL_ARB_separate_shader_objects;
BEGIN
     glUseProgramStages := SYSTEM.VAL(TglUseProgramStages, GetProcAddress('glUseProgramStages'));
     glActiveShaderProgram := SYSTEM.VAL(TglActiveShaderProgram, GetProcAddress('glActiveShaderProgram'));
     glCreateShaderProgramv := SYSTEM.VAL(TglCreateShaderProgramv, GetProcAddress('glCreateShaderProgramv'));
     glBindProgramPipeline := SYSTEM.VAL(TglBindProgramPipeline, GetProcAddress('glBindProgramPipeline'));
     glDeleteProgramPipelines := SYSTEM.VAL(TglDeleteProgramPipelines, GetProcAddress('glDeleteProgramPipelines'));
     glGenProgramPipelines := SYSTEM.VAL(TglGenProgramPipelines, GetProcAddress('glGenProgramPipelines'));
     glIsProgramPipeline := SYSTEM.VAL(TglIsProgramPipeline, GetProcAddress('glIsProgramPipeline'));
     glGetProgramPipelineiv := SYSTEM.VAL(TglGetProgramPipelineiv, GetProcAddress('glGetProgramPipelineiv'));
     glProgramUniform1i := SYSTEM.VAL(TglProgramUniform1i, GetProcAddress('glProgramUniform1i'));
     glProgramUniform1iv := SYSTEM.VAL(TglProgramUniform1iv, GetProcAddress('glProgramUniform1iv'));
     glProgramUniform1f := SYSTEM.VAL(TglProgramUniform1f, GetProcAddress('glProgramUniform1f'));
     glProgramUniform1fv := SYSTEM.VAL(TglProgramUniform1fv, GetProcAddress('glProgramUniform1fv'));
     glProgramUniform1d := SYSTEM.VAL(TglProgramUniform1d, GetProcAddress('glProgramUniform1d'));
     glProgramUniform1dv := SYSTEM.VAL(TglProgramUniform1dv, GetProcAddress('glProgramUniform1dv'));
     glProgramUniform1ui := SYSTEM.VAL(TglProgramUniform1ui, GetProcAddress('glProgramUniform1ui'));
     glProgramUniform1uiv := SYSTEM.VAL(TglProgramUniform1uiv, GetProcAddress('glProgramUniform1uiv'));
     glProgramUniform2i := SYSTEM.VAL(TglProgramUniform2i, GetProcAddress('glProgramUniform2i'));
     glProgramUniform2iv := SYSTEM.VAL(TglProgramUniform2iv, GetProcAddress('glProgramUniform2iv'));
     glProgramUniform2f := SYSTEM.VAL(TglProgramUniform2f, GetProcAddress('glProgramUniform2f'));
     glProgramUniform2fv := SYSTEM.VAL(TglProgramUniform2fv, GetProcAddress('glProgramUniform2fv'));
     glProgramUniform2d := SYSTEM.VAL(TglProgramUniform2d, GetProcAddress('glProgramUniform2d'));
     glProgramUniform2dv := SYSTEM.VAL(TglProgramUniform2dv, GetProcAddress('glProgramUniform2dv'));
     glProgramUniform2ui := SYSTEM.VAL(TglProgramUniform2ui, GetProcAddress('glProgramUniform2ui'));
     glProgramUniform2uiv := SYSTEM.VAL(TglProgramUniform2uiv, GetProcAddress('glProgramUniform2uiv'));
     glProgramUniform3i := SYSTEM.VAL(TglProgramUniform3i, GetProcAddress('glProgramUniform3i'));
     glProgramUniform3iv := SYSTEM.VAL(TglProgramUniform3iv, GetProcAddress('glProgramUniform3iv'));
     glProgramUniform3f := SYSTEM.VAL(TglProgramUniform3f, GetProcAddress('glProgramUniform3f'));
     glProgramUniform3fv := SYSTEM.VAL(TglProgramUniform3fv, GetProcAddress('glProgramUniform3fv'));
     glProgramUniform3d := SYSTEM.VAL(TglProgramUniform3d, GetProcAddress('glProgramUniform3d'));
     glProgramUniform3dv := SYSTEM.VAL(TglProgramUniform3dv, GetProcAddress('glProgramUniform3dv'));
     glProgramUniform3ui := SYSTEM.VAL(TglProgramUniform3ui, GetProcAddress('glProgramUniform3ui'));
     glProgramUniform3uiv := SYSTEM.VAL(TglProgramUniform3uiv, GetProcAddress('glProgramUniform3uiv'));
     glProgramUniform4i := SYSTEM.VAL(TglProgramUniform4i, GetProcAddress('glProgramUniform4i'));
     glProgramUniform4iv := SYSTEM.VAL(TglProgramUniform4iv, GetProcAddress('glProgramUniform4iv'));
     glProgramUniform4f := SYSTEM.VAL(TglProgramUniform4f, GetProcAddress('glProgramUniform4f'));
     glProgramUniform4fv := SYSTEM.VAL(TglProgramUniform4fv, GetProcAddress('glProgramUniform4fv'));
     glProgramUniform4d := SYSTEM.VAL(TglProgramUniform4d, GetProcAddress('glProgramUniform4d'));
     glProgramUniform4dv := SYSTEM.VAL(TglProgramUniform4dv, GetProcAddress('glProgramUniform4dv'));
     glProgramUniform4ui := SYSTEM.VAL(TglProgramUniform4ui, GetProcAddress('glProgramUniform4ui'));
     glProgramUniform4uiv := SYSTEM.VAL(TglProgramUniform4uiv, GetProcAddress('glProgramUniform4uiv'));
     glProgramUniformMatrix2fv := SYSTEM.VAL(TglProgramUniformMatrix2fv, GetProcAddress('glProgramUniformMatrix2fv'));
     glProgramUniformMatrix3fv := SYSTEM.VAL(TglProgramUniformMatrix3fv, GetProcAddress('glProgramUniformMatrix3fv'));
     glProgramUniformMatrix4fv := SYSTEM.VAL(TglProgramUniformMatrix4fv, GetProcAddress('glProgramUniformMatrix4fv'));
     glProgramUniformMatrix2dv := SYSTEM.VAL(TglProgramUniformMatrix2dv, GetProcAddress('glProgramUniformMatrix2dv'));
     glProgramUniformMatrix3dv := SYSTEM.VAL(TglProgramUniformMatrix3dv, GetProcAddress('glProgramUniformMatrix3dv'));
     glProgramUniformMatrix4dv := SYSTEM.VAL(TglProgramUniformMatrix4dv, GetProcAddress('glProgramUniformMatrix4dv'));
     glProgramUniformMatrix2x3fv := SYSTEM.VAL(TglProgramUniformMatrix2x3fv, GetProcAddress('glProgramUniformMatrix2x3fv'));
     glProgramUniformMatrix3x2fv := SYSTEM.VAL(TglProgramUniformMatrix3x2fv, GetProcAddress('glProgramUniformMatrix3x2fv'));
     glProgramUniformMatrix2x4fv := SYSTEM.VAL(TglProgramUniformMatrix2x4fv, GetProcAddress('glProgramUniformMatrix2x4fv'));
     glProgramUniformMatrix4x2fv := SYSTEM.VAL(TglProgramUniformMatrix4x2fv, GetProcAddress('glProgramUniformMatrix4x2fv'));
     glProgramUniformMatrix3x4fv := SYSTEM.VAL(TglProgramUniformMatrix3x4fv, GetProcAddress('glProgramUniformMatrix3x4fv'));
     glProgramUniformMatrix4x3fv := SYSTEM.VAL(TglProgramUniformMatrix4x3fv, GetProcAddress('glProgramUniformMatrix4x3fv'));
     glProgramUniformMatrix2x3dv := SYSTEM.VAL(TglProgramUniformMatrix2x3dv, GetProcAddress('glProgramUniformMatrix2x3dv'));
     glProgramUniformMatrix3x2dv := SYSTEM.VAL(TglProgramUniformMatrix3x2dv, GetProcAddress('glProgramUniformMatrix3x2dv'));
     glProgramUniformMatrix2x4dv := SYSTEM.VAL(TglProgramUniformMatrix2x4dv, GetProcAddress('glProgramUniformMatrix2x4dv'));
     glProgramUniformMatrix4x2dv := SYSTEM.VAL(TglProgramUniformMatrix4x2dv, GetProcAddress('glProgramUniformMatrix4x2dv'));
     glProgramUniformMatrix3x4dv := SYSTEM.VAL(TglProgramUniformMatrix3x4dv, GetProcAddress('glProgramUniformMatrix3x4dv'));
     glProgramUniformMatrix4x3dv := SYSTEM.VAL(TglProgramUniformMatrix4x3dv, GetProcAddress('glProgramUniformMatrix4x3dv'));
     glValidateProgramPipeline := SYSTEM.VAL(TglValidateProgramPipeline, GetProcAddress('glValidateProgramPipeline'));
     glGetProgramPipelineInfoLog := SYSTEM.VAL(TglGetProgramPipelineInfoLog, GetProcAddress('glGetProgramPipelineInfoLog'));
END Read_GL_ARB_separate_shader_objects;

PROCEDURE Read_GL_ARB_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1d := SYSTEM.VAL(TglVertexAttribL1d, GetProcAddress('glVertexAttribL1d'));
     glVertexAttribL2d := SYSTEM.VAL(TglVertexAttribL2d, GetProcAddress('glVertexAttribL2d'));
     glVertexAttribL3d := SYSTEM.VAL(TglVertexAttribL3d, GetProcAddress('glVertexAttribL3d'));
     glVertexAttribL4d := SYSTEM.VAL(TglVertexAttribL4d, GetProcAddress('glVertexAttribL4d'));
     glVertexAttribL1dv := SYSTEM.VAL(TglVertexAttribL1dv, GetProcAddress('glVertexAttribL1dv'));
     glVertexAttribL2dv := SYSTEM.VAL(TglVertexAttribL2dv, GetProcAddress('glVertexAttribL2dv'));
     glVertexAttribL3dv := SYSTEM.VAL(TglVertexAttribL3dv, GetProcAddress('glVertexAttribL3dv'));
     glVertexAttribL4dv := SYSTEM.VAL(TglVertexAttribL4dv, GetProcAddress('glVertexAttribL4dv'));
     glVertexAttribLPointer := SYSTEM.VAL(TglVertexAttribLPointer, GetProcAddress('glVertexAttribLPointer'));
     glGetVertexAttribLdv := SYSTEM.VAL(TglGetVertexAttribLdv, GetProcAddress('glGetVertexAttribLdv'));
END Read_GL_ARB_vertex_attrib_64bit;

PROCEDURE Read_GL_ARB_viewport_array;
BEGIN
     glViewportArrayv := SYSTEM.VAL(TglViewportArrayv, GetProcAddress('glViewportArrayv'));
     glViewportIndexedf := SYSTEM.VAL(TglViewportIndexedf, GetProcAddress('glViewportIndexedf'));
     glViewportIndexedfv := SYSTEM.VAL(TglViewportIndexedfv, GetProcAddress('glViewportIndexedfv'));
     glScissorArrayv := SYSTEM.VAL(TglScissorArrayv, GetProcAddress('glScissorArrayv'));
     glScissorIndexed := SYSTEM.VAL(TglScissorIndexed, GetProcAddress('glScissorIndexed'));
     glScissorIndexedv := SYSTEM.VAL(TglScissorIndexedv, GetProcAddress('glScissorIndexedv'));
     glDepthRangeArrayv := SYSTEM.VAL(TglDepthRangeArrayv, GetProcAddress('glDepthRangeArrayv'));
     glDepthRangeIndexed := SYSTEM.VAL(TglDepthRangeIndexed, GetProcAddress('glDepthRangeIndexed'));
     glGetFloati_v := SYSTEM.VAL(TglGetFloati_v, GetProcAddress('glGetFloati_v'));
     glGetDoublei_v := SYSTEM.VAL(TglGetDoublei_v, GetProcAddress('glGetDoublei_v'));
END Read_GL_ARB_viewport_array;

(*! GL 4.2 *)
PROCEDURE Read_GL_ARB_base_instance;
BEGIN
     glDrawArraysInstancedBaseInstance := SYSTEM.VAL(TglDrawArraysInstancedBaseInstance, GetProcAddress('glDrawArraysInstancedBaseInstance'));
     glDrawElementsInstancedBaseInstance := SYSTEM.VAL(TglDrawElementsInstancedBaseInstance, GetProcAddress('glDrawElementsInstancedBaseInstance'));
     glDrawElementsInstancedBaseVertexBaseInstance := SYSTEM.VAL(TglDrawElementsInstancedBaseVertexBaseInstance, GetProcAddress('glDrawElementsInstancedBaseVertexBaseInstance'));
END Read_GL_ARB_base_instance;

PROCEDURE Read_GL_ARB_transform_feedback_instanced;
BEGIN
     glDrawTransformFeedbackInstanced := SYSTEM.VAL(TglDrawTransformFeedbackInstanced, GetProcAddress('glDrawTransformFeedbackInstanced'));
     glDrawTransformFeedbackStreamInstanced := SYSTEM.VAL(TglDrawTransformFeedbackStreamInstanced, GetProcAddress('glDrawTransformFeedbackStreamInstanced'));
END Read_GL_ARB_transform_feedback_instanced;

PROCEDURE Read_GL_ARB_internalformat_query;
BEGIN
     glGetInternalformativ := SYSTEM.VAL(TglGetInternalformativ, GetProcAddress('glGetInternalformativ'));
END Read_GL_ARB_internalformat_query;

PROCEDURE Read_GL_ARB_shader_atomic_counters;
BEGIN
     glGetActiveAtomicCounterBufferiv := SYSTEM.VAL(TglGetActiveAtomicCounterBufferiv, GetProcAddress('glGetActiveAtomicCounterBufferiv'));
END Read_GL_ARB_shader_atomic_counters;

PROCEDURE Read_GL_ARB_shader_image_load_store;
BEGIN
     glBindImageTexture := SYSTEM.VAL(TglBindImageTexture, GetProcAddress('glBindImageTexture'));
     glMemoryBarrier := SYSTEM.VAL(TglMemoryBarrier, GetProcAddress('glMemoryBarrier'));
END Read_GL_ARB_shader_image_load_store;

PROCEDURE Read_GL_ARB_texture_storage;
BEGIN
     glTexStorage1D := SYSTEM.VAL(TglTexStorage1D, GetProcAddress('glTexStorage1D'));
     glTexStorage2D := SYSTEM.VAL(TglTexStorage2D, GetProcAddress('glTexStorage2D'));
     glTexStorage3D := SYSTEM.VAL(TglTexStorage3D, GetProcAddress('glTexStorage3D'));
     glTextureStorage1DEXT := SYSTEM.VAL(TglTextureStorage1DEXT, GetProcAddress('glTextureStorage1DEXT'));
     glTextureStorage2DEXT := SYSTEM.VAL(TglTextureStorage2DEXT, GetProcAddress('glTextureStorage2DEXT'));
     glTextureStorage3DEXT := SYSTEM.VAL(TglTextureStorage3DEXT, GetProcAddress('glTextureStorage3DEXT'));
END Read_GL_ARB_texture_storage;


(************)


PROCEDURE Read_GL_ARB_cl_event;
BEGIN
     glCreateSyncFromCLeventARB := SYSTEM.VAL(TglCreateSyncFromCLeventARB, GetProcAddress('glCreateSyncFromCLeventARB'));
END Read_GL_ARB_cl_event;

PROCEDURE Read_GL_ARB_debug_output;
BEGIN
     glDebugMessageControlARB := SYSTEM.VAL(TglDebugMessageControlARB, GetProcAddress('glDebugMessageControlARB'));
     glDebugMessageInsertARB := SYSTEM.VAL(TglDebugMessageInsertARB, GetProcAddress('glDebugMessageInsertARB'));
(*     glDebugMessageCallbackARB := SYSTEM.VAL(TglDebugMessageCallbackARB, GetProcAddress('glDebugMessageCallbackARB')); *)
     glGetDebugMessageLogARB := SYSTEM.VAL(TglGetDebugMessageLogARB, GetProcAddress('glGetDebugMessageLogARB'));
END Read_GL_ARB_debug_output;

PROCEDURE Read_GL_ARB_robustness;
BEGIN
     glGetGraphicsResetStatusARB := SYSTEM.VAL(TglGetGraphicsResetStatusARB, GetProcAddress('glGetGraphicsResetStatusARB'));
     glGetnMapdvARB := SYSTEM.VAL(TglGetnMapdvARB, GetProcAddress('glGetnMapdvARB'));
     glGetnMapfvARB := SYSTEM.VAL(TglGetnMapfvARB, GetProcAddress('glGetnMapfvARB'));
     glGetnMapivARB := SYSTEM.VAL(TglGetnMapivARB, GetProcAddress('glGetnMapivARB'));
     glGetnPixelMapfvARB := SYSTEM.VAL(TglGetnPixelMapfvARB, GetProcAddress('glGetnPixelMapfvARB'));
     glGetnPixelMapuivARB := SYSTEM.VAL(TglGetnPixelMapuivARB, GetProcAddress('glGetnPixelMapuivARB'));
     glGetnPixelMapusvARB := SYSTEM.VAL(TglGetnPixelMapusvARB, GetProcAddress('glGetnPixelMapusvARB'));
     glGetnPolygonStippleARB := SYSTEM.VAL(TglGetnPolygonStippleARB, GetProcAddress('glGetnPolygonStippleARB'));
     glGetnColorTableARB := SYSTEM.VAL(TglGetnColorTableARB, GetProcAddress('glGetnColorTableARB'));
     glGetnConvolutionFilterARB := SYSTEM.VAL(TglGetnConvolutionFilterARB, GetProcAddress('glGetnConvolutionFilterARB'));
     glGetnSeparableFilterARB := SYSTEM.VAL(TglGetnSeparableFilterARB, GetProcAddress('glGetnSeparableFilterARB'));
     glGetnHistogramARB := SYSTEM.VAL(TglGetnHistogramARB, GetProcAddress('glGetnHistogramARB'));
     glGetnMinmaxARB := SYSTEM.VAL(TglGetnMinmaxARB, GetProcAddress('glGetnMinmaxARB'));
     glGetnTexImageARB := SYSTEM.VAL(TglGetnTexImageARB, GetProcAddress('glGetnTexImageARB'));
     glReadnPixelsARB := SYSTEM.VAL(TglReadnPixelsARB, GetProcAddress('glReadnPixelsARB'));
     glGetnCompressedTexImageARB := SYSTEM.VAL(TglGetnCompressedTexImageARB, GetProcAddress('glGetnCompressedTexImageARB'));
     glGetnUniformfvARB := SYSTEM.VAL(TglGetnUniformfvARB, GetProcAddress('glGetnUniformfvARB'));
     glGetnUniformivARB := SYSTEM.VAL(TglGetnUniformivARB, GetProcAddress('glGetnUniformivARB'));
     glGetnUniformuivARB := SYSTEM.VAL(TglGetnUniformuivARB, GetProcAddress('glGetnUniformuivARB'));
     glGetnUniformdvARB := SYSTEM.VAL(TglGetnUniformdvARB, GetProcAddress('glGetnUniformdvARB'));
END Read_GL_ARB_robustness;

PROCEDURE Read_GL_ATI_draw_buffers;
BEGIN
     glDrawBuffersATI := SYSTEM.VAL(TglDrawBuffersATI, GetProcAddress('glDrawBuffersATI'));
END Read_GL_ATI_draw_buffers;

PROCEDURE Read_GL_ATI_element_array;
BEGIN
     glElementPointerATI := SYSTEM.VAL(TglElementPointerATI, GetProcAddress('glElementPointerATI'));
     glDrawElementArrayATI := SYSTEM.VAL(TglDrawElementArrayATI, GetProcAddress('glDrawElementArrayATI'));
     glDrawRangeElementArrayATI := SYSTEM.VAL(TglDrawRangeElementArrayATI, GetProcAddress('glDrawRangeElementArrayATI'));
END Read_GL_ATI_element_array;

PROCEDURE Read_GL_ATI_envmap_bumpmap;
BEGIN
     glTexBumpParameterivATI := SYSTEM.VAL(TglTexBumpParameterivATI, GetProcAddress('glTexBumpParameterivATI'));
     glTexBumpParameterfvATI := SYSTEM.VAL(TglTexBumpParameterfvATI, GetProcAddress('glTexBumpParameterfvATI'));
     glGetTexBumpParameterivATI := SYSTEM.VAL(TglGetTexBumpParameterivATI, GetProcAddress('glGetTexBumpParameterivATI'));
     glGetTexBumpParameterfvATI := SYSTEM.VAL(TglGetTexBumpParameterfvATI, GetProcAddress('glGetTexBumpParameterfvATI'));
END Read_GL_ATI_envmap_bumpmap;

PROCEDURE Read_GL_ATI_fragment_shader;
BEGIN
     glGenFragmentShadersATI := SYSTEM.VAL(TglGenFragmentShadersATI, GetProcAddress('glGenFragmentShadersATI'));
     glBindFragmentShaderATI := SYSTEM.VAL(TglBindFragmentShaderATI, GetProcAddress('glBindFragmentShaderATI'));
     glDeleteFragmentShaderATI := SYSTEM.VAL(TglDeleteFragmentShaderATI, GetProcAddress('glDeleteFragmentShaderATI'));
     glBeginFragmentShaderATI := SYSTEM.VAL(TglBeginFragmentShaderATI, GetProcAddress('glBeginFragmentShaderATI'));
     glEndFragmentShaderATI := SYSTEM.VAL(TglEndFragmentShaderATI, GetProcAddress('glEndFragmentShaderATI'));
     glPassTexCoordATI := SYSTEM.VAL(TglPassTexCoordATI, GetProcAddress('glPassTexCoordATI'));
     glSampleMapATI := SYSTEM.VAL(TglSampleMapATI, GetProcAddress('glSampleMapATI'));
     glColorFragmentOp1ATI := SYSTEM.VAL(TglColorFragmentOp1ATI, GetProcAddress('glColorFragmentOp1ATI'));
     glColorFragmentOp2ATI := SYSTEM.VAL(TglColorFragmentOp2ATI, GetProcAddress('glColorFragmentOp2ATI'));
     glColorFragmentOp3ATI := SYSTEM.VAL(TglColorFragmentOp3ATI, GetProcAddress('glColorFragmentOp3ATI'));
     glAlphaFragmentOp1ATI := SYSTEM.VAL(TglAlphaFragmentOp1ATI, GetProcAddress('glAlphaFragmentOp1ATI'));
     glAlphaFragmentOp2ATI := SYSTEM.VAL(TglAlphaFragmentOp2ATI, GetProcAddress('glAlphaFragmentOp2ATI'));
     glAlphaFragmentOp3ATI := SYSTEM.VAL(TglAlphaFragmentOp3ATI, GetProcAddress('glAlphaFragmentOp3ATI'));
     glSetFragmentShaderConstantATI := SYSTEM.VAL(TglSetFragmentShaderConstantATI, GetProcAddress('glSetFragmentShaderConstantATI'));
END Read_GL_ATI_fragment_shader;

PROCEDURE Read_GL_ATI_map_object_buffer;
BEGIN
     glMapObjectBufferATI := SYSTEM.VAL(TglMapObjectBufferATI, GetProcAddress('glMapObjectBufferATI'));
     glUnmapObjectBufferATI := SYSTEM.VAL(TglUnmapObjectBufferATI, GetProcAddress('glUnmapObjectBufferATI'));
END Read_GL_ATI_map_object_buffer;

PROCEDURE Read_GL_ATI_pn_triangles;
BEGIN
     glPNTrianglesiATI := SYSTEM.VAL(TglPNTrianglesiATI, GetProcAddress('glPNTrianglesiATI'));
     glPNTrianglesfATI := SYSTEM.VAL(TglPNTrianglesfATI, GetProcAddress('glPNTrianglesfATI'));
END Read_GL_ATI_pn_triangles;

PROCEDURE Read_GL_ATI_separate_stencil;
BEGIN
     glStencilOpSeparateATI := SYSTEM.VAL(TglStencilOpSeparateATI, GetProcAddress('glStencilOpSeparateATI'));
     glStencilFuncSeparateATI := SYSTEM.VAL(TglStencilFuncSeparateATI, GetProcAddress('glStencilFuncSeparateATI'));
END Read_GL_ATI_separate_stencil;

PROCEDURE Read_GL_ATI_vertex_array_object;
BEGIN
     glNewObjectBufferATI := SYSTEM.VAL(TglNewObjectBufferATI, GetProcAddress('glNewObjectBufferATI'));
     glIsObjectBufferATI := SYSTEM.VAL(TglIsObjectBufferATI, GetProcAddress('glIsObjectBufferATI'));
     glUpdateObjectBufferATI := SYSTEM.VAL(TglUpdateObjectBufferATI, GetProcAddress('glUpdateObjectBufferATI'));
     glGetObjectBufferfvATI := SYSTEM.VAL(TglGetObjectBufferfvATI, GetProcAddress('glGetObjectBufferfvATI'));
     glGetObjectBufferivATI := SYSTEM.VAL(TglGetObjectBufferivATI, GetProcAddress('glGetObjectBufferivATI'));
     glFreeObjectBufferATI := SYSTEM.VAL(TglFreeObjectBufferATI, GetProcAddress('glFreeObjectBufferATI'));
     glArrayObjectATI := SYSTEM.VAL(TglArrayObjectATI, GetProcAddress('glArrayObjectATI'));
     glGetArrayObjectfvATI := SYSTEM.VAL(TglGetArrayObjectfvATI, GetProcAddress('glGetArrayObjectfvATI'));
     glGetArrayObjectivATI := SYSTEM.VAL(TglGetArrayObjectivATI, GetProcAddress('glGetArrayObjectivATI'));
     glVariantArrayObjectATI := SYSTEM.VAL(TglVariantArrayObjectATI, GetProcAddress('glVariantArrayObjectATI'));
     glGetVariantArrayObjectfvATI := SYSTEM.VAL(TglGetVariantArrayObjectfvATI, GetProcAddress('glGetVariantArrayObjectfvATI'));
     glGetVariantArrayObjectivATI := SYSTEM.VAL(TglGetVariantArrayObjectivATI, GetProcAddress('glGetVariantArrayObjectivATI'));
END Read_GL_ATI_vertex_array_object;

PROCEDURE Read_GL_ATI_vertex_attrib_array_object;
BEGIN
     glVertexAttribArrayObjectATI := SYSTEM.VAL(TglVertexAttribArrayObjectATI, GetProcAddress('glVertexAttribArrayObjectATI'));
     glGetVertexAttribArrayObjectfvATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectfvATI, GetProcAddress('glGetVertexAttribArrayObjectfvATI'));
     glGetVertexAttribArrayObjectivATI := SYSTEM.VAL(TglGetVertexAttribArrayObjectivATI, GetProcAddress('glGetVertexAttribArrayObjectivATI'));
END Read_GL_ATI_vertex_attrib_array_object;

PROCEDURE Read_GL_ATI_vertex_streams;
BEGIN
     glVertexStream1sATI := SYSTEM.VAL(TglVertexStream1sATI, GetProcAddress('glVertexStream1sATI'));
     glVertexStream1svATI := SYSTEM.VAL(TglVertexStream1svATI, GetProcAddress('glVertexStream1svATI'));
     glVertexStream1iATI := SYSTEM.VAL(TglVertexStream1iATI, GetProcAddress('glVertexStream1iATI'));
     glVertexStream1ivATI := SYSTEM.VAL(TglVertexStream1ivATI, GetProcAddress('glVertexStream1ivATI'));
     glVertexStream1fATI := SYSTEM.VAL(TglVertexStream1fATI, GetProcAddress('glVertexStream1fATI'));
     glVertexStream1fvATI := SYSTEM.VAL(TglVertexStream1fvATI, GetProcAddress('glVertexStream1fvATI'));
     glVertexStream1dATI := SYSTEM.VAL(TglVertexStream1dATI, GetProcAddress('glVertexStream1dATI'));
     glVertexStream1dvATI := SYSTEM.VAL(TglVertexStream1dvATI, GetProcAddress('glVertexStream1dvATI'));
     glVertexStream2sATI := SYSTEM.VAL(TglVertexStream2sATI, GetProcAddress('glVertexStream2sATI'));
     glVertexStream2svATI := SYSTEM.VAL(TglVertexStream2svATI, GetProcAddress('glVertexStream2svATI'));
     glVertexStream2iATI := SYSTEM.VAL(TglVertexStream2iATI, GetProcAddress('glVertexStream2iATI'));
     glVertexStream2ivATI := SYSTEM.VAL(TglVertexStream2ivATI, GetProcAddress('glVertexStream2ivATI'));
     glVertexStream2fATI := SYSTEM.VAL(TglVertexStream2fATI, GetProcAddress('glVertexStream2fATI'));
     glVertexStream2fvATI := SYSTEM.VAL(TglVertexStream2fvATI, GetProcAddress('glVertexStream2fvATI'));
     glVertexStream2dATI := SYSTEM.VAL(TglVertexStream2dATI, GetProcAddress('glVertexStream2dATI'));
     glVertexStream2dvATI := SYSTEM.VAL(TglVertexStream2dvATI, GetProcAddress('glVertexStream2dvATI'));
     glVertexStream3sATI := SYSTEM.VAL(TglVertexStream3sATI, GetProcAddress('glVertexStream3sATI'));
     glVertexStream3svATI := SYSTEM.VAL(TglVertexStream3svATI, GetProcAddress('glVertexStream3svATI'));
     glVertexStream3iATI := SYSTEM.VAL(TglVertexStream3iATI, GetProcAddress('glVertexStream3iATI'));
     glVertexStream3ivATI := SYSTEM.VAL(TglVertexStream3ivATI, GetProcAddress('glVertexStream3ivATI'));
     glVertexStream3fATI := SYSTEM.VAL(TglVertexStream3fATI, GetProcAddress('glVertexStream3fATI'));
     glVertexStream3fvATI := SYSTEM.VAL(TglVertexStream3fvATI, GetProcAddress('glVertexStream3fvATI'));
     glVertexStream3dATI := SYSTEM.VAL(TglVertexStream3dATI, GetProcAddress('glVertexStream3dATI'));
     glVertexStream3dvATI := SYSTEM.VAL(TglVertexStream3dvATI, GetProcAddress('glVertexStream3dvATI'));
     glVertexStream4sATI := SYSTEM.VAL(TglVertexStream4sATI, GetProcAddress('glVertexStream4sATI'));
     glVertexStream4svATI := SYSTEM.VAL(TglVertexStream4svATI, GetProcAddress('glVertexStream4svATI'));
     glVertexStream4iATI := SYSTEM.VAL(TglVertexStream4iATI, GetProcAddress('glVertexStream4iATI'));
     glVertexStream4ivATI := SYSTEM.VAL(TglVertexStream4ivATI, GetProcAddress('glVertexStream4ivATI'));
     glVertexStream4fATI := SYSTEM.VAL(TglVertexStream4fATI, GetProcAddress('glVertexStream4fATI'));
     glVertexStream4fvATI := SYSTEM.VAL(TglVertexStream4fvATI, GetProcAddress('glVertexStream4fvATI'));
     glVertexStream4dATI := SYSTEM.VAL(TglVertexStream4dATI, GetProcAddress('glVertexStream4dATI'));
     glVertexStream4dvATI := SYSTEM.VAL(TglVertexStream4dvATI, GetProcAddress('glVertexStream4dvATI'));
     glNormalStream3bATI := SYSTEM.VAL(TglNormalStream3bATI, GetProcAddress('glNormalStream3bATI'));
     glNormalStream3bvATI := SYSTEM.VAL(TglNormalStream3bvATI, GetProcAddress('glNormalStream3bvATI'));
     glNormalStream3sATI := SYSTEM.VAL(TglNormalStream3sATI, GetProcAddress('glNormalStream3sATI'));
     glNormalStream3svATI := SYSTEM.VAL(TglNormalStream3svATI, GetProcAddress('glNormalStream3svATI'));
     glNormalStream3iATI := SYSTEM.VAL(TglNormalStream3iATI, GetProcAddress('glNormalStream3iATI'));
     glNormalStream3ivATI := SYSTEM.VAL(TglNormalStream3ivATI, GetProcAddress('glNormalStream3ivATI'));
     glNormalStream3fATI := SYSTEM.VAL(TglNormalStream3fATI, GetProcAddress('glNormalStream3fATI'));
     glNormalStream3fvATI := SYSTEM.VAL(TglNormalStream3fvATI, GetProcAddress('glNormalStream3fvATI'));
     glNormalStream3dATI := SYSTEM.VAL(TglNormalStream3dATI, GetProcAddress('glNormalStream3dATI'));
     glNormalStream3dvATI := SYSTEM.VAL(TglNormalStream3dvATI, GetProcAddress('glNormalStream3dvATI'));
     glClientActiveVertexStreamATI := SYSTEM.VAL(TglClientActiveVertexStreamATI, GetProcAddress('glClientActiveVertexStreamATI'));
     glVertexBlendEnviATI := SYSTEM.VAL(TglVertexBlendEnviATI, GetProcAddress('glVertexBlendEnviATI'));
     glVertexBlendEnvfATI := SYSTEM.VAL(TglVertexBlendEnvfATI, GetProcAddress('glVertexBlendEnvfATI'));
END Read_GL_ATI_vertex_streams;

PROCEDURE Read_GL_AMD_performance_monitor;
BEGIN
     glGetPerfMonitorGroupsAMD := SYSTEM.VAL(TglGetPerfMonitorGroupsAMD, GetProcAddress('glGetPerfMonitorGroupsAMD'));
     glGetPerfMonitorCountersAMD := SYSTEM.VAL(TglGetPerfMonitorCountersAMD, GetProcAddress('glGetPerfMonitorCountersAMD'));
     glGetPerfMonitorGroupStringAMD := SYSTEM.VAL(TglGetPerfMonitorGroupStringAMD, GetProcAddress('glGetPerfMonitorGroupStringAMD'));
     glGetPerfMonitorCounterStringAMD := SYSTEM.VAL(TglGetPerfMonitorCounterStringAMD, GetProcAddress('glGetPerfMonitorCounterStringAMD'));
     glGetPerfMonitorCounterInfoAMD := SYSTEM.VAL(TglGetPerfMonitorCounterInfoAMD, GetProcAddress('glGetPerfMonitorCounterInfoAMD'));
     glGenPerfMonitorsAMD := SYSTEM.VAL(TglGenPerfMonitorsAMD, GetProcAddress('glGenPerfMonitorsAMD'));
     glDeletePerfMonitorsAMD := SYSTEM.VAL(TglDeletePerfMonitorsAMD, GetProcAddress('glDeletePerfMonitorsAMD'));
     glSelectPerfMonitorCountersAMD := SYSTEM.VAL(TglSelectPerfMonitorCountersAMD, GetProcAddress('glSelectPerfMonitorCountersAMD'));
     glBeginPerfMonitorAMD := SYSTEM.VAL(TglBeginPerfMonitorAMD, GetProcAddress('glBeginPerfMonitorAMD'));
     glEndPerfMonitorAMD := SYSTEM.VAL(TglEndPerfMonitorAMD, GetProcAddress('glEndPerfMonitorAMD'));
     glGetPerfMonitorCounterDataAMD := SYSTEM.VAL(TglGetPerfMonitorCounterDataAMD, GetProcAddress('glGetPerfMonitorCounterDataAMD'));
END Read_GL_AMD_performance_monitor;

PROCEDURE Read_GL_AMD_vertex_shader_tesselator;
BEGIN
     glTessellationFactorAMD := SYSTEM.VAL(TglTessellationFactorAMD, GetProcAddress('glTessellationFactorAMD'));
     glTessellationModeAMD := SYSTEM.VAL(TglTessellationModeAMD, GetProcAddress('glTessellationModeAMD'));
END Read_GL_AMD_vertex_shader_tesselator;

PROCEDURE Read_GL_AMD_draw_buffers_blend;
BEGIN
     glBlendFuncIndexedAMD := SYSTEM.VAL(TglBlendFuncIndexedAMD, GetProcAddress('glBlendFuncIndexedAMD'));
     glBlendFuncSeparateIndexedAMD := SYSTEM.VAL(TglBlendFuncSeparateIndexedAMD, GetProcAddress('glBlendFuncSeparateIndexedAMD'));
     glBlendEquationIndexedAMD := SYSTEM.VAL(TglBlendEquationIndexedAMD, GetProcAddress('glBlendEquationIndexedAMD'));
     glBlendEquationSeparateIndexedAMD := SYSTEM.VAL(TglBlendEquationSeparateIndexedAMD, GetProcAddress('glBlendEquationSeparateIndexedAMD'));
END Read_GL_AMD_draw_buffers_blend;

PROCEDURE Read_GL_AMD_name_gen_delete;
BEGIN
     glGenNamesAMD := SYSTEM.VAL(TglGenNamesAMD, GetProcAddress('glGenNamesAMD'));
     glDeleteNamesAMD := SYSTEM.VAL(TglDeleteNamesAMD, GetProcAddress('glDeleteNamesAMD'));
     glIsNameAMD := SYSTEM.VAL(TglIsNameAMD, GetProcAddress('glIsNameAMD'));
END Read_GL_AMD_name_gen_delete;

PROCEDURE Read_GL_AMD_debug_output;
BEGIN
     glDebugMessageEnableAMD := SYSTEM.VAL(TglDebugMessageEnableAMD, GetProcAddress('glDebugMessageEnableAMD'));
     glDebugMessageInsertAMD := SYSTEM.VAL(TglDebugMessageInsertAMD, GetProcAddress('glDebugMessageInsertAMD'));
(*     glDebugMessageCallbackAMD := SYSTEM.VAL(TglDebugMessageCallbackAMD, GetProcAddress('glDebugMessageCallbackAMD')); *)
     glGetDebugMessageLogAMD := SYSTEM.VAL(TglGetDebugMessageLogAMD, GetProcAddress('glGetDebugMessageLogAMD'));
END Read_GL_AMD_debug_output;

PROCEDURE Read_GL_EXT_blend_color;
BEGIN
     glBlendColorEXT := SYSTEM.VAL(TglBlendColorEXT, GetProcAddress('glBlendColorEXT'));
END Read_GL_EXT_blend_color;

PROCEDURE Read_GL_EXT_blend_func_separate;
BEGIN
     glBlendFuncSeparateEXT := SYSTEM.VAL(TglBlendFuncSeparateEXT, GetProcAddress('glBlendFuncSeparateEXT'));
END Read_GL_EXT_blend_func_separate;

PROCEDURE Read_GL_EXT_blend_minmax;
BEGIN
     glBlendEquationEXT := SYSTEM.VAL(TglBlendEquationEXT, GetProcAddress('glBlendEquationEXT'));
END Read_GL_EXT_blend_minmax;

PROCEDURE Read_GL_EXT_color_subtable;
BEGIN
     glColorSubTableEXT := SYSTEM.VAL(TglColorSubTableEXT, GetProcAddress('glColorSubTableEXT'));
     glCopyColorSubTableEXT := SYSTEM.VAL(TglCopyColorSubTableEXT, GetProcAddress('glCopyColorSubTableEXT'));
END Read_GL_EXT_color_subtable;

PROCEDURE Read_GL_EXT_compiled_vertex_array;
BEGIN
     glLockArraysEXT := SYSTEM.VAL(TglLockArraysEXT, GetProcAddress('glLockArraysEXT'));
     glUnlockArraysEXT := SYSTEM.VAL(TglUnlockArraysEXT, GetProcAddress('glUnlockArraysEXT'));
END Read_GL_EXT_compiled_vertex_array;

PROCEDURE Read_GL_EXT_convolution;
BEGIN
     glConvolutionFilter1DEXT := SYSTEM.VAL(TglConvolutionFilter1DEXT, GetProcAddress('glConvolutionFilter1DEXT'));
     glConvolutionFilter2DEXT := SYSTEM.VAL(TglConvolutionFilter2DEXT, GetProcAddress('glConvolutionFilter2DEXT'));
     glConvolutionParameterfEXT := SYSTEM.VAL(TglConvolutionParameterfEXT, GetProcAddress('glConvolutionParameterfEXT'));
     glConvolutionParameterfvEXT := SYSTEM.VAL(TglConvolutionParameterfvEXT, GetProcAddress('glConvolutionParameterfvEXT'));
     glConvolutionParameteriEXT := SYSTEM.VAL(TglConvolutionParameteriEXT, GetProcAddress('glConvolutionParameteriEXT'));
     glConvolutionParameterivEXT := SYSTEM.VAL(TglConvolutionParameterivEXT, GetProcAddress('glConvolutionParameterivEXT'));
     glCopyConvolutionFilter1DEXT := SYSTEM.VAL(TglCopyConvolutionFilter1DEXT, GetProcAddress('glCopyConvolutionFilter1DEXT'));
     glCopyConvolutionFilter2DEXT := SYSTEM.VAL(TglCopyConvolutionFilter2DEXT, GetProcAddress('glCopyConvolutionFilter2DEXT'));
     glGetConvolutionFilterEXT := SYSTEM.VAL(TglGetConvolutionFilterEXT, GetProcAddress('glGetConvolutionFilterEXT'));
     glGetConvolutionParameterfvEXT := SYSTEM.VAL(TglGetConvolutionParameterfvEXT, GetProcAddress('glGetConvolutionParameterfvEXT'));
     glGetConvolutionParameterivEXT := SYSTEM.VAL(TglGetConvolutionParameterivEXT, GetProcAddress('glGetConvolutionParameterivEXT'));
     glGetSeparableFilterEXT := SYSTEM.VAL(TglGetSeparableFilterEXT, GetProcAddress('glGetSeparableFilterEXT'));
     glSeparableFilter2DEXT := SYSTEM.VAL(TglSeparableFilter2DEXT, GetProcAddress('glSeparableFilter2DEXT'));
END Read_GL_EXT_convolution;

PROCEDURE Read_GL_EXT_coordinate_frame;
BEGIN
     glTangent3bEXT := SYSTEM.VAL(TglTangent3bEXT, GetProcAddress('glTangent3bEXT'));
     glTangent3bvEXT := SYSTEM.VAL(TglTangent3bvEXT, GetProcAddress('glTangent3bvEXT'));
     glTangent3dEXT := SYSTEM.VAL(TglTangent3dEXT, GetProcAddress('glTangent3dEXT'));
     glTangent3dvEXT := SYSTEM.VAL(TglTangent3dvEXT, GetProcAddress('glTangent3dvEXT'));
     glTangent3fEXT := SYSTEM.VAL(TglTangent3fEXT, GetProcAddress('glTangent3fEXT'));
     glTangent3fvEXT := SYSTEM.VAL(TglTangent3fvEXT, GetProcAddress('glTangent3fvEXT'));
     glTangent3iEXT := SYSTEM.VAL(TglTangent3iEXT, GetProcAddress('glTangent3iEXT'));
     glTangent3ivEXT := SYSTEM.VAL(TglTangent3ivEXT, GetProcAddress('glTangent3ivEXT'));
     glTangent3sEXT := SYSTEM.VAL(TglTangent3sEXT, GetProcAddress('glTangent3sEXT'));
     glTangent3svEXT := SYSTEM.VAL(TglTangent3svEXT, GetProcAddress('glTangent3svEXT'));
     glBinormal3bEXT := SYSTEM.VAL(TglBinormal3bEXT, GetProcAddress('glBinormal3bEXT'));
     glBinormal3bvEXT := SYSTEM.VAL(TglBinormal3bvEXT, GetProcAddress('glBinormal3bvEXT'));
     glBinormal3dEXT := SYSTEM.VAL(TglBinormal3dEXT, GetProcAddress('glBinormal3dEXT'));
     glBinormal3dvEXT := SYSTEM.VAL(TglBinormal3dvEXT, GetProcAddress('glBinormal3dvEXT'));
     glBinormal3fEXT := SYSTEM.VAL(TglBinormal3fEXT, GetProcAddress('glBinormal3fEXT'));
     glBinormal3fvEXT := SYSTEM.VAL(TglBinormal3fvEXT, GetProcAddress('glBinormal3fvEXT'));
     glBinormal3iEXT := SYSTEM.VAL(TglBinormal3iEXT, GetProcAddress('glBinormal3iEXT'));
     glBinormal3ivEXT := SYSTEM.VAL(TglBinormal3ivEXT, GetProcAddress('glBinormal3ivEXT'));
     glBinormal3sEXT := SYSTEM.VAL(TglBinormal3sEXT, GetProcAddress('glBinormal3sEXT'));
     glBinormal3svEXT := SYSTEM.VAL(TglBinormal3svEXT, GetProcAddress('glBinormal3svEXT'));
     glTangentPointerEXT := SYSTEM.VAL(TglTangentPointerEXT, GetProcAddress('glTangentPointerEXT'));
     glBinormalPointerEXT := SYSTEM.VAL(TglBinormalPointerEXT, GetProcAddress('glBinormalPointerEXT'));
END Read_GL_EXT_coordinate_frame;

PROCEDURE Read_GL_EXT_copy_texture;
BEGIN
     glCopyTexImage1DEXT := SYSTEM.VAL(TglCopyTexImage1DEXT, GetProcAddress('glCopyTexImage1DEXT'));
     glCopyTexImage2DEXT := SYSTEM.VAL(TglCopyTexImage2DEXT, GetProcAddress('glCopyTexImage2DEXT'));
     glCopyTexSubImage1DEXT := SYSTEM.VAL(TglCopyTexSubImage1DEXT, GetProcAddress('glCopyTexSubImage1DEXT'));
     glCopyTexSubImage2DEXT := SYSTEM.VAL(TglCopyTexSubImage2DEXT, GetProcAddress('glCopyTexSubImage2DEXT'));
     glCopyTexSubImage3DEXT := SYSTEM.VAL(TglCopyTexSubImage3DEXT, GetProcAddress('glCopyTexSubImage3DEXT'));
END Read_GL_EXT_copy_texture;

PROCEDURE Read_GL_EXT_cull_vertex;
BEGIN
     glCullParameterdvEXT := SYSTEM.VAL(TglCullParameterdvEXT, GetProcAddress('glCullParameterdvEXT'));
     glCullParameterfvEXT := SYSTEM.VAL(TglCullParameterfvEXT, GetProcAddress('glCullParameterfvEXT'));
END Read_GL_EXT_cull_vertex;

PROCEDURE Read_GL_EXT_draw_range_elements;
BEGIN
     glDrawRangeElementsEXT := SYSTEM.VAL(TglDrawRangeElementsEXT, GetProcAddress('glDrawRangeElementsEXT'));
END Read_GL_EXT_draw_range_elements;

PROCEDURE Read_GL_EXT_fog_coord;
BEGIN
     glFogCoordfEXT := SYSTEM.VAL(TglFogCoordfEXT, GetProcAddress('glFogCoordfEXT'));
     glFogCoordfvEXT := SYSTEM.VAL(TglFogCoordfvEXT, GetProcAddress('glFogCoordfvEXT'));
     glFogCoorddEXT := SYSTEM.VAL(TglFogCoorddEXT, GetProcAddress('glFogCoorddEXT'));
     glFogCoorddvEXT := SYSTEM.VAL(TglFogCoorddvEXT, GetProcAddress('glFogCoorddvEXT'));
     glFogCoordPointerEXT := SYSTEM.VAL(TglFogCoordPointerEXT, GetProcAddress('glFogCoordPointerEXT'));
END Read_GL_EXT_fog_coord;

PROCEDURE Read_GL_EXT_framebuffer_object;
BEGIN
     glIsRenderbufferEXT := SYSTEM.VAL(TglIsRenderbufferEXT, GetProcAddress('glIsRenderbufferEXT'));
     glBindRenderbufferEXT := SYSTEM.VAL(TglBindRenderbufferEXT, GetProcAddress('glBindRenderbufferEXT'));
     glDeleteRenderbuffersEXT := SYSTEM.VAL(TglDeleteRenderbuffersEXT, GetProcAddress('glDeleteRenderbuffersEXT'));
     glGenRenderbuffersEXT := SYSTEM.VAL(TglGenRenderbuffersEXT, GetProcAddress('glGenRenderbuffersEXT'));
     glRenderbufferStorageEXT := SYSTEM.VAL(TglRenderbufferStorageEXT, GetProcAddress('glRenderbufferStorageEXT'));
     glGetRenderbufferParameterivEXT := SYSTEM.VAL(TglGetRenderbufferParameterivEXT, GetProcAddress('glGetRenderbufferParameterivEXT'));
     glIsFramebufferEXT := SYSTEM.VAL(TglIsFramebufferEXT, GetProcAddress('glIsFramebufferEXT'));
     glBindFramebufferEXT := SYSTEM.VAL(TglBindFramebufferEXT, GetProcAddress('glBindFramebufferEXT'));
     glDeleteFramebuffersEXT := SYSTEM.VAL(TglDeleteFramebuffersEXT, GetProcAddress('glDeleteFramebuffersEXT'));
     glGenFramebuffersEXT := SYSTEM.VAL(TglGenFramebuffersEXT, GetProcAddress('glGenFramebuffersEXT'));
     glCheckFramebufferStatusEXT := SYSTEM.VAL(TglCheckFramebufferStatusEXT, GetProcAddress('glCheckFramebufferStatusEXT'));
     glFramebufferTexture1DEXT := SYSTEM.VAL(TglFramebufferTexture1DEXT, GetProcAddress('glFramebufferTexture1DEXT'));
     glFramebufferTexture2DEXT := SYSTEM.VAL(TglFramebufferTexture2DEXT, GetProcAddress('glFramebufferTexture2DEXT'));
     glFramebufferTexture3DEXT := SYSTEM.VAL(TglFramebufferTexture3DEXT, GetProcAddress('glFramebufferTexture3DEXT'));
     glFramebufferRenderbufferEXT := SYSTEM.VAL(TglFramebufferRenderbufferEXT, GetProcAddress('glFramebufferRenderbufferEXT'));
     glGetFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetFramebufferAttachmentParameterivEXT, GetProcAddress('glGetFramebufferAttachmentParameterivEXT'));
     glGenerateMipmapEXT := SYSTEM.VAL(TglGenerateMipmapEXT, GetProcAddress('glGenerateMipmapEXT'));
END Read_GL_EXT_framebuffer_object;

PROCEDURE Read_GL_EXT_histogram;
BEGIN
     glGetHistogramEXT := SYSTEM.VAL(TglGetHistogramEXT, GetProcAddress('glGetHistogramEXT'));
     glGetHistogramParameterfvEXT := SYSTEM.VAL(TglGetHistogramParameterfvEXT, GetProcAddress('glGetHistogramParameterfvEXT'));
     glGetHistogramParameterivEXT := SYSTEM.VAL(TglGetHistogramParameterivEXT, GetProcAddress('glGetHistogramParameterivEXT'));
     glGetMinmaxEXT := SYSTEM.VAL(TglGetMinmaxEXT, GetProcAddress('glGetMinmaxEXT'));
     glGetMinmaxParameterfvEXT := SYSTEM.VAL(TglGetMinmaxParameterfvEXT, GetProcAddress('glGetMinmaxParameterfvEXT'));
     glGetMinmaxParameterivEXT := SYSTEM.VAL(TglGetMinmaxParameterivEXT, GetProcAddress('glGetMinmaxParameterivEXT'));
     glHistogramEXT := SYSTEM.VAL(TglHistogramEXT, GetProcAddress('glHistogramEXT'));
     glMinmaxEXT := SYSTEM.VAL(TglMinmaxEXT, GetProcAddress('glMinmaxEXT'));
     glResetHistogramEXT := SYSTEM.VAL(TglResetHistogramEXT, GetProcAddress('glResetHistogramEXT'));
     glResetMinmaxEXT := SYSTEM.VAL(TglResetMinmaxEXT, GetProcAddress('glResetMinmaxEXT'));
END Read_GL_EXT_histogram;

PROCEDURE Read_GL_EXT_index_func;
BEGIN
     glIndexFuncEXT := SYSTEM.VAL(TglIndexFuncEXT, GetProcAddress('glIndexFuncEXT'));
END Read_GL_EXT_index_func;

PROCEDURE Read_GL_EXT_index_material;
BEGIN
     glIndexMaterialEXT := SYSTEM.VAL(TglIndexMaterialEXT, GetProcAddress('glIndexMaterialEXT'));
END Read_GL_EXT_index_material;

PROCEDURE Read_GL_EXT_light_texture;
BEGIN
     glApplyTextureEXT := SYSTEM.VAL(TglApplyTextureEXT, GetProcAddress('glApplyTextureEXT'));
     glTextureLightEXT := SYSTEM.VAL(TglTextureLightEXT, GetProcAddress('glTextureLightEXT'));
     glTextureMaterialEXT := SYSTEM.VAL(TglTextureMaterialEXT, GetProcAddress('glTextureMaterialEXT'));
END Read_GL_EXT_light_texture;

PROCEDURE Read_GL_EXT_multi_draw_arrays;
BEGIN
     glMultiDrawArraysEXT := SYSTEM.VAL(TglMultiDrawArraysEXT, GetProcAddress('glMultiDrawArraysEXT'));
     glMultiDrawElementsEXT := SYSTEM.VAL(TglMultiDrawElementsEXT, GetProcAddress('glMultiDrawElementsEXT'));
END Read_GL_EXT_multi_draw_arrays;

PROCEDURE Read_GL_EXT_multisample;
BEGIN
     glSampleMaskEXT := SYSTEM.VAL(TglSampleMaskEXT, GetProcAddress('glSampleMaskEXT'));
     glSamplePatternEXT := SYSTEM.VAL(TglSamplePatternEXT, GetProcAddress('glSamplePatternEXT'));
END Read_GL_EXT_multisample;

PROCEDURE Read_GL_EXT_paletted_texture;
BEGIN
     glColorTableEXT := SYSTEM.VAL(TglColorTableEXT, GetProcAddress('glColorTableEXT'));
     glGetColorTableEXT := SYSTEM.VAL(TglGetColorTableEXT, GetProcAddress('glGetColorTableEXT'));
     glGetColorTableParameterivEXT := SYSTEM.VAL(TglGetColorTableParameterivEXT, GetProcAddress('glGetColorTableParameterivEXT'));
     glGetColorTableParameterfvEXT := SYSTEM.VAL(TglGetColorTableParameterfvEXT, GetProcAddress('glGetColorTableParameterfvEXT'));
END Read_GL_EXT_paletted_texture;

PROCEDURE Read_GL_EXT_pixel_transform;
BEGIN
     glPixelTransformParameteriEXT := SYSTEM.VAL(TglPixelTransformParameteriEXT, GetProcAddress('glPixelTransformParameteriEXT'));
     glPixelTransformParameterfEXT := SYSTEM.VAL(TglPixelTransformParameterfEXT, GetProcAddress('glPixelTransformParameterfEXT'));
     glPixelTransformParameterivEXT := SYSTEM.VAL(TglPixelTransformParameterivEXT, GetProcAddress('glPixelTransformParameterivEXT'));
     glPixelTransformParameterfvEXT := SYSTEM.VAL(TglPixelTransformParameterfvEXT, GetProcAddress('glPixelTransformParameterfvEXT'));
END Read_GL_EXT_pixel_transform;

PROCEDURE Read_GL_EXT_point_parameters;
BEGIN
     glPointParameterfEXT := SYSTEM.VAL(TglPointParameterfEXT, GetProcAddress('glPointParameterfEXT'));
     glPointParameterfvEXT := SYSTEM.VAL(TglPointParameterfvEXT, GetProcAddress('glPointParameterfvEXT'));
END Read_GL_EXT_point_parameters;

PROCEDURE Read_GL_EXT_polygon_offset;
BEGIN
     glPolygonOffsetEXT := SYSTEM.VAL(TglPolygonOffsetEXT, GetProcAddress('glPolygonOffsetEXT'));
END Read_GL_EXT_polygon_offset;

PROCEDURE Read_GL_EXT_secondary_color;
BEGIN
     glSecondaryColor3bEXT := SYSTEM.VAL(TglSecondaryColor3bEXT, GetProcAddress('glSecondaryColor3bEXT'));
     glSecondaryColor3bvEXT := SYSTEM.VAL(TglSecondaryColor3bvEXT, GetProcAddress('glSecondaryColor3bvEXT'));
     glSecondaryColor3dEXT := SYSTEM.VAL(TglSecondaryColor3dEXT, GetProcAddress('glSecondaryColor3dEXT'));
     glSecondaryColor3dvEXT := SYSTEM.VAL(TglSecondaryColor3dvEXT, GetProcAddress('glSecondaryColor3dvEXT'));
     glSecondaryColor3fEXT := SYSTEM.VAL(TglSecondaryColor3fEXT, GetProcAddress('glSecondaryColor3fEXT'));
     glSecondaryColor3fvEXT := SYSTEM.VAL(TglSecondaryColor3fvEXT, GetProcAddress('glSecondaryColor3fvEXT'));
     glSecondaryColor3iEXT := SYSTEM.VAL(TglSecondaryColor3iEXT, GetProcAddress('glSecondaryColor3iEXT'));
     glSecondaryColor3ivEXT := SYSTEM.VAL(TglSecondaryColor3ivEXT, GetProcAddress('glSecondaryColor3ivEXT'));
     glSecondaryColor3sEXT := SYSTEM.VAL(TglSecondaryColor3sEXT, GetProcAddress('glSecondaryColor3sEXT'));
     glSecondaryColor3svEXT := SYSTEM.VAL(TglSecondaryColor3svEXT, GetProcAddress('glSecondaryColor3svEXT'));
     glSecondaryColor3ubEXT := SYSTEM.VAL(TglSecondaryColor3ubEXT, GetProcAddress('glSecondaryColor3ubEXT'));
     glSecondaryColor3ubvEXT := SYSTEM.VAL(TglSecondaryColor3ubvEXT, GetProcAddress('glSecondaryColor3ubvEXT'));
     glSecondaryColor3uiEXT := SYSTEM.VAL(TglSecondaryColor3uiEXT, GetProcAddress('glSecondaryColor3uiEXT'));
     glSecondaryColor3uivEXT := SYSTEM.VAL(TglSecondaryColor3uivEXT, GetProcAddress('glSecondaryColor3uivEXT'));
     glSecondaryColor3usEXT := SYSTEM.VAL(TglSecondaryColor3usEXT, GetProcAddress('glSecondaryColor3usEXT'));
     glSecondaryColor3usvEXT := SYSTEM.VAL(TglSecondaryColor3usvEXT, GetProcAddress('glSecondaryColor3usvEXT'));
     glSecondaryColorPointerEXT := SYSTEM.VAL(TglSecondaryColorPointerEXT, GetProcAddress('glSecondaryColorPointerEXT'));
END Read_GL_EXT_secondary_color;

PROCEDURE Read_GL_EXT_stencil_two_side;
BEGIN
     glActiveStencilFaceEXT := SYSTEM.VAL(TglActiveStencilFaceEXT, GetProcAddress('glActiveStencilFaceEXT'));
END Read_GL_EXT_stencil_two_side;

PROCEDURE Read_GL_EXT_subtexture;
BEGIN
     glTexSubImage1DEXT := SYSTEM.VAL(TglTexSubImage1DEXT, GetProcAddress('glTexSubImage1DEXT'));
     glTexSubImage2DEXT := SYSTEM.VAL(TglTexSubImage2DEXT, GetProcAddress('glTexSubImage2DEXT'));
END Read_GL_EXT_subtexture;

PROCEDURE Read_GL_EXT_texture3D;
BEGIN
     glTexImage3DEXT := SYSTEM.VAL(TglTexImage3DEXT, GetProcAddress('glTexImage3DEXT'));
     glTexSubImage3DEXT := SYSTEM.VAL(TglTexSubImage3DEXT, GetProcAddress('glTexSubImage3DEXT'));
END Read_GL_EXT_texture3D;

PROCEDURE Read_GL_EXT_texture_object;
BEGIN
     glAreTexturesResidentEXT := SYSTEM.VAL(TglAreTexturesResidentEXT, GetProcAddress('glAreTexturesResidentEXT'));
     glBindTextureEXT := SYSTEM.VAL(TglBindTextureEXT, GetProcAddress('glBindTextureEXT'));
     glDeleteTexturesEXT := SYSTEM.VAL(TglDeleteTexturesEXT, GetProcAddress('glDeleteTexturesEXT'));
     glGenTexturesEXT := SYSTEM.VAL(TglGenTexturesEXT, GetProcAddress('glGenTexturesEXT'));
     glIsTextureEXT := SYSTEM.VAL(TglIsTextureEXT, GetProcAddress('glIsTextureEXT'));
     glPrioritizeTexturesEXT := SYSTEM.VAL(TglPrioritizeTexturesEXT, GetProcAddress('glPrioritizeTexturesEXT'));
END Read_GL_EXT_texture_object;

PROCEDURE Read_GL_EXT_texture_perturb_normal;
BEGIN
     glTextureNormalEXT := SYSTEM.VAL(TglTextureNormalEXT, GetProcAddress('glTextureNormalEXT'));
END Read_GL_EXT_texture_perturb_normal;

PROCEDURE Read_GL_EXT_vertex_array;
BEGIN
     glArrayElementEXT := SYSTEM.VAL(TglArrayElementEXT, GetProcAddress('glArrayElementEXT'));
     glColorPointerEXT := SYSTEM.VAL(TglColorPointerEXT, GetProcAddress('glColorPointerEXT'));
     glDrawArraysEXT := SYSTEM.VAL(TglDrawArraysEXT, GetProcAddress('glDrawArraysEXT'));
     glEdgeFlagPointerEXT := SYSTEM.VAL(TglEdgeFlagPointerEXT, GetProcAddress('glEdgeFlagPointerEXT'));
     glGetPointervEXT := SYSTEM.VAL(TglGetPointervEXT, GetProcAddress('glGetPointervEXT'));
     glIndexPointerEXT := SYSTEM.VAL(TglIndexPointerEXT, GetProcAddress('glIndexPointerEXT'));
     glNormalPointerEXT := SYSTEM.VAL(TglNormalPointerEXT, GetProcAddress('glNormalPointerEXT'));
     glTexCoordPointerEXT := SYSTEM.VAL(TglTexCoordPointerEXT, GetProcAddress('glTexCoordPointerEXT'));
     glVertexPointerEXT := SYSTEM.VAL(TglVertexPointerEXT, GetProcAddress('glVertexPointerEXT'));
END Read_GL_EXT_vertex_array;

PROCEDURE Read_GL_EXT_vertex_shader;
BEGIN
     glBeginVertexShaderEXT := SYSTEM.VAL(TglBeginVertexShaderEXT, GetProcAddress('glBeginVertexShaderEXT'));
     glEndVertexShaderEXT := SYSTEM.VAL(TglEndVertexShaderEXT, GetProcAddress('glEndVertexShaderEXT'));
     glBindVertexShaderEXT := SYSTEM.VAL(TglBindVertexShaderEXT, GetProcAddress('glBindVertexShaderEXT'));
     glGenVertexShadersEXT := SYSTEM.VAL(TglGenVertexShadersEXT, GetProcAddress('glGenVertexShadersEXT'));
     glDeleteVertexShaderEXT := SYSTEM.VAL(TglDeleteVertexShaderEXT, GetProcAddress('glDeleteVertexShaderEXT'));
     glShaderOp1EXT := SYSTEM.VAL(TglShaderOp1EXT, GetProcAddress('glShaderOp1EXT'));
     glShaderOp2EXT := SYSTEM.VAL(TglShaderOp2EXT, GetProcAddress('glShaderOp2EXT'));
     glShaderOp3EXT := SYSTEM.VAL(TglShaderOp3EXT, GetProcAddress('glShaderOp3EXT'));
     glSwizzleEXT := SYSTEM.VAL(TglSwizzleEXT, GetProcAddress('glSwizzleEXT'));
     glWriteMaskEXT := SYSTEM.VAL(TglWriteMaskEXT, GetProcAddress('glWriteMaskEXT'));
     glInsertComponentEXT := SYSTEM.VAL(TglInsertComponentEXT, GetProcAddress('glInsertComponentEXT'));
     glExtractComponentEXT := SYSTEM.VAL(TglExtractComponentEXT, GetProcAddress('glExtractComponentEXT'));
     glGenSymbolsEXT := SYSTEM.VAL(TglGenSymbolsEXT, GetProcAddress('glGenSymbolsEXT'));
     glSetInvariantEXT := SYSTEM.VAL(TglSetInvariantEXT, GetProcAddress('glSetInvariantEXT'));
     glSetLocalConstantEXT := SYSTEM.VAL(TglSetLocalConstantEXT, GetProcAddress('glSetLocalConstantEXT'));
     glVariantbvEXT := SYSTEM.VAL(TglVariantbvEXT, GetProcAddress('glVariantbvEXT'));
     glVariantsvEXT := SYSTEM.VAL(TglVariantsvEXT, GetProcAddress('glVariantsvEXT'));
     glVariantivEXT := SYSTEM.VAL(TglVariantivEXT, GetProcAddress('glVariantivEXT'));
     glVariantfvEXT := SYSTEM.VAL(TglVariantfvEXT, GetProcAddress('glVariantfvEXT'));
     glVariantdvEXT := SYSTEM.VAL(TglVariantdvEXT, GetProcAddress('glVariantdvEXT'));
     glVariantubvEXT := SYSTEM.VAL(TglVariantubvEXT, GetProcAddress('glVariantubvEXT'));
     glVariantusvEXT := SYSTEM.VAL(TglVariantusvEXT, GetProcAddress('glVariantusvEXT'));
     glVariantuivEXT := SYSTEM.VAL(TglVariantuivEXT, GetProcAddress('glVariantuivEXT'));
     glVariantPointerEXT := SYSTEM.VAL(TglVariantPointerEXT, GetProcAddress('glVariantPointerEXT'));
     glEnableVariantClientStateEXT := SYSTEM.VAL(TglEnableVariantClientStateEXT, GetProcAddress('glEnableVariantClientStateEXT'));
     glDisableVariantClientStateEXT := SYSTEM.VAL(TglDisableVariantClientStateEXT, GetProcAddress('glDisableVariantClientStateEXT'));
     glBindLightParameterEXT := SYSTEM.VAL(TglBindLightParameterEXT, GetProcAddress('glBindLightParameterEXT'));
     glBindMaterialParameterEXT := SYSTEM.VAL(TglBindMaterialParameterEXT, GetProcAddress('glBindMaterialParameterEXT'));
     glBindTexGenParameterEXT := SYSTEM.VAL(TglBindTexGenParameterEXT, GetProcAddress('glBindTexGenParameterEXT'));
     glBindTextureUnitParameterEXT := SYSTEM.VAL(TglBindTextureUnitParameterEXT, GetProcAddress('glBindTextureUnitParameterEXT'));
     glBindParameterEXT := SYSTEM.VAL(TglBindParameterEXT, GetProcAddress('glBindParameterEXT'));
     glIsVariantEnabledEXT := SYSTEM.VAL(TglIsVariantEnabledEXT, GetProcAddress('glIsVariantEnabledEXT'));
     glGetVariantBooleanvEXT := SYSTEM.VAL(TglGetVariantBooleanvEXT, GetProcAddress('glGetVariantBooleanvEXT'));
     glGetVariantIntegervEXT := SYSTEM.VAL(TglGetVariantIntegervEXT, GetProcAddress('glGetVariantIntegervEXT'));
     glGetVariantFloatvEXT := SYSTEM.VAL(TglGetVariantFloatvEXT, GetProcAddress('glGetVariantFloatvEXT'));
     glGetVariantPointervEXT := SYSTEM.VAL(TglGetVariantPointervEXT, GetProcAddress('glGetVariantPointervEXT'));
     glGetInvariantBooleanvEXT := SYSTEM.VAL(TglGetInvariantBooleanvEXT, GetProcAddress('glGetInvariantBooleanvEXT'));
     glGetInvariantIntegervEXT := SYSTEM.VAL(TglGetInvariantIntegervEXT, GetProcAddress('glGetInvariantIntegervEXT'));
     glGetInvariantFloatvEXT := SYSTEM.VAL(TglGetInvariantFloatvEXT, GetProcAddress('glGetInvariantFloatvEXT'));
     glGetLocalConstantBooleanvEXT := SYSTEM.VAL(TglGetLocalConstantBooleanvEXT, GetProcAddress('glGetLocalConstantBooleanvEXT'));
     glGetLocalConstantIntegervEXT := SYSTEM.VAL(TglGetLocalConstantIntegervEXT, GetProcAddress('glGetLocalConstantIntegervEXT'));
     glGetLocalConstantFloatvEXT := SYSTEM.VAL(TglGetLocalConstantFloatvEXT, GetProcAddress('glGetLocalConstantFloatvEXT'));
END Read_GL_EXT_vertex_shader;

PROCEDURE Read_GL_EXT_vertex_weighting;
BEGIN
     glVertexWeightfEXT := SYSTEM.VAL(TglVertexWeightfEXT, GetProcAddress('glVertexWeightfEXT'));
     glVertexWeightfvEXT := SYSTEM.VAL(TglVertexWeightfvEXT, GetProcAddress('glVertexWeightfvEXT'));
     glVertexWeightPointerEXT := SYSTEM.VAL(TglVertexWeightPointerEXT, GetProcAddress('glVertexWeightPointerEXT'));
END Read_GL_EXT_vertex_weighting;

PROCEDURE Read_GL_EXT_depth_bounds_test;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, GetProcAddress('glImageTransformParameteriHP'));
     glDepthBoundsEXT := SYSTEM.VAL(TglDepthBoundsEXT, GetProcAddress('glDepthBoundsEXT'));
END Read_GL_EXT_depth_bounds_test;

PROCEDURE Read_GL_EXT_blend_equation_separate;
BEGIN
     glBlendEquationSeparateEXT := SYSTEM.VAL(TglBlendEquationSeparateEXT, GetProcAddress('glBlendEquationSeparateEXT'));
END Read_GL_EXT_blend_equation_separate;

PROCEDURE Read_GL_EXT_stencil_clear_tag;
BEGIN
     glStencilClearTagEXT := SYSTEM.VAL(TglStencilClearTagEXT, GetProcAddress('glStencilClearTagEXT'));
END Read_GL_EXT_stencil_clear_tag;

PROCEDURE Read_GL_EXT_framebuffer_blit;
BEGIN
     glBlitFramebufferEXT := SYSTEM.VAL(TglBlitFramebufferEXT, GetProcAddress('glBlitFramebufferEXT'));
END Read_GL_EXT_framebuffer_blit;

PROCEDURE Read_GL_EXT_framebuffer_multisample;
BEGIN
     glRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglRenderbufferStorageMultisampleEXT, GetProcAddress('glRenderbufferStorageMultisampleEXT'));
END Read_GL_EXT_framebuffer_multisample;

PROCEDURE Read_GL_EXT_timer_query;
BEGIN
     glGetQueryObjecti64vEXT := SYSTEM.VAL(TglGetQueryObjecti64vEXT, GetProcAddress('glGetQueryObjecti64vEXT'));
     glGetQueryObjectui64vEXT := SYSTEM.VAL(TglGetQueryObjectui64vEXT, GetProcAddress('glGetQueryObjectui64vEXT'));
END Read_GL_EXT_timer_query;

PROCEDURE Read_GL_EXT_gpu_program_parameters;
BEGIN
     glProgramEnvParameters4fvEXT := SYSTEM.VAL(TglProgramEnvParameters4fvEXT, GetProcAddress('glProgramEnvParameters4fvEXT'));
     glProgramLocalParameters4fvEXT := SYSTEM.VAL(TglProgramLocalParameters4fvEXT, GetProcAddress('glProgramLocalParameters4fvEXT'));
END Read_GL_EXT_gpu_program_parameters;

PROCEDURE Read_GL_EXT_bindable_uniform;
BEGIN
     glUniformBufferEXT := SYSTEM.VAL(TglUniformBufferEXT, GetProcAddress('glUniformBufferEXT'));
     glGetUniformBufferSizeEXT := SYSTEM.VAL(TglGetUniformBufferSizeEXT, GetProcAddress('glGetUniformBufferSizeEXT'));
     glGetUniformOffsetEXT := SYSTEM.VAL(TglGetUniformOffsetEXT, GetProcAddress('glGetUniformOffsetEXT'));
END Read_GL_EXT_bindable_uniform;

PROCEDURE Read_GL_EXT_draw_buffers2;
BEGIN
     glColorMaskIndexedEXT := SYSTEM.VAL(TglColorMaskIndexedEXT, GetProcAddress('glColorMaskIndexedEXT'));
     glGetBooleanIndexedvEXT := SYSTEM.VAL(TglGetBooleanIndexedvEXT, GetProcAddress('glGetBooleanIndexedvEXT'));
     glGetIntegerIndexedvEXT := SYSTEM.VAL(TglGetIntegerIndexedvEXT, GetProcAddress('glGetIntegerIndexedvEXT'));
     glEnableIndexedEXT := SYSTEM.VAL(TglEnableIndexedEXT, GetProcAddress('glEnableIndexedEXT'));
     glDisableIndexedEXT := SYSTEM.VAL(TglDisableIndexedEXT, GetProcAddress('glDisableIndexedEXT'));
     glIsEnabledIndexedEXT := SYSTEM.VAL(TglIsEnabledIndexedEXT, GetProcAddress('glIsEnabledIndexedEXT'));
END Read_GL_EXT_draw_buffers2;

PROCEDURE Read_GL_EXT_draw_instanced;
BEGIN
     glDrawArraysInstancedEXT := SYSTEM.VAL(TglDrawArraysInstancedEXT, GetProcAddress('glDrawArraysInstancedEXT'));
     glDrawElementsInstancedEXT := SYSTEM.VAL(TglDrawElementsInstancedEXT, GetProcAddress('glDrawElementsInstancedEXT'));
END Read_GL_EXT_draw_instanced;

PROCEDURE Read_GL_EXT_geometry_shader4;
BEGIN
     glProgramParameteriEXT := SYSTEM.VAL(TglProgramParameteriEXT, GetProcAddress('glProgramParameteriEXT'));
     glFramebufferTextureEXT := SYSTEM.VAL(TglFramebufferTextureEXT, GetProcAddress('glFramebufferTextureEXT'));
     glFramebufferTextureFaceEXT := SYSTEM.VAL(TglFramebufferTextureFaceEXT, GetProcAddress('glFramebufferTextureFaceEXT'));
END Read_GL_EXT_geometry_shader4;

PROCEDURE Read_GL_EXT_gpu_shader4;
BEGIN
     glVertexAttribI1iEXT := SYSTEM.VAL(TglVertexAttribI1iEXT, GetProcAddress('glVertexAttribI1iEXT'));
     glVertexAttribI2iEXT := SYSTEM.VAL(TglVertexAttribI2iEXT, GetProcAddress('glVertexAttribI2iEXT'));
     glVertexAttribI3iEXT := SYSTEM.VAL(TglVertexAttribI3iEXT, GetProcAddress('glVertexAttribI3iEXT'));
     glVertexAttribI4iEXT := SYSTEM.VAL(TglVertexAttribI4iEXT, GetProcAddress('glVertexAttribI4iEXT'));
     glVertexAttribI1uiEXT := SYSTEM.VAL(TglVertexAttribI1uiEXT, GetProcAddress('glVertexAttribI1uiEXT'));
     glVertexAttribI2uiEXT := SYSTEM.VAL(TglVertexAttribI2uiEXT, GetProcAddress('glVertexAttribI2uiEXT'));
     glVertexAttribI3uiEXT := SYSTEM.VAL(TglVertexAttribI3uiEXT, GetProcAddress('glVertexAttribI3uiEXT'));
     glVertexAttribI4uiEXT := SYSTEM.VAL(TglVertexAttribI4uiEXT, GetProcAddress('glVertexAttribI4uiEXT'));
     glVertexAttribI1ivEXT := SYSTEM.VAL(TglVertexAttribI1ivEXT, GetProcAddress('glVertexAttribI1ivEXT'));
     glVertexAttribI2ivEXT := SYSTEM.VAL(TglVertexAttribI2ivEXT, GetProcAddress('glVertexAttribI2ivEXT'));
     glVertexAttribI3ivEXT := SYSTEM.VAL(TglVertexAttribI3ivEXT, GetProcAddress('glVertexAttribI3ivEXT'));
     glVertexAttribI4ivEXT := SYSTEM.VAL(TglVertexAttribI4ivEXT, GetProcAddress('glVertexAttribI4ivEXT'));
     glVertexAttribI1uivEXT := SYSTEM.VAL(TglVertexAttribI1uivEXT, GetProcAddress('glVertexAttribI1uivEXT'));
     glVertexAttribI2uivEXT := SYSTEM.VAL(TglVertexAttribI2uivEXT, GetProcAddress('glVertexAttribI2uivEXT'));
     glVertexAttribI3uivEXT := SYSTEM.VAL(TglVertexAttribI3uivEXT, GetProcAddress('glVertexAttribI3uivEXT'));
     glVertexAttribI4uivEXT := SYSTEM.VAL(TglVertexAttribI4uivEXT, GetProcAddress('glVertexAttribI4uivEXT'));
     glVertexAttribI4bvEXT := SYSTEM.VAL(TglVertexAttribI4bvEXT, GetProcAddress('glVertexAttribI4bvEXT'));
     glVertexAttribI4svEXT := SYSTEM.VAL(TglVertexAttribI4svEXT, GetProcAddress('glVertexAttribI4svEXT'));
     glVertexAttribI4ubvEXT := SYSTEM.VAL(TglVertexAttribI4ubvEXT, GetProcAddress('glVertexAttribI4ubvEXT'));
     glVertexAttribI4usvEXT := SYSTEM.VAL(TglVertexAttribI4usvEXT, GetProcAddress('glVertexAttribI4usvEXT'));
     glVertexAttribIPointerEXT := SYSTEM.VAL(TglVertexAttribIPointerEXT, GetProcAddress('glVertexAttribIPointerEXT'));
     glGetVertexAttribIivEXT := SYSTEM.VAL(TglGetVertexAttribIivEXT, GetProcAddress('glGetVertexAttribIivEXT'));
     glGetVertexAttribIuivEXT := SYSTEM.VAL(TglGetVertexAttribIuivEXT, GetProcAddress('glGetVertexAttribIuivEXT'));
     glUniform1uiEXT := SYSTEM.VAL(TglUniform1uiEXT, GetProcAddress('glUniform1uiEXT'));
     glUniform2uiEXT := SYSTEM.VAL(TglUniform2uiEXT, GetProcAddress('glUniform2uiEXT'));
     glUniform3uiEXT := SYSTEM.VAL(TglUniform3uiEXT, GetProcAddress('glUniform3uiEXT'));
     glUniform4uiEXT := SYSTEM.VAL(TglUniform4uiEXT, GetProcAddress('glUniform4uiEXT'));
     glUniform1uivEXT := SYSTEM.VAL(TglUniform1uivEXT, GetProcAddress('glUniform1uivEXT'));
     glUniform2uivEXT := SYSTEM.VAL(TglUniform2uivEXT, GetProcAddress('glUniform2uivEXT'));
     glUniform3uivEXT := SYSTEM.VAL(TglUniform3uivEXT, GetProcAddress('glUniform3uivEXT'));
     glUniform4uivEXT := SYSTEM.VAL(TglUniform4uivEXT, GetProcAddress('glUniform4uivEXT'));
     glGetUniformuivEXT := SYSTEM.VAL(TglGetUniformuivEXT, GetProcAddress('glGetUniformuivEXT'));
     glBindFragDataLocationEXT := SYSTEM.VAL(TglBindFragDataLocationEXT, GetProcAddress('glBindFragDataLocationEXT'));
     glGetFragDataLocationEXT := SYSTEM.VAL(TglGetFragDataLocationEXT, GetProcAddress('glGetFragDataLocationEXT'));
END Read_GL_EXT_gpu_shader4;

PROCEDURE Read_GL_EXT_texture_array;
BEGIN
     glFramebufferTextureLayerEXT := SYSTEM.VAL(TglFramebufferTextureLayerEXT, GetProcAddress('glFramebufferTextureLayerEXT'));
END Read_GL_EXT_texture_array;

PROCEDURE Read_GL_EXT_texture_buffer_object;
BEGIN
     glTexBufferEXT := SYSTEM.VAL(TglTexBufferEXT, GetProcAddress('glTexBufferEXT'));
END Read_GL_EXT_texture_buffer_object;

PROCEDURE Read_GL_EXT_texture_integer;
BEGIN
     glClearColorIiEXT := SYSTEM.VAL(TglClearColorIiEXT, GetProcAddress('glClearColorIiEXT'));
     glClearColorIuiEXT := SYSTEM.VAL(TglClearColorIuiEXT, GetProcAddress('glClearColorIuiEXT'));
     glTexParameterIivEXT := SYSTEM.VAL(TglTexParameterIivEXT, GetProcAddress('glTexParameterIivEXT'));
     glTexParameterIuivEXT := SYSTEM.VAL(TglTexParameterIuivEXT, GetProcAddress('glTexParameterIuivEXT'));
     glGetTexParameterIivEXT := SYSTEM.VAL(TglGetTexParameterIivEXT, GetProcAddress('glGetTexParameterIivEXT'));
     glGetTexParameterIiuvEXT := SYSTEM.VAL(TglGetTexParameterIiuvEXT, GetProcAddress('glGetTexParameterIiuvEXT'));
END Read_GL_EXT_texture_integer;

PROCEDURE Read_GL_EXT_transform_feedback;
BEGIN
     glBeginTransformFeedbackEXT := SYSTEM.VAL(TglBeginTransformFeedbackEXT, GetProcAddress('glBeginTransformFeedbackEXT'));
     glEndTransformFeedbackEXT := SYSTEM.VAL(TglEndTransformFeedbackEXT, GetProcAddress('glEndTransformFeedbackEXT'));
     glBindBufferRangeEXT := SYSTEM.VAL(TglBindBufferRangeEXT, GetProcAddress('glBindBufferRangeEXT'));
     glBindBufferOffsetEXT := SYSTEM.VAL(TglBindBufferOffsetEXT, GetProcAddress('glBindBufferOffsetEXT'));
     glBindBufferBaseEXT := SYSTEM.VAL(TglBindBufferBaseEXT, GetProcAddress('glBindBufferBaseEXT'));
     glTransformFeedbackVaryingsEXT := SYSTEM.VAL(TglTransformFeedbackVaryingsEXT, GetProcAddress('glTransformFeedbackVaryingsEXT'));
     glGetTransformFeedbackVaryingEXT := SYSTEM.VAL(TglGetTransformFeedbackVaryingEXT, GetProcAddress('glGetTransformFeedbackVaryingEXT'));
END Read_GL_EXT_transform_feedback;

PROCEDURE Read_GL_EXT_direct_state_access;
BEGIN
     glClientAttribDefaultEXT := SYSTEM.VAL(TglClientAttribDefaultEXT, GetProcAddress('glClientAttribDefaultEXT'));
     glPushClientAttribDefaultEXT := SYSTEM.VAL(TglPushClientAttribDefaultEXT, GetProcAddress('glPushClientAttribDefaultEXT'));
     glMatrixLoadfEXT := SYSTEM.VAL(TglMatrixLoadfEXT, GetProcAddress('glMatrixLoadfEXT'));
     glMatrixLoaddEXT := SYSTEM.VAL(TglMatrixLoaddEXT, GetProcAddress('glMatrixLoaddEXT'));
     glMatrixMultfEXT := SYSTEM.VAL(TglMatrixMultfEXT, GetProcAddress('glMatrixMultfEXT'));
     glMatrixMultdEXT := SYSTEM.VAL(TglMatrixMultdEXT, GetProcAddress('glMatrixMultdEXT'));
     glMatrixLoadIdentityEXT := SYSTEM.VAL(TglMatrixLoadIdentityEXT, GetProcAddress('glMatrixLoadIdentityEXT'));
     glMatrixRotatefEXT := SYSTEM.VAL(TglMatrixRotatefEXT, GetProcAddress('glMatrixRotatefEXT'));
     glMatrixRotatedEXT := SYSTEM.VAL(TglMatrixRotatedEXT, GetProcAddress('glMatrixRotatedEXT'));
     glMatrixScalefEXT := SYSTEM.VAL(TglMatrixScalefEXT, GetProcAddress('glMatrixScalefEXT'));
     glMatrixScaledEXT := SYSTEM.VAL(TglMatrixScaledEXT, GetProcAddress('glMatrixScaledEXT'));
     glMatrixTranslatefEXT := SYSTEM.VAL(TglMatrixTranslatefEXT, GetProcAddress('glMatrixTranslatefEXT'));
     glMatrixTranslatedEXT := SYSTEM.VAL(TglMatrixTranslatedEXT, GetProcAddress('glMatrixTranslatedEXT'));
     glMatrixFrustumEXT := SYSTEM.VAL(TglMatrixFrustumEXT, GetProcAddress('glMatrixFrustumEXT'));
     glMatrixOrthoEXT := SYSTEM.VAL(TglMatrixOrthoEXT, GetProcAddress('glMatrixOrthoEXT'));
     glMatrixPopEXT := SYSTEM.VAL(TglMatrixPopEXT, GetProcAddress('glMatrixPopEXT'));
     glMatrixPushEXT := SYSTEM.VAL(TglMatrixPushEXT, GetProcAddress('glMatrixPushEXT'));
     glMatrixLoadTransposefEXT := SYSTEM.VAL(TglMatrixLoadTransposefEXT, GetProcAddress('glMatrixLoadTransposefEXT'));
     glMatrixLoadTransposedEXT := SYSTEM.VAL(TglMatrixLoadTransposedEXT, GetProcAddress('glMatrixLoadTransposedEXT'));
     glMatrixMultTransposefEXT := SYSTEM.VAL(TglMatrixMultTransposefEXT, GetProcAddress('glMatrixMultTransposefEXT'));
     glMatrixMultTransposedEXT := SYSTEM.VAL(TglMatrixMultTransposedEXT, GetProcAddress('glMatrixMultTransposedEXT'));
     glTextureParameterfEXT := SYSTEM.VAL(TglTextureParameterfEXT, GetProcAddress('glTextureParameterfEXT'));
     glTextureParameterfvEXT := SYSTEM.VAL(TglTextureParameterfvEXT, GetProcAddress('glTextureParameterfvEXT'));
     glTextureParameteriEXT := SYSTEM.VAL(TglTextureParameteriEXT, GetProcAddress('glTextureParameteriEXT'));
     glTextureParameterivEXT := SYSTEM.VAL(TglTextureParameterivEXT, GetProcAddress('glTextureParameterivEXT'));
     glTextureImage1DEXT := SYSTEM.VAL(TglTextureImage1DEXT, GetProcAddress('glTextureImage1DEXT'));
     glTextureImage2DEXT := SYSTEM.VAL(TglTextureImage2DEXT, GetProcAddress('glTextureImage2DEXT'));
     glTextureSubImage1DEXT := SYSTEM.VAL(TglTextureSubImage1DEXT, GetProcAddress('glTextureSubImage1DEXT'));
     glTextureSubImage2DEXT := SYSTEM.VAL(TglTextureSubImage2DEXT, GetProcAddress('glTextureSubImage2DEXT'));
     glCopyTextureImage1DEXT := SYSTEM.VAL(TglCopyTextureImage1DEXT, GetProcAddress('glCopyTextureImage1DEXT'));
     glCopyTextureImage2DEXT := SYSTEM.VAL(TglCopyTextureImage2DEXT, GetProcAddress('glCopyTextureImage2DEXT'));
     glCopyTextureSubImage1DEXT := SYSTEM.VAL(TglCopyTextureSubImage1DEXT, GetProcAddress('glCopyTextureSubImage1DEXT'));
     glCopyTextureSubImage2DEXT := SYSTEM.VAL(TglCopyTextureSubImage2DEXT, GetProcAddress('glCopyTextureSubImage2DEXT'));
     glGetTextureImageEXT := SYSTEM.VAL(TglGetTextureImageEXT, GetProcAddress('glGetTextureImageEXT'));
     glGetTextureParameterfvEXT := SYSTEM.VAL(TglGetTextureParameterfvEXT, GetProcAddress('glGetTextureParameterfvEXT'));
     glGetTextureParameterivEXT := SYSTEM.VAL(TglGetTextureParameterivEXT, GetProcAddress('glGetTextureParameterivEXT'));
     glGetTextureLevelParameterfvEXT := SYSTEM.VAL(TglGetTextureLevelParameterfvEXT, GetProcAddress('glGetTextureLevelParameterfvEXT'));
     glGetTextureLevelParameterivEXT := SYSTEM.VAL(TglGetTextureLevelParameterivEXT, GetProcAddress('glGetTextureLevelParameterivEXT'));
     glTextureImage3DEXT := SYSTEM.VAL(TglTextureImage3DEXT, GetProcAddress('glTextureImage3DEXT'));
     glTextureSubImage3DEXT := SYSTEM.VAL(TglTextureSubImage3DEXT, GetProcAddress('glTextureSubImage3DEXT'));
     glCopyTextureSubImage3DEXT := SYSTEM.VAL(TglCopyTextureSubImage3DEXT, GetProcAddress('glCopyTextureSubImage3DEXT'));
     glMultiTexParameterfEXT := SYSTEM.VAL(TglMultiTexParameterfEXT, GetProcAddress('glMultiTexParameterfEXT'));
     glMultiTexParameterfvEXT := SYSTEM.VAL(TglMultiTexParameterfvEXT, GetProcAddress('glMultiTexParameterfvEXT'));
     glMultiTexParameteriEXT := SYSTEM.VAL(TglMultiTexParameteriEXT, GetProcAddress('glMultiTexParameteriEXT'));
     glMultiTexParameterivEXT := SYSTEM.VAL(TglMultiTexParameterivEXT, GetProcAddress('glMultiTexParameterivEXT'));
     glMultiTexImage1DEXT := SYSTEM.VAL(TglMultiTexImage1DEXT, GetProcAddress('glMultiTexImage1DEXT'));
     glMultiTexImage2DEXT := SYSTEM.VAL(TglMultiTexImage2DEXT, GetProcAddress('glMultiTexImage2DEXT'));
     glMultiTexSubImage1DEXT := SYSTEM.VAL(TglMultiTexSubImage1DEXT, GetProcAddress('glMultiTexSubImage1DEXT'));
     glMultiTexSubImage2DEXT := SYSTEM.VAL(TglMultiTexSubImage2DEXT, GetProcAddress('glMultiTexSubImage2DEXT'));
     glCopyMultiTexImage1DEXT := SYSTEM.VAL(TglCopyMultiTexImage1DEXT, GetProcAddress('glCopyMultiTexImage1DEXT'));
     glCopyMultiTexImage2DEXT := SYSTEM.VAL(TglCopyMultiTexImage2DEXT, GetProcAddress('glCopyMultiTexImage2DEXT'));
     glCopyMultiTexSubImage1DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage1DEXT, GetProcAddress('glCopyMultiTexSubImage1DEXT'));
     glCopyMultiTexSubImage2DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage2DEXT, GetProcAddress('glCopyMultiTexSubImage2DEXT'));
     glGetMultiTexImageEXT := SYSTEM.VAL(TglGetMultiTexImageEXT, GetProcAddress('glGetMultiTexImageEXT'));
     glGetMultiTexParameterfvEXT := SYSTEM.VAL(TglGetMultiTexParameterfvEXT, GetProcAddress('glGetMultiTexParameterfvEXT'));
     glGetMultiTexParameterivEXT := SYSTEM.VAL(TglGetMultiTexParameterivEXT, GetProcAddress('glGetMultiTexParameterivEXT'));
     glGetMultiTexLevelParameterfvEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterfvEXT, GetProcAddress('glGetMultiTexLevelParameterfvEXT'));
     glGetMultiTexLevelParameterivEXT := SYSTEM.VAL(TglGetMultiTexLevelParameterivEXT, GetProcAddress('glGetMultiTexLevelParameterivEXT'));
     glMultiTexImage3DEXT := SYSTEM.VAL(TglMultiTexImage3DEXT, GetProcAddress('glMultiTexImage3DEXT'));
     glMultiTexSubImage3DEXT := SYSTEM.VAL(TglMultiTexSubImage3DEXT, GetProcAddress('glMultiTexSubImage3DEXT'));
     glCopyMultiTexSubImage3DEXT := SYSTEM.VAL(TglCopyMultiTexSubImage3DEXT, GetProcAddress('glCopyMultiTexSubImage3DEXT'));
     glBindMultiTextureEXT := SYSTEM.VAL(TglBindMultiTextureEXT, GetProcAddress('glBindMultiTextureEXT'));
     glEnableClientStateIndexedEXT := SYSTEM.VAL(TglEnableClientStateIndexedEXT, GetProcAddress('glEnableClientStateIndexedEXT'));
     glDisableClientStateIndexedEXT := SYSTEM.VAL(TglDisableClientStateIndexedEXT, GetProcAddress('glDisableClientStateIndexedEXT'));
     glMultiTexCoordPointerEXT := SYSTEM.VAL(TglMultiTexCoordPointerEXT, GetProcAddress('glMultiTexCoordPointerEXT'));
     glMultiTexEnvfEXT := SYSTEM.VAL(TglMultiTexEnvfEXT, GetProcAddress('glMultiTexEnvfEXT'));
     glMultiTexEnvfvEXT := SYSTEM.VAL(TglMultiTexEnvfvEXT, GetProcAddress('glMultiTexEnvfvEXT'));
     glMultiTexEnviEXT := SYSTEM.VAL(TglMultiTexEnviEXT, GetProcAddress('glMultiTexEnviEXT'));
     glMultiTexEnvivEXT := SYSTEM.VAL(TglMultiTexEnvivEXT, GetProcAddress('glMultiTexEnvivEXT'));
     glMultiTexGendEXT := SYSTEM.VAL(TglMultiTexGendEXT, GetProcAddress('glMultiTexGendEXT'));
     glMultiTexGendvEXT := SYSTEM.VAL(TglMultiTexGendvEXT, GetProcAddress('glMultiTexGendvEXT'));
     glMultiTexGenfEXT := SYSTEM.VAL(TglMultiTexGenfEXT, GetProcAddress('glMultiTexGenfEXT'));
     glMultiTexGenfvEXT := SYSTEM.VAL(TglMultiTexGenfvEXT, GetProcAddress('glMultiTexGenfvEXT'));
     glMultiTexGeniEXT := SYSTEM.VAL(TglMultiTexGeniEXT, GetProcAddress('glMultiTexGeniEXT'));
     glMultiTexGenivEXT := SYSTEM.VAL(TglMultiTexGenivEXT, GetProcAddress('glMultiTexGenivEXT'));
     glGetMultiTexEnvfvEXT := SYSTEM.VAL(TglGetMultiTexEnvfvEXT, GetProcAddress('glGetMultiTexEnvfvEXT'));
     glGetMultiTexEnvivEXT := SYSTEM.VAL(TglGetMultiTexEnvivEXT, GetProcAddress('glGetMultiTexEnvivEXT'));
     glGetMultiTexGendvEXT := SYSTEM.VAL(TglGetMultiTexGendvEXT, GetProcAddress('glGetMultiTexGendvEXT'));
     glGetMultiTexGenfvEXT := SYSTEM.VAL(TglGetMultiTexGenfvEXT, GetProcAddress('glGetMultiTexGenfvEXT'));
     glGetMultiTexGenivEXT := SYSTEM.VAL(TglGetMultiTexGenivEXT, GetProcAddress('glGetMultiTexGenivEXT'));
     glGetFloatIndexedvEXT := SYSTEM.VAL(TglGetFloatIndexedvEXT, GetProcAddress('glGetFloatIndexedvEXT'));
     glGetDoubleIndexedvEXT := SYSTEM.VAL(TglGetDoubleIndexedvEXT, GetProcAddress('glGetDoubleIndexedvEXT'));
     glGetPointerIndexedvEXT := SYSTEM.VAL(TglGetPointerIndexedvEXT, GetProcAddress('glGetPointerIndexedvEXT'));
     glCompressedTextureImage3DEXT := SYSTEM.VAL(TglCompressedTextureImage3DEXT, GetProcAddress('glCompressedTextureImage3DEXT'));
     glCompressedTextureImage2DEXT := SYSTEM.VAL(TglCompressedTextureImage2DEXT, GetProcAddress('glCompressedTextureImage2DEXT'));
     glCompressedTextureImage1DEXT := SYSTEM.VAL(TglCompressedTextureImage1DEXT, GetProcAddress('glCompressedTextureImage1DEXT'));
     glCompressedTextureSubImage3DEXT := SYSTEM.VAL(TglCompressedTextureSubImage3DEXT, GetProcAddress('glCompressedTextureSubImage3DEXT'));
     glCompressedTextureSubImage2DEXT := SYSTEM.VAL(TglCompressedTextureSubImage2DEXT, GetProcAddress('glCompressedTextureSubImage2DEXT'));
     glCompressedTextureSubImage1DEXT := SYSTEM.VAL(TglCompressedTextureSubImage1DEXT, GetProcAddress('glCompressedTextureSubImage1DEXT'));
     glGetCompressedTextureImageEXT := SYSTEM.VAL(TglGetCompressedTextureImageEXT, GetProcAddress('glGetCompressedTextureImageEXT'));
     glCompressedMultiTexImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexImage3DEXT, GetProcAddress('glCompressedMultiTexImage3DEXT'));
     glCompressedMultiTexImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexImage2DEXT, GetProcAddress('glCompressedMultiTexImage2DEXT'));
     glCompressedMultiTexImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexImage1DEXT, GetProcAddress('glCompressedMultiTexImage1DEXT'));
     glCompressedMultiTexSubImage3DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage3DEXT, GetProcAddress('glCompressedMultiTexSubImage3DEXT'));
     glCompressedMultiTexSubImage2DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage2DEXT, GetProcAddress('glCompressedMultiTexSubImage2DEXT'));
     glCompressedMultiTexSubImage1DEXT := SYSTEM.VAL(TglCompressedMultiTexSubImage1DEXT, GetProcAddress('glCompressedMultiTexSubImage1DEXT'));
     glGetCompressedMultiTexImageEXT := SYSTEM.VAL(TglGetCompressedMultiTexImageEXT, GetProcAddress('glGetCompressedMultiTexImageEXT'));
     glNamedProgramStringEXT := SYSTEM.VAL(TglNamedProgramStringEXT, GetProcAddress('glNamedProgramStringEXT'));
     glNamedProgramLocalParameter4dEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dEXT, GetProcAddress('glNamedProgramLocalParameter4dEXT'));
     glNamedProgramLocalParameter4dvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4dvEXT, GetProcAddress('glNamedProgramLocalParameter4dvEXT'));
     glNamedProgramLocalParameter4fEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fEXT, GetProcAddress('glNamedProgramLocalParameter4fEXT'));
     glNamedProgramLocalParameter4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameter4fvEXT, GetProcAddress('glNamedProgramLocalParameter4fvEXT'));
     glGetNamedProgramLocalParameterdvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterdvEXT, GetProcAddress('glGetNamedProgramLocalParameterdvEXT'));
     glGetNamedProgramLocalParameterfvEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterfvEXT, GetProcAddress('glGetNamedProgramLocalParameterfvEXT'));
     glGetNamedProgramivEXT := SYSTEM.VAL(TglGetNamedProgramivEXT, GetProcAddress('glGetNamedProgramivEXT'));
     glGetNamedProgramStringEXT := SYSTEM.VAL(TglGetNamedProgramStringEXT, GetProcAddress('glGetNamedProgramStringEXT'));
     glNamedProgramLocalParameters4fvEXT := SYSTEM.VAL(TglNamedProgramLocalParameters4fvEXT, GetProcAddress('glNamedProgramLocalParameters4fvEXT'));
     glNamedProgramLocalParameterI4iEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4iEXT, GetProcAddress('glNamedProgramLocalParameterI4iEXT'));
     glNamedProgramLocalParameterI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4ivEXT, GetProcAddress('glNamedProgramLocalParameterI4ivEXT'));
     glNamedProgramLocalParametersI4ivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4ivEXT, GetProcAddress('glNamedProgramLocalParametersI4ivEXT'));
     glNamedProgramLocalParameterI4uiEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uiEXT, GetProcAddress('glNamedProgramLocalParameterI4uiEXT'));
     glNamedProgramLocalParameterI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParameterI4uivEXT, GetProcAddress('glNamedProgramLocalParameterI4uivEXT'));
     glNamedProgramLocalParametersI4uivEXT := SYSTEM.VAL(TglNamedProgramLocalParametersI4uivEXT, GetProcAddress('glNamedProgramLocalParametersI4uivEXT'));
     glGetNamedProgramLocalParameterIivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIivEXT, GetProcAddress('glGetNamedProgramLocalParameterIivEXT'));
     glGetNamedProgramLocalParameterIuivEXT := SYSTEM.VAL(TglGetNamedProgramLocalParameterIuivEXT, GetProcAddress('glGetNamedProgramLocalParameterIuivEXT'));
     glTextureParameterIivEXT := SYSTEM.VAL(TglTextureParameterIivEXT, GetProcAddress('glTextureParameterIivEXT'));
     glTextureParameterIuivEXT := SYSTEM.VAL(TglTextureParameterIuivEXT, GetProcAddress('glTextureParameterIuivEXT'));
     glGetTextureParameterIivEXT := SYSTEM.VAL(TglGetTextureParameterIivEXT, GetProcAddress('glGetTextureParameterIivEXT'));
     glGetTextureParameterIuivEXT := SYSTEM.VAL(TglGetTextureParameterIuivEXT, GetProcAddress('glGetTextureParameterIuivEXT'));
     glMultiTexParameterIivEXT := SYSTEM.VAL(TglMultiTexParameterIivEXT, GetProcAddress('glMultiTexParameterIivEXT'));
     glMultiTexParameterIuivEXT := SYSTEM.VAL(TglMultiTexParameterIuivEXT, GetProcAddress('glMultiTexParameterIuivEXT'));
     glGetMultiTexParameterIivEXT := SYSTEM.VAL(TglGetMultiTexParameterIivEXT, GetProcAddress('glGetMultiTexParameterIivEXT'));
     glGetMultiTexParameterIuivEXT := SYSTEM.VAL(TglGetMultiTexParameterIuivEXT, GetProcAddress('glGetMultiTexParameterIuivEXT'));
     glProgramUniform1fEXT := SYSTEM.VAL(TglProgramUniform1fEXT, GetProcAddress('glProgramUniform1fEXT'));
     glProgramUniform2fEXT := SYSTEM.VAL(TglProgramUniform2fEXT, GetProcAddress('glProgramUniform2fEXT'));
     glProgramUniform3fEXT := SYSTEM.VAL(TglProgramUniform3fEXT, GetProcAddress('glProgramUniform3fEXT'));
     glProgramUniform4fEXT := SYSTEM.VAL(TglProgramUniform4fEXT, GetProcAddress('glProgramUniform4fEXT'));
     glProgramUniform1iEXT := SYSTEM.VAL(TglProgramUniform1iEXT, GetProcAddress('glProgramUniform1iEXT'));
     glProgramUniform2iEXT := SYSTEM.VAL(TglProgramUniform2iEXT, GetProcAddress('glProgramUniform2iEXT'));
     glProgramUniform3iEXT := SYSTEM.VAL(TglProgramUniform3iEXT, GetProcAddress('glProgramUniform3iEXT'));
     glProgramUniform4iEXT := SYSTEM.VAL(TglProgramUniform4iEXT, GetProcAddress('glProgramUniform4iEXT'));
     glProgramUniform1fvEXT := SYSTEM.VAL(TglProgramUniform1fvEXT, GetProcAddress('glProgramUniform1fvEXT'));
     glProgramUniform2fvEXT := SYSTEM.VAL(TglProgramUniform2fvEXT, GetProcAddress('glProgramUniform2fvEXT'));
     glProgramUniform3fvEXT := SYSTEM.VAL(TglProgramUniform3fvEXT, GetProcAddress('glProgramUniform3fvEXT'));
     glProgramUniform4fvEXT := SYSTEM.VAL(TglProgramUniform4fvEXT, GetProcAddress('glProgramUniform4fvEXT'));
     glProgramUniform1ivEXT := SYSTEM.VAL(TglProgramUniform1ivEXT, GetProcAddress('glProgramUniform1ivEXT'));
     glProgramUniform2ivEXT := SYSTEM.VAL(TglProgramUniform2ivEXT, GetProcAddress('glProgramUniform2ivEXT'));
     glProgramUniform3ivEXT := SYSTEM.VAL(TglProgramUniform3ivEXT, GetProcAddress('glProgramUniform3ivEXT'));
     glProgramUniform4ivEXT := SYSTEM.VAL(TglProgramUniform4ivEXT, GetProcAddress('glProgramUniform4ivEXT'));
     glProgramUniformMatrix2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2fvEXT, GetProcAddress('glProgramUniformMatrix2fvEXT'));
     glProgramUniformMatrix3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3fvEXT, GetProcAddress('glProgramUniformMatrix3fvEXT'));
     glProgramUniformMatrix4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4fvEXT, GetProcAddress('glProgramUniformMatrix4fvEXT'));
     glProgramUniformMatrix2x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3fvEXT, GetProcAddress('glProgramUniformMatrix2x3fvEXT'));
     glProgramUniformMatrix3x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2fvEXT, GetProcAddress('glProgramUniformMatrix3x2fvEXT'));
     glProgramUniformMatrix2x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4fvEXT, GetProcAddress('glProgramUniformMatrix2x4fvEXT'));
     glProgramUniformMatrix4x2fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2fvEXT, GetProcAddress('glProgramUniformMatrix4x2fvEXT'));
     glProgramUniformMatrix3x4fvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4fvEXT, GetProcAddress('glProgramUniformMatrix3x4fvEXT'));
     glProgramUniformMatrix4x3fvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3fvEXT, GetProcAddress('glProgramUniformMatrix4x3fvEXT'));
     glProgramUniform1uiEXT := SYSTEM.VAL(TglProgramUniform1uiEXT, GetProcAddress('glProgramUniform1uiEXT'));
     glProgramUniform2uiEXT := SYSTEM.VAL(TglProgramUniform2uiEXT, GetProcAddress('glProgramUniform2uiEXT'));
     glProgramUniform3uiEXT := SYSTEM.VAL(TglProgramUniform3uiEXT, GetProcAddress('glProgramUniform3uiEXT'));
     glProgramUniform4uiEXT := SYSTEM.VAL(TglProgramUniform4uiEXT, GetProcAddress('glProgramUniform4uiEXT'));
     glProgramUniform1uivEXT := SYSTEM.VAL(TglProgramUniform1uivEXT, GetProcAddress('glProgramUniform1uivEXT'));
     glProgramUniform2uivEXT := SYSTEM.VAL(TglProgramUniform2uivEXT, GetProcAddress('glProgramUniform2uivEXT'));
     glProgramUniform3uivEXT := SYSTEM.VAL(TglProgramUniform3uivEXT, GetProcAddress('glProgramUniform3uivEXT'));
     glProgramUniform4uivEXT := SYSTEM.VAL(TglProgramUniform4uivEXT, GetProcAddress('glProgramUniform4uivEXT'));
     glNamedBufferDataEXT := SYSTEM.VAL(TglNamedBufferDataEXT, GetProcAddress('glNamedBufferDataEXT'));
     glNamedBufferSubDataEXT := SYSTEM.VAL(TglNamedBufferSubDataEXT, GetProcAddress('glNamedBufferSubDataEXT'));
     glMapNamedBufferEXT := SYSTEM.VAL(TglMapNamedBufferEXT, GetProcAddress('glMapNamedBufferEXT'));
     glUnmapNamedBufferEXT := SYSTEM.VAL(TglUnmapNamedBufferEXT, GetProcAddress('glUnmapNamedBufferEXT'));
     glMapNamedBufferRangeEXT := SYSTEM.VAL(TglMapNamedBufferRangeEXT, GetProcAddress('glMapNamedBufferRangeEXT'));
     glFlushMappedNamedBufferRangeEXT := SYSTEM.VAL(TglFlushMappedNamedBufferRangeEXT, GetProcAddress('glFlushMappedNamedBufferRangeEXT'));
     glNamedCopyBufferSubDataEXT := SYSTEM.VAL(TglNamedCopyBufferSubDataEXT, GetProcAddress('glNamedCopyBufferSubDataEXT'));
     glGetNamedBufferParameterivEXT := SYSTEM.VAL(TglGetNamedBufferParameterivEXT, GetProcAddress('glGetNamedBufferParameterivEXT'));
     glGetNamedBufferPointervEXT := SYSTEM.VAL(TglGetNamedBufferPointervEXT, GetProcAddress('glGetNamedBufferPointervEXT'));
     glGetNamedBufferSubDataEXT := SYSTEM.VAL(TglGetNamedBufferSubDataEXT, GetProcAddress('glGetNamedBufferSubDataEXT'));
     glTextureBufferEXT := SYSTEM.VAL(TglTextureBufferEXT, GetProcAddress('glTextureBufferEXT'));
     glMultiTexBufferEXT := SYSTEM.VAL(TglMultiTexBufferEXT, GetProcAddress('glMultiTexBufferEXT'));
     glNamedRenderbufferStorageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageEXT, GetProcAddress('glNamedRenderbufferStorageEXT'));
     glGetNamedRenderbufferParameterivEXT := SYSTEM.VAL(TglGetNamedRenderbufferParameterivEXT, GetProcAddress('glGetNamedRenderbufferParameterivEXT'));
     glCheckNamedFramebufferStatusEXT := SYSTEM.VAL(TglCheckNamedFramebufferStatusEXT, GetProcAddress('glCheckNamedFramebufferStatusEXT'));
     glNamedFramebufferTexture1DEXT := SYSTEM.VAL(TglNamedFramebufferTexture1DEXT, GetProcAddress('glNamedFramebufferTexture1DEXT'));
     glNamedFramebufferTexture2DEXT := SYSTEM.VAL(TglNamedFramebufferTexture2DEXT, GetProcAddress('glNamedFramebufferTexture2DEXT'));
     glNamedFramebufferTexture3DEXT := SYSTEM.VAL(TglNamedFramebufferTexture3DEXT, GetProcAddress('glNamedFramebufferTexture3DEXT'));
     glNamedFramebufferRenderbufferEXT := SYSTEM.VAL(TglNamedFramebufferRenderbufferEXT, GetProcAddress('glNamedFramebufferRenderbufferEXT'));
     glGetNamedFramebufferAttachmentParameterivEXT := SYSTEM.VAL(TglGetNamedFramebufferAttachmentParameterivEXT, GetProcAddress('glGetNamedFramebufferAttachmentParameterivEXT'));
     glGenerateTextureMipmapEXT := SYSTEM.VAL(TglGenerateTextureMipmapEXT, GetProcAddress('glGenerateTextureMipmapEXT'));
     glGenerateMultiTexMipmapEXT := SYSTEM.VAL(TglGenerateMultiTexMipmapEXT, GetProcAddress('glGenerateMultiTexMipmapEXT'));
     glFramebufferDrawBufferEXT := SYSTEM.VAL(TglFramebufferDrawBufferEXT, GetProcAddress('glFramebufferDrawBufferEXT'));
     glFramebufferDrawBuffersEXT := SYSTEM.VAL(TglFramebufferDrawBuffersEXT, GetProcAddress('glFramebufferDrawBuffersEXT'));
     glFramebufferReadBufferEXT := SYSTEM.VAL(TglFramebufferReadBufferEXT, GetProcAddress('glFramebufferReadBufferEXT'));
     glGetFramebufferParameterivEXT := SYSTEM.VAL(TglGetFramebufferParameterivEXT, GetProcAddress('glGetFramebufferParameterivEXT'));
     glNamedRenderbufferStorageMultisampleEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleEXT, GetProcAddress('glNamedRenderbufferStorageMultisampleEXT'));
     glNamedRenderbufferStorageMultisampleCoverageEXT := SYSTEM.VAL(TglNamedRenderbufferStorageMultisampleCoverageEXT, GetProcAddress('glNamedRenderbufferStorageMultisampleCoverageEXT'));
     glNamedFramebufferTextureEXT := SYSTEM.VAL(TglNamedFramebufferTextureEXT, GetProcAddress('glNamedFramebufferTextureEXT'));
     glNamedFramebufferTextureLayerEXT := SYSTEM.VAL(TglNamedFramebufferTextureLayerEXT, GetProcAddress('glNamedFramebufferTextureLayerEXT'));
     glNamedFramebufferTextureFaceEXT := SYSTEM.VAL(TglNamedFramebufferTextureFaceEXT, GetProcAddress('glNamedFramebufferTextureFaceEXT'));
     glTextureRenderbufferEXT := SYSTEM.VAL(TglTextureRenderbufferEXT, GetProcAddress('glTextureRenderbufferEXT'));
     glMultiTexRenderbufferEXT := SYSTEM.VAL(TglMultiTexRenderbufferEXT, GetProcAddress('glMultiTexRenderbufferEXT'));
     glProgramUniform1dEXT := SYSTEM.VAL(TglProgramUniform1dEXT, GetProcAddress('glProgramUniform1dEXT'));
     glProgramUniform2dEXT := SYSTEM.VAL(TglProgramUniform2dEXT, GetProcAddress('glProgramUniform2dEXT'));
     glProgramUniform3dEXT := SYSTEM.VAL(TglProgramUniform3dEXT, GetProcAddress('glProgramUniform3dEXT'));
     glProgramUniform4dEXT := SYSTEM.VAL(TglProgramUniform4dEXT, GetProcAddress('glProgramUniform4dEXT'));
     glProgramUniform1dvEXT := SYSTEM.VAL(TglProgramUniform1dvEXT, GetProcAddress('glProgramUniform1dvEXT'));
     glProgramUniform2dvEXT := SYSTEM.VAL(TglProgramUniform2dvEXT, GetProcAddress('glProgramUniform2dvEXT'));
     glProgramUniform3dvEXT := SYSTEM.VAL(TglProgramUniform3dvEXT, GetProcAddress('glProgramUniform3dvEXT'));
     glProgramUniform4dvEXT := SYSTEM.VAL(TglProgramUniform4dvEXT, GetProcAddress('glProgramUniform4dvEXT'));
     glProgramUniformMatrix2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2dvEXT, GetProcAddress('glProgramUniformMatrix2dvEXT'));
     glProgramUniformMatrix3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3dvEXT, GetProcAddress('glProgramUniformMatrix3dvEXT'));
     glProgramUniformMatrix4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4dvEXT, GetProcAddress('glProgramUniformMatrix4dvEXT'));
     glProgramUniformMatrix2x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x3dvEXT, GetProcAddress('glProgramUniformMatrix2x3dvEXT'));
     glProgramUniformMatrix2x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix2x4dvEXT, GetProcAddress('glProgramUniformMatrix2x4dvEXT'));
     glProgramUniformMatrix3x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x2dvEXT, GetProcAddress('glProgramUniformMatrix3x2dvEXT'));
     glProgramUniformMatrix3x4dvEXT := SYSTEM.VAL(TglProgramUniformMatrix3x4dvEXT, GetProcAddress('glProgramUniformMatrix3x4dvEXT'));
     glProgramUniformMatrix4x2dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x2dvEXT, GetProcAddress('glProgramUniformMatrix4x2dvEXT'));
     glProgramUniformMatrix4x3dvEXT := SYSTEM.VAL(TglProgramUniformMatrix4x3dvEXT, GetProcAddress('glProgramUniformMatrix4x3dvEXT'));
END Read_GL_EXT_direct_state_access;

PROCEDURE Read_GL_EXT_separate_shader_objects;
BEGIN
     glUseShaderProgramEXT := SYSTEM.VAL(TglUseShaderProgramEXT, GetProcAddress('glUseShaderProgramEXT'));
     glActiveProgramEXT := SYSTEM.VAL(TglActiveProgramEXT, GetProcAddress('glActiveProgramEXT'));
     glCreateShaderProgramEXT := SYSTEM.VAL(TglCreateShaderProgramEXT, GetProcAddress('glCreateShaderProgramEXT'));
END Read_GL_EXT_separate_shader_objects;

PROCEDURE Read_GL_EXT_shader_image_load_store;
BEGIN
     glBindImageTextureEXT := SYSTEM.VAL(TglBindImageTextureEXT, GetProcAddress('glBindImageTextureEXT'));
     glMemoryBarrierEXT := SYSTEM.VAL(TglMemoryBarrierEXT, GetProcAddress('glMemoryBarrierEXT'));
END Read_GL_EXT_shader_image_load_store;

PROCEDURE Read_GL_EXT_vertex_attrib_64bit;
BEGIN
     glVertexAttribL1dEXT := SYSTEM.VAL(TglVertexAttribL1dEXT, GetProcAddress('glVertexAttribL1dEXT'));
     glVertexAttribL2dEXT := SYSTEM.VAL(TglVertexAttribL2dEXT, GetProcAddress('glVertexAttribL2dEXT'));
     glVertexAttribL3dEXT := SYSTEM.VAL(TglVertexAttribL3dEXT, GetProcAddress('glVertexAttribL3dEXT'));
     glVertexAttribL4dEXT := SYSTEM.VAL(TglVertexAttribL4dEXT, GetProcAddress('glVertexAttribL4dEXT'));
     glVertexAttribL1dvEXT := SYSTEM.VAL(TglVertexAttribL1dvEXT, GetProcAddress('glVertexAttribL1dvEXT'));
     glVertexAttribL2dvEXT := SYSTEM.VAL(TglVertexAttribL2dvEXT, GetProcAddress('glVertexAttribL2dvEXT'));
     glVertexAttribL3dvEXT := SYSTEM.VAL(TglVertexAttribL3dvEXT, GetProcAddress('glVertexAttribL3dvEXT'));
     glVertexAttribL4dvEXT := SYSTEM.VAL(TglVertexAttribL4dvEXT, GetProcAddress('glVertexAttribL4dvEXT'));
     glVertexAttribLPointerEXT := SYSTEM.VAL(TglVertexAttribLPointerEXT, GetProcAddress('glVertexAttribLPointerEXT'));
     glGetVertexAttribLdvEXT := SYSTEM.VAL(TglGetVertexAttribLdvEXT, GetProcAddress('glGetVertexAttribLdvEXT'));
     glVertexArrayVertexAttribLOffsetEXT := SYSTEM.VAL(TglVertexArrayVertexAttribLOffsetEXT, GetProcAddress('glVertexArrayVertexAttribLOffsetEXT'));
END Read_GL_EXT_vertex_attrib_64bit;

PROCEDURE Read_GL_HP_image_transform;
BEGIN
     glImageTransformParameteriHP := SYSTEM.VAL(TglImageTransformParameteriHP, GetProcAddress('glImageTransformParameteriHP'));
     glImageTransformParameterfHP := SYSTEM.VAL(TglImageTransformParameterfHP, GetProcAddress('glImageTransformParameterfHP'));
     glImageTransformParameterivHP := SYSTEM.VAL(TglImageTransformParameterivHP, GetProcAddress('glImageTransformParameterivHP'));
     glImageTransformParameterfvHP := SYSTEM.VAL(TglImageTransformParameterfvHP, GetProcAddress('glImageTransformParameterfvHP'));
     glGetImageTransformParameterivHP := SYSTEM.VAL(TglGetImageTransformParameterivHP, GetProcAddress('glGetImageTransformParameterivHP'));
     glGetImageTransformParameterfvHP := SYSTEM.VAL(TglGetImageTransformParameterfvHP, GetProcAddress('glGetImageTransformParameterfvHP'));
END Read_GL_HP_image_transform;

PROCEDURE Read_GL_IBM_multimode_draw_arrays;
BEGIN
     glMultiModeDrawArraysIBM := SYSTEM.VAL(TglMultiModeDrawArraysIBM, GetProcAddress('glMultiModeDrawArraysIBM'));
     glMultiModeDrawElementsIBM := SYSTEM.VAL(TglMultiModeDrawElementsIBM, GetProcAddress('glMultiModeDrawElementsIBM'));
END Read_GL_IBM_multimode_draw_arrays;

PROCEDURE Read_GL_IBM_vertex_array_lists;
BEGIN
     glColorPointerListIBM := SYSTEM.VAL(TglColorPointerListIBM, GetProcAddress('glColorPointerListIBM'));
     glSecondaryColorPointerListIBM := SYSTEM.VAL(TglSecondaryColorPointerListIBM, GetProcAddress('glSecondaryColorPointerListIBM'));
     glEdgeFlagPointerListIBM := SYSTEM.VAL(TglEdgeFlagPointerListIBM, GetProcAddress('glEdgeFlagPointerListIBM'));
     glFogCoordPointerListIBM := SYSTEM.VAL(TglFogCoordPointerListIBM, GetProcAddress('glFogCoordPointerListIBM'));
     glIndexPointerListIBM := SYSTEM.VAL(TglIndexPointerListIBM, GetProcAddress('glIndexPointerListIBM'));
     glNormalPointerListIBM := SYSTEM.VAL(TglNormalPointerListIBM, GetProcAddress('glNormalPointerListIBM'));
     glTexCoordPointerListIBM := SYSTEM.VAL(TglTexCoordPointerListIBM, GetProcAddress('glTexCoordPointerListIBM'));
     glVertexPointerListIBM := SYSTEM.VAL(TglVertexPointerListIBM, GetProcAddress('glVertexPointerListIBM'));
END Read_GL_IBM_vertex_array_lists;

PROCEDURE Read_GL_INGR_blend_func_separate;
BEGIN
     glBlendFuncSeparateINGR := SYSTEM.VAL(TglBlendFuncSeparateINGR, GetProcAddress('glBlendFuncSeparateINGR'));
END Read_GL_INGR_blend_func_separate;

PROCEDURE Read_GL_INTEL_parallel_arrays;
BEGIN
     glVertexPointervINTEL := SYSTEM.VAL(TglVertexPointervINTEL, GetProcAddress('glVertexPointervINTEL'));
     glNormalPointervINTEL := SYSTEM.VAL(TglNormalPointervINTEL, GetProcAddress('glNormalPointervINTEL'));
     glColorPointervINTEL := SYSTEM.VAL(TglColorPointervINTEL, GetProcAddress('glColorPointervINTEL'));
     glTexCoordPointervINTEL := SYSTEM.VAL(TglTexCoordPointervINTEL, GetProcAddress('glTexCoordPointervINTEL'));
END Read_GL_INTEL_parallel_arrays;

PROCEDURE Read_GL_MESA_resize_buffers;
BEGIN
     glResizeBuffersMESA := SYSTEM.VAL(TglResizeBuffersMESA, GetProcAddress('glResizeBuffersMESA'));
END Read_GL_MESA_resize_buffers;

PROCEDURE Read_GL_MESA_window_pos;
BEGIN
     glWindowPos2dMESA := SYSTEM.VAL(TglWindowPos2dMESA, GetProcAddress('glWindowPos2dMESA'));
     glWindowPos2dvMESA := SYSTEM.VAL(TglWindowPos2dvMESA, GetProcAddress('glWindowPos2dvMESA'));
     glWindowPos2fMESA := SYSTEM.VAL(TglWindowPos2fMESA, GetProcAddress('glWindowPos2fMESA'));
     glWindowPos2fvMESA := SYSTEM.VAL(TglWindowPos2fvMESA, GetProcAddress('glWindowPos2fvMESA'));
     glWindowPos2iMESA := SYSTEM.VAL(TglWindowPos2iMESA, GetProcAddress('glWindowPos2iMESA'));
     glWindowPos2ivMESA := SYSTEM.VAL(TglWindowPos2ivMESA, GetProcAddress('glWindowPos2ivMESA'));
     glWindowPos2sMESA := SYSTEM.VAL(TglWindowPos2sMESA, GetProcAddress('glWindowPos2sMESA'));
     glWindowPos2svMESA := SYSTEM.VAL(TglWindowPos2svMESA, GetProcAddress('glWindowPos2svMESA'));
     glWindowPos3dMESA := SYSTEM.VAL(TglWindowPos3dMESA, GetProcAddress('glWindowPos3dMESA'));
     glWindowPos3dvMESA := SYSTEM.VAL(TglWindowPos3dvMESA, GetProcAddress('glWindowPos3dvMESA'));
     glWindowPos3fMESA := SYSTEM.VAL(TglWindowPos3fMESA, GetProcAddress('glWindowPos3fMESA'));
     glWindowPos3fvMESA := SYSTEM.VAL(TglWindowPos3fvMESA, GetProcAddress('glWindowPos3fvMESA'));
     glWindowPos3iMESA := SYSTEM.VAL(TglWindowPos3iMESA, GetProcAddress('glWindowPos3iMESA'));
     glWindowPos3ivMESA := SYSTEM.VAL(TglWindowPos3ivMESA, GetProcAddress('glWindowPos3ivMESA'));
     glWindowPos3sMESA := SYSTEM.VAL(TglWindowPos3sMESA, GetProcAddress('glWindowPos3sMESA'));
     glWindowPos3svMESA := SYSTEM.VAL(TglWindowPos3svMESA, GetProcAddress('glWindowPos3svMESA'));
     glWindowPos4dMESA := SYSTEM.VAL(TglWindowPos4dMESA, GetProcAddress('glWindowPos4dMESA'));
     glWindowPos4dvMESA := SYSTEM.VAL(TglWindowPos4dvMESA, GetProcAddress('glWindowPos4dvMESA'));
     glWindowPos4fMESA := SYSTEM.VAL(TglWindowPos4fMESA, GetProcAddress('glWindowPos4fMESA'));
     glWindowPos4fvMESA := SYSTEM.VAL(TglWindowPos4fvMESA, GetProcAddress('glWindowPos4fvMESA'));
     glWindowPos4iMESA := SYSTEM.VAL(TglWindowPos4iMESA, GetProcAddress('glWindowPos4iMESA'));
     glWindowPos4ivMESA := SYSTEM.VAL(TglWindowPos4ivMESA, GetProcAddress('glWindowPos4ivMESA'));
     glWindowPos4sMESA := SYSTEM.VAL(TglWindowPos4sMESA, GetProcAddress('glWindowPos4sMESA'));
     glWindowPos4svMESA := SYSTEM.VAL(TglWindowPos4svMESA, GetProcAddress('glWindowPos4svMESA'));
END Read_GL_MESA_window_pos;

PROCEDURE Read_GL_NV_evaluators;
BEGIN
     glMapControlPointsNV := SYSTEM.VAL(TglMapControlPointsNV, GetProcAddress('glMapControlPointsNV'));
     glMapParameterivNV := SYSTEM.VAL(TglMapParameterivNV, GetProcAddress('glMapParameterivNV'));
     glMapParameterfvNV := SYSTEM.VAL(TglMapParameterfvNV, GetProcAddress('glMapParameterfvNV'));
     glGetMapControlPointsNV := SYSTEM.VAL(TglGetMapControlPointsNV, GetProcAddress('glGetMapControlPointsNV'));
     glGetMapParameterivNV := SYSTEM.VAL(TglGetMapParameterivNV, GetProcAddress('glGetMapParameterivNV'));
     glGetMapParameterfvNV := SYSTEM.VAL(TglGetMapParameterfvNV, GetProcAddress('glGetMapParameterfvNV'));
     glGetMapAttribParameterivNV := SYSTEM.VAL(TglGetMapAttribParameterivNV, GetProcAddress('glGetMapAttribParameterivNV'));
     glGetMapAttribParameterfvNV := SYSTEM.VAL(TglGetMapAttribParameterfvNV, GetProcAddress('glGetMapAttribParameterfvNV'));
     glEvalMapsNV := SYSTEM.VAL(TglEvalMapsNV, GetProcAddress('glEvalMapsNV'));
END Read_GL_NV_evaluators;

PROCEDURE Read_GL_NV_fence;
BEGIN
     glDeleteFencesNV := SYSTEM.VAL(TglDeleteFencesNV, GetProcAddress('glDeleteFencesNV'));
     glGenFencesNV := SYSTEM.VAL(TglGenFencesNV, GetProcAddress('glGenFencesNV'));
     glIsFenceNV := SYSTEM.VAL(TglIsFenceNV, GetProcAddress('glIsFenceNV'));
     glTestFenceNV := SYSTEM.VAL(TglTestFenceNV, GetProcAddress('glTestFenceNV'));
     glGetFenceivNV := SYSTEM.VAL(TglGetFenceivNV, GetProcAddress('glGetFenceivNV'));
     glFinishFenceNV := SYSTEM.VAL(TglFinishFenceNV, GetProcAddress('glFinishFenceNV'));
     glSetFenceNV := SYSTEM.VAL(TglSetFenceNV, GetProcAddress('glSetFenceNV'));
END Read_GL_NV_fence;

PROCEDURE Read_GL_NV_fragment_program;
BEGIN
     glProgramNamedParameter4fNV := SYSTEM.VAL(TglProgramNamedParameter4fNV, GetProcAddress('glProgramNamedParameter4fNV'));
     glProgramNamedParameter4dNV := SYSTEM.VAL(TglProgramNamedParameter4dNV, GetProcAddress('glProgramNamedParameter4dNV'));
     glProgramNamedParameter4fvNV := SYSTEM.VAL(TglProgramNamedParameter4fvNV, GetProcAddress('glProgramNamedParameter4fvNV'));
     glProgramNamedParameter4dvNV := SYSTEM.VAL(TglProgramNamedParameter4dvNV, GetProcAddress('glProgramNamedParameter4dvNV'));
     glGetProgramNamedParameterfvNV := SYSTEM.VAL(TglGetProgramNamedParameterfvNV, GetProcAddress('glGetProgramNamedParameterfvNV'));
     glGetProgramNamedParameterdvNV := SYSTEM.VAL(TglGetProgramNamedParameterdvNV, GetProcAddress('glGetProgramNamedParameterdvNV'));
END Read_GL_NV_fragment_program;

PROCEDURE Read_GL_NV_half_float;
BEGIN
     glVertex2hNV := SYSTEM.VAL(TglVertex2hNV, GetProcAddress('glVertex2hNV'));
     glVertex2hvNV := SYSTEM.VAL(TglVertex2hvNV, GetProcAddress('glVertex2hvNV'));
     glVertex3hNV := SYSTEM.VAL(TglVertex3hNV, GetProcAddress('glVertex3hNV'));
     glVertex3hvNV := SYSTEM.VAL(TglVertex3hvNV, GetProcAddress('glVertex3hvNV'));
     glVertex4hNV := SYSTEM.VAL(TglVertex4hNV, GetProcAddress('glVertex4hNV'));
     glVertex4hvNV := SYSTEM.VAL(TglVertex4hvNV, GetProcAddress('glVertex4hvNV'));
     glNormal3hNV := SYSTEM.VAL(TglNormal3hNV, GetProcAddress('glNormal3hNV'));
     glNormal3hvNV := SYSTEM.VAL(TglNormal3hvNV, GetProcAddress('glNormal3hvNV'));
     glColor3hNV := SYSTEM.VAL(TglColor3hNV, GetProcAddress('glColor3hNV'));
     glColor3hvNV := SYSTEM.VAL(TglColor3hvNV, GetProcAddress('glColor3hvNV'));
     glColor4hNV := SYSTEM.VAL(TglColor4hNV, GetProcAddress('glColor4hNV'));
     glColor4hvNV := SYSTEM.VAL(TglColor4hvNV, GetProcAddress('glColor4hvNV'));
     glTexCoord1hNV := SYSTEM.VAL(TglTexCoord1hNV, GetProcAddress('glTexCoord1hNV'));
     glTexCoord1hvNV := SYSTEM.VAL(TglTexCoord1hvNV, GetProcAddress('glTexCoord1hvNV'));
     glTexCoord2hNV := SYSTEM.VAL(TglTexCoord2hNV, GetProcAddress('glTexCoord2hNV'));
     glTexCoord2hvNV := SYSTEM.VAL(TglTexCoord2hvNV, GetProcAddress('glTexCoord2hvNV'));
     glTexCoord3hNV := SYSTEM.VAL(TglTexCoord3hNV, GetProcAddress('glTexCoord3hNV'));
     glTexCoord3hvNV := SYSTEM.VAL(TglTexCoord3hvNV, GetProcAddress('glTexCoord3hvNV'));
     glTexCoord4hNV := SYSTEM.VAL(TglTexCoord4hNV, GetProcAddress('glTexCoord4hNV'));
     glTexCoord4hvNV := SYSTEM.VAL(TglTexCoord4hvNV, GetProcAddress('glTexCoord4hvNV'));
     glMultiTexCoord1hNV := SYSTEM.VAL(TglMultiTexCoord1hNV, GetProcAddress('glMultiTexCoord1hNV'));
     glMultiTexCoord1hvNV := SYSTEM.VAL(TglMultiTexCoord1hvNV, GetProcAddress('glMultiTexCoord1hvNV'));
     glMultiTexCoord2hNV := SYSTEM.VAL(TglMultiTexCoord2hNV, GetProcAddress('glMultiTexCoord2hNV'));
     glMultiTexCoord2hvNV := SYSTEM.VAL(TglMultiTexCoord2hvNV, GetProcAddress('glMultiTexCoord2hvNV'));
     glMultiTexCoord3hNV := SYSTEM.VAL(TglMultiTexCoord3hNV, GetProcAddress('glMultiTexCoord3hNV'));
     glMultiTexCoord3hvNV := SYSTEM.VAL(TglMultiTexCoord3hvNV, GetProcAddress('glMultiTexCoord3hvNV'));
     glMultiTexCoord4hNV := SYSTEM.VAL(TglMultiTexCoord4hNV, GetProcAddress('glMultiTexCoord4hNV'));
     glMultiTexCoord4hvNV := SYSTEM.VAL(TglMultiTexCoord4hvNV, GetProcAddress('glMultiTexCoord4hvNV'));
     glFogCoordhNV := SYSTEM.VAL(TglFogCoordhNV, GetProcAddress('glFogCoordhNV'));
     glFogCoordhvNV := SYSTEM.VAL(TglFogCoordhvNV, GetProcAddress('glFogCoordhvNV'));
     glSecondaryColor3hNV := SYSTEM.VAL(TglSecondaryColor3hNV, GetProcAddress('glSecondaryColor3hNV'));
     glSecondaryColor3hvNV := SYSTEM.VAL(TglSecondaryColor3hvNV, GetProcAddress('glSecondaryColor3hvNV'));
     glVertexWeighthNV := SYSTEM.VAL(TglVertexWeighthNV, GetProcAddress('glVertexWeighthNV'));
     glVertexWeighthvNV := SYSTEM.VAL(TglVertexWeighthvNV, GetProcAddress('glVertexWeighthvNV'));
     glVertexAttrib1hNV := SYSTEM.VAL(TglVertexAttrib1hNV, GetProcAddress('glVertexAttrib1hNV'));
     glVertexAttrib1hvNV := SYSTEM.VAL(TglVertexAttrib1hvNV, GetProcAddress('glVertexAttrib1hvNV'));
     glVertexAttrib2hNV := SYSTEM.VAL(TglVertexAttrib2hNV, GetProcAddress('glVertexAttrib2hNV'));
     glVertexAttrib2hvNV := SYSTEM.VAL(TglVertexAttrib2hvNV, GetProcAddress('glVertexAttrib2hvNV'));
     glVertexAttrib3hNV := SYSTEM.VAL(TglVertexAttrib3hNV, GetProcAddress('glVertexAttrib3hNV'));
     glVertexAttrib3hvNV := SYSTEM.VAL(TglVertexAttrib3hvNV, GetProcAddress('glVertexAttrib3hvNV'));
     glVertexAttrib4hNV := SYSTEM.VAL(TglVertexAttrib4hNV, GetProcAddress('glVertexAttrib4hNV'));
     glVertexAttrib4hvNV := SYSTEM.VAL(TglVertexAttrib4hvNV, GetProcAddress('glVertexAttrib4hvNV'));
     glVertexAttribs1hvNV := SYSTEM.VAL(TglVertexAttribs1hvNV, GetProcAddress('glVertexAttribs1hvNV'));
     glVertexAttribs2hvNV := SYSTEM.VAL(TglVertexAttribs2hvNV, GetProcAddress('glVertexAttribs2hvNV'));
     glVertexAttribs3hvNV := SYSTEM.VAL(TglVertexAttribs3hvNV, GetProcAddress('glVertexAttribs3hvNV'));
     glVertexAttribs4hvNV := SYSTEM.VAL(TglVertexAttribs4hvNV, GetProcAddress('glVertexAttribs4hvNV'));
END Read_GL_NV_half_float;

PROCEDURE Read_GL_NV_occlusion_query;
BEGIN
     glGenOcclusionQueriesNV := SYSTEM.VAL(TglGenOcclusionQueriesNV, GetProcAddress('glGenOcclusionQueriesNV'));
     glDeleteOcclusionQueriesNV := SYSTEM.VAL(TglDeleteOcclusionQueriesNV, GetProcAddress('glDeleteOcclusionQueriesNV'));
     glIsOcclusionQueryNV := SYSTEM.VAL(TglIsOcclusionQueryNV, GetProcAddress('glIsOcclusionQueryNV'));
     glBeginOcclusionQueryNV := SYSTEM.VAL(TglBeginOcclusionQueryNV, GetProcAddress('glBeginOcclusionQueryNV'));
     glEndOcclusionQueryNV := SYSTEM.VAL(TglEndOcclusionQueryNV, GetProcAddress('glEndOcclusionQueryNV'));
     glGetOcclusionQueryivNV := SYSTEM.VAL(TglGetOcclusionQueryivNV, GetProcAddress('glGetOcclusionQueryivNV'));
     glGetOcclusionQueryuivNV := SYSTEM.VAL(TglGetOcclusionQueryuivNV, GetProcAddress('glGetOcclusionQueryuivNV'));
END Read_GL_NV_occlusion_query;

PROCEDURE Read_GL_NV_pixel_data_range;
BEGIN
     glPixelDataRangeNV := SYSTEM.VAL(TglPixelDataRangeNV, GetProcAddress('glPixelDataRangeNV'));
     glFlushPixelDataRangeNV := SYSTEM.VAL(TglFlushPixelDataRangeNV, GetProcAddress('glFlushPixelDataRangeNV'));
END Read_GL_NV_pixel_data_range;

PROCEDURE Read_GL_NV_point_sprite;
BEGIN
     glPointParameteriNV := SYSTEM.VAL(TglPointParameteriNV, GetProcAddress('glPointParameteriNV'));
     glPointParameterivNV := SYSTEM.VAL(TglPointParameterivNV, GetProcAddress('glPointParameterivNV'));
END Read_GL_NV_point_sprite;

PROCEDURE Read_GL_NV_primitive_restart;
BEGIN
     glPrimitiveRestartNV := SYSTEM.VAL(TglPrimitiveRestartNV, GetProcAddress('glPrimitiveRestartNV'));
     glPrimitiveRestartIndexNV := SYSTEM.VAL(TglPrimitiveRestartIndexNV, GetProcAddress('glPrimitiveRestartIndexNV'));
END Read_GL_NV_primitive_restart;

PROCEDURE Read_GL_NV_register_combiners;
BEGIN
     glCombinerParameterfvNV := SYSTEM.VAL(TglCombinerParameterfvNV, GetProcAddress('glCombinerParameterfvNV'));
     glCombinerParameterfNV := SYSTEM.VAL(TglCombinerParameterfNV, GetProcAddress('glCombinerParameterfNV'));
     glCombinerParameterivNV := SYSTEM.VAL(TglCombinerParameterivNV, GetProcAddress('glCombinerParameterivNV'));
     glCombinerParameteriNV := SYSTEM.VAL(TglCombinerParameteriNV, GetProcAddress('glCombinerParameteriNV'));
     glCombinerInputNV := SYSTEM.VAL(TglCombinerInputNV, GetProcAddress('glCombinerInputNV'));
     glCombinerOutputNV := SYSTEM.VAL(TglCombinerOutputNV, GetProcAddress('glCombinerOutputNV'));
     glFinalCombinerInputNV := SYSTEM.VAL(TglFinalCombinerInputNV, GetProcAddress('glFinalCombinerInputNV'));
     glGetCombinerInputParameterfvNV := SYSTEM.VAL(TglGetCombinerInputParameterfvNV, GetProcAddress('glGetCombinerInputParameterfvNV'));
     glGetCombinerInputParameterivNV := SYSTEM.VAL(TglGetCombinerInputParameterivNV, GetProcAddress('glGetCombinerInputParameterivNV'));
     glGetCombinerOutputParameterfvNV := SYSTEM.VAL(TglGetCombinerOutputParameterfvNV, GetProcAddress('glGetCombinerOutputParameterfvNV'));
     glGetCombinerOutputParameterivNV := SYSTEM.VAL(TglGetCombinerOutputParameterivNV, GetProcAddress('glGetCombinerOutputParameterivNV'));
     glGetFinalCombinerInputParameterfvNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterfvNV, GetProcAddress('glGetFinalCombinerInputParameterfvNV'));
     glGetFinalCombinerInputParameterivNV := SYSTEM.VAL(TglGetFinalCombinerInputParameterivNV, GetProcAddress('glGetFinalCombinerInputParameterivNV'));
END Read_GL_NV_register_combiners;

PROCEDURE Read_GL_NV_register_combiners2;
BEGIN
     glCombinerStageParameterfvNV := SYSTEM.VAL(TglCombinerStageParameterfvNV, GetProcAddress('glCombinerStageParameterfvNV'));
     glGetCombinerStageParameterfvNV := SYSTEM.VAL(TglGetCombinerStageParameterfvNV, GetProcAddress('glGetCombinerStageParameterfvNV'));
END Read_GL_NV_register_combiners2;

PROCEDURE Read_GL_NV_vertex_array_range;
BEGIN
     glFlushVertexArrayRangeNV := SYSTEM.VAL(TglFlushVertexArrayRangeNV, GetProcAddress('glFlushVertexArrayRangeNV'));
     glVertexArrayRangeNV := SYSTEM.VAL(TglVertexArrayRangeNV, GetProcAddress('glVertexArrayRangeNV'));
END Read_GL_NV_vertex_array_range;

PROCEDURE Read_GL_NV_vertex_program;
BEGIN
     glAreProgramsResidentNV := SYSTEM.VAL(TglAreProgramsResidentNV, GetProcAddress('glAreProgramsResidentNV'));
     glBindProgramNV := SYSTEM.VAL(TglBindProgramNV, GetProcAddress('glBindProgramNV'));
     glDeleteProgramsNV := SYSTEM.VAL(TglDeleteProgramsNV, GetProcAddress('glDeleteProgramsNV'));
     glExecuteProgramNV := SYSTEM.VAL(TglExecuteProgramNV, GetProcAddress('glExecuteProgramNV'));
     glGenProgramsNV := SYSTEM.VAL(TglGenProgramsNV, GetProcAddress('glGenProgramsNV'));
     glGetProgramParameterdvNV := SYSTEM.VAL(TglGetProgramParameterdvNV, GetProcAddress('glGetProgramParameterdvNV'));
     glGetProgramParameterfvNV := SYSTEM.VAL(TglGetProgramParameterfvNV, GetProcAddress('glGetProgramParameterfvNV'));
     glGetProgramivNV := SYSTEM.VAL(TglGetProgramivNV, GetProcAddress('glGetProgramivNV'));
     glGetProgramStringNV := SYSTEM.VAL(TglGetProgramStringNV, GetProcAddress('glGetProgramStringNV'));
     glGetTrackMatrixivNV := SYSTEM.VAL(TglGetTrackMatrixivNV, GetProcAddress('glGetTrackMatrixivNV'));
     glGetVertexAttribdvNV := SYSTEM.VAL(TglGetVertexAttribdvNV, GetProcAddress('glGetVertexAttribdvNV'));
     glGetVertexAttribfvNV := SYSTEM.VAL(TglGetVertexAttribfvNV, GetProcAddress('glGetVertexAttribfvNV'));
     glGetVertexAttribivNV := SYSTEM.VAL(TglGetVertexAttribivNV, GetProcAddress('glGetVertexAttribivNV'));
     glGetVertexAttribPointervNV := SYSTEM.VAL(TglGetVertexAttribPointervNV, GetProcAddress('glGetVertexAttribPointervNV'));
     glIsProgramNV := SYSTEM.VAL(TglIsProgramNV, GetProcAddress('glIsProgramNV'));
     glLoadProgramNV := SYSTEM.VAL(TglLoadProgramNV, GetProcAddress('glLoadProgramNV'));
     glProgramParameter4dNV := SYSTEM.VAL(TglProgramParameter4dNV, GetProcAddress('glProgramParameter4dNV'));
     glProgramParameter4dvNV := SYSTEM.VAL(TglProgramParameter4dvNV, GetProcAddress('glProgramParameter4dvNV'));
     glProgramParameter4fNV := SYSTEM.VAL(TglProgramParameter4fNV, GetProcAddress('glProgramParameter4fNV'));
     glProgramParameter4fvNV := SYSTEM.VAL(TglProgramParameter4fvNV, GetProcAddress('glProgramParameter4fvNV'));
     glProgramParameters4dvNV := SYSTEM.VAL(TglProgramParameters4dvNV, GetProcAddress('glProgramParameters4dvNV'));
     glProgramParameters4fvNV := SYSTEM.VAL(TglProgramParameters4fvNV, GetProcAddress('glProgramParameters4fvNV'));
     glRequestResidentProgramsNV := SYSTEM.VAL(TglRequestResidentProgramsNV, GetProcAddress('glRequestResidentProgramsNV'));
     glTrackMatrixNV := SYSTEM.VAL(TglTrackMatrixNV, GetProcAddress('glTrackMatrixNV'));
     glVertexAttribPointerNV := SYSTEM.VAL(TglVertexAttribPointerNV, GetProcAddress('glVertexAttribPointerNV'));
     glVertexAttrib1dNV := SYSTEM.VAL(TglVertexAttrib1dNV, GetProcAddress('glVertexAttrib1dNV'));
     glVertexAttrib1dvNV := SYSTEM.VAL(TglVertexAttrib1dvNV, GetProcAddress('glVertexAttrib1dvNV'));
     glVertexAttrib1fNV := SYSTEM.VAL(TglVertexAttrib1fNV, GetProcAddress('glVertexAttrib1fNV'));
     glVertexAttrib1fvNV := SYSTEM.VAL(TglVertexAttrib1fvNV, GetProcAddress('glVertexAttrib1fvNV'));
     glVertexAttrib1sNV := SYSTEM.VAL(TglVertexAttrib1sNV, GetProcAddress('glVertexAttrib1sNV'));
     glVertexAttrib1svNV := SYSTEM.VAL(TglVertexAttrib1svNV, GetProcAddress('glVertexAttrib1svNV'));
     glVertexAttrib2dNV := SYSTEM.VAL(TglVertexAttrib2dNV, GetProcAddress('glVertexAttrib2dNV'));
     glVertexAttrib2dvNV := SYSTEM.VAL(TglVertexAttrib2dvNV, GetProcAddress('glVertexAttrib2dvNV'));
     glVertexAttrib2fNV := SYSTEM.VAL(TglVertexAttrib2fNV, GetProcAddress('glVertexAttrib2fNV'));
     glVertexAttrib2fvNV := SYSTEM.VAL(TglVertexAttrib2fvNV, GetProcAddress('glVertexAttrib2fvNV'));
     glVertexAttrib2sNV := SYSTEM.VAL(TglVertexAttrib2sNV, GetProcAddress('glVertexAttrib2sNV'));
     glVertexAttrib2svNV := SYSTEM.VAL(TglVertexAttrib2svNV, GetProcAddress('glVertexAttrib2svNV'));
     glVertexAttrib3dNV := SYSTEM.VAL(TglVertexAttrib3dNV, GetProcAddress('glVertexAttrib3dNV'));
     glVertexAttrib3dvNV := SYSTEM.VAL(TglVertexAttrib3dvNV, GetProcAddress('glVertexAttrib3dvNV'));
     glVertexAttrib3fNV := SYSTEM.VAL(TglVertexAttrib3fNV, GetProcAddress('glVertexAttrib3fNV'));
     glVertexAttrib3fvNV := SYSTEM.VAL(TglVertexAttrib3fvNV, GetProcAddress('glVertexAttrib3fvNV'));
     glVertexAttrib3sNV := SYSTEM.VAL(TglVertexAttrib3sNV, GetProcAddress('glVertexAttrib3sNV'));
     glVertexAttrib3svNV := SYSTEM.VAL(TglVertexAttrib3svNV, GetProcAddress('glVertexAttrib3svNV'));
     glVertexAttrib4dNV := SYSTEM.VAL(TglVertexAttrib4dNV, GetProcAddress('glVertexAttrib4dNV'));
     glVertexAttrib4dvNV := SYSTEM.VAL(TglVertexAttrib4dvNV, GetProcAddress('glVertexAttrib4dvNV'));
     glVertexAttrib4fNV := SYSTEM.VAL(TglVertexAttrib4fNV, GetProcAddress('glVertexAttrib4fNV'));
     glVertexAttrib4fvNV := SYSTEM.VAL(TglVertexAttrib4fvNV, GetProcAddress('glVertexAttrib4fvNV'));
     glVertexAttrib4sNV := SYSTEM.VAL(TglVertexAttrib4sNV, GetProcAddress('glVertexAttrib4sNV'));
     glVertexAttrib4svNV := SYSTEM.VAL(TglVertexAttrib4svNV, GetProcAddress('glVertexAttrib4svNV'));
     glVertexAttrib4ubNV := SYSTEM.VAL(TglVertexAttrib4ubNV, GetProcAddress('glVertexAttrib4ubNV'));
     glVertexAttrib4ubvNV := SYSTEM.VAL(TglVertexAttrib4ubvNV, GetProcAddress('glVertexAttrib4ubvNV'));
     glVertexAttribs1dvNV := SYSTEM.VAL(TglVertexAttribs1dvNV, GetProcAddress('glVertexAttribs1dvNV'));
     glVertexAttribs1fvNV := SYSTEM.VAL(TglVertexAttribs1fvNV, GetProcAddress('glVertexAttribs1fvNV'));
     glVertexAttribs1svNV := SYSTEM.VAL(TglVertexAttribs1svNV, GetProcAddress('glVertexAttribs1svNV'));
     glVertexAttribs2dvNV := SYSTEM.VAL(TglVertexAttribs2dvNV, GetProcAddress('glVertexAttribs2dvNV'));
     glVertexAttribs2fvNV := SYSTEM.VAL(TglVertexAttribs2fvNV, GetProcAddress('glVertexAttribs2fvNV'));
     glVertexAttribs2svNV := SYSTEM.VAL(TglVertexAttribs2svNV, GetProcAddress('glVertexAttribs2svNV'));
     glVertexAttribs3dvNV := SYSTEM.VAL(TglVertexAttribs3dvNV, GetProcAddress('glVertexAttribs3dvNV'));
     glVertexAttribs3fvNV := SYSTEM.VAL(TglVertexAttribs3fvNV, GetProcAddress('glVertexAttribs3fvNV'));
     glVertexAttribs3svNV := SYSTEM.VAL(TglVertexAttribs3svNV, GetProcAddress('glVertexAttribs3svNV'));
     glVertexAttribs4dvNV := SYSTEM.VAL(TglVertexAttribs4dvNV, GetProcAddress('glVertexAttribs4dvNV'));
     glVertexAttribs4fvNV := SYSTEM.VAL(TglVertexAttribs4fvNV, GetProcAddress('glVertexAttribs4fvNV'));
     glVertexAttribs4svNV := SYSTEM.VAL(TglVertexAttribs4svNV, GetProcAddress('glVertexAttribs4svNV'));
     glVertexAttribs4ubvNV := SYSTEM.VAL(TglVertexAttribs4ubvNV, GetProcAddress('glVertexAttribs4ubvNV'));
END Read_GL_NV_vertex_program;

PROCEDURE Read_GL_NV_depth_buffer_float;
BEGIN
     glDepthRangedNV := SYSTEM.VAL(TglDepthRangedNV, GetProcAddress('glDepthRangedNV'));
     glClearDepthdNV := SYSTEM.VAL(TglClearDepthdNV, GetProcAddress('glClearDepthdNV'));
     glDepthBoundsdNV := SYSTEM.VAL(TglDepthBoundsdNV, GetProcAddress('glDepthBoundsdNV'));
END Read_GL_NV_depth_buffer_float;

PROCEDURE Read_GL_NV_framebuffer_multisample_coverage;
BEGIN
     glRenderbufferStorageMultsampleCoverageNV := SYSTEM.VAL(TglRenderbufferStorageMultsampleCoverageNV, GetProcAddress('glRenderbufferStorageMultsampleCoverageNV'));
END Read_GL_NV_framebuffer_multisample_coverage;

PROCEDURE Read_GL_NV_geometry_program4;
BEGIN
     glProgramVertexLimitNV := SYSTEM.VAL(TglProgramVertexLimitNV, GetProcAddress('glProgramVertexLimitNV'));
END Read_GL_NV_geometry_program4;

PROCEDURE Read_GL_NV_gpu_program4;
BEGIN
     glProgramLocalParameterI4iNV := SYSTEM.VAL(TglProgramLocalParameterI4iNV, GetProcAddress('glProgramLocalParameterI4iNV'));
     glProgramLocalParameterI4ivNV := SYSTEM.VAL(TglProgramLocalParameterI4ivNV, GetProcAddress('glProgramLocalParameterI4ivNV'));
     glProgramLocalParametersI4ivNV := SYSTEM.VAL(TglProgramLocalParametersI4ivNV, GetProcAddress('glProgramLocalParametersI4ivNV'));
     glProgramLocalParameterI4uiNV := SYSTEM.VAL(TglProgramLocalParameterI4uiNV, GetProcAddress('glProgramLocalParameterI4uiNV'));
     glProgramLocalParameterI4uivNV := SYSTEM.VAL(TglProgramLocalParameterI4uivNV, GetProcAddress('glProgramLocalParameterI4uivNV'));
     glProgramLocalParametersI4uivNV := SYSTEM.VAL(TglProgramLocalParametersI4uivNV, GetProcAddress('glProgramLocalParametersI4uivNV'));
     glProgramEnvParameterI4iNV := SYSTEM.VAL(TglProgramEnvParameterI4iNV, GetProcAddress('glProgramEnvParameterI4iNV'));
     glProgramEnvParameterI4ivNV := SYSTEM.VAL(TglProgramEnvParameterI4ivNV, GetProcAddress('glProgramEnvParameterI4ivNV'));
     glProgramEnvParametersI4ivNV := SYSTEM.VAL(TglProgramEnvParametersI4ivNV, GetProcAddress('glProgramEnvParametersI4ivNV'));
     glProgramEnvParameterI4uiNV := SYSTEM.VAL(TglProgramEnvParameterI4uiNV, GetProcAddress('glProgramEnvParameterI4uiNV'));
     glProgramEnvParameterI4uivNV := SYSTEM.VAL(TglProgramEnvParameterI4uivNV, GetProcAddress('glProgramEnvParameterI4uivNV'));
     glProgramEnvParametersI4uivNV := SYSTEM.VAL(TglProgramEnvParametersI4uivNV, GetProcAddress('glProgramEnvParametersI4uivNV'));
     glGetProgramLocalParameterIivNV := SYSTEM.VAL(TglGetProgramLocalParameterIivNV, GetProcAddress('glGetProgramLocalParameterIivNV'));
     glGetProgramLocalParameterIuivNV := SYSTEM.VAL(TglGetProgramLocalParameterIuivNV, GetProcAddress('glGetProgramLocalParameterIuivNV'));
     glGetProgramEnvParameterIivNV := SYSTEM.VAL(TglGetProgramEnvParameterIivNV, GetProcAddress('glGetProgramEnvParameterIivNV'));
     glGetProgramEnvParameterIuivNV := SYSTEM.VAL(TglGetProgramEnvParameterIuivNV, GetProcAddress('glGetProgramEnvParameterIuivNV'));
END Read_GL_NV_gpu_program4;

PROCEDURE Read_GL_NV_parameter_buffer_object;
BEGIN
     glProgramBufferParametersfvNV := SYSTEM.VAL(TglProgramBufferParametersfvNV, GetProcAddress('glProgramBufferParametersfvNV'));
     glProgramBufferParametersIivNV := SYSTEM.VAL(TglProgramBufferParametersIivNV, GetProcAddress('glProgramBufferParametersIivNV'));
     glProgramBufferParametersIuivNV := SYSTEM.VAL(TglProgramBufferParametersIuivNV, GetProcAddress('glProgramBufferParametersIuivNV'));
END Read_GL_NV_parameter_buffer_object;

PROCEDURE Read_GL_NV_transform_feedback;
BEGIN
     glBeginTransformFeedbackNV := SYSTEM.VAL(TglBeginTransformFeedbackNV, GetProcAddress('glBeginTransformFeedbackNV'));
     glEndTransformFeedbackNV := SYSTEM.VAL(TglEndTransformFeedbackNV, GetProcAddress('glEndTransformFeedbackNV'));
     glTransformFeedbackAttribsNV := SYSTEM.VAL(TglTransformFeedbackAttribsNV, GetProcAddress('glTransformFeedbackAttribsNV'));
     glBindBufferRangeNV := SYSTEM.VAL(TglBindBufferRangeNV, GetProcAddress('glBindBufferRangeNV'));
     glBindBufferOffsetNV := SYSTEM.VAL(TglBindBufferOffsetNV, GetProcAddress('glBindBufferOffsetNV'));
     glBindBufferBaseNV := SYSTEM.VAL(TglBindBufferBaseNV, GetProcAddress('glBindBufferBaseNV'));
     glTransformFeedbackVaryingsNV := SYSTEM.VAL(TglTransformFeedbackVaryingsNV, GetProcAddress('glTransformFeedbackVaryingsNV'));
     glActiveVaryingNV := SYSTEM.VAL(TglActiveVaryingNV, GetProcAddress('glActiveVaryingNV'));
     glGetVaryingLocationNV := SYSTEM.VAL(TglGetVaryingLocationNV, GetProcAddress('glGetVaryingLocationNV'));
     glGetActiveVaryingNV := SYSTEM.VAL(TglGetActiveVaryingNV, GetProcAddress('glGetActiveVaryingNV'));
     glGetTransformFeedbackVaryingNV := SYSTEM.VAL(TglGetTransformFeedbackVaryingNV, GetProcAddress('glGetTransformFeedbackVaryingNV'));
     glTransformFeedbackStreamAttribsNV := SYSTEM.VAL(TglTransformFeedbackStreamAttribsNV, GetProcAddress('glTransformFeedbackStreamAttribsNV'));
END Read_GL_NV_transform_feedback;

PROCEDURE Read_GL_NV_conditional_render;
BEGIN
     glBeginConditionalRenderNV := SYSTEM.VAL(TglBeginConditionalRenderNV, GetProcAddress('glBeginConditionalRenderNV'));
     glEndConditionalRenderNV := SYSTEM.VAL(TglEndConditionalRenderNV, GetProcAddress('glEndConditionalRenderNV'));
END Read_GL_NV_conditional_render;

PROCEDURE Read_GL_NV_present_video;
BEGIN
     glPresentFrameKeyedNV := SYSTEM.VAL(TglPresentFrameKeyedNV, GetProcAddress('glPresentFrameKeyedNV'));
     glPresentFrameDualFillNV := SYSTEM.VAL(TglPresentFrameDualFillNV, GetProcAddress('glPresentFrameDualFillNV'));
     glGetVideoivNV := SYSTEM.VAL(TglGetVideoivNV, GetProcAddress('glGetVideoivNV'));
     glGetVideouivNV := SYSTEM.VAL(TglGetVideouivNV, GetProcAddress('glGetVideouivNV'));
     glGetVideoi64vNV := SYSTEM.VAL(TglGetVideoi64vNV, GetProcAddress('glGetVideoi64vNV'));
     glGetVideoui64vNV := SYSTEM.VAL(TglGetVideoui64vNV, GetProcAddress('glGetVideoui64vNV'));
END Read_GL_NV_present_video;

PROCEDURE Read_GL_NV_explicit_multisample;
BEGIN
     glGetMultisamplefvNV := SYSTEM.VAL(TglGetMultisamplefvNV, GetProcAddress('glGetMultisamplefvNV'));
     glSampleMaskIndexedNV := SYSTEM.VAL(TglSampleMaskIndexedNV, GetProcAddress('glSampleMaskIndexedNV'));
     glTexRenderbufferNV := SYSTEM.VAL(TglTexRenderbufferNV, GetProcAddress('glTexRenderbufferNV'));
END Read_GL_NV_explicit_multisample;

PROCEDURE Read_GL_NV_transform_feedback2;
BEGIN
     glBindTransformFeedbackNV := SYSTEM.VAL(TglBindTransformFeedbackNV, GetProcAddress('glBindTransformFeedbackNV'));
     glDeleteTransformFeedbacksNV := SYSTEM.VAL(TglDeleteTransformFeedbacksNV, GetProcAddress('glDeleteTransformFeedbacksNV'));
     glGenTransformFeedbacksNV := SYSTEM.VAL(TglGenTransformFeedbacksNV, GetProcAddress('glGenTransformFeedbacksNV'));
     glIsTransformFeedbackNV := SYSTEM.VAL(TglIsTransformFeedbackNV, GetProcAddress('glIsTransformFeedbackNV'));
     glPauseTransformFeedbackNV := SYSTEM.VAL(TglPauseTransformFeedbackNV, GetProcAddress('glPauseTransformFeedbackNV'));
     glResumeTransformFeedbackNV := SYSTEM.VAL(TglResumeTransformFeedbackNV, GetProcAddress('glResumeTransformFeedbackNV'));
     glDrawTransformFeedbackNV := SYSTEM.VAL(TglDrawTransformFeedbackNV, GetProcAddress('glDrawTransformFeedbackNV'));
END Read_GL_NV_transform_feedback2;

PROCEDURE Read_GL_NV_video_capture;
BEGIN
     glBeginVideoCaptureNV := SYSTEM.VAL(TglBeginVideoCaptureNV, GetProcAddress('glBeginVideoCaptureNV'));
     glBindVideoCaptureStreamBufferNV := SYSTEM.VAL(TglBindVideoCaptureStreamBufferNV, GetProcAddress('glBindVideoCaptureStreamBufferNV'));
     glBindVideoCaptureStreamTextureNV := SYSTEM.VAL(TglBindVideoCaptureStreamTextureNV, GetProcAddress('glBindVideoCaptureStreamTextureNV'));
     glEndVideoCaptureNV := SYSTEM.VAL(TglEndVideoCaptureNV, GetProcAddress('glEndVideoCaptureNV'));
     glGetVideoCaptureivNV := SYSTEM.VAL(TglGetVideoCaptureivNV, GetProcAddress('glGetVideoCaptureivNV'));
     glGetVideoCaptureStreamivNV := SYSTEM.VAL(TglGetVideoCaptureStreamivNV, GetProcAddress('glGetVideoCaptureStreamivNV'));
     glGetVideoCaptureStreamfvNV := SYSTEM.VAL(TglGetVideoCaptureStreamfvNV, GetProcAddress('glGetVideoCaptureStreamfvNV'));
     glGetVideoCaptureStreamdvNV := SYSTEM.VAL(TglGetVideoCaptureStreamdvNV, GetProcAddress('glGetVideoCaptureStreamdvNV'));
     glVideoCaptureNV := SYSTEM.VAL(TglVideoCaptureNV, GetProcAddress('glVideoCaptureNV'));
     glVideoCaptureStreamParameterivNV := SYSTEM.VAL(TglVideoCaptureStreamParameterivNV, GetProcAddress('glVideoCaptureStreamParameterivNV'));
     glVideoCaptureStreamParameterfvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterfvNV, GetProcAddress('glVideoCaptureStreamParameterfvNV'));
     glVideoCaptureStreamParameterdvNV := SYSTEM.VAL(TglVideoCaptureStreamParameterdvNV, GetProcAddress('glVideoCaptureStreamParameterdvNV'));
END Read_GL_NV_video_capture;

PROCEDURE Read_GL_NV_copy_image;
BEGIN
     glCopyImageSubDataNV := SYSTEM.VAL(TglCopyImageSubDataNV, GetProcAddress('glCopyImageSubDataNV'));
END Read_GL_NV_copy_image;

PROCEDURE Read_GL_NV_shader_buffer_load;
BEGIN
     glMakeBufferResidentNV := SYSTEM.VAL(TglMakeBufferResidentNV, GetProcAddress('glMakeBufferResidentNV'));
     glMakeBufferNonResidentNV := SYSTEM.VAL(TglMakeBufferNonResidentNV, GetProcAddress('glMakeBufferNonResidentNV'));
     glIsBufferResidentNV := SYSTEM.VAL(TglIsBufferResidentNV, GetProcAddress('glIsBufferResidentNV'));
     glMakeNamedBufferResidentNV := SYSTEM.VAL(TglMakeNamedBufferResidentNV, GetProcAddress('glMakeNamedBufferResidentNV'));
     glMakeNamedBufferNonResidentNV := SYSTEM.VAL(TglMakeNamedBufferNonResidentNV, GetProcAddress('glMakeNamedBufferNonResidentNV'));
     glIsNamedBufferResidentNV := SYSTEM.VAL(TglIsNamedBufferResidentNV, GetProcAddress('glIsNamedBufferResidentNV'));
     glGetBufferParameterui64vNV := SYSTEM.VAL(TglGetBufferParameterui64vNV, GetProcAddress('glGetBufferParameterui64vNV'));
     glGetNamedBufferParameterui64vNV := SYSTEM.VAL(TglGetNamedBufferParameterui64vNV, GetProcAddress('glGetNamedBufferParameterui64vNV'));
     glGetIntegerui64vNV := SYSTEM.VAL(TglGetIntegerui64vNV, GetProcAddress('glGetIntegerui64vNV'));
     glUniformui64NV := SYSTEM.VAL(TglUniformui64NV, GetProcAddress('glUniformui64NV'));
     glUniformui64vNV := SYSTEM.VAL(TglUniformui64vNV, GetProcAddress('glUniformui64vNV'));
     glGetUniformui64vNV := SYSTEM.VAL(TglGetUniformui64vNV, GetProcAddress('glGetUniformui64vNV'));
     glProgramUniformui64NV := SYSTEM.VAL(TglProgramUniformui64NV, GetProcAddress('glProgramUniformui64NV'));
     glProgramUniformui64vNV := SYSTEM.VAL(TglProgramUniformui64vNV, GetProcAddress('glProgramUniformui64vNV'));
END Read_GL_NV_shader_buffer_load;

PROCEDURE Read_GL_NV_vertex_buffer_unified_memory;
BEGIN
     glBufferAddressRangeNV := SYSTEM.VAL(TglBufferAddressRangeNV, GetProcAddress('glBufferAddressRangeNV'));
     glVertexFormatNV := SYSTEM.VAL(TglVertexFormatNV, GetProcAddress('glVertexFormatNV'));
     glNormalFormatNV := SYSTEM.VAL(TglNormalFormatNV, GetProcAddress('glNormalFormatNV'));
     glColorFormatNV := SYSTEM.VAL(TglColorFormatNV, GetProcAddress('glColorFormatNV'));
     glIndexFormatNV := SYSTEM.VAL(TglIndexFormatNV, GetProcAddress('glIndexFormatNV'));
     glTexCoordFormatNV := SYSTEM.VAL(TglTexCoordFormatNV, GetProcAddress('glTexCoordFormatNV'));
     glEdgeFlagFormatNV := SYSTEM.VAL(TglEdgeFlagFormatNV, GetProcAddress('glEdgeFlagFormatNV'));
     glSecondaryColorFormatNV := SYSTEM.VAL(TglSecondaryColorFormatNV, GetProcAddress('glSecondaryColorFormatNV'));
     glFogCoordFormatNV := SYSTEM.VAL(TglFogCoordFormatNV, GetProcAddress('glFogCoordFormatNV'));
     glVertexAttribFormatNV := SYSTEM.VAL(TglVertexAttribFormatNV, GetProcAddress('glVertexAttribFormatNV'));
     glVertexAttribIFormatNV := SYSTEM.VAL(TglVertexAttribIFormatNV, GetProcAddress('glVertexAttribIFormatNV'));
     glGetIntegerui64i_vNV := SYSTEM.VAL(TglGetIntegerui64i_vNV, GetProcAddress('glGetIntegerui64i_vNV'));
END Read_GL_NV_vertex_buffer_unified_memory;

PROCEDURE Read_GL_NV_gpu_program5;
BEGIN
     glProgramSubroutineParametersuivNV := SYSTEM.VAL(TglProgramSubroutineParametersuivNV, GetProcAddress('glProgramSubroutineParametersuivNV'));
     glGetProgramSubroutineParameteruivNV := SYSTEM.VAL(TglGetProgramSubroutineParameteruivNV, GetProcAddress('glGetProgramSubroutineParameteruivNV'));
END Read_GL_NV_gpu_program5;

PROCEDURE Read_GL_NV_gpu_shader5;
BEGIN
     glUniform1i64NV := SYSTEM.VAL(TglUniform1i64NV, GetProcAddress('glUniform1i64NV'));
     glUniform2i64NV := SYSTEM.VAL(TglUniform2i64NV, GetProcAddress('glUniform2i64NV'));
     glUniform3i64NV := SYSTEM.VAL(TglUniform3i64NV, GetProcAddress('glUniform3i64NV'));
     glUniform4i64NV := SYSTEM.VAL(TglUniform4i64NV, GetProcAddress('glUniform4i64NV'));
     glUniform1i64vNV := SYSTEM.VAL(TglUniform1i64vNV, GetProcAddress('glUniform1i64vNV'));
     glUniform2i64vNV := SYSTEM.VAL(TglUniform2i64vNV, GetProcAddress('glUniform2i64vNV'));
     glUniform3i64vNV := SYSTEM.VAL(TglUniform3i64vNV, GetProcAddress('glUniform3i64vNV'));
     glUniform4i64vNV := SYSTEM.VAL(TglUniform4i64vNV, GetProcAddress('glUniform4i64vNV'));
     glUniform1ui64NV := SYSTEM.VAL(TglUniform1ui64NV, GetProcAddress('glUniform1ui64NV'));
     glUniform2ui64NV := SYSTEM.VAL(TglUniform2ui64NV, GetProcAddress('glUniform2ui64NV'));
     glUniform3ui64NV := SYSTEM.VAL(TglUniform3ui64NV, GetProcAddress('glUniform3ui64NV'));
     glUniform4ui64NV := SYSTEM.VAL(TglUniform4ui64NV, GetProcAddress('glUniform4ui64NV'));
     glUniform1ui64vNV := SYSTEM.VAL(TglUniform1ui64vNV, GetProcAddress('glUniform1ui64vNV'));
     glUniform2ui64vNV := SYSTEM.VAL(TglUniform2ui64vNV, GetProcAddress('glUniform2ui64vNV'));
     glUniform3ui64vNV := SYSTEM.VAL(TglUniform3ui64vNV, GetProcAddress('glUniform3ui64vNV'));
     glUniform4ui64vNV := SYSTEM.VAL(TglUniform4ui64vNV, GetProcAddress('glUniform4ui64vNV'));
     glGetUniformi64vNV := SYSTEM.VAL(TglGetUniformi64vNV, GetProcAddress('glGetUniformi64vNV'));
     glProgramUniform1i64NV := SYSTEM.VAL(TglProgramUniform1i64NV, GetProcAddress('glProgramUniform1i64NV'));
     glProgramUniform2i64NV := SYSTEM.VAL(TglProgramUniform2i64NV, GetProcAddress('glProgramUniform2i64NV'));
     glProgramUniform3i64NV := SYSTEM.VAL(TglProgramUniform3i64NV, GetProcAddress('glProgramUniform3i64NV'));
     glProgramUniform4i64NV := SYSTEM.VAL(TglProgramUniform4i64NV, GetProcAddress('glProgramUniform4i64NV'));
     glProgramUniform1i64vNV := SYSTEM.VAL(TglProgramUniform1i64vNV, GetProcAddress('glProgramUniform1i64vNV'));
     glProgramUniform2i64vNV := SYSTEM.VAL(TglProgramUniform2i64vNV, GetProcAddress('glProgramUniform2i64vNV'));
     glProgramUniform3i64vNV := SYSTEM.VAL(TglProgramUniform3i64vNV, GetProcAddress('glProgramUniform3i64vNV'));
     glProgramUniform4i64vNV := SYSTEM.VAL(TglProgramUniform4i64vNV, GetProcAddress('glProgramUniform4i64vNV'));
     glProgramUniform1ui64NV := SYSTEM.VAL(TglProgramUniform1ui64NV, GetProcAddress('glProgramUniform1ui64NV'));
     glProgramUniform2ui64NV := SYSTEM.VAL(TglProgramUniform2ui64NV, GetProcAddress('glProgramUniform2ui64NV'));
     glProgramUniform3ui64NV := SYSTEM.VAL(TglProgramUniform3ui64NV, GetProcAddress('glProgramUniform3ui64NV'));
     glProgramUniform4ui64NV := SYSTEM.VAL(TglProgramUniform4ui64NV, GetProcAddress('glProgramUniform4ui64NV'));
     glProgramUniform1ui64vNV := SYSTEM.VAL(TglProgramUniform1ui64vNV, GetProcAddress('glProgramUniform1ui64vNV'));
     glProgramUniform2ui64vNV := SYSTEM.VAL(TglProgramUniform2ui64vNV, GetProcAddress('glProgramUniform2ui64vNV'));
     glProgramUniform3ui64vNV := SYSTEM.VAL(TglProgramUniform3ui64vNV, GetProcAddress('glProgramUniform3ui64vNV'));
     glProgramUniform4ui64vNV := SYSTEM.VAL(TglProgramUniform4ui64vNV, GetProcAddress('glProgramUniform4ui64vNV'));
END Read_GL_NV_gpu_shader5;

PROCEDURE Read_GL_NV_vertex_attrib_integer_64bit;
BEGIN
     glVertexAttribL1i64NV := SYSTEM.VAL(TglVertexAttribL1i64NV, GetProcAddress('glVertexAttribL1i64NV'));
     glVertexAttribL2i64NV := SYSTEM.VAL(TglVertexAttribL2i64NV, GetProcAddress('glVertexAttribL2i64NV'));
     glVertexAttribL3i64NV := SYSTEM.VAL(TglVertexAttribL3i64NV, GetProcAddress('glVertexAttribL3i64NV'));
     glVertexAttribL4i64NV := SYSTEM.VAL(TglVertexAttribL4i64NV, GetProcAddress('glVertexAttribL4i64NV'));
     glVertexAttribL1i64vNV := SYSTEM.VAL(TglVertexAttribL1i64vNV, GetProcAddress('glVertexAttribL1i64vNV'));
     glVertexAttribL2i64vNV := SYSTEM.VAL(TglVertexAttribL2i64vNV, GetProcAddress('glVertexAttribL2i64vNV'));
     glVertexAttribL3i64vNV := SYSTEM.VAL(TglVertexAttribL3i64vNV, GetProcAddress('glVertexAttribL3i64vNV'));
     glVertexAttribL4i64vNV := SYSTEM.VAL(TglVertexAttribL4i64vNV, GetProcAddress('glVertexAttribL4i64vNV'));
     glVertexAttribL1ui64NV := SYSTEM.VAL(TglVertexAttribL1ui64NV, GetProcAddress('glVertexAttribL1ui64NV'));
     glVertexAttribL2ui64NV := SYSTEM.VAL(TglVertexAttribL2ui64NV, GetProcAddress('glVertexAttribL2ui64NV'));
     glVertexAttribL3ui64NV := SYSTEM.VAL(TglVertexAttribL3ui64NV, GetProcAddress('glVertexAttribL3ui64NV'));
     glVertexAttribL4ui64NV := SYSTEM.VAL(TglVertexAttribL4ui64NV, GetProcAddress('glVertexAttribL4ui64NV'));
     glVertexAttribL1ui64vNV := SYSTEM.VAL(TglVertexAttribL1ui64vNV, GetProcAddress('glVertexAttribL1ui64vNV'));
     glVertexAttribL2ui64vNV := SYSTEM.VAL(TglVertexAttribL2ui64vNV, GetProcAddress('glVertexAttribL2ui64vNV'));
     glVertexAttribL3ui64vNV := SYSTEM.VAL(TglVertexAttribL3ui64vNV, GetProcAddress('glVertexAttribL3ui64vNV'));
     glVertexAttribL4ui64vNV := SYSTEM.VAL(TglVertexAttribL4ui64vNV, GetProcAddress('glVertexAttribL4ui64vNV'));
     glGetVertexAttribLi64vNV := SYSTEM.VAL(TglGetVertexAttribLi64vNV, GetProcAddress('glGetVertexAttribLi64vNV'));
     glGetVertexAttribLui64vNV := SYSTEM.VAL(TglGetVertexAttribLui64vNV, GetProcAddress('glGetVertexAttribLui64vNV'));
     glVertexAttribLFormatNV := SYSTEM.VAL(TglVertexAttribLFormatNV, GetProcAddress('glVertexAttribLFormatNV'));
END Read_GL_NV_vertex_attrib_integer_64bit;

PROCEDURE Read_GL_NV_vdpau_interop;
BEGIN
     glVDPAUInitNV := SYSTEM.VAL(TglVDPAUInitNV, GetProcAddress('glVDPAUInitNV'));
     glVDPAUFiniNV := SYSTEM.VAL(TglVDPAUFiniNV, GetProcAddress('glVDPAUFiniNV'));
     glVDPAURegisterVideoSurfaceNV := SYSTEM.VAL(TglVDPAURegisterVideoSurfaceNV, GetProcAddress('glVDPAURegisterVideoSurfaceNV'));
     glVDPAURegisterOutputSurfaceNV := SYSTEM.VAL(TglVDPAURegisterOutputSurfaceNV, GetProcAddress('glVDPAURegisterOutputSurfaceNV'));
     glVDPAUIsSurfaceNV := SYSTEM.VAL(TglVDPAUIsSurfaceNV, GetProcAddress('glVDPAUIsSurfaceNV'));
     glVDPAUUnregisterSurfaceNV := SYSTEM.VAL(TglVDPAUUnregisterSurfaceNV, GetProcAddress('glVDPAUUnregisterSurfaceNV'));
     glVDPAUGetSurfaceivNV := SYSTEM.VAL(TglVDPAUGetSurfaceivNV, GetProcAddress('glVDPAUGetSurfaceivNV'));
     glVDPAUSurfaceAccessNV := SYSTEM.VAL(TglVDPAUSurfaceAccessNV, GetProcAddress('glVDPAUSurfaceAccessNV'));
     glVDPAUMapSurfacesNV := SYSTEM.VAL(TglVDPAUMapSurfacesNV, GetProcAddress('glVDPAUMapSurfacesNV'));
     glVDPAUUnmapSurfacesNV := SYSTEM.VAL(TglVDPAUUnmapSurfacesNV, GetProcAddress('glVDPAUUnmapSurfacesNV'));
END Read_GL_NV_vdpau_interop;

PROCEDURE Read_GL_NV_texture_barrier;
BEGIN
     glTextureBarrierNV := SYSTEM.VAL(TglTextureBarrierNV, GetProcAddress('glTextureBarrierNV'));
END Read_GL_NV_texture_barrier;

PROCEDURE Read_GL_PGI_misc_hints;
BEGIN
     glHintPGI := SYSTEM.VAL(TglHintPGI, GetProcAddress('glHintPGI'));
END Read_GL_PGI_misc_hints;

PROCEDURE Read_GL_SGIS_detail_texture;
BEGIN
     glDetailTexFuncSGIS := SYSTEM.VAL(TglDetailTexFuncSGIS, GetProcAddress('glDetailTexFuncSGIS'));
     glGetDetailTexFuncSGIS := SYSTEM.VAL(TglGetDetailTexFuncSGIS, GetProcAddress('glGetDetailTexFuncSGIS'))
END Read_GL_SGIS_detail_texture;

PROCEDURE Read_GL_SGIS_fog_function;
BEGIN
     glFogFuncSGIS := SYSTEM.VAL(TglFogFuncSGIS, GetProcAddress('glFogFuncSGIS'));
     glGetFogFuncSGIS := SYSTEM.VAL(TglGetFogFuncSGIS, GetProcAddress('glGetFogFuncSGIS'));
END Read_GL_SGIS_fog_function;

PROCEDURE Read_GL_SGIS_multisample;
BEGIN
     glSampleMaskSGIS := SYSTEM.VAL(TglSampleMaskSGIS, GetProcAddress('glSampleMaskSGIS'));
     glSamplePatternSGIS := SYSTEM.VAL(TglSamplePatternSGIS, GetProcAddress('glSamplePatternSGIS'));
END Read_GL_SGIS_multisample;

PROCEDURE Read_GL_SGIS_pixel_texture;
BEGIN
     glPixelTexGenParameteriSGIS := SYSTEM.VAL(TglPixelTexGenParameteriSGIS, GetProcAddress('glPixelTexGenParameteriSGIS'));
     glPixelTexGenParameterivSGIS := SYSTEM.VAL(TglPixelTexGenParameterivSGIS, GetProcAddress('glPixelTexGenParameterivSGIS'));
     glPixelTexGenParameterfSGIS := SYSTEM.VAL(TglPixelTexGenParameterfSGIS, GetProcAddress('glPixelTexGenParameterfSGIS'));
     glPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglPixelTexGenParameterfvSGIS, GetProcAddress('glPixelTexGenParameterfvSGIS'));
     glGetPixelTexGenParameterivSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterivSGIS, GetProcAddress('glGetPixelTexGenParameterivSGIS'));
     glGetPixelTexGenParameterfvSGIS := SYSTEM.VAL(TglGetPixelTexGenParameterfvSGIS, GetProcAddress('glGetPixelTexGenParameterfvSGIS'));
END Read_GL_SGIS_pixel_texture;

PROCEDURE Read_GL_SGIS_point_parameters;
BEGIN
     glPointParameterfSGIS := SYSTEM.VAL(TglPointParameterfSGIS, GetProcAddress('glPointParameterfSGIS'));
     glPointParameterfvSGIS := SYSTEM.VAL(TglPointParameterfvSGIS, GetProcAddress('glPointParameterfvSGIS'));
END Read_GL_SGIS_point_parameters;

PROCEDURE Read_GL_SGIS_sharpen_texture;
BEGIN
     glSharpenTexFuncSGIS := SYSTEM.VAL(TglSharpenTexFuncSGIS, GetProcAddress('glSharpenTexFuncSGIS'));
     glGetSharpenTexFuncSGIS := SYSTEM.VAL(TglGetSharpenTexFuncSGIS, GetProcAddress('glGetSharpenTexFuncSGIS'));
END Read_GL_SGIS_sharpen_texture;

PROCEDURE Read_GL_SGIS_texture4D;
BEGIN
	glTexImage4DSGIS := SYSTEM.VAL(TglTexImage4DSGIS, GetProcAddress('glTexImage4DSGIS'));
     glTexSubImage4DSGIS := SYSTEM.VAL(TglTexSubImage4DSGIS, GetProcAddress('glTexSubImage4DSGIS'));
END Read_GL_SGIS_texture4D;

PROCEDURE Read_GL_SGIS_texture_color_mask;
BEGIN
     glTextureColorMaskSGIS := SYSTEM.VAL(TglTextureColorMaskSGIS, GetProcAddress('glTextureColorMaskSGIS'));
END Read_GL_SGIS_texture_color_mask;

PROCEDURE Read_GL_SGIS_texture_filter4;
BEGIN
	glGetTexFilterFuncSGIS := SYSTEM.VAL(TglGetTexFilterFuncSGIS, GetProcAddress('glGetTexFilterFuncSGIS'));
     glTexFilterFuncSGIS := SYSTEM.VAL(TglTexFilterFuncSGIS, GetProcAddress('glTexFilterFuncSGIS'));
END Read_GL_SGIS_texture_filter4;

PROCEDURE Read_GL_SGIX_async;
BEGIN
     glAsyncMarkerSGIX := SYSTEM.VAL(TglAsyncMarkerSGIX, GetProcAddress('glAsyncMarkerSGIX'));
     glFinishAsyncSGIX := SYSTEM.VAL(TglFinishAsyncSGIX, GetProcAddress('glFinishAsyncSGIX'));
     glPollAsyncSGIX := SYSTEM.VAL(TglPollAsyncSGIX, GetProcAddress('glPollAsyncSGIX'));
     glGenAsyncMarkersSGIX := SYSTEM.VAL(TglGenAsyncMarkersSGIX, GetProcAddress('glGenAsyncMarkersSGIX'));
     glDeleteAsyncMarkersSGIX := SYSTEM.VAL(TglDeleteAsyncMarkersSGIX, GetProcAddress('glDeleteAsyncMarkersSGIX'));
     glIsAsyncMarkerSGIX := SYSTEM.VAL(TglIsAsyncMarkerSGIX, GetProcAddress('glIsAsyncMarkerSGIX'));
END Read_GL_SGIX_async;

PROCEDURE Read_GL_SGIX_flush_raster;
BEGIN
     glFlushRasterSGIX := SYSTEM.VAL(TglFlushRasterSGIX, GetProcAddress('glFlushRasterSGIX'));
END Read_GL_SGIX_flush_raster;

PROCEDURE Read_GL_SGIX_fragment_lighting;
BEGIN
     glFragmentColorMaterialSGIX := SYSTEM.VAL(TglFragmentColorMaterialSGIX, GetProcAddress('glFragmentColorMaterialSGIX'));
     glFragmentLightfSGIX := SYSTEM.VAL(TglFragmentLightfSGIX, GetProcAddress('glFragmentLightfSGIX'));
     glFragmentLightfvSGIX := SYSTEM.VAL(TglFragmentLightfvSGIX, GetProcAddress('glFragmentLightfvSGIX'));
     glFragmentLightiSGIX := SYSTEM.VAL(TglFragmentLightiSGIX, GetProcAddress('glFragmentLightiSGIX'));
     glFragmentLightivSGIX := SYSTEM.VAL(TglFragmentLightivSGIX, GetProcAddress('glFragmentLightivSGIX'));
     glFragmentLightModelfSGIX := SYSTEM.VAL(TglFragmentLightModelfSGIX, GetProcAddress('glFragmentLightModelfSGIX'));
     glFragmentLightModelfvSGIX := SYSTEM.VAL(TglFragmentLightModelfvSGIX, GetProcAddress('glFragmentLightModelfvSGIX'));
     glFragmentLightModeliSGIX := SYSTEM.VAL(TglFragmentLightModeliSGIX, GetProcAddress('glFragmentLightModeliSGIX'));
     glFragmentLightModelivSGIX := SYSTEM.VAL(TglFragmentLightModelivSGIX, GetProcAddress('glFragmentLightModelivSGIX'));
     glFragmentMaterialfSGIX := SYSTEM.VAL(TglFragmentMaterialfSGIX, GetProcAddress('glFragmentMaterialfSGIX'));
     glFragmentMaterialfvSGIX := SYSTEM.VAL(TglFragmentMaterialfvSGIX, GetProcAddress('glFragmentMaterialfvSGIX'));
     glFragmentMaterialiSGIX := SYSTEM.VAL(TglFragmentMaterialiSGIX, GetProcAddress('glFragmentMaterialiSGIX'));
     glFragmentMaterialivSGIX := SYSTEM.VAL(TglFragmentMaterialivSGIX, GetProcAddress('glFragmentMaterialivSGIX'));
     glGetFragmentLightfvSGIX := SYSTEM.VAL(TglGetFragmentLightfvSGIX, GetProcAddress('glGetFragmentLightfvSGIX'));
     glGetFragmentLightivSGIX := SYSTEM.VAL(TglGetFragmentLightivSGIX, GetProcAddress('glGetFragmentLightivSGIX'));
     glGetFragmentMaterialfvSGIX := SYSTEM.VAL(TglGetFragmentMaterialfvSGIX, GetProcAddress('glGetFragmentMaterialfvSGIX'));
     glGetFragmentMaterialivSGIX := SYSTEM.VAL(TglGetFragmentMaterialivSGIX, GetProcAddress('glGetFragmentMaterialivSGIX'));
     glLightEnviSGIX := SYSTEM.VAL(TglLightEnviSGIX, GetProcAddress('glLightEnviSGIX'))
END Read_GL_SGIX_fragment_lighting;

PROCEDURE Read_GL_SGIX_framezoom;
BEGIN
     glFrameZoomSGIX := SYSTEM.VAL(TglFrameZoomSGIX, GetProcAddress('glFrameZoomSGIX'));
END Read_GL_SGIX_framezoom;

PROCEDURE Read_GL_SGIX_igloo_interface;
BEGIN
     glIglooInterfaceSGIX := SYSTEM.VAL(TglIglooInterfaceSGIX, GetProcAddress('glIglooInterfaceSGIX'));
END Read_GL_SGIX_igloo_interface;

PROCEDURE Read_GL_SGIX_instruments;
BEGIN
     glGetInstrumentsSGIX := SYSTEM.VAL(TglGetInstrumentsSGIX, GetProcAddress('glGetInstrumentsSGIX'));
     glInstrumentsBufferSGIX := SYSTEM.VAL(TglInstrumentsBufferSGIX, GetProcAddress('glInstrumentsBufferSGIX'));
     glPollInstrumentsSGIX := SYSTEM.VAL(TglPollInstrumentsSGIX, GetProcAddress('glPollInstrumentsSGIX'));
     glReadInstrumentsSGIX := SYSTEM.VAL(TglReadInstrumentsSGIX, GetProcAddress('glReadInstrumentsSGIX'));
     glStartInstrumentsSGIX := SYSTEM.VAL(TglStartInstrumentsSGIX, GetProcAddress('glStartInstrumentsSGIX'));
     glStopInstrumentsSGIX := SYSTEM.VAL(TglStopInstrumentsSGIX, GetProcAddress('glStopInstrumentsSGIX'));
END Read_GL_SGIX_instruments;

PROCEDURE Read_GL_SGIX_list_priority;
BEGIN
     glGetListParameterfvSGIX := SYSTEM.VAL(TglGetListParameterfvSGIX, GetProcAddress('glGetListParameterfvSGIX'));
     glGetListParameterivSGIX := SYSTEM.VAL(TglGetListParameterivSGIX, GetProcAddress('glGetListParameterivSGIX'));
     glListParameterfSGIX := SYSTEM.VAL(TglListParameterfSGIX, GetProcAddress('glListParameterfSGIX'));
     glListParameterfvSGIX := SYSTEM.VAL(TglListParameterfvSGIX, GetProcAddress('glListParameterfvSGIX'));
     glListParameteriSGIX := SYSTEM.VAL(TglListParameteriSGIX, GetProcAddress('glListParameteriSGIX'));
     glListParameterivSGIX := SYSTEM.VAL(TglListParameterivSGIX, GetProcAddress('glListParameterivSGIX'))
END Read_GL_SGIX_list_priority;

PROCEDURE Read_GL_SGIX_pixel_texture;
BEGIN
     glPixelTexGenSGIX := SYSTEM.VAL(TglPixelTexGenSGIX, GetProcAddress('glPixelTexGenSGIX'));
END Read_GL_SGIX_pixel_texture;

PROCEDURE Read_GL_SGIX_polynomial_ffd;
BEGIN
     glDeformationMap3dSGIX := SYSTEM.VAL(TglDeformationMap3dSGIX, GetProcAddress('glDeformationMap3dSGIX'));
     glDeformationMap3fSGIX := SYSTEM.VAL(TglDeformationMap3fSGIX, GetProcAddress('glDeformationMap3fSGIX'));
     glDeformSGIX := SYSTEM.VAL(TglDeformSGIX, GetProcAddress('glDeformSGIX'));
     glLoadIdentityDeformationMapSGIX := SYSTEM.VAL(TglLoadIdentityDeformationMapSGIX, GetProcAddress('glLoadIdentityDeformationMapSGIX'));
END Read_GL_SGIX_polynomial_ffd;

PROCEDURE Read_GL_SGIX_reference_plane;
BEGIN
     glReferencePlaneSGIX := SYSTEM.VAL(TglReferencePlaneSGIX, GetProcAddress('glReferencePlaneSGIX'));
END Read_GL_SGIX_reference_plane;

PROCEDURE Read_GL_SGIX_sprite;
BEGIN
     glSpriteParameterfSGIX := SYSTEM.VAL(TglSpriteParameterfSGIX, GetProcAddress('glSpriteParameterfSGIX'));
     glSpriteParameterfvSGIX := SYSTEM.VAL(TglSpriteParameterfvSGIX, GetProcAddress('glSpriteParameterfvSGIX'));
     glSpriteParameteriSGIX := SYSTEM.VAL(TglSpriteParameteriSGIX, GetProcAddress('glSpriteParameteriSGIX'));
     glSpriteParameterivSGIX := SYSTEM.VAL(TglSpriteParameterivSGIX, GetProcAddress('glSpriteParameterivSGIX'));
END Read_GL_SGIX_sprite;

PROCEDURE Read_GL_SGIX_tag_sample_buffer;
BEGIN
     glTagSampleBufferSGIX := SYSTEM.VAL(TglTagSampleBufferSGIX, GetProcAddress('glTagSampleBufferSGIX'));
END Read_GL_SGIX_tag_sample_buffer;

PROCEDURE Read_GL_SGI_color_table;
BEGIN
     glColorTableSGI := SYSTEM.VAL(TglColorTableSGI, GetProcAddress('glColorTableSGI'));
     glColorTableParameterfvSGI := SYSTEM.VAL(TglColorTableParameterfvSGI, GetProcAddress('glColorTableParameterfvSGI'));
     glColorTableParameterivSGI := SYSTEM.VAL(TglColorTableParameterivSGI, GetProcAddress('glColorTableParameterivSGI'));
     glCopyColorTableSGI := SYSTEM.VAL(TglCopyColorTableSGI, GetProcAddress('glCopyColorTableSGI'));
     glGetColorTableSGI := SYSTEM.VAL(TglGetColorTableSGI, GetProcAddress('glGetColorTableSGI'));
     glGetColorTableParameterfvSGI := SYSTEM.VAL(TglGetColorTableParameterfvSGI, GetProcAddress('glGetColorTableParameterfvSGI'));
     glGetColorTableParameterivSGI := SYSTEM.VAL(TglGetColorTableParameterivSGI, GetProcAddress('glGetColorTableParameterivSGI'));
END Read_GL_SGI_color_table;

PROCEDURE Read_GL_SUNX_constant_data;
BEGIN
     glFinishTextureSUNX := SYSTEM.VAL(TglFinishTextureSUNX, GetProcAddress('glFinishTextureSUNX'));
END Read_GL_SUNX_constant_data;

PROCEDURE Read_GL_SUN_global_alpha;
BEGIN
     glGlobalAlphaFactorbSUN := SYSTEM.VAL(TglGlobalAlphaFactorbSUN, GetProcAddress('glGlobalAlphaFactorbSUN'));
     glGlobalAlphaFactorsSUN := SYSTEM.VAL(TglGlobalAlphaFactorsSUN, GetProcAddress('glGlobalAlphaFactorsSUN'));
     glGlobalAlphaFactoriSUN := SYSTEM.VAL(TglGlobalAlphaFactoriSUN, GetProcAddress('glGlobalAlphaFactoriSUN'));
     glGlobalAlphaFactorfSUN := SYSTEM.VAL(TglGlobalAlphaFactorfSUN, GetProcAddress('glGlobalAlphaFactorfSUN'));
     glGlobalAlphaFactordSUN := SYSTEM.VAL(TglGlobalAlphaFactordSUN, GetProcAddress('glGlobalAlphaFactordSUN'));
     glGlobalAlphaFactorubSUN := SYSTEM.VAL(TglGlobalAlphaFactorubSUN, GetProcAddress('glGlobalAlphaFactorubSUN'));
     glGlobalAlphaFactorusSUN := SYSTEM.VAL(TglGlobalAlphaFactorusSUN, GetProcAddress('glGlobalAlphaFactorusSUN'));
     glGlobalAlphaFactoruiSUN := SYSTEM.VAL(TglGlobalAlphaFactoruiSUN, GetProcAddress('glGlobalAlphaFactoruiSUN'));
END Read_GL_SUN_global_alpha;

PROCEDURE Read_GL_SUN_mesh_array;
BEGIN
     glDrawMeshArraysSUN := SYSTEM.VAL(TglDrawMeshArraysSUN, GetProcAddress('glDrawMeshArraysSUN'));
END Read_GL_SUN_mesh_array;

PROCEDURE Read_GL_SUN_triangle_list;
BEGIN
     glReplacementCodeuiSUN := SYSTEM.VAL(TglReplacementCodeuiSUN, GetProcAddress('glReplacementCodeuiSUN'));
     glReplacementCodeusSUN := SYSTEM.VAL(TglReplacementCodeusSUN, GetProcAddress('glReplacementCodeusSUN'));
     glReplacementCodeubSUN := SYSTEM.VAL(TglReplacementCodeubSUN, GetProcAddress('glReplacementCodeubSUN'));
     glReplacementCodeuivSUN := SYSTEM.VAL(TglReplacementCodeuivSUN, GetProcAddress('glReplacementCodeuivSUN'));
     glReplacementCodeusvSUN := SYSTEM.VAL(TglReplacementCodeusvSUN, GetProcAddress('glReplacementCodeusvSUN'));
     glReplacementCodeubvSUN := SYSTEM.VAL(TglReplacementCodeubvSUN, GetProcAddress('glReplacementCodeubvSUN'));
     glReplacementCodePointerSUN := SYSTEM.VAL(TglReplacementCodePointerSUN, GetProcAddress('glReplacementCodePointerSUN'));
END Read_GL_SUN_triangle_list;

PROCEDURE Read_GL_SUN_vertex;
BEGIN
     glColor4ubVertex2fSUN := SYSTEM.VAL(TglColor4ubVertex2fSUN, GetProcAddress('glColor4ubVertex2fSUN'));
     glColor4ubVertex2fvSUN := SYSTEM.VAL(TglColor4ubVertex2fvSUN, GetProcAddress('glColor4ubVertex2fvSUN'));
     glColor4ubVertex3fSUN := SYSTEM.VAL(TglColor4ubVertex3fSUN, GetProcAddress('glColor4ubVertex3fSUN'));
     glColor4ubVertex3fvSUN := SYSTEM.VAL(TglColor4ubVertex3fvSUN, GetProcAddress('glColor4ubVertex3fvSUN'));
     glColor3fVertex3fSUN := SYSTEM.VAL(TglColor3fVertex3fSUN, GetProcAddress('glColor3fVertex3fSUN'));
     glColor3fVertex3fvSUN := SYSTEM.VAL(TglColor3fVertex3fvSUN, GetProcAddress('glColor3fVertex3fvSUN'));
     glNormal3fVertex3fSUN := SYSTEM.VAL(TglNormal3fVertex3fSUN, GetProcAddress('glNormal3fVertex3fSUN'));
     glNormal3fVertex3fvSUN := SYSTEM.VAL(TglNormal3fVertex3fvSUN, GetProcAddress('glNormal3fVertex3fvSUN'));
     glColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fSUN, GetProcAddress('glColor4fNormal3fVertex3fSUN'));
     glColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglColor4fNormal3fVertex3fvSUN, GetProcAddress('glColor4fNormal3fVertex3fvSUN'));
     glTexCoord2fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fVertex3fSUN, GetProcAddress('glTexCoord2fVertex3fSUN'));
     glTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fVertex3fvSUN, GetProcAddress('glTexCoord2fVertex3fvSUN'));
     glTexCoord4fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fVertex4fSUN, GetProcAddress('glTexCoord4fVertex4fSUN'));
     glTexCoord4fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fVertex4fvSUN, GetProcAddress('glTexCoord4fVertex4fvSUN'));
     glTexCoord2fColor4ubVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fSUN, GetProcAddress('glTexCoord2fColor4ubVertex3fSUN'));
     glTexCoord2fColor4ubVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4ubVertex3fvSUN, GetProcAddress('glTexCoord2fColor4ubVertex3fvSUN'));
     glTexCoord2fColor3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fSUN, GetProcAddress('glTexCoord2fColor3fVertex3fSUN'));
     glTexCoord2fColor3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor3fVertex3fvSUN, GetProcAddress('glTexCoord2fColor3fVertex3fvSUN'));
     glTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fSUN, GetProcAddress('glTexCoord2fNormal3fVertex3fSUN'));
     glTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fNormal3fVertex3fvSUN, GetProcAddress('glTexCoord2fNormal3fVertex3fvSUN'));
     glTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fSUN, GetProcAddress('glTexCoord2fColor4fNormal3fVertex3fSUN'));
     glTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglTexCoord2fColor4fNormal3fVertex3fvSUN, GetProcAddress('glTexCoord2fColor4fNormal3fVertex3fvSUN'));
     glTexCoord4fColor4fNormal3fVertex4fSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fSUN, GetProcAddress('glTexCoord4fColor4fNormal3fVertex4fSUN'));
     glTexCoord4fColor4fNormal3fVertex4fvSUN := SYSTEM.VAL(TglTexCoord4fColor4fNormal3fVertex4fvSUN, GetProcAddress('glTexCoord4fColor4fNormal3fVertex4fvSUN'));
     glReplacementCodeuiVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fSUN, GetProcAddress('glReplacementCodeuiVertex3fSUN'));
     glReplacementCodeuiVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiVertex3fvSUN, GetProcAddress('glReplacementCodeuiVertex3fvSUN'));
     glReplacementCodeuiColor4ubVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fSUN, GetProcAddress('glReplacementCodeuiColor4ubVertex3fSUN'));
     glReplacementCodeuiColor4ubVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4ubVertex3fvSUN, GetProcAddress('glReplacementCodeuiColor4ubVertex3fvSUN'));
     glReplacementCodeuiColor3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fSUN, GetProcAddress('glReplacementCodeuiColor3fVertex3fSUN'));
     glReplacementCodeuiColor3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor3fVertex3fvSUN, GetProcAddress('glReplacementCodeuiColor3fVertex3fvSUN'));
     glReplacementCodeuiNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fSUN, GetProcAddress('glReplacementCodeuiNormal3fVertex3fSUN'));
     glReplacementCodeuiNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiNormal3fVertex3fvSUN, GetProcAddress('glReplacementCodeuiNormal3fVertex3fvSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fSUN, GetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiColor4fNormal3fVertex3fvSUN, GetProcAddress('glReplacementCodeuiColor4fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fSUN, GetProcAddress('glReplacementCodeuiTexCoord2fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fVertex3fvSUN, GetProcAddress('glReplacementCodeuiTexCoord2fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN, GetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN, GetProcAddress('glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN, GetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN'));
     glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN := SYSTEM.VAL(TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN, GetProcAddress('glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN'));
END Read_GL_SUN_vertex;

PROCEDURE Read_WGL_ARB_buffer_region;
BEGIN
     wglCreateBufferRegionARB := SYSTEM.VAL(TwglCreateBufferRegionARB, GetProcAddress('wglCreateBufferRegionARB'));
     wglDeleteBufferRegionARB := SYSTEM.VAL(TwglDeleteBufferRegionARB, GetProcAddress('wglDeleteBufferRegionARB'));
     wglSaveBufferRegionARB := SYSTEM.VAL(TwglSaveBufferRegionARB, GetProcAddress('wglSaveBufferRegionARB'));
     wglRestoreBufferRegionARB := SYSTEM.VAL(TwglRestoreBufferRegionARB, GetProcAddress('wglRestoreBufferRegionARB'));
END Read_WGL_ARB_buffer_region;

PROCEDURE Read_WGL_ARB_extensionsxstring;
BEGIN
     wglGetExtensionsStringARB := SYSTEM.VAL(TwglGetExtensionsStringARB, GetProcAddress('wglGetExtensionsStringARB'));
END Read_WGL_ARB_extensionsxstring;

PROCEDURE Read_WGL_ARB_make_current_read;
BEGIN
     wglMakeContextCurrentARB := SYSTEM.VAL(TwglMakeContextCurrentARB, GetProcAddress('wglMakeContextCurrentARB'));
     wglGetCurrentReadDCARB := SYSTEM.VAL(TwglGetCurrentReadDCARB, GetProcAddress('wglGetCurrentReadDCARB'));
END Read_WGL_ARB_make_current_read;

PROCEDURE Read_WGL_ARB_pbuffer;
BEGIN
     wglCreatePbufferARB := SYSTEM.VAL(TwglCreatePbufferARB, GetProcAddress('wglCreatePbufferARB'));
     wglGetPbufferDCARB := SYSTEM.VAL(TwglGetPbufferDCARB, GetProcAddress('wglGetPbufferDCARB'));
     wglReleasePbufferDCARB := SYSTEM.VAL(TwglReleasePbufferDCARB, GetProcAddress('wglReleasePbufferDCARB'));
     wglDestroyPbufferARB := SYSTEM.VAL(TwglDestroyPbufferARB, GetProcAddress('wglDestroyPbufferARB'));
     wglQueryPbufferARB := SYSTEM.VAL(TwglQueryPbufferARB, GetProcAddress('wglQueryPbufferARB'));
END Read_WGL_ARB_pbuffer;

PROCEDURE Read_WGL_ARB_pixel_format;
BEGIN
     wglGetPixelFormatAttribivARB := SYSTEM.VAL(TwglGetPixelFormatAttribivARB, GetProcAddress('wglGetPixelFormatAttribivARB'));
     wglGetPixelFormatAttribfvARB := SYSTEM.VAL(TwglGetPixelFormatAttribfvARB, GetProcAddress('wglGetPixelFormatAttribfvARB'));
     wglChoosePixelFormatARB := SYSTEM.VAL(TwglChoosePixelFormatARB, GetProcAddress('wglChoosePixelFormatARB'));
END Read_WGL_ARB_pixel_format;

PROCEDURE Read_WGL_ARB_pixel_format_float;
BEGIN
     wglClampColorARB := SYSTEM.VAL(TwglClampColorARB, GetProcAddress('wglClampColorARB'));
END Read_WGL_ARB_pixel_format_float;

PROCEDURE Read_WGL_ARB_render_texture;
BEGIN
     wglBindTexImageARB := SYSTEM.VAL(TwglBindTexImageARB, GetProcAddress('wglBindTexImageARB'));
     wglReleaseTexImageARB := SYSTEM.VAL(TwglReleaseTexImageARB, GetProcAddress('wglReleaseTexImageARB'));
     wglSetPbufferAttribARB := SYSTEM.VAL(TwglSetPbufferAttribARB, GetProcAddress('wglSetPbufferAttribARB'));
END Read_WGL_ARB_render_texture;

PROCEDURE Read_WGL_ARB_create_context;
BEGIN
     wglCreateContextAttribsARB := SYSTEM.VAL(TwglCreateContextAttribsARB, GetProcAddress('wglCreateContextAttribsARB'));
END Read_WGL_ARB_create_context;

PROCEDURE Read_WGL_AMD_gpu_association;
BEGIN
     wglGetGPUIDsAMD := SYSTEM.VAL(TwglGetGPUIDsAMD, GetProcAddress('wglGetGPUIDsAMD'));
     wglGetGPUInfoAMD := SYSTEM.VAL(TwglGetGPUInfoAMD, GetProcAddress('wglGetGPUInfoAMD'));
     wglGetContextGPUIDAMD := SYSTEM.VAL(TwglGetContextGPUIDAMD, GetProcAddress('wglGetContextGPUIDAMD'));
     wglCreateAssociatedContextAMD := SYSTEM.VAL(TwglCreateAssociatedContextAMD, GetProcAddress('wglCreateAssociatedContextAMD'));
     wglCreateAssociatedContextAttribsAMD := SYSTEM.VAL(TwglCreateAssociatedContextAttribsAMD, GetProcAddress('wglCreateAssociatedContextAttribsAMD'));
     wglDeleteAssociatedContextAMD := SYSTEM.VAL(TwglDeleteAssociatedContextAMD, GetProcAddress('wglDeleteAssociatedContextAMD'));
     wglMakeAssociatedContextCurrentAMD := SYSTEM.VAL(TwglMakeAssociatedContextCurrentAMD, GetProcAddress('wglMakeAssociatedContextCurrentAMD'));
     wglGetCurrentAssociatedContextAMD := SYSTEM.VAL(TwglGetCurrentAssociatedContextAMD, GetProcAddress('wglGetCurrentAssociatedContextAMD'));
     wglBlitContextFramebufferAMD := SYSTEM.VAL(TwglBlitContextFramebufferAMD, GetProcAddress('wglBlitContextFramebufferAMD'));
END Read_WGL_AMD_gpu_association;

PROCEDURE Read_WGL_EXT_display_color_table;
BEGIN
     wglCreateDisplayColorTableEXT := SYSTEM.VAL(TwglCreateDisplayColorTableEXT, GetProcAddress('wglCreateDisplayColorTableEXT'));
     wglLoadDisplayColorTableEXT := SYSTEM.VAL(TwglLoadDisplayColorTableEXT, GetProcAddress('wglLoadDisplayColorTableEXT'));
     wglBindDisplayColorTableEXT := SYSTEM.VAL(TwglBindDisplayColorTableEXT, GetProcAddress('wglBindDisplayColorTableEXT'));
     wglDestroyDisplayColorTableEXT := SYSTEM.VAL(TwglDestroyDisplayColorTableEXT, GetProcAddress('wglDestroyDisplayColorTableEXT'));
END Read_WGL_EXT_display_color_table;

PROCEDURE Read_WGL_EXT_extensionsxstring;
BEGIN
     wglGetExtensionsStringEXT := SYSTEM.VAL(TwglGetExtensionsStringEXT, GetProcAddress('wglGetExtensionsStringEXT'));
END Read_WGL_EXT_extensionsxstring;

PROCEDURE Read_WGL_EXT_make_current_read;
BEGIN
     wglMakeContextCurrentEXT := SYSTEM.VAL(TwglMakeContextCurrentEXT, GetProcAddress('wglMakeContextCurrentEXT'));
     wglGetCurrentReadDCEXT := SYSTEM.VAL(TwglGetCurrentReadDCEXT, GetProcAddress('wglGetCurrentReadDCEXT'));
END Read_WGL_EXT_make_current_read;

PROCEDURE Read_WGL_EXT_pbuffer;
BEGIN
     wglCreatePbufferEXT := SYSTEM.VAL(TwglCreatePbufferEXT, GetProcAddress('wglCreatePbufferEXT'));
     wglGetPbufferDCEXT := SYSTEM.VAL(TwglGetPbufferDCEXT, GetProcAddress('wglGetPbufferDCEXT'));
     wglReleasePbufferDCEXT := SYSTEM.VAL(TwglReleasePbufferDCEXT, GetProcAddress('wglReleasePbufferDCEXT'));
     wglDestroyPbufferEXT := SYSTEM.VAL(TwglDestroyPbufferEXT, GetProcAddress('wglDestroyPbufferEXT'));
     wglQueryPbufferEXT := SYSTEM.VAL(TwglQueryPbufferEXT, GetProcAddress('wglQueryPbufferEXT'));
END Read_WGL_EXT_pbuffer;

PROCEDURE Read_WGL_EXT_pixel_format;
BEGIN
     wglGetPixelFormatAttribivEXT := SYSTEM.VAL(TwglGetPixelFormatAttribivEXT, GetProcAddress('wglGetPixelFormatAttribivEXT'));
     wglGetPixelFormatAttribfvEXT := SYSTEM.VAL(TwglGetPixelFormatAttribfvEXT, GetProcAddress('wglGetPixelFormatAttribfvEXT'));
     wglChoosePixelFormatEXT := SYSTEM.VAL(TwglChoosePixelFormatEXT, GetProcAddress('wglChoosePixelFormatEXT'));
END Read_WGL_EXT_pixel_format;

PROCEDURE Read_WGL_EXT_swap_control;
BEGIN
     wglSwapIntervalEXT := SYSTEM.VAL(TwglSwapIntervalEXT, GetProcAddress('wglSwapIntervalEXT'));
     wglGetSwapIntervalEXT := SYSTEM.VAL(TwglGetSwapIntervalEXT, GetProcAddress('wglGetSwapIntervalEXT'));
END Read_WGL_EXT_swap_control;

PROCEDURE Read_WGL_I3D_digital_video_control;
BEGIN
     wglGetDigitalVideoParametersI3D := SYSTEM.VAL(TwglGetDigitalVideoParametersI3D, GetProcAddress('wglGetDigitalVideoParametersI3D'));
     wglSetDigitalVideoParametersI3D := SYSTEM.VAL(TwglSetDigitalVideoParametersI3D, GetProcAddress('wglSetDigitalVideoParametersI3D'));
END Read_WGL_I3D_digital_video_control;

PROCEDURE Read_WGL_I3D_gamma;
BEGIN
     wglGetGammaTableParametersI3D := SYSTEM.VAL(TwglGetGammaTableParametersI3D, GetProcAddress('wglGetGammaTableParametersI3D'));
     wglSetGammaTableParametersI3D := SYSTEM.VAL(TwglSetGammaTableParametersI3D, GetProcAddress('wglSetGammaTableParametersI3D'));
     wglGetGammaTableI3D := SYSTEM.VAL(TwglGetGammaTableI3D, GetProcAddress('wglGetGammaTableI3D'));
     wglSetGammaTableI3D := SYSTEM.VAL(TwglSetGammaTableI3D, GetProcAddress('wglSetGammaTableI3D'));
END Read_WGL_I3D_gamma;

PROCEDURE Read_WGL_I3D_genlock;
BEGIN
     wglEnableGenlockI3D := SYSTEM.VAL(TwglEnableGenlockI3D, GetProcAddress('wglEnableGenlockI3D'));
     wglDisableGenlockI3D := SYSTEM.VAL(TwglDisableGenlockI3D, GetProcAddress('wglDisableGenlockI3D'));
     wglIsEnabledGenlockI3D := SYSTEM.VAL(TwglIsEnabledGenlockI3D, GetProcAddress('wglIsEnabledGenlockI3D'));
     wglGenlockSourceI3D := SYSTEM.VAL(TwglGenlockSourceI3D, GetProcAddress('wglGenlockSourceI3D'));
     wglGetGenlockSourceI3D := SYSTEM.VAL(TwglGetGenlockSourceI3D, GetProcAddress('wglGetGenlockSourceI3D'));
     wglGenlockSourceEdgeI3D := SYSTEM.VAL(TwglGenlockSourceEdgeI3D, GetProcAddress('wglGenlockSourceEdgeI3D'));
     wglGetGenlockSourceEdgeI3D := SYSTEM.VAL(TwglGetGenlockSourceEdgeI3D, GetProcAddress('wglGetGenlockSourceEdgeI3D'));
     wglGenlockSampleRateI3D := SYSTEM.VAL(TwglGenlockSampleRateI3D, GetProcAddress('wglGenlockSampleRateI3D'));
     wglGetGenlockSampleRateI3D := SYSTEM.VAL(TwglGetGenlockSampleRateI3D, GetProcAddress('wglGetGenlockSampleRateI3D'));
     wglGenlockSourceDelayI3D := SYSTEM.VAL(TwglGenlockSourceDelayI3D, GetProcAddress('wglGenlockSourceDelayI3D'));
     wglGetGenlockSourceDelayI3D := SYSTEM.VAL(TwglGetGenlockSourceDelayI3D, GetProcAddress('wglGetGenlockSourceDelayI3D'));
     wglQueryGenlockMaxSourceDelayI3D := SYSTEM.VAL(TwglQueryGenlockMaxSourceDelayI3D, GetProcAddress('wglQueryGenlockMaxSourceDelayI3D'));
END Read_WGL_I3D_genlock;

PROCEDURE Read_WGL_I3D_image_buffer;
BEGIN
     wglCreateImageBufferI3D := SYSTEM.VAL(TwglCreateImageBufferI3D, GetProcAddress('wglCreateImageBufferI3D'));
     wglDestroyImageBufferI3D := SYSTEM.VAL(TwglDestroyImageBufferI3D, GetProcAddress('wglDestroyImageBufferI3D'));
     wglAssociateImageBufferEventsI3D := SYSTEM.VAL(TwglAssociateImageBufferEventsI3D, GetProcAddress('wglAssociateImageBufferEventsI3D'));
     wglReleaseImageBufferEventsI3D := SYSTEM.VAL(TwglReleaseImageBufferEventsI3D, GetProcAddress('wglReleaseImageBufferEventsI3D'));
END Read_WGL_I3D_image_buffer;

PROCEDURE Read_WGL_I3D_swap_frame_lock;
BEGIN
     wglEnableFrameLockI3D := SYSTEM.VAL(TwglEnableFrameLockI3D, GetProcAddress('wglEnableFrameLockI3D'));
     wglDisableFrameLockI3D := SYSTEM.VAL(TwglDisableFrameLockI3D, GetProcAddress('wglDisableFrameLockI3D'));
     wglIsEnabledFrameLockI3D := SYSTEM.VAL(TwglIsEnabledFrameLockI3D, GetProcAddress('wglIsEnabledFrameLockI3D'));
     wglQueryFrameLockMasterI3D := SYSTEM.VAL(TwglQueryFrameLockMasterI3D, GetProcAddress('wglQueryFrameLockMasterI3D'));
END Read_WGL_I3D_swap_frame_lock;

PROCEDURE Read_WGL_I3D_swap_frame_usage;
BEGIN
     wglGetFrameUsageI3D := SYSTEM.VAL(TwglGetFrameUsageI3D, GetProcAddress('wglGetFrameUsageI3D'));
     wglBeginFrameTrackingI3D := SYSTEM.VAL(TwglBeginFrameTrackingI3D, GetProcAddress('wglBeginFrameTrackingI3D'));
     wglEndFrameTrackingI3D := SYSTEM.VAL(TwglEndFrameTrackingI3D, GetProcAddress('wglEndFrameTrackingI3D'));
     wglQueryFrameTrackingI3D := SYSTEM.VAL(TwglQueryFrameTrackingI3D, GetProcAddress('wglQueryFrameTrackingI3D'));
END Read_WGL_I3D_swap_frame_usage;

PROCEDURE Read_WGL_NV_vertex_array_range;
BEGIN
     wglAllocateMemoryNV := SYSTEM.VAL(TwglAllocateMemoryNV, GetProcAddress('wglAllocateMemoryNV'));
     wglFreeMemoryNV := SYSTEM.VAL(TwglFreeMemoryNV, GetProcAddress('wglFreeMemoryNV'));
END Read_WGL_NV_vertex_array_range;

PROCEDURE Read_WGL_NV_present_video;
BEGIN
     wglEnumerateVideoDevicesNV := SYSTEM.VAL(TwglEnumerateVideoDevicesNV, GetProcAddress('wglEnumerateVideoDevicesNV'));
(*     wglBindVideoDeviceNV := SYSTEM.VAL(TwglBindVideoDeviceNV, GetProcAddress('wglBindVideoDeviceNV')); *)
     wglQueryCurrentContextNV := SYSTEM.VAL(TwglQueryCurrentContextNV, GetProcAddress('wglQueryCurrentContextNV'));
END Read_WGL_NV_present_video;

PROCEDURE Read_WGL_NV_video_output;
BEGIN
     wglGetVideoDeviceNV := SYSTEM.VAL(TwglGetVideoDeviceNV, GetProcAddress('wglGetVideoDeviceNV'));
     wglReleaseVideoDeviceNV := SYSTEM.VAL(TwglReleaseVideoDeviceNV, GetProcAddress('wglReleaseVideoDeviceNV'));
     wglBindVideoImageNV := SYSTEM.VAL(TwglBindVideoImageNV, GetProcAddress('wglBindVideoImageNV'));
     wglReleaseVideoImageNV := SYSTEM.VAL(TwglReleaseVideoImageNV, GetProcAddress('wglReleaseVideoImageNV'));
     wglSendPbufferToVideoNV := SYSTEM.VAL(TwglSendPbufferToVideoNV, GetProcAddress('wglSendPbufferToVideoNV'));
     wglGetVideoInfoNV := SYSTEM.VAL(TwglGetVideoInfoNV, GetProcAddress('wglGetVideoInfoNV'));
END Read_WGL_NV_video_output;

PROCEDURE Read_WGL_NV_swap_group;
BEGIN
     wglJoinSwapGroupNV := SYSTEM.VAL(TwglJoinSwapGroupNV, GetProcAddress('wglJoinSwapGroupNV'));
     wglBindSwapBarrierNV := SYSTEM.VAL(TwglBindSwapBarrierNV, GetProcAddress('wglBindSwapBarrierNV'));
     wglQuerySwapGroupNV := SYSTEM.VAL(TwglQuerySwapGroupNV, GetProcAddress('wglQuerySwapGroupNV'));
     wglQueryMaxSwapGroupsNV := SYSTEM.VAL(TwglQueryMaxSwapGroupsNV, GetProcAddress('wglQueryMaxSwapGroupsNV'));
     wglQueryFrameCountNV := SYSTEM.VAL(TwglQueryFrameCountNV, GetProcAddress('wglQueryFrameCountNV'));
     wglResetFrameCountNV := SYSTEM.VAL(TwglResetFrameCountNV, GetProcAddress('wglResetFrameCountNV'));
END Read_WGL_NV_swap_group;

PROCEDURE Read_WGL_NV_gpu_affinity;
BEGIN
     wglEnumGpusNV := SYSTEM.VAL(TwglEnumGpusNV, GetProcAddress('wglEnumGpusNV'));
     wglEnumGpuDevicesNV := SYSTEM.VAL(TwglEnumGpuDevicesNV, GetProcAddress('wglEnumGpuDevicesNV'));
     wglCreateAffinityDCNV := SYSTEM.VAL(TwglCreateAffinityDCNV, GetProcAddress('wglCreateAffinityDCNV'));
     wglEnumGpusFromAffinityDCNV := SYSTEM.VAL(TwglEnumGpusFromAffinityDCNV, GetProcAddress('wglEnumGpusFromAffinityDCNV'));
     wglDeleteDCNV := SYSTEM.VAL(TwglDeleteDCNV, GetProcAddress('wglDeleteDCNV'));
END Read_WGL_NV_gpu_affinity;

PROCEDURE Read_WGL_NV_video_capture;
BEGIN
     wglBindVideoCaptureDeviceNV := SYSTEM.VAL(TwglBindVideoCaptureDeviceNV, GetProcAddress('wglBindVideoCaptureDeviceNV'));
     wglEnumerateVideoCaptureDevicesNV := SYSTEM.VAL(TwglEnumerateVideoCaptureDevicesNV, GetProcAddress('wglEnumerateVideoCaptureDevicesNV'));
     wglLockVideoCaptureDeviceNV := SYSTEM.VAL(TwglLockVideoCaptureDeviceNV, GetProcAddress('wglLockVideoCaptureDeviceNV'));
     wglQueryVideoCaptureDeviceNV := SYSTEM.VAL(TwglQueryVideoCaptureDeviceNV, GetProcAddress('wglQueryVideoCaptureDeviceNV'));
     wglReleaseVideoCaptureDeviceNV := SYSTEM.VAL(TwglReleaseVideoCaptureDeviceNV, GetProcAddress('wglReleaseVideoCaptureDeviceNV'));
END Read_WGL_NV_video_capture;

PROCEDURE Read_WGL_NV_copy_image;
BEGIN
     wglCopyImageSubDataNV := SYSTEM.VAL(TwglCopyImageSubDataNV, GetProcAddress('wglCopyImageSubDataNV'));
END Read_WGL_NV_copy_image;

PROCEDURE Read_WGL_OML_sync_control;
BEGIN
     wglGetSyncValuesOML := SYSTEM.VAL(TwglGetSyncValuesOML, GetProcAddress('wglGetSyncValuesOML'));
     wglGetMscRateOML := SYSTEM.VAL(TwglGetMscRateOML, GetProcAddress('wglGetMscRateOML'));
     wglSwapBuffersMscOML := SYSTEM.VAL(TwglSwapBuffersMscOML, GetProcAddress('wglSwapBuffersMscOML'));
     wglSwapLayerBuffersMscOML := SYSTEM.VAL(TwglSwapLayerBuffersMscOML, GetProcAddress('wglSwapLayerBuffersMscOML'));
     wglWaitForMscOML := SYSTEM.VAL(TwglWaitForMscOML, GetProcAddress('wglWaitForMscOML'));
     wglWaitForSbcOML := SYSTEM.VAL(TwglWaitForSbcOML, GetProcAddress('wglWaitForSbcOML'));
END Read_WGL_OML_sync_control;

PROCEDURE Read_WGL_3DL_stereo_control;
BEGIN
(*     wglSetStereoEmitterState3DL := SYSTEM.VAL(TwglSetStereoEmitterState3DL, GetProcAddress('wglSetStereoEmitterState3DL'));*)
END Read_WGL_3DL_stereo_control;

PROCEDURE Read_WIN_draw_range_elements;
BEGIN
     glDrawRangeElementsWIN := SYSTEM.VAL(TglDrawRangeElementsWIN, GetProcAddress('glDrawRangeElementsWIN'));
END Read_WIN_draw_range_elements;

PROCEDURE Read_WIN_swap_hint;
BEGIN
     glAddSwapHintRectWIN := SYSTEM.VAL(TglAddSwapHintRectWIN, GetProcAddress('glAddSwapHintRectWIN'));
END Read_WIN_swap_hint;


(***********************)

PROCEDURE ReadExtensions*;
BEGIN
  ReadOpenGLCore;

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
  Read_GL_ARB_vertexxtype_2_10_10_10_rev;
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
  (* GL 4.2 *)
  Read_GL_ARB_base_instance;
  Read_GL_ARB_transform_feedback_instanced;
  Read_GL_ARB_internalformat_query;
  Read_GL_ARB_shader_atomic_counters;
  Read_GL_ARB_shader_image_load_store;
  Read_GL_ARB_texture_storage;
  (* ****** *)
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
  GL_VERSION_4_2 := FALSE;

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
    IF MinorVersion >= 2 THEN GL_VERSION_4_2 := TRUE; END;
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
VAR pos: LONGINT;
BEGIN
	pos := Strings.Pos(thisextension, allextensions^);
	IF debug & (pos = -1) THEN
		KernelLog.String(thisextension); KernelLog.String(": NOT AVAILABLE"); KernelLog.Ln;
	END;
  RETURN pos > 0;
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
  GL_ARB_vertexxtype_2_10_10_10_rev := Int_CheckExtension(Buffer, 'GL_ARB_vertexxtype_2_10_10_10_rev');
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

 (* GL 4.2 *)
  GL_ARB_base_instance := Int_CheckExtension(Buffer, 'GL_ARB_base_instance');
  GL_ARB_shading_language_420pack := Int_CheckExtension(Buffer, 'GL_ARB_shading_language_420pack');
  GL_ARB_transform_feedback_instanced := Int_CheckExtension(Buffer, 'GL_ARB_transform_feedback_instanced');
  GL_ARB_compressed_texture_pixel_storage := Int_CheckExtension(Buffer, 'GL_ARB_compressed_texture_pixel_storage');
  GL_ARB_conservative_depth := Int_CheckExtension(Buffer, 'GL_ARB_conservative_depth');
  GL_ARB_internalformat_query := Int_CheckExtension(Buffer, 'GL_ARB_internalformat_query');
  GL_ARB_map_buffer_alignment := Int_CheckExtension(Buffer, 'GL_ARB_map_buffer_alignment');
  GL_ARB_shader_atomic_counters := Int_CheckExtension(Buffer, 'GL_ARB_shader_atomic_counters');
  GL_ARB_shader_image_load_store := Int_CheckExtension(Buffer, 'GL_ARB_shader_image_load_store');
  GL_ARB_shading_language_packing := Int_CheckExtension(Buffer, 'GL_ARB_shading_language_packing');
  GL_ARB_texture_storage := Int_CheckExtension(Buffer, 'GL_ARB_texture_storage');
  (* * *)

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
  WGL_ARB_extensions_string := Int_CheckExtension(Buffer, 'WGL_ARB_extensions_string');
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
  WGL_EXT_extensions_string := Int_CheckExtension(Buffer, 'WGL_EXT_extensions_string');
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

(* no need for Windows *)
PROCEDURE SetFCR*;
BEGIN
 (*oldfcr := Set8087CW(newfcr);*)
END SetFCR;

PROCEDURE DelFCR*;
BEGIN
(*  newfcr := Set8087CW(oldfcr); *)
END DelFCR;


BEGIN
 Modules.InstallTermHandler(OnClose);

 (*
 	133FH= {0..5, 8..9,12}
  *)
 oldfcr := FCR();
 newfcr := SYSTEM.VAL(SET, 133FH);
 InitOpenGL;
 ReadOpenGLCore();
END OpenGL.

