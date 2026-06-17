attribute highp vec3 a_position;
varying highp vec4 v_fogColor;
varying highp vec4 v_fogDistControl;
varying highp vec4 v_position;
uniform highp mat4 u_modelViewProj;
uniform highp vec4 FogAndDistanceControl;
uniform highp vec4 ViewPositionAndTime;
uniform highp vec4 FogColor;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.x = a_position.x;
  tmpvar_1.y = (a_position.y + 0.205);
  tmpvar_1.z = a_position.z;
  gl_Position = (u_modelViewProj * tmpvar_1);
  v_position.xyz = a_position;
  v_position.w = ViewPositionAndTime.w;
  v_fogColor = FogColor;
  v_fogDistControl = FogAndDistanceControl;
}

