using Toybox.Application as App;
using Toybox.Timer as Timer;

class GarmodoroApp extends App.AppBase {
    var timer;
    var tickTimer;
    var isPomodoroTimerRunning = false;
    var isTickTimerRunning = false;
    var minutes = 0;
    var pomodoroNumber = 1;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        timer = new Timer.Timer();
        tickTimer = new Timer.Timer();

        if (state != null) {
            if (state.hasKey("isPomodoroTimerRunning")) {
                isPomodoroTimerRunning = state["isPomodoroTimerRunning"];
            }
            if (state.hasKey("isTickTimerRunning")) {
                isTickTimerRunning = state["isTickTimerRunning"];
            }
            if (state.hasKey("minutes")) {
                minutes = state["minutes"];
            }
            if (state.hasKey("pomodoroNumber")) {
                pomodoroNumber = state["pomodoroNumber"];
            }

            if (isPomodoroTimerRunning) {
                timer.start(method(:pomodoroCallback), 60 * 1000, true);
            }
            if (isTickTimerRunning) {
                tickTimer.start(method(:idleCallback), 1000, true);
            }
        } else {
            minutes = App.getApp().getProperty("pomodoroLength");
            pomodoroNumber = 1;
        }
    }

    function onStop(state) {
        state.put("isPomodoroTimerRunning", isPomodoroTimerRunning);
        state.put("isTickTimerRunning", isTickTimerRunning);
        state.put("minutes", minutes);
        state.put("pomodoroNumber", pomodoroNumber);

        tickTimer.stop();
        timer.stop();
    }

    function getInitialView() {
        return [ new GarmodoroView(), new GarmodoroDelegate() ];
    }
}
