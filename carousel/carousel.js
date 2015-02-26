$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.find('.items img:first-child').addClass('active')
  this.$el.on('click', '.slide-right', this.slideRight.bind(this) );
  this.$el.on('click', '.slide-left', this.slideLeft.bind(this) );
};


$.Carousel.prototype.slideLeft = function () {
  this.slide(1);
};


$.Carousel.prototype.slideRight = function () {
  this.slide(-1);
};

$.Carousel.prototype.slide = function(dir){
  if (this.transitioning){
    return;
  }

  this.transitioning = true;

  var $oldimg = this.$el.find('.items img').eq(this.activeIdx);

  this.activeIdx += dir;
  if (this.activeIdx < 0){
    this.activeIdx = this.$el.find('.items img').length - 1;
  }
  if (this.activeIdx > (this.$el.find('.items img').length - 1)){
    this.activeIdx = 0;
  }

  var $activeimg = this.$el.find('.items img').eq(this.activeIdx)
  console.log($activeimg);

  if (dir === 1){
    $activeimg.addClass('right').addClass('active');
  } else if (dir === -1) {
    $activeimg.addClass('left').addClass('active');
  }

  setTimeout(function () {
    // debugger;
    if (dir === 1){
      $oldimg.addClass('left');
      $activeimg.removeClass('right');
    } else if (dir === -1) {
      $oldimg.addClass('right');
      $activeimg.removeClass('left');
    }
  }, 0)

  $activeimg.one("transitionend", function (event) {
    // debugger;
    $oldimg.removeClass();
    this.transitioning = false;

  }.bind(this));
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
