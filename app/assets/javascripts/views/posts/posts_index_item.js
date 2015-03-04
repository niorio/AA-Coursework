Journal.Views.PostsIndexItem = Backbone.View.extend({

  template: JST['posts/index_item'],
  tagName: 'li',
  render: function() {
    this.$el.empty();
    item = this.template({post: this.model});
    this.$el.html(item);
    return this;
  }

});
