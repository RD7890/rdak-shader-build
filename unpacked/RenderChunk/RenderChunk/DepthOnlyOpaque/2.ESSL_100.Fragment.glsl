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
  lowp vec4 diffuse_1;
  diffuse_1.w = 1.0;
  diffuse_1.xyz = vec3(0.9999993, 0.9999993, 0.9999993);
  highp vec3 tmpvar_2;
  tmpvar_2 = dFdx(v_position);
  highp vec3 tmpvar_3;
  tmpvar_3 = dFdy(v_position);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (s_LightMapTexture, vec2(0.0, 1.0));
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((FogAndDistanceControl.x - 0.6) / -0.3), 0.0, 1.0);
  tmpvar_5 = (tmpvar_6 * (tmpvar_6 * (3.0 - 
    (2.0 * tmpvar_6)
  )));
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((1.0 - 
    (FogColor.x * 1.5)
  ), 0.0, 1.0), 1.2);
  highp float tmpvar_8;
  tmpvar_8 = (clamp ((
    (FogColor.x - 0.15)
   * 1.25), 0.0, 1.0) * (1.0 - FogColor.z));
  lowp float edge0_9;
  edge0_9 = (tmpvar_4.x * v_lightmapUV.y);
  lowp float tmpvar_10;
  tmpvar_10 = clamp (((v_lightmapUV.x - edge0_9) / (1.0 - edge0_9)), 0.0, 1.0);
  lowp float tmpvar_11;
  tmpvar_11 = max ((v_lightmapUV.x * (tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  )), ((v_lightmapUV.x * tmpvar_5) * v_lightmapUV.y));
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((vec3(1.0, 0.35, 0.0) * tmpvar_11) + ((tmpvar_11 * tmpvar_11) * (
    (tmpvar_11 * tmpvar_11)
   * tmpvar_11)));
  lowp vec3 almap_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (((tmpvar_4.x - 0.3) / 0.2), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = clamp (((tmpvar_4.x - 1.0) / -0.2), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = (min ((tmpvar_14 * 
    (tmpvar_14 * (3.0 - (2.0 * tmpvar_14)))
  ), (tmpvar_15 * 
    (tmpvar_15 * (3.0 - (2.0 * tmpvar_15)))
  )) * (1.0 - tmpvar_5));
  lowp float tmpvar_17;
  tmpvar_17 = clamp (((tmpvar_4.x - 1.0) / -0.8), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_17 * 
    (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))
  ) * 1.5), 0.0, 1.0);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((v_lightmapUV.y - 0.94) / -0.01999998), 0.0, 1.0);
  lowp float edge0_20;
  edge0_20 = (tmpvar_4.x * v_lightmapUV.y);
  lowp float tmpvar_21;
  tmpvar_21 = clamp (((v_lightmapUV.x - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  lowp float tmpvar_22;
  tmpvar_22 = mix (((
    mix (1.0, 0.2, max (0.0, abs(normalize(
      ((tmpvar_2.yzx * tmpvar_3.zxy) - (tmpvar_2.zxy * tmpvar_3.yzx))
    ).x)))
   * 
    (1.0 - (tmpvar_19 * (tmpvar_19 * (3.0 - 
      (2.0 * tmpvar_19)
    ))))
  ) * (1.0 - tmpvar_5)), 1.0, (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  highp vec2 tmpvar_23;
  tmpvar_23.x = 0.0;
  tmpvar_23.y = v_lightmapUV.y;
  lowp vec3 tmpvar_24;
  tmpvar_24 = (texture2D (s_LightMapTexture, tmpvar_23).xyz * 0.2);
  almap_13 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod    (s_MatTexture, v_texcoord0, 0.0);
  bool tmpvar_26;
  if ((tmpvar_25.w > 0.91)) {
    tmpvar_26 = (texture2DLod    (s_MatTexture, v_texcoord0, 0.0).w < 0.93);
  } else {
    tmpvar_26 = bool(0);
  };
  almap_13 = (tmpvar_24 + (float(tmpvar_26) * 3.0));
  almap_13 = (almap_13 + tmpvar_12);
  almap_13 = (almap_13 + (mix (
    mix (vec3(1.1, 1.1, 0.8), vec3(1.0, 0.5, 0.0), tmpvar_16)
  , vec3(0.05, 0.15, 0.4), tmpvar_18) * tmpvar_22));
  diffuse_1.xyz = (vec3(0.9999993, 0.9999993, 0.9999993) * almap_13);
  if ((FogAndDistanceControl.x == 0.0)) {
    highp vec2 pos_27;
    pos_27 = ((v_position.xz * 1.3) - (ViewPositionAndTime.w * 1.5));
    highp vec2 fp_28;
    highp vec2 tmpvar_29;
    tmpvar_29 = floor(pos_27);
    highp vec2 tmpvar_30;
    tmpvar_30 = fract(pos_27);
    fp_28 = ((tmpvar_30 * tmpvar_30) * (3.0 - (2.0 * tmpvar_30)));
    highp float tmpvar_31;
    tmpvar_31 = (tmpvar_29.x + (tmpvar_29.y * 57.0));
    highp vec2 pos_32;
    pos_32 = (v_position.xz + ViewPositionAndTime.w);
    highp vec2 fp_33;
    highp vec2 tmpvar_34;
    tmpvar_34 = floor(pos_32);
    highp vec2 tmpvar_35;
    tmpvar_35 = fract(pos_32);
    fp_33 = ((tmpvar_35 * tmpvar_35) * (3.0 - (2.0 * tmpvar_35)));
    highp float tmpvar_36;
    tmpvar_36 = (tmpvar_34.x + (tmpvar_34.y * 57.0));
    diffuse_1.xyz = ((vec3(0.3, 0.6, 1.0) * diffuse_1.xyz) + ((diffuse_1.xyz * 
      max (0.0, ((1.0 - mix (
        mix (fract((sin(tmpvar_31) * 43758.55)), fract((sin(
          (tmpvar_31 + 1.0)
        ) * 43758.55)), fp_28.x)
      , 
        mix (fract((sin(
          (tmpvar_31 + 57.0)
        ) * 43758.55)), fract((sin(
          (tmpvar_31 + 58.0)
        ) * 43758.55)), fp_28.x)
      , fp_28.y)) + mix (mix (
        fract((sin(tmpvar_36) * 43758.55))
      , 
        fract((sin((tmpvar_36 + 1.0)) * 43758.55))
      , fp_33.x), mix (
        fract((sin((tmpvar_36 + 57.0)) * 43758.55))
      , 
        fract((sin((tmpvar_36 + 58.0)) * 43758.55))
      , fp_33.x), fp_33.y)))
    ) * v_lightmapUV.y));
    diffuse_1.xyz = (diffuse_1.xyz + ((diffuse_1.xyz * 
      (v_lightmapUV.x * v_lightmapUV.x)
    ) * (1.0 - v_lightmapUV.y)));
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(v_worldpos);
  highp vec3 skyc_38;
  highp vec3 tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (FogColor.xyz * 2.0);
  tmpvar_39 = mix (mix (mix (vec3(0.0, 0.4, 0.9), vec3(0.065, 0.15, 0.25), tmpvar_7), vec3(0.5, 0.4, 0.6), tmpvar_8), tmpvar_40, tmpvar_5);
  highp vec3 tmpvar_41;
  tmpvar_41 = mix (mix (mix (vec3(0.75, 0.98, 1.15), vec3(1.0, 0.4, 0.5), tmpvar_8), (tmpvar_39 + 0.15), tmpvar_7), tmpvar_40, tmpvar_5);
  skyc_38 = mix (mix ((tmpvar_39 * 0.07739938), pow (
    ((0.947867 * tmpvar_39) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_39, vec3(0.04045, 0.04045, 0.04045))
  )), mix ((tmpvar_41 * 0.07739938), pow (
    ((0.947867 * tmpvar_41) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_41, vec3(0.04045, 0.04045, 0.04045))
  )), max (0.0, (
    exp((-(clamp (tmpvar_37.y, 0.0, 1.0)) * 4.5))
   + 
    (exp((-(
      clamp (sqrt(dot (tmpvar_37.zy, tmpvar_37.zy)), 0.0, 1.0)
    ) * 4.0)) * tmpvar_8)
  )));
  if ((FogAndDistanceControl.x == 0.0)) {
    skyc_38 = mix ((FogColor.xyz * 0.07739938), pow ((
      (0.947867 * FogColor.xyz)
     + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (FogColor.xyz, vec3(0.04045, 0.04045, 0.04045))));
  };
  diffuse_1.xyz = mix (diffuse_1.xyz, skyc_38, v_fog.w);
  lowp vec3 color_42;
  color_42 = (diffuse_1.xyz * 5.0);
  diffuse_1.xyz = pow (((
    (((color_42 * (
      (0.25 * color_42)
     + 0.029)) + 0.006) / ((color_42 * (
      (0.25 * color_42)
     + 0.29)) + 0.07))
   - 0.08571429) * vec3(1.199794, 1.199794, 1.199794)), vec3(0.4545454, 0.4545454, 0.4545454));
  diffuse_1.xyz = clamp (diffuse_1.xyz, 0.0, 1.0);
  diffuse_1.xyz = mix (vec3(dot (diffuse_1.xyz, vec3(0.2125, 0.7154, 0.0721))), diffuse_1.xyz, 1.1);
  gl_FragColor = diffuse_1;
}

