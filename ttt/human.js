"use strict";


function Human(mark){
  this.human = true;
  this.mark = mark;

}

Human.prototype.getMove = function(reader, makeMove, completionCallback){
  var move;

  reader.question("\nWhere would you like to move?\n", function(answer){

    move = answer.split(",");
    move = [parseInt(move[0]), parseInt(move[1])];

    makeMove(move, completionCallback);
  });

}

module.exports = Human;
