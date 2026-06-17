varying highp vec4 v_color0;
uniform highp vec4 StarsColor;
void main ()
{
  highp vec4 starColor_1;
  lowp vec4 starColor_2;
  starColor_2 = v_color0;
  starColor_2.x = max(starColor_2.x,47.0);
  starColor_2.y = max(starColor_2.y,47.0);
  starColor_2.z = max(starColor_2.z,47.0);
  
  starColor_1.w = v_color0.w*39.5;
  
  
  
  starColor_1.xyz = (v_color0.xyz * (vec3(StarsColor.x, StarsColor.y*50.3, StarsColor.z*50.3) * v_color0.w))*starColor_2.xyz;
  gl_FragColor = starColor_1;
}
      
    
