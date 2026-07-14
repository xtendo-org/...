-- esc_to_default.lua
-- fcitx5-lua script: Switch to default IM when Esc is pressed,
-- but still pass Esc through to the application.

-- Called when the Lua addon is initialized
function initialize()
    logInfo("ESC-to-default Lua addon initialized.")
end

-- Called for each key event.
-- Return true if you *consume* (capture) the key (i.e., don't pass it on),
-- or false if you do *not* consume it (i.e., you let it pass through).
function filterKeyEvent(inputContext, keyval, keycode, state, type, isRelease)
    -- Only act on key *press*, not release:
    if not isRelease then
        -- Check if this key is the Escape key:
        if keyval == FcitxKey_Escape then
            -- Switch to your default IM's unique name:
            inputContext:setIM("keyboard-us")
            -- Return false, meaning "do not consume" => pass Esc to the app
            return false
        end
    end

    -- For all other keys (or key releases), do not change anything
    -- and do NOT consume the key (so return false).
    return false
end
