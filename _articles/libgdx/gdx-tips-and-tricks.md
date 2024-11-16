---
layout: blog
name:   "LibGDX Tips and Tricks"
date: 2020-05-30 12:00:00
type:   blog
group:  libgdx
published: true
permalink: libgdx-tips-and-tricks
---

# Debug some situations

## Can't see my FBO

Pixmap.IO / ScreenUtils

## Can't see my mesh

use GLTFExporter...


# Gradle issues

<q>Gradle can't find dependencies looking at .m2 local repository.</q>
<p>Maven local repository sometimes mess with gradle dependencies cache, you need to <em>remove your .m2 directory.</em> and rebuild your project</p>

<q>GWT super dev mode, my changes are not applied, even if i clean rebuild all my project.</q>
<p>Super dev has cache outside of your project, not clear it, go to super dev web page and <em>click clean button</em>.</p>


# Scene2D

* Any actor provides <em>setUserObject</em> to attach any of your logic object to it.
* Any actor provides <em>setName</em> to attach an ID to it. It can be retrieved later using Group#findActor.

# Framebuffer

<p>
<a href="https://gist.github.com/mgsx-dev/9cab46e4c9583d1bbf9ea7db543c94bd">Gist</a>
In order to preserve alpha with your fbo, you should draw non opaque graphics using a special blending function : 
<code>batch.setBlendFunctionSeparate(GL20.GL_SRC_ALPHA, GL20.GL_ONE_MINUS_SRC_ALPHA, GL20.GL_SRC_ALPHA, GL20.GL_ONE);</code>
</p>

# Error handling

Catch any errors (TODO gist)

for Lwjgl3 you can override Lwjgl3Application#cleanup method or wrap #loop method with a try catch if you need the error.

```java
public class DesktopApplication extends LwjglApplication
{
    public DesktopApplication(ApplicationListener listener, LwjglApplicationConfiguration config) 
    {
        super(listener, config);
    }
    
    @Override
    public boolean executeRunnables() {
        try{
            return super.executeRunnables();
        }catch(Throwable e){
            // run code when app exiting with a crash
            return true;
        }
    }
}

public class GameBase extends Game 
{
    @Override
    public void render() 
    {
        try
        {
            super.render();
        } 
        catch (Throwable e) 
        {
            // run code when app exiting with a crash
        }
    }
}

public class MyGame extends GameBase 
{
    @Override
    public void dispose() 
    {
        // run code when app exiting without crash
    }
}
```

# Snippets

## Scene2D Animated Image

```java


import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.scenes.scene2d.ui.Image;
import com.badlogic.gdx.scenes.scene2d.utils.TextureRegionDrawable;

public class ImageAnimation extends Image
{
    private Animation<TextureRegion> animation;
    private float time;
    
    private TextureRegionDrawable drawable = new TextureRegionDrawable();
    
    public ImageAnimation() {
        super();
        setDrawable(drawable);
    }
    
    public void setAnimation(Animation<TextureRegion> animation) {
        this.animation = animation;
    }
    
    @Override
    public void act(float delta) 
    {
        time += delta;
        if(animation != null && animation.getAnimationDuration() > 0){
            TextureRegion frame = animation.getKeyFrame(time, true);
            drawable.setRegion(frame);
            setDrawable(drawable);
        }else{
            setDrawable(null);
        }
        super.act(delta);
    }
    
}

```

## Scene2D Particles Actor

```java
import com.badlogic.gdx.graphics.g2d.Batch;
import com.badlogic.gdx.graphics.g2d.ParticleEffect;
import com.badlogic.gdx.scenes.scene2d.Actor;

public class ParticleEffectActor extends Actor
{
    private ParticleEffect effect;
    
    public ParticleEffectActor(ParticleEffect effect) {
        super();
        this.effect = effect;
    }
    
    public ParticleEffect getEffect() {
        return effect;
    }

    public void start(){
        effect.start();
    }
    
    public void stop(){
        effect.allowCompletion();
    }
    
    @Override
    public void act(float delta) {
        effect.setPosition(getX(), getY());
        effect.update(delta);
        super.act(delta);
    }
    
    @Override
    public void draw(Batch batch, float parentAlpha) {
        effect.draw(batch);
    }
}
```



## Shape Prototype

```java

import com.badlogic.gdx.Game;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;
import com.badlogic.gdx.utils.viewport.FitViewport;
import com.badlogic.gdx.utils.viewport.Viewport;

public class MyGame extends Game{

    private Viewport viewport;
    private ShapeRenderer shapeRenderer;
    private float time;
    
    @Override
    public void create() {
        viewport = new FitViewport(1000, 500);
        shapeRenderer = new ShapeRenderer();
    }
    
    @Override
    public void resize(int width, int height) {
        viewport.update(width, height);
    }
    
    @Override
    public void render() {
        final float delta= Gdx.graphics.getDeltaTime();
        // update
        time += delta;
        // draw
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        shapeRenderer.setProjectionMatrix(viewport.getCamera().combined);
        shapeRenderer.setColor(time % 1f, 1, 1, 1);
        shapeRenderer.begin(ShapeType.Line);
        shapeRenderer.line(0, 0, 490, 240);
        shapeRenderer.end();
    }
}
```

