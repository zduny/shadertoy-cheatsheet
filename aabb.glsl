struct AABB {
    vec3 min;
    vec3 max;
};
    
AABB createCubeAABB(in vec3 middle, in float size) {
    vec3 halfSize = vec3(size / 2.0);

    return AABB(middle - halfSize, middle + halfSize);
}

vec3 getAABBnormal(in AABB aabb, in vec3 pos) {
    const float epsilon = 0.0001;

    vec3 d1 = abs(aabb.min - pos);
    vec3 d2 = abs(aabb.max - pos);
    
    vec3 n = -1.0 * vec3(lessThan(d1, vec3(epsilon)));
	n += vec3(lessThan(d2, vec3(epsilon)));

    return normalize(n);
}

vec3 getAABBcenter(in AABB aabb) {
    return (aabb.min + aabb.max) * .5;
}
    
bool isPositionInsideAABB(in vec3 position, in AABB aabb) {
  vec3 s = step(aabb.min, position) - step(aabb.max, position);
  
  return (s.x * s.y * s.z) > 0.0; 
}