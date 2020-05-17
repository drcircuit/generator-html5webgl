
/** <%= name %> */
var canvas = document.getElementById("space");
var gl = canvas.getContext("experimental-webgl");

loadShaders(ready);

function ready(){
    console.log("ready");
    // do geometry stuff here.
    gl.useProgram(program);
}

function loadShaders(cb) {
    fetch("/shaders/vertex.shader")
        .then((res) => res.text())
        .then((text) => {
            program = gl.createProgram();
            buildShader(text, gl.VERTEX_SHADER, program);
            return fetch("/shaders/fragment.shader");
        })
        .then((res) => res.text())
        .then((text) => {
            buildShader(text, gl.FRAGMENT_SHADER, program);
            gl.linkProgram(program);
            if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
                console.error("Cannot link program", gl.getProgramInfoLog(program));
            }
            cb();
        })
        .catch((err) => {
            console.log(err);
        });

}
function buildShader(source, type, program) {
    let shader = gl.createShader(type);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
        console.error("Cannot compile shader\nSyntax error!", gl.getShaderInfoLog(shader));
        return;
    }
    gl.attachShader(program, shader);
}
