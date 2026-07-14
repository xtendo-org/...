local fcitx = require("fcitx")

fcitx.log("ESC-to-keyboard-us: Script loaded!")

function handleEvent(sym, state, release)
    if release then
        return
    end

    if sym == 65307 then
        fcitx.setCurrentInputMethod("keyboard-us")
    end
end

fcitx.watchEvent(fcitx.EventType.KeyEvent, "handleEvent")
