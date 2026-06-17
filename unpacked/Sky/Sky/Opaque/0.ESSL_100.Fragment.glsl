varying highp vec4 FogCol;
varying highp vec3 v_color0;
varying highp vec3 v_color1;
varying highp vec3 v_color2;
varying highp vec3 v_color3;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = max (0.0, (v_color3.y / sqrt(
    dot (v_color3, v_color3)
  )));
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (FogCol.x - 0.1);
  tmpvar_2 = clamp ((tmpvar_3 / 0.39), 0.0, 1.0);
  highp float tmpvar_4;
  tmpvar_4 = clamp ((tmpvar_3 / 0.39), 0.0, 1.0);
  highp float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_3 / 0.39), 0.0, 1.0);
  highp float h_6;
  h_6 = (1.0 - (tmpvar_1 * tmpvar_1));
  highp float tmpvar_7;
  tmpvar_7 = (h_6 * h_6);
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) * (tmpvar_7 * tmpvar_7));
  mediump vec3 col_9;
  col_9 = (mix ((v_color0 * 
    (tmpvar_5 * (tmpvar_5 * (3.0 - (2.0 * tmpvar_5))))
  ), mix (
    mix (vec3(0.061, 0.12, 0.21), v_color1, (tmpvar_4 * (tmpvar_4 * (3.0 - 
      (2.0 * tmpvar_4)
    ))))
  , 
    mix (vec3(0.061, 0.12, 0.21), v_color2, (tmpvar_2 * (tmpvar_2 * (3.0 - 
      (2.0 * tmpvar_2)
    ))))
  , 
    (tmpvar_8 * tmpvar_8)
  ), (
    (0.6 * tmpvar_8)
   + 
    (0.4 * tmpvar_7)
  )) * 2.0);
  col_9 = ((col_9 * (1.0 + 
    (col_9 * 0.063)
  )) / (1.0 + col_9));
  mediump vec3 tmpvar_10;
  tmpvar_10 = mix (vec3(dot (col_9, vec3(0.21, 0.71, 0.08))), col_9, 1.091);
  col_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10;
  gl_FragColor = tmpvar_11;
}

