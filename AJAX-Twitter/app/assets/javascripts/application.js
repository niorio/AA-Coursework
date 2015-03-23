// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require_tree .

$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render();
  this.$el.on("click", this.handleClick.bind(this));
  this.follower = options.follower;
};

$.FollowToggle.prototype.render = function () {
  var buttonText = this.followState === "followed" ? "unfollow!" : "follow!";
  this.$el.text(buttonText);
};

$.FollowToggle.prototype.handleClick = function(event){
  event.preventDefault();

  var actionType, newState;
  if (this.followState === "followed"){
    actionType = "delete";
    newState = "unfollowed";
  } else {
    actionType = "post";
    newState = "followed";
  }

  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: actionType,
    dataType: "JSON",
    success: function () {
      this.$el.prop("disabled", false)
      this.toggleFollower();
      }.bind(this)
  })

  this.toggleState(newState);
  this.render();
  this.$el.prop("disabled", true)
};

$.FollowToggle.prototype.toggleState = function(state){
  this.$el.data("initial-follow-state", state);
  this.followState= state;
}

$.FollowToggle.prototype.toggleFollower = function(){
  if (this.followState === "unfollowed"){
    $('#user-followers > li').each(function(idx, child){
      if ($(child).text() === this.follower) {
        $(child).remove();
      }
    }.bind(this))
  } else {
    $('#user-followers').append("<li>"+ this.follower + "</li>");
  }

}

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};
