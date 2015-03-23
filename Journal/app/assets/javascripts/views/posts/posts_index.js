Journal.Views.PostsIndex = Backbone.View.extend({

  initialize: function(){
    this.listenTo(this.collection, 'remove', this.render);
    this.listenTo(this.collection, 'sync', this.render);
  },

  template: JST['posts/index'],

  render: function() {
    this.$el.empty();
    this.$el.html(this.template());

    this.collection.each(function(post){
      var postView = new Journal.Views.PostsIndexItem({model: post});
      var postli = postView.render().$el;
      this.$el.find('ul').append(postli);
    }.bind(this))

    return this;
  }

});
