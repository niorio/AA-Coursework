var Board = require("./board");

function Game(reader){

    this.reader = reader;
    this.current_token = "X";
    this.board = new Board();

};

Game.prototype.run = function(completionCallback){

    if(this.board.winner() === -1)
    {
        this.board.print();
        this.reader.question("\n\nWhere would you like to move?\n", this.makeMove.bind(this, completionCallback));
    }
    else
    {
        console.log(this.board.winner() + " Wins!");
        completionCallback();
    }
}

Game.prototype.makeMove = function(completionCallback, answer){

    var move = answer.split(",");

    move = [parseInt(move[0]), parseInt(move[1])];

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

    }
    else
    {
        console.log("Invalid Move");
    }

    this.run(completionCallback);
};

module.exports = Game;
