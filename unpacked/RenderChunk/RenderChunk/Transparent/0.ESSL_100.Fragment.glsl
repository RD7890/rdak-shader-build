varying highp vec4 v_color0;
varying highp vec4 v_fog;
varying highp vec2 v_lightmapUV;
varying highp vec3 v_position;
varying highp vec2 v_texcoord0;
varying highp vec3 v_worldpos;
uniform highp vec4 FogAndDistanceControl;
uniform highp vec4 ViewPositionAndTime;
uniform highp vec4 FogColor;
uniform sampler2D s_MatTexture;
uniform sampler2D s_LightMapTexture;
void main ()
{
  bool waterd_1;
  lowp vec4 diffuse_2;
  diffuse_2 = (texture2D (s_MatTexture, v_texcoord0) * v_color0);
  diffuse_2.xyz = mix ((diffuse_2.xyz * 0.07739938), pow ((
    (0.947867 * diffuse_2.xyz)
   + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (diffuse_2.xyz, vec3(0.04045, 0.04045, 0.04045))));
  waterd_1 = ((v_color0.w > 0.4) && (v_color0.w < 0.6));
  highp vec3 tmpvar_3;
  tmpvar_3 = dFdx(v_position);
  highp vec3 tmpvar_4;
  tmpvar_4 = dFdy(v_position);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(((tmpvar_3.yzx * tmpvar_4.zxy) - (tmpvar_3.zxy * tmpvar_4.yzx)));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (s_LightMapTexture, vec2(0.0, 1.0));
  highp float tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (((FogAndDistanceControl.x - 0.6) / -0.3), 0.0, 1.0);
  tmpvar_7 = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  highp float tmpvar_9;
  tmpvar_9 = pow (clamp ((1.0 - 
    (FogColor.x * 1.5)
  ), 0.0, 1.0), 1.2);
  highp float tmpvar_10;
  tmpvar_10 = (clamp ((
    (FogColor.x - 0.15)
   * 1.25), 0.0, 1.0) * (1.0 - FogColor.z));
  lowp float edge0_11;
  edge0_11 = (tmpvar_6.x * v_lightmapUV.y);
  lowp float tmpvar_12;
  tmpvar_12 = clamp (((v_lightmapUV.x - edge0_11) / (1.0 - edge0_11)), 0.0, 1.0);
  lowp float tmpvar_13;
  tmpvar_13 = max ((v_lightmapUV.x * (tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  )), ((v_lightmapUV.x * tmpvar_7) * v_lightmapUV.y));
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((vec3(1.0, 0.48, 0.06) * tmpvar_13) + ((tmpvar_13 * tmpvar_13) * (
    (tmpvar_13 * tmpvar_13)
   * tmpvar_13)));
  lowp vec3 almap_15;
  lowp float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_6.x - 0.3) / 0.2), 0.0, 1.0);
  lowp float tmpvar_17;
  tmpvar_17 = clamp (((tmpvar_6.x - 1.0) / -0.2), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = (min ((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ), (tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  )) * (1.0 - tmpvar_7));
  lowp float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_6.x - 1.0) / -0.8), 0.0, 1.0);
  lowp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ) * 1.5), 0.0, 1.0);
  highp float tmpvar_21;
  tmpvar_21 = clamp (((v_lightmapUV.y - 0.94) / -0.01999998), 0.0, 1.0);
  lowp float edge0_22;
  edge0_22 = (tmpvar_6.x * v_lightmapUV.y);
  lowp float tmpvar_23;
  tmpvar_23 = clamp (((v_lightmapUV.x - edge0_22) / (1.0 - edge0_22)), 0.0, 1.0);
  lowp float tmpvar_24;
  tmpvar_24 = mix (((
    mix (1.0, 0.40, max (0.0, abs(tmpvar_5.x)))
   * 
    (1.0 - (tmpvar_21 * (tmpvar_21 * (3.0 - 
      (2.0 * tmpvar_21)
    ))))
  ) * (1.0 - tmpvar_7)), 1.0, (tmpvar_23 * (tmpvar_23 * 
    (3.0 - (2.0 * tmpvar_23))
  )));
  highp vec2 tmpvar_25;
  tmpvar_25.x = 0.0;
  tmpvar_25.y = v_lightmapUV.y;
  lowp vec3 tmpvar_26;
  tmpvar_26 = (texture2D (s_LightMapTexture, tmpvar_25).xyz * 0.22);
  almap_15 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DLod    (s_MatTexture, v_texcoord0, 0.0);
  bool tmpvar_28;
  if ((tmpvar_27.w > 0.91)) {
    tmpvar_28 = (texture2DLod    (s_MatTexture, v_texcoord0, 0.0).w < 0.93);
  } else {
    tmpvar_28 = bool(0);
  };
  almap_15 = (tmpvar_26 + (float(tmpvar_28) * 3.0));
  almap_15 = (almap_15 + tmpvar_14);
  almap_15 = (almap_15 + (mix (
    mix (vec3(0.92, 0.94, 1.0), vec3(1.0, 0.72, 0.42), tmpvar_18)
  , vec3(0.06, 0.12, 0.28), tmpvar_20) * tmpvar_24));
  diffuse_2.xyz = (diffuse_2.xyz * almap_15);
  if (waterd_1) {
    highp vec2 cpos_29;
    cpos_29 = v_position.xz;
    highp vec3 wn_30;
    highp vec2 pos_31;
    highp float tmpvar_32;
    tmpvar_32 = (ViewPositionAndTime.w * 1.5);
    pos_31 = ((v_position.xz * 1.3) - tmpvar_32);
    highp vec2 fp_33;
    highp vec2 tmpvar_34;
    tmpvar_34 = floor(pos_31);
    highp vec2 tmpvar_35;
    tmpvar_35 = fract(pos_31);
    fp_33 = ((tmpvar_35 * tmpvar_35) * (3.0 - (2.0 * tmpvar_35)));
    highp float tmpvar_36;
    tmpvar_36 = (tmpvar_34.x + (tmpvar_34.y * 57.0));
    highp vec2 pos_37;
    pos_37 = (v_position.xz + ViewPositionAndTime.w);
    highp vec2 fp_38;
    highp vec2 tmpvar_39;
    tmpvar_39 = floor(pos_37);
    highp vec2 tmpvar_40;
    tmpvar_40 = fract(pos_37);
    fp_38 = ((tmpvar_40 * tmpvar_40) * (3.0 - (2.0 * tmpvar_40)));
    highp float tmpvar_41;
    tmpvar_41 = (tmpvar_39.x + (tmpvar_39.y * 57.0));
    highp float tmpvar_42;
    tmpvar_42 = ((1.0 - mix (
      mix (fract((sin(tmpvar_36) * 43758.55)), fract((sin(
        (tmpvar_36 + 1.0)
      ) * 43758.55)), fp_33.x)
    , 
      mix (fract((sin(
        (tmpvar_36 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_36 + 58.0)
      ) * 43758.55)), fp_33.x)
    , fp_33.y)) + mix (mix (
      fract((sin(tmpvar_41) * 43758.55))
    , 
      fract((sin((tmpvar_41 + 1.0)) * 43758.55))
    , fp_38.x), mix (
      fract((sin((tmpvar_41 + 57.0)) * 43758.55))
    , 
      fract((sin((tmpvar_41 + 58.0)) * 43758.55))
    , fp_38.x), fp_38.y));
    highp vec2 tmpvar_43;
    tmpvar_43.x = (v_position.x - 0.02);
    tmpvar_43.y = cpos_29.y;
    highp vec2 pos_44;
    pos_44 = ((tmpvar_43 * 1.3) - tmpvar_32);
    highp vec2 fp_45;
    highp vec2 tmpvar_46;
    tmpvar_46 = floor(pos_44);
    highp vec2 tmpvar_47;
    tmpvar_47 = fract(pos_44);
    fp_45 = ((tmpvar_47 * tmpvar_47) * (3.0 - (2.0 * tmpvar_47)));
    highp float tmpvar_48;
    tmpvar_48 = (tmpvar_46.x + (tmpvar_46.y * 57.0));
    highp vec2 pos_49;
    pos_49 = (tmpvar_43 + ViewPositionAndTime.w);
    highp vec2 fp_50;
    highp vec2 tmpvar_51;
    tmpvar_51 = floor(pos_49);
    highp vec2 tmpvar_52;
    tmpvar_52 = fract(pos_49);
    fp_50 = ((tmpvar_52 * tmpvar_52) * (3.0 - (2.0 * tmpvar_52)));
    highp float tmpvar_53;
    tmpvar_53 = (tmpvar_51.x + (tmpvar_51.y * 57.0));
    highp vec2 tmpvar_54;
    tmpvar_54.x = cpos_29.x;
    tmpvar_54.y = (v_position.z - 0.02);
    highp vec2 pos_55;
    pos_55 = ((tmpvar_54 * 1.3) - tmpvar_32);
    highp vec2 fp_56;
    highp vec2 tmpvar_57;
    tmpvar_57 = floor(pos_55);
    highp vec2 tmpvar_58;
    tmpvar_58 = fract(pos_55);
    fp_56 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
    highp float tmpvar_59;
    tmpvar_59 = (tmpvar_57.x + (tmpvar_57.y * 57.0));
    highp vec2 pos_60;
    pos_60 = (tmpvar_54 + ViewPositionAndTime.w);
    highp vec2 fp_61;
    highp vec2 tmpvar_62;
    tmpvar_62 = floor(pos_60);
    highp vec2 tmpvar_63;
    tmpvar_63 = fract(pos_60);
    fp_61 = ((tmpvar_63 * tmpvar_63) * (3.0 - (2.0 * tmpvar_63)));
    highp float tmpvar_64;
    tmpvar_64 = (tmpvar_62.x + (tmpvar_62.y * 57.0));
    highp vec3 tmpvar_65;
    tmpvar_65.z = 1.0;
    tmpvar_65.x = (tmpvar_42 - ((1.0 - 
      mix (mix (fract((
        sin(tmpvar_48)
       * 43758.55)), fract((
        sin((tmpvar_48 + 1.0))
       * 43758.55)), fp_45.x), mix (fract((
        sin((tmpvar_48 + 57.0))
       * 43758.55)), fract((
        sin((tmpvar_48 + 58.0))
       * 43758.55)), fp_45.x), fp_45.y)
    ) + mix (
      mix (fract((sin(tmpvar_53) * 43758.55)), fract((sin(
        (tmpvar_53 + 1.0)
      ) * 43758.55)), fp_50.x)
    , 
      mix (fract((sin(
        (tmpvar_53 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_53 + 58.0)
      ) * 43758.55)), fp_50.x)
    , fp_50.y)));
    tmpvar_65.y = (tmpvar_42 - ((1.0 - 
      mix (mix (fract((
        sin(tmpvar_59)
       * 43758.55)), fract((
        sin((tmpvar_59 + 1.0))
       * 43758.55)), fp_56.x), mix (fract((
        sin((tmpvar_59 + 57.0))
       * 43758.55)), fract((
        sin((tmpvar_59 + 58.0))
       * 43758.55)), fp_56.x), fp_56.y)
    ) + mix (
      mix (fract((sin(tmpvar_64) * 43758.55)), fract((sin(
        (tmpvar_64 + 1.0)
      ) * 43758.55)), fp_61.x)
    , 
      mix (fract((sin(
        (tmpvar_64 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_64 + 58.0)
      ) * 43758.55)), fp_61.x)
    , fp_61.y)));
    highp mat3 tmpvar_66;
    tmpvar_66[0].x = (abs(tmpvar_5).y + tmpvar_5.z);
    tmpvar_66[0].y = 0.0;
    tmpvar_66[0].z = -(tmpvar_5.x);
    tmpvar_66[1].x = 0.0;
    tmpvar_66[1].y = (-(abs(tmpvar_5).x) - abs(tmpvar_5).z);
    tmpvar_66[1].z = abs(tmpvar_5).y;
    tmpvar_66[2] = tmpvar_5;
    wn_30 = (((
      (normalize(tmpvar_65) * 0.5)
     + 0.5) * 2.0) - 1.0);
    highp vec3 tmpvar_67;
    tmpvar_67 = normalize((wn_30 * tmpvar_66));
    wn_30 = tmpvar_67;
    lowp vec4 diff_68;
    highp float fresnel_69;
    highp vec3 rv_70;
    highp vec3 tmpvar_71;
    tmpvar_71 = normalize(v_worldpos);
    highp vec3 tmpvar_72;
    tmpvar_72 = (tmpvar_71 - (2.0 * (
      dot (tmpvar_67, tmpvar_71)
     * tmpvar_67)));
    rv_70 = tmpvar_72;
    highp vec3 tmpvar_73;
    tmpvar_73 = normalize(-(v_worldpos));
    highp float tmpvar_74;
    tmpvar_74 = max (0.0, dot (tmpvar_67, tmpvar_73));
    highp float tmpvar_75;
    tmpvar_75 = (max (0.0, tmpvar_72.y) * 1.2);
    highp float x_76;
    x_76 = (1.0 - tmpvar_74);
    highp float tmpvar_77;
    tmpvar_77 = ((0.5 + (
      ((0.5 * x_76) * (x_76 * x_76))
     * 
      (x_76 * x_76)
    )) * v_lightmapUV.y);
    fresnel_69 = tmpvar_77;
    lowp vec4 tmpvar_78;
    tmpvar_78 = (diffuse_2 * (1.0 - v_lightmapUV.y));
    diff_68 = tmpvar_78;
    highp vec3 skyc_79;
    highp vec3 tmpvar_80;
    highp vec3 tmpvar_81;
    tmpvar_81 = (FogColor.xyz * 2.0);
    tmpvar_80 = mix (mix (mix (vec3(0.08, 0.42, 0.88), vec3(0.04, 0.09, 0.20), tmpvar_9), vec3(0.52, 0.36, 0.50), tmpvar_10), tmpvar_81, tmpvar_7);
    highp vec3 tmpvar_82;
    tmpvar_82 = mix (mix (mix (vec3(0.80, 0.96, 1.12), vec3(1.0, 0.44, 0.26), tmpvar_10), (tmpvar_80 + 0.15), tmpvar_9), tmpvar_81, tmpvar_7);
    skyc_79 = mix (mix ((tmpvar_80 * 0.07739938), pow (
      ((0.947867 * tmpvar_80) + 0.0521327)
    , vec3(2.4, 2.4, 2.4)), vec3(
      greaterThanEqual (tmpvar_80, vec3(0.04045, 0.04045, 0.04045))
    )), mix ((tmpvar_82 * 0.07739938), pow (
      ((0.947867 * tmpvar_82) + 0.0521327)
    , vec3(2.4, 2.4, 2.4)), vec3(
      greaterThanEqual (tmpvar_82, vec3(0.04045, 0.04045, 0.04045))
    )), max (0.0, (
      exp((-(clamp (tmpvar_72.y, 0.0, 1.0)) * 4.5))
     + 
      (exp((-(
        clamp (sqrt(dot (tmpvar_72.zy, tmpvar_72.zy)), 0.0, 1.0)
      ) * 4.0)) * tmpvar_10)
    )));
    if ((FogAndDistanceControl.x == 0.0)) {
      skyc_79 = mix ((FogColor.xyz * 0.07739938), pow ((
        (0.947867 * FogColor.xyz)
       + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (FogColor.xyz, vec3(0.04045, 0.04045, 0.04045))));
    };
    lowp vec4 tmpvar_83;
    tmpvar_83.w = 1.0;
    tmpvar_83.xyz = (skyc_79 + (tmpvar_14 * 0.5));
    rv_70 = (tmpvar_72 / tmpvar_72.y);
    highp float x_84;
    x_84 = (1.0 - tmpvar_74);
    fresnel_69 = ((0.3 + (
      ((0.7 * x_84) * (x_84 * x_84))
     * 
      (x_84 * x_84)
    )) * v_lightmapUV.y);
    highp vec3 tmpvar_85;
    tmpvar_85 = mix (mix (mix (vec3(0.85, 1.0, 1.1), vec3(0.9, 0.6, 0.3), tmpvar_10), vec3(0.15, 0.2, 0.29), tmpvar_9), (FogColor.xyz * 2.0), tmpvar_7);
    highp vec4 tmpvar_86;
    tmpvar_86.w = 1.0;
    tmpvar_86.xyz = mix ((tmpvar_85 * 0.07739938), pow ((
      (0.947867 * tmpvar_85)
     + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (tmpvar_85, vec3(0.04045, 0.04045, 0.04045))));
    highp vec2 pos_87;
    highp float den_88;
    highp float tot_89;
    den_88 = clamp ((1.0 - tmpvar_7), 0.0, 1.0);
    pos_87 = (rv_70.xz * 1.6);
    pos_87 = (pos_87 + (ViewPositionAndTime.w * 0.001));
    highp vec2 fp_90;
    highp vec2 tmpvar_91;
    tmpvar_91 = floor(pos_87);
    highp vec2 tmpvar_92;
    tmpvar_92 = fract(pos_87);
    fp_90 = ((tmpvar_92 * tmpvar_92) * (3.0 - (2.0 * tmpvar_92)));
    highp float tmpvar_93;
    tmpvar_93 = (tmpvar_91.x + (tmpvar_91.y * 57.0));
    tot_89 = (mix (mix (
      fract((sin(tmpvar_93) * 43758.55))
    , 
      fract((sin((tmpvar_93 + 1.0)) * 43758.55))
    , fp_90.x), mix (
      fract((sin((tmpvar_93 + 57.0)) * 43758.55))
    , 
      fract((sin((tmpvar_93 + 58.0)) * 43758.55))
    , fp_90.x), fp_90.y) * den_88);
    den_88 = (den_88 * 0.5);
    pos_87 = (pos_87 * 2.5);
    pos_87 = (pos_87 + tot_89);
    highp float tmpvar_94;
    tmpvar_94 = (ViewPositionAndTime.w * 0.1);
    pos_87 = (pos_87 + tmpvar_94);
    highp vec2 fp_95;
    highp vec2 tmpvar_96;
    tmpvar_96 = floor(pos_87);
    highp vec2 tmpvar_97;
    tmpvar_97 = fract(pos_87);
    fp_95 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
    highp float tmpvar_98;
    tmpvar_98 = (tmpvar_96.x + (tmpvar_96.y * 57.0));
    tot_89 = (tot_89 + (mix (
      mix (fract((sin(tmpvar_98) * 43758.55)), fract((sin(
        (tmpvar_98 + 1.0)
      ) * 43758.55)), fp_95.x)
    , 
      mix (fract((sin(
        (tmpvar_98 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_98 + 58.0)
      ) * 43758.55)), fp_95.x)
    , fp_95.y) * den_88));
    den_88 = (den_88 * 0.5);
    pos_87 = (pos_87 * 2.5);
    pos_87 = (pos_87 + tot_89);
    pos_87 = (pos_87 + tmpvar_94);
    highp vec2 fp_99;
    highp vec2 tmpvar_100;
    tmpvar_100 = floor(pos_87);
    highp vec2 tmpvar_101;
    tmpvar_101 = fract(pos_87);
    fp_99 = ((tmpvar_101 * tmpvar_101) * (3.0 - (2.0 * tmpvar_101)));
    highp float tmpvar_102;
    tmpvar_102 = (tmpvar_100.x + (tmpvar_100.y * 57.0));
    tot_89 = (tot_89 + (mix (
      mix (fract((sin(tmpvar_102) * 43758.55)), fract((sin(
        (tmpvar_102 + 1.0)
      ) * 43758.55)), fp_99.x)
    , 
      mix (fract((sin(
        (tmpvar_102 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_102 + 58.0)
      ) * 43758.55)), fp_99.x)
    , fp_99.y) * den_88));
    den_88 = (den_88 * 0.5);
    pos_87 = (pos_87 * 2.5);
    pos_87 = (pos_87 + tot_89);
    pos_87 = (pos_87 + tmpvar_94);
    highp vec2 fp_103;
    highp vec2 tmpvar_104;
    tmpvar_104 = floor(pos_87);
    highp vec2 tmpvar_105;
    tmpvar_105 = fract(pos_87);
    fp_103 = ((tmpvar_105 * tmpvar_105) * (3.0 - (2.0 * tmpvar_105)));
    highp float tmpvar_106;
    tmpvar_106 = (tmpvar_104.x + (tmpvar_104.y * 57.0));
    tot_89 = (tot_89 + (mix (
      mix (fract((sin(tmpvar_106) * 43758.55)), fract((sin(
        (tmpvar_106 + 1.0)
      ) * 43758.55)), fp_103.x)
    , 
      mix (fract((sin(
        (tmpvar_106 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_106 + 58.0)
      ) * 43758.55)), fp_103.x)
    , fp_103.y) * den_88));
    den_88 = (den_88 * 0.5);
    pos_87 = (pos_87 * 2.5);
    pos_87 = (pos_87 + tot_89);
    pos_87 = (pos_87 + tmpvar_94);
    highp vec4 tmpvar_107;
    tmpvar_107.w = 1.0;
    tmpvar_107.xyz = skyc_79;
    diff_68 = (mix (mix (tmpvar_78, tmpvar_83, tmpvar_77), tmpvar_86, (
      ((1.0 - pow (0.1, max (0.0, 
        (1.0 - tot_89)
      ))) * tmpvar_75)
     * fresnel_69)) + ((
      pow (max (0.0, dot (tmpvar_67, normalize(
        (tmpvar_73 + vec3(-0.98, 0.173, 0.0))
      ))), 230.0)
     * tmpvar_107) * tmpvar_10));
    highp float tmpvar_108;
    tmpvar_108 = clamp (((v_lightmapUV.y - 0.9) / 0.04000002), 0.0, 1.0);
    diff_68.xyz = (diff_68.xyz * max (v_lightmapUV.x, (
      ((tmpvar_108 * (tmpvar_108 * (3.0 - 
        (2.0 * tmpvar_108)
      ))) * 0.7)
     + 0.3)));
    diffuse_2 = diff_68;
  };
  if ((FogAndDistanceControl.x == 0.0)) {
    highp vec2 pos_109;
    pos_109 = ((v_position.xz * 1.3) - (ViewPositionAndTime.w * 1.5));
    highp vec2 fp_110;
    highp vec2 tmpvar_111;
    tmpvar_111 = floor(pos_109);
    highp vec2 tmpvar_112;
    tmpvar_112 = fract(pos_109);
    fp_110 = ((tmpvar_112 * tmpvar_112) * (3.0 - (2.0 * tmpvar_112)));
    highp float tmpvar_113;
    tmpvar_113 = (tmpvar_111.x + (tmpvar_111.y * 57.0));
    highp vec2 pos_114;
    pos_114 = (v_position.xz + ViewPositionAndTime.w);
    highp vec2 fp_115;
    highp vec2 tmpvar_116;
    tmpvar_116 = floor(pos_114);
    highp vec2 tmpvar_117;
    tmpvar_117 = fract(pos_114);
    fp_115 = ((tmpvar_117 * tmpvar_117) * (3.0 - (2.0 * tmpvar_117)));
    highp float tmpvar_118;
    tmpvar_118 = (tmpvar_116.x + (tmpvar_116.y * 57.0));
    highp float tmpvar_119;
    tmpvar_119 = ((1.0 - mix (
      mix (fract((sin(tmpvar_113) * 43758.55)), fract((sin(
        (tmpvar_113 + 1.0)
      ) * 43758.55)), fp_110.x)
    , 
      mix (fract((sin(
        (tmpvar_113 + 57.0)
      ) * 43758.55)), fract((sin(
        (tmpvar_113 + 58.0)
      ) * 43758.55)), fp_110.x)
    , fp_110.y)) + mix (mix (
      fract((sin(tmpvar_118) * 43758.55))
    , 
      fract((sin((tmpvar_118 + 1.0)) * 43758.55))
    , fp_115.x), mix (
      fract((sin((tmpvar_118 + 57.0)) * 43758.55))
    , 
      fract((sin((tmpvar_118 + 58.0)) * 43758.55))
    , fp_115.x), fp_115.y));
    if (!(waterd_1)) {
      diffuse_2.xyz = ((vec3(0.28, 0.58, 0.95) * diffuse_2.xyz) + ((diffuse_2.xyz * 
        max (0.0, tmpvar_119)
      ) * v_lightmapUV.y));
    };
    diffuse_2.xyz = (diffuse_2.xyz + ((diffuse_2.xyz * 
      (v_lightmapUV.x * v_lightmapUV.x)
    ) * (1.0 - v_lightmapUV.y)));
  };
  highp vec3 tmpvar_120;
  tmpvar_120 = normalize(v_worldpos);
  highp vec3 skyc_121;
  highp vec3 tmpvar_122;
  highp vec3 tmpvar_123;
  tmpvar_123 = (FogColor.xyz * 2.0);
  tmpvar_122 = mix (mix (mix (vec3(0.08, 0.42, 0.88), vec3(0.04, 0.09, 0.20), tmpvar_9), vec3(0.52, 0.36, 0.50), tmpvar_10), tmpvar_123, tmpvar_7);
  highp vec3 tmpvar_124;
  tmpvar_124 = mix (mix (mix (vec3(0.80, 0.96, 1.12), vec3(1.0, 0.44, 0.26), tmpvar_10), (tmpvar_122 + 0.15), tmpvar_9), tmpvar_123, tmpvar_7);
  skyc_121 = mix (mix ((tmpvar_122 * 0.07739938), pow (
    ((0.947867 * tmpvar_122) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_122, vec3(0.04045, 0.04045, 0.04045))
  )), mix ((tmpvar_124 * 0.07739938), pow (
    ((0.947867 * tmpvar_124) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_124, vec3(0.04045, 0.04045, 0.04045))
  )), max (0.0, (
    exp((-(clamp (tmpvar_120.y, 0.0, 1.0)) * 4.5))
   + 
    (exp((-(
      clamp (sqrt(dot (tmpvar_120.zy, tmpvar_120.zy)), 0.0, 1.0)
    ) * 4.0)) * tmpvar_10)
  )));
  if ((FogAndDistanceControl.x == 0.0)) {
    skyc_121 = mix ((FogColor.xyz * 0.07739938), pow ((
      (0.947867 * FogColor.xyz)
     + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (FogColor.xyz, vec3(0.04045, 0.04045, 0.04045))));
  };
  diffuse_2.xyz = mix (diffuse_2.xyz, skyc_121, v_fog.w);
  lowp vec3 color_125;
  color_125 = (diffuse_2.xyz * 5.5);
  diffuse_2.xyz = pow (((
    (((color_125 * (
      (0.25 * color_125)
     + 0.029)) + 0.006) / ((color_125 * (
      (0.25 * color_125)
     + 0.29)) + 0.07))
   - 0.08571429) * vec3(1.199794, 1.199794, 1.199794)), vec3(0.4545454, 0.4545454, 0.4545454));
  diffuse_2.xyz = clamp (diffuse_2.xyz, 0.0, 1.0);
  diffuse_2.xyz = mix (vec3(dot (diffuse_2.xyz, vec3(0.2125, 0.7154, 0.0721))), diffuse_2.xyz, 1.15);
  gl_FragColor = diffuse_2;
}

