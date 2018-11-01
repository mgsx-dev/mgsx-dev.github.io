---

tags: input
---

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