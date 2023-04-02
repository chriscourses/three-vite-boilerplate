precision highp float;
#include utils/perlin;

varying vec3 vPosition;
varying vec2 vUv;
varying vec3 vNormal;

void main () {
   float noise = perlinNoise(vec3(vPosition.z * 5.0));
   gl_FragColor = vec4(vec3(noise) ,1.0);
}