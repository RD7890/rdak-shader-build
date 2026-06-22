varying highp vec4 v_color0;
varying highp vec3 cPos;
uniform highp vec4 FogColor;
uniform highp vec4 FogAndDistanceControl;

#define saturate(x) clamp(x, 0.0, 1.0)

void main() {
    // ---- surface normal from screen-space derivatives ----
    highp vec3 norm = normalize(cross(dFdx(cPos), dFdy(cPos)));

    // Face weights — 0..1, cheap, no trig
    highp float fTop    = saturate( norm.y);          // 1.0 on top face
    highp float fBottom = saturate(-norm.y);          // 1.0 on bottom face

    // ---- time-of-day factors (same as original) ----
    highp float iNight = pow(saturate(1.0 - FogColor.r * 1.5), 1.2);
    highp float iRain  = smoothstep(0.6, 0.3, FogAndDistanceControl.x);
    // dusk: FogColor shifts red > green near sunrise/sunset
    highp float iDusk  = saturate((FogColor.r - FogColor.g) * 3.5);

    // ---- DAY ----
    // Top:    bright white with a very faint warm tint (direct sun)
    // Sides:  cool grey-white (sky-bounce)
    // Bottom: blue-grey shadow — this is the key to "real" clouds
    highp vec3 dayTop    = vec3(1.00, 1.00, 0.98);
    highp vec3 daySide   = vec3(0.82, 0.86, 0.92);
    highp vec3 dayBottom = vec3(0.50, 0.55, 0.68);
    highp vec3 dayCol    = daySide;
    dayCol = mix(dayCol, dayTop,    fTop);
    dayCol = mix(dayCol, dayBottom, fBottom);

    // ---- DUSK / SUNRISE ----
    // Top:    orange-gold
    // Sides:  warm coral
    // Bottom: dark plum-grey
    highp vec3 duskTop    = vec3(1.00, 0.70, 0.38);
    highp vec3 duskSide   = vec3(0.88, 0.54, 0.34);
    highp vec3 duskBottom = vec3(0.36, 0.26, 0.28);
    highp vec3 duskCol    = duskSide;
    duskCol = mix(duskCol, duskTop,    fTop);
    duskCol = mix(duskCol, duskBottom, fBottom);

    // ---- NIGHT ----
    // Top:    deep blue-grey (moonlight)
    // Sides:  dark blue
    // Bottom: near-black with a hint of indigo
    highp vec3 nightTop    = vec3(0.35, 0.40, 0.60);
    highp vec3 nightSide   = vec3(0.22, 0.26, 0.40);
    highp vec3 nightBottom = vec3(0.08, 0.10, 0.18);
    highp vec3 nightCol    = nightSide;
    nightCol = mix(nightCol, nightTop,    fTop);
    nightCol = mix(nightCol, nightBottom, fBottom);

    // ---- RAIN ----
    // Desaturated grey throughout, heavy bottoms
    highp vec3 rainTop    = vec3(0.72, 0.74, 0.78);
    highp vec3 rainSide   = vec3(0.52, 0.54, 0.58);
    highp vec3 rainBottom = vec3(0.26, 0.28, 0.32);
    highp vec3 rainCol    = rainSide;
    rainCol = mix(rainCol, rainTop,    fTop);
    rainCol = mix(rainCol, rainBottom, fBottom);

    // ---- blend time-of-day ----
    highp vec3 col = dayCol;
    col = mix(col, duskCol,  iDusk);
    col = mix(col, nightCol, iNight);
    col = mix(col, rainCol,  iRain);

    // v_color0.w carries the distance-fade alpha from the vertex shader
    gl_FragColor = mix(v_color0, vec4(col, 1.0), v_color0.w);
}
