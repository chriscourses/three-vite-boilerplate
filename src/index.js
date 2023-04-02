import './css/style.css'
import * as THREE from 'three'
import { OrbitControls } from 'three/addons/controls/OrbitControls.js'

import vertex from './shaders/vertex.glsl'
import fragment from './shaders/fragment.glsl'

// Three Scene
let scene, camera, renderer, animationId, controls
let geometry, material, mesh

function init() {
  scene = new THREE.Scene()

  camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    1,
    10000
  )
  camera.position.z = 1000

  geometry = new THREE.BoxGeometry(200, 200, 200)
  material = new THREE.RawShaderMaterial({
    vertexShader: vertex,
    fragmentShader: fragment,
  })

  mesh = new THREE.Mesh(geometry, material)
  scene.add(mesh)

  for (let i = -5; i <= 5; i++) {
    const geometry = new THREE.BoxGeometry(200, 200, 200)
    const material = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      wireframe: true,
    })

    const mesh = new THREE.Mesh(geometry, material)
    scene.add(mesh)
    mesh.position.x = i * 400
  }

  renderer = new THREE.WebGLRenderer({ antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  controls = new OrbitControls(camera, renderer.domElement)

  document.body.appendChild(renderer.domElement)
}

function animate() {
  animationId = requestAnimationFrame(animate)

  mesh.rotation.x += 0.04
  mesh.rotation.y += 0.02

  renderer.render(scene, camera)
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
