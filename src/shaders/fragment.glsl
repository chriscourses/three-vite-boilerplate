precision highp float;
varying vec2 vUv;

void main () {
    gl_FragColor = vec4(vec3(vUv.x) ,1.0);
}