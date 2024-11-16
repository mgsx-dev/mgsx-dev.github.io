---
layout: blog
name:   "LibGDX GLSL"
date: 2020-05-30 12:00:00
type:   blog
group:  libgdx
published: true
---

## Platform and Shader version

* MacOSX (desktop) uses OpenGL ES 2.1 then `#version 120` is required
* WebGL : ???
* Android (without GLES3) : `#version 110` or `#version 120`
* Android (with GLES3) : `#version 300 es`
* iOS : ???
* other Desktop (Linux and Windows) : 
    * OpenGL 3 : `#version 130`

## Cross compatible shader code

Based on [LWJGL Wiki](https://github.com/mattdesl/lwjgl-basics/wiki/GLSL-Versions)
You can write croos-compatible shader code with few macro :

**Vertex shader**

```
#ifdef GLSL3
#define attribute in
#define varying out
#endif
```

**Fragment shader**

```
#ifdef GLSL3
#define varying in
out vec4 out_FragColor;
#define textureCube texture
#define texture2D texture
#else
#define out_FragColor gl_FragColor
#endif
```

Since gl_FragColor is a reserved and decrecated keyword for GLSL3+, you have to replace **gl_FragColor** by **out_FragColor** in your fragement shader code.

Finally you have to inject this macro at runtime in case of OpenGL 3+ or OpenGLES 3+ :

`#define GLSL3`




```java

Gdx.gl.glClearColor(0, 0, 0, 0);
Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);

```

# Shader

## ImmediateModeRenderer / ShapeRenderer

```vertex
attribute vec4 a_position;
attribute vec4 a_color;
uniform mat4 u_projModelView;

varying vec4 v_color;

void main() {
    v_color = a_color;
    gl_Position = u_projModelView * a_position;
}

```


```fragment
#ifdef GL_ES 
#define LOWP lowp
#define MED mediump
#define HIGH highp
precision mediump float;
#else
#define MED
#define LOWP
#define HIGH
#endif

varying vec4 v_color;

void main() {
    gl_FragColor = v_color;
}

```

# SpriteBatch


```vertex
attribute vec4 a_position;
attribute vec4 a_color;
attribute vec2 a_texCoord0;
uniform mat4 u_projTrans;
varying vec2 v_texCoords;
varying vec4 v_color;

void main()
{
    v_color = a_color;
    v_texCoords = a_texCoord0;
    gl_Position =  u_projTrans * a_position;
}

```


```fragment
#ifdef GL_ES
#define LOWP lowp
precision mediump float;
#else
#define LOWP
#endif

varying vec4 v_color;
varying vec2 v_texCoords;
uniform sampler2D u_texture;

void main() {
    gl_FragColor = v_color * texture2D(u_texture, v_texCoords);
}

```
