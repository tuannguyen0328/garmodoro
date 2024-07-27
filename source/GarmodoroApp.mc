using Toybox.Application as App;
using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.System as Sys;

class GarmodoroApp extends App.AppBase {
    // var timer;
    // var tickTimer;
    var isPomodoroTimerRunning = false;
    var isTickTimerRunning = false;
    var minutes = 0;
    var pomodoroNumber = 1;

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        Sys.println("onStart called");
        timer = new Timer.Timer();
        tickTimer = new Timer.Timer();

        if (state != null) {
            Sys.println("Restoring state");
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
        Sys.println("onStop called");
        if (state != null) {
            state.put("isPomodoroTimerRunning", isPomodoroTimerRunning);
            state.put("isTickTimerRunning", isTickTimerRunning);
            state.put("minutes", minutes);
            state.put("pomodoroNumber", pomodoroNumber);
        }

        // if (tickTimer != null) {
        //     tickTimer.stop();
        // }
        // if (timer != null) {
        //     timer.stop();
        // }
    }

    function getInitialView() {
        return [new GarmodoroView(), new GarmodoroDelegate()];
    }

    function pomodoroCallback() {
        minutes -= 1;
        if (minutes == 0) {
            ping(100, 1500);

            isPomodoroTimerRunning = false;
            // timer.stop();

            // Switch to break
            minutes = App.getApp().getProperty(isLongBreak() ? "longBreakLength" : "shortBreakLength");
            // timer.start(method(:breakCallback), 60 * 1000, true);
        }
    }

    function breakCallback() {
        minutes -= 1;
        if (minutes == 0) {
            ping(100, 1500);
            isTickTimerRunning = false;
            // timer.stop();
            resetMinutes();
        }
    }

    function isLongBreak() {
        return (pomodoroNumber % App.getApp().getProperty("numberOfPomodorosBeforeLongBreak")) == 0;
    }

    function resetMinutes() {
        minutes = App.getApp().getProperty("pomodoroLength");
    }

    function idleCallback() {
        Ui.requestUpdate();
    }

    function ping(dutyCycle, length) {
        if (Attention has :vibrate) {
            Attention.vibrate([new Attention.VibeProfile(dutyCycle, length)]);
        }
    }
}
