MODULE OpenGL; (** AUTHOR "fnecati"; PURPOSE "OpenGL binding for UnixAos"; *)

IMPORT SYSTEM, Unix, Modules, X11Api, Strings, GLC := OpenGLConst, KernelLog;

(*
	Compiler.Compile OpenGLConst.Mod Unix.OpenGL.Mod ~

 ==============================================================================
        OpenGL 4.2 - Headertranslation
        Version 4.2
        Date : 08.08.2011
        Works with : LinuxAos
 ==============================================================================
 *)

VAR
	 (* handle to library *)
 	GL_LibHandle: LONGINT;
	GLU_LibHandle:LONGINT;
	oldfcr, newfcr: SET; (* for FPU Control registers *)

CONST
   debug = FALSE; (* used in ReadImplementationProperties, when extension is not available *)
   GL_LibName = 'libGL.so';
   GLU_LibName = 'libGLU.so';


TYPE

  ADDRESS * =X11Api.ADDRESS;
  AnsiChar* = POINTER TO ARRAY OF CHAR;
  PAnsiChar * = ADDRESS;
  THandle * = LONGINT;
  XID* = X11Api.XID;

  GLenum * = LONGINT;
  GLboolean * = LONGINT;
  GLbitfield * = LONGINT; (* SET *)
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
  WORD * = INTEGER;
  DWORD * = LONGINT;

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
  TglDebugProcARB = PROCEDURE{C}(source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei; CONST xmessage: PGLchar; userParam: PGLvoid);

  (* GL_AMD_debug_output *)
  TglDebugProcAMD = PROCEDURE{C}(id: GLuint; category: GLenum; severity: GLenum; length: GLsizei; CONST xmessage: PGLchar; userParam: PGLvoid);

 (* GL_NV_vdpau_interop *)
  GLvdpauSurfaceNV = GLintptr;
  PGLvdpauSurfaceNV =  ADDRESS; (*POINTER TO ARRAY OF GLvdpauSurfaceNV;*)



 (*! GLX - LINUX *)

    DisplayPtr* = X11Api.DisplayPtr;
    VisualInfoPtr* = X11Api.VisualInfoPtr;

    GLXContext* = XID; (* Pointer *)
    GLXContextID* = XID;
    GLXDrawable* = XID;
    GLXFBConfig* = XID; (* Pointer *)
    GLXPbuffer* = XID;
    GLXPixmap* = XID;
    GLXWindow* = XID;

    Window* = XID;
    Colormap* = XID;
    Pixmap* = XID;
    Font* = XID;

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
  TGLUQuadricErrorProc * = PROCEDURE{C}(errorCode: GLenum);
  (* GLUTessCallback *)
  TGLUTessBeginProc * = PROCEDURE{C}(AType: GLenum);
  TGLUTessEdgeFlagProc * = PROCEDURE{C}(Flag: GLboolean);
  TGLUTessVertexProc * = PROCEDURE{C}(VertexData: Pointer);
  TGLUTessEndProc * = PROCEDURE{C};
  TGLUTessErrorProc * = PROCEDURE{C}(ErrNo: GLenum);
  TGLUTessCombineProc * = PROCEDURE{C}(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer);
  TGLUTessBeginDataProc * = PROCEDURE{C}(AType: GLenum; UserData: Pointer);
  TGLUTessEdgeFlagDataProc * = PROCEDURE{C}(Flag: GLboolean; UserData: Pointer);
  TGLUTessVertexDataProc * = PROCEDURE{C}(VertexData: Pointer; UserData: Pointer);
  TGLUTessEndDataProc * = PROCEDURE{C}(UserData: Pointer);
  TGLUTessErrorDataProc * = PROCEDURE{C}(ErrNo: GLenum; UserData: Pointer);
  TGLUTessCombineDataProc * = PROCEDURE{C}(Coords: TGLArrayd3; VertexData: TGLArrayp4; Weight: TGLArrayf4; OutData: PPointer; UserData: Pointer);
  (* GLUNurbsCallback *)
  TGLUNurbsErrorProc * = PROCEDURE{C}(ErrorCode: GLenum);

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
  TglCullFace = PROCEDURE{C}(mode: GLenum);
  TglFrontFace = PROCEDURE{C}(mode: GLenum);
  TglHint = PROCEDURE{C}(target: GLenum; mode: GLenum);
  TglLineWidth = PROCEDURE{C}(width: GLfloat);
  TglPointSize = PROCEDURE{C}(size: GLfloat);
  TglPolygonMode = PROCEDURE{C}(face: GLenum; mode: GLenum);
  TglScissor = PROCEDURE{C}(x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglTexParameterf = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLfloat);
  TglTexParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexParameteri = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLint);
  TglTexParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglTexImage1D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexImage2D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglDrawBuffer = PROCEDURE{C}(mode: GLenum);
  TglClear = PROCEDURE{C}(mask: GLbitfield);
  TglClearColor = PROCEDURE{C}(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);
  TglClearStencil = PROCEDURE{C}(s: GLint);
  TglClearDepth = PROCEDURE{C}(depth: GLclampd);
  TglStencilMask = PROCEDURE{C}(mask: GLuint);
  TglColorMask = PROCEDURE{C}(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean);
  TglDepthMask = PROCEDURE{C}(flag: GLboolean);
  TglDisable = PROCEDURE{C}(cap: GLenum);
  TglEnable = PROCEDURE{C}(cap: GLenum);
  TglFinish = PROCEDURE{C}();
  TglFlush = PROCEDURE{C}();
  TglBlendFunc = PROCEDURE{C}(sfactor: GLenum; dfactor: GLenum);
  TglLogicOp = PROCEDURE{C}(opcode: GLenum);
  TglStencilFunc = PROCEDURE{C}(func: GLenum; ref: GLint; mask: GLuint);
  TglStencilOp = PROCEDURE{C}(fail: GLenum; zfail: GLenum; zpass: GLenum);
  TglDepthFunc = PROCEDURE{C}(func: GLenum);
  TglPixelStoref = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPixelStorei = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglReadBuffer = PROCEDURE{C}(mode: GLenum);
  TglReadPixels = PROCEDURE{C}(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglGetBooleanv = PROCEDURE{C}(pname: GLenum; params: PGLboolean);
  TglGetDoublev = PROCEDURE{C}(pname: GLenum; params: PGLdouble);
  TglGetError = PROCEDURE{C}(): GLenum;
  TglGetFloatv = PROCEDURE{C}(pname: GLenum; params: PGLfloat);
  TglGetIntegerv* = PROCEDURE{C}(pname: GLenum; params: PGLint);
  TglGetString* =  PROCEDURE{C}(name: GLenum): ADDRESS;
  TglGetTexImage = PROCEDURE{C}(target: GLenum; level: GLint; format: GLenum; xtype: GLenum; pixels: PGLvoid);
  TglGetTexParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexLevelParameterfv = PROCEDURE{C}(target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetTexLevelParameteriv = PROCEDURE{C}(target: GLenum; level: GLint; pname: GLenum; params: PGLint);
  TglIsEnabled =  PROCEDURE{C}(cap: GLenum): GLboolean;
  TglDepthRange = PROCEDURE{C}(zNear: GLclampd; zFar: GLclampd);
  TglViewport = PROCEDURE{C}(x: GLint; y: GLint; width: GLsizei; height: GLsizei);

  (*! GL_VERSION_1_1 *)
  TglDrawArrays = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei);
  TglDrawElements = PROCEDURE{C}(mode: GLenum; count: GLsizei; xtype: GLenum;  indices: PGLvoid);
  TglGetPointerv = PROCEDURE{C}(pname: GLenum; params: PGLvoid);
  TglPolygonOffset = PROCEDURE{C}(factor: GLfloat; units: GLfloat);
  TglCopyTexImage1D = PROCEDURE{C}(target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTexImage2D = PROCEDURE{C}(target: GLenum; level: GLint; internalFormat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTexSubImage1D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTexSubImage2D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglTexSubImage1D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage2D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglBindTexture = PROCEDURE{C}(target: GLenum; texture: GLuint);
  TglDeleteTextures = PROCEDURE{C}(n: GLsizei;  textures: PGLuint);
  TglGenTextures = PROCEDURE{C}(n: GLsizei; textures: PGLuint);

(*! ifdef DEPRECATED *)
  TglAccum = PROCEDURE{C}(op: GLenum; value: GLfloat);
  TglAlphaFunc = PROCEDURE{C}(func: GLenum; ref: GLclampf);
  TglAreTexturesResident =  PROCEDURE{C}(n: GLsizei;  textures: PGLuint; residences: PGLboolean): GLboolean;
  TglArrayElement = PROCEDURE{C}(i: GLint);
  TglBegin = PROCEDURE{C}(mode: GLenum);
  TglBitmap = PROCEDURE{C}(width: GLsizei; height: GLsizei; xorig: GLfloat; yorig: GLfloat; xmove: GLfloat; ymove: GLfloat;  bitmap: PGLubyte);
  TglCallList = PROCEDURE{C}(list: GLuint);
  TglCallLists = PROCEDURE{C}(n: GLsizei; xtype: GLenum;  lists: PGLvoid);
  TglClearAccum = PROCEDURE{C}(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);
  TglClearIndex = PROCEDURE{C}(c: GLfloat);
  TglClipPlane = PROCEDURE{C}(plane: GLenum;  equation: PGLdouble);
  TglColor3b = PROCEDURE{C}(red: GLbyte; green: GLbyte; blue: GLbyte);
  TglColor3bv = PROCEDURE{C}( v: PGLbyte);
  TglColor3d = PROCEDURE{C}(red: GLdouble; green: GLdouble; blue: GLdouble);
  TglColor3dv = PROCEDURE{C}( v: PGLdouble);
  TglColor3f = PROCEDURE{C}(red: GLfloat; green: GLfloat; blue: GLfloat);
  TglColor3fv = PROCEDURE{C}( v: PGLfloat);
  TglColor3i = PROCEDURE{C}(red: GLint; green: GLint; blue: GLint);
  TglColor3iv = PROCEDURE{C}( v: PGLint);
  TglColor3s = PROCEDURE{C}(red: GLshort; green: GLshort; blue: GLshort);
  TglColor3sv = PROCEDURE{C}( v: PGLshort);
  TglColor3ub = PROCEDURE{C}(red: GLubyte; green: GLubyte; blue: GLubyte);
  TglColor3ubv = PROCEDURE{C}( v: PGLubyte);
  TglColor3ui = PROCEDURE{C}(red: GLuint; green: GLuint; blue: GLuint);
  TglColor3uiv = PROCEDURE{C}( v: PGLuint);
  TglColor3us = PROCEDURE{C}(red: GLushort; green: GLushort; blue: GLushort);
  TglColor3usv = PROCEDURE{C}( v: PGLushort);
  TglColor4b = PROCEDURE{C}(red: GLbyte; green: GLbyte; blue: GLbyte; alpha: GLbyte);
  TglColor4bv = PROCEDURE{C}( v: PGLbyte);
  TglColor4d = PROCEDURE{C}(red: GLdouble; green: GLdouble; blue: GLdouble; alpha: GLdouble);
  TglColor4dv = PROCEDURE{C}( v: PGLdouble);
  TglColor4f = PROCEDURE{C}(red: GLfloat; green: GLfloat; blue: GLfloat; alpha: GLfloat);
  TglColor4fv = PROCEDURE{C}( v: PGLfloat);
  TglColor4i = PROCEDURE{C}(red: GLint; green: GLint; blue: GLint; alpha: GLint);
  TglColor4iv = PROCEDURE{C}( v: PGLint);
  TglColor4s = PROCEDURE{C}(red: GLshort; green: GLshort; blue: GLshort; alpha: GLshort);
  TglColor4sv = PROCEDURE{C}( v: PGLshort);
  TglColor4ub = PROCEDURE{C}(red: GLubyte; green: GLubyte; blue: GLubyte; alpha: GLubyte);
  TglColor4ubv = PROCEDURE{C}( v: PGLubyte);
  TglColor4ui = PROCEDURE{C}(red: GLuint; green: GLuint; blue: GLuint; alpha: GLuint);
  TglColor4uiv = PROCEDURE{C}( v: PGLuint);
  TglColor4us = PROCEDURE{C}(red: GLushort; green: GLushort; blue: GLushort; alpha: GLushort);
  TglColor4usv = PROCEDURE{C}( v: PGLushort);
  TglColorMaterial = PROCEDURE{C}(face: GLenum; mode: GLenum);
  TglColorPointer = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglCopyPixels = PROCEDURE{C}(x: GLint; y: GLint; width: GLsizei; height: GLsizei; xtype: GLenum);
  TglDeleteLists = PROCEDURE{C}(list: GLuint; range: GLsizei);
  TglDisableClientState = PROCEDURE{C}(xarray: GLenum);
  TglDrawPixels = PROCEDURE{C}(width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglEdgeFlag = PROCEDURE{C}(flag: GLboolean);
  TglEdgeFlagPointer = PROCEDURE{C}(stride: GLsizei; xpointer: PGLvoid);
  TglEdgeFlagv = PROCEDURE{C}( flag: PGLboolean);
  TglEnableClientState = PROCEDURE{C}(xarray: GLenum);
  TglEnd = PROCEDURE{C}();
  TglEndList = PROCEDURE{C}();
  TglEvalCoord1d = PROCEDURE{C}(u: GLdouble);
  TglEvalCoord1dv = PROCEDURE{C}( u: PGLdouble);
  TglEvalCoord1f = PROCEDURE{C}(u: GLfloat);
  TglEvalCoord1fv = PROCEDURE{C}( u: PGLfloat);
  TglEvalCoord2d = PROCEDURE{C}(u: GLdouble; v: GLdouble);
  TglEvalCoord2dv = PROCEDURE{C}( u: PGLdouble);
  TglEvalCoord2f = PROCEDURE{C}(u: GLfloat; v: GLfloat);
  TglEvalCoord2fv = PROCEDURE{C}( u: PGLfloat);
  TglEvalMesh1 = PROCEDURE{C}(mode: GLenum; i1: GLint; i2: GLint);
  TglEvalMesh2 = PROCEDURE{C}(mode: GLenum; i1: GLint; i2: GLint; j1: GLint; j2: GLint);
  TglEvalPoint1 = PROCEDURE{C}(i: GLint);
  TglEvalPoint2 = PROCEDURE{C}(i: GLint; j: GLint);
  TglFeedbackBuffer = PROCEDURE{C}(size: GLsizei; xtype: GLenum; buffer: PGLfloat);
  TglFogf = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglFogfv = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);
  TglFogi = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglFogiv = PROCEDURE{C}(pname: GLenum;  params: PGLint);
  TglFrustum = PROCEDURE{C}(left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglGenLists =  PROCEDURE{C}(range: GLsizei): GLuint;
  TglGetClipPlane = PROCEDURE{C}(plane: GLenum; equation: PGLdouble);
  TglGetLightfv = PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLfloat);
  TglGetLightiv = PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLint);
  TglGetMapdv = PROCEDURE{C}(target: GLenum; query: GLenum; v: PGLdouble);
  TglGetMapfv = PROCEDURE{C}(target: GLenum; query: GLenum; v: PGLfloat);
  TglGetMapiv = PROCEDURE{C}(target: GLenum; query: GLenum; v: PGLint);
  TglGetMaterialfv = PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMaterialiv = PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLint);
  TglGetPixelMapfv = PROCEDURE{C}(map: GLenum; values: PGLfloat);
  TglGetPixelMapuiv = PROCEDURE{C}(map: GLenum; values: PGLuint);
  TglGetPixelMapusv = PROCEDURE{C}(map: GLenum; values: PGLushort);
  TglGetPolygonStipple = PROCEDURE{C}(mask: PGLubyte);
  TglGetTexEnvfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexEnviv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexGendv = PROCEDURE{C}(coord: GLenum; pname: GLenum; params: PGLdouble);
  TglGetTexGenfv = PROCEDURE{C}(coord: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTexGeniv = PROCEDURE{C}(coord: GLenum; pname: GLenum; params: PGLint);
  TglIndexMask = PROCEDURE{C}(mask: GLuint);
  TglIndexPointer = PROCEDURE{C}(xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglIndexd = PROCEDURE{C}(c: GLdouble);
  TglIndexdv = PROCEDURE{C}( c: PGLdouble);
  TglIndexf = PROCEDURE{C}(c: GLfloat);
  TglIndexfv = PROCEDURE{C}( c: PGLfloat);
  TglIndexi = PROCEDURE{C}(c: GLint);
  TglIndexiv = PROCEDURE{C}( c: PGLint);
  TglIndexs = PROCEDURE{C}(c: GLshort);
  TglIndexsv = PROCEDURE{C}( c: PGLshort);
  TglIndexub = PROCEDURE{C}(c: GLubyte);
  TglIndexubv = PROCEDURE{C}( c: PGLubyte);
  TglInitNames = PROCEDURE{C}();
  TglInterleavedArrays = PROCEDURE{C}(format: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglIsList =  PROCEDURE{C}(list: GLuint): BOOLEAN;
  TglIsTexture =  PROCEDURE{C}(texture: GLuint): BOOLEAN;
  TglLightModelf = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglLightModelfv = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);
  TglLightModeli = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglLightModeliv = PROCEDURE{C}(pname: GLenum;  params: PGLint);
  TglLightf = PROCEDURE{C}(light: GLenum; pname: GLenum; param: GLfloat);
  TglLightfv = PROCEDURE{C}(light: GLenum; pname: GLenum;   params: PGLfloat);
  TglLighti = PROCEDURE{C}(light: GLenum; pname: GLenum; param: GLint);
  TglLightiv = PROCEDURE{C}(light: GLenum; pname: GLenum;  params: PGLint);
  TglLineStipple = PROCEDURE{C}(factor: GLint; pattern: GLushort);
  TglListBase = PROCEDURE{C}(base: GLuint);
  TglLoadIdentity = PROCEDURE{C}();
  TglLoadMatrixd = PROCEDURE{C}( m: PGLdouble);
  TglLoadMatrixf = PROCEDURE{C}( m: PGLfloat);
  TglLoadName = PROCEDURE{C}(name: GLuint);
  TglMap1d = PROCEDURE{C}(target: GLenum; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint;  points: PGLdouble);
  TglMap1f = PROCEDURE{C}(target: GLenum; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint;  points: PGLfloat);
  TglMap2d = PROCEDURE{C}(target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint;  points: PGLdouble);
  TglMap2f = PROCEDURE{C}(target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; points: PGLfloat);
  TglMapGrid1d = PROCEDURE{C}(un: GLint; u1: GLdouble; u2: GLdouble);
  TglMapGrid1f = PROCEDURE{C}(un: GLint; u1: GLfloat; u2: GLfloat);
  TglMapGrid2d = PROCEDURE{C}(un: GLint; u1: GLdouble; u2: GLdouble; vn: GLint; v1: GLdouble; v2: GLdouble);
  TglMapGrid2f = PROCEDURE{C}(un: GLint; u1: GLfloat; u2: GLfloat; vn: GLint; v1: GLfloat; v2: GLfloat);
  TglMaterialf = PROCEDURE{C}(face: GLenum; pname: GLenum; param: GLfloat);
  TglMaterialfv = PROCEDURE{C}(face: GLenum; pname: GLenum;  params:  ADDRESS (*PGLfloat*));
  TglMateriali = PROCEDURE{C}(face: GLenum; pname: GLenum; param: GLint);
  TglMaterialiv = PROCEDURE{C}(face: GLenum; pname: GLenum;  params: PGLint);
  TglMatrixMode = PROCEDURE{C}(mode: GLenum);
  TglMultMatrixd = PROCEDURE{C}( m: PGLdouble);
  TglMultMatrixf = PROCEDURE{C}( m: PGLfloat);
  TglNewList = PROCEDURE{C}(list: GLuint; mode: GLenum);
  TglNormal3b = PROCEDURE{C}(nx: GLbyte; ny: GLbyte; nz: GLbyte);
  TglNormal3bv = PROCEDURE{C}( v: PGLbyte);
  TglNormal3d = PROCEDURE{C}(nx: GLdouble; ny: GLdouble; nz: GLdouble);
  TglNormal3dv = PROCEDURE{C}( v: PGLdouble);
  TglNormal3f = PROCEDURE{C}(nx: GLfloat; ny: GLfloat; nz: GLfloat);
  TglNormal3fv = PROCEDURE{C}( v: PGLfloat);
  TglNormal3i = PROCEDURE{C}(nx: GLint; ny: GLint; nz: GLint);
  TglNormal3iv = PROCEDURE{C}( v: PGLint);
  TglNormal3s = PROCEDURE{C}(nx: GLshort; ny: GLshort; nz: GLshort);
  TglNormal3sv = PROCEDURE{C}( v: PGLshort);
  TglNormalPointer = PROCEDURE{C}(xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglOrtho = PROCEDURE{C}(left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglPassThrough = PROCEDURE{C}(token: GLfloat);
  TglPixelMapfv = PROCEDURE{C}(map: GLenum; mapsize: GLsizei;  values: PGLfloat);
  TglPixelMapuiv = PROCEDURE{C}(map: GLenum; mapsize: GLsizei;  values: PGLuint);
  TglPixelMapusv = PROCEDURE{C}(map: GLenum; mapsize: GLsizei;  values: PGLushort);
  TglPixelTransferf = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPixelTransferi = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglPixelZoom = PROCEDURE{C}(xfactor: GLfloat; yfactor: GLfloat);
  TglPolygonStipple = PROCEDURE{C}( mask: PGLubyte);
  TglPopAttrib = PROCEDURE{C}();
  TglPopClientAttrib = PROCEDURE{C}();
  TglPopMatrix = PROCEDURE{C}();
  TglPopName = PROCEDURE{C}();
  TglPrioritizeTextures = PROCEDURE{C}(n: GLsizei;  textures: PGLuint;  priorities: PGLclampf);
  TglPushAttrib = PROCEDURE{C}(mask: GLbitfield);
  TglPushClientAttrib = PROCEDURE{C}(mask: GLbitfield);
  TglPushMatrix = PROCEDURE{C}();
  TglPushName = PROCEDURE{C}(name: GLuint);
  TglRasterPos2d = PROCEDURE{C}(x: GLdouble; y: GLdouble);
  TglRasterPos2dv = PROCEDURE{C}( v: PGLdouble);
  TglRasterPos2f = PROCEDURE{C}(x: GLfloat; y: GLfloat);
  TglRasterPos2fv = PROCEDURE{C}( v: PGLfloat);
  TglRasterPos2i = PROCEDURE{C}(x: GLint; y: GLint);
  TglRasterPos2iv = PROCEDURE{C}( v: PGLint);
  TglRasterPos2s = PROCEDURE{C}(x: GLshort; y: GLshort);
  TglRasterPos2sv = PROCEDURE{C}( v: PGLshort);
  TglRasterPos3d = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglRasterPos3dv = PROCEDURE{C}( v: PGLdouble);
  TglRasterPos3f = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglRasterPos3fv = PROCEDURE{C}( v: PGLfloat);
  TglRasterPos3i = PROCEDURE{C}(x: GLint; y: GLint; z: GLint);
  TglRasterPos3iv = PROCEDURE{C}( v: PGLint);
  TglRasterPos3s = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort);
  TglRasterPos3sv = PROCEDURE{C}( v: PGLshort);
  TglRasterPos4d = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglRasterPos4dv = PROCEDURE{C}( v: PGLdouble);
  TglRasterPos4f = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglRasterPos4fv = PROCEDURE{C}( v: PGLfloat);
  TglRasterPos4i = PROCEDURE{C}(x: GLint; y: GLint; z: GLint; w: GLint);
  TglRasterPos4iv = PROCEDURE{C}( v: PGLint);
  TglRasterPos4s = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglRasterPos4sv = PROCEDURE{C}( v: PGLshort);
  TglRectd = PROCEDURE{C}(x1: GLdouble; y1: GLdouble; x2: GLdouble; y2: GLdouble);
  TglRectdv = PROCEDURE{C}( v1: PGLdouble;  v2: PGLdouble);
  TglRectf = PROCEDURE{C}(x1: GLfloat; y1: GLfloat; x2: GLfloat; y2: GLfloat);
  TglRectfv = PROCEDURE{C}( v1: PGLfloat;  v2: PGLfloat);
  TglRecti = PROCEDURE{C}(x1: GLint; y1: GLint; x2: GLint; y2: GLint);
  TglRectiv = PROCEDURE{C}( v1: PGLint;  v2: PGLint);
  TglRects = PROCEDURE{C}(x1: GLshort; y1: GLshort; x2: GLshort; y2: GLshort);
  TglRectsv = PROCEDURE{C}( v1: PGLshort;  v2: PGLshort);
  TglRenderMode =  PROCEDURE{C}(mode: GLenum): GLint;
  TglRotated = PROCEDURE{C}(anTgle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);
  TglRotatef = PROCEDURE{C}( angle, x, y, z: GLfloat);
  TglScaled = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglScalef = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglSelectBuffer = PROCEDURE{C}(size: GLsizei; buffer: PGLuint);
  TglShadeModel = PROCEDURE{C}(mode: GLenum);
  TglTexCoord1d = PROCEDURE{C}(s: GLdouble);
  TglTexCoord1dv = PROCEDURE{C}( v: PGLdouble);
  TglTexCoord1f = PROCEDURE{C}(s: GLfloat);
  TglTexCoord1fv = PROCEDURE{C}( v: PGLfloat);
  TglTexCoord1i = PROCEDURE{C}(s: GLint);
  TglTexCoord1iv = PROCEDURE{C}( v: PGLint);
  TglTexCoord1s = PROCEDURE{C}(s: GLshort);
  TglTexCoord1sv = PROCEDURE{C}( v: PGLshort);
  TglTexCoord2d = PROCEDURE{C}(s: GLdouble; t: GLdouble);
  TglTexCoord2dv = PROCEDURE{C}( v: PGLdouble);
  TglTexCoord2f = PROCEDURE{C}(s: GLfloat; t: GLfloat);
  TglTexCoord2fv = PROCEDURE{C}( v: PGLfloat);
  TglTexCoord2i = PROCEDURE{C}(s: GLint; t: GLint);
  TglTexCoord2iv = PROCEDURE{C}( v: PGLint);
  TglTexCoord2s = PROCEDURE{C}(s: GLshort; t: GLshort);
  TglTexCoord2sv = PROCEDURE{C}( v: PGLshort);
  TglTexCoord3d = PROCEDURE{C}(s: GLdouble; t: GLdouble; r: GLdouble);
  TglTexCoord3dv = PROCEDURE{C}( v: PGLdouble);
  TglTexCoord3f = PROCEDURE{C}(s: GLfloat; t: GLfloat; r: GLfloat);
  TglTexCoord3fv = PROCEDURE{C}( v: PGLfloat);
  TglTexCoord3i = PROCEDURE{C}(s: GLint; t: GLint; r: GLint);
  TglTexCoord3iv = PROCEDURE{C}( v: PGLint);
  TglTexCoord3s = PROCEDURE{C}(s: GLshort; t: GLshort; r: GLshort);
  TglTexCoord3sv = PROCEDURE{C}( v: PGLshort);
  TglTexCoord4d = PROCEDURE{C}(s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglTexCoord4dv = PROCEDURE{C}( v: PGLdouble);
  TglTexCoord4f = PROCEDURE{C}(s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglTexCoord4fv = PROCEDURE{C}( v: PGLfloat);
  TglTexCoord4i = PROCEDURE{C}(s: GLint; t: GLint; r: GLint; q: GLint);
  TglTexCoord4iv = PROCEDURE{C}( v: PGLint);
  TglTexCoord4s = PROCEDURE{C}(s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglTexCoord4sv = PROCEDURE{C}( v: PGLshort);
  TglTexCoordPointer = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglTexEnvf = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLfloat);
  TglTexEnvfv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexEnvi = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLint);
  TglTexEnviv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglTexGend = PROCEDURE{C}(coord: GLenum; pname: GLenum; param: GLdouble);
  TglTexGendv = PROCEDURE{C}(coord: GLenum; pname: GLenum;  params: PGLdouble);
  TglTexGenf = PROCEDURE{C}(coord: GLenum; pname: GLenum; param: GLfloat);
  TglTexGenfv = PROCEDURE{C}(coord: GLenum; pname: GLenum;  params: PGLfloat);
  TglTexGeni = PROCEDURE{C}(coord: GLenum; pname: GLenum; param: GLint);
  TglTexGeniv = PROCEDURE{C}(coord: GLenum; pname: GLenum;  params: PGLint);


  TglTranslated = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglTranslatef = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertex2d = PROCEDURE{C}(x: GLdouble; y: GLdouble);
  TglVertex2dv = PROCEDURE{C}( v: PGLdouble);
  TglVertex2f = PROCEDURE{C}(x: GLfloat; y: GLfloat);
  TglVertex2fv = PROCEDURE{C}( v: PGLfloat);
  TglVertex2i = PROCEDURE{C}(x: GLint; y: GLint);
  TglVertex2iv = PROCEDURE{C}( v: PGLint);
  TglVertex2s = PROCEDURE{C}(x: GLshort; y: GLshort);
  TglVertex2sv = PROCEDURE{C}( v: PGLshort);
  TglVertex3d = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertex3dv = PROCEDURE{C}( v: PGLdouble);
  TglVertex3f = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertex3fv = PROCEDURE{C}( v: PGLfloat);
  TglVertex3i = PROCEDURE{C}(x: GLint; y: GLint; z: GLint);
  TglVertex3iv = PROCEDURE{C}( v: PGLint);
  TglVertex3s = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort);
  TglVertex3sv = PROCEDURE{C}( v: PGLshort);
  TglVertex4d = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertex4dv = PROCEDURE{C}( v: PGLdouble);
  TglVertex4f = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertex4fv = PROCEDURE{C}( v: PGLfloat);
  TglVertex4i = PROCEDURE{C}(x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertex4iv = PROCEDURE{C}( v: PGLint);
  TglVertex4s = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertex4sv = PROCEDURE{C}( v: PGLshort);
  TglVertexPointer = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
(*! endif *)

  (*! GL_VERSION_1_2 *)
  TglBlendColor* = PROCEDURE{C}(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);
  TglBlendEquation = PROCEDURE{C}(mode: GLenum);
  TglDrawRangeElements = PROCEDURE{C}(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; xtype: GLenum;  indices: PGLvoid);
  TglTexImage3D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage3D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglCopyTexSubImage3D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);

 (*! ifdef DEPRECATED 1.2 *)
  TglColorTable = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  table: PGLvoid);
  TglColorTableParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglColorTableParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyColorTable = PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglGetColorTable = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; table: PGLvoid);
  TglGetColorTableParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetColorTableParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglColorSubTable = PROCEDURE{C}(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; xtype: GLenum;  data: PGLvoid);
  TglCopyColorSubTable = PROCEDURE{C}(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);
  TglConvolutionFilter1D = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionFilter2D = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionParameterf = PROCEDURE{C}(target: GLenum; pname: GLenum; params: GLfloat);
  TglConvolutionParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglConvolutionParameteri = PROCEDURE{C}(target: GLenum; pname: GLenum; params: GLint);
  TglConvolutionParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyConvolutionFilter1D = PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglCopyConvolutionFilter2D = PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetConvolutionFilter = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglGetConvolutionParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetConvolutionParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetSeparableFilter = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);
  TglSeparableFilter2D = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  row: PGLvoid;  column: PGLvoid);
  TglGetHistogram = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetHistogramParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetHistogramParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetMinmax = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetMinmaxParameterfv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMinmaxParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglHistogram = PROCEDURE{C}(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);
  TglMinmax = PROCEDURE{C}(target: GLenum; internalformat: GLenum; sink: GLboolean);
  TglResetHistogram = PROCEDURE{C}(target: GLenum);
  TglResetMinmax = PROCEDURE{C}(target: GLenum);
