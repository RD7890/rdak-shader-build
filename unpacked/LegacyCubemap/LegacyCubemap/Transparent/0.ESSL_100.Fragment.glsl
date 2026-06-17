varying highp vec4 v_fogColor;
varying highp vec4 v_fogDistControl;
varying highp vec4 v_position;
void main ()
{
  highp vec4 color_1;
  highp vec3 tmpvar_2;
  tmpvar_2.x = v_position.x;
  tmpvar_2.yz = -(v_position.yz);
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize(tmpvar_2);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((v_fogDistControl.x - 0.6) / -0.3), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  highp float tmpvar_6;
  tmpvar_6 = pow (clamp ((1.0 - 
    (v_fogColor.x * 1.5)
  ), 0.0, 1.0), 1.2);
  highp float tmpvar_7;
  tmpvar_7 = (clamp ((
    (v_fogColor.x - 0.15)
   * 1.25), 0.0, 1.0) * (1.0 - v_fogColor.z));
  highp float tmpvar_8;
  highp vec2 pos_9;
  highp float den_10;
  highp float tot_11;
  den_10 = clamp ((1.0 - tmpvar_4), 0.0, 1.0);
  pos_9 = ((tmpvar_3 / tmpvar_3.y).xz * 1.6);
  pos_9 = (pos_9 + (v_position.w * 0.001));
  highp vec2 fp_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = floor(pos_9);
  highp vec2 tmpvar_14;
  tmpvar_14 = fract(pos_9);
  fp_12 = ((tmpvar_14 * tmpvar_14) * (3.0 - (2.0 * tmpvar_14)));
  highp float tmpvar_15;
  tmpvar_15 = (tmpvar_13.x + (tmpvar_13.y * 57.0));
  tot_11 = (mix (mix (
    fract((sin(tmpvar_15) * 43758.55))
  , 
    fract((sin((tmpvar_15 + 1.0)) * 43758.55))
  , fp_12.x), mix (
    fract((sin((tmpvar_15 + 57.0)) * 43758.55))
  , 
    fract((sin((tmpvar_15 + 58.0)) * 43758.55))
  , fp_12.x), fp_12.y) * den_10);
  den_10 = (den_10 * 0.5);
  pos_9 = (pos_9 * 2.5);
  pos_9 = (pos_9 + tot_11);
  highp float tmpvar_16;
  tmpvar_16 = (v_position.w * 0.1);
  pos_9 = (pos_9 + tmpvar_16);
  highp vec2 fp_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = floor(pos_9);
  highp vec2 tmpvar_19;
  tmpvar_19 = fract(pos_9);
  fp_17 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
  highp float tmpvar_20;
  tmpvar_20 = (tmpvar_18.x + (tmpvar_18.y * 57.0));
  tot_11 = (tot_11 + (mix (
    mix (fract((sin(tmpvar_20) * 43758.55)), fract((sin(
      (tmpvar_20 + 1.0)
    ) * 43758.55)), fp_17.x)
  , 
    mix (fract((sin(
      (tmpvar_20 + 57.0)
    ) * 43758.55)), fract((sin(
      (tmpvar_20 + 58.0)
    ) * 43758.55)), fp_17.x)
  , fp_17.y) * den_10));
  den_10 = (den_10 * 0.5);
  pos_9 = (pos_9 * 2.5);
  pos_9 = (pos_9 + tot_11);
  pos_9 = (pos_9 + tmpvar_16);
  highp vec2 fp_21;
  highp vec2 tmpvar_22;
  tmpvar_22 = floor(pos_9);
  highp vec2 tmpvar_23;
  tmpvar_23 = fract(pos_9);
  fp_21 = ((tmpvar_23 * tmpvar_23) * (3.0 - (2.0 * tmpvar_23)));
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_22.x + (tmpvar_22.y * 57.0));
  tot_11 = (tot_11 + (mix (
    mix (fract((sin(tmpvar_24) * 43758.55)), fract((sin(
      (tmpvar_24 + 1.0)
    ) * 43758.55)), fp_21.x)
  , 
    mix (fract((sin(
      (tmpvar_24 + 57.0)
    ) * 43758.55)), fract((sin(
      (tmpvar_24 + 58.0)
    ) * 43758.55)), fp_21.x)
  , fp_21.y) * den_10));
  den_10 = (den_10 * 0.5);
  pos_9 = (pos_9 * 2.5);
  pos_9 = (pos_9 + tot_11);
  pos_9 = (pos_9 + tmpvar_16);
  highp vec2 fp_25;
  highp vec2 tmpvar_26;
  tmpvar_26 = floor(pos_9);
  highp vec2 tmpvar_27;
  tmpvar_27 = fract(pos_9);
  fp_25 = ((tmpvar_27 * tmpvar_27) * (3.0 - (2.0 * tmpvar_27)));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_26.x + (tmpvar_26.y * 57.0));
  tot_11 = (tot_11 + (mix (
    mix (fract((sin(tmpvar_28) * 43758.55)), fract((sin(
      (tmpvar_28 + 1.0)
    ) * 43758.55)), fp_25.x)
  , 
    mix (fract((sin(
      (tmpvar_28 + 57.0)
    ) * 43758.55)), fract((sin(
      (tmpvar_28 + 58.0)
    ) * 43758.55)), fp_25.x)
  , fp_25.y) * den_10));
  den_10 = (den_10 * 0.5);
  pos_9 = (pos_9 * 2.5);
  pos_9 = (pos_9 + tot_11);
  pos_9 = (pos_9 + tmpvar_16);
  tmpvar_8 = (1.0 - pow (0.1, max (0.0, 
    (1.0 - tot_11)
  )));
  highp vec3 skyc_29;
  highp vec3 tmpvar_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (v_fogColor.xyz * 2.0);
  tmpvar_30 = mix (mix (mix (vec3(0.0, 0.4, 0.9), vec3(0.065, 0.15, 0.25), tmpvar_6), vec3(0.5, 0.4, 0.6), tmpvar_7), tmpvar_31, tmpvar_4);
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (mix (mix (vec3(0.75, 0.98, 1.15), vec3(1.0, 0.4, 0.5), tmpvar_7), (tmpvar_30 + 0.15), tmpvar_6), tmpvar_31, tmpvar_4);
  skyc_29 = mix (mix ((tmpvar_30 * 0.07739938), pow (
    ((0.947867 * tmpvar_30) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_30, vec3(0.04045, 0.04045, 0.04045))
  )), mix ((tmpvar_32 * 0.07739938), pow (
    ((0.947867 * tmpvar_32) + 0.0521327)
  , vec3(2.4, 2.4, 2.4)), vec3(
    greaterThanEqual (tmpvar_32, vec3(0.04045, 0.04045, 0.04045))
  )), max (0.0, (
    exp((-(clamp (tmpvar_3.y, 0.0, 1.0)) * 4.5))
   + 
    (exp((-(
      clamp (sqrt(dot (tmpvar_3.zy, tmpvar_3.zy)), 0.0, 1.0)
    ) * 4.0)) * tmpvar_7)
  )));
  if ((v_fogDistControl.x == 0.0)) {
    skyc_29 = mix ((v_fogColor.xyz * 0.07739938), pow ((
      (0.947867 * v_fogColor.xyz)
     + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (v_fogColor.xyz, vec3(0.04045, 0.04045, 0.04045))));
  };
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = skyc_29;
  tmpvar_33.w = exp((-(
    clamp (tmpvar_3.y, 0.0, 1.0)
  ) * 5.0));
  highp vec3 tmpvar_34;
  tmpvar_34 = mix (mix (mix (vec3(0.85, 1.0, 1.1), vec3(0.9, 0.6, 0.3), tmpvar_7), vec3(0.15, 0.2, 0.29), tmpvar_6), (v_fogColor.xyz * 2.0), tmpvar_4);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = mix ((tmpvar_34 * 0.07739938), pow ((
    (0.947867 * tmpvar_34)
   + 0.0521327), vec3(2.4, 2.4, 2.4)), vec3(greaterThanEqual (tmpvar_34, vec3(0.04045, 0.04045, 0.04045))));
  tmpvar_35.w = tmpvar_8;
  highp float tmpvar_36;
  tmpvar_36 = clamp (((
    sqrt(dot (tmpvar_3.xz, tmpvar_3.xz))
   - 1.0) / -0.05000001), 0.0, 1.0);
  highp vec4 tmpvar_37;
  tmpvar_37 = mix (tmpvar_33, tmpvar_35, ((tmpvar_8 * 
    (tmpvar_36 * (tmpvar_36 * (3.0 - (2.0 * tmpvar_36))))
  ) * float(
    (tmpvar_3.y >= 0.0)
  )));
  color_1.w = tmpvar_37.w;
  highp vec3 color_38;
  color_38 = (tmpvar_37.xyz * 5.0);
  color_1.xyz = pow (((
    (((color_38 * (
      (0.25 * color_38)
     + 0.029)) + 0.006) / ((color_38 * (
      (0.25 * color_38)
     + 0.29)) + 0.07))
   - 0.08571429) * vec3(1.199794, 1.199794, 1.199794)), vec3(0.4545454, 0.4545454, 0.4545454));
  color_1.xyz = clamp (color_1.xyz, 0.0, 1.0);
  color_1.xyz = mix (vec3(dot (color_1.xyz, vec3(0.2125, 0.7154, 0.0721))), color_1.xyz, 1.1);
  gl_FragColor = color_1;
}

