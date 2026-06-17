attribute highp vec4 a_color0;
attribute highp vec3 a_position;
varying highp vec4 FogCol;
varying highp float ViewTime;
varying highp vec3 v_color0;
varying highp vec3 v_color1;
varying highp vec3 v_color2;
varying highp vec3 v_color3;
uniform highp mat4 u_modelViewProj;
uniform highp vec4 FogColor;
uniform highp vec4 FogAndDistanceControl;
uniform highp vec4 ViewPositionAndTime;
void main ()
{
  highp vec3 wPos_1;
  highp vec3 pos_2;
  pos_2.xz = a_position.xz;
  pos_2.y = (a_position.y - ((0.4 * a_color0.x) * a_color0.x));
  wPos_1.xz = pos_2.xz;
  wPos_1.y = (pos_2.y + 0.148);
  highp float tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4.y = 1.0;
  tmpvar_4.x = (0.5 + (20.0 / FogAndDistanceControl.z));
  highp vec2 tmpvar_5;
  tmpvar_5 = clamp (((FogAndDistanceControl.xy - tmpvar_4) / (vec2(0.23, 0.7) - tmpvar_4)), vec2(0.0, 0.0), vec2(1.0, 1.0));
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5.x * tmpvar_5.y);
  tmpvar_3 = ((tmpvar_6 * tmpvar_6) * (3.0 - (2.0 * tmpvar_6)));
  if ((((FogAndDistanceControl.x == 0.0) && (FogAndDistanceControl.y < 0.8)) && ((FogColor.z > FogColor.x) || (FogColor.y > FogColor.x)))) {
    highp vec3 tmpvar_7;
    tmpvar_7 = ((vec3(1.8, 2.0, 1.8) * FogColor.xyz) * FogColor.xyz);
    v_color0 = tmpvar_7;
    v_color1 = tmpvar_7;
    v_color2 = tmpvar_7;
  } else {
    highp float tmpvar_8;
    tmpvar_8 = max ((FogColor.x * 0.6), max (FogColor.y, FogColor.z));
    highp float tmpvar_9;
    tmpvar_9 = min (FogColor.y, 0.26);
    v_color0 = mix (((
      (((0.77 * tmpvar_8) * tmpvar_8) + (0.33 * tmpvar_8))
     * vec3(0.0, 0.385, 0.936)) * (1.0 + 
      (0.5 * tmpvar_3)
    )), (tmpvar_9 * (tmpvar_9 * vec3(11.22, 11.88, 13.2))), tmpvar_3);
    highp vec3 horizonCol_10;
    highp float tmpvar_11;
    tmpvar_11 = max ((FogColor.x * 0.65), max ((FogColor.y * 1.1), FogColor.z));
    horizonCol_10 = (((
      ((0.25 * tmpvar_11) * tmpvar_11)
     + 
      (0.4 * tmpvar_11)
    ) + max (
      (FogColor.x - FogColor.z)
    , 0.0)) * vec3(2.9448, 1.2888, 0.3384));
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (horizonCol_10, (vec3(1.4064, 1.634936, 1.96201) * tmpvar_11), (tmpvar_11 * tmpvar_11));
    highp float tmpvar_13;
    tmpvar_13 = clamp (((FogColor.x - 0.1) / 0.39), 0.0, 1.0);
    highp float tmpvar_14;
    tmpvar_14 = clamp (((FogColor.y - 0.49) / 0.11), 0.0, 1.0);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (mix (mix (horizonCol_10, 
      (vec3(0.0857904, 0.397304, 0.8509536) * tmpvar_11)
    , 
      (tmpvar_11 * tmpvar_11)
    ), mix (horizonCol_10, 
      (vec3(2.25024, 2.056856, 2.383929) * tmpvar_11)
    , 
      (tmpvar_11 * tmpvar_11)
    ), (tmpvar_13 * 
      (tmpvar_13 * (3.0 - (2.0 * tmpvar_13)))
    )), tmpvar_12, (tmpvar_14 * (tmpvar_14 * 
      (3.0 - (2.0 * tmpvar_14))
    )));
    highp float tmpvar_16;
    tmpvar_16 = clamp ((tmpvar_3 / 0.2), 0.0, 1.0);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (tmpvar_15, mix (tmpvar_15, tmpvar_12, (tmpvar_16 * 
      (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
    )), FogColor.x);
    horizonCol_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (tmpvar_17, vec3((tmpvar_9 * (tmpvar_9 * 19.6))), tmpvar_3);
    v_color1 = tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (((2.1 * 
      (1.1 - FogColor.z)
    ) * FogColor.y) * (1.0 - tmpvar_3));
    v_color2 = (tmpvar_18 * (vec3((1.0 - tmpvar_19)) + (vec3(1.39, 1.079, 0.797) * tmpvar_19)));
  };
  FogCol = FogColor;
  v_color3 = wPos_1;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = pos_2;
  gl_Position = (u_modelViewProj * tmpvar_20);
  ViewTime = ViewPositionAndTime.w;
}