(*! endif *)

  (*! GL_VERSION_1_3 *)
  TglActiveTexture = PROCEDURE{C}(texture: GLenum);
  TglSampleCoverage = PROCEDURE{C}(value: GLclampf; invert: GLboolean);
  TglCompressedTexImage3D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage2D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage1D = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage3D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage2D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage1D = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglGetCompressedTexImage = PROCEDURE{C}(target: GLenum; level: GLint; img: PGLvoid);

(*! ifdef DEPRECATED 1.3 *)
  TglClientActiveTexture = PROCEDURE{C}(texture: GLenum);
  TglMultiTexCoord1d = PROCEDURE{C}(target: GLenum; s: GLdouble);
  TglMultiTexCoord1dv = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord1f = PROCEDURE{C}(target: GLenum; s: GLfloat);
  TglMultiTexCoord1fv = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord1i = PROCEDURE{C}(target: GLenum; s: GLint);
  TglMultiTexCoord1iv = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord1s = PROCEDURE{C}(target: GLenum; s: GLshort);
  TglMultiTexCoord1sv = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord2d = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble);
  TglMultiTexCoord2dv = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord2f = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat);
  TglMultiTexCoord2fv = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord2i = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint);
  TglMultiTexCoord2iv = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord2s = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort);
  TglMultiTexCoord2sv = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord3d = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);
  TglMultiTexCoord3dv = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord3f = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);
  TglMultiTexCoord3fv = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord3i = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint; r: GLint);
  TglMultiTexCoord3iv = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord3s = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort; r: GLshort);
  TglMultiTexCoord3sv = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord4d = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglMultiTexCoord4dv = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord4f = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglMultiTexCoord4fv = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord4i = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);
  TglMultiTexCoord4iv = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord4s = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglMultiTexCoord4sv = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglLoadTransposeMatrixf = PROCEDURE{C}( m: PGLfloat);
  TglLoadTransposeMatrixd = PROCEDURE{C}( m: PGLdouble);
  TglMultTransposeMatrixf = PROCEDURE{C}( m: PGLfloat);
  TglMultTransposeMatrixd = PROCEDURE{C}( m: PGLdouble);
