bool rayIntersectsAABB(in Ray ray, in AABB aabb, out float t0, out float t1) {
  vec3 invR = 1.0 / ray.direction;

  vec3 tbot = invR * (aabb.min - ray.origin);
  vec3 ttop = invR * (aabb.max - ray.origin);

  vec3 tmin = min(ttop, tbot);
  vec3 tmax = max(ttop, tbot);

  vec2 t = max(tmin.xx, tmin.yz);
  t0 = max(t.x, t.y);
  t = min(tmax.xx, tmax.yz);
  t1 = min(t.x, t.y);

  return t0 <= t1;
}

bool rayIntersectsSphere(in Ray ray, in Sphere sphere, out float t0,
                         out float t1) {
  float a = dot(ray.direction, ray.direction);
  vec3 s0_r0 = ray.origin - sphere.origin;
  float b = 2.0 * dot(ray.direction, s0_r0);
  float c = dot(s0_r0, s0_r0) - (sphere.radius * sphere.radius);
  float delta = b * b - 4.0 * a * c;
  float a_2 = 2.0 * a;

  if (delta < 0.0) {
    return false;
  }

  float delta_sqrt = sqrt(delta);

  t0 = (-b - delta_sqrt) / a_2;
  t1 = (-b + delta_sqrt) / a_2;

  return true;
}

bool rayIntersectsTriangle(in Ray ray, in vec3 v0, in vec3 v1, in vec3 v2,
                           out float t) {
  vec3 edge1, edge2, h, s, q;
  float a, f, u, v;

  edge1 = v1 - v0;
  edge2 = v2 - v0;

  h = cross(ray.direction, edge2);
  a = dot(edge1, h);

  if (a > -epsilon && a < epsilon)
    return false;

  f = 1.0 / a;
  s = ray.origin - v0;
  u = f * dot(s, h);

  if (u < 0.0 || u > 1.0)
    return false;

  q = cross(s, edge1);
  v = f * dot(ray.direction, q);

  if (v < 0.0 || u + v > 1.0)
    return false;

  // At this stage we can compute t to find out where the intersection point is
  // on the line.
  t = f * dot(edge2, q);
  if (t > epsilon) // ray intersection
  {
    return true;
  }

  // This means that there is a line intersection but not a ray intersection.
  return false;
}

bool AABBintersectsAABB(in AABB a, in AABB b) {
  return all(lessThanEqual(a.min, b.max)) &&
         all(greaterThanEqual(a.max, b.min));
}

bool sphereIntersectsAABB(in Sphere sphere, in AABB aabb,
                          out vec3 intersection) {
  intersection = clamp(sphere.origin, aabb.min, aabb.max);

  return is_position_inside_sphere(intersection, sphere);
}

bool sphereIntersectsSphere(in Sphere a, in Sphere b, out vec3 intersection) {
  vec3 d = b.origin - a.origin;

  intersection = a.origin + 0.5 * d;

  return length(d) < a.radius + b.radius;
}