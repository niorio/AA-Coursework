Journal.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'],
  render: function() {
    this.$el.empty();
    this.$el.html(this.template());

    var postView;
    var postli;
    this.collection.each(function(post){
      postView = new Journal.Views.PostsIndexItem({model: post});
      postli = postView.render().$el;
      this.$el.find('ul').append(postli);
    }.bind(this))

    return this;
  }

});
