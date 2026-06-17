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
  highp vec3 worldPos_2;
  highp mat4 tmpvar_3;
  tmpvar_3[0] = i_data0;
  tmpvar_3[1] = i_data1;
  tmpvar_3[2] = i_data2;
  tmpvar_3[3] = vec4(0.0, 0.0, 0.0, 1.0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = a_position;
  worldPos_2 = ((tmpvar_3 * tmpvar_4).xyz + vec3(0.5, 0.5, 0.5));
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((worldPos_2 - ViewPositionAndTime.xyz));
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = tmpvar_5.z;
  tmpvar_6.z = -(tmpvar_5.x);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(tmpvar_6);
  worldPos_2 = (worldPos_2 - ((
    ((tmpvar_5.yzx * tmpvar_7.zxy) - (tmpvar_5.zxy * tmpvar_7.yzx))
   * 
    (a_color0.z - 0.5)
  ) + (tmpvar_7 * 
    (a_color0.x - 0.5)
  )));
  v_position = a_position;
  v_worldpos = worldPos_2;
  highp vec3 tmpvar_8;
  tmpvar_8 = (ViewPositionAndTime.xyz - worldPos_2);
  fogColor_1.xyz = FogColor.xyz;
  fogColor_1.w = clamp (((
    (sqrt(dot (tmpvar_8, tmpvar_8)) / FogAndDistanceControl.z)
   - FogAndDistanceControl.x) / (FogAndDistanceControl.y - FogAndDistanceControl.x)), 0.0, 1.0);
  v_texcoord0 = a_texcoord0;
  v_lightmapUV = a_texcoord1;
  v_color0 = vec4(1.0, 1.0, 1.0, 1.0);
  v_fog = fogColor_1;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldPos_2;
  gl_Position = (u_viewProj * tmpvar_9);
}

