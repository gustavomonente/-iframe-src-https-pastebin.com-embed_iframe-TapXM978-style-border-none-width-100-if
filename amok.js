var ar = require('ar-drone');
var drone = ar.createUdpControl();

var ref = { emergency : true };
var pcmd = {};

setTimeout(function () {
  ref.emergency = false;
  ref.fly = true;
  setTimeout(amok, 4000);
}, 1000);

setTimeout(function () {
  ref.fly = false;
}, 30 * 1000);

setInterval(function () {
  drone.ref(ref);
  drone.pcmd(pcmd);
  drone.flush();
}, 30);

function amok () {
  var iv = setInterval(function () {
    pcmd = {};
    ref = { fly : true };
    var actions = [
      function () { up(Math.random() * 2 - 1) },
      function () { left(Math.random() * 2 - 1) },
      function () { turn(Math.random() * 2 - 1) },
    ];
    actions[Math.floor(Math.random() * actions.length)]();
  }, 1000);
  
  setTimeout(function () {
    ref.fly = false;
  }, 10 * 1000);
}  

function takeOff () {
  ref.fly = true;
  ref.emergency = false;
  drone.flush();
}

function land () {
  ref.fly = false;
}

function front (v) {
  pcmd.front = v;
}

function left (v) {
  pcmd.left = v;
}

function up (v) {
  pcmd.up = v;
}

function turn (v) {
  pcmd.clockwise = v;
}
