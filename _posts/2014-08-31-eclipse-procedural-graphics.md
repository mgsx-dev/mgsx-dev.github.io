---
layout: blog
name:  "Procedural Texturing in Eclipse"
date:   2014-08-31 12:24:31
type:  blog
github: graphics-procedural-modeling
---

There is many way to make procedural texturing. You can use dedicated software like Blender or you can directly code it with shaders with GLSL.

Another approach is cover in [Texture Studio]({ post_url 2014-08-31-texture-studio }).

This workshop focus on Eclipse modeling tools to acheive a software allowing to produce texture.

The approach here is to use easy coding. This is done with XText which is a general purpose Text To Model tool :
- we defines a grammar with antlr
- put it in XText
- and finally process the model.

Herer is some screenshots :

<a href="{{ site.baseurl }}/img/blog/procedural-texture-modeling/Capture.png">
<img src="{{ site.baseurl }}/img/blog/procedural-texture-modeling/CaptureMini.png">
</a>
