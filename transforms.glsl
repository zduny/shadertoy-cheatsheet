void transformNormal(inout vec3 normal, in mat4 mat) {
    normal = normalize((mat * vec4(normal, 0.0)).xyz);
}

void transformPosition(inout vec3 pos, in mat4 mat) {
    pos = (mat * vec4(pos, 1.0)).xyz;
}