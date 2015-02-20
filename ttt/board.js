function Board(){

  this.board = [];

  for(var i = 0; i < 3; i += 1)
  {
    this.board.push([null,null,null])
  }

};

Board.prototype.print = function(){
  for(var i = 0; i < 3; i += 1)
  {
    console.log(this.board[i]);
  }
}

Board.prototype.winner = function(){
  for(var i = 0; i < 3; i++){
    if (this.board[0][i] === this.board[1][i] && this.board[0][i] === this.board[2][i] && this.board[0][i] !== null){
      return this.board[0][i];
    }
  }
  for(var i = 0; i < 3; i++){
    if (this.board[i][0] === this.board[i][1] && this.board[i][0] === this.board[i][2] && this.board[i][0] !== null){
      return this.board[i][0];
    }
  }

  if (this.board[0][0] === this.board[1][1] && this.board[1][1] === this.board[2][2] && this.board[1][1] !== null){
    return this.board[0][0];
  }
  if (this.board[0][2] === this.board[1][1] && this.board[1][1] === this.board[2][0] && this.board[1][1] !== null){
    return this.board[0][2];
  }

  var empty_spaces = false;
  for(var i = 0; i < 3; i += 1)
  {
      for(var j = 0; j < 3; j += 1)
      {
          if(this.board[i][j] === null)
          {
              empty_spaces = true;
          }
      }
  }

  if(empty_spaces === false)
  {
      return 0;
  }

  return -1;
};


Board.prototype.empty = function(pos){

  if( this.board[pos[0]][pos[1]] === null )
  {
      return true;
  }
  else
  {
      return false;
  }

};

Board.prototype.placeMark = function(pos, mark){

  this.board[pos[0]][pos[1]] = mark;

};
















module.exports = Board;
