---
layout: product
name:  "Texture Studio"
categories: product software
bitbucket: texture-studio
---

Texture studio is a software for graphic designers and a tool for developers. It allow to easily build complex procedural textures to be used later in graphic software or games.

Concept could be compared to Pure Data : Compositing by plugging atoms together branching from output to input. The underlaying API allow developers to easily extends atoms or create new ones.

This software is opensource and totally free to use. <a href="https://bitbucket.org/germ1/texture-studio/downloads">Downloads</a> are available here. If you want to extend it, please go to the <a href="https://bitbucket.org/germ1/texture-studio/overview">project page</a>.

Here is some examples of what it can produce :

## 2D Procedural Textures

<img src="{{ site.baseurl }}/img/blog/texture-studio/2d.png">

## 3D Procedural Ray Tracing

<img src="{{ site.baseurl }}/img/blog/texture-studio/3d.png">

## Experimental features

* OpenGL realtime scenes
* Sound
* Kinect sensor
* Midi mapping/learning
* More ...

# How it works

Let's begin with the default 2D procedural texture (classique noise).

<img src="{{ site.baseurl }}/img/blog/texture-studio/step1.png">

Then we insert a sinusoid function between color mixer and noise.

<img src="{{ site.baseurl }}/img/blog/texture-studio/step2.png">

We insert again a Resampler to give a striped aspect.

<img src="{{ site.baseurl }}/img/blog/texture-studio/step3.png">

Now let's play with parameter, first we scale down the sinusoid a little.

<img src="{{ site.baseurl }}/img/blog/texture-studio/step4.png">

Then we add more strips by scaling down our resampler.

<img src="{{ site.baseurl }}/img/blog/texture-studio/step5.png">

Now we change the colors in the color mixer.

<img src="{{ site.baseurl }}/img/blog/texture-studio/step6.png">

Finally we tweak the noise, adding more octavia and reduce persistence a little to have something more natural (like mountains from top view)

<img src="{{ site.baseurl }}/img/blog/texture-studio/step7.png">

We can now save this patch as XML to work with it latter and we save the frame as PNG file.

<a href="{{ site.baseurl }}/img/blog/texture-studio/tuto.xml"/>Download this patch</a>

<img src="{{ site.baseurl }}/img/blog/texture-studio/tuto.png">

That's it !

# How atoms are made ?

Let see a simple one, the Sinusoidal operator (java comments explain how it works) :

``` java
package net.mgsx.numart.procedural.texture.impl;

import net.mgsx.numart.framework.annotations.ParamDouble;
import net.mgsx.numart.procedural.texture.ScalarOperator;

// ScalarOperator make this atom available in the UI for a compatible context.
public class Sinusoidal extends ScalarOperator {

	// we define here a parameter, its GUI is automatically generated.
	@ParamDouble(min=0.0, max=1.0)
	public double phase = 0.0;
	
	// we define here another parameter.
	@ParamDouble(min=0.0, max=20.0)
	public double frequency = 3.0;
	
	// This is our atom implementation, transforming the input scalar to
	// with our sinusoidal formula.
	public double getValue(double value) 
	{
		return 0.5 * (1 - Math.cos(2 * Math.PI * (value * frequency + phase)));
	}

}
```

That's it. All classes are scanned at startup so developer don't have to worry about anything else, his custom classe will popup in menus in a compatible context.

