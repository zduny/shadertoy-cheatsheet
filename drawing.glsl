void drawDisk(in vec2 fragmentCoordinates, in vec2 center, in float radius,
              in vec4 color, inout vec4 outputColor) {
  float d = distance(fragmentCoordinates, center);
  float a = 1.0 - clamp(d - radius + 0.5, 0.0, 1.0);

  output_color = mix(outputColor, color, a * color.a);
}

float sdSegment(in vec2 point, in vec2 a, in vec2 b) {
  vec2 pa = point - a;
  vec2 ba = b - a;

  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);

  return length(pa - ba * h);
}

void drawSegment(in vec2 fragmentCoordinates, in vec2 a, in vec2 b,
                 in float thickness, in vec4 color, inout vec4 outputColor) {
  float d = sdSegment(fragmentCoordinates, a, b);
  float a = 1.0 - clamp(d - thickness / 2.0 + .5, 0.0, 1.0);

  outputColor = mix(outputColor, color, a * color.a);
}