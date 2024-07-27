using Toybox.Attention as Attention;

class Utility {
    static function ping(dutyCycle, length) {
        if (Attention has :vibrate) {
            Attention.vibrate([new Attention.VibeProfile(dutyCycle, length)]);
        }
    }
}
