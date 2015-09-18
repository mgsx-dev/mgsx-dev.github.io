---
layout: glsl
name:  "6.1 - Animated Iridescence"
date:   2015-07-21 00:00:00
type: glsl
group: gradient
preview: /img/blog/gradient/thumb/006-001-animated-iridescence.gif
screenshot: /img/blog/gradient/006-001-animated-iridescence.png
excerpt: "To see iridescence in action, let's animate it with noise."
parent: 6 - Iridescence
---
## Explainations

To see iridescence in action, let's animate it with noise.

Noise generation is not covered in this chapter, see [Noise chapter]({% post_url 2015-07-20-Noise %}) for more details.

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

vec3 mod289(vec3 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x)
{
  return mod289(((x*34.0)+1.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec3 fade(vec3 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float cnoise(vec3 P)
{
  vec3 Pi0 = floor(P); // Integer part for indexing
  vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  vec3 Pf0 = fract(P); // Fractional part for interpolation
  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  vec4 iy = vec4(Pi0.yy, Pi1.yy);
  vec4 iz0 = Pi0.zzzz;
  vec4 iz1 = Pi1.zzzz;

  vec4 ixy = permute(permute(ix) + iy);
  vec4 ixy0 = permute(ixy + iz0);
  vec4 ixy1 = permute(ixy + iz1);

  vec4 gx0 = ixy0 * (1.0 / 7.0);
  vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
  gx0 = fract(gx0);
  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
  vec4 sz0 = step(gz0, vec4(0.0));
  gx0 -= sz0 * (step(0.0, gx0) - 0.5);
  gy0 -= sz0 * (step(0.0, gy0) - 0.5);

  vec4 gx1 = ixy1 * (1.0 / 7.0);
  vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
  gx1 = fract(gx1);
  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
  vec4 sz1 = step(gz1, vec4(0.0));
  gx1 -= sz1 * (step(0.0, gx1) - 0.5);
  gy1 -= sz1 * (step(0.0, gy1) - 0.5);

  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);

  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  vec3 fade_xyz = fade(Pf0);
  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x); 
  return 2.2 * n_xyz;
}

vec4 wl_to_rgb(float wl)
{
    vec3 color;
    if(wl < 380.0)
    {
      color = vec3(1.0, 0.0, 1.0);
    }
    else if(wl<440.0)
    {
      color = vec3(-(wl - 440.0) / (440.0 - 380.0), 0.0, 1.0);
    }
    else if(wl<490.0)
    {
      color = vec3(0.0, (wl - 440.0) / (490.0 - 440.0), 1.0);
    }
    else if(wl<510.0)
    {
      color = vec3(0.0, 1.0, -(wl - 510.0) / (510.0 - 490.0));
    }
    else if(wl<580.0)
    {
      color = vec3((wl - 510.0) / (580.0 - 510.0), 1.0, 0.0);
    }
    else if(wl<645.0)
    {
      color = vec3(1.0, -(wl - 645.0) / (645.0 - 580.0), 0.0);
    }
    else
    {
      color = vec3(1.0, 0.0, 0.0);
    }

    float g = 0.80;
    vec3 gamma = vec3(g,g,g);
    color = pow(color, gamma);

    float factor;
    if((wl >= 380.0) && (wl<420.0)){
        factor = (wl - 380.0) / (420.0 - 380.0);
    }else if((wl >= 420.0) && (wl<701.0)){
        factor = 1.0;
    }else if((wl >= 701.0) && (wl<781.0)){
        factor = (780.0 - wl) / (780.0 - 700.0);
    }else{
        factor = 0.0;
    }

    return vec4(color, factor);
}

vec4 frequency_to_rgb(float position)
{
  float f = mix(385.0, 785.0, position);

  float wavelen = 300000.0 / f;

  return wl_to_rgb(wavelen);
}

void main( void ) {

  vec2 position = gl_FragCoord.xy / resolution.xy;
  
```

We compute an animated FM noise (2 compound noise signals)

``` glsl
  float vtime = time * 0.05f;
  float freq = 2.0f;
  float noiseFM = cnoise(vec3(position, vtime) * freq * 3.0);
  float noise = cnoise(vec3(position, vtime + noiseFM) * freq) * 0.5f + 0.5f;

```

Extract a gradient from that FM noise, we take just a thin band around mid noise value

``` glsl
  float gradient = smoothstep(0.4, 0.6, noise);

```

We get our raindow color from gradient.

``` glsl
  vec4 rainbow = frequency_to_rgb(gradient);

```

We remove half rainbow saturation.

``` glsl
  vec3 irColor = mix(vec3(1.0, 1.0, 1.0), rainbow.rgb, 0.5);

```

We create a base color mixing two close green dark oil color with noise.

``` glsl
  vec3 baseColor = mix(vec3(0.1, 0.4, 0.4), vec3(0.7, 0.7, 0.8), noise);

```

And then mix partially our base color with visible iridescence.

``` glsl
  vec3 color = mix(baseColor, irColor, rainbow.a * 0.7);

  gl_FragColor =  vec4(color, 1.0);

}
```


## Full Code Source

``` glsl
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

vec3 mod289(vec3 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x)
{
  return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x)
{
  return mod289(((x*34.0)+1.0)*x);
}

vec4 taylorInvSqrt(vec4 r)
{
  return 1.79284291400159 - 0.85373472095314 * r;
}

vec3 fade(vec3 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float cnoise(vec3 P)
{
  vec3 Pi0 = floor(P); // Integer part for indexing
  vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
  Pi0 = mod289(Pi0);
  Pi1 = mod289(Pi1);
  vec3 Pf0 = fract(P); // Fractional part for interpolation
  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  vec4 iy = vec4(Pi0.yy, Pi1.yy);
  vec4 iz0 = Pi0.zzzz;
  vec4 iz1 = Pi1.zzzz;

  vec4 ixy = permute(permute(ix) + iy);
  vec4 ixy0 = permute(ixy + iz0);
  vec4 ixy1 = permute(ixy + iz1);

  vec4 gx0 = ixy0 * (1.0 / 7.0);
  vec4 gy0 = fract(floor(gx0) * (1.0 / 7.0)) - 0.5;
  gx0 = fract(gx0);
  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
  vec4 sz0 = step(gz0, vec4(0.0));
  gx0 -= sz0 * (step(0.0, gx0) - 0.5);
  gy0 -= sz0 * (step(0.0, gy0) - 0.5);

  vec4 gx1 = ixy1 * (1.0 / 7.0);
  vec4 gy1 = fract(floor(gx1) * (1.0 / 7.0)) - 0.5;
  gx1 = fract(gx1);
  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
  vec4 sz1 = step(gz1, vec4(0.0));
  gx1 -= sz1 * (step(0.0, gx1) - 0.5);
  gy1 -= sz1 * (step(0.0, gy1) - 0.5);

  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);

  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  vec3 fade_xyz = fade(Pf0);
  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x); 
  return 2.2 * n_xyz;
}

vec4 wl_to_rgb(float wl)
{
    vec3 color;
    if(wl < 380.0)
    {
      color = vec3(1.0, 0.0, 1.0);
    }
    else if(wl<440.0)
    {
      color = vec3(-(wl - 440.0) / (440.0 - 380.0), 0.0, 1.0);
    }
    else if(wl<490.0)
    {
      color = vec3(0.0, (wl - 440.0) / (490.0 - 440.0), 1.0);
    }
    else if(wl<510.0)
    {
      color = vec3(0.0, 1.0, -(wl - 510.0) / (510.0 - 490.0));
    }
    else if(wl<580.0)
    {
      color = vec3((wl - 510.0) / (580.0 - 510.0), 1.0, 0.0);
    }
    else if(wl<645.0)
    {
      color = vec3(1.0, -(wl - 645.0) / (645.0 - 580.0), 0.0);
    }
    else
    {
      color = vec3(1.0, 0.0, 0.0);
    }

    float g = 0.80;
    vec3 gamma = vec3(g,g,g);
    color = pow(color, gamma);

    float factor;
    if((wl >= 380.0) && (wl<420.0)){
        factor = (wl - 380.0) / (420.0 - 380.0);
    }else if((wl >= 420.0) && (wl<701.0)){
        factor = 1.0;
    }else if((wl >= 701.0) && (wl<781.0)){
        factor = (780.0 - wl) / (780.0 - 700.0);
    }else{
        factor = 0.0;
    }

    return vec4(color, factor);
}

vec4 frequency_to_rgb(float position)
{
  float f = mix(385.0, 785.0, position);

  float wavelen = 300000.0 / f;

  return wl_to_rgb(wavelen);
}

void main( void ) {

  vec2 position = gl_FragCoord.xy / resolution.xy;
  
  float vtime = time * 0.05f;
  float freq = 2.0f;
  float noiseFM = cnoise(vec3(position, vtime) * freq * 3.0);
  float noise = cnoise(vec3(position, vtime + noiseFM) * freq) * 0.5f + 0.5f;

  float gradient = smoothstep(0.4, 0.6, noise);

  vec4 rainbow = frequency_to_rgb(gradient);

  vec3 irColor = mix(vec3(1.0, 1.0, 1.0), rainbow.rgb, 0.5);

  vec3 baseColor = mix(vec3(0.1, 0.4, 0.4), vec3(0.7, 0.7, 0.8), noise);

  vec3 color = mix(baseColor, irColor, rainbow.a * 0.7);

  gl_FragColor =  vec4(color, 1.0);

}
```