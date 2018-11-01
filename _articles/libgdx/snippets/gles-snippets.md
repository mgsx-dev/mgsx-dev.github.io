

```java

Gdx.gl.glClearColor(0, 0, 0, 0);
Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);

```

# Shader

```java
shader = new ShaderProgram(Gdx.files.internal("shaders/name.vs"), Gdx.files.internal("shaders/name.fs"));
if(!shader.isCompiled()) throw new GdxRuntimeException(shader.getLog());
```

# GLSL

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

## Model

TODO


```vertex

```


```fragment

```