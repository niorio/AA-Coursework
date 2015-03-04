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
  },

  events: {
    'dblclick .title': 'editTitle',
    'blur .title-input': 'saveTitle',
    'dblclick .body': 'editBody',
    'blur .body-input': 'saveBody'
  },

  editTitle: function(){
    var titleForm = JST['posts/edit_title']({title: this.model.escape('title')});
    this.$el.find('.title').html(titleForm);
  },

  saveTitle: function(){
    var newTitle = $(event.target).val();
    this.model.set({title: newTitle});
    var that = this;

    this.model.save({
      success: function() {
        that.render();
      }
    });
  },

  editBody: function(){
    var bodyForm = JST['posts/edit_body']({body: this.model.escape('body')});
    this.$el.find('.body').html(bodyForm);
  },

  saveBody: function(){
    var newBody = $(event.target).val();
    this.model.set({body: newBody});
    var that = this;
    this.model.save({
      success: function() {
        that.render();
      }
    });
  }

});
