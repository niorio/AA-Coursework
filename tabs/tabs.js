$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeTab = this.$contentTabs.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
  };

$.Tabs.prototype.clickTab = function(event){
  event.preventDefault();

  this.$activeTab.removeClass('active');
  this.$activeTab.addClass('transitioning');
  this.$el.find('a').removeClass('active');

  var newTab = $(event.currentTarget);
  newTab.addClass('active');

  this.$activeTab.one("transitionend", function (event) {

    this.$activeTab.removeClass('transitioning')
    var newLink = newTab.attr('href');
    this.$activeTab = this.$contentTabs.find(newLink);
    this.$activeTab.addClass('active');
    this.$activeTab.addClass('transitioning');

    setTimeout(function () {
      this.$activeTab.removeClass('transitioning')
    }.bind(this), 0);

  }.bind(this));
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
