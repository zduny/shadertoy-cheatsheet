#define MS_STANDARD_1  vec2[](vec2(0.0))
#define MS_STANDARD_2  vec2[](vec2(-0.25), vec2(0.25))
#define MS_STANDARD_4  vec2[](                                           \
                         vec2(-0.125, -0.375), vec2(0.375, -0.125),      \
                         vec2(-0.375,  0.125), vec2(0.125,  0.375)       \
                       )
#define MS_STANDARD_8  vec2[](                                           \
                         vec2( 0.0625, -0.1875), vec2(-0.0625,  0.1875), \
                         vec2( 0.3125,  0.0625), vec2(-0.1875, -0.3125), \
                         vec2(-0.3125,  0.3125), vec2(-0.4375, -0.0625), \
                         vec2( 0.1875,  0.4375), vec2( 0.4375, -0.4375)  \
                       )
                            
#define MS_STANDARD_16 vec2[](                                           \
                         vec2( 0.0625,  0.0625), vec2(-0.0625, -0.1875), \
                         vec2(-0.1875,  0.125 ), vec2( 0.25  , -0.0625), \
                         vec2(-0.3125, -0.125 ), vec2( 0.125 ,  0.3125), \
                         vec2( 0.3125,  0.1875), vec2( 0.1875, -0.3125), \
                         vec2(-0.125 ,  0.375 ), vec2( 0.0   , -0.4375), \
                         vec2(-0.25  , -0.375 ), vec2(-0.375 ,  0.25  ), \
                         vec2(-0.5   ,  0.0   ), vec2( 0.4375, -0.25  ), \
                         vec2( 0.375 ,  0.4375), vec2(-0.4375, -0.5   )  \
                       )
                             
#define AA_1                                                             \
  const int sampleCount = 1;                                             \
  const vec2[] samplePositions = MS_STANDARD_1;

#define AA_2                                                             \
  const int sampleCount = 2;                                             \
  const vec2[] samplePositions = MS_STANDARD_2;

#define AA_4                                                             \
  const int sampleCount = 4;                                             \
  const vec2[] samplePositions = MS_STANDARD_4;

#define AA_8                                                             \
  const int sampleCount = 8;                                             \
  const vec2[] samplePositions = MS_STANDARD_8;

#define AA_16                                                            \
  const int sampleCount = 16;                                            \
  const vec2[] samplePositions = MS_STANDARD_16;

#define INCLUDE_SUPER_SAMPLE_FUNCTION(name, quality, takeSample)         \
  vec4 name(in vec2 fragCoord) {                                         \
    quality                                                              \
    vec4 result = vec4(0.0);                                             \
    float samplesSqrt = sqrt(float(sampleCount));                        \
    for (int i = 0; i < sampleCount; i++) {                              \
      result += takeSample(fragCoord + samplePositions[i],               \
                           1.0 / samplesSqrt);                           \
    }                                                                    \
                                                                         \
    return result / float(sampleCount);                                  \
  }

#define INCLUDE_GRID_SUPER_SAMPLE_FUNCTION(name, takeSample)             \
  vec4 name(in vec2 fragCoord, in int samplesSqrt) {                     \
    vec4 outColor = vec4(0.0);                                           \
    for (int x = 0; x < samplesSqrt; x++) {                              \
      for (int y = 0; y < samplesSqrt; y++) {                            \
        vec2 offset =                                                    \
          vec2((float(x) + 0.5) * (1.0 / float(samplesSqrt)) - 0.5,      \
               (float(y) + 0.5) * (1.0 / float(samplesSqrt)) - 0.5);     \
        vec2 samplePosition = fragCoord + offset;                        \
        outColor += takeSample(samplePosition, 1.0 / samplesSqrt);       \
      }                                                                  \
    }                                                                    \
                                                                         \
    return outColor / float(samplesSqrt * samplesSqrt);                  \
  }
