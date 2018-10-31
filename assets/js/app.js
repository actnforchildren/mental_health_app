// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import "./login"
import "./toolbox"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

// import elm code
// import Elm from "./elm.js"
var calendar = document.getElementById("elm-calendar");
if (calendar) {
  var app = Elm.Main.init({
    node: calendar,
    flags: millis
  })

  var calendar = document.getElementById("calendar");
  if(calendar) {

    setTimeout(function() {
      swipe(calendar, function(dir) {
        app.ports.swipe.send(dir);
      });
    });
  }
}

// swipe weekly log
var weeklyLog = document.getElementById("weekly-log");
if (weeklyLog) {
  swipe(weeklyLog, function(dir) {
    if (dir === "right") {
      window.location.href = previousWeek
    }

    if (dir === "left") {
      window.location.href = nextWeek
    }
  });
}

// swipe monthly log
var monthlyLog = document.getElementById("monthly-log");
if (monthlyLog) {
  swipe(monthlyLog, function(dir) {
    if (dir === "right") {
      window.location.href = previousMonth
    }

    if (dir === "left") {
      window.location.href = nextMonth
    }
  });
}

function swipe(el, callback){
  var swipedir;
  var startX;
  var startY;
  var distX;
  var distY;
  var threshold = 50;
  var restraint = 100;

  el.addEventListener('touchstart', function(e){
    var touchobj = e.changedTouches[0];
    swipedir = 'none';
    startX = touchobj.pageX;
    startY = touchobj.pageY;

  }, false);

  el.addEventListener('touchend', function(e){
    var touchobj = e.changedTouches[0]
    distX = touchobj.pageX - startX;
    distY = touchobj.pageY - startY;

    if (Math.abs(distX) >= threshold && Math.abs(distY) <= restraint) {
      swipedir = (distX < 0) ? 'left' : 'right';
    }

    callback(swipedir);
  }, false);
}
