attribute highp vec4 a_color0;
attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
attribute highp vec2 a_texcoord1;
attribute highp vec4 i_data0;
attribute highp vec4 i_data1;
attribute highp vec4 i_data2;
varying highp vec4 v_color0;
varying highp vec4 v_fog;
varying highp vec2 v_lightmapUV;
varying highp vec3 v_position;
varying highp vec2 v_texcoord0;
varying highp vec3 v_worldpos;
uniform highp mat4 u_viewProj;
uniform highp vec4 FogAndDistanceControl;
uniform highp vec4 ViewPositionAndTime;
uniform highp vec4 FogColor;
void main ()
{
  highp vec4 fogColor_1;
  highp mat4 tmpvar_2;
  tmpvar_2[0] = i_data0;
  tmpvar_2[1] = i_data1;
  tmpvar_2[2] = i_data2;
  tmpvar_2[3] = vec4(0.0, 0.0, 0.0, 1.0);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = a_position;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * tmpvar_3).xyz;
  v_position = a_position;
  v_worldpos = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (ViewPositionAndTime.xyz - tmpvar_4);
  fogColor_1.xyz = FogColor.xyz;
  fogColor_1.w = clamp (((
    (sqrt(dot (tmpvar_5, tmpvar_5)) / FogAndDistanceControl.z)
   - FogAndDistanceControl.x) / (FogAndDistanceControl.y - FogAndDistanceControl.x)), 0.0, 1.0);
  v_texcoord0 = a_texcoord0;
  v_lightmapUV = a_texcoord1;
  v_color0 = a_color0;
  v_fog = fogColor_1;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_4;
  gl_Position = (u_viewProj * tmpvar_6);
}

