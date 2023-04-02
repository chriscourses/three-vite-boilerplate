import './css/style.css'
import * as THREE from 'three'
import { OrbitControls } from 'three/addons/controls/OrbitControls.js'
import vertex from './shaders/vertex.glsl'
import fragment from './shaders/fragment.glsl'

let scene
let camera
let renderer
let animationId
let controls
let torusKnot

function init() {
  scene = new THREE.Scene()

  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    1,
    10000
  )
  camera.position.z = 50

  torusKnot = new THREE.Mesh(
    new THREE.TorusKnotGeometry(10, 3, 100, 16),
    new THREE.RawShaderMaterial({
      vertexShader: vertex,
      fragmentShader: fragment,
    })
  )
  scene.add(torusKnot)

  renderer = new THREE.WebGLRenderer({ antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  controls = new OrbitControls(camera, renderer.domElement)

  document.body.appendChild(renderer.domElement)
}

function animate() {
  animationId = requestAnimationFrame(animate)
  renderer.render(scene, camera)

  torusKnot.rotation.x += 0.01
  torusKnot.rotation.y += 0.01
}

init()
animate()

// Event listeners
function resize() {
  camera.aspect = innerWidth / innerHeight
  camera.updateProjectionMatrix()
  renderer.setSize(innerWidth, innerHeight)
}

addEventListener('resize', resize)
