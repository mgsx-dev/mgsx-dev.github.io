---
layout: glsl-blog
name:   "Processing"
type:   blog-glsl
group:  processing
github: processing-glsl
---

Almost all GLSL tutorial series are made with Processing. This workshop will explain how to setup processing to play easily with GLSL.

Here is a simple template loading a shader and a texture to play with it (shader file and picture expected to be found in data/ folder).

The shader might have those variable (as uniform) :

- resolution : size of the screen
- time : time in seconds since application start
- picture : a sampler 2D

``` java
PShader shader;

void setup() {
  size(320, 320, P2D);
  noStroke();

  shader = loadShader("shader.glsl");
  shader.set("resolution", float(width), float(height));
  shader.set("picture", loadImage("picture.png"));
}

void draw() {
  shader.set("time", millis() / 1000.0);  
  shader(shader);
  rect(0, 0, width, height);
}
```

To see shader exemple, browse GLSL workshop. All the code for all GLSL training at this website are also available on [GitHub](https://github.com/{{ site.github_username }}/{{ page.github }}). First sketch "ProcessingSample" contains PDE file to use with Processing IDE. It also contains an eclipse project to use with eclipse. The data folder containing graphics and shaders are shared.

Eclipse project contains also code to :

- batch export shader preview screenshot and animation.
- batch generate jekyll web site pages (used to generate GLSL posts on this website).
