TrelloClone.Views.ListShow = Backbone.View.extend({

  tagName: 'li',

  template: JST["lists/show"],

  events: {
    "click #new-card": "cardForm"
  },

  render: function () {
    this.$el.empty();
    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  cardForm: function (event) {
    
  }



})
