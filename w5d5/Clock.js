'use strict'

function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var timeH = this.date.getHours();
  var timeM = this.date.getMinutes();
  var timeS = this.date.getSeconds();
  console.log(timeH + ":" + timeM + ":" + timeS);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  this.date = new Date();
  // 2. Call printTime.
  this.printTime();
  // 3. Schedule the tick interval.
  setInterval(this._tick.bind(this),Clock.TICK)
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  this.date.setSeconds(this.date.getSeconds() + 5);
  // 2. Call printTime.
  this.printTime();
};

var clock = new Clock();
clock.run();
