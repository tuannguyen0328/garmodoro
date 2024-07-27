using Toybox.Application as App;
using Toybox.Attention as Attention;
using Toybox.WatchUi as Ui;

class StopMenuDelegate extends Ui.InputDelegate {
    var timer;
    var tickTimer;
    var minutes = 0;
    var pomodoroNumber = 1;
    var isPomodoroTimerStarted = false;
    var isBreakTimerStarted = false;

    function initialize() {
        Ui.InputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == "stop") {
            stopPomodoro();
        }
    }

    function stopPomodoro() {
        isPomodoroTimerStarted = false;
        isBreakTimerStarted = false;
        timer.stop();
        tickTimer.stop();
        Utility.ping(100, 1500);
        // Additional logic for stopping the Pomodoro timer
    }
}
