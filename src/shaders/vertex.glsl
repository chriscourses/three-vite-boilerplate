attribute vec3 position;
attribute vec2 uv;
attribute vec3 normal;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

varying vec2 vUv;
varying vec3 vNormal;

void main () {
   vUv = uv;
   vNormal = normal;
   gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}