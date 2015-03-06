TrelloClone.Collections.Boards = Backbone.Collection.extend({

  model: TrelloClone.Models.Card,

  url: 'api/cards'

});
