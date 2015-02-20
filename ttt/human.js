"use strict";


function Human(){


}

Human.prototype.getMove = function(reader, board, makeMove, completionCallback){

  var move;
  board.print();

  reader.question("\n\nWhere would you like to move?\n", function(answer){

    move = answer.split(",");
    move = [parseInt(move[0]), parseInt(move[1])];

    makeMove(move, completionCallback);
  });

}

module.exports = Human;
