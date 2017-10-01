---
---

You need some libgdx basic knowledge to follow this tutorial. 
this tutorial can be followed directly after [Libgdx Drop tutorial](https://github.com/libgdx/libgdx/wiki/A-simple-game).

# Project setup

You may already have setup your project correcly with core, android and desktop sub modules.

# The game

The game idea is very simple:

    * Catch raindrops.
    * Raindrops spawn randomly at the top of the scene every second
    * Raindrops diseapear when touching the ground.
    * Player can pickup a drop by touching it. It change its color.
    * The game never ends.

# The Assets

Audio is not covered in this tutorial but you already know how to play sounds and easily integrate sound FX in this game.

We will only load a texture for the background, we'll see how to wrap it on a 3D model.

# Configuring the Starter Classes

Simply replace the Drop game class by Drop3D in both Desktop launcher and Android launcher.


The Code

We want to split up our code into a few sections. For the sake of simplicity we keep everything in the Drop3D.java file of the Core project.


# Basic shapes


# A Camera and a ModelBatch

Next we want to create a camera and a `ModelBatch`. We'll use the former to ensure we can render using our target resolution of 800x480 pixels no matter what the actual screen resolution is. The SpriteBatch is a special class that is used to draw 3D objects, like the model instances we created.

We add two new fields to the class, let's call them camera and batch:

   private OrthographicCamera camera;
   private SpriteBatch batch;
In the create() method we first create the camera like this:

   camera = new OrthographicCamera();
   camera.setToOrtho(false, 800, 480);
This will make sure the camera always shows us an area of our game world that is 800x480 units wide. Think of it as a virtual window into our world. We currently interpret the units as pixels to make our life a little easier. There's nothing preventing us from using other units though, e.g. meters or whatever you have. Cameras are very powerful and allow you to do a lot of things we won't cover in this basic tutorial. Check out the rest of the developer guide for more information.

Next we create the SpriteBatch (we are still in the create() method):

   batch = new SpriteBatch();
We are almost done with creating all the things we need to run this simple game.









TODO progressive steps :

# TODO (not 3D related first) : spawn some apples, remove when below ground, update apples

# TODO create models programmatically (static background, dynamic apples )

# TODO render models (model batch, modelInstance, ...Etc)

# TODO rendering pipeline and environement (model batch env ..)

# TODO lights