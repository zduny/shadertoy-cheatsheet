struct Sphere {
    vec3 origin;
    float radius;
};
    
vec3 sphereNormal(in Sphere sphere, in vec3 position) {
    return normalize(position - sphere.origin);
}

bool isPositionInsideSphere(in vec3 position, in Sphere sphere) {
	return length(position - sphere.origin) < sphere.radius; 