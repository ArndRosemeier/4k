precision highp float;
uniform float t;
uniform vec2 R;
float S,k,L,W=1.;vec3 G,p;
mat2 r(float a){float c=cos(a),s=sin(a);return mat2(c,s,-s,c);}
vec3 P(float x){return .5+.5*cos(6.28*(x+vec3(0,.33,.67)));}
float m(vec3 p){
  vec3 q=p;
  p.xy*=r(p.z*.05+S);
  p.z=mod(p.z,8.)-4.;
  float s=1.;
  for(int i=0;i<4;i++){
    p=abs(p)-vec3(1.6,1.3,1.)-.3*sin(S*1.7);
    p.xy*=r(.4+S*.6);
    p.xz*=r(.2+S*.3);
    p*=1.3;s*=1.3;
  }
  vec3 a=abs(p)-vec3(.4,.4,3.);
  L=(length(p.xy+.5)-.03)/s;
  float d=min(length(max(a,0.))+min(max(a.x,max(a.y,a.z)),0.),length(p.xz)-.2)/s;
  d=max(d,2.2+.4*sin(q.z*.2)-length(q.xy));
  L=max(L,.6-length(q.xy));
  return min(d,L);
}
float M(vec3 o,vec3 d){
  float z=0.,h;
  for(int i=0;i<110;i++){
    p=o+d*z;h=m(p);
    G+=W*P(p.z*.02+t*.05+S)*(.1+k+pow(.5+.5*sin(p.z*.4-t*9.),12.))*.0004/(.0004+L*L)*exp(-z*.09);
    if(h<.001||z>60.)break;
    z+=h*.8;
  }
  return z;
}
void main(){
  vec2 u=(gl_FragCoord.xy-.5*R)/R.y;
  float T=mod(t,64.),B=floor(T/2.),z;
  k=B>3.&&B<30.?exp(-fract(T*2.)*5.):0.;
  S=floor(t/16.)*1.3+sin(t*.25)*.15;
  float w=pow(mod(t,16.)/16.,6.);vec3 o=vec3(0,0,t*3.+w*60.),d=normalize(vec3(u*r(t*.1),1.-k*.25-w*.7+.3*length(u))),c=vec3(0);
  d.xz*=r(sin(t*.3)*.3);
  z=M(o,d);
  if(z<60.){
    vec2 e=vec2(.003,0);
    vec3 n=normalize(m(p)-vec3(m(p-e.xyy),m(p-e.yxy),m(p-e.yyx))),l=normalize(vec3(.5,.8,-.6));
    c=(P(S+.6)*.05+vec3(.04,.05,.07))*(.2+max(dot(n,l),0.))+pow(max(dot(reflect(d,n),l),0.),20.)*.5+pow(1.+dot(n,d),5.)*P(p.z*.02+S)*.6;
    W=.5*exp(-z*.06);c*=W+W;M(p+n*.01,reflect(d,n));
  }
  c+=G*.08;
  c+=exp(-mod(t,16.)*2.);c*=min(t*.3,1.);
  c*=1.-.6*dot(u,u);c+=(fract(sin(dot(u,vec2(12.9,78.2))+t)*43758.)-.5)*.05;
  gl_FragColor=vec4(pow(c/(1.+c),vec3(.75)),1);
}
