using Toybox.Application as App;
using Toybox.Attention as Attention;
using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;

class GarmodoroDelegate extends Ui.BehaviorDelegate {
    var timer;
    var tickTimer;
    var minutes = 0;
    var pomodoroNumber = 1;
    var isPomodoroTimerStarted = false;
    var isBreakTimerStarted = false;

    function initialize() {
        Ui.BehaviorDelegate.initialize();
        timer = new Timer.Timer();
        tickTimer = new Timer.Timer();
        if (isPomodoroTimerStarted) {
            timer.start(method(:pomodoroCallback), 60 * 1000, true);
        }
        if (isBreakTimerStarted) {
            tickTimer.start(method(:idleCallback), 1000, true);
        }
    }

    function pomodoroCallback() {
        minutes -= 1;

        if (minutes == 0) {
            Attention.playTone(Attention.TONE_LAP);
            Attention.vibrate([new Attention.VibeProfile(100, 1500)]);
            tickTimer.stop();
            timer.stop();
            isPomodoroTimerStarted = false;
            minutes = App.getApp().getProperty(isLongBreak() ? "longBreakLength" : "shortBreakLength");
            timer.start(method(:breakCallback), 60 * 1000, true);
        }
    }

    function breakCallback() {
        minutes -= 1;

        if (minutes == 0) {
            Attention.playTone(Attention.TONE_LAP);
            Attention.vibrate([new Attention.VibeProfile(100, 1500)]);
            tickTimer.stop();
            timer.stop();
            isBreakTimerStarted = false;
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
}
