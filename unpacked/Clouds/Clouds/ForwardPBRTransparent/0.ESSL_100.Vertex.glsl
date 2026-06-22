attribute highp vec4 a_color0;
attribute highp vec3 a_position;
varying highp vec4 v_color0;
uniform highp mat4 u_proj;
uniform highp mat4 u_view;
uniform mat4 u_model[4];
uniform highp vec4 DistanceControl;
uniform highp vec4 SubPixelOffset;
uniform highp vec4 CloudColor;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = a_position;
  highp vec3 tmpvar_3;
  tmpvar_3 = (u_model[0] * tmpvar_2).xyz;
  highp mat4 offsetProj_4;
  offsetProj_4 = u_proj;
  highp vec4 tmpvar_5;
  tmpvar_5.yzw = u_proj[2].yzw;
  tmpvar_5.x = (u_proj[2].x + SubPixelOffset.x);
  offsetProj_4[2] = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.xzw = offsetProj_4[2].xzw;
  tmpvar_6.y = (offsetProj_4[2].y - SubPixelOffset.y);
  offsetProj_4[2] = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3;
  tmpvar_1 = (a_color0 * CloudColor);
  tmpvar_1.w = (tmpvar_1.w * clamp ((1.0 - 
    max (((sqrt(
      dot (tmpvar_3, tmpvar_3)
    ) / DistanceControl.x) - 0.9), 0.0)
  ), 0.0, 1.0));
  v_color0 = tmpvar_1;
  gl_Position = (offsetProj_4 * (u_view * tmpvar_7));
}
