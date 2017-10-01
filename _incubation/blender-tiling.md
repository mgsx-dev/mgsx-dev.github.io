
# Concept

A grid of 8x8 tiles usable in Tiled. Tile are 32x32 pixels.

# Configure blender

From default blender scene you should have a *Camera*, a *Lamp* and a *Cube*.

**Camera**: 
    * reset position and rotation at zero and move camera up on Z axis at 4 (**G Z 4 Enter**).
    * set orthographic with orthographic scale 8 (1 unit = 1 grid cell)

**Render settings**:
    * For 32x32 tiles resolution at 8x8 grid gived 256x256 : put resolution 256x256 and 100% render

**Background**
    * transform cube as background and cover grid + extra secure zone (**Tab S 5 Enter S Z 0.1 Enter Tab G Z -1 Enter**)

**Lamp**
    * set as sun and ensure shadows enabled

# First tile

    * get to camera view (**num-0**) and pickup center of a cell (**L-Button**)
    * create a cube and scale it to fit in half the cell
    * show render by selection rendered mode ****
    * setup world : indirect lighting to 0.3
    * change light intensity to 0.5

# Terran

    * reset 3D cursor at zero
    * create cube and move it at **G X 0.5 Enter G Y 0.5 Enter**


# Export

    $ blender -b file.blend -S Scene -o sprite-sheet.png -F PNG -f 1