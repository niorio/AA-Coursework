"use strict";


function Computer(){


}

Computer.prototype.getMove = function(reader, board, makeMove, completionCallback){

  var move= [Math.floor(Math.random() * 3), Math.floor(Math.random() * 3)];
  makeMove(move, completionCallback);


}

module.exports = Computer;
