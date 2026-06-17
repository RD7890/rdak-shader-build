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
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = a_position;
  highp vec3 tmpvar_3;
  tmpvar_3 = (u_model[0] * tmpvar_2).xyz;
  v_position = a_position;
  v_worldpos = tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (ViewPositionAndTime.xyz - tmpvar_3);
  fogColor_1.xyz = FogColor.xyz;
  fogColor_1.w = clamp (((
    (sqrt(dot (tmpvar_4, tmpvar_4)) / FogAndDistanceControl.z)
   - FogAndDistanceControl.x) / (FogAndDistanceControl.y - FogAndDistanceControl.x)), 0.0, 1.0);
  v_texcoord0 = a_texcoord0;
  v_lightmapUV = a_texcoord1;
  v_color0 = a_color0;
  v_fog = fogColor_1;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  gl_Position = (u_viewProj * tmpvar_5);
}