(*! endif *)


  (*! GL_VERSION_1_4 *)
  TglBlendFuncSeparate = PROCEDURE{C}(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);
  TglMultiDrawArrays = PROCEDURE{C}(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  TglMultiDrawElements = PROCEDURE{C}(mode: GLenum;  count: PGLsizei; xtype: GLenum;  indices: PGLvoid; primcount: GLsizei);
  TglPointParameterf = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPointParameterfv = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);
  TglPointParameteri = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglPointParameteriv = PROCEDURE{C}(pname: GLenum;  params: PGLint);

  (*! ifdef DEPRECATED 1.4 *)
  TglFogCoordf = PROCEDURE{C}(coord: GLfloat);
  TglFogCoordfv = PROCEDURE{C}( coord: PGLfloat);
  TglFogCoordd = PROCEDURE{C}(coord: GLdouble);
  TglFogCoorddv = PROCEDURE{C}( coord: PGLdouble);
  TglFogCoordPointer = PROCEDURE{C}(xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglSecondaryColor3b = PROCEDURE{C}(red: GLbyte; green: GLbyte; blue: GLbyte);
  TglSecondaryColor3bv = PROCEDURE{C}( v: PGLbyte);
  TglSecondaryColor3d = PROCEDURE{C}(red: GLdouble; green: GLdouble; blue: GLdouble);
  TglSecondaryColor3dv = PROCEDURE{C}( v: PGLdouble);
  TglSecondaryColor3f = PROCEDURE{C}(red: GLfloat; green: GLfloat; blue: GLfloat);
  TglSecondaryColor3fv = PROCEDURE{C}( v: PGLfloat);
  TglSecondaryColor3i = PROCEDURE{C}(red: GLint; green: GLint; blue: GLint);
  TglSecondaryColor3iv = PROCEDURE{C}( v: PGLint);
  TglSecondaryColor3s = PROCEDURE{C}(red: GLshort; green: GLshort; blue: GLshort);
  TglSecondaryColor3sv = PROCEDURE{C}( v: PGLshort);
  TglSecondaryColor3ub = PROCEDURE{C}(red: GLubyte; green: GLubyte; blue: GLubyte);
  TglSecondaryColor3ubv = PROCEDURE{C}( v: PGLubyte);
  TglSecondaryColor3ui = PROCEDURE{C}(red: GLuint; green: GLuint; blue: GLuint);
  TglSecondaryColor3uiv = PROCEDURE{C}( v: PGLuint);
  TglSecondaryColor3us = PROCEDURE{C}(red: GLushort; green: GLushort; blue: GLushort);
  TglSecondaryColor3usv = PROCEDURE{C}( v: PGLushort);
  TglSecondaryColorPointer = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglWindowPos2d = PROCEDURE{C}(x: GLdouble; y: GLdouble);
  TglWindowPos2dv = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos2f = PROCEDURE{C}(x: GLfloat; y: GLfloat);
  TglWindowPos2fv = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos2i = PROCEDURE{C}(x: GLint; y: GLint);
  TglWindowPos2iv = PROCEDURE{C}( v: PGLint);
  TglWindowPos2s = PROCEDURE{C}(x: GLshort; y: GLshort);
  TglWindowPos2sv = PROCEDURE{C}( v: PGLshort);
  TglWindowPos3d = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dv = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos3f = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fv = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos3i = PROCEDURE{C}(x: GLint; y: GLint; z: GLint);
  TglWindowPos3iv = PROCEDURE{C}( v: PGLint);
  TglWindowPos3s = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3sv = PROCEDURE{C}( v: PGLshort);
(*! endif *)

  (*! GL_VERSION_1_5 *)
  TglGenQueries = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglDeleteQueries = PROCEDURE{C}(n: GLsizei;  ids: PGLuint);
  TglIsQuery = PROCEDURE{C}(id: GLuint): BOOLEAN;
  TglBeginQuery = PROCEDURE{C}(target: GLenum; id: GLuint);
  TglEndQuery = PROCEDURE{C}(target: GLenum);
  TglGetQueryiv = PROCEDURE{C}(target, pname: GLenum; params: PGLint);
  TglGetQueryObjectiv = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint);
  TglGetQueryObjectuiv = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLuint);
  TglBindBuffer = PROCEDURE{C}(target: GLenum; buffer: GLuint);
  TglDeleteBuffers = PROCEDURE{C}(n: GLsizei;  buffers: PGLuint );
  TglGenBuffers = PROCEDURE{C}(n: GLsizei;  buffers: PGLuint);
  TglIsBuffer = PROCEDURE{C}(buffer: GLuint): GLboolean;
  TglBufferData = PROCEDURE{C}(target: GLenum; size: GLsizei;  data: ADDRESS; usage: GLenum);
  TglBufferSubData = PROCEDURE{C}(target: GLenum; offset: GLsizei; size: GLsizei;  data: PGLvoid);
  TglGetBufferSubData = PROCEDURE{C}(target: GLenum; offset: GLsizei; size: GLsizei; data: PGLvoid);
  TglMapBuffer = PROCEDURE{C}(target: GLenum; access: GLenum): PGLvoid;
  TglUnmapBuffer = PROCEDURE{C}(target: GLenum): GLboolean;
  TglGetBufferParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetBufferPointerv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLvoid);

  (*! GL_VERSION_2_0 *)
  TglBlendEquationSeparate = PROCEDURE{C}(modeRGB: GLenum; modeAlpha: GLenum);
  TglDrawBuffers = PROCEDURE{C}(n: GLsizei;  bufs: PGLenum);
  TglStencilOpSeparate = PROCEDURE{C}(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum);
  TglStencilFuncSeparate = PROCEDURE{C}(frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint);
  TglStencilMaskSeparate = PROCEDURE{C}(face: GLenum; mask: GLuint);
  TglAttachShader = PROCEDURE{C}(programObj, shaderObj: GLHandle);
  TglBindAttribLocation = PROCEDURE{C}(programObj: GLHandle; index: GLuint; name: PGLchar);
  TglCompileShader = PROCEDURE{C}(shaderObj: GLHandle);
  TglCreateProgram = PROCEDURE{C}(): GLHandle;
  TglCreateShader = PROCEDURE{C}(shaderType: GLenum): GLHandle;
  TglDeleteProgram = PROCEDURE{C}(programObj: GLHandle);
  TglDeleteShader = PROCEDURE{C}(shaderObj: GLHandle);
  TglDetachShader = PROCEDURE{C}(programObj, shaderObj: GLHandle);
  TglDisableVertexAttribArray = PROCEDURE{C}(index: GLuint);
  TglEnableVertexAttribArray = PROCEDURE{C}(index: GLuint);
  TglGetActiveAttrib = PROCEDURE{C}(programObj: GLHandle; index: GLuint; maxlength: GLsizei; VAR length: GLint; VAR size: GLint; VAR xtype: GLenum; name: PGLchar);
  TglGetActiveUniform = PROCEDURE{C}(programObj: GLHandle; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLchar);
  TglGetAttachedShaders = PROCEDURE{C}(programObj: GLHandle; MaxCount: GLsizei; VAR Count: GLint; shaders: PGLuint);
  TglGetAttribLocation = PROCEDURE{C}(programObj: GLHandle; CONST chars: ARRAY OF CHAR): GLint;
  TglGetProgramiv = PROCEDURE{C}(programObj: GLHandle; pname: GLenum; params: PGLint);
  TglGetProgramInfoLog = PROCEDURE{C}(programObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar);
  TglGetShaderiv = PROCEDURE{C}(shaderObj: GLHandle; pname: GLenum; params: PGLint);
  TglGetShaderInfoLog = PROCEDURE{C}(shaderObj: GLHandle; maxLength: GLsizei; VAR length: GLint; infoLog: PGLchar);
  TglGetShaderSource = PROCEDURE{C}(shaderObj: GLHandle; maxlength: GLsizei; VAR length: GLsizei; source: PGLchar);
  TglGetUniformLocation = PROCEDURE{C}(programObj: GLHandle; CONST char: ARRAY OF CHAR): GLint;
  TglGetUniformfv = PROCEDURE{C}(programObj: GLHandle; location: GLint; params: PGLfloat);
  TglGetUniformiv = PROCEDURE{C}(programObj: GLHandle; location: GLint; params: PGLint);
  TglGetVertexAttribfv = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribiv = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointerv = PROCEDURE{C}(index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgram = PROCEDURE{C}(programObj: GLHandle) : GLboolean;
  TglIsShader = PROCEDURE{C}(shaderObj: GLHandle) : GLboolean;
  TglLinkProgram = PROCEDURE{C}(programObj: GLHandle);
  TglShaderSource = PROCEDURE{C}(shaderObj: GLHandle; count: GLsizei; xstring: PGLchar; lengths: PGLint);
  TglUseProgram = PROCEDURE{C}(programObj: GLHandle);
  TglUniform1f = PROCEDURE{C}(location: GLint; v0: GLfloat);
  TglUniform2f = PROCEDURE{C}(location: GLint; v0, v1: GLfloat);
  TglUniform3f = PROCEDURE{C}(location: GLint; v0, v1, v2: GLfloat);
  TglUniform4f = PROCEDURE{C}(location: GLint; v0, v1, v2, v3: GLfloat);
  TglUniform1i = PROCEDURE{C}(location: GLint; v0: GLint);
  TglUniform2i = PROCEDURE{C}(location: GLint; v0, v1: GLint);
  TglUniform3i = PROCEDURE{C}(location: GLint; v0, v1, v2: GLint);
  TglUniform4i = PROCEDURE{C}(location: GLint; v0, v1, v2, v3: GLint);
  TglUniform1fv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform2fv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform3fv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform4fv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform1iv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform2iv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform3iv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform4iv = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniformMatrix2fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglValidateProgram = PROCEDURE{C}(programObj: GLHandle);
  TglVertexAttrib1d = PROCEDURE{C}(index: GLuint; x: GLdouble);
  TglVertexAttrib1dv = PROCEDURE{C}(index: GLuint;   v: PGLdouble);
  TglVertexAttrib1f = PROCEDURE{C}(index: GLuint; x: GLfloat);
  TglVertexAttrib1fv = PROCEDURE{C}(index: GLuint;   v: PGLfloat);
  TglVertexAttrib1s = PROCEDURE{C}(index: GLuint; x: GLshort);
  TglVertexAttrib1sv = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib2d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib2f = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fv = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib2s = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2sv = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib3d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib3f = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fv = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib3s = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3sv = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4Nbv = PROCEDURE{C}(index: GLuint;  v: PGLbyte);
  TglVertexAttrib4Niv = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttrib4Nsv = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4Nub = PROCEDURE{C}(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4Nubv = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttrib4Nuiv = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttrib4Nusv = PROCEDURE{C}(index: GLuint;  v: PGLushort);
  TglVertexAttrib4bv = PROCEDURE{C}(index: GLuint;  v: PGLbyte);
  TglVertexAttrib4d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib4f = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fv = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib4iv = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttrib4s = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4sv = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubv = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttrib4uiv = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttrib4usv = PROCEDURE{C}(index: GLuint;  v: PGLushort);
  TglVertexAttribPointer = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei;  xpointer: PGLvoid);

  (*! GL_VERSION_2_1 *)
  TglUniformMatrix2x3fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3x2fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix2x4fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4x2fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3x4fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4x3fv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);

  (*! GL_VERSION_3_0 *)
  (* OpenGL 3.0 also reuses entry points from these extensions:
   ARB_framebuffer_object
   ARB_map_buffer_range
   ARB_vertex_array_object  *)
  TglColorMaski = PROCEDURE{C}(index_: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean);
  TglGetBooleani_v = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PGLboolean);
  TglGetIntegeri_v = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PGLint);
  TglEnablei = PROCEDURE{C}(target: GLenum; index_: GLuint);
  TglDisablei = PROCEDURE{C}(target: GLenum; index_: GLuint);
  TglIsEnabledi = PROCEDURE{C}(target: GLenum; index_: GLuint): GLboolean;
  TglBeginTransformFeedback = PROCEDURE{C}(primitiveMode: GLenum);
  TglEndTransformFeedback = PROCEDURE{C}();
  TglBindBufferRange = PROCEDURE{C}(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei);
  TglBindBufferBase = PROCEDURE{C}(target: GLenum; index_: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryings = PROCEDURE{C}(xprogram: GLuint; count: GLsizei;  varyings: PPGLchar; bufferMode: GLenum);
  TglGetTransformFeedbackVarying = PROCEDURE{C}(xprogram: GLuint; index_: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; type_: PGLsizei; name: PGLchar);
  TglClampColor = PROCEDURE{C}(targe: GLenum; clamp: GLenum);
  TglBeginConditionalRender = PROCEDURE{C}(id: GLuint; mode: GLenum);
  TglEndConditionalRender = PROCEDURE{C}();
  TglVertexAttribIPointer = PROCEDURE{C}(index_: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribIiv = PROCEDURE{C}(index_: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribIuiv = PROCEDURE{C}(index_: GLuint; pname: GLenum; params: PGLuint);
  TglVertexAttribI1i = PROCEDURE{C}(index_: GLuint; x: GLint);
  TglVertexAttribI2i = PROCEDURE{C}(index_: GLuint; x: GLint; y: GLint);
  TglVertexAttribI3i = PROCEDURE{C}(index_: GLuint; x: GLint; y: GLint; z: GLint);
  TglVertexAttribI4i = PROCEDURE{C}(index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexAttribI1ui = PROCEDURE{C}(index_: GLuint; x: GLuint);
  TglVertexAttribI2ui = PROCEDURE{C}(index_: GLuint; x: GLuint; y: GLuint);
  TglVertexAttribI3ui = PROCEDURE{C}(index_: GLuint; x: GLuint; y: GLuint; z: GLuint);
  TglVertexAttribI4ui = PROCEDURE{C}(index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglVertexAttribI1iv = PROCEDURE{C}(index_: GLuint;  v: PGLint);
  TglVertexAttribI2iv = PROCEDURE{C}(index_: GLuint;  v: PGLint);
  TglVertexAttribI3iv = PROCEDURE{C}(index_: GLuint;  v: PGLint);
  TglVertexAttribI4iv = PROCEDURE{C}(index_: GLuint;  v: PGLint);
  TglVertexAttribI1uiv = PROCEDURE{C}(index_: GLuint;  v: PGLuint);
  TglVertexAttribI2uiv = PROCEDURE{C}(index_: GLuint;  v: PGLuint);
  TglVertexAttribI3uiv = PROCEDURE{C}(index_: GLuint;  v: PGLuint);
  TglVertexAttribI4uiv = PROCEDURE{C}(index_: GLuint;  v: PGLuint);
  TglVertexAttribI4bv = PROCEDURE{C}(index_: GLuint;  v: PGLbyte);
  TglVertexAttribI4sv = PROCEDURE{C}(index_: GLuint;  v: PGLshort);
  TglVertexAttribI4ubv = PROCEDURE{C}(index_: GLuint;  v: PGLubyte);
  TglVertexAttribI4usv = PROCEDURE{C}(index_: GLuint;  v: PGLushort);
  TglGetUniformuiv = PROCEDURE{C}(xprogram: GLuint; location: GLint; params: PGLuint);
  TglBindFragDataLocation = PROCEDURE{C}(xprogram: GLuint; color: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataLocation = PROCEDURE{C}(xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;
  TglUniform1ui = PROCEDURE{C}(location: GLint; v0: GLuint);
  TglUniform2ui = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint);
  TglUniform3ui = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglUniform4ui = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglUniform1uiv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform2uiv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform3uiv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform4uiv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglTexParameterIiv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglTexParameterIuiv = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetTexParameterIiv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterIuiv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLuint);
  TglClearBufferiv = PROCEDURE{C}(buffer: GLenum; drawbuffer: GLint;  value: PGLint);
  TglClearBufferuiv = PROCEDURE{C}(buffer: GLenum; drawbuffer: GLint;  value: PGLuint);
  TglClearBufferfv = PROCEDURE{C}(buffer: GLenum; drawbuffer: GLint;  value: PGLfloat);
  TglClearBufferfi = PROCEDURE{C}(buffer: GLenum; drawbuffer: GLint; depth: GLfloat; stencil: GLint);
  TglGetStringi = PROCEDURE{C}(name: GLenum; index: GLuint): PGLubyte;

  (*! GL_VERSION_3_1 *)
  (* OpenGL 3.1 also reuses entry points from these extensions:
   ARB_copy_buffer
   ARB_uniform_buffer_object  *)
  TglDrawArraysInstanced = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstanced = PROCEDURE{C}(mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei);
  TglTexBuffer = PROCEDURE{C}(target: GLenum; internalformat: GLenum; buffer: GLuint);
  TglPrimitiveRestartIndex = PROCEDURE{C}(index_: GLuint);

  (*! GL_VERSION_3_2 *)
  (* OpenGL 3.2 also reuses entry points from these extensions:
   ARB_draw_elements_base_vertex
   ARB_provoking_vertex
   ARB_sync
   ARB_texture_multisample  *)
  TglGetInteger64i_v = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PGLint64);
  TglGetBufferParameteri64v = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint64);
  TglFramebufferTexture = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
  (*TglFramebufferTextureFace = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum); *)

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
  TglVertexAttribDivisor = PROCEDURE{C}(index: GLuint; divisor: GLuint);


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
  TglMinSampleShading = PROCEDURE{C}(value: GLclampf);
  TglBlendEquationi = PROCEDURE{C}(buf: GLuint; mode: GLenum);
  TglBlendEquationSeparatei = PROCEDURE{C}(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);
  TglBlendFunci = PROCEDURE{C}(buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparatei = PROCEDURE{C}(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);

  (*! GL_VERSION_4_1 *)
  (* OpenGL 4.1 also reuses entry points from these extensions: *)
  (* ARB_ES2_compatibility *)
  (* ARB_get_program_binary *)
  (* ARB_separate_shader_objects *)
  (* ARB_shader_precision (no entry points) *)
  (* ARB_vertex_attrib_64bit *)
  (* ARB_viewport_array *)


 (* GL_3DFX_tbuffer *)
  TglTbufferMask3DFX = PROCEDURE{C}(mask: GLuint);
(****************************************)
  (* GL_APPLE_element_array *)
  TglElementPointerAPPLE = PROCEDURE{C}(xtype:  GLenum; xpointer: PGLvoid);
  TglDrawElementArrayAPPLE = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei);
  TglDrawRangeElementArrayAPPLE = PROCEDURE{C}(mode: GLenum; start: GLuint; xend: GLuint; first: GLint; count: GLsizei);
  TglMultiDrawElementArrayAPPLE = PROCEDURE{C}(mode: GLenum;  first: PGLint;  count: PGLsizei; primcount: GLsizei);
  TglMultiDrawRangeElementArrayAPPLE = PROCEDURE{C}(mode: GLenum; start: GLuint; xend: GLuint;  first: PGLint; count: PGLsizei; primcount: GLsizei);

  (* GL_APPLE_fence *)
  TglGenFencesAPPLE = PROCEDURE{C}(n: GLsizei; fences: PGLuint);
  TglDeleteFencesAPPLE = PROCEDURE{C}(n: GLsizei; fences: PGLuint);
  TglSetFenceAPPLE = PROCEDURE{C}(fence: GLuint);
  TglIsFenceAPPLE = PROCEDURE{C}(fence: GLuint): GLboolean;
  TglTestFenceAPPLE = PROCEDURE{C}(fence: GLuint): GLboolean;
  TglFinishFenceAPPLE= PROCEDURE{C}(fence: GLuint);
  TglTestObjectAPPLE = PROCEDURE{C}(_object: GLenum; name: GLuint): GLboolean;
  TglFinishObjectAPPLE= PROCEDURE{C}(_object: GLenum; name: GLint);

  (* GL_APPLE_vertex_array_object *)
  TglBindVertexArrayAPPLE = PROCEDURE{C}(xarray: GLuint);
  TglDeleteVertexArraysAPPLE = PROCEDURE{C}(n: GLsizei; xarrays: PGLuint);
  TglGenVertexArraysAPPLE = PROCEDURE{C}(n: GLsizei; xarrays: PGLuint);
  TglIsVertexArrayAPPLE = PROCEDURE{C}(narray: GLuint): GLboolean;

  (*  GL_APPLE_vertex_array_range *)
  TglVertexArrayRangeAPPLE = PROCEDURE{C}(length: GLsizei; xpointer: PGLvoid);
  TglFlushVertexArrayRangeAPPLE = PROCEDURE{C}(length: GLsizei; xpointer: PGLvoid);
  TglVertexArrayParameteriAPPLE = PROCEDURE{C}(pname: GLenum; param: GLint);

  (*  GL_APPLE_texture_range *)
  TglTextureRangeAPPLE = PROCEDURE{C}(target: GLenum; xlength: GLsizei; xpointer: PGLvoid);
  TglGetTexParameterPointervAPPLE = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PPGLvoid);

  (*  GL_APPLE_vertex_program_evaluators *)
  TglEnableVertexAttribAPPLE = PROCEDURE{C}(indexx: GLuint; pname: GLenum);
  TglDisableVertexAttribAPPLE = PROCEDURE{C}(indexx: GLuint; pname: GLenum);
  TglIsVertexAttribEnabledAPPLE = PROCEDURE{C}(indexx: GLuint; pname: GLenum): GLboolean;
  TglMapVertexAttrib1dAPPLE = PROCEDURE{C}(indexx: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; stride: GLint; order: GLint; points: PGLdouble);
  TglMapVertexAttrib1fAPPLE = PROCEDURE{C}(indexx: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; stride: GLint; order: GLint; points: PGLfloat);
  TglMapVertexAttrib2dAPPLE = PROCEDURE{C}(indexx: GLuint; size: GLuint; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; points: PGLdouble);
  TglMapVertexAttrib2fAPPLE = PROCEDURE{C}(indexx: GLuint; size: GLuint; u1: GLfloat; u2: GLfloat; ustride: GLint; order: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; points: GLfloat);

  (*  GL_APPLE_object_purgeable *)
  TglObjectPurgeableAPPLE = PROCEDURE{C}(objectType: GLenum; name: GLuint; option: GLenum): GLenum;
  TglObjectUnpurgeableAPPLE = PROCEDURE{C}(objectType: GLenum; name: GLuint; option: GLenum): GLenum;
  TglGetObjectParameterivAPPLE = PROCEDURE{C}(objectType: GLenum; name: GLuint; pname: GLenum; params: PGLint);

(**********************************)
  (* GL_ARB_matrix_palette *)
  TglCurrentPaletteMatrixARB = PROCEDURE{C}(index: GLint);
  TglMatrixIndexubvARB = PROCEDURE{C}(size: GLint;  indices: PGLubyte);
  TglMatrixIndexusvARB = PROCEDURE{C}(size: GLint;  indices: PGLushort);
  TglMatrixIndexuivARB = PROCEDURE{C}(size: GLint;  indices: PGLuint);
  TglMatrixIndexPointerARB = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_ARB_multisample *)
  TglSampleCoverageARB = PROCEDURE{C}(value: GLclampf; invert: GLboolean);

  (* GL_ARB_multitexture *)
  TglActiveTextureARB = PROCEDURE{C}(texture: GLenum);
  TglClientActiveTextureARB = PROCEDURE{C}(texture: GLenum);
  TglMultiTexCoord1dARB = PROCEDURE{C}(target: GLenum; s: GLdouble);
  TglMultiTexCoord1dvARB = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord1fARB = PROCEDURE{C}(target: GLenum; s: GLfloat);
  TglMultiTexCoord1fvARB = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord1iARB = PROCEDURE{C}(target: GLenum; s: GLint);
  TglMultiTexCoord1ivARB = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord1sARB = PROCEDURE{C}(target: GLenum; s: GLshort);
  TglMultiTexCoord1svARB = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord2dARB = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble);
  TglMultiTexCoord2dvARB = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord2fARB = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat);
  TglMultiTexCoord2fvARB = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord2iARB = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint);
  TglMultiTexCoord2ivARB = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord2sARB = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort);
  TglMultiTexCoord2svARB = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord3dARB = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble);
  TglMultiTexCoord3dvARB = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord3fARB = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat);
  TglMultiTexCoord3fvARB = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord3iARB = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint; r: GLint);
  TglMultiTexCoord3ivARB = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord3sARB = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort; r: GLshort);
  TglMultiTexCoord3svARB = PROCEDURE{C}(target: GLenum;  v: PGLshort);
  TglMultiTexCoord4dARB = PROCEDURE{C}(target: GLenum; s: GLdouble; t: GLdouble; r: GLdouble; q: GLdouble);
  TglMultiTexCoord4dvARB = PROCEDURE{C}(target: GLenum;  v: PGLdouble);
  TglMultiTexCoord4fARB = PROCEDURE{C}(target: GLenum; s: GLfloat; t: GLfloat; r: GLfloat; q: GLfloat);
  TglMultiTexCoord4fvARB = PROCEDURE{C}(target: GLenum;  v: PGLfloat);
  TglMultiTexCoord4iARB = PROCEDURE{C}(target: GLenum; s: GLint; t: GLint; r: GLint; q: GLint);
  TglMultiTexCoord4ivARB = PROCEDURE{C}(target: GLenum;  v: PGLint);
  TglMultiTexCoord4sARB = PROCEDURE{C}(target: GLenum; s: GLshort; t: GLshort; r: GLshort; q: GLshort);
  TglMultiTexCoord4svARB = PROCEDURE{C}(target: GLenum;  v: PGLshort);

  (* GL_ARB_point_parameters *)
  TglPointParameterfARB = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPointParameterfvARB = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);

  (* GL_ARB_texture_compression *)
  TglCompressedTexImage3DARB = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage2DARB = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexImage1DARB = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage3DARB = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage2DARB = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglCompressedTexSubImage1DARB = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  data: PGLvoid);
  TglGetCompressedTexImageARB = PROCEDURE{C}(target: GLenum; level: GLint; img: PGLvoid);

  (* GL_ARB_transpose_matrix *)
  TglLoadTransposeMatrixfARB = PROCEDURE{C}( m: PGLfloat);
  TglLoadTransposeMatrixdARB = PROCEDURE{C}( m: PGLdouble);
  TglMultTransposeMatrixfARB = PROCEDURE{C}( m: PGLfloat);
  TglMultTransposeMatrixdARB = PROCEDURE{C}( m: PGLdouble);

  (* GL_ARB_vertex_blend *)
  TglWeightbvARB = PROCEDURE{C}(size: GLint;  weights: PGLbyte);
  TglWeightsvARB = PROCEDURE{C}(size: GLint;  weights: PGLshort);
  TglWeightivARB = PROCEDURE{C}(size: GLint;  weights: PGLint);
  TglWeightfvARB = PROCEDURE{C}(size: GLint;  weights: PGLfloat);
  TglWeightdvARB = PROCEDURE{C}(size: GLint;  weights: PGLdouble);
  TglWeightubvARB = PROCEDURE{C}(size: GLint;  weights: PGLubyte);
  TglWeightusvARB = PROCEDURE{C}(size: GLint;  weights: PGLushort);
  TglWeightuivARB = PROCEDURE{C}(size: GLint;  weights: PGLuint);
  TglWeightPointerARB = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; xpointer: PGLvoid);
  TglVertexBlendARB = PROCEDURE{C}(count: GLint);

  (* GL_ARB_vertex_buffer_object *)
  TglBindBufferARB = PROCEDURE{C}(target: GLenum; buffer: GLuint);
  TglDeleteBuffersARB = PROCEDURE{C}(n: GLsizei;  buffers: PGLuint);
  TglGenBuffersARB = PROCEDURE{C}(n: GLsizei; buffers: PGLuint );
  TglIsBufferARB = PROCEDURE{C}(buffer: GLuint): GLboolean;
  TglBufferDataARB = PROCEDURE{C}(target: GLenum; size: GLsizei;  data: PGLvoid; usage: GLenum);
  TglBufferSubDataARB = PROCEDURE{C}(target: GLenum; offset: GLsizei; size: GLsizei;  data: PGLvoid);
  TglGetBufferSubDataARB = PROCEDURE{C}(target: GLenum; offset: GLsizei; size: GLsizei; data: PGLvoid);
  TglMapBufferARB = PROCEDURE{C}(target: GLenum; access: GLenum): PGLvoid;
  TglUnmapBufferARB = PROCEDURE{C}( target: GLenum): GLboolean;
  TglGetBufferParameterivARB = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetBufferPointervARB = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLvoid);

  (* GL_ARB_vertex_program *)
  TglVertexAttrib1dARB = PROCEDURE{C}(index: GLuint; x: GLdouble);
  TglVertexAttrib1dvARB = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib1fARB = PROCEDURE{C}(index: GLuint; x: GLfloat);
  TglVertexAttrib1fvARB = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib1sARB = PROCEDURE{C}(index: GLuint; x: GLshort);
  TglVertexAttrib1svARB = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib2dARB = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dvARB = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib2fARB = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fvARB = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib2sARB = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2svARB = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib3dARB = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dvARB = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib3fARB = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fvARB = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib3sARB = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3svARB = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4NbvARB = PROCEDURE{C}(index: GLuint;  v: PGLbyte);
  TglVertexAttrib4NivARB = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttrib4NsvARB = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4NubARB = PROCEDURE{C}(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4NubvARB = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttrib4NuivARB = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttrib4NusvARB = PROCEDURE{C}(index: GLuint;  v: PGLushort);
  TglVertexAttrib4bvARB = PROCEDURE{C}(index: GLuint;  v: PGLbyte);
  TglVertexAttrib4dARB = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dvARB = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib4fARB = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fvARB = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib4ivARB = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttrib4sARB = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4svARB = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubvARB = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttrib4uivARB = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttrib4usvARB = PROCEDURE{C}(index: GLuint;  v: PGLushort);
  TglVertexAttribPointerARB = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei; xpointer: PGLvoid);
  TglEnableVertexAttribArrayARB = PROCEDURE{C}(index: GLuint);
  TglDisableVertexAttribArrayARB = PROCEDURE{C}(index: GLuint);
  TglProgramStringARB = PROCEDURE{C}(target: GLenum; format: GLenum; len: GLsizei;  xstring: PGLvoid);
  TglBindProgramARB = PROCEDURE{C}(target: GLenum; xprogram: GLuint);
  TglDeleteProgramsARB = PROCEDURE{C}(n: GLsizei;  programs: PGLuint);
  TglGenProgramsARB = PROCEDURE{C}(n: GLsizei; programs: PGLuint);
  TglProgramEnvParameter4dARB = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramEnvParameter4dvARB = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLdouble);
  TglProgramEnvParameter4fARB = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramEnvParameter4fvARB = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLfloat);
  TglProgramLocalParameter4dARB = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramLocalParameter4dvARB = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLdouble);
  TglProgramLocalParameter4fARB = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramLocalParameter4fvARB = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLfloat);
  TglGetProgramEnvParameterdvARB = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLdouble);
  TglGetProgramEnvParameterfvARB = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLfloat);
  TglGetProgramLocalParameterdvARB = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLdouble);
  TglGetProgramLocalParameterfvARB = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLfloat);
  TglGetProgramivARB = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetProgramStringARB = PROCEDURE{C}(target: GLenum; pname: GLenum; _string: PGLvoid);
  TglGetVertexAttribdvARB = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetVertexAttribfvARB = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribivARB = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointervARB = PROCEDURE{C}(index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgramARB = PROCEDURE{C}(xprogram: GLuint): GLboolean;

  (* GL_ARB_window_pos *)
  TglWindowPos2dARB = PROCEDURE{C}(x: GLdouble; y: GLdouble);
  TglWindowPos2dvARB = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos2fARB = PROCEDURE{C}(x: GLfloat; y: GLfloat);
  TglWindowPos2fvARB = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos2iARB = PROCEDURE{C}(x: GLint; y: GLint);
  TglWindowPos2ivARB = PROCEDURE{C}( v: PGLint);
  TglWindowPos2sARB = PROCEDURE{C}(x: GLshort; y: GLshort);
  TglWindowPos2svARB = PROCEDURE{C}( v: PGLshort);
  TglWindowPos3dARB = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dvARB = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos3fARB = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fvARB = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos3iARB = PROCEDURE{C}(x: GLint; y: GLint; z: GLint);
  TglWindowPos3ivARB = PROCEDURE{C}( v: PGLint);
  TglWindowPos3sARB = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3svARB = PROCEDURE{C}( v: PGLshort);

  (* GL_ARB_draw_buffers *)
  TglDrawBuffersARB = PROCEDURE{C}(n: GLsizei; bufs: PGLenum);

  (* GL_ARB_color_buffer_float *)
  TglClampColorARB = PROCEDURE{C}(target: GLenum; clamp: GLenum);

  (* GL_ARB_vertex_shader *)
  TglGetActiveAttribARB = PROCEDURE{C}(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLcharARB);
  TglGetAttribLocationARB = PROCEDURE{C}(programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint;
  TglBindAttribLocationARB = PROCEDURE{C}(programObj: GLHandleARB; index: GLuint; CONST name: ARRAY OF CHAR);

  (* GL_ARB_shader_objects *)
  TglDeleteObjectARB = PROCEDURE{C}(Obj: GLHandleARB);
  TglGetHandleARB = PROCEDURE{C}(pname: GLenum): GLHandleARB;
  TglDetachObjectARB = PROCEDURE{C}(container, attached: GLHandleARB);
  TglCreateShaderObjectARB = PROCEDURE{C}(shaderType: GLenum): GLHandleARB;
  TglShaderSourceARB = PROCEDURE{C}(shaderObj: GLHandleARB; count: GLsizei; xstring: PPGLcharARB; lengths: PGLint);
  TglCompileShaderARB = PROCEDURE{C}(shaderObj: GLHandleARB);
  TglCreateProgramObjectARB = PROCEDURE{C}(): GLHandleARB;
  TglAttachObjectARB = PROCEDURE{C}(programObj, shaderObj: GLHandleARB);
  TglLinkProgramARB = PROCEDURE{C}(programObj: GLHandleARB);
  TglUseProgramObjectARB = PROCEDURE{C}(programObj: GLHandleARB);
  TglValidateProgramARB = PROCEDURE{C}(programObj: GLHandleARB);
  TglUniform1fARB = PROCEDURE{C}(location: GLint; v0: GLfloat);
  TglUniform2fARB = PROCEDURE{C}(location: GLint; v0, v1: GLfloat);
  TglUniform3fARB = PROCEDURE{C}(location: GLint; v0, v1, v2: GLfloat);
  TglUniform4fARB = PROCEDURE{C}(location: GLint; v0, v1, v2, v3: GLfloat);
  TglUniform1iARB = PROCEDURE{C}(location: GLint; v0: GLint);
  TglUniform2iARB = PROCEDURE{C}(location: GLint; v0, v1: GLint);
  TglUniform3iARB = PROCEDURE{C}(location: GLint; v0, v1, v2: GLint);
  TglUniform4iARB = PROCEDURE{C}(location: GLint; v0, v1, v2, v3: GLint);
  TglUniform1fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform2fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform3fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform4fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLfloat);
  TglUniform1ivARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform2ivARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform3ivARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniform4ivARB = PROCEDURE{C}(location: GLint; count: GLsizei; value: PGLint);
  TglUniformMatrix2fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix3fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglUniformMatrix4fvARB = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean; value: PGLfloat);
  TglGetObjectParameterfvARB = PROCEDURE{C}(Obj: GLHandleARB; pname: GLenum; params: PGLfloat);
  TglGetObjectParameterivARB = PROCEDURE{C}(Obj: GLHandleARB; pname: GLenum; params: PGLint);
  TglGetInfoLogARB = PROCEDURE{C}(shaderObj: GLHandleARB; maxLength: GLsizei; VAR length: GLint; infoLog: PGLcharARB);
  TglGetAttachedObjectsARB = PROCEDURE{C}(programobj: GLHandleARB; maxCount: GLsizei; VAR count: GLsizei; objects: PGLHandleARB);
  TglGetUniformLocationARB = PROCEDURE{C}(programObj: GLHandleARB; CONST chars: ARRAY OF CHAR): GLint;
  TglGetActiveUniformARB = PROCEDURE{C}(programobj: GLHandleARB; index: GLuint; maxLength: GLsizei; VAR length: GLsizei; VAR size: GLint; VAR xtype: GLenum; name: PGLcharARB);
  TglGetUniformfvARB = PROCEDURE{C}(programObj: GLHandleARB; location: GLint; params: PGLfloat);
  TglGetUniformivARB = PROCEDURE{C}(programObj: GLHandleARB; location: GLint; params: PGLint);
  TglGetShaderSourceARB = PROCEDURE{C}(shader: GLHandleARB; maxLength: GLsizei; VAR length: GLsizei; source: PGLcharARB);

  (* GL_ARB_Occlusion_Query *)
  TglGenQueriesARB = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglDeleteQueriesARB = PROCEDURE{C}(n: GLsizei;  ids: PGLuint);
  TglIsQueryARB = PROCEDURE{C}(id: GLuint): BOOLEAN;
  TglBeginQueryARB = PROCEDURE{C}(target: GLenum; id: GLuint);
  TglEndQueryARB = PROCEDURE{C}(target: GLenum);
  TglGetQueryivARB = PROCEDURE{C}(target, pname: GLenum; params: PGLint);
  TglGetQueryObjectivARB = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint);
  TglGetQueryObjectuivARB = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLuint);

  (* GL_ARB_draw_instanced *)
  TglDrawArraysInstancedARB = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstancedARB = PROCEDURE{C}(mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei);

  (* GL_ARB_framebuffer_object *)
  TglIsRenderbuffer = PROCEDURE{C}(renderbuffer: GLuint): GLboolean;
  TglBindRenderbuffer = PROCEDURE{C}(target: GLenum; renderbuffer: GLuint);
  TglDeleteRenderbuffers = PROCEDURE{C}(n: GLsizei;  renderbuffers: PGLuint);
  TglGenRenderbuffers = PROCEDURE{C}(n: GLsizei; renderbuffers: PGLuint);
  TglRenderbufferStorage = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetRenderbufferParameteriv = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglIsFramebuffer = PROCEDURE{C}(framebuffer: GLuint): GLboolean;
  TglBindFramebuffer = PROCEDURE{C}(target: GLenum; framebuffer: GLuint);
  TglDeleteFramebuffers = PROCEDURE{C}(n: GLsizei;  framebuffers: PGLuint);
  TglGenFramebuffers = PROCEDURE{C}(n: GLsizei; framebuffers: PGLuint);
  TglCheckFramebufferStatus = PROCEDURE{C}(target: GLenum): GLenum;
  TglFramebufferTexture1D = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture2D = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture3D = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglFramebufferRenderbuffer = PROCEDURE{C}(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetFramebufferAttachmentParameteriv = PROCEDURE{C}(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateMipmap = PROCEDURE{C}(target: GLenum);
  TglBlitFramebuffer = PROCEDURE{C}(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum);
  TglRenderbufferStorageMultisample = PROCEDURE{C}(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglFramebufferTextureLayer = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);

  (* GL_ARB_geometry_shader4 *)
  TglProgramParameteriARB = PROCEDURE{C}(xprogram: GLuint; pname: GLenum; value: GLint);
  TglFramebufferTextureARB = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTextureLayerARB = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);
  TglFramebufferTextureFaceARB = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);

  (* GL_ARB_instanced_arrays *)
  TglVertexAttribDivisorARB = PROCEDURE{C}(index_: GLuint; divisor: GLuint);

  (* GL_ARB_map_buffer_range *)
  TglMapBufferRange = PROCEDURE{C}(target: GLenum; offset: GLsizei; length: GLsizei; access: GLbitfield): PGLvoid;
  TglFlushMappedBufferRange = PROCEDURE{C}(target: GLenum; offset: GLsizei; length: GLsizei);

  (* GL_ARB_texture_buffer_object *)
  TglTexBufferARB = PROCEDURE{C}(target: GLenum; internalformat: GLenum; buffer: GLuint);

  (* GL_ARB_vertex_array_object *)
  TglBindVertexArray = PROCEDURE{C}(array_: GLuint);
  TglDeleteVertexArrays = PROCEDURE{C}(n: GLsizei;  arrays: PGLuint);
  TglGenVertexArrays = PROCEDURE{C}(n: GLsizei; arrays: PGLuint);
  TglIsVertexArray = PROCEDURE{C}(array_: GLuint): GLboolean;

  (* GL_ARB_uniform_buffer_object *)
  TglGetUniformIndices = PROCEDURE{C}(xprogram: GLuint; uniformCount: GLsizei;  uniformNames: PPGLchar; uniformIndices: PGLuint);
  TglGetActiveUniformsiv = PROCEDURE{C}(xprogram: GLuint; uniformCount: GLsizei;  uniformIndices: PGLuint; pname: GLenum; params: PGLint);
  TglGetActiveUniformName = PROCEDURE{C}(xprogram: GLuint; uniformIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformName: PGLchar);
  TglGetUniformBlockIndex = PROCEDURE{C}(xprogram: GLuint; CONST uniformBlockName: ARRAY OF CHAR): GLuint;
  TglGetActiveUniformBlockiv = PROCEDURE{C}(xprogram: GLuint; uniformBlockIndex: GLuint; pname: GLenum; params: PGLint);
  TglGetActiveUniformBlockName = PROCEDURE{C}(xprogram: GLuint; uniformBlockIndex: GLuint; bufSize: GLsizei; length: PGLsizei; uniformBlockName: PGLchar);
  TglUniformBlockBinding = PROCEDURE{C}(xprogram: GLuint; uniformBlockIndex: GLuint; uniformBlockBinding: GLuint);

  (* GL_ARB_copy_buffer *)
  TglCopyBufferSubData = PROCEDURE{C}(readTarget: GLenum; writeTarget: GLenum; readOffset: GLint; writeOffset: GLint; size: GLsizei);

  (* GL_ARB_draw_elements_base_vertex *)
  TglDrawElementsBaseVertex = PROCEDURE{C}(mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; basevertex: GLint);
  TglDrawRangeElementsBaseVertex = PROCEDURE{C}(mode: GLenum; start: GLuint; end_: GLuint; count: GLsizei; type_: GLenum;  indices: PGLvoid; basevertex: GLint);
  TglDrawElementsInstancedBaseVertex = PROCEDURE{C}(mode: GLenum; count: GLsizei; type_: GLenum;  indices: PGLvoid; primcount: GLsizei; basevertex: GLint);
  TglMultiDrawElementsBaseVertex = PROCEDURE{C}(mode: GLenum;  count: PGLsizei; type_: GLenum;  indices: PPGLvoid; primcount: GLsizei;  basevertex: PGLint);

  (* GL_ARB_provoking_vertex *)
  TglProvokingVertex = PROCEDURE{C}(mode: GLenum);

  (* GL_ARB_sync *)
  TglFenceSync = PROCEDURE{C}(condition: GLenum; flags: GLbitfield): GLsync;
  TglIsSync = PROCEDURE{C}(sync: GLsync): GLboolean;
  TglDeleteSync = PROCEDURE{C}(sync: GLsync);
  TglClientWaitSync = PROCEDURE{C}(sync: GLsync; flags: GLbitfield; timeout: GLuint64): GLenum;
  TglWaitSync = PROCEDURE{C}(sync: GLsync; flags: GLbitfield; timeout: GLuint64);
  TglGetInteger64v = PROCEDURE{C}(pname: GLenum; params: PGLint64);
  TglGetSynciv = PROCEDURE{C}(sync: GLsync; pname: GLenum; butSize: GLsizei; length: PGLsizei; values: PGLint);

  (* GL_ARB_texture_multisample *)
  TglTexImage2DMultisample = PROCEDURE{C}(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; fixedsamplelocations: GLboolean);
  TglTexImage3DMultisample = PROCEDURE{C}(target: GLenum; samples: GLsizei; internalformat: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; fixedsamplelocations: GLboolean);
  TglGetMultisamplefv = PROCEDURE{C}(pname: GLenum; index_: GLuint; val: PGLfloat);
  TglSampleMaski = PROCEDURE{C}(index_: GLuint; mask: GLbitfield);

  (* GL_ARB_draw_buffers_blend *)
  TglBlendEquationiARB = PROCEDURE{C}(buf: GLuint; mode: GLenum);
  TglBlendEquationSeparateiARB = PROCEDURE{C}(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);
  TglBlendFunciARB = PROCEDURE{C}(buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparateiARB = PROCEDURE{C}(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);

  (* GL_ARB_sample_shading *)
  TglMinSampleShadingARB = PROCEDURE{C}(value: GLclampf);

    (*  GL_ARB_shading_language_include *)
  TglNamedStringARB = PROCEDURE{C}(type_: GLenum; namelen: GLint; CONST name: ARRAY OF CHAR; stringlen: GLint; CONST xstring: ARRAY OF CHAR);
  TglDeleteNamedStringARB = PROCEDURE{C}(namelen: GLint; CONST name: ARRAY OF CHAR);
  TglCompileShaderIncludeARB = PROCEDURE{C}(shader: GLuint; count: GLsizei;  path: PPGLchar;  length: PGLint);
  TglIsNamedStringARB = PROCEDURE{C}(namelen: GLint; CONST name: ARRAY OF CHAR): GLboolean;
  TglGetNamedStringARB = PROCEDURE{C}(namelen: GLint; CONST name: ARRAY OF CHAR; bufSize: GLsizei; stringlen: GLint; xstring: PGLchar);
  TglGetNamedStringivARB = PROCEDURE{C}(namelen: GLint; CONST name: ARRAY OF CHAR; pname: GLenum; params: PGLint);

  (*  GL_ARB_blend_func_extended *)
  TglBindFragDataLocationIndexed = PROCEDURE{C}(xprogram: GLuint; colorNumber: GLuint; index: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataIndex = PROCEDURE{C}(xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;

  (*  GL_ARB_sampler_objects *)
  TglGenSamplers = PROCEDURE{C}(count: GLsizei; samplers: PGLuint);
  TglDeleteSamplers = PROCEDURE{C}(count: GLsizei;  samplers: PGLuint);
  TglIsSampler = PROCEDURE{C}(sampler: GLuint): GLboolean;
  TglBindSampler = PROCEDURE{C}(unit_: GLuint; sampler: GLuint);
  TglSamplerParameteri = PROCEDURE{C}(sampler: GLuint; pname: GLenum; param: GLint);
  TglSamplerParameteriv = PROCEDURE{C}(sampler: GLuint; pname: GLenum;  param: PGLint);
  TglSamplerParameterf = PROCEDURE{C}(sampler: GLuint; pname: GLenum; param: GLfloat);
  TglSamplerParameterfv = PROCEDURE{C}(sampler: GLuint; pname: GLenum;  param: PGLfloat);
  TglSamplerParameterIiv = PROCEDURE{C}(sampler: GLuint; pname: GLenum;  param: PGLint);
  TglSamplerParameterIuiv = PROCEDURE{C}(sampler: GLuint; pname: GLenum;  param: PGLuint);
  TglGetSamplerParameteriv = PROCEDURE{C}(sampler: GLuint; pname: GLenum; params: PGLint);
  TglGetSamplerParameterIiv = PROCEDURE{C}(sampler: GLuint; pname: GLenum; params: PGLint);
  TglGetSamplerParameterfv = PROCEDURE{C}(sampler: GLuint; pname: GLenum; params: PGLfloat);
  TglGetSamplerParameterIuiv = PROCEDURE{C}(sampler: GLuint; pname: GLenum; params: PGLuint);

  (*  GL_ARB_timer_query *)
  TglQueryCounter = PROCEDURE{C}(id: GLuint; target: GLenum);
  TglGetQueryObjecti64v = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint64);
  TglGetQueryObjectui64v = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLuint64);

  (*  GL_ARB_vertexxtype_2_10_10_10_rev *)
  TglVertexP2ui = PROCEDURE{C}(type_: GLenum; value: GLuint);
  TglVertexP2uiv = PROCEDURE{C}(type_: GLenum;  value: PGLuint);
  TglVertexP3ui = PROCEDURE{C}(type_: GLenum; value: GLuint);
  TglVertexP3uiv = PROCEDURE{C}(type_: GLenum;  value: PGLuint);
  TglVertexP4ui = PROCEDURE{C}(type_: GLenum; value: GLuint);
  TglVertexP4uiv = PROCEDURE{C}(type_: GLenum;  value: PGLuint);
  TglTexCoordP1ui = PROCEDURE{C}(type_: GLenum; coords: GLuint);
  TglTexCoordP1uiv = PROCEDURE{C}(type_: GLenum;  coords: PGLuint);
  TglTexCoordP2ui = PROCEDURE{C}(type_: GLenum; coords: GLuint);
  TglTexCoordP2uiv = PROCEDURE{C}(type_: GLenum;  coords: PGLuint);
  TglTexCoordP3ui = PROCEDURE{C}(type_: GLenum; coords: GLuint);
  TglTexCoordP3uiv = PROCEDURE{C}(type_: GLenum;  coords: PGLuint);
  TglTexCoordP4ui = PROCEDURE{C}(type_: GLenum; coords: GLuint);
  TglTexCoordP4uiv = PROCEDURE{C}(type_: GLenum;  coords: PGLuint);
  TglMultiTexCoordP1ui = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP1uiv = PROCEDURE{C}(texture: GLenum; type_: GLenum;  coords: PGLuint);
  TglMultiTexCoordP2ui = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP2uiv = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: PGLuint);
  TglMultiTexCoordP3ui = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP3uiv = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: PGLuint);
  TglMultiTexCoordP4ui = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: GLuint);
  TglMultiTexCoordP4uiv = PROCEDURE{C}(texture: GLenum; type_: GLenum; coords: PGLuint);
  TglNormalP3ui = PROCEDURE{C}(type_: GLenum; coords: GLuint);
  TglNormalP3uiv = PROCEDURE{C}(type_: GLenum;  coords: PGLuint);
  TglColorP3ui = PROCEDURE{C}(type_: GLenum; color: GLuint);
  TglColorP3uiv = PROCEDURE{C}(type_: GLenum;  color: PGLuint);
  TglColorP4ui = PROCEDURE{C}(type_: GLenum; color: GLuint);
  TglColorP4uiv = PROCEDURE{C}(type_: GLenum;  color: GLuint);
  TglSecondaryColorP3ui = PROCEDURE{C}(type_: GLenum; color: GLuint);
  TglSecondaryColorP3uiv = PROCEDURE{C}(type_: GLenum;  color: PGLuint);
  TglVertexAttribP1ui = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP1uiv = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP2ui = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP2uiv = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP3ui = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP3uiv = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);
  TglVertexAttribP4ui = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean; value: GLuint);
  TglVertexAttribP4uiv = PROCEDURE{C}(index: GLuint; type_: GLenum; normalized: GLboolean;  value: PGLuint);

  (*  GL_ARB_draw_indirect *)
  TglDrawArraysIndirect = PROCEDURE{C}(mode: GLenum;  indirect: PGLvoid);
  TglDrawElementsIndirect = PROCEDURE{C}(mode: GLenum; xtype: GLenum;  indirect: PGLvoid);

  (*  GL_ARB_gpu_shader_fp64 *)
  TglUniform1d = PROCEDURE{C}(location: GLint; x: GLdouble);
  TglUniform2d = PROCEDURE{C}(location: GLint; x: GLdouble; y: GLdouble);
  TglUniform3d = PROCEDURE{C}(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglUniform4d = PROCEDURE{C}(location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglUniform1dv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform2dv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform3dv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniform4dv = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLdouble);
  TglUniformMatrix2dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix2x3dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix2x4dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3x2dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix3x4dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4x2dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglUniformMatrix4x3dv = PROCEDURE{C}(location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglGetUniformdv = PROCEDURE{C}(xprogram: GLuint; location: GLint; params: PGLdouble);

  (*  GL_ARB_shader_subroutine *)
  TglGetSubroutineUniformLocation = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; CONST name: ARRAY OF CHAR): GLint;
  TglGetSubroutineIndex = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; CONST name: ARRAY OF CHAR): GLuint;
  TglGetActiveSubroutineUniformiv = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; index: GLuint; pname: GLenum; values: PGLint);
  TglGetActiveSubroutineUniformName = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar);
  TglGetActiveSubroutineName = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; index: GLuint; bufsize: GLsizei; length: PGLsizei; name: PGLchar);
  TglUniformSubroutinesuiv = PROCEDURE{C}(shadertype: GLenum; count: GLsizei;  indices: PGLuint);
  TglGetUniformSubroutineuiv = PROCEDURE{C}(shadertype: GLenum; location: GLint; params: PGLuint);
  TglGetProgramStageiv = PROCEDURE{C}(xprogram: GLuint; shadertype: GLenum; pname: GLenum; values: PGLint);

  (*  GL_ARB_tessellation_shader *)
  TglPatchParameteri = PROCEDURE{C}(pname: GLenum; value: GLint);
  TglPatchParameterfv = PROCEDURE{C}(pname: GLenum;  values: PGLfloat);

  (*  GL_ARB_transform_feedback2 *)
  TglBindTransformFeedback = PROCEDURE{C}(target: GLenum; id: GLuint);
  TglDeleteTransformFeedbacks = PROCEDURE{C}(n: GLsizei;  ids: PGLuint);
  TglGenTransformFeedbacks = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglIsTransformFeedback = PROCEDURE{C}(id: GLuint): GLboolean;
  TglPauseTransformFeedback = PROCEDURE{C}();
  TglResumeTransformFeedback = PROCEDURE{C}();
  TglDrawTransformFeedback = PROCEDURE{C}(mode: GLenum; id: GLuint);

  (*  GL_ARB_transform_feedback3 *)
  TglDrawTransformFeedbackStream = PROCEDURE{C}(mode: GLenum; id: GLuint; stream: GLuint);
  TglBeginQueryIndexed = PROCEDURE{C}(target: GLenum; index: GLuint; id: GLuint);
  TglEndQueryIndexed = PROCEDURE{C}(target: GLenum; index: GLuint);
  TglGetQueryIndexediv = PROCEDURE{C}(target: GLenum; index: GLuint; pname: GLenum; params: PGLint);

  (*  GL_ARB_ES2_compatibility *)
  TglReleaseShaderCompiler = PROCEDURE{C}();
  TglShaderBinary = PROCEDURE{C}(count: GLsizei;  shaders: PGLuint; binaryformat: GLenum;  binary: PGLvoid; length: GLsizei);
  TglGetShaderPrecisionFormat = PROCEDURE{C}(shadertype: GLenum; precisiontype: GLenum; range: PGLint; precision: PGLint);
  TglDepthRangef = PROCEDURE{C}(n: GLclampf; f: GLclampf);
  TglClearDepthf = PROCEDURE{C}(d: GLclampf);

  (* GL_ARB_get_program_binary *)
  TglGetProgramBinary = PROCEDURE{C}(xprogram: GLuint; bufSize: GLsizei; length: PGLsizei; binaryFormat: PGLenum; binary: PGLvoid);
  TglProgramBinary = PROCEDURE{C}(xprogram: GLuint; binaryFormat: GLenum;  binary: PGLvoid; length: GLsizei);
  TglProgramParameteri = PROCEDURE{C}(xprogram: GLuint; pname: GLenum; value: GLint);

  (* GL_ARB_separate_shader_objects*)
  TglUseProgramStages = PROCEDURE{C}(pipeline: GLuint; stages: GLbitfield; xprogram: GLuint);
  TglActiveShaderProgram = PROCEDURE{C}(pipeline: GLuint; xprogram: GLuint);
  TglCreateShaderProgramv = PROCEDURE{C}(type_: GLenum; count: GLsizei;  strings: PPGLchar): GLuint;
  TglBindProgramPipeline = PROCEDURE{C}(pipeline: GLuint);
  TglDeleteProgramPipelines = PROCEDURE{C}(n: GLsizei;  pipelines: PGLuint);
  TglGenProgramPipelines = PROCEDURE{C}(n: GLsizei; pipelines: PGLuint);
  TglIsProgramPipeline = PROCEDURE{C}(pipeline: GLuint): GLboolean;
  TglGetProgramPipelineiv = PROCEDURE{C}(pipeline: GLuint; pname: GLenum; params: PGLint);
  TglProgramUniform1i = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint);
  TglProgramUniform1iv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform1f = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat);
  TglProgramUniform1fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform1d = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLdouble);
  TglProgramUniform1dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform1ui = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint);
  TglProgramUniform1uiv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform2i = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint);
  TglProgramUniform2iv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform2f = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);
  TglProgramUniform2fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform2d = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble);
  TglProgramUniform2dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform2ui = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint);
  TglProgramUniform2uiv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform3i = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);
  TglProgramUniform3iv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform3f = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);
  TglProgramUniform3fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform3d = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble);
  TglProgramUniform3dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform3ui = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglProgramUniform3uiv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform4i = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);
  TglProgramUniform4iv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform4f = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);
  TglProgramUniform4fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform4d = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLdouble; v1: GLdouble; v2: GLdouble; v3: GLdouble);
  TglProgramUniform4dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform4ui = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglProgramUniform4uiv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniformMatrix2fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x3fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x2fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x4fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x2fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x4fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x3fv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x3dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x2dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x4dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x2dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x4dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x3dv = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglValidateProgramPipeline = PROCEDURE{C}(pipeline: GLuint);
  TglGetProgramPipelineInfoLog = PROCEDURE{C}(pipeline: GLuint; bufSize: GLsizei; length: PGLsizei; infoLog: PGLchar);

  (* GL_ARB_vertex_attrib_64bit *)
  TglVertexAttribL1d = PROCEDURE{C}(index: GLuint; x: GLdouble);
  TglVertexAttribL2d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttribL3d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttribL4d = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttribL1dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL2dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL3dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL4dv = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribLPointer = PROCEDURE{C}(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribLdv = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLdouble);

  (* GL_ARB_viewport_array*)
  TglViewportArrayv = PROCEDURE{C}(first: GLuint; count: GLsizei;  v: PGLfloat);
  TglViewportIndexedf = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; w: GLfloat; h: GLfloat);
  TglViewportIndexedfv = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglScissorArrayv = PROCEDURE{C}(first: GLuint; count: GLsizei;  v: PGLint);
  TglScissorIndexed = PROCEDURE{C}(index: GLuint; left: GLint; bottom: GLint; width: GLsizei; height: GLsizei);
  TglScissorIndexedv = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglDepthRangeArrayv = PROCEDURE{C}(first: GLuint; count: GLsizei;  v: PGLclampd);
  TglDepthRangeIndexed = PROCEDURE{C}(index: GLuint; n: GLclampd; f: GLclampd);
  TglGetFloati_v = PROCEDURE{C}(target: GLenum; index: GLuint; data: PGLfloat);
  TglGetDoublei_v = PROCEDURE{C}(target: GLenum; index: GLuint; data: PGLdouble);

