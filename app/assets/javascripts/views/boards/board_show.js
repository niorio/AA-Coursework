TrelloClone.Views.BoardShow = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, 'sync', this.render);
  },

  template: JST['boards/show'],

  events: {
    'submit form': 'submitNewList',
    'click #delete': 'deleteBoard'
  },

  render: function () {
    debugger
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  submitNewList: function (event) {
    event.preventDefault();
    var attrs = $(event.target).serializeJSON();

    var board = this.model
    var newList = new TrelloClone.Models.List({board_id: this.model.id});
    newList.save(attrs, {
      success: function() {
        board.fetch();
      }
    });
  },

  deleteBoard: function(){
    this.model.destroy({
      wait: true,
      success: function(){
        Backbone.history.navigate('', {trigger: true})
      }
    });
  }


})
