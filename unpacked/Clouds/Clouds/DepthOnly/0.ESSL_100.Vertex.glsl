attribute highp vec3 a_position;
varying highp vec4 v_color0;
uniform highp mat4 u_viewProj;
uniform mat4 u_model[4];
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = a_position;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = (u_model[0] * tmpvar_2).xyz;
  tmpvar_1 = (u_viewProj * tmpvar_3);
  tmpvar_1.z = clamp (tmpvar_1.z, 0.0, 1.0);
  v_color0 = vec4(0.0, 0.0, 0.0, 0.0);
  gl_Position = tmpvar_1;
}

