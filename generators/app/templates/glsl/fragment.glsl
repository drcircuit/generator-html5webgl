#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform float u_time;

void main(){
  vec2 uv = (gl_FragCoord.xy-0.5 * u_resolution) / u_resolution.y;
  vec3 color= 0.5 + 0.5 * cos(u_time + uv.xyx + vec3(0,2,4));
  gl_FragColor=vec4(color,1.0);
}