varying highp vec4 v_color0;
varying highp vec3 cPos;
uniform highp vec4 FogColor;
uniform highp vec4 FogAndDistanceControl;

#define saturate(x) clamp(x,0.,1.)
#define iRain smoothstep(.6,.3,FogAndDistanceControl.x)
#define iNight pow(saturate(1.-FogColor.r*1.5),1.2)
#define iDusk (clamp (FogColor.r - FogColor.g, 0.0, 0.5) * 2.0)

void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 NormPos;
  tmpvar_1 = vec4(1);
  NormPos = normalize(cross(dFdx(cPos),dFdy(cPos)));
  
  vec3 CloudCol_1;
  CloudCol_1 = tmpvar_1.xyz;
  CloudCol_1 = mix(mix(
  CloudCol_1*1.1, vec3(0.5, 0.78, 1.0)*0.8, abs(NormPos.z)),
  CloudCol_1*vec3(1.0, 0.95, 0.7) * 0.6, -NormPos.y);

  vec3 CloudCol_2;
  CloudCol_2 = tmpvar_1.xyz;
  CloudCol_2 = mix(mix(
  CloudCol_2*0.9, vec3(1.0, 0.9, 0.45)*0.9, abs(NormPos.z)),
  CloudCol_2*vec3(1.0, 0.48, 0.512) * 1.15, -NormPos.y);

  vec3 CloudCol_3;
  CloudCol_3 = tmpvar_1.xyz;
  CloudCol_3 = mix(mix(
  CloudCol_3*0.4, vec3(0.4, 0.7, 1.0)*0.6, abs(NormPos.x)),
  CloudCol_3*vec3(0.8, 1.0, 0.9)*0.2, -NormPos.y);
  
  vec3 CloudCol_4;
  CloudCol_4 = tmpvar_1.xyz;
  CloudCol_4 = mix(mix(
  CloudCol_4 * 1.1, vec3(1.0, 0.908, 0.912) * 0.8, abs(NormPos.x)),
  CloudCol_4*vec3(1.0, 0.95, 0.7)*0.6, -NormPos.y);
  
  vec3 finalC;
  finalC = mix(CloudCol_1, CloudCol_3, iNight);
  finalC = mix(finalC, mix(finalC, CloudCol_4, iRain), (1.0- iNight));
  finalC = mix(finalC, CloudCol_2, iDusk);
  tmpvar_1.xyz = finalC;
  
  gl_FragColor = mix (v_color0, tmpvar_1, v_color0.w);
}

