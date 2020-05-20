@echo off
git add .
git commit -m "%1"
git push
npm publish
npm install -g generator-html5webgl 
echo "Pushed some code..."