
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