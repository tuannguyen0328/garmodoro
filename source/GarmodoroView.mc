using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Time as Time;

class GarmodoroView extends Ui.View {
    var isPomodoroTimerStarted;
    var isBreakTimerStarted;
    var minutes;
    var pomodoroNumber;

    function initialize(isPomodoroTimerStarted, isBreakTimerStarted, minutes, pomodoroNumber) {
        self.isPomodoroTimerStarted = isPomodoroTimerStarted;
        self.isBreakTimerStarted = isBreakTimerStarted;
        self.minutes = minutes;
        self.pomodoroNumber = pomodoroNumber;
    }

    function onUpdate(dc) {
        dc.clear();

        if (self.isPomodoroTimerStarted) {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            drawMinutes(dc);
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
            drawCaption(dc);
        } else {
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 4, Gfx.FONT_LARGE, "Ready", Gfx.TEXT_JUSTIFY_CENTER);
        }

        if (!self.isBreakTimerStarted) {
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_MEDIUM, "Pomodoro #" + self.pomodoroNumber, Gfx.TEXT_JUSTIFY_CENTER);
        }

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4, Gfx.FONT_NUMBER_MILD, getTime(), Gfx.TEXT_JUSTIFY_CENTER);
    }

    hidden function drawMinutes(dc) {
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4 - 30, Gfx.FONT_NUMBER_THAI_HOT, self.minutes.format("%02d"), Gfx.TEXT_JUSTIFY_CENTER);
    }

    hidden function drawCaption(dc) {
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4 - 60, Gfx.FONT_TINY, "Pomodoro Timer", Gfx.TEXT_JUSTIFY_CENTER);
    }

    function onHide() {}

    function getTime() {
        var today = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        return Lang.format("$1$:$2$", [
            today.hour.format("%02d"),
            today.min.format("%02d"),
        ]);
    }
}
