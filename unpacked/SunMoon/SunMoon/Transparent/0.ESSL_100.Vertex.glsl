attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
varying highp vec2 v_texcoord0;
uniform highp mat4 u_modelViewProj;
void main ()
{
  highp vec3 pos_1;
  v_texcoord0 = a_texcoord0;
  pos_1.y = a_position.y;
  pos_1.xz = (a_position.xz * 1.45);
  highp vec2 tmpvar_2;
  tmpvar_2.x = ((pos_1.x * 0.9510565) - (pos_1.z * -0.3090171));
  tmpvar_2.y = ((pos_1.x * -0.3090171) + (pos_1.z * 0.9510565));
  pos_1.xz = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = pos_1;
  gl_Position = (u_modelViewProj * tmpvar_3);
}

