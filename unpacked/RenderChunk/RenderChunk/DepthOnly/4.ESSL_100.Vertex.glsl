attribute highp vec4 a_color0;
attribute highp vec3 a_position;
attribute highp vec2 a_texcoord0;
attribute highp vec2 a_texcoord1;
varying highp vec4 v_color0;
varying highp vec4 v_fog;
varying highp vec2 v_lightmapUV;
varying highp vec3 v_position;
varying highp vec2 v_texcoord0;
varying highp vec3 v_worldpos;
uniform highp mat4 u_viewProj;
uniform mat4 u_model[4];
uniform highp vec4 FogAndDistanceControl;
uniform highp vec4 ViewPositionAndTime;
uniform highp vec4 FogColor;
void main ()
{
  highp vec4 fogColor_1;
  highp vec3 worldPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = a_position;
  worldPos_2 = ((u_model[0] * tmpvar_3).xyz + vec3(0.5, 0.5, 0.5));
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((worldPos_2 - ViewPositionAndTime.xyz));
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = tmpvar_4.z;
  tmpvar_5.z = -(tmpvar_4.x);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(tmpvar_5);
  worldPos_2 = (worldPos_2 - ((
    ((tmpvar_4.yzx * tmpvar_6.zxy) - (tmpvar_4.zxy * tmpvar_6.yzx))
   * 
    (a_color0.z - 0.5)
  ) + (tmpvar_6 * 
    (a_color0.x - 0.5)
  )));
  v_position = a_position;
  v_worldpos = worldPos_2;
  highp vec3 tmpvar_7;
  tmpvar_7 = (ViewPositionAndTime.xyz - worldPos_2);
  fogColor_1.xyz = FogColor.xyz;
  fogColor_1.w = clamp (((
    (sqrt(dot (tmpvar_7, tmpvar_7)) / FogAndDistanceControl.z)
   - FogAndDistanceControl.x) / (FogAndDistanceControl.y - FogAndDistanceControl.x)), 0.0, 1.0);
  v_texcoord0 = a_texcoord0;
  v_lightmapUV = a_texcoord1;
  v_color0 = vec4(1.0, 1.0, 1.0, 1.0);
  v_fog = fogColor_1;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = worldPos_2;
  gl_Position = (u_viewProj * tmpvar_8);
}

