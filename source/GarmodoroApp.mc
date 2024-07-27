using Toybox.Application as App;
using Toybox.Timer as Timer;

class GarmodoroApp extends App.AppBase {

	function initialize() {
		AppBase.initialize();
	}

	function onStart(state) {
		timer = new Timer.Timer();
		tickTimer = new Timer.Timer();
	}

	function onStop(state) {
		tickTimer.stop();
		timer.stop();
	}

	function getInitialView() {
		return [ new GarmodoroView(), new GarmodoroDelegate() ];
	}
}
