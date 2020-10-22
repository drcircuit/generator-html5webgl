# generator-html5webgl
A simple yeoman generator for webgl. I made this because I love shadertoy. But I wanted to learn more about how you get everything bootstraped so that you can host this yourself. This essentially gives you most of what you get with shadertoy - except for textures and cubemaps, and extra buffers - but that will come soon!


# Shaders
Once you create your project, you get two files, one called fragment.shader, and one called vertex.shader. These are loaded through the javascript included in the page. This means no more inline code as strings. You can now use a nice editor with syntax highlighting and code completion to code your webgl. 
## Vertex Shader
The standard vertex shader is like shadertoy, it assumes you want to use the pixel shader to all your stuff, either in 3d or 2d. So this is just a basic face, facing directly towards the viewport. 
But you can change this into whatever you want, but then you need to change the javascript aswell.

## Fragment Shader
### Ray Marcher
If you opted for the Ray Marcher option during the wizard, you will get some standard SDFs (Signed Distance Functions) as well as a basic camera model, the ray marching loop, the normal calculation and a basic color shading based on a light straight above your geometry.
You also have some basic boolean functions to transform your SDFs. Now you can move on and extend it with the functionality you want.

### 2d effect
If you said no to the Ray Marcher, you get a pretty basic effect, just fading colors based on the pixel position.

Now you know what this thing is for! GO NUTS! And create something beautiful!
