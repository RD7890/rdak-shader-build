attribute highp vec3 a_position;
attribute highp vec4 i_data1;
attribute highp vec4 i_data2;
attribute highp vec4 i_data3;
varying highp vec4 v_color0;
uniform highp mat4 u_viewProj;
void main ()
{
  highp vec4 tmpvar_1;
  highp mat4 model_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.x = i_data1.x;
  tmpvar_3.y = i_data2.x;
  tmpvar_3.z = i_data3.x;
  model_2[0] = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.x = i_data1.y;
  tmpvar_4.y = i_data2.y;
  tmpvar_4.z = i_data3.y;
  model_2[1] = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.x = i_data1.z;
  tmpvar_5.y = i_data2.z;
  tmpvar_5.z = i_data3.z;
  model_2[2] = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = i_data1.w;
  tmpvar_6.y = i_data2.w;
  tmpvar_6.z = i_data3.w;
  model_2[3] = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = a_position;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (model_2 * tmpvar_7).xyz;
  tmpvar_1 = (u_viewProj * tmpvar_8);
  tmpvar_1.z = clamp (tmpvar_1.z, 0.0, 1.0);
  v_color0 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = tmpvar_1;
}

