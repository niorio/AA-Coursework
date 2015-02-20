"use strict";

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame(){
  this.stacks = [[5,4,3,2,1],[],[]];
};

HanoiGame.prototype.isWon = function(){
  if (this.stacks[1].length === 5 || this.stacks[2].length === 5){
    return true;
  }
  else{
    return false;
  }
}

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx){
  var startTower = this.stacks[startTowerIdx];
  var endTower = this.stacks[endTowerIdx];
  if (startTower[startTower.length-1] > endTower[endTower.length-1]){
    return false;
  } else{
    return true;
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx){
  if (this.isValidMove(startTowerIdx, endTowerIdx)){

    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else{
    return false;
  }

}

HanoiGame.prototype.print = function(){
  console.log(JSON.stringify(this.stacks));
}

HanoiGame.prototype.promptMove = function(callback){
    this.print();
    reader.question("Where do you wish to move from and to?", function(response){
      var move = response.split(",");
      var start = parseInt(move[0]);
      var end = parseInt(move[1]);
      callback(start, end);
    });
}

HanoiGame.prototype.run = function(completionCallback){
  this.promptMove(function(start, end)
  {
      if(!this.move(start,end))
      {
          console.log("Illegal Move Entered!");
      }

      if(!this.isWon())
      {
          this.run(completionCallback);
      }
      else
      {
          completionCallback();
      }
  }.bind(this));
}


var game = new HanoiGame();
game.run(function()
{
  console.log("Congats, you are so smart.");
  reader.close();
})
