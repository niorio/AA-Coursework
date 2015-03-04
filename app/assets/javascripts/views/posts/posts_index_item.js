Journal.Views.PostsIndexItem = Backbone.View.extend({

  template: JST['posts/index_item'],

  tagName: 'li',

  events: {'click button': 'deletePost'},

  render: function() {
    this.$el.empty();
    var item = this.template({post: this.model});
    this.$el.html(item);
    return this;
  },

  deletePost: function(){
    this.model.destroy();
  }

});
