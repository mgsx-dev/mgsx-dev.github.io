---
layout: blog
name:   "LibGDX code sharing"
date: 2018-02-16 12:00:00
type: blog
group:  libgdx
published: false
---

This post explore the ways to share code between your libGDX projets.

Note that all these technics are not specific to libGDX and could be used for any Gradle projects.

It is very common to have several libGDX projects (specific games) that have common needs and we don't want to reinvent the wheel, that's why we're using libGDX extensions, java libraries and libGDX itself. But sometimes we want to make our own library containing for instance some widgets, some utility class and so on.

While public library are easy usable in a project through dependencies, the questions is how technically use some personal shared code across all our projects and why not use some other library or public our own library.

What to take in considerations :

* Is our library is public (open-source) ?
* Is our library is cross-platform or have platform specific code ?
* Is our library stable, that is enough generalized and well designed (are we confident) ?

Which questions this article will try to answer :

* How to setup such library ?
* How to ensure flow with other developper on game projects run smoothly ?
* How to make it usable by others ?
* How to deal with lifecycle, versionning, bug fixing, improvements, breaking changes ?

Next are all the possible solution from the most hand-made to the most industrialized.

# Solutions

## The copy/paste method

This method is the less industrialized but have pros and cons : 

The pros : 

* Nothing to setup, just copy paste what we need
* Import just what you need
* Doesn't matter if the piece of code is stable or not, we could fix, modify or break it for the game specifics needs.

The cons :

* It is completetly detached form original, so change tracking is not easy (you have to recopy again and again ..)
* 

## Local project linking

the not recommended ways : 

* import a jar
* link project in IDE : brocken when gradle regenerate your IDE files
* link with gradle settings (include '../mylib') : others devs should have the same layout and dual git checkout is matter.

the recommended way :

pubishToLocalMaven : 

* act exactly like normal dependency management flow

Note : this is how you do when you want to develop both on the libray and use it in another project (SNAPSHOT)


## Published library

several ways : 

* jitpack.io : nothing to setup, all you need is to have your libray publicly available (eg. github) but you can't use a local version and dependency name is very specific to jitpack naming layout.
* jcenter (and others) : that's ok
* maven central : no needs to add more repository in games but the publish process is more complicated. This method is mandatory to make your extension official in libGDX setup.