$.Thumbnails = function (el) {
  this.$el = $(el)
  this.$activeImg = this.$el.find('.gutter-images img:first-child');
  this.activate(this.$activeImg)
  console.log(this.$activeImg)
}

$.Thumbnails.prototype.activate = function ($img) {
  this.$el.find('.active').append($img);
}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
