---
layout: glsl
name:  "7 - Fractal Noise"
date:   2015-07-21 00:00:00
type: glsl
group: noise
preview: /img/blog/noise/thumb/007-fractal-noise.png
screenshot: /img/blog/noise/007-fractal-noise.png
excerpt: "That's not bad. So, move on to fractal noise."
before: 6 - Hermite
after: 8 - Perlin Noise
---
## Explainations

That's not bad. So, move on to fractal noise.

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float hermite(float t)
{
  return t * t * (3.0 - 2.0 * t);
}

float noise(vec2 co, float frequency)
{
  vec2 v = vec2(co.x * frequency, co.y * frequency);

  float ix1 = floor(v.x);
  float iy1 = floor(v.y);
  float ix2 = floor(v.x + 1.0);
  float iy2 = floor(v.y + 1.0);

  float fx = hermite(fract(v.x));
  float fy = hermite(fract(v.y));

  float fade1 = mix(rand(vec2(ix1, iy1)), rand(vec2(ix2, iy1)), fx);
  float fade2 = mix(rand(vec2(ix1, iy2)), rand(vec2(ix2, iy2)), fx);

  return mix(fade1, fade2, fy);
}

```

Our fractal noise function simply overlay noise multiple times at different frequencies
at each step, frequency is doubled at each pass.

``` glsl
float fnoise(vec2 co, float freq, int steps)
{
  float value = 0.0;
  for(int i=0 ; i<steps ; i++)
  {
    value += noise(co, freq);
    freq *= 2.0;
  }
```

Then we rescale to range 0-1

``` glsl
  return value / float(steps);
}

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

```

Let's try with 5 pass. (try to not use huge value for performance reasons)

``` glsl
  float value = fnoise(position, 10.0, 5);

	gl_FragColor = vec4(value, value, value,1.0);
}
```


## Full Code Source

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float hermite(float t)
{
  return t * t * (3.0 - 2.0 * t);
}

float noise(vec2 co, float frequency)
{
  vec2 v = vec2(co.x * frequency, co.y * frequency);

  float ix1 = floor(v.x);
  float iy1 = floor(v.y);
  float ix2 = floor(v.x + 1.0);
  float iy2 = floor(v.y + 1.0);

  float fx = hermite(fract(v.x));
  float fy = hermite(fract(v.y));

  float fade1 = mix(rand(vec2(ix1, iy1)), rand(vec2(ix2, iy1)), fx);
  float fade2 = mix(rand(vec2(ix1, iy2)), rand(vec2(ix2, iy2)), fx);

  return mix(fade1, fade2, fy);
}

float fnoise(vec2 co, float freq, int steps)
{
  float value = 0.0;
  for(int i=0 ; i<steps ; i++)
  {
    value += noise(co, freq);
    freq *= 2.0;
  }
  return value / float(steps);
}

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

  float value = fnoise(position, 10.0, 5);

	gl_FragColor = vec4(value, value, value,1.0);
}
```