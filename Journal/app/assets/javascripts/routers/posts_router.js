Journal.Routers.Posts = Backbone.Router.extend({
  initialize: function(options) {
    this.$el = options.$el;
    this.$el.append('<div class="sidebar">');
    this.$el.append('<div class="content">');
    this.collection = new Journal.Collections.Posts();
    this.collection.fetch();

    var indexView = new Journal.Views.PostsIndex({collection: this.collection});
    this.$el.find(".sidebar").html(indexView.render().$el);
  },

  routes: {
    "" : "index",
    "posts/new": "new",
    "posts/:id" :"show",
    "posts/:id/edit": "edit"
  },

  index: function(){
    this.$el.find('.content').empty();
  },

  show: function(id) {
    var post = this.collection.getOrFetch(id);
    var postView = new Journal.Views.PostShow({model: post});
    this.$el.find('.content').html(postView.render().$el);
  },

  edit: function(id) {
    var post = this.collection.getOrFetch(id);
    var form = new Journal.Views.PostForm({
      model: post,
      collection: this.collection});
    this.$el.find('.content').html(form.render().$el);
    this.$el.find('.content').prepend("<h2> Edit Post </h2>");
  },

  new: function() {
    var post = new Journal.Models.Post();
    var form = new Journal.Views.PostForm({
      model: post,
      collection: this.collection})
    this.$el.find('.content').html(form.render().$el);
    this.$el.find('.content').prepend("<h2> Edit Post </h2>");


  }



});