(**********************************************)
 (*! GL 4.2 *)

  (*  GL_ARB_base_instance *)
  TglDrawArraysInstancedBaseInstance = PROCEDURE{C}(mode : GLenum; first : GLint; count :GLsizei; primcount : GLsizei; baseinstance : GLuint);
  TglDrawElementsInstancedBaseInstance = PROCEDURE{C}(mode : GLenum; count : GLsizei; xtype : GLenum; indices : PGLvoid; primcount : GLsizei; baseinstance : GLuint);
  TglDrawElementsInstancedBaseVertexBaseInstance = PROCEDURE{C}(mode : GLenum; count : GLsizei; xtype : GLenum; indices : PGLvoid; primcount :GLsizei; basevertex : GLint; baseinstance : GLuint);

  (*  GL_ARB_transform_feedback_instanced *)
  TglDrawTransformFeedbackInstanced = PROCEDURE{C}(mode : GLenum; id : GLuint; primcount : GLsizei);
  TglDrawTransformFeedbackStreamInstanced = PROCEDURE{C}(mode : GLenum; id : GLuint; stream : GLuint; primcount : GLsizei);

  (*  GL_ARB_internalformat_query *)
  TglGetInternalformativ = PROCEDURE{C}(target : GLenum; internalformat : GLenum; pname : GLenum; bufSize : GLsizei; params : PGLint);

  (*  GL_ARB_shader_atomic_counters *)
  TglGetActiveAtomicCounterBufferiv = PROCEDURE{C}(xprogram : GLuint; bufferIndex : GLuint; pname : GLenum; params : PGLint);

  (* / GL_ARB_shader_image_load_store *)
  TglBindImageTexture = PROCEDURE{C}(xunit : GLuint; texture : GLuint; level :GLint; layered : GLboolean; layer : GLint; access : GLenum; format : GLenum);
  TglMemoryBarrier = PROCEDURE{C}(barriers : GLbitfield);

  (*  GL_ARB_texture_storage *)
  TglTexStorage1D = PROCEDURE{C}(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei);
  TglTexStorage2D = PROCEDURE{C}(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei);
  TglTexStorage3D = PROCEDURE{C}(target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei);
  TglTextureStorage1DEXT = PROCEDURE{C}(texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei);
  TglTextureStorage2DEXT = PROCEDURE{C}(texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei);
  TglTextureStorage3DEXT = PROCEDURE{C}(texture : GLuint; target : GLenum; levels :GLsizei; internalformat : GLenum; width : GLsizei; height : GLsizei; depth : GLsizei);


