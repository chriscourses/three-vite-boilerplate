#include utils/perlin;

// attribute values provided automatically by Three.js
attribute vec3 position;
attribute vec2 uv;
attribute vec3 normal;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform float time;

// the "v" prefix stands for varying since you cannot have two 
// variables of the same name (one from attribute and one from varying)
varying vec3 vPosition;
varying vec2 vUv;
varying vec3 vNormal;

void main () {
   vPosition = position;
   vUv = uv;
   vNormal = normal;

   // Compute Perlin noise value at the current vertex's position
   float noiseScale = 10.0;
   float noiseAmplitude = 5.0;
   vec3 noisePosition = position * noiseScale + vec3(time, 0.0, time); // Add time if you want to animate the terrain
   float noiseValue = perlinNoise(noisePosition);

   // Modulate the height (Y-axis) using the noise value
   vec3 newPosition = vec3(position.x, position.y + noiseValue * noiseAmplitude, position.z);

   gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}