## 3D Environement

```java

import com.badlogic.gdx.Game;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Color;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.PerspectiveCamera;
import com.badlogic.gdx.graphics.VertexAttributes;
import com.badlogic.gdx.graphics.g3d.Environment;
import com.badlogic.gdx.graphics.g3d.Material;
import com.badlogic.gdx.graphics.g3d.ModelBatch;
import com.badlogic.gdx.graphics.g3d.ModelInstance;
import com.badlogic.gdx.graphics.g3d.attributes.ColorAttribute;
import com.badlogic.gdx.graphics.g3d.environment.DirectionalLight;
import com.badlogic.gdx.graphics.g3d.utils.CameraInputController;
import com.badlogic.gdx.graphics.g3d.utils.ModelBuilder;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.utils.Array;
import com.badlogic.gdx.utils.viewport.FitViewport;
import com.badlogic.gdx.utils.viewport.Viewport;

public class MyGame extends Game
{
    private Array<ModelInstance> models = new Array<ModelInstance>();
    private ModelBatch modelBatch;
    private Viewport viewport;
    private CameraInputController cameraController;
    private Environment env;
    
    @Override
    public void create() {
        PerspectiveCamera camera = new PerspectiveCamera(60f, 1, 1);
        camera.near = .1f;
        camera.far = 100f;
        camera.position.set(10, 10, 10);
        camera.up.set(Vector3.Y);
        camera.lookAt(Vector3.Zero);
        camera.update();
        viewport = new FitViewport(1000, 500, camera);
        cameraController = new CameraInputController(camera);
        modelBatch = new ModelBatch();
        Material material = new Material();
        material.set(ColorAttribute.createDiffuse(Color.ORANGE));
        long attributes = VertexAttributes.Usage.Position | VertexAttributes.Usage.Normal;
        float s = 10;
        models.add(new ModelInstance(new ModelBuilder().createBox(s, s, s, material, attributes)));
        env = new Environment();
        env.add(new DirectionalLight().set(Color.WHITE, new Vector3(-1, -3, -2).nor()));
        float l = 0.3f;
        env.set(new ColorAttribute(ColorAttribute.AmbientLight, new Color(l,l,l,1)));
        Gdx.input.setInputProcessor(cameraController);
    }
    
    @Override
    public void resize(int width, int height) {
        viewport.update(width, height);
    }
    
    @Override
    public void render() {
        cameraController.update();
        Gdx.gl.glClearColor(0,0,0,0);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT | GL20.GL_DEPTH_BUFFER_BIT);
        modelBatch.begin(viewport.getCamera());
        modelBatch.render(models, env);
        modelBatch.end();
    }
    
}
```


## Universal Keyboard Inputs

Universal arrow control for QWERTY and AZERTY and arrow keys :


```java

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;

// Layouts ARROWS, WSAD, ZSQD
int [][] keyLayouts = {
        {Input.Keys.UP, Input.Keys.DOWN, Input.Keys.LEFT, Input.Keys.RIGHT},
        {Input.Keys.W, Input.Keys.S, Input.Keys.A, Input.Keys.D},
        {Input.Keys.Z, Input.Keys.S, Input.Keys.Q, Input.Keys.D},
};

// Check states
boolean [] isKeyPressed = {false, false, false, false};
boolean [] isKeyJustPressed = {false, false, false, false};
for(int [] keyLayout : keyLayouts){
    for(int i=0 ; i<4 ; i++){
        int key = keyLayout[i];
        isKeyPressed[i] |= Gdx.input.isKeyPressed(key);
        isKeyJustPressed[i] |= Gdx.input.isKeyJustPressed(key);
    }
}

// Get the results (order WSAD : up, down, left, right)
boolean isUp = isKeyPressed[0];
boolean isDown = isKeyPressed[1];
boolean isLeft = isKeyPressed[2];
boolean isRight = isKeyPressed[3];

boolean isJustUp = isKeyJustPressed[0];
boolean isJustDown = isKeyJustPressed[1];
boolean isJustLeft = isKeyJustPressed[2];
boolean isJustRight = isKeyJustPressed[3];

```


or as class : 

```java
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;

public class UniControl {

    public static final int DOWN = 1, RIGHT = 3, UP = 0, LEFT = 2;
    
    // Layouts ARROWS, WSAD, ZSQD
    private static final int [][] keyLayouts = {
            {Input.Keys.UP, Input.Keys.DOWN, Input.Keys.LEFT, Input.Keys.RIGHT},
            {Input.Keys.W, Input.Keys.S, Input.Keys.A, Input.Keys.D},
            {Input.Keys.Z, Input.Keys.S, Input.Keys.Q, Input.Keys.D},
    };

    public static boolean isPressed(int direction){
        for(int [] keyLayout : keyLayouts){
            if(Gdx.input.isKeyPressed(keyLayout[direction])) return true;
        }
        return false;
    }
    
    public static boolean isJustPressed(int direction){
        for(int [] keyLayout : keyLayouts){
            if(Gdx.input.isKeyJustPressed(keyLayout[direction])) return true;
        }
        return false;
    }


}

```