---
layout: blog
name:   "Blender Python Snippets"
date: 2019-02-07 12:00:00
type:   blog
group:  blender
published: true
---

## Exporting NURBS

```python
import bpy
import json

def map_point(point):
    return {
        "x": point.co.x,
        "y": point.co.y,
        "z": point.co.z,
        "w": point.co.w
    }
    
def map_spline(spline):
    return {
        "points": list(map(map_point, spline.points))
    }

def map_surface(data):
    return {
        "splines": list(map(map_spline, data.splines))
    }        

def map_data(object):
    if object.type == "SURFACE":
        return map_surface(object.data)
    return {}

def map_object(object):
    return {
        "name": object.name,
        "data": map_data(object)
    }

def map_objects(objects):
    return {
        "info": "blender export script",
        "objects": list(map(map_object, objects))
    }
def map_selection():
    return map_objects([bpy.context.active_object])

# bpy.context.active_object.data.splines[0].points[0].co

with open('data.json', 'w') as outfile:
    json.dump(map_selection(), outfile)
```


