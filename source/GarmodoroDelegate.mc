using Toybox.Application as App;
using Toybox.Attention as Attention;
using Toybox.WatchUi as Ui;

var timer;
var tickTimer;
var minutes = 0;
var pomodoroNumber = 1;
var isPomodoroTimerStarted = false;
var isBreakTimerStarted = false;

function ping(dutyCycle, length) {
    if (Attention has :vibrate) {
        Attention.vibrate([new Attention.VibeProfile(dutyCycle, length)]);
    }
}

function play(tone) {
    if (Attention has :playTone && !App.getApp().getProperty("muteSounds")) {
        Attention.playTone(tone);
    }
}

function idleCallback() {
    Ui.requestUpdate();
}

function isLongBreak() {
    return (pomodoroNumber % App.getApp().getProperty("numberOfPomodorosBeforeLongBreak")) == 0;
}

function resetMinutes() {
    minutes = App.getApp().getProperty("pomodoroLength");
}

class GarmodoroDelegate extends Ui.BehaviorDelegate {
    function initialize() {
        Ui.BehaviorDelegate.initialize();
        timer.start(method(:idleCallback), 60 * 1000, true);
    }

    function pomodoroCallback() {
        minutes -= 1;

        if (minutes == 0) {
            play(10); // Attention.TONE_LAP
            ping(100, 1500);
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
            play(10); // Attention.TONE_LAP
            ping(100, 1500);
            tickTimer.stop();
            timer.stop();
            isBreakTimerStarted = false;
            resetMinutes();
        }
    }
}
