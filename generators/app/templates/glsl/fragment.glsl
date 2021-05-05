#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform vec4 u_mouse;
uniform float u_time;

<% if(rayMarcher){ %>
#define MAX_STEPS 100
#define SURFACE_DIST 0.001
#define MAX_DIST 100.0
<% } %>

float t;

mat2 Rot2d(float a) {
  float s = sin(a);
  float c = cos(a);
  return mat2(c, - s, s, c);
}

<% if(rayMarcher){ %>
float differenceSdf(float a, float b){
  return max(a,-b);
}

float intersectSdf(float a, float b){
  return max(a, b);
}

float unionSdf(float a, float b){
  return min(a, b);
}

float sdSphere(vec3 p, vec4 sphere) {
  return length(p - sphere.xyz) - sphere.w;
}

float sdBox(vec3 p, vec3 box) {
  p = abs(p) - box;
  return length(max(p, 0.0)) + min(max(p.x, max(p.y, p.z)), 0.0);
}

float sdGyroid(vec3 p, float scale, float thickness, float bias) {
  p *= scale;
  return abs(dot(sin(p), cos(p.zxy)) + bias) / scale - thickness;
}

float sdAAPlane(vec3 p){
  return p.y;
}
//
vec3 Transform(vec3 p) {
  return p;
}

float GetDist(vec3 p){
  // replace with your scene
  float d = sdSphere(p, vec4(0,1,3,1));
  return d;
}

vec3 GetNormal(vec3 p) {
  vec2 e = vec2(0.02, 0);
  float d = GetDist(p);
  vec3 n = d-vec3(GetDist(p - e.xyy), GetDist(p - e.yxy), GetDist(p - e.yyx));
  return normalize(n);
}

vec3 GetRayDir(vec2 uv, vec3 p, vec3 l, float z) {
  vec3 f = normalize(l - p),
  r = normalize(cross(vec3(0, 1, 0), f)),
  u = cross(f, r),
  c = p+f * z,
  i = c+uv.x * r+uv.y * u,
  d = normalize(i - p);
  return d;
}

float RayMarch(vec3 ro, vec3 rd) {
  float dO = 0.0;
  for(int i = 0; i < MAX_STEPS; i ++ ) {
    vec3 p = ro + dO * rd;
    float ds = GetDist(p);
    dO += ds;
    if (dO < SURFACE_DIST||dO > MAX_DIST) {
      break;
    }
  }
  return dO;
}

vec3 render(vec2 uv){
  vec3 color = vec3(0);
  
  // camera
  vec3 camO = vec3(0, 3, -3);
  vec3 lookAt = vec3(0, 0, 0);
  camO.yz *= Rot2d(-u_mouse.y*3.14+1.);
  camO.xz *= Rot2d(-u_mouse.x*6.2831);
  vec3 rd = GetRayDir(uv, camO, lookAt, 1.0);
  
  // trace scene
  float d = RayMarch(camO, rd);

  // material
  if (d < MAX_DIST) {
    vec3 p = camO + rd * d;
    vec3 n = GetNormal(p);
    float height = p.y;
    float dif = dot(n, normalize(vec3(1,2,3)))*.5+.5;
    color += dif;
  }
  return color;
}

<% } %>
void main(){
  t = u_time / 5.0;
  vec2 uv = (gl_FragCoord.xy-0.5 * u_resolution) / u_resolution.y;
  <% if(rayMarcher){%>
  vec3 color = render(uv);
  color = pow(color, vec3(.4545)); //correct gamma
  <% } else { %>
  vec3 color= 0.5 + 0.5 * cos(u_time + uv.xyx + vec3(0,2,4));
  <% } %>
  gl_FragColor=vec4(color,1.0);
}