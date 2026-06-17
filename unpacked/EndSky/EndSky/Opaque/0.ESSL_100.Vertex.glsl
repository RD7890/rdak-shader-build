attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
varying highp vec4 v_posTime;
varying highp vec3 v_sPos;
varying highp vec2 v_texcoord0;
uniform highp mat4 u_viewProj;
uniform mat4 u_model[4];
uniform highp vec4 ViewPositionAndTime;
void main ()
{
  highp vec3 wPos_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = a_position;
  highp vec3 tmpvar_3;
  tmpvar_3 = (u_model[0] * tmpvar_2).xyz;
  wPos_1.y = tmpvar_3.y;
  wPos_1.xz = -(tmpvar_3.xz);
  v_texcoord0 = (2.0 * a_texcoord0);
  v_sPos = a_position;
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = wPos_1;
  tmpvar_4.w = ViewPositionAndTime.w;
  v_posTime = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  gl_Position = (u_viewProj * tmpvar_5);
}

