"use strict";


function Computer(mark){
  this.mark = mark;
}

Computer.prototype.getMove = function(reader, makeMove, completionCallback){

  var move= [Math.floor(Math.random() * 3), Math.floor(Math.random() * 3)];
  makeMove(move, completionCallback);

}

module.exports = Computer;
