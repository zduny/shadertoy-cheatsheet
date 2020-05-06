// Square root of number of samples used for super-sampling
#define SAMPLES 2

vec3 trace(in Ray ray) {
    // Do calculations here and return resulting color for input ray
    
    return vec3(0.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {    
    const float fov = pi / 2.0;
    float step = 1.0 / float(SAMPLES);
    
 
    int i = 0;
    int j = 0;
    vec3 outColor = vec3(0.0, 0.0, 0.0);
    
    for (int sx = 0; sx < SAMPLES; sx++) {
        for (int sy = 0; sy < SAMPLES; sy++) {
            Ray ray = createRayPerspective(iResolution.xy, (fragCoord + vec2(float(sx) * step, float(sy) * step)), fov);
            outColor += trace(ray);          
        }
    }
    
    outColor /= float(SAMPLES * SAMPLES);
    
	fragColor = vec4(toSRGB(outColor), 1.0);
}