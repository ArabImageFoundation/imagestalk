var jade = require('jade');
var template = require('fs').readFileSync('./test.jade');
var fn = jade.compile(template,{client:true})
console.log(fn.toString(),fn({something:'sdsad'}))