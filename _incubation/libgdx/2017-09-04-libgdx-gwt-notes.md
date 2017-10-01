---
layout: blog
name:   "LibGDX and GWT"
type:   blog
group:  libgdx
permalink: libgdx-gwt
---

This page gather considerations when targetting html5 with LibGDX.

# Reflection

When using generic collection like (Array, Pool ...) or java arrays you have to declare these in GWT definitions:


```
<module>
	...
	<extend-configuration-property name="gdx.reflect.include" value="com.your.package.YourClass1" />
	<extend-configuration-property name="gdx.reflect.include" value="com.your.package.YourClass2" />
</module>

```

You have to set visibility of these types to public as well.

When using external library which not provide GWT definition, you need to create one either by including the whole package or a subset like this:

```
<module>
	<source path="com/the/package/of/the/library">
		<include name="Type1Used.java" />
		<include name="Type2Used.java" />
		...
	</source>
</module>

```

# Storage

Only preferences are supported. It is key/value pairs model store in HTML5 localStorage. If you need to store more complex structure like JSON, you could store the serialized data as a string field in preferences.

# Other limitations

* long type for public fields on serialized class are not supported.
* the application dispose method is not called.


# Debugging / developping

!!! asset not found because of chrome cache on assets.txt file !!! => clear cche in browser or disable caching fix it.