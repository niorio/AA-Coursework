Journal.Views.PostShow = Backbone.View.extend({

  initialize: function(){
    this.listenTo(this.model, 'change', this.render);
  },

  template: JST['posts/show'],

  render: function() {
    this.$el.empty();
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }
});
