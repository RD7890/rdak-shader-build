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
  diffuse_1.xyz = (texture2D (s_MatTexture, v_texcoord0) * v_color0).xyz;
  diffuse_1.w = 1.0;
  // sRGB -> linear
  diffuse_1.xyz = mix ((diffuse_1.xyz * 0.07739938), pow ((
    (0.947867 * diffuse_1.xyz)
   + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (diffuse_1.xyz, vec3(0.04045, 0.04045, 0.04045))));
  // Screen-space derivatives for ambient occlusion normal
  highp vec3 tmpvar_2;
  tmpvar_2 = dFdx(v_position);
  highp vec3 tmpvar_3;
  tmpvar_3 = dFdy(v_position);
  // Sample lightmap at full sky brightness to read sky-light level
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (s_LightMapTexture, vec2(0.0, 1.0));
  // Rain factor (smoothstepped): 1.0 = raining/nether/end, 0.0 = clear
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = clamp (((FogAndDistanceControl.x - 0.6) / -0.3), 0.0, 1.0);
  tmpvar_5 = (tmpvar_6 * (tmpvar_6 * (3.0 - (2.0 * tmpvar_6))));
  // Night factor: rises as FogColor.r drops (sky dims at night)
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((1.0 - (FogColor.x * 1.5)), 0.0, 1.0), 1.2);
  // Dusk factor: red channel exceeds blue near sunrise/sunset
  highp float tmpvar_8;
  tmpvar_8 = (clamp (((FogColor.x - 0.15) * 1.25), 0.0, 1.0) * (1.0 - FogColor.z));
  // Torch brightness — rises sharply toward block-light=1, falls in daylight
  lowp float edge0_9;
  edge0_9 = (tmpvar_4.x * v_lightmapUV.y);
  lowp float tmpvar_10;
  tmpvar_10 = clamp (((v_lightmapUV.x - edge0_9) / (1.0 - edge0_9)), 0.0, 1.0);
  lowp float tmpvar_11;
  tmpvar_11 = max ((v_lightmapUV.x * (tmpvar_10 *
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10))))), ((v_lightmapUV.x * tmpvar_5) * v_lightmapUV.y));
  // Torch colour: amber-warm — more realistic than the previous pure orange
  lowp vec3 tmpvar_12;
  tmpvar_12 = ((vec3(1.0, 0.48, 0.06) * tmpvar_11) + ((tmpvar_11 * tmpvar_11) *
    ((tmpvar_11 * tmpvar_11) * tmpvar_11)));
  // Lightmap sky-level factors for ambient colour selection
  lowp vec3 almap_13;
  lowp float tmpvar_14;
  tmpvar_14 = clamp (((tmpvar_4.x - 0.3) / 0.2), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = clamp (((tmpvar_4.x - 1.0) / -0.2), 0.0, 1.0);
  // Golden-hour factor: peaks when sky light is in mid-range (dawn/dusk transition)
  lowp float tmpvar_16;
  tmpvar_16 = (min ((tmpvar_14 * (tmpvar_14 * (3.0 - (2.0 * tmpvar_14)))),
    (tmpvar_15 * (tmpvar_15 * (3.0 - (2.0 * tmpvar_15))))) * (1.0 - tmpvar_5));
  // Night/deep-dark factor
  lowp float tmpvar_17;
  tmpvar_17 = clamp (((tmpvar_4.x - 1.0) / -0.8), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = clamp (((tmpvar_17 * (tmpvar_17 * (3.0 - (2.0 * tmpvar_17)))) * 1.5), 0.0, 1.0);
  // Emissive-block and sky-exposure thresholds
  highp float tmpvar_19;
  tmpvar_19 = clamp (((v_lightmapUV.y - 0.94) / -0.01999998), 0.0, 1.0);
  lowp float edge0_20;
  edge0_20 = (tmpvar_4.x * v_lightmapUV.y);
  lowp float tmpvar_21;
  tmpvar_21 = clamp (((v_lightmapUV.x - edge0_20) / (1.0 - edge0_20)), 0.0, 1.0);
  // AO factor: 0.40 floor (was 0.20 — far less aggressive face-darkening)
  lowp float tmpvar_22;
  tmpvar_22 = mix (((
    mix (1.0, 0.40, max (0.0, abs(normalize(
      ((tmpvar_2.yzx * tmpvar_3.zxy) - (tmpvar_2.zxy * tmpvar_3.yzx))
    ).x)))
   * (1.0 - (tmpvar_19 * (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))))
  ) * (1.0 - tmpvar_5)), 1.0, (tmpvar_21 * (tmpvar_21 * (3.0 - (2.0 * tmpvar_21)))));
  highp vec2 tmpvar_23;
  tmpvar_23.x = 0.0;
  tmpvar_23.y = v_lightmapUV.y;
  // Sky-bounce base — slightly increased for richer indirect light
  lowp vec3 tmpvar_24;
  tmpvar_24 = (texture2D (s_LightMapTexture, tmpvar_23).xyz * 0.22);
  almap_13 = tmpvar_24;
  // Emissive block glow (ore veins etc.)
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DLod (s_MatTexture, v_texcoord0, 0.0);
  bool tmpvar_26;
  if ((tmpvar_25.w > 0.91)) {
    tmpvar_26 = (texture2DLod (s_MatTexture, v_texcoord0, 0.0).w < 0.93);
  } else {
    tmpvar_26 = bool(0);
  };
  almap_13 = (tmpvar_24 + (float(tmpvar_26) * 3.0));
  almap_13 = (almap_13 + tmpvar_12);
  // Sky-facing ambient colour — corrected per time-of-day:
  //   Full day  → cool white-blue  (was broken: used orange like a torch)
  //   Dawn/dusk → warm golden
  //   Night     → deep moonlight blue
  almap_13 = (almap_13 + (mix (
    mix (vec3(0.92, 0.94, 1.0), vec3(1.0, 0.72, 0.42), tmpvar_16)
  , vec3(0.06, 0.12, 0.28), tmpvar_18) * tmpvar_22));
  diffuse_1.xyz = (diffuse_1.xyz * almap_13);
  // Rain / wet-surface ripple effect (Nether/End: FogAndDistanceControl.x == 0)
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
    // Rain tint: cooler, more natural slate-blue (was over-cyan)
    diffuse_1.xyz = ((vec3(0.28, 0.58, 0.95) * diffuse_1.xyz) + ((diffuse_1.xyz *
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
  // Sky colour for fog/distance blend — full improved palette
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(v_worldpos);
  highp vec3 skyc_38;
  highp vec3 tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = (FogColor.xyz * 2.0);
  // Lower atmosphere: richer day blue, deeper night indigo, muted dusk purple
  tmpvar_39 = mix (mix (mix (vec3(0.08, 0.42, 0.88), vec3(0.04, 0.09, 0.20), tmpvar_7), vec3(0.52, 0.36, 0.50), tmpvar_8), tmpvar_40, tmpvar_5);
  // Upper atmosphere / sun-disc glow: warm orange dusk instead of pink
  highp vec3 tmpvar_41;
  tmpvar_41 = mix (mix (mix (vec3(0.80, 0.96, 1.12), vec3(1.0, 0.44, 0.26), tmpvar_8), (tmpvar_39 + 0.15), tmpvar_7), tmpvar_40, tmpvar_5);
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
  // Hable filmic tone mapping — exposure 5.5 (was 5.0, richer midtones)
  lowp vec3 color_42;
  color_42 = (diffuse_1.xyz * 5.5);
  diffuse_1.xyz = pow (((
    (((color_42 * (
      (0.25 * color_42)
     + 0.029)) + 0.006) / ((color_42 * (
      (0.25 * color_42)
     + 0.29)) + 0.07))
   - 0.08571429) * vec3(1.199794, 1.199794, 1.199794)), vec3(0.4545454, 0.4545454, 0.4545454));
  diffuse_1.xyz = clamp (diffuse_1.xyz, 0.0, 1.0);
  // Saturation 1.15 (was 1.1 — slightly more vibrant colours)
  diffuse_1.xyz = mix (vec3(dot (diffuse_1.xyz, vec3(0.2125, 0.7154, 0.0721))), diffuse_1.xyz, 1.15);
  gl_FragColor = diffuse_1;
}
