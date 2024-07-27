using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class GarmodoroView extends Ui.View {
    function onUpdate(dc) {
        dc.clear();

        if (isPomodoroTimerStarted) {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            drawMinutes(dc);
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
            drawCaption(dc);
        } else {
            dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 4, Gfx.FONT_LARGE, "Ready", Gfx.TEXT_JUSTIFY_CENTER);
        }

        if (!isBreakTimerStarted) {
            dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_MEDIUM, "Pomodoro #" + pomodoroNumber, Gfx.TEXT_JUSTIFY_CENTER);
        }

        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4, Gfx.FONT_NUMBER_MILD, getTime(), Gfx.TEXT_JUSTIFY_CENTER);
    }

    hidden function drawMinutes(dc) {
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4 - 30, Gfx.FONT_NUMBER_THAI_HOT, minutes.format("%02d"), Gfx.TEXT_JUSTIFY_CENTER);
    }

    hidden function drawCaption(dc) {
        dc.drawText(dc.getWidth() / 2, 3 * dc.getHeight() / 4 - 60, Gfx.FONT_TINY, "Pomodoro Timer", Gfx.TEXT_JUSTIFY_CENTER);
    }

    function onHide() {}

    function getTime() {
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        return Lang.format("$1$:$2$", [
            today.hour.format("%02d"),
            today.min.format("%02d"),
        ]);
    }
}
