'use strict';

var t3 = require("./index");
var readline = require('readline');


var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var game = new t3.Game(reader);

game.run(function(){
  console.log("game over");
  reader.close();
});
