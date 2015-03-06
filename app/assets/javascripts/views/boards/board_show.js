TrelloClone.Views.BoardShow = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, 'sync', this.render);
    this.subviews = [];
  },

  template: JST['boards/show'],

  events: {
    'submit form': 'submitNewList',
    'click #delete': 'deleteBoard'
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);

    var listView;
    var that = this;
    this.model.lists().each(function(list){
      listView = new TrelloClone.Views.ListShow({model: list});
      that.subviews.push(listView);
      that.$el.find($('#list-list')).append(listView.render().$el);
    })


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
