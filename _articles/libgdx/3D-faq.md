---
layout: blog
name:   "LibGDX 3D Tricks"
date: 2020-05-30 12:00:00
type:   blog
group:  libgdx
published: true
---

# Stick a model to the camera

```java
// Snipet : stick to camera
//
// variables
Vector3 tangent = new Vector3();
Vector3 up = new Vector3();
Vector3 direction = new Vector3();
Vector3 offset = new Vector3(0,0,4);
// rotation
direction.set(camera.direction);
tangent.set(camera.direction).crs(camera.up).nor();
up.set(tangent).crs(camera.direction).nor();
// final transform
ctx.scene.modelInstance.transform
.set(tangent, up, direction, Vector3.Zero).tra()
.setTranslation(camera.position)
.translate(offset);
```
