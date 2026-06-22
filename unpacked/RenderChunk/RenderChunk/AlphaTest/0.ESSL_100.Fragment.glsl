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
  lowp vec4 diffuse_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_MatTexture, v_texcoord0);
  if ((tmpvar_2.w < 0.5)) {
    discard;
  };
  diffuse_1.xyz = (tmpvar_2 * v_color0).xyz;
  diffuse_1.w = 1.0;
  // sRGB -> linear
  diffuse_1.xyz = mix ((diffuse_1.xyz * 0.07739938), pow ((
    (0.947867 * diffuse_1.xyz)
   + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (diffuse_1.xyz, vec3(0.04045, 0.04045, 0.04045))));
  // Screen-space derivatives for ambient occlusion normal
  highp vec3 tmpvar_3;
  tmpvar_3 = dFdx(v_position);
  highp vec3 tmpvar_4;
  tmpvar_4 = dFdy(v_position);
  // Sample lightmap at full sky brightness to read sky-light level
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (s_LightMapTexture, vec2(0.0, 1.0));
  // Rain factor (smoothstepped): 1.0 = raining/nether/end, 0.0 = clear
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((FogAndDistanceControl.x - 0.6) / -0.3), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - (2.0 * tmpvar_7))));
  // Night factor: rises as FogColor.r drops
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((1.0 - (FogColor.x * 1.5)), 0.0, 1.0), 1.2);
  // Dusk factor: red channel exceeds blue near sunrise/sunset
  highp float tmpvar_9;
  tmpvar_9 = (clamp (((FogColor.x - 0.15) * 1.25), 0.0, 1.0) * (1.0 - FogColor.z));
  // Torch brightness
  lowp float edge0_10;
  edge0_10 = (tmpvar_5.x * v_lightmapUV.y);
  lowp float tmpvar_11;
  tmpvar_11 = clamp (((v_lightmapUV.x - edge0_10) / (1.0 - edge0_10)), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = max ((v_lightmapUV.x * (tmpvar_11 *
    (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))), ((v_lightmapUV.x * tmpvar_6) * v_lightmapUV.y));
  // Torch colour: amber-warm
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((vec3(1.0, 0.48, 0.06) * tmpvar_12) + ((tmpvar_12 * tmpvar_12) *
    ((tmpvar_12 * tmpvar_12) * tmpvar_12)));
  // Lightmap sky-level factors for ambient colour selection
  lowp vec3 almap_14;
  lowp float tmpvar_15;
  tmpvar_15 = clamp (((tmpvar_5.x - 0.3) / 0.2), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_5.x - 1.0) / -0.2), 0.0, 1.0);
  // Golden-hour factor: peaks during dawn/dusk sky transition
  lowp float tmpvar_17;
  tmpvar_17 = (min ((tmpvar_15 * (tmpvar_15 * (3.0 - (2.0 * tmpvar_15)))),
    (tmpvar_16 * (tmpvar_16 * (3.0 - (2.0 * tmpvar_16))))) * (1.0 - tmpvar_6));
  // Night/deep-dark factor
  lowp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_5.x - 1.0) / -0.8), 0.0, 1.0);
  lowp float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_18 * (tmpvar_18 * (3.0 - (2.0 * tmpvar_18)))) * 1.5), 0.0, 1.0);
  // Emissive-block and sky-exposure thresholds
  highp float tmpvar_20;
  tmpvar_20 = clamp (((v_lightmapUV.y - 0.94) / -0.01999998), 0.0, 1.0);
  lowp float edge0_21;
  edge0_21 = (tmpvar_5.x * v_lightmapUV.y);
  lowp float tmpvar_22;
  tmpvar_22 = clamp (((v_lightmapUV.x - edge0_21) / (1.0 - edge0_21)), 0.0, 1.0);
  // AO factor: 0.40 floor (was 0.20 — leaves far less crushed in shadow)
  lowp float tmpvar_23;
  tmpvar_23 = mix (((
    mix (1.0, 0.40, max (0.0, abs(normalize(
      ((tmpvar_3.yzx * tmpvar_4.zxy) - (tmpvar_3.zxy * tmpvar_4.yzx))
    ).x)))
   * (1.0 - (tmpvar_20 * (tmpvar_20 * (3.0 - (2.0 * tmpvar_20)))))
  ) * (1.0 - tmpvar_6)), 1.0, (tmpvar_22 * (tmpvar_22 * (3.0 - (2.0 * tmpvar_22)))));
  highp vec2 tmpvar_24;
  tmpvar_24.x = 0.0;
  tmpvar_24.y = v_lightmapUV.y;
  // Sky-bounce base — increased for richer indirect light
  lowp vec3 tmpvar_25;
  tmpvar_25 = (texture2D (s_LightMapTexture, tmpvar_24).xyz * 0.22);
  almap_14 = tmpvar_25;
  // Emissive block glow
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2DLod (s_MatTexture, v_texcoord0, 0.0);
  bool tmpvar_27;
  if ((tmpvar_26.w > 0.91)) {
    tmpvar_27 = (texture2DLod (s_MatTexture, v_texcoord0, 0.0).w < 0.93);
  } else {
    tmpvar_27 = bool(0);
  };
  almap_14 = (tmpvar_25 + (float(tmpvar_27) * 3.0));
  almap_14 = (almap_14 + tmpvar_13);
  // Sky-facing ambient colour — properly time-of-day dependent:
  //   Full day  → cool white-blue sky light
  //   Dawn/dusk → warm golden
  //   Night     → deep moonlight blue
  almap_14 = (almap_14 + (mix (
    mix (vec3(0.92, 0.94, 1.0), vec3(1.0, 0.72, 0.42), tmpvar_17)
  , vec3(0.06, 0.12, 0.28), tmpvar_19) * tmpvar_23));
  diffuse_1.xyz = (diffuse_1.xyz * almap_14);
  // Rain / wet-surface ripple effect
  if ((FogAndDistanceControl.x == 0.0)) {
    highp vec2 pos_28;
    pos_28 = ((v_position.xz * 1.3) - (ViewPositionAndTime.w * 1.5));
    highp vec2 fp_29;
    highp vec2 tmpvar_30;
    tmpvar_30 = floor(pos_28);
    highp vec2 tmpvar_31;
    tmpvar_31 = fract(pos_28);
    fp_29 = ((tmpvar_31 * tmpvar_31) * (3.0 - (2.0 * tmpvar_31)));
    highp float tmpvar_32;
    tmpvar_32 = (tmpvar_30.x + (tmpvar_30.y * 57.0));
    highp vec2 pos_33;
    pos_33 = (v_position.xz + ViewPositionAndTime.w);
    highp vec2 fp_34;
    highp vec2 tmpvar_35;
    tmpvar_35 = floor(pos_33);
    highp vec2 tmpvar_36;
    tmpvar_36 = fract(pos_33);
    fp_34 = ((tmpvar_36 * tmpvar_36) * (3.0 - (2.0 * tmpvar_36)));
    highp float tmpvar_37;
    tmpvar_37 = (tmpvar_35.x + (tmpvar_35.y * 57.0));
    // Rain tint: cooler slate-blue (was over-cyan)
    diffuse_1.xyz = ((vec3(0.28, 0.58, 0.95) * diffuse_1.xyz) + ((diffuse_1.xyz *
      max (0.0, ((1.0 - mix (
        mix (fract((sin(tmpvar_32) * 43758.55)), fract((sin(
          (tmpvar_32 + 1.0)
        ) * 43758.55)), fp_29.x)
      ,
        mix (fract((sin(
          (tmpvar_32 + 57.0)
        ) * 43758.55)), fract((sin(
          (tmpvar_32 + 58.0)
        ) * 43758.55)), fp_29.x)
      , fp_29.y)) + mix (mix (
        fract((sin(tmpvar_37) * 43758.55))
      ,
        fract((sin((tmpvar_37 + 1.0)) * 43758.55))
      , fp_34.x), mix (
        fract((sin((tmpvar_37 + 57.0)) * 43758.55))
      ,
        fract((sin((tmpvar_37 + 58.0)) * 43758.55))
      , fp_34.x), fp_34.y)))
    ) * v_lightmapUV.y));
    diffuse_1.xyz = (diffuse_1.xyz + ((diffuse_1.xyz *
      (v_lightmapUV.x * v_lightmapUV.x)
    ) * (1.0 - v_lightmapUV.y)));
  };
  // Sky colour for fog/distance blend — improved palette
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(v_worldpos);
  highp vec3 skyc_39;
  highp vec3 tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = (FogColor.xyz * 2.0);
  // Lower atmosphere: richer day blue, deeper night indigo, muted dusk purple
  tmpvar_40 = mix (mix (mix (vec3(0.08, 0.42, 0.88), vec3(0.04, 0.09, 0.20), tmpvar_8), vec3(0.52, 0.36, 0.50), tmpvar_9), tmpvar_41, tmpvar_6);
  // Upper atmosphere: warm orange dusk glow (not pink)
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (mix (mix (vec3(0.80, 0.96, 1.12), vec3(1.0, 0.44, 0.26), tmpvar_9), (tmpvar_40 + 0.15), tmpvar_8), tmpvar_41, tmpvar_6);
  skyc_39 = mix (mix ((tmpvar_40 * 0.07739938), pow (
    ((0.947867 * tmpvar_40) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_40, vec3(0.04045, 0.04045, 0.04045))
  )), mix ((tmpvar_42 * 0.07739938), pow (
    ((0.947867 * tmpvar_42) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_42, vec3(0.04045, 0.04045, 0.04045))
  )), max (0.0, (
    exp((-(clamp (tmpvar_38.y, 0.0, 1.0)) * 4.5))
   +
    (exp((-(
      clamp (sqrt(dot (tmpvar_38.zy, tmpvar_38.zy)), 0.0, 1.0)
    ) * 4.0)) * tmpvar_9)
  )));
  if ((FogAndDistanceControl.x == 0.0)) {
    skyc_39 = mix ((FogColor.xyz * 0.07739938), pow ((
      (0.947867 * FogColor.xyz)
     + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (FogColor.xyz, vec3(0.04045, 0.04045, 0.04045))));
  };
  diffuse_1.xyz = mix (diffuse_1.xyz, skyc_39, v_fog.w);
  // Hable filmic tone mapping — exposure 5.5 (was 5.0)
  lowp vec3 color_43;
  color_43 = (diffuse_1.xyz * 5.5);
  diffuse_1.xyz = pow (((
    (((color_43 * (
      (0.25 * color_43)
     + 0.029)) + 0.006) / ((color_43 * (
      (0.25 * color_43)
     + 0.29)) + 0.07))
   - 0.08571429) * vec3(1.199794, 1.199794, 1.199794)), vec3(0.4545454, 0.4545454, 0.4545454));
  diffuse_1.xyz = clamp (diffuse_1.xyz, 0.0, 1.0);
  // Saturation 1.15 (was 1.1)
  diffuse_1.xyz = mix (vec3(dot (diffuse_1.xyz, vec3(0.2125, 0.7154, 0.0721))), diffuse_1.xyz, 1.15);
  gl_FragColor = diffuse_1;
}
