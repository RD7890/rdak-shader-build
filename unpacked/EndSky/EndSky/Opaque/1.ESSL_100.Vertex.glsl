attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
attribute highp vec4 i_data0;
attribute highp vec4 i_data1;
attribute highp vec4 i_data2;
attribute highp vec4 i_data3;
varying highp vec4 v_posTime;
varying highp vec3 v_sPos;
varying highp vec2 v_texcoord0;
uniform highp mat4 u_viewProj;
uniform highp vec4 ViewPositionAndTime;
void main ()
{
  highp vec3 wPos_1;
  highp mat4 tmpvar_2;
  tmpvar_2[0] = i_data0;
  tmpvar_2[1] = i_data1;
  tmpvar_2[2] = i_data2;
  tmpvar_2[3] = i_data3;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = a_position;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * tmpvar_3).xyz;
  wPos_1.y = tmpvar_4.y;
  wPos_1.xz = -(tmpvar_4.xz);
  v_texcoord0 = (2.0 * a_texcoord0);
  v_sPos = a_position;
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = wPos_1;
  tmpvar_5.w = ViewPositionAndTime.w;
  v_posTime = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_4;
  gl_Position = (u_viewProj * tmpvar_6);
}

