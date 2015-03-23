TrelloClone.Views.BoardsNew = Backbone.View.extend({
  template: JST['boards/new'],

  tagName: 'form',

  events: {
    'click button': 'submit'
  },

  render: function() {
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  },

  submit: function() {
    console.log("hey!");
    attrs = this.$el.serializeJSON();
    this.model.save(attrs, {
      success: function (model) {
        debugger
        Backbone.history.navigate('#boards/' + model.id, {trigger: true});
      }
    })
  }

});
