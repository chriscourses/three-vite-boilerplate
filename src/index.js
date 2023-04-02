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
let cube

function init() {
  scene = new THREE.Scene()

  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    1,
    10000
  )
  camera.position.z = 1000

  cube = new THREE.Mesh(
    new THREE.BoxGeometry(200, 200, 200),
    new THREE.RawShaderMaterial({
      vertexShader: vertex,
      fragmentShader: fragment,
    })
  )
  scene.add(cube)

  renderer = new THREE.WebGLRenderer({ antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  controls = new OrbitControls(camera, renderer.domElement)

  document.body.appendChild(renderer.domElement)
}

function animate() {
  animationId = requestAnimationFrame(animate)
  renderer.render(scene, camera)

  cube.rotation.x += 0.04
  cube.rotation.y += 0.02
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
