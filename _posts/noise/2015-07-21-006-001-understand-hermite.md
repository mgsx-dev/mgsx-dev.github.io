---
layout: glsl
name:  "6.1 - Understand Hermite"
date:   2015-07-21 00:00:00
type: glsl
group: noise
preview: /img/blog/noise/thumb/006-001-understand-hermite.png
screenshot: /img/blog/noise/006-001-understand-hermite.png
excerpt: "To help you understand hermite interpolation, let's draw the curve."
after: 6.2 - Noise 1D
parent: 6 - Hermite
---
## Explainations

To help you understand hermite interpolation, let's draw the curve.

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

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

```

just take f(x) = hermite(x)

``` glsl
  float y = hermite(position.x);

```

then we want to draw the curve so 
- when the value is below pixel y we paint white
- when the value is above pixel y we paint black

``` glsl
  float v = step(position.y, y);
  
	gl_FragColor = vec4(v,v,v,1.0);
}

```

We see that the curve as zero derivative at 0 and 1.

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

void main( void ) {

	vec2 position = gl_FragCoord.xy / resolution.xy;

  float y = hermite(position.x);

  float v = step(position.y, y);
  
	gl_FragColor = vec4(v,v,v,1.0);
}

```