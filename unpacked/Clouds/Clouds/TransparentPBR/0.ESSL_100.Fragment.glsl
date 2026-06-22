varying highp vec4 v_color0;
varying highp vec3 cPos;
uniform highp vec4 FogColor;
uniform highp vec4 FogAndDistanceControl;

#define saturate(x) clamp(x, 0.0, 1.0)

void main() {
    highp vec3 norm = normalize(cross(dFdx(cPos), dFdy(cPos)));

    highp float fTop    = saturate( norm.y);
    highp float fBottom = saturate(-norm.y);

    highp float iNight = pow(saturate(1.0 - FogColor.r * 1.5), 1.2);
    highp float iRain  = smoothstep(0.6, 0.3, FogAndDistanceControl.x);
    highp float iDusk  = saturate((FogColor.r - FogColor.g) * 3.5);

    highp vec3 dayCol = vec3(0.82, 0.86, 0.92);
    dayCol = mix(dayCol, vec3(1.00, 1.00, 0.98), fTop);
    dayCol = mix(dayCol, vec3(0.50, 0.55, 0.68), fBottom);

    highp vec3 duskCol = vec3(0.88, 0.54, 0.34);
    duskCol = mix(duskCol, vec3(1.00, 0.70, 0.38), fTop);
    duskCol = mix(duskCol, vec3(0.36, 0.26, 0.28), fBottom);

    highp vec3 nightCol = vec3(0.22, 0.26, 0.40);
    nightCol = mix(nightCol, vec3(0.35, 0.40, 0.60), fTop);
    nightCol = mix(nightCol, vec3(0.08, 0.10, 0.18), fBottom);

    highp vec3 rainCol = vec3(0.52, 0.54, 0.58);
    rainCol = mix(rainCol, vec3(0.72, 0.74, 0.78), fTop);
    rainCol = mix(rainCol, vec3(0.26, 0.28, 0.32), fBottom);

    highp vec3 col = dayCol;
    col = mix(col, duskCol,  iDusk);
    col = mix(col, nightCol, iNight);
    col = mix(col, rainCol,  iRain);

    gl_FragColor = mix(v_color0, vec4(col, 1.0), v_color0.w);
}