(**********************************************)

  (* GL_ARB_cl_event *)
  TglCreateSyncFromCLeventARB = PROCEDURE{C}(context: p_cl_context; event: p_cl_event; flags: GLbitfield): GLsync;

  (* GL_ARB_debug_output*)
  TglDebugMessageControlARB = PROCEDURE{C}(source: GLenum; type_: GLenum; severity: GLenum; count: GLsizei;  ids: PGLuint; enabled: GLboolean);
  TglDebugMessageInsertARB = PROCEDURE{C}(source: GLenum; type_: GLenum; id: GLuint; severity: GLenum; length: GLsizei;  buf: PGLchar);
 (* TglDebugMessageCallbackARB = PROCEDURE{C}(callback: TglDebugProcARB;  userParam: PGLvoid); *)
  TglGetDebugMessageLogARB = PROCEDURE{C}(count: GLuint; bufsize: GLsizei; sources: PGLenum; types: PGLenum; ids: PGLuint; severities: PGLenum; lengths: PGLsizei; messageLog: PGLchar): GLuint;

  (* GL_ARB_robustness*)
  TglGetGraphicsResetStatusARB = PROCEDURE{C}(): GLenum;
  TglGetnMapdvARB = PROCEDURE{C}(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLdouble);
  TglGetnMapfvARB = PROCEDURE{C}(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLfloat);
  TglGetnMapivARB = PROCEDURE{C}(target: GLenum; query: GLenum; bufSize: GLsizei; v: PGLint);
  TglGetnPixelMapfvARB = PROCEDURE{C}(map: GLenum; bufSize: GLsizei; values: PGLfloat);
  TglGetnPixelMapuivARB = PROCEDURE{C}(map: GLenum; bufSize: GLsizei; values: PGLuint);
  TglGetnPixelMapusvARB = PROCEDURE{C}(map: GLenum; bufSize: GLsizei; values: PGLushort);
  TglGetnPolygonStippleARB = PROCEDURE{C}(bufSize: GLsizei; pattern: PGLubyte);
  TglGetnColorTableARB = PROCEDURE{C}(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; table: PGLvoid);
  TglGetnConvolutionFilterARB = PROCEDURE{C}(target: GLenum; format: GLenum; type_: GLenum; bufSize: GLsizei; image: PGLvoid);
  TglGetnSeparableFilterARB = PROCEDURE{C}(target: GLenum; format: GLenum; type_: GLenum; rowBufSize: GLsizei; row: PGLvoid; columnBufSize: GLsizei; column: PGLvoid; span: PGLvoid);
  TglGetnHistogramARB = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid);
  TglGetnMinmaxARB = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; type_: GLenum; bufSize: GLsizei; values: PGLvoid);
  TglGetnTexImageARB = PROCEDURE{C}(target: GLenum; level: GLint; format: GLenum; type_: GLenum; bufSize: GLsizei; img: PGLvoid);
  TglReadnPixelsARB = PROCEDURE{C}(x: GLint; y: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; bufSize: GLsizei; data: PGLvoid);
  TglGetnCompressedTexImageARB = PROCEDURE{C}(target: GLenum; lod: GLint; bufSize: GLsizei; img: PGLvoid);
  TglGetnUniformfvARB = PROCEDURE{C}(xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLfloat);
  TglGetnUniformivARB = PROCEDURE{C}(xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLint);
  TglGetnUniformuivARB = PROCEDURE{C}(xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLuint);
  TglGetnUniformdvARB = PROCEDURE{C}(xprogram: GLuint; location: GLint; bufSize: GLsizei; params: PGLdouble);

  (* GL_ATI_draw_buffers *)
  TglDrawBuffersATI = PROCEDURE{C}(n: GLsizei;  bufs: PGLenum);

  (* GL_ATI_element_array *)
  TglElementPointerATI = PROCEDURE{C}(xtype: GLenum;  xpointer: PGLvoid);
  TglDrawElementArrayATI = PROCEDURE{C}(mode: GLenum; count: GLsizei);
  TglDrawRangeElementArrayATI = PROCEDURE{C}(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei);

  (* GL_ATI_envmap_bumpmap *)
  TglTexBumpParameterivATI = PROCEDURE{C}(pname: GLenum;  param: PGLint);
  TglTexBumpParameterfvATI = PROCEDURE{C}(pname: GLenum;  param: PGLfloat);
  TglGetTexBumpParameterivATI = PROCEDURE{C}(pname: GLenum; param: PGLint);
  TglGetTexBumpParameterfvATI = PROCEDURE{C}(pname: GLenum; param: PGLfloat);

  (* GL_ATI_fragment_shader *)
  TglGenFragmentShadersATI = PROCEDURE{C}(range: GLuint): GLuint;
  TglBindFragmentShaderATI = PROCEDURE{C}(id: GLuint);
  TglDeleteFragmentShaderATI = PROCEDURE{C}(id: GLuint);
  TglBeginFragmentShaderATI = PROCEDURE{C}();
  TglEndFragmentShaderATI = PROCEDURE{C}();
  TglPassTexCoordATI = PROCEDURE{C}(dst: GLuint; coord: GLuint; swizzle: GLenum);
  TglSampleMapATI = PROCEDURE{C}(dst: GLuint; interp: GLuint; swizzle: GLenum);
  TglColorFragmentOp1ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint);
  TglColorFragmentOp2ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint);
  TglColorFragmentOp3ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMask: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint);
  TglAlphaFragmentOp1ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint);
  TglAlphaFragmentOp2ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint);
  TglAlphaFragmentOp3ATI = PROCEDURE{C}(op: GLenum; dst: GLuint; dstMod: GLuint; arg1: GLuint; arg1Rep: GLuint; arg1Mod: GLuint; arg2: GLuint; arg2Rep: GLuint; arg2Mod: GLuint; arg3: GLuint; arg3Rep: GLuint; arg3Mod: GLuint);
  TglSetFragmentShaderConstantATI = PROCEDURE{C}(dst: GLuint;  value: PGLfloat);

  (* GL_ATI_map_object_buffer *)
  TglMapObjectBufferATI = PROCEDURE{C}(buffer: GLuint): PGLvoid;
  TglUnmapObjectBufferATI = PROCEDURE{C}(buffer: GLuint);

  (* GL_ATI_pn_triangles *)
  TglPNTrianglesiATI = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglPNTrianglesfATI = PROCEDURE{C}(pname: GLenum; param: GLfloat);

  (* GL_ATI_separate_stencil *)
  TglStencilOpSeparateATI = PROCEDURE{C}(face: GLenum; sfail: GLenum; dpfail: GLenum; dppass: GLenum);
  TglStencilFuncSeparateATI = PROCEDURE{C}(frontfunc: GLenum; backfunc: GLenum; ref: GLint; mask: GLuint);

  (* GL_ATI_vertex_array_object *)
  TglNewObjectBufferATI = PROCEDURE{C}(size: GLsizei;  xpointer: PGLvoid; usage: GLenum): GLuint;
  TglIsObjectBufferATI = PROCEDURE{C}(buffer: GLuint): GLboolean;
  TglUpdateObjectBufferATI = PROCEDURE{C}(buffer: GLuint; offset: GLuint; size: GLsizei;  xpointer: PGLvoid; preserve: GLenum);
  TglGetObjectBufferfvATI = PROCEDURE{C}(buffer: GLuint; pname: GLenum; params: PGLfloat);
  TglGetObjectBufferivATI = PROCEDURE{C}(buffer: GLuint; pname: GLenum; params: PGLint);
  TglFreeObjectBufferATI = PROCEDURE{C}(buffer: GLuint);
  TglArrayObjectATI = PROCEDURE{C}(xarray: GLenum; size: GLint; xtype: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetArrayObjectfvATI = PROCEDURE{C}(xarray: GLenum; pname: GLenum; params: PGLfloat);
  TglGetArrayObjectivATI = PROCEDURE{C}(xarray: GLenum; pname: GLenum; params: PGLint);
  TglVariantArrayObjectATI = PROCEDURE{C}(id: GLuint; xtype: GLenum; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetVariantArrayObjectfvATI = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVariantArrayObjectivATI = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint);

  (* GL_ATI_vertex_attrib_array_object *)
  TglVertexAttribArrayObjectATI = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei; buffer: GLuint; offset: GLuint);
  TglGetVertexAttribArrayObjectfvATI = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribArrayObjectivATI = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint);

  (* GL_ATI_vertex_streams *)
  TglVertexStream1sATI = PROCEDURE{C}(stream: GLenum; x: GLshort);
  TglVertexStream1svATI = PROCEDURE{C}(stream: GLenum;  coords: PGLshort);
  TglVertexStream1iATI = PROCEDURE{C}(stream: GLenum; x: GLint);
  TglVertexStream1ivATI = PROCEDURE{C}(stream: GLenum;  coords: PGLint);
  TglVertexStream1fATI = PROCEDURE{C}(stream: GLenum; x: GLfloat);
  TglVertexStream1fvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLfloat);
  TglVertexStream1dATI = PROCEDURE{C}(stream: GLenum; x: GLdouble);
  TglVertexStream1dvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLdouble);
  TglVertexStream2sATI = PROCEDURE{C}(stream: GLenum; x: GLshort; y: GLshort);
  TglVertexStream2svATI = PROCEDURE{C}(stream: GLenum;  coords: PGLshort);
  TglVertexStream2iATI = PROCEDURE{C}(stream: GLenum; x: GLint; y: GLint);
  TglVertexStream2ivATI = PROCEDURE{C}(stream: GLenum;  coords: PGLint);
  TglVertexStream2fATI = PROCEDURE{C}(stream: GLenum; x: GLfloat; y: GLfloat);
  TglVertexStream2fvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLfloat);
  TglVertexStream2dATI = PROCEDURE{C}(stream: GLenum; x: GLdouble; y: GLdouble);
  TglVertexStream2dvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLdouble);
  TglVertexStream3sATI = PROCEDURE{C}(stream: GLenum; x: GLshort; y: GLshort; z: GLshort);
  TglVertexStream3svATI = PROCEDURE{C}(stream: GLenum;  coords: PGLshort);
  TglVertexStream3iATI = PROCEDURE{C}(stream: GLenum; x: GLint; y: GLint; z: GLint);
  TglVertexStream3ivATI = PROCEDURE{C}(stream: GLenum;  coords: PGLint);
  TglVertexStream3fATI = PROCEDURE{C}(stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexStream3fvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLfloat);
  TglVertexStream3dATI = PROCEDURE{C}(stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexStream3dvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLdouble);
  TglVertexStream4sATI = PROCEDURE{C}(stream: GLenum; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexStream4svATI = PROCEDURE{C}(stream: GLenum;  coords: PGLshort);
  TglVertexStream4iATI = PROCEDURE{C}(stream: GLenum; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexStream4ivATI = PROCEDURE{C}(stream: GLenum;  coords: PGLint);
  TglVertexStream4fATI = PROCEDURE{C}(stream: GLenum; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexStream4fvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLfloat);
  TglVertexStream4dATI = PROCEDURE{C}(stream: GLenum; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexStream4dvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLdouble);
  TglNormalStream3bATI = PROCEDURE{C}(stream: GLenum; nx: GLbyte; ny: GLbyte; nz: GLbyte);
  TglNormalStream3bvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLbyte);
  TglNormalStream3sATI = PROCEDURE{C}(stream: GLenum; nx: GLshort; ny: GLshort; nz: GLshort);
  TglNormalStream3svATI = PROCEDURE{C}(stream: GLenum;  coords: PGLshort);
  TglNormalStream3iATI = PROCEDURE{C}(stream: GLenum; nx: GLint; ny: GLint; nz: GLint);
  TglNormalStream3ivATI = PROCEDURE{C}(stream: GLenum;  coords: PGLint);
  TglNormalStream3fATI = PROCEDURE{C}(stream: GLenum; nx: GLfloat; ny: GLfloat; nz: GLfloat);
  TglNormalStream3fvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLfloat);
  TglNormalStream3dATI = PROCEDURE{C}(stream: GLenum; nx: GLdouble; ny: GLdouble; nz: GLdouble);
  TglNormalStream3dvATI = PROCEDURE{C}(stream: GLenum;  coords: PGLdouble);
  TglClientActiveVertexStreamATI = PROCEDURE{C}(stream: GLenum);
  TglVertexBlendEnviATI = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglVertexBlendEnvfATI = PROCEDURE{C}(pname: GLenum; param: GLfloat);

  (* GL_AMD_performance_monitor *)
  TglGetPerfMonitorGroupsAMD = PROCEDURE{C}(numGroups: PGLint; groupsSize: GLsizei; groups: PGLuint);
  TglGetPerfMonitorCountersAMD = PROCEDURE{C}(group: GLuint; numCounters: PGLint; maxActiveCouters: PGLint; counterSize: GLsizei; counters: PGLuint);
  TglGetPerfMonitorGroupStringAMD = PROCEDURE{C}(group: GLuint; bufSize: GLsizei; length: PGLsizei; groupString: PGLchar);
  TglGetPerfMonitorCounterStringAMD = PROCEDURE{C}(group: GLuint; counter: GLuint; bufSize: GLsizei; length: PGLsizei; counterString: PGLchar);
  TglGetPerfMonitorCounterInfoAMD = PROCEDURE{C}(group: GLuint; counter: GLuint; pname: GLenum; data: Pointer);
  TglGenPerfMonitorsAMD = PROCEDURE{C}(n: GLsizei; monitors: PGLuint);
  TglDeletePerfMonitorsAMD = PROCEDURE{C}(n: GLsizei; monitors: PGLuint);
  TglSelectPerfMonitorCountersAMD = PROCEDURE{C}(monitor: GLuint; enable: GLboolean; group: GLuint; numCounters: GLint; counterList: PGLuint);
  TglBeginPerfMonitorAMD = PROCEDURE{C}(monitor: GLuint);
  TglEndPerfMonitorAMD = PROCEDURE{C}(monitor: GLuint);
  TglGetPerfMonitorCounterDataAMD = PROCEDURE{C}(monitor: GLuint; pname: GLenum; dataSize: GLsizei; data: PGLuint; bytesWritten: PGLint);

  (* GL_AMD_vertex_shader_tesselator *)
  TglTessellationFactorAMD = PROCEDURE{C}(factor: GLfloat);
  TglTessellationModeAMD = PROCEDURE{C}(mode: GLenum);

  (* GL_AMD_draw_buffers_blend *)
  TglBlendFuncIndexedAMD = PROCEDURE{C}(buf: GLuint; src: GLenum; dst: GLenum);
  TglBlendFuncSeparateIndexedAMD = PROCEDURE{C}(buf: GLuint; srcRGB: GLenum; dstRGB: GLenum; srcAlpha: GLenum; dstAlpha: GLenum);
  TglBlendEquationIndexedAMD = PROCEDURE{C}(buf: GLuint; mode: GLenum);
  TglBlendEquationSeparateIndexedAMD = PROCEDURE{C}(buf: GLuint; modeRGB: GLenum; modeAlpha: GLenum);

  (* GL_AMD_name_gen_delete *)
  TglGenNamesAMD = PROCEDURE{C}(identifier: GLenum; num: GLuint; names: PGLuint);
  TglDeleteNamesAMD = PROCEDURE{C}(identifier: GLenum; num: GLuint;  names: PGLuint);
  TglIsNameAMD = PROCEDURE{C}(identifier: GLenum; name: GLuint): GLboolean;

  (* GL_AMD_debug_output *)
  TglDebugMessageEnableAMD = PROCEDURE{C}(category: GLenum; severity: GLenum; count: GLsizei;  ids: PGLuint; enabled: GLboolean);
  TglDebugMessageInsertAMD = PROCEDURE{C}(category: GLenum; severity: GLenum; id: GLuint; length: GLsizei;  buf: PGLchar);
 (* TglDebugMessageCallbackAMD = PROCEDURE{C}(callback: TGLDebugProcAMD; userParam: PGLvoid);  *)
  TglGetDebugMessageLogAMD = PROCEDURE{C}(count: GLuint; bufsize: GLsizei; categories: PGLenum; severities: PGLuint; ids: PGLuint; lengths: PGLsizei; message: PGLchar): GLuint;

  (* GL_EXT_blend_color *)
  TglBlendColorEXT = PROCEDURE{C}(red: GLclampf; green: GLclampf; blue: GLclampf; alpha: GLclampf);

  (* GL_EXT_blend_func_separate *)
  TglBlendFuncSeparateEXT = PROCEDURE{C}(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);

  (* GL_EXT_blend_minmax *)
  TglBlendEquationEXT = PROCEDURE{C}(mode: GLenum);

  (* GL_EXT_color_subtable *)
  TglColorSubTableEXT = PROCEDURE{C}(target: GLenum; start: GLsizei; count: GLsizei; format: GLenum; xtype: GLenum;  data: PGLvoid);
  TglCopyColorSubTableEXT = PROCEDURE{C}(target: GLenum; start: GLsizei; x: GLint; y: GLint; width: GLsizei);

  (* GL_EXT_compiled_vertex_array *)
  TglLockArraysEXT = PROCEDURE{C}(first: GLint; count: GLsizei);
  TglUnlockArraysEXT = PROCEDURE{C}();

  (* GL_EXT_convolution *)
  TglConvolutionFilter1DEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglConvolutionFilter2DEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  image: PGLvoid);
  TglConvolutionParameterfEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: GLfloat);
  TglConvolutionParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglConvolutionParameteriEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: GLint);
  TglConvolutionParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglCopyConvolutionFilter1DEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglCopyConvolutionFilter2DEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetConvolutionFilterEXT = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; image: PGLvoid);
  TglGetConvolutionParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetConvolutionParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetSeparableFilterEXT = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; row: PGLvoid; column: PGLvoid; span: PGLvoid);
  TglSeparableFilter2DEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  row: PGLvoid;  column: PGLvoid);

  (* GL_EXT_coordinate_frame *)
  TglTangent3bEXT = PROCEDURE{C}(tx: GLbyte; ty: GLbyte; tz: GLbyte);
  TglTangent3bvEXT = PROCEDURE{C}( v: PGLbyte);
  TglTangent3dEXT = PROCEDURE{C}(tx: GLdouble; ty: GLdouble; tz: GLdouble);
  TglTangent3dvEXT = PROCEDURE{C}( v: PGLdouble);
  TglTangent3fEXT = PROCEDURE{C}(tx: GLfloat; ty: GLfloat; tz: GLfloat);
  TglTangent3fvEXT = PROCEDURE{C}( v: PGLfloat);
  TglTangent3iEXT = PROCEDURE{C}(tx: GLint; ty: GLint; tz: GLint);
  TglTangent3ivEXT = PROCEDURE{C}( v: PGLint);
  TglTangent3sEXT = PROCEDURE{C}(tx: GLshort; ty: GLshort; tz: GLshort);
  TglTangent3svEXT = PROCEDURE{C}( v: PGLshort);
  TglBinormal3bEXT = PROCEDURE{C}(bx: GLbyte; by: GLbyte; bz: GLbyte);
  TglBinormal3bvEXT = PROCEDURE{C}( v: PGLbyte);
  TglBinormal3dEXT = PROCEDURE{C}(bx: GLdouble; by: GLdouble; bz: GLdouble);
  TglBinormal3dvEXT = PROCEDURE{C}( v: PGLdouble);
  TglBinormal3fEXT = PROCEDURE{C}(bx: GLfloat; by: GLfloat; bz: GLfloat);
  TglBinormal3fvEXT = PROCEDURE{C}( v: PGLfloat);
  TglBinormal3iEXT = PROCEDURE{C}(bx: GLint; by: GLint; bz: GLint);
  TglBinormal3ivEXT = PROCEDURE{C}( v: PGLint);
  TglBinormal3sEXT = PROCEDURE{C}(bx: GLshort; by: GLshort; bz: GLshort);
  TglBinormal3svEXT = PROCEDURE{C}( v: PGLshort);
  TglTangentPointerEXT = PROCEDURE{C}(xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglBinormalPointerEXT = PROCEDURE{C}(xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_copy_texture *)
  TglCopyTexImage1DEXT = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTexImage2DEXT = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTexSubImage1DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTexSubImage2DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglCopyTexSubImage3DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);

  (* GL_EXT_cull_vertex *)
  TglCullParameterdvEXT = PROCEDURE{C}(pname: GLenum; params: PGLdouble);
  TglCullParameterfvEXT = PROCEDURE{C}(pname: GLenum; params: PGLfloat);

  (* GL_EXT_draw_range_elements *)
  TglDrawRangeElementsEXT = PROCEDURE{C}(mode: GLenum; start: GLuint; _end: GLuint; count: GLsizei; xtype: GLenum;  indices: PGLvoid);

  (* GL_EXT_fog_coord *)
  TglFogCoordfEXT = PROCEDURE{C}(coord: GLfloat);
  TglFogCoordfvEXT = PROCEDURE{C}( coord: PGLfloat);
  TglFogCoorddEXT = PROCEDURE{C}(coord: GLdouble);
  TglFogCoorddvEXT = PROCEDURE{C}( coord: PGLdouble);
  TglFogCoordPointerEXT = PROCEDURE{C}(xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_framebuffer_object *)
  TglIsRenderbufferEXT = PROCEDURE{C}(renderbuffer: GLuint): BOOLEAN;
  TglBindRenderbufferEXT = PROCEDURE{C}(target: GLenum; renderbuffer: GLuint);
  TglDeleteRenderbuffersEXT = PROCEDURE{C}(n: GLsizei;  renderbuffers: PGLuint);
  TglGenRenderbuffersEXT = PROCEDURE{C}(n: GLsizei; renderbuffers: PGLuint);
  TglRenderbufferStorageEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetRenderbufferParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglIsFramebufferEXT = PROCEDURE{C}(framebuffer: GLuint): BOOLEAN;
  TglBindFramebufferEXT = PROCEDURE{C}(target: GLenum; framebuffer: GLuint);
  TglDeleteFramebuffersEXT = PROCEDURE{C}(n: GLsizei;  framebuffers: PGLuint);
  TglGenFramebuffersEXT = PROCEDURE{C}(n: GLsizei; framebuffers: PGLuint);
  TglCheckFramebufferStatusEXT = PROCEDURE{C}(target: GLenum): GLenum;
  TglFramebufferTexture1DEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture2DEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglFramebufferTexture3DEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglFramebufferRenderbufferEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetFramebufferAttachmentParameterivEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateMipmapEXT = PROCEDURE{C}(target: GLenum);

  (* GL_EXT_histogram *)
  TglGetHistogramEXT = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetHistogramParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetHistogramParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetMinmaxEXT = PROCEDURE{C}(target: GLenum; reset: GLboolean; format: GLenum; xtype: GLenum; values: PGLvoid);
  TglGetMinmaxParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMinmaxParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglHistogramEXT = PROCEDURE{C}(target: GLenum; width: GLsizei; internalformat: GLenum; sink: GLboolean);
  TglMinmaxEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; sink: GLboolean);
  TglResetHistogramEXT = PROCEDURE{C}(target: GLenum);
  TglResetMinmaxEXT = PROCEDURE{C}(target: GLenum);

  (* GL_EXT_index_func *)
  TglIndexFuncEXT = PROCEDURE{C}(func: GLenum; ref: GLclampf);

  (* GL_EXT_index_material *)
  TglIndexMaterialEXT = PROCEDURE{C}(face: GLenum; mode: GLenum);

  (* GL_EXT_light_texture *)
  TglApplyTextureEXT = PROCEDURE{C}(mode: GLenum);
  TglTextureLightEXT = PROCEDURE{C}(pname: GLenum);
  TglTextureMaterialEXT = PROCEDURE{C}(face: GLenum; mode: GLenum);

  (* GL_EXT_multi_draw_arrays *)
  TglMultiDrawArraysEXT = PROCEDURE{C}(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei);
  TglMultiDrawElementsEXT = PROCEDURE{C}(mode: GLenum;  count: PGLsizei; xtype: GLenum;  indices: PGLvoid; primcount: GLsizei);

  (* GL_EXT_multisample *)
  TglSampleMaskEXT = PROCEDURE{C}(value: GLclampf; invert: GLboolean);
  TglSamplePatternEXT = PROCEDURE{C}(pattern: GLenum);

  (* GL_EXT_paletted_texture *)
  TglColorTableEXT = PROCEDURE{C}(target: GLenum; internalFormat: GLenum; width: GLsizei; format: GLenum; xtype: GLenum;  table: PGLvoid);
  TglGetColorTableEXT = PROCEDURE{C}(target: GLenum; format: GLenum; xtype: GLenum; data: PGLvoid);
  TglGetColorTableParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetColorTableParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_EXT_pixel_transform *)
  TglPixelTransformParameteriEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLint);
  TglPixelTransformParameterfEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLfloat);
  TglPixelTransformParameterivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglPixelTransformParameterfvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);

  (* GL_EXT_point_parameters *)
  TglPointParameterfEXT = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPointParameterfvEXT = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);

  (* GL_EXT_polygon_offset *)
  TglPolygonOffsetEXT = PROCEDURE{C}(factor: GLfloat; bias: GLfloat);

  (* GL_EXT_secondary_color *)
  TglSecondaryColor3bEXT = PROCEDURE{C}(red: GLbyte; green: GLbyte; blue: GLbyte);
  TglSecondaryColor3bvEXT = PROCEDURE{C}( v: PGLbyte);
  TglSecondaryColor3dEXT = PROCEDURE{C}(red: GLdouble; green: GLdouble; blue: GLdouble);
  TglSecondaryColor3dvEXT = PROCEDURE{C}( v: PGLdouble);
  TglSecondaryColor3fEXT = PROCEDURE{C}(red: GLfloat; green: GLfloat; blue: GLfloat);
  TglSecondaryColor3fvEXT = PROCEDURE{C}( v: PGLfloat);
  TglSecondaryColor3iEXT = PROCEDURE{C}(red: GLint; green: GLint; blue: GLint);
  TglSecondaryColor3ivEXT = PROCEDURE{C}( v: PGLint);
  TglSecondaryColor3sEXT = PROCEDURE{C}(red: GLshort; green: GLshort; blue: GLshort);
  TglSecondaryColor3svEXT = PROCEDURE{C}( v: PGLshort);
  TglSecondaryColor3ubEXT = PROCEDURE{C}(red: GLubyte; green: GLubyte; blue: GLubyte);
  TglSecondaryColor3ubvEXT = PROCEDURE{C}( v: PGLubyte);
  TglSecondaryColor3uiEXT = PROCEDURE{C}(red: GLuint; green: GLuint; blue: GLuint);
  TglSecondaryColor3uivEXT = PROCEDURE{C}( v: PGLuint);
  TglSecondaryColor3usEXT = PROCEDURE{C}(red: GLushort; green: GLushort; blue: GLushort);
  TglSecondaryColor3usvEXT = PROCEDURE{C}( v: PGLushort);
  TglSecondaryColorPointerEXT = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_stencil_two_side *)
  TglActiveStencilFaceEXT = PROCEDURE{C}(face: GLenum);

  (* GL_EXT_subtexture *)
  TglTexSubImage1DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage2DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);

  (* GL_EXT_texture3D *)
  TglTexImage3DEXT = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; xtype: GLenum;  pixels: PGLvoid);
  TglTexSubImage3DEXT = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; xtype: GLenum;  pixels: PGLvoid);

  (* GL_EXT_texture_object *)
  TglAreTexturesResidentEXT = PROCEDURE{C}(n: GLsizei;  textures: PGLuint; residences: PGLboolean): GLboolean;
  TglBindTextureEXT = PROCEDURE{C}(target: GLenum; texture: GLuint);
  TglDeleteTexturesEXT = PROCEDURE{C}(n: GLsizei;  textures: PGLuint);
  TglGenTexturesEXT = PROCEDURE{C}(n: GLsizei; textures: PGLuint);
  TglIsTextureEXT = PROCEDURE{C}(texture: GLuint): GLboolean;
  TglPrioritizeTexturesEXT = PROCEDURE{C}(n: GLsizei;  textures: PGLuint;  priorities: PGLclampf);

  (* GL_EXT_texture_perturb_normal *)
  TglTextureNormalEXT = PROCEDURE{C}(mode: GLenum);

  (* GL_EXT_vertex_array *)
  TglArrayElementEXT = PROCEDURE{C}(i: GLint);
  TglColorPointerEXT = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglDrawArraysEXT = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei);
  TglEdgeFlagPointerEXT = PROCEDURE{C}(stride: GLsizei; count: GLsizei;  xpointer: PGLboolean);
  TglGetPointervEXT = PROCEDURE{C}(pname: GLenum; params: PGLvoid);
  TglIndexPointerEXT = PROCEDURE{C}(xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglNormalPointerEXT = PROCEDURE{C}(xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglTexCoordPointerEXT = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);
  TglVertexPointerEXT = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei; count: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_vertex_shader *)
  TglBeginVertexShaderEXT = PROCEDURE{C}();
  TglEndVertexShaderEXT = PROCEDURE{C}();
  TglBindVertexShaderEXT = PROCEDURE{C}(id: GLuint);
  TglGenVertexShadersEXT = PROCEDURE{C}(range: GLuint): GLuint;
  TglDeleteVertexShaderEXT = PROCEDURE{C}(id: GLuint);
  TglShaderOp1EXT = PROCEDURE{C}(op: GLenum; res: GLuint; arg1: GLuint);
  TglShaderOp2EXT = PROCEDURE{C}(op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint);
  TglShaderOp3EXT = PROCEDURE{C}(op: GLenum; res: GLuint; arg1: GLuint; arg2: GLuint; arg3: GLuint);
  TglSwizzleEXT = PROCEDURE{C}(res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum);
  TglWriteMaskEXT = PROCEDURE{C}(res: GLuint; _in: GLuint; outX: GLenum; outY: GLenum; outZ: GLenum; outW: GLenum);
  TglInsertComponentEXT = PROCEDURE{C}(res: GLuint; src: GLuint; num: GLuint);
  TglExtractComponentEXT = PROCEDURE{C}(res: GLuint; src: GLuint; num: GLuint);
  TglGenSymbolsEXT = PROCEDURE{C}(datatype: GLenum; storagetype: GLenum; range: GLenum; components: GLuint): GLuint;
  TglSetInvariantEXT = PROCEDURE{C}(id: GLuint; xtype: GLenum;  addr: PGLvoid);
  TglSetLocalConstantEXT = PROCEDURE{C}(id: GLuint; xtype: GLenum;  addr: PGLvoid);
  TglVariantbvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLbyte);
  TglVariantsvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLshort);
  TglVariantivEXT = PROCEDURE{C}(id: GLuint;  addr: PGLint);
  TglVariantfvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLfloat);
  TglVariantdvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLdouble);
  TglVariantubvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLubyte);
  TglVariantusvEXT = PROCEDURE{C}(id: GLuint;  addr: PGLushort);
  TglVariantuivEXT = PROCEDURE{C}(id: GLuint;  addr: PGLuint);
  TglVariantPointerEXT = PROCEDURE{C}(id: GLuint; xtype: GLenum; stride: GLuint;  addr: PGLvoid);
  TglEnableVariantClientStateEXT = PROCEDURE{C}(id: GLuint);
  TglDisableVariantClientStateEXT = PROCEDURE{C}(id: GLuint);
  TglBindLightParameterEXT = PROCEDURE{C}(light: GLenum; value: GLenum): GLuint;
  TglBindMaterialParameterEXT = PROCEDURE{C}(face: GLenum; value: GLenum): GLuint;
  TglBindTexGenParameterEXT = PROCEDURE{C}(xunit: GLenum; coord: GLenum; value: GLenum): GLuint;
  TglBindTextureUnitParameterEXT = PROCEDURE{C}( xunit: GLenum; value: GLenum): GLuint;
  TglBindParameterEXT = PROCEDURE{C}(value: GLenum): GLuint;
  TglIsVariantEnabledEXT = PROCEDURE{C}(id: GLuint; cap: GLenum): GLboolean;
  TglGetVariantBooleanvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLboolean);
  TglGetVariantIntegervEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLint);
  TglGetVariantFloatvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLfloat);
  TglGetVariantPointervEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLvoid);
  TglGetInvariantBooleanvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLboolean);
  TglGetInvariantIntegervEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLint);
  TglGetInvariantFloatvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLfloat);
  TglGetLocalConstantBooleanvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLboolean);
  TglGetLocalConstantIntegervEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLint);
  TglGetLocalConstantFloatvEXT = PROCEDURE{C}(id: GLuint; value: GLenum; data: PGLfloat);

  (* GL_EXT_vertex_weighting *)
  TglVertexWeightfEXT = PROCEDURE{C}(weight: GLfloat);
  TglVertexWeightfvEXT = PROCEDURE{C}( weight: PGLfloat);
  TglVertexWeightPointerEXT = PROCEDURE{C}(size: GLsizei; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);

  (* GL_EXT_stencil_clear_tag *)
  TglStencilClearTagEXT = PROCEDURE{C}(stencilTagBits: GLsizei; stencilClearTag: GLuint);

  (* GL_EXT_framebuffer_blit *)
  TglBlitFramebufferEXT = PROCEDURE{C}(srcX0: GLint; srcY0: GLint; srcX1: GLint; srcY1: GLint; dstX0: GLint; dstY0: GLint; dstX1: GLint; dstY1: GLint; mask: GLbitfield; filter: GLenum);

  (* GL_EXT_framebuffer_multisample *)
  TglRenderbufferStorageMultisampleEXT = PROCEDURE{C}(target: GLenum; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);

  (* GL_EXT_timer_query *)
  TglGetQueryObjecti64vEXT = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetQueryObjectui64vEXT = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLuint64EXT);

  (* GL_EXT_gpu_program_parameters *)
  TglProgramEnvParameters4fvEXT = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLfloat);
  TglProgramLocalParameters4fvEXT = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLfloat);

  (* GL_EXT_bindable_uniform *)
  TglUniformBufferEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; buffer: GLuint);
  TglGetUniformBufferSizeEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint): GLint;
  TglGetUniformOffsetEXT = PROCEDURE{C}( xprogram: GLuint; location: GLint): PGLint;

  (* GL_EXT_draw_buffers2 *)
  TglColorMaskIndexedEXT = PROCEDURE{C}(buf: GLuint; r: GLboolean; g: GLboolean; b: GLboolean; a: GLboolean);
  TglGetBooleanIndexedvEXT = PROCEDURE{C}(value: GLenum; index: GLuint; data: PGLboolean);
  TglGetIntegerIndexedvEXT = PROCEDURE{C}(value: GLenum; index: GLuint; data: PGLint);
  TglEnableIndexedEXT = PROCEDURE{C}(target: GLenum; index: GLuint);
  TglDisableIndexedEXT = PROCEDURE{C}(target: GLenum; index: GLuint);
  TglIsEnabledIndexedEXT = PROCEDURE{C}(target: GLenum; index: GLuint): GLboolean;

  (* GL_EXT_draw_instanced *)
  TglDrawArraysInstancedEXT = PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei; primcount: GLsizei);
  TglDrawElementsInstancedEXT = PROCEDURE{C}(mode: GLenum; count: GLsizei; xtype: GLenum;  indices: Pointer; primcount: GLsizei);

  (* GL_EXT_geometry_shader4 *)
  TglProgramParameteriEXT = PROCEDURE{C}(xprogram: GLuint; pname: GLenum; value: GLint);
  TglFramebufferTextureEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint);
(*  TglFramebufferTextureLayerEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);  *)
  TglFramebufferTextureFaceEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);

  (* GL_EXT_gpu_shader4 *)
  TglVertexAttribI1iEXT = PROCEDURE{C}(index: GLuint; x: GLint);
  TglVertexAttribI2iEXT = PROCEDURE{C}(index: GLuint; x: GLint; y: GLint);
  TglVertexAttribI3iEXT = PROCEDURE{C}(index: GLuint; x: GLint; y: GLint; z: GLint);
  TglVertexAttribI4iEXT = PROCEDURE{C}(index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglVertexAttribI1uiEXT = PROCEDURE{C}(index: GLuint; x: GLuint);
  TglVertexAttribI2uiEXT = PROCEDURE{C}(index: GLuint; x: GLuint; y: GLuint);
  TglVertexAttribI3uiEXT = PROCEDURE{C}(index: GLuint; x: GLuint; y: GLuint; z: GLuint);
  TglVertexAttribI4uiEXT = PROCEDURE{C}(index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglVertexAttribI1ivEXT = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttribI2ivEXT = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttribI3ivEXT = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttribI4ivEXT = PROCEDURE{C}(index: GLuint;  v: PGLint);
  TglVertexAttribI1uivEXT = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttribI2uivEXT = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttribI3uivEXT = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttribI4uivEXT = PROCEDURE{C}(index: GLuint;  v: PGLuint);
  TglVertexAttribI4bvEXT = PROCEDURE{C}(index: GLuint;  v: PGLbyte);
  TglVertexAttribI4svEXT = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttribI4ubvEXT = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttribI4usvEXT = PROCEDURE{C}(index: GLuint;  v: PGLushort);
  TglVertexAttribIPointerEXT = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; stride: GLsizei;  xpointer: Pointer);
  TglGetVertexAttribIivEXT = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribIuivEXT = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLuint);
  TglUniform1uiEXT = PROCEDURE{C}(location: GLint; v0: GLuint);
  TglUniform2uiEXT = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint);
  TglUniform3uiEXT = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglUniform4uiEXT = PROCEDURE{C}(location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglUniform1uivEXT = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform2uivEXT = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform3uivEXT = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglUniform4uivEXT = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint);
  TglGetUniformuivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; params: PGLuint);
  TglBindFragDataLocationEXT = PROCEDURE{C}(xprogram: GLuint; colorNumber: GLuint; CONST name: ARRAY OF CHAR);
  TglGetFragDataLocationEXT = PROCEDURE{C}(xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;

  (* GL_EXT_texture_array *)
  TglFramebufferTextureLayerEXT = PROCEDURE{C}(target: GLenum; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);

  (* GL_EXT_texture_buffer_object *)
  TglTexBufferEXT = PROCEDURE{C}(target: GLenum; internalformat: GLenum; buffer: GLuint);

  (* GL_EXT_texture_integer *)
  TglClearColorIiEXT = PROCEDURE{C}(r: GLint; g: GLint; b: GLint; a: GLint);
  TglClearColorIuiEXT = PROCEDURE{C}(r: GLuint; g: GLuint; b: GLuint; a: GLuint);
  TglTexParameterIivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglTexParameterIuivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLuint);
  TglGetTexParameterIivEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetTexParameterIiuvEXT = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLuint);

  (* GL_HP_image_transform *)
  TglImageTransformParameteriHP = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLint);
  TglImageTransformParameterfHP = PROCEDURE{C}(target: GLenum; pname: GLenum; param: GLfloat);
  TglImageTransformParameterivHP = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglImageTransformParameterfvHP = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetImageTransformParameterivHP = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetImageTransformParameterfvHP = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_EXT_depth_bounds_test *)
  TglDepthBoundsEXT = PROCEDURE{C}(zmin: GLclampd; zmax: GLclampd);

  (* GL_EXT_blend_equation_separate *)
  TglBlendEquationSeparateEXT = PROCEDURE{C}(modeRGB: GLenum; modeAlpha: GLenum);

  (* GL_EXT_transform_feedback *)
  TglBeginTransformFeedbackEXT = PROCEDURE{C}(primitiveMode: GLenum);
  TglEndTransformFeedbackEXT = PROCEDURE{C}();
  TglBindBufferRangeEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei; size: GLsizei);
  TglBindBufferOffsetEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; buffer: GLuint; offset: GLsizei);
  TglBindBufferBaseEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryingsEXT = PROCEDURE{C}(xprogram: GLuint; count: GLsizei;  locations: PGLint; bufferMode: GLenum);
  TglGetTransformFeedbackVaryingEXT = PROCEDURE{C}(xprogram: GLuint; index_: GLuint; location: PGLint);

  (* GL_EXT_direct_state_access *)
  TglClientAttribDefaultEXT = PROCEDURE{C}(mask: GLbitfield);
  TglPushClientAttribDefaultEXT = PROCEDURE{C}(mask: GLbitfield);
  TglMatrixLoadfEXT = PROCEDURE{C}(mode: GLenum;  m: PGLfloat);
  TglMatrixLoaddEXT = PROCEDURE{C}(mode: GLenum;  m: PGLdouble);
  TglMatrixMultfEXT = PROCEDURE{C}(mode: GLenum;  m: PGLfloat);
  TglMatrixMultdEXT = PROCEDURE{C}(mode: GLenum;  m: PGLdouble);
  TglMatrixLoadIdentityEXT = PROCEDURE{C}(mode: GLenum);
  TglMatrixRotatefEXT = PROCEDURE{C}(mode: GLenum; angle: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixRotatedEXT = PROCEDURE{C}(mode: GLenum; angle: GLdouble; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixScalefEXT = PROCEDURE{C}(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixScaledEXT = PROCEDURE{C}(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixTranslatefEXT = PROCEDURE{C}(mode: GLenum; x: GLfloat; y: GLfloat; z: GLfloat);
  TglMatrixTranslatedEXT = PROCEDURE{C}(mode: GLenum; x: GLdouble; y: GLdouble; z: GLdouble);
  TglMatrixFrustumEXT = PROCEDURE{C}(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglMatrixOrthoEXT = PROCEDURE{C}(mode: GLenum; left: GLdouble; right: GLdouble; bottom: GLdouble; top: GLdouble; zNear: GLdouble; zFar: GLdouble);
  TglMatrixPopEXT = PROCEDURE{C}(mode: GLenum);
  TglMatrixPushEXT = PROCEDURE{C}(mode: GLenum);
  TglMatrixLoadTransposefEXT = PROCEDURE{C}(mode: GLenum;  m: PGLfloat);
  TglMatrixLoadTransposedEXT = PROCEDURE{C}(mode: GLenum;  m: PGLdouble);
  TglMatrixMultTransposefEXT = PROCEDURE{C}(mode: GLenum;  m: PGLfloat);
  TglMatrixMultTransposedEXT = PROCEDURE{C}(mode: GLenum;  m: PGLdouble);
  TglTextureParameterfEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; param: GLfloat);
  TglTextureParameterfvEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglTextureParameteriEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; param: GLint);
  TglTextureParameterivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglTextureImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyTextureImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyTextureImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyTextureSubImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyTextureSubImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetTextureImageEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);
  TglGetTextureParameterfvEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetTextureParameterivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetTextureLevelParameterfvEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetTextureLevelParameterivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; pname: GLenum; params: GLint);
  TglTextureImage3DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglTextureSubImage3DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyTextureSubImage3DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglMultiTexParameterfEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexParameterfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexParameteriEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexParameterivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglCopyMultiTexImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; border: GLint);
  TglCopyMultiTexImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei; height: GLsizei; border: GLint);
  TglCopyMultiTexSubImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; x: GLint; y: GLint; width: GLsizei);
  TglCopyMultiTexSubImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglGetMultiTexImageEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; format: GLenum; type_: GLenum; pixels: PGLvoid);
  TglGetMultiTexParameterfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexParameterivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexLevelParameterfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLfloat);
  TglGetMultiTexLevelParameterivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; pname: GLenum; params: PGLint);
  TglMultiTexImage3DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; format: GLenum; type_: GLenum;  pixels: PGLvoid);
  TglMultiTexSubImage3DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; type_: GLenum;  pixels:PGLvoid);
  TglCopyMultiTexSubImage3DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; x: GLint; y: GLint; width: GLsizei; height: GLsizei);
  TglBindMultiTextureEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; texture: GLuint);
  TglEnableClientStateIndexedEXT = PROCEDURE{C}(array_: GLenum; index_: GLuint);
  TglDisableClientStateIndexedEXT = PROCEDURE{C}(array_: GLenum; index_: GLuint);
  TglMultiTexCoordPointerEXT = PROCEDURE{C}(texunit: GLenum; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglMultiTexEnvfEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexEnvfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexEnviEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexEnvivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexGendEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLdouble);
  TglMultiTexGendvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLdouble);
  TglMultiTexGenfEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLfloat);
  TglMultiTexGenfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLfloat);
  TglMultiTexGeniEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; param: GLint);
  TglMultiTexGenivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum;  params: PGLint);
  TglGetMultiTexEnvfvEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexEnvivEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexGendvEXT = PROCEDURE{C}(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLdouble);
  TglGetMultiTexGenfvEXT = PROCEDURE{C}(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMultiTexGenivEXT = PROCEDURE{C}(texunit: GLenum; coord: GLenum; pname: GLenum; params: PGLint);
  TglGetFloatIndexedvEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PGLfloat);
  TglGetDoubleIndexedvEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PGLdouble);
  TglGetPointerIndexedvEXT = PROCEDURE{C}(target: GLenum; index_: GLuint; data: PPGLvoid);
  TglCompressedTextureImage3DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage3DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage2DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedTextureSubImage1DEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglGetCompressedTextureImageEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; lod: GLint; img: PGLvoid);
  TglCompressedMultiTexImage3DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; border: GLint; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage3DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage2DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; width: GLsizei; height: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglCompressedMultiTexSubImage1DEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; level: GLint; xoffset: GLint; width: GLsizei; format: GLenum; imageSize: GLsizei;  bits: PGLvoid);
  TglGetCompressedMultiTexImageEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; lod: GLint; img: PGLvoid);
  TglNamedProgramStringEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; format: GLenum; len: GLsizei;  string_: PGLvoid);
  TglNamedProgramLocalParameter4dEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglNamedProgramLocalParameter4dvEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLdouble);
  TglNamedProgramLocalParameter4fEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglNamedProgramLocalParameter4fvEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLfloat);
  TglGetNamedProgramLocalParameterdvEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLdouble);
  TglGetNamedProgramLocalParameterfvEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLfloat);
  TglGetNamedProgramivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetNamedProgramStringEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; pname: GLenum; string_: PGLvoid);
  TglNamedProgramLocalParameters4fvEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLfloat);
  TglNamedProgramLocalParameterI4iEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglNamedProgramLocalParameterI4ivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLint);
  TglNamedProgramLocalParametersI4ivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLint);
  TglNamedProgramLocalParameterI4uiEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglNamedProgramLocalParameterI4uivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint;  params: PGLuint);
  TglNamedProgramLocalParametersI4uivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; count: GLsizei;  params: PGLuint);
  TglGetNamedProgramLocalParameterIivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLint);
  TglGetNamedProgramLocalParameterIuivEXT = PROCEDURE{C}(xprogram: GLuint; target: GLenum; index_: GLuint; params: PGLuint);
  TglTextureParameterIivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglTextureParameterIuivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetTextureParameterIivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetTextureParameterIuivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);
  TglMultiTexParameterIivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLint);
  TglMultiTexParameterIuivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum;  params: PGLuint);
  TglGetMultiTexParameterIivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLint);
  TglGetMultiTexParameterIuivEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; pname: GLenum; params: PGLuint);
  TglProgramUniform1fEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat);
  TglProgramUniform2fEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat);
  TglProgramUniform3fEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat);
  TglProgramUniform4fEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLfloat; v1: GLfloat; v2: GLfloat; v3: GLfloat);
  TglProgramUniform1iEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint);
  TglProgramUniform2iEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint);
  TglProgramUniform3iEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint);
  TglProgramUniform4iEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLint; v1: GLint; v2: GLint; v3: GLint);
  TglProgramUniform1fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform2fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform3fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform4fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLfloat);
  TglProgramUniform1ivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform2ivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform3ivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniform4ivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint);
  TglProgramUniformMatrix2fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x3fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x2fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix2x4fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x2fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix3x4fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniformMatrix4x3fvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLfloat);
  TglProgramUniform1uiEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint);
  TglProgramUniform2uiEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint);
  TglProgramUniform3uiEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint);
  TglProgramUniform4uiEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; v0: GLuint; v1: GLuint; v2: GLuint; v3: GLuint);
  TglProgramUniform1uivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform2uivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform3uivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglProgramUniform4uivEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint);
  TglNamedBufferDataEXT = PROCEDURE{C}(buffer: GLuint; size: GLsizei;  data: PGLvoid; usage: GLenum);
  TglNamedBufferSubDataEXT = PROCEDURE{C}(buffer: GLuint; offset: GLintptr; size: GLsizeiptr;  data: PGLvoid);
  TglMapNamedBufferEXT = PROCEDURE{C}(buffer: GLuint; access: GLenum): PGLvoid;
  TglUnmapNamedBufferEXT = PROCEDURE{C}(buffer: GLuint): GLboolean;
  TglMapNamedBufferRangeEXT = PROCEDURE{C}(buffer: GLuint; offset: GLintptr; length: GLsizeiptr; access: GLbitfield): PGLvoid;
  TglFlushMappedNamedBufferRangeEXT = PROCEDURE{C}(buffer: GLuint; offset: GLintptr; length: GLsizeiptr);
  TglNamedCopyBufferSubDataEXT = PROCEDURE{C}(readBuffer: GLuint; writeBuffer: GLuint; readOffset: GLintptr; writeOffset: GLintptr; size: GLsizeiptr);
  TglGetNamedBufferParameterivEXT = PROCEDURE{C}(buffer: GLuint; pname: GLenum; params: PGLint);
  TglGetNamedBufferPointervEXT = PROCEDURE{C}(buffer: GLuint; pname: GLenum; params: PPGLvoid);
  TglGetNamedBufferSubDataEXT = PROCEDURE{C}(buffer: GLuint; offset: GLintptr; size: GLsizeiptr; data: PGLvoid);
  TglTextureBufferEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; internalformat: GLenum; buffer: GLuint);
  TglMultiTexBufferEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; interformat: GLenum; buffer: GLuint);
  TglNamedRenderbufferStorageEXT = PROCEDURE{C}(renderbuffer: GLuint; interformat: GLenum; width: GLsizei; height: GLsizei);
  TglGetNamedRenderbufferParameterivEXT = PROCEDURE{C}(renderbuffer: GLuint; pname: GLenum; params: PGLint);
  TglCheckNamedFramebufferStatusEXT = PROCEDURE{C}(framebuffer: GLuint; target: GLenum): GLenum;
  TglNamedFramebufferTexture1DEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTexture2DEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTexture3DEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; textarget: GLenum; texture: GLuint; level: GLint; zoffset: GLint);
  TglNamedFramebufferRenderbufferEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; renderbuffertarget: GLenum; renderbuffer: GLuint);
  TglGetNamedFramebufferAttachmentParameterivEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; pname: GLenum; params: PGLint);
  TglGenerateTextureMipmapEXT = PROCEDURE{C}(texture: GLuint; target: GLenum);
  TglGenerateMultiTexMipmapEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum);
  TglFramebufferDrawBufferEXT = PROCEDURE{C}(framebuffer: GLuint; mode: GLenum);
  TglFramebufferDrawBuffersEXT = PROCEDURE{C}(framebuffer: GLuint; n: GLsizei;  bufs: PGLenum);
  TglFramebufferReadBufferEXT = PROCEDURE{C}(framebuffer: GLuint; mode: GLenum);
  TglGetFramebufferParameterivEXT = PROCEDURE{C}(framebuffer: GLuint; pname: GLenum; params: PGLint);
  TglNamedRenderbufferStorageMultisampleEXT = PROCEDURE{C}(renderbuffer: GLuint; samples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglNamedRenderbufferStorageMultisampleCoverageEXT = PROCEDURE{C}(renderbuffer: GLuint; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);
  TglNamedFramebufferTextureEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint);
  TglNamedFramebufferTextureLayerEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; layer: GLint);
  TglNamedFramebufferTextureFaceEXT = PROCEDURE{C}(framebuffer: GLuint; attachment: GLenum; texture: GLuint; level: GLint; face: GLenum);
  TglTextureRenderbufferEXT = PROCEDURE{C}(texture: GLuint; target: GLenum; renderbuffer: GLuint);
  TglMultiTexRenderbufferEXT = PROCEDURE{C}(texunit: GLenum; target: GLenum; renderbuffer: GLuint);
  TglProgramUniform1dEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLdouble);
  TglProgramUniform2dEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble);
  TglProgramUniform3dEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglProgramUniform4dEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramUniform1dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform2dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform3dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniform4dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLdouble);
  TglProgramUniformMatrix2dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x3dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix2x4dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x2dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix3x4dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x2dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);
  TglProgramUniformMatrix4x3dvEXT = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei; transpose: GLboolean;  value: PGLdouble);

  (* GL_EXT_separate_shader_objects *)
  TglUseShaderProgramEXT = PROCEDURE{C}(xtype: GLenum; xprogram: GLuint);
  TglActiveProgramEXT = PROCEDURE{C}(xprogram: GLuint);
  TglCreateShaderProgramEXT = PROCEDURE{C}(xtype: GLenum; CONST xstring: ARRAY OF CHAR): GLuint;

   (* GL_EXT_shader_image_load_store *)
  TglBindImageTextureEXT = PROCEDURE{C}(index: GLuint; texture: GLuint; level: GLint; layered: GLboolean; layer: GLint; access: GLenum; format: GLint);
  TglMemoryBarrierEXT = PROCEDURE{C}(barriers: GLbitfield);

  (* GL_EXT_vertex_attrib_64bit *)
  TglVertexAttribL1dEXT = PROCEDURE{C}(index: GLuint; x: GLdouble);
  TglVertexAttribL2dEXT = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttribL3dEXT = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttribL4dEXT = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttribL1dvEXT = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL2dvEXT = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL3dvEXT = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribL4dvEXT = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttribLPointerEXT = PROCEDURE{C}(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei;  pointer: PGLvoid);
  TglGetVertexAttribLdvEXT = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLdouble);
  TglVertexArrayVertexAttribLOffsetEXT = PROCEDURE{C}(vaobj: GLuint; buffer: GLuint; index: GLuint; size: GLint; type_: GLenum; stride: GLsizei; offset: GLintptr);

