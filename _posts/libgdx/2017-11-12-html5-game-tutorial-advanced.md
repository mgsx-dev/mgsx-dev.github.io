---
layout: blog
name:   "WebGL game with Libgdx (part 2)"
type:   blog
group:  libgdx
permalink: html5-libgdx-tutorial-advanced
---

This tutorial following the [WebGL game with Libgdx (part 1)]({{ site.baseurl }}/html5-libgdx-tutorial.html)

Thanks to [MonsterOfCookie](https://github.com/MonsterOfCookie) and [MrStahlfelge](https://github.com/MrStahlfelge) for their help.


# Keyboard handling

Some special web browser keyboard hotkeys could trigger some undesirable behaviors.

You can find some of them [here](https://www.howtogeek.com/114518/47-keyboard-shortcuts-that-work-in-all-web-browsers/)

## Preventing some web browser behaviors

For instance, if you need the F1 keys in your game, it actually trigger the browser help openning a new page.

Here is a javascript example you can use to prevent it. Note that your game still receive the event. 

```javascript
window.onkeydown =
    function(event) {
        // prevent web browser to open the help page (F1 key)
        if(event.keyCode == 112){
            event.preventDefault();
            return false;
        }                
    };
```

Preventing all possible browser hotkeys is not a good idea. Sometimes you want some to occur (F12 to open dev tools, F5 to refresh, Ctrl+T to open a new tab).

It's then recommended to just prevent browser hotkeys you're really using in your game.


## Preventing page scrolling

Browser implements page scrolling hotkeys that could conflicts with your game : 

* Space, Page Down, Arrow Down – Scroll down a frame.
* Shift+Space, Page Up, Arrow Up – Scroll up a frame.
* Home – Top of page.
* End – Bottom of page.
* Arrow Left  – Scroll left a frame.
* Arrow right  – Scroll right a frame.

Note that the space key is a special case : prevent it from key down event would prevent the key press event to occur and the space character won't be typed in the TextField widget.

Here is a javascript template you can use to prevent page scrolling without messing with TextField widget :

```javascript
window.onkeypress =
    function(event) {
        // prevent the space key (page scroll down)
        if(event.keyCode == 32){
            event.preventDefault();
            return false;
        }
    };

window.onkeydown =
    function(event) {
        // prevent all navigation keys except the space key
        if(event.keyCode >= 33 && event.keyCode <= 40){
            event.preventDefault();
            return false;
        }                
    };
```