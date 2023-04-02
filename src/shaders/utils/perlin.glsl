#define PI 3.14159265358979
#define MODULUS vec3(0.1031, 0.11369, 0.13787)

// ----------------------------------------------------------------------------
// Function: hash33
// Description:
//   Takes a 3D input vector and returns a 3D output vector with pseudo-random
//   values in the range of [-1, 1]. It's used for generating spatially coherent,
//   deterministic noise patterns, e.g., in Perlin noise calculations.
// ----------------------------------------------------------------------------

vec3 hash33(vec3 inputVector) {
    // Apply a modulus to the input vector
    vec3 modulatedInput = fract(inputVector * MODULUS);

    // Calculate dot product with a rotated and offset version of the input vector
    float dotProduct = dot(modulatedInput, modulatedInput.yxz + 19.19);

    // Add the dot product to the input vector and apply a fract function
    vec3 fractVec = fract(vec3(
        (modulatedInput.x + modulatedInput.y) * modulatedInput.z,
        (modulatedInput.x + modulatedInput.z) * modulatedInput.y,
        (modulatedInput.y + modulatedInput.z) * modulatedInput.x
    ) + dotProduct);

    // Remap the values from [0, 1] to [-1, 1]
    return -1.0 + 2.0 * fractVec;
}

// ----------------------------------------------------------------------------
// Function: perlinNoise
// Description:
//   Takes a 3D position vector and returns a Perlin noise value in the range
//   of [-1, 1]. Perlin noise is a gradient noise function that generates
//   spatially coherent, continuous, and smooth noise patterns. It's widely used
//   in procedural texture generation, terrain generation, and other graphical
//   applications.
// ----------------------------------------------------------------------------

float perlinNoise(vec3 position) {
    // Calculate integer and fractional parts of the position
    vec3 integerPos = floor(position);
    vec3 fractionalPos = position - integerPos;

    // Compute the smoothstep (interpolation) values
    vec3 smoothstepValues = fractionalPos * fractionalPos * (3.0 - 2.0 * fractionalPos);

    // Calculate gradient values at each corner of the unit cube
    vec3 hashedGradient000 = hash33(integerPos + vec3(0, 0, 0));
    vec3 hashedGradient100 = hash33(integerPos + vec3(1, 0, 0));
    vec3 hashedGradient010 = hash33(integerPos + vec3(0, 1, 0));
    vec3 hashedGradient110 = hash33(integerPos + vec3(1, 1, 0));
    vec3 hashedGradient001 = hash33(integerPos + vec3(0, 0, 1));
    vec3 hashedGradient101 = hash33(integerPos + vec3(1, 0, 1));
    vec3 hashedGradient011 = hash33(integerPos + vec3(0, 1, 1));
    vec3 hashedGradient111 = hash33(integerPos + vec3(1, 1, 1));

    // Compute dot products at each corner of the unit cube
    float dot000 = dot(fractionalPos - vec3(0, 0, 0), hashedGradient000);
    float dot100 = dot(fractionalPos - vec3(1, 0, 0), hashedGradient100);
    float dot010 = dot(fractionalPos - vec3(0, 1, 0), hashedGradient010);
    float dot110 = dot(fractionalPos - vec3(1, 1, 0), hashedGradient110);
    float dot001 = dot(fractionalPos - vec3(0, 0, 1), hashedGradient001);
    float dot101 = dot(fractionalPos - vec3(1, 0, 1), hashedGradient101);
    float dot011 = dot(fractionalPos - vec3(0, 1, 1), hashedGradient011);
    float dot111 = dot(fractionalPos - vec3(1, 1, 1), hashedGradient111);

    // Trilinear interpolation of dot products
    float xInterp000_100 = mix(dot000, dot100, smoothstepValues.x);
    float xInterp010_110 = mix(dot010, dot110, smoothstepValues.x);
    float xInterp001_101 = mix(dot001, dot101, smoothstepValues.x);
    float xInterp011_111 = mix(dot011, dot111, smoothstepValues.x);

    float zInterpBottom = mix(xInterp000_100, xInterp001_101, smoothstepValues.z);
    float zInterpTop = mix(xInterp010_110, xInterp011_111, smoothstepValues.z);

    float finalInterp = mix(zInterpBottom, zInterpTop, smoothstepValues.y);
    return finalInterp;
}