(***************************)
  (*  GL_IBM_multimode_draw_arrays *)
  TglMultiModeDrawArraysIBM = PROCEDURE{C}(mode: GLenum; first: PGLint; count: PGLsizei; primcount: GLsizei; modestride: GLint);
  TglMultiModeDrawElementsIBM = PROCEDURE{C}(mode: PGLenum; count: PGLsizei; xtype:  GLenum; indices: PGLvoid; primcount: GLsizei; modestride: GLint);

  (*  GL_IBM_vertex_array_lists *)
  TglColorPointerListIBM = PROCEDURE{C}(size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglSecondaryColorPointerListIBM = PROCEDURE{C}(size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglEdgeFlagPointerListIBM = PROCEDURE{C}(stride: GLint; xpointer: PGLboolean; ptrstride: GLint);
  TglFogCoordPointerListIBM = PROCEDURE{C}(xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglIndexPointerListIBM = PROCEDURE{C}(xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglNormalPointerListIBM = PROCEDURE{C}(xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglTexCoordPointerListIBM = PROCEDURE{C}(size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);
  TglVertexPointerListIBM = PROCEDURE{C}(size: GLint; xtype:  GLenum; stride: GLint; xpointer: PGLvoid; ptrstride: GLint);

  (*  GL_INGR_blend_func_separate *)
  TglBlendFuncSeparateINGR = PROCEDURE{C}(sfactorRGB: GLenum; dfactorRGB: GLenum; sfactorAlpha: GLenum; dfactorAlpha: GLenum);

  (*  GL_INTEL_parallel_arrays *)
  TglVertexPointervINTEL = PROCEDURE{C}(size: GLint; xtype:  GLenum; xpointer: PGLvoid);
  TglNormalPointervINTEL = PROCEDURE{C}(xtype:  GLenum; xpointer: PGLvoid);
  TglColorPointervINTEL = PROCEDURE{C}(size: GLint; xtype:  GLenum; xpointer: PGLvoid);
  TglTexCoordPointervINTEL = PROCEDURE{C}(size: GLint; xtype:  GLenum; xpointer: PGLvoid);


(***************************)
  (*  GL_MESA_resize_buffers *)
  TglResizeBuffersMESA = PROCEDURE{C}();

  (* GL_MESA_window_pos *)
  TglWindowPos2dMESA = PROCEDURE{C}(x: GLdouble; y: GLdouble);
  TglWindowPos2dvMESA = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos2fMESA = PROCEDURE{C}(x: GLfloat; y: GLfloat);
  TglWindowPos2fvMESA = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos2iMESA = PROCEDURE{C}(x: GLint; y: GLint);
  TglWindowPos2ivMESA = PROCEDURE{C}( v: PGLint);
  TglWindowPos2sMESA = PROCEDURE{C}(x: GLshort; y: GLshort);
  TglWindowPos2svMESA = PROCEDURE{C}( v: PGLshort);
  TglWindowPos3dMESA = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble);
  TglWindowPos3dvMESA = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos3fMESA = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat);
  TglWindowPos3fvMESA = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos3iMESA = PROCEDURE{C}(x: GLint; y: GLint; z: GLint);
  TglWindowPos3ivMESA = PROCEDURE{C}( v: PGLint);
  TglWindowPos3sMESA = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort);
  TglWindowPos3svMESA = PROCEDURE{C}( v: PGLshort);
  TglWindowPos4dMESA = PROCEDURE{C}(x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglWindowPos4dvMESA = PROCEDURE{C}( v: PGLdouble);
  TglWindowPos4fMESA = PROCEDURE{C}(x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglWindowPos4fvMESA = PROCEDURE{C}( v: PGLfloat);
  TglWindowPos4iMESA = PROCEDURE{C}(x: GLint; y: GLint; z: GLint; w: GLint);
  TglWindowPos4ivMESA = PROCEDURE{C}( v: PGLint);
  TglWindowPos4sMESA = PROCEDURE{C}(x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglWindowPos4svMESA = PROCEDURE{C}( v: PGLshort);

  (* GL_NV_evaluators *)
  TglMapControlPointsNV = PROCEDURE{C}(target: GLenum; index: GLuint; xtype: GLenum; ustride: GLsizei; vstride: GLsizei; uorder: GLint; vorder: GLint; _packed: GLboolean;  points: PGLvoid);
  TglMapParameterivNV = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLint);
  TglMapParameterfvNV = PROCEDURE{C}(target: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetMapControlPointsNV = PROCEDURE{C}(target: GLenum; index: GLuint; xtype: GLenum; ustride: GLsizei; vstride: GLsizei; _packed: GLboolean; points: PGLvoid);
  TglGetMapParameterivNV = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglGetMapParameterfvNV = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetMapAttribParameterivNV = PROCEDURE{C}(target: GLenum; index: GLuint; pname: GLenum; params: PGLint);
  TglGetMapAttribParameterfvNV = PROCEDURE{C}(target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat);
  TglEvalMapsNV = PROCEDURE{C}(target: GLenum; mode: GLenum);

  (* GL_NV_fence *)
  TglDeleteFencesNV = PROCEDURE{C}(n: GLsizei;  fences: PGLuint);
  TglGenFencesNV = PROCEDURE{C}(n: GLsizei; fences: PGLuint);
  TglIsFenceNV = PROCEDURE{C}(fence: GLuint): GLboolean;
  TglTestFenceNV = PROCEDURE{C}(fence: GLuint): GLboolean;
  TglGetFenceivNV = PROCEDURE{C}(fence: GLuint; pname: GLenum; params: PGLint);
  TglFinishFenceNV = PROCEDURE{C}(fence: GLuint);
  TglSetFenceNV = PROCEDURE{C}(fence: GLuint; condition: GLenum);

  (* GL_NV_fragment_program *)
  TglProgramNamedParameter4fNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramNamedParameter4dNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramNamedParameter4fvNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR;  v: PGLfloat);
  TglProgramNamedParameter4dvNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR;  v: PGLdouble);
  TglGetProgramNamedParameterfvNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; params: PGLfloat);
  TglGetProgramNamedParameterdvNV = PROCEDURE{C}(id: GLuint; len: GLsizei; CONST name: ARRAY OF CHAR; params: PGLdouble);

  (* GL_NV_half_float *)
  TglVertex2hNV = PROCEDURE{C}(x: TGLhalfNV; y: TGLhalfNV);
  TglVertex2hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglVertex3hNV = PROCEDURE{C}(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV);
  TglVertex3hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglVertex4hNV = PROCEDURE{C}(x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV);
  TglVertex4hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglNormal3hNV = PROCEDURE{C}(nx: TGLhalfNV; ny: TGLhalfNV; nz: TGLhalfNV);
  TglNormal3hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglColor3hNV = PROCEDURE{C}(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV);
  TglColor3hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglColor4hNV = PROCEDURE{C}(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV; alpha: TGLhalfNV);
  TglColor4hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglTexCoord1hNV = PROCEDURE{C}(s: TGLhalfNV);
  TglTexCoord1hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglTexCoord2hNV = PROCEDURE{C}(s: TGLhalfNV; t: TGLhalfNV);
  TglTexCoord2hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglTexCoord3hNV = PROCEDURE{C}(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV);
  TglTexCoord3hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglTexCoord4hNV = PROCEDURE{C}(s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV);
  TglTexCoord4hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglMultiTexCoord1hNV = PROCEDURE{C}(target: GLenum; s: TGLhalfNV);
  TglMultiTexCoord1hvNV = PROCEDURE{C}(target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord2hNV = PROCEDURE{C}(target: GLenum; s: TGLhalfNV; t: TGLhalfNV);
  TglMultiTexCoord2hvNV = PROCEDURE{C}(target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord3hNV = PROCEDURE{C}(target: GLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV);
  TglMultiTexCoord3hvNV = PROCEDURE{C}(target: GLenum;  v: PGLhalfNV);
  TglMultiTexCoord4hNV = PROCEDURE{C}(target: GLenum; s: TGLhalfNV; t: TGLhalfNV; r: TGLhalfNV; q: TGLhalfNV);
  TglMultiTexCoord4hvNV = PROCEDURE{C}(target: GLenum;  v: PGLhalfNV);
  TglFogCoordhNV = PROCEDURE{C}(fog: TGLhalfNV);
  TglFogCoordhvNV = PROCEDURE{C}( fog: PGLhalfNV);
  TglSecondaryColor3hNV = PROCEDURE{C}(red: TGLhalfNV; green: TGLhalfNV; blue: TGLhalfNV);
  TglSecondaryColor3hvNV = PROCEDURE{C}( v: PGLhalfNV);
  TglVertexWeighthNV = PROCEDURE{C}(weight: TGLhalfNV);
  TglVertexWeighthvNV = PROCEDURE{C}( weight: PGLhalfNV);
  TglVertexAttrib1hNV = PROCEDURE{C}(index: GLuint; x: TGLhalfNV);
  TglVertexAttrib1hvNV = PROCEDURE{C}(index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib2hNV = PROCEDURE{C}(index: GLuint; x: TGLhalfNV; y: TGLhalfNV);
  TglVertexAttrib2hvNV = PROCEDURE{C}(index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib3hNV = PROCEDURE{C}(index: GLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV);
  TglVertexAttrib3hvNV = PROCEDURE{C}(index: GLuint;  v: PGLhalfNV);
  TglVertexAttrib4hNV = PROCEDURE{C}(index: GLuint; x: TGLhalfNV; y: TGLhalfNV; z: TGLhalfNV; w: TGLhalfNV);
  TglVertexAttrib4hvNV = PROCEDURE{C}(index: GLuint;  v: PGLhalfNV);
  TglVertexAttribs1hvNV = PROCEDURE{C}(index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs2hvNV = PROCEDURE{C}(index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs3hvNV = PROCEDURE{C}(index: GLuint; n: GLsizei;  v: PGLhalfNV);
  TglVertexAttribs4hvNV = PROCEDURE{C}(index: GLuint; n: GLsizei;  v: PGLhalfNV);

  (* GL_NV_occlusion_query *)
  TglGenOcclusionQueriesNV = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglDeleteOcclusionQueriesNV = PROCEDURE{C}(n: GLsizei;  ids: PGLuint);
  TglIsOcclusionQueryNV = PROCEDURE{C}(id: GLuint): GLboolean;
  TglBeginOcclusionQueryNV = PROCEDURE{C}(id: GLuint);
  TglEndOcclusionQueryNV = PROCEDURE{C}();
  TglGetOcclusionQueryivNV = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint);
  TglGetOcclusionQueryuivNV = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLuint);

  (* GL_NV_pixel_data_range *)
  TglPixelDataRangeNV = PROCEDURE{C}(target: GLenum; length: GLsizei; xpointer: PGLvoid);
  TglFlushPixelDataRangeNV = PROCEDURE{C}(target: GLenum);

  (* GL_NV_point_sprite *)
  TglPointParameteriNV = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglPointParameterivNV = PROCEDURE{C}(pname: GLenum;  params: PGLint);

  (* GL_NV_primitive_restart *)
  TglPrimitiveRestartNV = PROCEDURE{C}();
  TglPrimitiveRestartIndexNV = PROCEDURE{C}(index: GLuint);

  (* GL_NV_register_combiners *)
  TglCombinerParameterfvNV = PROCEDURE{C}(pname: GLenum;  params: PGLfloat);
  TglCombinerParameterfNV = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglCombinerParameterivNV = PROCEDURE{C}(pname: GLenum;  params: PGLint);
  TglCombinerParameteriNV = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglCombinerInputNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum);
  TglCombinerOutputNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; abOutput: GLenum; cdOutput: GLenum; sumOutput: GLenum; scale: GLenum; bias: GLenum; abDotProduct: GLboolean; cdDotProduct: GLboolean; muxSum: GLboolean);
  TglFinalCombinerInputNV = PROCEDURE{C}(variable: GLenum; input: GLenum; mapping: GLenum; componentUsage: GLenum);
  TglGetCombinerInputParameterfvNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLfloat);
  TglGetCombinerInputParameterivNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; variable: GLenum; pname: GLenum; params: PGLint);
  TglGetCombinerOutputParameterfvNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; pname: GLenum; params: PGLfloat);
  TglGetCombinerOutputParameterivNV = PROCEDURE{C}(stage: GLenum; portion: GLenum; pname: GLenum; params: PGLint);
  TglGetFinalCombinerInputParameterfvNV = PROCEDURE{C}(variable: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFinalCombinerInputParameterivNV = PROCEDURE{C}(variable: GLenum; pname: GLenum; params: PGLint);

  (* GL_NV_register_combiners2*)
  TglCombinerStageParameterfvNV = PROCEDURE{C}(stage: GLenum; pname: GLenum;  params: PGLfloat);
  TglGetCombinerStageParameterfvNV = PROCEDURE{C}(stage: GLenum; pname: GLenum; params: PGLfloat);

  (* GL_NV_vertex_array_range *)
  TglFlushVertexArrayRangeNV = PROCEDURE{C}();
  TglVertexArrayRangeNV = PROCEDURE{C}(length: GLsizei;  xpointer: PGLvoid);

  (* GL_NV_vertex_program *)
  TglAreProgramsResidentNV = PROCEDURE{C}(n: GLsizei;  programs: PGLuint; residences: PGLboolean): GLboolean;
  TglBindProgramNV = PROCEDURE{C}(target: GLenum; id: GLuint);
  TglDeleteProgramsNV = PROCEDURE{C}(n: GLsizei;  programs: PGLuint);
  TglExecuteProgramNV = PROCEDURE{C}(target: GLenum; id: GLuint;  params: PGLfloat);
  TglGenProgramsNV = PROCEDURE{C}(n: GLsizei; programs: PGLuint);
  TglGetProgramParameterdvNV = PROCEDURE{C}(target: GLenum; index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetProgramParameterfvNV = PROCEDURE{C}(target: GLenum; index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetProgramivNV = PROCEDURE{C}(id: GLuint; pname: GLenum; params: PGLint);
  TglGetProgramStringNV = PROCEDURE{C}(id: GLuint; pname: GLenum; xprogram: PGLubyte);
  TglGetTrackMatrixivNV = PROCEDURE{C}(target: GLenum; address: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribdvNV = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLdouble);
  TglGetVertexAttribfvNV = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVertexAttribivNV = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint);
  TglGetVertexAttribPointervNV = PROCEDURE{C}(index: GLuint; pname: GLenum; xpointer: PGLvoid);
  TglIsProgramNV = PROCEDURE{C}(id: GLuint): GLboolean;
  TglLoadProgramNV = PROCEDURE{C}(target: GLenum; id: GLuint; len: GLsizei;  xprogram: PGLubyte);
  TglProgramParameter4dNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglProgramParameter4dvNV = PROCEDURE{C}(target: GLenum; index: GLuint;  v: PGLdouble);
  TglProgramParameter4fNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglProgramParameter4fvNV = PROCEDURE{C}(target: GLenum; index: GLuint;  v: PGLfloat);
  TglProgramParameters4dvNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLuint;  v: PGLdouble);
  TglProgramParameters4fvNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLuint;  v: PGLfloat);
  TglRequestResidentProgramsNV = PROCEDURE{C}(n: GLsizei;  programs: PGLuint);
  TglTrackMatrixNV = PROCEDURE{C}(target: GLenum; address: GLuint; matrix: GLenum; transform: GLenum);
  TglVertexAttribPointerNV = PROCEDURE{C}(index: GLuint; fsize: GLint; xtype: GLenum; stride: GLsizei;  xpointer: PGLvoid);
  TglVertexAttrib1dNV = PROCEDURE{C}(index: GLuint; x: GLdouble);
  TglVertexAttrib1dvNV = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib1fNV = PROCEDURE{C}(index: GLuint; x: GLfloat);
  TglVertexAttrib1fvNV = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib1sNV = PROCEDURE{C}(index: GLuint; x: GLshort);
  TglVertexAttrib1svNV = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib2dNV = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble);
  TglVertexAttrib2dvNV = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib2fNV = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat);
  TglVertexAttrib2fvNV = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib2sNV = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort);
  TglVertexAttrib2svNV = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib3dNV = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble);
  TglVertexAttrib3dvNV = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib3fNV = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglVertexAttrib3fvNV = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib3sNV = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort);
  TglVertexAttrib3svNV = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4dNV = PROCEDURE{C}(index: GLuint; x: GLdouble; y: GLdouble; z: GLdouble; w: GLdouble);
  TglVertexAttrib4dvNV = PROCEDURE{C}(index: GLuint;  v: PGLdouble);
  TglVertexAttrib4fNV = PROCEDURE{C}(index: GLuint; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglVertexAttrib4fvNV = PROCEDURE{C}(index: GLuint;  v: PGLfloat);
  TglVertexAttrib4sNV = PROCEDURE{C}(index: GLuint; x: GLshort; y: GLshort; z: GLshort; w: GLshort);
  TglVertexAttrib4svNV = PROCEDURE{C}(index: GLuint;  v: PGLshort);
  TglVertexAttrib4ubNV = PROCEDURE{C}(index: GLuint; x: GLubyte; y: GLubyte; z: GLubyte; w: GLubyte);
  TglVertexAttrib4ubvNV = PROCEDURE{C}(index: GLuint;  v: PGLubyte);
  TglVertexAttribs1dvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs1fvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs1svNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs2dvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs2fvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs2svNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs3dvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs3fvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs3svNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs4dvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLdouble);
  TglVertexAttribs4fvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLfloat);
  TglVertexAttribs4svNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLshort);
  TglVertexAttribs4ubvNV = PROCEDURE{C}(index: GLuint; count: GLsizei;  v: PGLubyte);

  (* GL_NV_depth_buffer_float *)
  TglDepthRangedNV = PROCEDURE{C}(n: GLdouble; f: GLdouble);
  TglClearDepthdNV = PROCEDURE{C}(d: GLdouble);
  TglDepthBoundsdNV = PROCEDURE{C}(zmin: GLdouble; zmax: GLdouble);

  (* GL_NV_framebuffer_multisample_coverage *)
  TglRenderbufferStorageMultsampleCoverageNV = PROCEDURE{C}(target: GLenum; coverageSamples: GLsizei; colorSamples: GLsizei; internalformat: GLenum; width: GLsizei; height: GLsizei);

  (* GL_NV_geometry_program4 *)
  TglProgramVertexLimitNV = PROCEDURE{C}(target: GLenum; limit: GLint);

  (* GL_NV_gpu_program4 *)
  TglProgramLocalParameterI4iNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglProgramLocalParameterI4ivNV = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLint);
  TglProgramLocalParametersI4ivNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLint);
  TglProgramLocalParameterI4uiNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglProgramLocalParameterI4uivNV = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLuint);
  TglProgramLocalParametersI4uivNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLuint);
  TglProgramEnvParameterI4iNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLint; y: GLint; z: GLint; w: GLint);
  TglProgramEnvParameterI4ivNV = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLint);
  TglProgramEnvParametersI4ivNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLint);
  TglProgramEnvParameterI4uiNV = PROCEDURE{C}(target: GLenum; index: GLuint; x: GLuint; y: GLuint; z: GLuint; w: GLuint);
  TglProgramEnvParameterI4uivNV = PROCEDURE{C}(target: GLenum; index: GLuint;  params: PGLuint);
  TglProgramEnvParametersI4uivNV = PROCEDURE{C}(target: GLenum; index: GLuint; count: GLsizei;  params: PGLuint);
  TglGetProgramLocalParameterIivNV = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLint);
  TglGetProgramLocalParameterIuivNV = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLuint);
  TglGetProgramEnvParameterIivNV = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLint);
  TglGetProgramEnvParameterIuivNV = PROCEDURE{C}(target: GLenum; index: GLuint; params: PGLuint);

  (* GL_NV_parameter_buffer_object *)
  TglProgramBufferParametersfvNV = PROCEDURE{C}(target: GLenum; buffer: GLuint; index: GLuint; count: GLsizei;  params: PGLfloat);
  TglProgramBufferParametersIivNV = PROCEDURE{C}(target: GLenum; buffer: GLuint; index: GLuint; count: GLsizei;  params: GLint);
  TglProgramBufferParametersIuivNV = PROCEDURE{C}(target: GLenum; buffer: GLuint; index: GLuint; count: GLuint;  params: PGLuint);

  (* GL_NV_transform_feedback *)
  TglBeginTransformFeedbackNV = PROCEDURE{C}(primitiveMode: GLenum);
  TglEndTransformFeedbackNV = PROCEDURE{C}();
  TglTransformFeedbackAttribsNV = PROCEDURE{C}(count: GLsizei;  attribs: GLint; bufferMode: GLenum);
  TglBindBufferRangeNV = PROCEDURE{C}(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint; size: GLsizei);
  TglBindBufferOffsetNV = PROCEDURE{C}(target: GLenum; index: GLuint; buffer: GLuint; offset: GLint);
  TglBindBufferBaseNV = PROCEDURE{C}(target: GLenum; index: GLuint; buffer: GLuint);
  TglTransformFeedbackVaryingsNV = PROCEDURE{C}(xprogram: GLuint; count: GLsizei;  varyings: PPGLchar; bufferMode: GLenum);
  TglActiveVaryingNV = PROCEDURE{C}(xprogram: GLuint; CONST name: ARRAY OF CHAR);
  TglGetVaryingLocationNV = PROCEDURE{C}(xprogram: GLuint; CONST name: ARRAY OF CHAR): GLint;
  TglGetActiveVaryingNV = PROCEDURE{C}(xprogram: GLuint; index: GLuint; bufSize: GLsizei; length: PGLsizei; size: PGLsizei; xtype: PGLenum; name: PGLchar);
  TglGetTransformFeedbackVaryingNV = PROCEDURE{C}(xprogram: GLuint; index: GLuint; location: PGLint);
   TglTransformFeedbackStreamAttribsNV = PROCEDURE{C}(count: GLsizei;  attribs: PGLint; nbuffers: GLsizei;  bufstreams: PGLint; bufferMode: GLenum);

  (* GL_NV_conditional_render *)
  TglBeginConditionalRenderNV = PROCEDURE{C}(id: GLuint; mode: GLenum);
  TglEndConditionalRenderNV = PROCEDURE{C}();

  (* GL_NV_present_video *)
  TglPresentFrameKeyedNV = PROCEDURE{C}(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDuratioId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; key0: GLuint; target1: GLenum; fill1: GLuint; key1: GLuint);
  TglPresentFrameDualFillNV = PROCEDURE{C}(video_slot: GLuint; minPresentTime: GLuint64EXT; BeginPresentTimeId: GLuint; presentDurationId: GLuint; type_: GLenum; target0: GLenum; fill0: GLuint; target1: GLenum; fill1: GLuint; target2: GLenum; fill2: GLuint; target3: GLenum; fill3: GLuint);
  TglGetVideoivNV = PROCEDURE{C}(video_slot: GLuint; pname: GLenum; params: PGLint);
  TglGetVideouivNV = PROCEDURE{C}(video_slot: GLuint; pname: GLenum; params: PGLuint);
  TglGetVideoi64vNV = PROCEDURE{C}(video_slot: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetVideoui64vNV = PROCEDURE{C}(video_slot: GLuint; pname: GLenum; params: PGLuint64EXT);
(*  TglVideoParameterivNV = PROCEDURE{C}(video_slot: GLuint; pname: GLenum;  params: PGLint);  *)

  (* GL_NV_explicit_multisample *)
  TglGetMultisamplefvNV = PROCEDURE{C}(pname: GLenum; index: GLuint; val: PGLfloat);
  TglSampleMaskIndexedNV = PROCEDURE{C}(index: GLuint; mask: GLbitfield);
  TglTexRenderbufferNV = PROCEDURE{C}(target: GLenum; renderbuffer: GLuint);

  (* GL_NV_transform_feedback2 *)
  TglBindTransformFeedbackNV = PROCEDURE{C}(target: GLenum; id: GLuint);
  TglDeleteTransformFeedbacksNV = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglGenTransformFeedbacksNV = PROCEDURE{C}(n: GLsizei; ids: PGLuint);
  TglIsTransformFeedbackNV = PROCEDURE{C}(id: GLuint): GLboolean;
  TglPauseTransformFeedbackNV = PROCEDURE{C}();
  TglResumeTransformFeedbackNV = PROCEDURE{C}();
  TglDrawTransformFeedbackNV = PROCEDURE{C}(mode: GLenum; id: GLuint);

  (* GL_NV_video_capture *)
  TglBeginVideoCaptureNV = PROCEDURE{C}(video_capture_slot: GLuint);
  TglBindVideoCaptureStreamBufferNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; offset: GLsizei);
  TglBindVideoCaptureStreamTextureNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; frame_region: GLenum; target: GLenum; texture: GLuint);
  TglEndVideoCaptureNV = PROCEDURE{C}(video_capture_slot: GLuint);
  TglGetVideoCaptureivNV = PROCEDURE{C}(video_capture_slot: GLuint; pname: GLenum; params: PGLint);
  TglGetVideoCaptureStreamivNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLint);
  TglGetVideoCaptureStreamfvNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLfloat);
  TglGetVideoCaptureStreamdvNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum; params: PGLdouble);
  TglVideoCaptureNV = PROCEDURE{C}(video_capture_slot: GLuint; sequence_num: PGLuint; capture_time: PGLuint64EXT): GLenum;
  TglVideoCaptureStreamParameterivNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLint);
  TglVideoCaptureStreamParameterfvNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLfloat);
  TglVideoCaptureStreamParameterdvNV = PROCEDURE{C}(video_capture_slot: GLuint; stream: GLuint; pname: GLenum;  params: PGLdouble);

  (* GL_NV_copy_image *)
  TglCopyImageSubDataNV = PROCEDURE{C}(srcName: GLuint; srcTarget: GLenum; srcLevel: GLint; srcX: GLint; srcY: GLint; srcZ: GLint; dstName: GLuint; dstTarget: GLenum; dstLevel: GLint; dstX: GLint; dstY: GLint; dstZ: GLint; width: GLsizei; height: GLsizei; depth: GLsizei);

    (* GL_NV_shader_buffer_load *)
  TglMakeBufferResidentNV = PROCEDURE{C}(target: GLenum; access: GLenum);
  TglMakeBufferNonResidentNV = PROCEDURE{C}(target: GLenum);
  TglIsBufferResidentNV = PROCEDURE{C}(target: GLenum): GLboolean;
  TglMakeNamedBufferResidentNV = PROCEDURE{C}(buffer: GLuint; access: GLenum);
  TglMakeNamedBufferNonResidentNV = PROCEDURE{C}(buffer: GLuint);
  TglIsNamedBufferResidentNV = PROCEDURE{C}(buffer: GLuint): GLboolean;
  TglGetBufferParameterui64vNV = PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLuint64EXT);
  TglGetNamedBufferParameterui64vNV = PROCEDURE{C}(buffer: GLuint; pname: GLenum; params: PGLuint64EXT);
  TglGetIntegerui64vNV = PROCEDURE{C}(value: GLenum; result: PGLuint64EXT);
  TglUniformui64NV = PROCEDURE{C}(location: GLint; value: GLuint64EXT);
  TglUniformui64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglGetUniformui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; params: PGLuint64EXT);
  TglProgramUniformui64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; value: GLuint64EXT);
  TglProgramUniformui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);

  (* GL_NV_vertex_buffer_unified_memory *)
  TglBufferAddressRangeNV = PROCEDURE{C}(pname: GLenum; index: GLuint; adress: GLuint64EXT; length: GLsizei);
  TglVertexFormatNV = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei);
  TglNormalFormatNV = PROCEDURE{C}(xtype: GLenum; stride: GLsizei);
  TglColorFormatNV = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei);
  TglIndexFormatNV = PROCEDURE{C}(xtype: GLenum; stride: GLsizei);
  TglTexCoordFormatNV = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei);
  TglEdgeFlagFormatNV = PROCEDURE{C}(stride: GLsizei);
  TglSecondaryColorFormatNV = PROCEDURE{C}(size: GLint; xtype: GLenum; stride: GLsizei);
  TglFogCoordFormatNV = PROCEDURE{C}(xtype: GLenum; stride: GLsizei);
  TglVertexAttribFormatNV = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; normalized: GLboolean; stride: GLsizei);
  TglVertexAttribIFormatNV = PROCEDURE{C}(index: GLuint; size: GLint; xtype: GLenum; stride: GLsizei);
  TglGetIntegerui64i_vNV = PROCEDURE{C}(value: GLenum; index: GLuint; Result: PGLuint64EXT);

   (* GL_NV_gpu_program5 *)
  TglProgramSubroutineParametersuivNV = PROCEDURE{C}(target: GLenum; count: GLsizei;  params: PGLuint);
  TglGetProgramSubroutineParameteruivNV = PROCEDURE{C}(target: GLenum; index: GLuint; param: PGLuint);

    (*  GL_NV_gpu_shader5 *)
  TglUniform1i64NV = PROCEDURE{C}(location: GLint; x: GLint64EXT);
  TglUniform2i64NV = PROCEDURE{C}(location: GLint; x: GLint64EXT; y: GLint64EXT);
  TglUniform3i64NV = PROCEDURE{C}(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglUniform4i64NV = PROCEDURE{C}(location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglUniform1i64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform2i64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform3i64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform4i64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglUniform1ui64NV = PROCEDURE{C}(location: GLint; x: GLuint64EXT);
  TglUniform2ui64NV = PROCEDURE{C}(location: GLint; x: GLuint64EXT; y: GLuint64EXT);
  TglUniform3ui64NV = PROCEDURE{C}(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglUniform4ui64NV = PROCEDURE{C}(location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglUniform1ui64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform2ui64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform3ui64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglUniform4ui64vNV = PROCEDURE{C}(location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglGetUniformi64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; params: PGLint64EXT);
  TglProgramUniform1i64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLint64EXT);
  TglProgramUniform2i64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT);
  TglProgramUniform3i64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglProgramUniform4i64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglProgramUniform1i64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform2i64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform3i64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform4i64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLint64EXT);
  TglProgramUniform1ui64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLuint64EXT);
  TglProgramUniform2ui64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT);
  TglProgramUniform3ui64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglProgramUniform4ui64NV = PROCEDURE{C}(xprogram: GLuint; location: GLint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglProgramUniform1ui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform2ui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform3ui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);
  TglProgramUniform4ui64vNV = PROCEDURE{C}(xprogram: GLuint; location: GLint; count: GLsizei;  value: PGLuint64EXT);

  (* GL_NV_vertex_attrib_integer_64bit *)
  TglVertexAttribL1i64NV = PROCEDURE{C}(index: GLuint; x: GLint64EXT);
  TglVertexAttribL2i64NV = PROCEDURE{C}(index: GLuint; x: GLint64EXT; y: GLint64EXT);
  TglVertexAttribL3i64NV = PROCEDURE{C}(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT);
  TglVertexAttribL4i64NV = PROCEDURE{C}(index: GLuint; x: GLint64EXT; y: GLint64EXT; z: GLint64EXT; w: GLint64EXT);
  TglVertexAttribL1i64vNV = PROCEDURE{C}(index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL2i64vNV = PROCEDURE{C}(index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL3i64vNV = PROCEDURE{C}(index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL4i64vNV = PROCEDURE{C}(index: GLuint;  v: PGLint64EXT);
  TglVertexAttribL1ui64NV = PROCEDURE{C}(index: GLuint; x: GLuint64EXT);
  TglVertexAttribL2ui64NV = PROCEDURE{C}(index: GLuint; x: GLuint64EXT; y: GLuint64EXT);
  TglVertexAttribL3ui64NV = PROCEDURE{C}(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT);
  TglVertexAttribL4ui64NV = PROCEDURE{C}(index: GLuint; x: GLuint64EXT; y: GLuint64EXT; z: GLuint64EXT; w: GLuint64EXT);
  TglVertexAttribL1ui64vNV = PROCEDURE{C}(index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL2ui64vNV = PROCEDURE{C}(index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL3ui64vNV = PROCEDURE{C}(index: GLuint;  v: PGLuint64EXT);
  TglVertexAttribL4ui64vNV = PROCEDURE{C}(index: GLuint;  v: PGLuint64EXT);
  TglGetVertexAttribLi64vNV = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLint64EXT);
  TglGetVertexAttribLui64vNV = PROCEDURE{C}(index: GLuint; pname: GLenum; params: PGLuint64EXT);
  TglVertexAttribLFormatNV = PROCEDURE{C}(index: GLuint; size: GLint; type_: GLenum; stride: GLsizei);

  (* GL_NV_vdpau_interop *)
  TglVDPAUInitNV = PROCEDURE{C}( vdpDevice: PGLvoid;  getProcAddress: PGLvoid);
  TglVDPAUFiniNV = PROCEDURE{C};
  TglVDPAURegisterVideoSurfaceNV = PROCEDURE{C}(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei;  textureNames: PGLuint): GLvdpauSurfaceNV;
  TglVDPAURegisterOutputSurfaceNV = PROCEDURE{C}(vdpSurface: PGLvoid; target: GLenum; numTextureNames: GLsizei;  textureNames: PGLuint): GLvdpauSurfaceNV;
  TglVDPAUIsSurfaceNV = PROCEDURE{C}(surface: GLvdpauSurfaceNV);
  TglVDPAUUnregisterSurfaceNV = PROCEDURE{C}(surface: GLvdpauSurfaceNV);
  TglVDPAUGetSurfaceivNV = PROCEDURE{C}(surface: GLvdpauSurfaceNV; pname: GLenum; bufSize: GLsizei; length: PGLsizei; values: PGLint);
  TglVDPAUSurfaceAccessNV = PROCEDURE{C}(surface: GLvdpauSurfaceNV; access: GLenum);
  TglVDPAUMapSurfacesNV = PROCEDURE{C}(numSurfaces: GLsizei;  surfaces: PGLvdpauSurfaceNV);
  TglVDPAUUnmapSurfacesNV = PROCEDURE{C}(numSurface: GLsizei;  surfaces: PGLvdpauSurfaceNV);

  (* GL_NV_texture_barrier *)
  TglTextureBarrierNV = PROCEDURE{C};
(********************************************************)
 (*  GL_PGI_misc_hints *)
  TglHintPGI = PROCEDURE{C}(target: GLenum; mode: GLint);

  (*  GL_SGIS_detail_texture *)
  TglDetailTexFuncSGIS = PROCEDURE{C}(target: GLenum; n: GLsizei; points: PGLfloat);
  TglGetDetailTexFuncSGIS = PROCEDURE{C}(target: GLenum; points: PGLfloat);

  (*  GL_SGIS_fog_function *)
  TglFogFuncSGIS = PROCEDURE{C}(n: GLsizei; points: PGLfloat);
  TglGetFogFuncSGIS = PROCEDURE{C}(points: PGLfloat);

  (*  GL_SGIS_multisample *)
  TglSampleMaskSGIS = PROCEDURE{C}(value: GLclampf; invert: GLboolean);
  TglSamplePatternSGIS = PROCEDURE{C}(pattern: GLenum);

  (*  GL_SGIS_pixel_texture *)
  TglPixelTexGenParameteriSGIS = PROCEDURE{C}(pname: GLenum; param: GLint);
  TglPixelTexGenParameterivSGIS = PROCEDURE{C}(pname: GLenum; params: PGLint);
  TglPixelTexGenParameterfSGIS = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPixelTexGenParameterfvSGIS = PROCEDURE{C}(pname: GLenum; params: PGLfloat);
  TglGetPixelTexGenParameterivSGIS = PROCEDURE{C}(pname: GLenum; params: PGLint);
  TglGetPixelTexGenParameterfvSGIS = PROCEDURE{C}(pname: GLenum; params: PGLfloat);

  (*  GL_SGIS_point_parameters *)
  TglPointParameterfSGIS = PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglPointParameterfvSGIS = PROCEDURE{C}(pname: GLenum; params: PGLfloat);

  (*  GL_SGIS_sharpen_texture *)
  TglSharpenTexFuncSGIS = PROCEDURE{C}(target: GLenum; n: GLsizei; points: PGLfloat);
  TglGetSharpenTexFuncSGIS = PROCEDURE{C}(target: GLenum; points: PGLfloat);

  (*  GL_SGIS_texture4D *)
  TglTexImage4DSGIS = PROCEDURE{C}(target: GLenum; level: GLint; internalformat: GLenum; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; border: GLint; format: GLenum; xtype:  GLenum; pixels: PGLvoid);
  TglTexSubImage4DSGIS = PROCEDURE{C}(target: GLenum; level: GLint; xoffset: GLint; yoffset: GLint; zoffset: GLint; woffset: GLint; width: GLsizei; height: GLsizei; depth: GLsizei; size4d: GLsizei; format: GLenum; xtype:  GLenum; pixels: PGLvoid);

  (*  GL_SGIS_texture_color_mask *)
  TglTextureColorMaskSGIS = PROCEDURE{C}(red: GLboolean; green: GLboolean; blue: GLboolean; alpha: GLboolean);

  (*  GL_SGIS_texture_filter4 *)
  TglGetTexFilterFuncSGIS = PROCEDURE{C}(target: GLenum; filter: GLenum; weights: PGLfloat);
  TglTexFilterFuncSGIS = PROCEDURE{C}(target: GLenum; filter: GLenum; n: GLsizei; weights: PGLfloat);

  (*  GL_SGIX_async *)
  TglAsyncMarkerSGIX = PROCEDURE{C}(marker: GLuint);
  TglFinishAsyncSGIX = PROCEDURE{C}(markerp: PGLuint): GLint;
  TglPollAsyncSGIX = PROCEDURE{C}(markerp: PGLuint): GLint;
  TglGenAsyncMarkersSGIX = PROCEDURE{C}(range: GLsizei): GLuint;
  TglDeleteAsyncMarkersSGIX = PROCEDURE{C}(marker: GLuint; range: GLsizei);
  TglIsAsyncMarkerSGIX = PROCEDURE{C}(marker: GLuint): GLboolean;

  (*  GL_SGIX_flush_raster *)
  TglFlushRasterSGIX= PROCEDURE{C}();

  (*  GL_SGIX_fragment_lighting *)
  TglFragmentColorMaterialSGIX= PROCEDURE{C}(face: GLenum; mode: GLenum);
  TglFragmentLightfSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; param: GLfloat);
  TglFragmentLightfvSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLfloat);
  TglFragmentLightiSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; param: GLint);
  TglFragmentLightivSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLint);
  TglFragmentLightModelfSGIX= PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglFragmentLightModelfvSGIX= PROCEDURE{C}(pname: GLenum; params: PGLfloat);
  TglFragmentLightModeliSGIX= PROCEDURE{C}(pname: GLenum; param: GLint);
  TglFragmentLightModelivSGIX= PROCEDURE{C}(pname: GLenum; params: PGLint);
  TglFragmentMaterialfSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; param: GLfloat);
  TglFragmentMaterialfvSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLfloat);
  TglFragmentMaterialiSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; param: GLint);
  TglFragmentMaterialivSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLint);
  TglGetFragmentLightfvSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFragmentLightivSGIX= PROCEDURE{C}(light: GLenum; pname: GLenum; params: PGLint);
  TglGetFragmentMaterialfvSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLfloat);
  TglGetFragmentMaterialivSGIX= PROCEDURE{C}(face: GLenum; pname: GLenum; params: PGLint);
  TglLightEnviSGIX= PROCEDURE{C}(pname: GLenum; param: GLint);

  (*  GL_SGIX_framezoom *)
  TglFrameZoomSGIX= PROCEDURE{C}(factor: GLint);

  (*  GL_SGIX_igloo_interface *)
  TglIglooInterfaceSGIX= PROCEDURE{C}(pname: GLenum; params: PGLvoid);

  (*  GL_SGIX_instruments *)
  TglGetInstrumentsSGIX = PROCEDURE{C}(): GLint;
  TglInstrumentsBufferSGIX= PROCEDURE{C}(size: GLsizei; buffer: PGLint);
  TglPollInstrumentsSGIX = PROCEDURE{C}(marker_p: PGLint): GLint;
  TglReadInstrumentsSGIX= PROCEDURE{C}(marker: GLint);
  TglStartInstrumentsSGIX= PROCEDURE{C}();
  TglStopInstrumentsSGIX= PROCEDURE{C}(marker: GLint);

  (*  GL_SGIX_list_priority *)
  TglGetListParameterfvSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; params: PGLfloat);
  TglGetListParameterivSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; params: PGLint);
  TglListParameterfSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; param: GLfloat);
  TglListParameterfvSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; params: PGLfloat);
  TglListParameteriSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; param: GLint);
  TglListParameterivSGIX= PROCEDURE{C}(list: GLuint; pname: GLenum; params: PGLint);

  (*  GL_SGIX_pixel_texture *)
  TglPixelTexGenSGIX= PROCEDURE{C}(mode: GLenum);

  (*  GL_SGIX_polynomial_ffd *)
  TglDeformationMap3dSGIX= PROCEDURE{C}(target: GLenum; u1: GLdouble; u2: GLdouble; ustride: GLint; uorder: GLint; v1: GLdouble; v2: GLdouble; vstride: GLint; vorder: GLint; w1: GLdouble; w2: GLdouble; wstride: GLint; worder: GLint; points: PGLdouble);
  TglDeformationMap3fSGIX= PROCEDURE{C}(target: GLenum; u1: GLfloat; u2: GLfloat; ustride: GLint; uorder: GLint; v1: GLfloat; v2: GLfloat; vstride: GLint; vorder: GLint; w1: GLfloat; w2: GLfloat; wstride: GLint; worder: GLint; points: PGLfloat);
  TglDeformSGIX= PROCEDURE{C}(mask: GLbitfield);
  TglLoadIdentityDeformationMapSGIX= PROCEDURE{C}(mask: GLbitfield);

  (*  GL_SGIX_reference_plane *)
  TglReferencePlaneSGIX= PROCEDURE{C}( equation: PGLdouble);

  (*  GL_SGIX_sprite *)
  TglSpriteParameterfSGIX= PROCEDURE{C}(pname: GLenum; param: GLfloat);
  TglSpriteParameterfvSGIX= PROCEDURE{C}(pname: GLenum; params: PGLfloat);
  TglSpriteParameteriSGIX= PROCEDURE{C}(pname: GLenum; param: GLint);
  TglSpriteParameterivSGIX= PROCEDURE{C}(pname: GLenum; params: PGLint);

  (*  GL_SGIX_tag_sample_buffer *)
  TglTagSampleBufferSGIX= PROCEDURE{C}();

  (*  GL_SGI_color_table *)
  TglColorTableSGI= PROCEDURE{C}(target: GLenum; internalformat: GLenum; width: GLsizei; format: GLenum; xtype:  GLenum; table: PGLvoid);
  TglColorTableParameterfvSGI= PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglColorTableParameterivSGI= PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);
  TglCopyColorTableSGI= PROCEDURE{C}(target: GLenum; internalformat: GLenum; x: GLint; y: GLint; width: GLsizei);
  TglGetColorTableSGI= PROCEDURE{C}(target: GLenum; format: GLenum; xtype:  GLenum; table: PGLvoid);
  TglGetColorTableParameterfvSGI= PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLfloat);
  TglGetColorTableParameterivSGI= PROCEDURE{C}(target: GLenum; pname: GLenum; params: PGLint);

  (*  GL_SUNX_constant_data *)
  TglFinishTextureSUNX= PROCEDURE{C}();

  (*  GL_SUN_global_alpha *)
  TglGlobalAlphaFactorbSUN= PROCEDURE{C}(factor: GLbyte);
  TglGlobalAlphaFactorsSUN= PROCEDURE{C}(factor: GLshort);
  TglGlobalAlphaFactoriSUN= PROCEDURE{C}(factor: GLint);
  TglGlobalAlphaFactorfSUN= PROCEDURE{C}(factor: GLfloat);
  TglGlobalAlphaFactordSUN= PROCEDURE{C}(factor: GLdouble);
  TglGlobalAlphaFactorubSUN= PROCEDURE{C}(factor: GLubyte);
  TglGlobalAlphaFactorusSUN= PROCEDURE{C}(factor: GLushort);
  TglGlobalAlphaFactoruiSUN= PROCEDURE{C}(factor: GLuint);

  (*  GL_SUN_mesh_array *)
  TglDrawMeshArraysSUN= PROCEDURE{C}(mode: GLenum; first: GLint; count: GLsizei; width: GLsizei);

  (*  GL_SUN_triangle_list *)
  TglReplacementCodeuiSUN= PROCEDURE{C}(code: GLuint);
  TglReplacementCodeusSUN= PROCEDURE{C}(code: GLushort);
  TglReplacementCodeubSUN= PROCEDURE{C}(code: GLubyte);
  TglReplacementCodeuivSUN= PROCEDURE{C}( code: PGLuint);
  TglReplacementCodeusvSUN= PROCEDURE{C}( code: PGLushort);
  TglReplacementCodeubvSUN= PROCEDURE{C}( code: PGLubyte);
  TglReplacementCodePointerSUN= PROCEDURE{C}(xtype:  GLenum; stride: GLsizei; xpointer: PGLvoid);

  (*  GL_SUN_vertex *)
  TglColor4ubVertex2fSUN= PROCEDURE{C}(r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat);
  TglColor4ubVertex2fvSUN= PROCEDURE{C}( c: PGLubyte;  v: PGLfloat);
  TglColor4ubVertex3fSUN= PROCEDURE{C}(r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor4ubVertex3fvSUN= PROCEDURE{C}(c: PGLubyte; v: PGLfloat);
  TglColor3fVertex3fSUN= PROCEDURE{C}(r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor3fVertex3fvSUN= PROCEDURE{C}(c: PGLfloat; v: PGLfloat);
  TglNormal3fVertex3fSUN= PROCEDURE{C}(nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglNormal3fVertex3fvSUN= PROCEDURE{C}(n: PGLfloat; v: PGLfloat);
  TglColor4fNormal3fVertex3fSUN= PROCEDURE{C}(r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglColor4fNormal3fVertex3fvSUN= PROCEDURE{C}(c: PGLfloat; n: PGLfloat; v: PGLfloat);
  TglTexCoord2fVertex3fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fVertex3fvSUN= PROCEDURE{C}(tc: PGLfloat; v: PGLfloat);
  TglTexCoord4fVertex4fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglTexCoord4fVertex4fvSUN= PROCEDURE{C}(tc: PGLfloat; v: PGLfloat);
  TglTexCoord2fColor4ubVertex3fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor4ubVertex3fvSUN= PROCEDURE{C}(tc: PGLfloat; c: PGLubyte; v: PGLfloat);
  TglTexCoord2fColor3fVertex3fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor3fVertex3fvSUN= PROCEDURE{C}(tc: PGLfloat; c: PGLfloat; v: PGLfloat);
  TglTexCoord2fNormal3fVertex3fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fNormal3fVertex3fvSUN= PROCEDURE{C}( tc: PGLfloat;  n: PGLfloat; v: PGLfloat);
  TglTexCoord2fColor4fNormal3fVertex3fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglTexCoord2fColor4fNormal3fVertex3fvSUN= PROCEDURE{C}( tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglTexCoord4fColor4fNormal3fVertex4fSUN= PROCEDURE{C}(s: GLfloat; t: GLfloat; p: GLfloat; q: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat; w: GLfloat);
  TglTexCoord4fColor4fNormal3fVertex4fvSUN= PROCEDURE{C}( tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiVertex3fSUN= PROCEDURE{C}(rc: GLuint; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  v: PGLfloat);
  TglReplacementCodeuiColor4ubVertex3fSUN= PROCEDURE{C}(rc: GLuint; r: GLubyte; g: GLubyte; b: GLubyte; a: GLubyte; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor4ubVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  c: PGLubyte;  v: PGLfloat);
  TglReplacementCodeuiColor3fVertex3fSUN= PROCEDURE{C}(rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor3fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  c: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiNormal3fVertex3fSUN= PROCEDURE{C}(rc: GLuint; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiNormal3fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiColor4fNormal3fVertex3fSUN= PROCEDURE{C}(rc: GLuint; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiColor4fNormal3fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fVertex3fSUN= PROCEDURE{C}(rc: GLuint; s: GLfloat; t: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  tc: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fNormal3fVertex3fSUN= PROCEDURE{C}(rc: GLuint; s: GLfloat; t: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  tc: PGLfloat;  n: PGLfloat;  v: PGLfloat);
  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN= PROCEDURE{C}(rc: GLuint; s: GLfloat; t: GLfloat; r: GLfloat; g: GLfloat; b: GLfloat; a: GLfloat; nx: GLfloat; ny: GLfloat; nz: GLfloat; x: GLfloat; y: GLfloat; z: GLfloat);
  TglReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN= PROCEDURE{C}( rc: PGLuint;  tc: PGLfloat;  c: PGLfloat;  n: PGLfloat;  v: PGLfloat);


(*******************************************************)
 (*! window support functions for Linux *)
(* ************************************************* *)

  TglXChooseVisual = PROCEDURE{C}(dpy: DisplayPtr; screen: GLint; attribList: PGLint): VisualInfoPtr;
  TglXCopyContext = PROCEDURE{C}(dpy: DisplayPtr; src: GLXContext; dst: GLXContext; mask: GLuint);
  TglXCreateContext = PROCEDURE{C}(dpy: DisplayPtr; vis: VisualInfoPtr; shareList: GLXContext; direct: GLboolean): GLXContext;
  TglXCreateGLXPixmap = PROCEDURE{C}(dpy: DisplayPtr; vis: VisualInfoPtr; pixmap: Pixmap): GLXPixmap;
  TglXDestroyContext = PROCEDURE{C}(dpy: DisplayPtr; ctx: GLXContext);
  TglXDestroyGLXPixmap = PROCEDURE{C}(dpy : DisplayPtr; pix: GLXPixmap);
  TglXGetConfig = PROCEDURE{C}(dpy : DisplayPtr; vis: VisualInfoPtr; attrib: GLint; VAR value: GLint): GLint;
  TglXGetCurrentContext = PROCEDURE{C}(): GLXContext;
  TglXGetCurrentDrawable = PROCEDURE{C}(): GLXDrawable ;
  TglXIsDirect = PROCEDURE{C}(dpy: DisplayPtr; ctx: GLXContext): GLboolean;
  TglXMakeCurrent = PROCEDURE{C}(dpy: DisplayPtr; drawable: GLXDrawable; ctx: GLXContext): GLboolean;
  TglXQueryExtension = PROCEDURE{C}(dpy: DisplayPtr;  VAR errorBase: GLint; VAR eventBase: GLint): GLboolean;
  TglXQueryVersion = PROCEDURE{C}(dpy: DisplayPtr; VAR major: GLint; VAR minor: GLint): GLboolean;
  TglXSwapBuffers = PROCEDURE{C}(dpy: DisplayPtr; drawable: GLXDrawable);
  TglXUseXFont = PROCEDURE{C}(font: Font; first: GLint; count: GLint; listBase: GLint);
  TglXWaitGL = PROCEDURE{C};
  TglXWaitX = PROCEDURE{C};

  TglXGetClientString = PROCEDURE{C}( dpy: DisplayPtr; name: GLint): PGLchar;
  TglXQueryServerString = PROCEDURE{C}(dpy: DisplayPtr; screen: GLint; name: GLint): PGLchar;
  TglXQueryExtensionsString = PROCEDURE{C}(dpy: DisplayPtr; screen: GLint): PGLchar;

  (* GLX_VERSION_1_3 *)
  TglXGetFBConfigs = PROCEDURE{C}(dpy: DisplayPtr; screen: GLint; nelements: PGLint): GLXFBConfig;
  TglXChooseFBConfig = PROCEDURE{C}(dpy: DisplayPtr; screen: GLint; attriblist: PGLint; VAR nelements: GLint): GLXFBConfig;
  TglXGetFBConfigAttrib = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; attribute: GLint; value: PGLint): GLint;
  TglXGetVisualFromFBConfig = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig) : VisualInfoPtr;
  TglXCreateWindow = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; win: Window; attriblist: PGLint): GLXWindow;
  TglXDestroyWindow = PROCEDURE{C}(dpy: DisplayPtr; win: GLXWindow);
  TglXCreatePixmap = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; pixmap: Pixmap; attriblist: PGLint): GLXPixmap;

  TglXDestroyPixmap = PROCEDURE{C}(dpy: DisplayPtr; pixmap: GLXPixmap);
  TglXCreatePbuffer = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; attriblist: PGLint): GLXPbuffer;
  TglXDestroyPbuffer = PROCEDURE{C}(dpy: DisplayPtr; pbuf: GLXPbuffer);
  TglXQueryDrawable = PROCEDURE{C}(dpy: DisplayPtr; draw: GLXDrawable; attribute: GLint; value: PGLuint);
  TglXCreateNewContext = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; renderxtype:  GLint; sharelist: GLXContext; direct: GLboolean): GLXContext ;
  TglXMakeContextCurrent = PROCEDURE{C}( display: DisplayPtr; draw: GLXDrawable; readx: GLXDrawable; ctx: GLXContext): GLboolean;
  TglXGetCurrentReadDrawable = PROCEDURE{C}(): GLXDrawable;
  TglXGetCurrentDisplay = PROCEDURE{C}(): DisplayPtr;

  TglXQueryContext = PROCEDURE{C}(dpy: DisplayPtr; ctx: GLXContext; attribute: GLint; VAR value: GLint): GLint;
  TglXSelectEvent = PROCEDURE{C}(dpy: DisplayPtr; draw: GLXDrawable; eventmask: GLuint);
  TglXGetSelectedEvent = PROCEDURE{C}(dpy: DisplayPtr; draw: GLXDrawable; VAR eventmask: GLuint);

  (* GLX_VERSION_1_4 *)
  TglXGetProcAddress = PROCEDURE{C}(CONST name: ARRAY OF CHAR): Pointer;

  (* GLX_ARB_get_proc_address *)
  TglXGetProcAddressARB = PROCEDURE{C}(CONST name: ARRAY OF CHAR): Pointer;

  (* GLX_ARB_create_context *)
  TglXCreateContextAttribsARB = PROCEDURE{C}(dpy: DisplayPtr; config: GLXFBConfig; sharecontext: GLXContext; direct: GLboolean;  attriblist: PGLint): GLXContext;

  (* GLX_EXT_import_context *)
  TglXGetCurrentDisplayEXT = PROCEDURE{C}(): DisplayPtr;
  TglXQueryContextInfoEXT = PROCEDURE{C}(dpy: DisplayPtr; context: GLXContext; attribute: GLint; VAR value: GLint): GLint;
  TglXGetContextIDEXT = PROCEDURE{C}( context: GLXContext): GLXContextID;
  TglXImportContextEXT = PROCEDURE{C}(dpy: DisplayPtr; contextID: GLXContextID): GLXContext;
  TglXFreeContextEXT = PROCEDURE{C}(dpy: DisplayPtr; context: GLXContext);

  (* GLX_EXT_texture_from_pixmap *)
  TglXBindTexImageEXT = PROCEDURE{C}(dpy: DisplayPtr; drawable: GLXDrawable; buffer: GLint;  attriblist: PGLint);
  TglXReleaseTexImageEXT = PROCEDURE{C}(dpy: DisplayPtr; drawable: GLXDrawable; buffer: GLint);



  (*! GL utility functions and procedures *)
VAR

  gluErrorString - : PROCEDURE{C}(errCode: GLenum): ADDRESS; (* AnsiChar; *)
  gluGetString - : PROCEDURE{C}(name: GLenum): ADDRESS;
  gluOrtho2D - : PROCEDURE{C}(left, right, bottom, top: GLdouble);
  gluPerspective - : PROCEDURE{C}(fovy, aspect, zNear, zFar: GLdouble);
  gluPickMatrix - : PROCEDURE{C}(x, y, width, height: GLdouble; CONST viewport: TVector4i);
  gluLookAt - : PROCEDURE{C}(eyex, eyey, eyez, centerx, centery, centerz, upx, upy, upz: GLdouble);
  gluProject - : PROCEDURE{C}(objx, objy, objz: GLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; winx, winy, winz: PGLdouble): GLint;
  gluUnProject - : PROCEDURE{C}(winx, winy, winz: GLdouble; CONST modelMatrix: TGLMatrixd4; CONST projMatrix: TGLMatrixd4; CONST viewport: TVector4i; objx, objy, objz: PGLdouble): GLint;
  gluScaleImage - : PROCEDURE{C}(format: GLenum; widthin, heightin: GLint; typein: GLenum; datain: Pointer; widthout, heightout: GLint; typeout: GLenum;  dataout: Pointer): GLint;
  gluBuild1DMipmaps - : PROCEDURE{C}(target: GLenum; components, width: GLint; format, atype: GLenum;  data: Pointer): GLint;
  gluBuild2DMipmaps - : PROCEDURE{C}(target: GLenum; components, width, height: GLint; format, atype: GLenum;  Data: Pointer): GLint;
  gluNewQuadric - : PROCEDURE{C}(): TGLUQuadric;
  gluDeleteQuadric - : PROCEDURE{C}(state: TGLUQuadric);
  gluQuadricNormals - : PROCEDURE{C}(quadObject: TGLUQuadric; normals: GLenum);
  gluQuadricTexture - : PROCEDURE{C}(quadObject: PGLUQuadric; textureCoords: GLboolean);
  gluQuadricOrientation - : PROCEDURE{C}(quadObject: PGLUQuadric; orientation: GLenum);
  gluQuadricDrawStyle - : PROCEDURE{C}(quadObject: TGLUQuadric; drawStyle: GLenum);
  gluCylinder - : PROCEDURE{C}(quadObject: TGLUQuadric; baseRadius, topRadius, height: GLdouble; slices, stacks: GLint);
  gluDisk - : PROCEDURE{C}(quadObject: TGLUQuadric; innerRadius, outerRadius: GLdouble; slices, loops: GLint);
  gluPartialDisk - : PROCEDURE{C}(quadObject: TGLUQuadric; innerRadius, outerRadius: GLdouble; slices, loops: GLint; startAngle, sweepAngle: GLdouble);
  gluSphere - : PROCEDURE{C}(quadObject: TGLUQuadric; radius: GLdouble; slices, stacks: GLint);
  gluQuadricCallback - : PROCEDURE{C}(quadObject: TGLUQuadric; which: GLenum; fn: ADDRESS (*TGLUQuadricErrorProc*));
  gluNewTess - : PROCEDURE{C}(): PGLUTesselator;
  gluDeleteTess - : PROCEDURE{C}(tess: PGLUTesselator);
  gluTessBeginPolygon - : PROCEDURE{C}(tess: PGLUTesselator; polygon_data: Pointer);
  gluTessBeginContour - : PROCEDURE{C}(tess: PGLUTesselator);
  gluTessVertex - : PROCEDURE{C}(tess: PGLUTesselator; CONST coords: TGLArrayd3; data: Pointer);
  gluTessEndContour - : PROCEDURE{C}(tess: PGLUTesselator);
  gluTessEndPolygon - : PROCEDURE{C}(tess: PGLUTesselator);
  gluTessProperty - : PROCEDURE{C}(tess: PGLUTesselator; which: GLenum; value: GLdouble);
  gluTessNormal - : PROCEDURE{C}(tess: PGLUTesselator; x, y, z: GLdouble);
  gluTessCallback - : PROCEDURE{C}(tess: PGLUTesselator; which: GLenum; fn: Pointer);
  gluGetTessProperty - : PROCEDURE{C}(tess: PGLUTesselator; which: GLenum; value: PGLdouble);
  gluNewNurbsRenderer - : PROCEDURE{C}(): PGLUNurbs;
  gluDeleteNurbsRenderer - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluBeginSurface - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluBeginCurve - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluEndCurve - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluEndSurface - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluBeginTrim - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluEndTrim - : PROCEDURE{C}(nobj: PGLUNurbs);
  gluPwlCurve - : PROCEDURE{C}(nobj: PGLUNurbs; count: GLint; points: PGLfloat; stride: GLint; atype: GLenum);
  gluNurbsCurve - : PROCEDURE{C}(nobj: PGLUNurbs; nknots: GLint; knot: PGLfloat; stride: GLint; ctlarray: PGLfloat; order: GLint; atype: GLenum);
  gluNurbsSurface - : PROCEDURE{C}(nobj: PGLUNurbs; sknot_count: GLint; sknot: PGLfloat; tknot_count: GLint; tknot: PGLfloat; s_stride, t_stride: GLint; ctlarray: PGLfloat; sorder, torder: GLint; atype: GLenum);
  gluLoadSamplingMatrices - : PROCEDURE{C}(nobj: PGLUNurbs; CONST modelMatrix, projMatrix: TGLMatrixf4; CONST viewport: TVector4i);
  gluNurbsProperty - : PROCEDURE{C}(nobj: PGLUNurbs; aproperty: GLenum; value: GLfloat);
  gluGetNurbsProperty - : PROCEDURE{C}(nobj: PGLUNurbs; aproperty: GLenum; value: PGLfloat);
  gluNurbsCallback - : PROCEDURE{C}(nobj: PGLUNurbs; which: GLenum; fn: TGLUNurbsErrorProc);
  gluBeginPolygon - : PROCEDURE{C}(tess: PGLUTesselator);
  gluNextContour - : PROCEDURE{C}(tess: PGLUTesselator; atype: GLenum);
  gluEndPolygon - : PROCEDURE{C}(tess: PGLUTesselator);

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

  (** wrapper procedure *)
  PROCEDURE GetProcAddress*(CONST funcName: ARRAY OF CHAR): ADDRESS;
  VAR address: ADDRESS;
  BEGIN
  	address := 0;
  	IF glXGetProcAddress # NIL THEN
	  	address := glXGetProcAddress(funcName);
	ELSIF glXGetProcAddressARB # NIL THEN
		address := glXGetProcAddressARB(funcName);
	ELSE

	END;
	RETURN address;
  END GetProcAddress;

PROCEDURE InitOpenGL*;

BEGIN {EXCLUSIVE}

   GL_LibHandle := Unix.Dlopen(GL_LibName, 2);
  ASSERT(GL_LibHandle # 0,101);

  GLU_LibHandle := Unix.Dlopen(GLU_LibName, 2);
  ASSERT(GLU_LibHandle # 0,102);

  (* load GL functions*)
  IF (GL_LibHandle # 0) THEN
    (* GLX_VERSION_1_4 (needs to be first)*)
     Unix.Dlsym(GL_LibHandle, 'glXGetProcAddress', SYSTEM.VAL(ADDRESS, glXGetProcAddress));

      (* GLX_ARB_get_proc_address  (also needs to be first) *)
     Unix.Dlsym(GL_LibHandle, 'glXGetProcAddressARB', SYSTEM.VAL(ADDRESS, glXGetProcAddressARB));

 	 glXChooseVisual:= SYSTEM.VAL(TglXChooseVisual , GetProcAddress("glXChooseVisual"));
	 glXCopyContext:= SYSTEM.VAL(TglXCopyContext , GetProcAddress("glXCopyContext"));
	 glXCreateContext:= SYSTEM.VAL(TglXCreateContext , GetProcAddress("glXCreateContext"));
	 glXCreateGLXPixmap:= SYSTEM.VAL(TglXCreateGLXPixmap , GetProcAddress("glXCreateGLXPixmap"));
	 glXDestroyContext:= SYSTEM.VAL(TglXDestroyContext , GetProcAddress("glXDestroyContext"));
	 glXDestroyGLXPixmap:= SYSTEM.VAL(TglXDestroyGLXPixmap , GetProcAddress("glXDestroyGLXPixmap"));
	 glXGetConfig:= SYSTEM.VAL(TglXGetConfig , GetProcAddress("glXGetConfig"));
	 glXGetCurrentContext:= SYSTEM.VAL(TglXGetCurrentContext , GetProcAddress("glXGetCurrentContext"));
	 glXGetCurrentDrawable:= SYSTEM.VAL(TglXGetCurrentDrawable , GetProcAddress("glXGetCurrentDrawable"));
	 glXIsDirect:= SYSTEM.VAL(TglXIsDirect , GetProcAddress("glXIsDirect"));

        glXMakeCurrent:= SYSTEM.VAL(TglXMakeCurrent , GetProcAddress("glXMakeCurrent"));
        glXQueryExtension:= SYSTEM.VAL(TglXQueryExtension , GetProcAddress("glXQueryExtension"));
        glXQueryVersion:= SYSTEM.VAL(TglXQueryVersion , GetProcAddress("glXQueryVersion"));
        glXSwapBuffers:= SYSTEM.VAL(TglXSwapBuffers , GetProcAddress("glXSwapBuffers"));
        glXUseXFont:= SYSTEM.VAL(TglXUseXFont , GetProcAddress("glXUseXFont"));
        glXWaitGL:= SYSTEM.VAL(TglXWaitGL , GetProcAddress("glXWaitGL"));
        glXWaitX:= SYSTEM.VAL(TglXWaitX , GetProcAddress("glXWaitX"));
        glXGetClientString:= SYSTEM.VAL(TglXGetClientString , GetProcAddress("glXGetClientString"));
        glXQueryServerString:= SYSTEM.VAL(TglXQueryServerString , GetProcAddress("glXQueryServerString"));
        glXQueryExtensionsString:= SYSTEM.VAL(TglXQueryExtensionsString , GetProcAddress("glXQueryExtensionsString"));

    (* GLX_VERSION_1_3 *)
        glXGetFBConfigs:= SYSTEM.VAL(TglXGetFBConfigs , GetProcAddress("glXGetFBConfigs"));
        glXChooseFBConfig:= SYSTEM.VAL(TglXChooseFBConfig , GetProcAddress("glXChooseFBConfig"));
        glXGetFBConfigAttrib:= SYSTEM.VAL(TglXGetFBConfigAttrib , GetProcAddress("glXGetFBConfigAttrib"));
        glXGetVisualFromFBConfig:= SYSTEM.VAL(TglXGetVisualFromFBConfig , GetProcAddress("glXGetVisualFromFBConfig"));
        glXCreateWindow:= SYSTEM.VAL(TglXCreateWindow , GetProcAddress("glXCreateWindow"));
        glXDestroyWindow:= SYSTEM.VAL(TglXDestroyWindow , GetProcAddress("glXDestroyWindow"));
        glXCreatePixmap:= SYSTEM.VAL(TglXCreatePixmap , GetProcAddress("glXCreatePixmap"));

        glXDestroyPixmap:= SYSTEM.VAL(TglXDestroyPixmap , GetProcAddress("glXDestroyPixmap"));
        glXCreatePbuffer:= SYSTEM.VAL(TglXCreatePbuffer , GetProcAddress("glXCreatePbuffer"));
        glXDestroyPbuffer:= SYSTEM.VAL(TglXDestroyPbuffer , GetProcAddress("glXDestroyPbuffer"));
        glXQueryDrawable:= SYSTEM.VAL(TglXQueryDrawable , GetProcAddress("glXQueryDrawable"));
        glXCreateNewContext:= SYSTEM.VAL(TglXCreateNewContext , GetProcAddress("glXCreateNewContext"));
        glXMakeContextCurrent:= SYSTEM.VAL(TglXMakeContextCurrent , GetProcAddress("glXMakeContextCurrent"));
        glXGetCurrentReadDrawable:= SYSTEM.VAL(TglXGetCurrentReadDrawable , GetProcAddress("glXGetCurrentReadDrawable"));
        glXGetCurrentDisplay:= SYSTEM.VAL(TglXGetCurrentDisplay , GetProcAddress("glXGetCurrentDisplay"));

        glXQueryContext:= SYSTEM.VAL(TglXQueryContext , GetProcAddress("glXQueryContext"));
        glXSelectEvent:= SYSTEM.VAL(TglXSelectEvent , GetProcAddress("glXSelectEvent"));
        glXGetSelectedEvent:= SYSTEM.VAL(TglXGetSelectedEvent , GetProcAddress("glXGetSelectedEvent"));

      (* GLX_ARB_create_context *)
        glXCreateContextAttribsARB:= SYSTEM.VAL(TglXCreateContextAttribsARB , GetProcAddress("glXCreateContextAttribsARB"));

      (* GLX_EXT_import_context *)
        glXGetCurrentDisplayEXT:= SYSTEM.VAL(TglXGetCurrentDisplayEXT , GetProcAddress("glXGetCurrentDisplayEXT"));
        glXQueryContextInfoEXT:= SYSTEM.VAL(TglXQueryContextInfoEXT , GetProcAddress("glXQueryContextInfoEXT"));
        glXGetContextIDEXT:= SYSTEM.VAL(TglXGetContextIDEXT , GetProcAddress("glXGetContextIDEXT"));
        glXImportContextEXT:= SYSTEM.VAL(TglXImportContextEXT , GetProcAddress("glXImportContextEXT"));
        glXFreeContextEXT:= SYSTEM.VAL(TglXFreeContextEXT , GetProcAddress("glXFreeContextEXT"));

      (* GLX_EXT_texture_from_pixmap *)
        glXBindTexImageEXT:= SYSTEM.VAL(TglXBindTexImageEXT , GetProcAddress("glXBindTexImageEXT"));
        glXReleaseTexImageEXT:= SYSTEM.VAL(TglXReleaseTexImageEXT , GetProcAddress("glXReleaseTexImageEXT"));


      KernelLog.String(GL_LibName); KernelLog.String(" loaded."); KernelLog.Ln;
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

(* wrapper procedures *)
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

PROCEDURE GLXQueryExtensionString*(display: DisplayPtr; screen: LONGINT): Strings.String;
VAR  sadr: LONGINT;
BEGIN
  	sadr := glXQueryExtensionsString(display, screen);
	RETURN GetStringFromAddr(sadr);
END GLXQueryExtensionString;

PROCEDURE GLXGetClientString*(display: DisplayPtr; name: GLenum): Strings.String;
VAR  sadr: LONGINT;
BEGIN
  	sadr := glXGetClientString(display, name);
	RETURN GetStringFromAddr(sadr);
END GLXGetClientString;

PROCEDURE GLXQueryServerString*(display: DisplayPtr; screen: GLint; name: GLenum): Strings.String;
VAR  sadr: LONGINT;
BEGIN
  	sadr := glXQueryServerString(display, screen, name);
	RETURN GetStringFromAddr(sadr);
END GLXQueryServerString;

PROCEDURE GLUErrorString*(err: GLenum):Strings.String;
VAR  sadr: LONGINT;
BEGIN
  	sadr := gluErrorString(err);
	RETURN GetStringFromAddr(sadr);
END GLUErrorString;

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
VAR pos: LONGINT;
BEGIN
	pos := Strings.Pos(thisextension, allextensions^);
	IF debug & (pos = -1) THEN
		KernelLog.String(thisextension); KernelLog.String(": NOT AVAILABLE"); KernelLog.Ln;
	END;
  RETURN pos > 0;
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
BEGIN
 DelFCR();

 IF GLU_LibHandle # 0 THEN
       Unix.Dlclose(GLU_LibHandle);
     KernelLog.String(GLU_LibName); KernelLog.String(" unloaded."); KernelLog.Ln;
END;

IF GL_LibHandle # 0 THEN
      Unix.Dlclose(GL_LibHandle);
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
 	oldfcr = {0..6, 8..9}  ,  LinuxAos
 *)
 oldfcr := FCR();
 newfcr := SYSTEM.VAL(SET, 133FH);
 InitOpenGL();
 ReadOpenGLCore();
END OpenGL.

