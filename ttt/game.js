"use strict";

var Board = require("./board");

function Game(reader, p1, p2){

    this.reader = reader;
    this.current_token = "X";
    this.current_player = p1;
    this.waitingPlayer = p2;
    this.board = new Board();
};

Game.prototype.run = function(completionCallback){

    if(this.board.winner() === -1)
    {
        this.current_player.getMove(this.reader, this.board, this.makeMove.bind(this), completionCallback);
    }
    else if(this.board.winner() === 0)
    {
      this.board.print();
      console.log("DRAW!");
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
        this.board.placeMark(move, this.current_token);

        if(this.current_token === "X")
        {
          this.current_token = "O";
        }
        else
        {
          this.current_token = "X";
        }

        var tmp = this.waitingPlayer;
        this.waitingPlayer = this.current_player;
        this.current_player = tmp;

    }
    else
    {
        if(this.current_player.constructor.name === "Human")
        {
            console.log("Invalid Move");
        }
    }

    this.run(completionCallback);
};

module.exports = Game;
