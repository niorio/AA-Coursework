"use strict";

var Board = require("./board");

function Game(reader, p1, p2){

  this.reader = reader;
  this.currentPlayer = p1;
  this.waitingPlayer = p2;
  this.board = new Board();
};

Game.prototype.run = function(completionCallback){

  if (this.currentPlayer.human){
    this.board.print();
  }

  if(this.board.winner() === -1)
  {
    this.currentPlayer.getMove(this.reader, this.makeMove.bind(this), completionCallback);
  }
  else if(this.board.winner() === 0)
  {
    this.board.print();
    console.log("Draw!");
    completionCallback();
  }
  else
  {
    this.board.print();
    console.log(this.board.winner() + " Wins!");
    completionCallback();
  }
}

Game.prototype.makeMove = function(move, completionCallback){

  if(this.board.empty(move))
  {
    this.board.placeMark(move, this.currentPlayer.mark);

    var tmp = this.waitingPlayer;
    this.waitingPlayer = this.currentPlayer;
    this.currentPlayer = tmp;

  }
  else
  {
    if(this.currentPlayer.human)
    {
      console.log("Invalid Move");
    }
  }

  this.run(completionCallback);
};



module.exports = Game;
