TrelloClone.Collections.Boards = Backbone.Collection.extend({

  model: TrelloClone.Models.Board,

  url: 'api/boards',

  getOrFetch: function(id){
    var model = this.get(id);
    if (model){
      model.fetch();
    } else {
      var that = this;
      model = new TrelloClone.Models.Board({id: id});
      model.fetch({
        success: function () {
          that.add(model);
        }
      });
    }
    return model;
  }

});

TrelloClone.Collections.boards = new TrelloClone.Collections.Boards();
