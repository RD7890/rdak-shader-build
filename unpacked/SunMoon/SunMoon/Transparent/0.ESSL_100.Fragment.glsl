varying highp vec2 v_texcoord0;
uniform highp vec4 SunMoonColor;
uniform sampler2D s_SunMoonTexture;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (s_SunMoonTexture, v_texcoord0);
  color_1.xyz = (tmpvar_2.xyz * SunMoonColor.xyz);
  highp float tmpvar_3;
  tmpvar_3 = (1.0 - SunMoonColor.w);
  color_1.w = (tmpvar_2.w * (1.0 - (
    (tmpvar_3 * tmpvar_3)
   * tmpvar_3)));
  gl_FragColor = color_1;
}

