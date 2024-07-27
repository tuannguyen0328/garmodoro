using Toybox.System as Sys;
using Toybox.Background as Bg;

(:background)
class GarmodoroBackground extends Sys.ServiceDelegate {
    function initialize() {
        ServiceDelegate.initialize();
    }

    function onReceive(message) {
        if (message instanceof Lang.String) {
            if (message == "TIMER_COMPLETE") {
                // Handle timer completion logic here
                Sys.println("Pomodoro timer completed in background.");
                // Example: send notification or log the event
            }
        }
    }

    function onTemporalEvent() {
        // Handle timing logic here
        Sys.println("Background service triggered by temporal event.");
    }

    function onStop() {
        // Handle cleanup when the background service stops
    }
}
