(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.setupBoard();
    $el.append(this.board);
    this.game = game;
  };

  View.prototype.bindEvents = function () {
  };

  View.prototype.makeMove = function ($square) {
  };

  View.prototype.setupBoard = function () {
    var $grid = $("<ul></ul>").addClass("grid").addClass("group");


    for (var i = 0; i < 9; i++)
    {
      var $cell = $("<li></li>");
      $grid.append($cell)
    }
    this.board = $grid;
  };
})();
