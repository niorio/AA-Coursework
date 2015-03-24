function Board(){

  this.grid = [];

  for(var i = 0; i < 3; i += 1){
    this.grid.push([null,null,null])
  }

};

Board.prototype.print = function(){
  for(var i = 0; i < 3; i += 1){
    console.log(this.grid[i]);
  }
}

Board.prototype.winner = function(){
  for(var i = 0; i < 3; i++){
    if (this.grid[0][i] === this.grid[1][i] && this.grid[0][i] === this.grid[2][i] && this.grid[0][i] !== null){
      return this.grid[0][i];
    }
  }
  for(var i = 0; i < 3; i++){
    if (this.grid[i][0] === this.grid[i][1] && this.grid[i][0] === this.grid[i][2] && this.grid[i][0] !== null){
      return this.grid[i][0];
    }
  }

  if (this.grid[0][0] === this.grid[1][1] && this.grid[1][1] === this.grid[2][2] && this.grid[1][1] !== null){
    return this.grid[0][0];
  }
  if (this.grid[0][2] === this.grid[1][1] && this.grid[1][1] === this.grid[2][0] && this.grid[1][1] !== null){
    return this.grid[0][2];
  }

  var empty_spaces = false;
  for(var i = 0; i < 3; i += 1)
  {
    for(var j = 0; j < 3; j += 1){
      if(this.grid[i][j] === null){
        empty_spaces = true;
      }
    }
  }

  if(empty_spaces === false){
    return 0;
  }

  return -1;
};


Board.prototype.empty = function(pos){

  if( this.grid[pos[0]][pos[1]] === null ){
    return true;
  } else {
    return false;
  }

};

Board.prototype.placeMark = function(pos, mark){

  this.grid[pos[0]][pos[1]] = mark;

};












module.exports = Board;
