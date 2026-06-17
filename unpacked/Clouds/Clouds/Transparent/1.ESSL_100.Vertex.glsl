attribute highp vec4 a_color0;
attribute highp vec3 a_position;
attribute highp vec4 i_data1;
attribute highp vec4 i_data2;
attribute highp vec4 i_data3;
varying highp vec4 v_color0;
uniform highp mat4 u_proj;
uniform highp mat4 u_view;
uniform highp vec4 DistanceControl;
uniform highp vec4 SubPixelOffset;
uniform highp vec4 CloudColor;
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
  tmpvar_8 = (model_2 * tmpvar_7);
  highp mat4 offsetProj_9;
  offsetProj_9 = u_proj;
  highp vec4 tmpvar_10;
  tmpvar_10.yzw = u_proj[2].yzw;
  tmpvar_10.x = (u_proj[2].x + SubPixelOffset.x);
  offsetProj_9[2] = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xzw = offsetProj_9[2].xzw;
  tmpvar_11.y = (offsetProj_9[2].y - SubPixelOffset.y);
  offsetProj_9[2] = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_8.xyz;
  tmpvar_1 = (a_color0 * CloudColor);
  tmpvar_1.w = (tmpvar_1.w * clamp ((1.0 - 
    max (((sqrt(
      dot (tmpvar_8.xyz, tmpvar_8.xyz)
    ) / DistanceControl.x) - 0.9), 0.0)
  ), 0.0, 1.0));
  v_color0 = tmpvar_1;
  gl_Position = (offsetProj_9 * (u_view * tmpvar_12));
}

