---
layout: blog
name:   "LibGDX and Blender"
date: 2018-05-18 12:00:00
type:   blog
group:  libgdx
published: false
---


LibGDX already provides what you need to import models from Blender into your LibGDX games

These tools enable common 3D data like : meshes, objects hierarchy, materials, animations and bones.

But what if you want to go further :

* import cameras, lights, splines, and so on.
* convert back from G3Dx formats to blender.

This article explain how to do it and provides related code and tools.


# Generative meshes

## Generative meshes in Blender

If you're familiar with python language and Blender python API you could go this way but in my case i preffer using Java code (and LibGDX utility) for this purpose.

## Generative meshes in LibGDX

LibGDX provides usefull utility class in order to create models and meshes programatically (ModelBuilder, MeshBuilder, etc.).

It's enough in order to generate on the fly 3D models and meshes inside a game but sometimes you want to export these generates models for several reasons :

* pre-generate 3D assets for your game
* reuse generated 3D in 3D tools like Blender

These subjects are covered later.


# Conversions

## Blender to LibGDX

### Models and Meshes

Process is the following :

* create your models in Blender
* export as FBX (or OBJ) using out-of-the-box Blender plugins
* convert to LibGDX internal format (G3DJ or G3DB) using [fbx-conv](https://github.com/libgdx/fbx-conv)
* finally load your model in your game with ModelLoaders

This process could be automatized in some way in order to speed-up development, I wrote some gradle utility to accomplish this. Process becomes :

* create (or edit) your models in Blender
* run either specific gradle task or overall assets packing task (one command line)
* finally restart your game to have updated models.

Note that gradle part could be more complex if you want to automate other tasks like backing some textures or anything you can do with Blender python API.

Beside these gradle tools doesn't necessarily restricted to 3D models, it could be used to export 2D sprite-sheets, background textures or any other data.

### More Blender objects

I wrote some tools in order to import more Blender objects like Cameras, Lights, Splines ...

* first a python script to export these objects as JSON
* the java code to load these objects and convert them to LibGDX objects.

With both these tools and those provided by LibGDX, you could modelize all in Blender and run all in LibGDX with a single line of code.


## LibGDX to Blender

Why you want to do that ? There is several use cases but mine was to generate models with LibGDX java code (ModelBuilder, MeshBuilder, etc.) and import it in Blender in order to tweak it, reuse and finally export for my game.

Unfortunately fbx-conv tools doesn't support conversion from G3Dx to FBX or OBJ file.

Approach I used was to first export G3DModel from java code and import it in Blender with Python script.

In order to re-import a G3DModel into Blender, it's needed to :

* export a G3DModel from java code to G3DJ file : you can use [this Java class](TODO link to gdx-blender/G3DModelExporter)
* import a G3DJ file in Blender : you can use [this Python script](TODO link to gdx-blender/scripts/g3dj-import.py)

Note that G3DB (binary) format is not supported by this python script but it's straightforward to convert from/to G3D using LibGDX serializers. Sample code available [here](TODO link to gdx-blender/G3DB2G3DJ ...)






# TODO chapter on G3DJ vs G3DB

example with simple mesh and tesslation, G3DB is 3 times smaller than G3DJ :

|smoothing|G3DJ size|G3DB size|
|0x|28.9 KB|9.8 KB|
|1x|142.2 KB|45.8 KB|
|2x|1.2 MB|381 KB|
|3x|15.5 MB|4.6 MB|

