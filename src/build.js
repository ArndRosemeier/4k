const fs=require('fs');
let s=fs.readFileSync(__dirname+'/fs.glsl','utf8').replace(/\/\/.*$/gm,'').replace(/\s+/g,' ').replace(/ ?([^\w.\s]) ?/g,'$1').replace(/precision highp float;/,'precision highp float;').trim();
s=s.replace(/^precisionhighp/,'precision highp');
let h=fs.readFileSync(__dirname+'/tpl.html','utf8').replace('$FS',s).replace(/\n/g,'');
fs.writeFileSync(__dirname+'/../index.html',h);console.log(Buffer.byteLength(h),'bytes');
