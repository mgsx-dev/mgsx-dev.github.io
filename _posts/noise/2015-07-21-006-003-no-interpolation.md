---
layout: glsl
name:  "6.3 - No Interpolation"
date:   2015-07-21 00:00:00
type: glsl
group: noise
preview: /img/blog/noise/thumb/006-003-no-interpolation.gif
screenshot: /img/blog/noise/006-003-no-interpolation.png
before: 6.2 - Noise 1D
after: 6.4 - Linear Interpolation
parent: 6 - Hermite
---
## Explainations

Let's get back a little to understand interpolation

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

float rand(float x){
    return fract(sin(x * 12.9898) * 43758.5453);
}

float noise(float x, float frequency)
{
  float v = x * frequency;

  float ix1 = floor(v);
  float ix2 = floor(v + 1.0);

```

We don't want to interpolate, just see random scaled 

``` glsl
  float fx = 0.0;

  return mix(rand(ix1), rand(ix2), fx);
}

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

  float y = noise(position.x + time * 0.1, 10.0);

  float v = step(position.y, y);
  
	gl_FragColor = vec4(v,v,v,1.0);
}

```

Result is as expected : some bars with random height

## Full Code Source

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

float rand(float x){
    return fract(sin(x * 12.9898) * 43758.5453);
}

float noise(float x, float frequency)
{
  float v = x * frequency;

  float ix1 = floor(v);
  float ix2 = floor(v + 1.0);

  float fx = 0.0;

  return mix(rand(ix1), rand(ix2), fx);
}

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

  float y = noise(position.x + time * 0.1, 10.0);

  float v = step(position.y, y);
  
	gl_FragColor = vec4(v,v,v,1.0);
}

```