(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.setupBoard();
    $el.append(this.board);
    this.game = game;
    this.$el = $el
  };

  View.prototype.bindEvents = function () {
    this.$el.find('.grid').on("click", "li", function(event){
      var $cell = $(event.currentTarget);
      var currentId = $cell.attr('id');
      var pos = parseNum(currentId);

      try {
        this.game.playMove(pos);
      } catch(moveError){
        alert("Invalid Move!");
      }

      this.makeMove($cell);
      if (this.game.winner())
      {
        var $winningCells = $('.' + this.game.currentPlayer);
        $winningCells.addClass('victory');
      }
    }.bind(this));
  };

  var parseNum = function (num)
  {
    var x = Math.floor(num / 3);
    var y = num % 3;
    return [x, y];
  }

  View.prototype.makeMove = function ($square) {
    $square.addClass('clicked');
    $square.text(this.game.currentPlayer);
    $square.addClass(this.game.currentPlayer);
  };

  View.prototype.setupBoard = function () {
    var $grid = $("<ul></ul>").addClass("grid").addClass("group");


    for (var i = 0; i < 9; i++)
    {
      var $cell = $("<li></li>").attr('id', i);
      $grid.append($cell)
    }
    this.board = $grid;
  };
})();
