'use strict';
var Generator = require('yeoman-generator');
module.exports = class extends Generator {
    constructor(args, opts) {
        super(args, opts);
        this.option('babel');
    }
    prompting() {
        return this.prompt([{
            type: 'input',
            name: 'name',
            message: 'Your project name',
            default: this.appname
        },
        {
            type: 'input',
            name: 'title',
            message: 'Your project title',
            default: this.appname
        },
        {
            type: 'input',
            name: 'author',
            message: 'Who are you?',
            default: 'The Working Class Hacker <workingclasshacker@gmail.com>'
        },
        {
            type: 'confirm',
            name: 'rayMarcher',
            message: 'Are you writing a Ray Marcher?',
            default: 'black'
        },
        {
            type: 'input',
            name: 'width',
            message: 'How wide should the canvas be?',
            default: 'window.innerWidth'
        },
        {
            type: 'input',
            name: 'height',
            message: 'How high should the canvas be?',
            default: 'window.innerHeight'
        }]).then((answers) => {          
            this.answers = answers;
        });
    }
    writing() {
        this.fs.copyTpl(
            this.templatePath('index.html'),
            this.destinationPath('index.html'),
            this.answers
        );
        this.fs.copyTpl(
            this.templatePath('css/style.css'),
            this.destinationPath('styles/' + this.answers.name + '.css'),
            this.answers
        );
        this.fs.copyTpl(
            this.templatePath('js/script.js'),
            this.destinationPath('scripts/' + this.answers.name + '.js'),
            this.answers
        );
        this.fs.copyTpl(
            this.templatePath('packagefile.json'),
            this.destinationPath('package.json'),
            this.answers
        );
        this.fs.copyTpl(
            this.templatePath("glsl/fragment.glsl"),
            this.destinationPath("shaders/fragment.shader"),
            this.answers
        );
        this.fs.copyTpl(
            this.templatePath("glsl/vertex.glsl"),
            this.destinationPath("shaders/vertex.shader"),
            this.answers
        );
    }
    install(){
        this.npmInstall();
    }

};