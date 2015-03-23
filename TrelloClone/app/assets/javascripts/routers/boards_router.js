TrelloClone.Routers.Boards = Backbone.Router.extend({

  initialize: function(options){
    this.$rootEl = options.$rootEl
    this.collection = TrelloClone.Collections.boards;
  },

  routes: {
    "": "index",
    "boards/new": "newBoard",
    "boards/:id": "showBoard"
  },

  index: function() {
    this.collection.fetch();
    var indexView = new TrelloClone.Views.BoardsIndex({
      collection: this.collection});
    this._swapView(indexView);
  },

  newBoard: function(){
    var board = new TrelloClone.Models.Board();
    var newBoardView = new TrelloClone.Views.BoardsNew({model: board});
    this._swapView(newBoardView);
  },

  showBoard: function(id){
    var board = TrelloClone.Collections.boards.getOrFetch(id);
    var boardView = new TrelloClone.Views.BoardShow({model: board});
    this._swapView(boardView);

  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el)
  },

});
