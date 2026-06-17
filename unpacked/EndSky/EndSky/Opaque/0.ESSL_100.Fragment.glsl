varying highp vec4 v_posTime;
uniform highp vec4 ViewPositionAndTime;
void main ()
{
  mediump vec3 color_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize(v_posTime.xyz);
  highp float t_3;
  highp vec3 sky_4;
  highp vec3 v_5;
  t_3 = (v_posTime.w * 0.2);
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (min (abs(
    (tmpvar_2.x / tmpvar_2.z)
  ), 1.0) / max (abs(
    (tmpvar_2.x / tmpvar_2.z)
  ), 1.0));
  highp float tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  tmpvar_8 = (((
    ((((
      ((((-0.01213232 * tmpvar_8) + 0.05368138) * tmpvar_8) - 0.1173503)
     * tmpvar_8) + 0.1938925) * tmpvar_8) - 0.3326756)
   * tmpvar_8) + 0.9999793) * tmpvar_7);
  tmpvar_8 = (tmpvar_8 + (float(
    (abs((tmpvar_2.x / tmpvar_2.z)) > 1.0)
  ) * (
    (tmpvar_8 * -2.0)
   + 1.570796)));
  tmpvar_6 = (tmpvar_8 * sign((tmpvar_2.x / tmpvar_2.z)));
  if ((abs(tmpvar_2.z) > (1e-08 * abs(tmpvar_2.x)))) {
    if ((tmpvar_2.z < 0.0)) {
      if ((tmpvar_2.x >= 0.0)) {
        tmpvar_6 += 3.141593;
      } else {
        tmpvar_6 = (tmpvar_6 - 3.141593);
      };
    };
  } else {
    tmpvar_6 = (sign(tmpvar_2.x) * 1.570796);
  };
  v_5.xz = tmpvar_2.xz;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((abs(tmpvar_2.y) / 2.5), 0.0, 1.0);
  v_5.y = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp float s_10;
  highp float tmpvar_11;
  tmpvar_11 = sin(((tmpvar_6 * 6.0) + (t_3 * 1.1)));
  s_10 = (tmpvar_11 * tmpvar_11);
  s_10 = (s_10 * (0.5 + (0.7 * 
    cos(((tmpvar_6 * 4.0) - (1.1 * t_3)))
  )));
  highp float tmpvar_12;
  highp float edge0_13;
  edge0_13 = (0.59 - s_10);
  highp float tmpvar_14;
  tmpvar_14 = clamp (((v_5.y - edge0_13) / (-0.7 - edge0_13)), 0.0, 1.0);
  tmpvar_12 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  highp float s_15;
  highp float tmpvar_16;
  tmpvar_16 = sin(((tmpvar_6 * 6.0) + (t_3 * 0.8)));
  s_15 = (tmpvar_16 * tmpvar_16);
  s_15 = (s_15 * (0.5 + (0.7 * 
    cos(((tmpvar_6 * 2.0) - (1.1 * t_3)))
  )));
  highp float tmpvar_17;
  highp float edge0_18;
  edge0_18 = (0.59 - s_15);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((v_5.y - edge0_18) / (-0.7 - edge0_18)), 0.0, 1.0);
  tmpvar_17 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  highp float tmpvar_20;
  tmpvar_20 = (0.5 + (0.5 * sin(
    (((3.0 * tmpvar_6) + t_3) + ((10.0 * tmpvar_2.x) * tmpvar_2.y))
  )));
  highp float tmpvar_21;
  tmpvar_21 = (((0.7 * 
    (0.5 + (0.5 * cos((
      (((5.0 * tmpvar_6) + (0.5 * t_3)) + (5.0 * tmpvar_20))
     + 
      (0.1 * sin(((40.0 * tmpvar_6) - (4.0 * t_3))))
    ))))
  ) * tmpvar_20) + (0.3 * tmpvar_20));
  highp float tmpvar_22;
  tmpvar_22 = (0.5 + (0.5 * tmpvar_2.y));
  highp float tmpvar_23;
  tmpvar_23 = (tmpvar_21 * (1.0 - (
    (tmpvar_22 * tmpvar_22)
   * tmpvar_22)));
  highp float edge0_24;
  edge0_24 = (1.0 - tmpvar_21);
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_2.y - edge0_24) / (-1.0 - edge0_24)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_2.y - 1.0) / -1.5), 0.0, 1.0);
  highp float tmpvar_27;
  tmpvar_27 = ((0.66 * (tmpvar_23 + 
    ((1.0 - tmpvar_23) * (tmpvar_25 * (tmpvar_25 * (3.0 - 
      (2.0 * tmpvar_25)
    ))))
  )) + (0.7 * (tmpvar_26 * 
    (tmpvar_26 * (3.0 - (2.0 * tmpvar_26)))
  )));
  sky_4 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (min (abs(
    (tmpvar_2.z / tmpvar_2.x)
  ), 1.0) / max (abs(
    (tmpvar_2.z / tmpvar_2.x)
  ), 1.0));
  highp float tmpvar_30;
  tmpvar_30 = (tmpvar_29 * tmpvar_29);
  tmpvar_30 = (((
    ((((
      ((((-0.01213232 * tmpvar_30) + 0.05368138) * tmpvar_30) - 0.1173503)
     * tmpvar_30) + 0.1938925) * tmpvar_30) - 0.3326756)
   * tmpvar_30) + 0.9999793) * tmpvar_29);
  tmpvar_30 = (tmpvar_30 + (float(
    (abs((tmpvar_2.z / tmpvar_2.x)) > 1.0)
  ) * (
    (tmpvar_30 * -2.0)
   + 1.570796)));
  tmpvar_28 = (tmpvar_30 * sign((tmpvar_2.z / tmpvar_2.x)));
  if ((abs(tmpvar_2.x) > (1e-08 * abs(tmpvar_2.z)))) {
    if ((tmpvar_2.x < 0.0)) {
      if ((tmpvar_2.z >= 0.0)) {
        tmpvar_28 += 3.141593;
      } else {
        tmpvar_28 = (tmpvar_28 - 3.141593);
      };
    };
  } else {
    tmpvar_28 = (sign(tmpvar_2.z) * 1.570796);
  };
  highp float tmpvar_31;
  tmpvar_31 = sqrt(((tmpvar_2.x * tmpvar_2.x) + (tmpvar_2.z * tmpvar_2.z)));
  highp vec2 tmpvar_32;
  tmpvar_32.x = (tmpvar_28 + (t_3 * 0.6));
  tmpvar_32.y = tmpvar_31;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_2.y - -0.5) / 1.5), 0.0, 1.0);
  highp float tmpvar_34;
  tmpvar_34 = (0.7 * (tmpvar_33 * (tmpvar_33 * 
    (3.0 - (2.0 * tmpvar_33))
  )));
  sky_4 = ((vec3(0.175, 0.105, 0.28) * max (0.0, 
    ((sin((
      (tmpvar_32.x + (pow (tmpvar_31, 0.2) * 10.0))
     * 6.0)) + (pow (
      (1.0 - tmpvar_31)
    , 10.0) * 10.0)) - (tmpvar_31 * 2.0))
  )) * (tmpvar_34 * tmpvar_34));
  sky_4 = (sky_4 + mix (vec3(0.02, 0.007, 0.04), vec3(0.25, 0.15, 0.4), (tmpvar_27 * tmpvar_27)));
  sky_4 = (sky_4 + ((
    (vec3(2.565, 1.539, 4.104) * (tmpvar_12 * tmpvar_12))
   * 
    (tmpvar_12 * tmpvar_12)
  ) + (
    (vec3(2.3275, 1.6625, 1.5295) * (tmpvar_17 * tmpvar_17))
   * 
    (tmpvar_17 * tmpvar_17)
  )));
  highp float tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_2 * 87.0);
  highp vec3 p3_37;
  p3_37 = (fract(tmpvar_36) * 0.05);
  highp vec3 tmpvar_38;
  tmpvar_38 = fract((p3_37 * vec3(0.1031, 0.11369, 0.13787)));
  p3_37 = (tmpvar_38 + dot (tmpvar_38, (tmpvar_38.yzx + 19.19)));
  highp vec3 p3_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = fract((floor(tmpvar_36) * vec3(0.1031, 0.11369, 0.13787)));
  p3_39 = (tmpvar_40 + dot (tmpvar_40, (tmpvar_40.yzx + 19.19)));
  highp float tmpvar_41;
  tmpvar_41 = clamp (((
    fract(((p3_39.x + p3_39.y) * p3_39.z))
   - 0.95) / 0.05000001), 0.0, 1.0);
  highp vec3 x_42;
  x_42 = (fract(tmpvar_36) - 0.5);
  highp float tmpvar_43;
  tmpvar_43 = clamp (((
    sqrt(dot (x_42, x_42))
   - 0.6) / -0.6), 0.0, 1.0);
  tmpvar_35 = (((tmpvar_43 * 
    (tmpvar_43 * (3.0 - (2.0 * tmpvar_43)))
  ) * (tmpvar_41 * 
    (tmpvar_41 * (3.0 - (2.0 * tmpvar_41)))
  )) * ((
    cos((sin((ViewPositionAndTime.w * 1.2)) + (fract(
      ((p3_37.x + p3_37.y) * p3_37.z)
    ) * 14.0)))
   * 0.7) + 0.5));
  highp vec3 p3_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = fract((abs(tmpvar_2) * vec3(0.1031, 0.11369, 0.13787)));
  p3_44 = (tmpvar_45 + dot (tmpvar_45, (tmpvar_45.yzx + 19.19)));
  highp vec3 tmpvar_46;
  tmpvar_46.x = (tmpvar_35 * 0.7);
  tmpvar_46.y = (tmpvar_35 * fract((
    (p3_44.x + p3_44.y)
   * p3_44.z)));
  tmpvar_46.z = (tmpvar_35 * 0.9);
  highp float tmpvar_47;
  tmpvar_47 = clamp (((tmpvar_2.y - -0.5) / 1.5), 0.0, 1.0);
  highp float tmpvar_48;
  tmpvar_48 = (0.7 * (tmpvar_47 * (tmpvar_47 * 
    (3.0 - (2.0 * tmpvar_47))
  )));
  color_1 = (sky_4 + (tmpvar_46 * (tmpvar_48 * tmpvar_48)));
  mediump vec3 col_49;
  col_49 = (color_1 * 1.953);
  col_49 = (col_49 * 0.85);
  mediump vec3 tmpvar_50;
  tmpvar_50 = pow (clamp ((
    (col_49 * ((1.04 * col_49) + 0.03))
   / 
    ((col_49 * ((0.93 * col_49) + 0.56)) + 0.14)
  ), 0.0, 1.0), vec3(0.831, 0.831, 0.831));
  mediump vec3 tmpvar_51;
  tmpvar_51 = mix (vec3(dot (tmpvar_50, vec3(0.21, 0.71, 0.08))), tmpvar_50, 1.56);
  col_49 = tmpvar_51;
  color_1 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = tmpvar_51;
  gl_FragColor = tmpvar_52;
}

