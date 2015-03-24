'use strict';

var t3 = require("./index");
var readline = require('readline');


var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var p1 = new t3.Human('X');
var p2 = new t3.Computer('O');

var game = new t3.Game(reader, p1, p2);

game.run(function(){
  reader.close();
});
