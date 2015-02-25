(function(){
  if (typeof window.Hanoi === "undefined" ){
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el){
    this.game = game;
    this.$el = $el;
    this.render();
    this.selectedTower = null;
    this.bindEvents();
  }

  View.prototype.bindEvents = function(){
    this.$el.on("click", ".tower", function(event){
      var $tower = $(event.currentTarget);
      this.clickTower($tower);
    }.bind(this));
  }

  View.prototype.clickTower = function($tower){
    if (this.selectedTower === null){
      this.selectedTower = $tower.index();
      $tower.addClass('selected');
    }
    else {
      var moveTo = $tower.index();
      if (this.game.move(this.selectedTower, moveTo) === false){
        alert("Invalid Move");
      } ;
      this.render();
      if (this.game.isWon()){
        alert("You Win!");
      }
      this.selectedTower = null;
    }
  }


  View.prototype.render = function(){
    this.$el.empty();
    var towers = this.game.towers;
    for (var i = 0; i < towers.length; i++){
      var $tower = $("<ul>").addClass('tower');
      for (var j = 0; j < 3; j++){
        if (towers[i][j]){
          var $block = $("<li></li>").addClass("block" + towers[i][j]);
        } else {
          var $block = $("<li></li>").addClass("invisible");
        }

        $tower.prepend($block);
      }
      this.$el.append($tower);
    }
  }




})();
