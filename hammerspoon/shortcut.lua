function systemKey(key)
  hs.eventtap.event.newSystemKeyEvent(key, true):post()
  hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

function openTerminal()
  -- os.execute('open -nF /Applications/Terminal.app')
  hs.application.launchOrFocus("Terminal")
  hs.eventtap.keyStroke({"cmd"}, "n")
end

function openBrowser()
  -- kitty
  k = hs.application.find("Safari")
  if k == nil then
      hs.application.launchOrFocus("Safari")
  end
  k:selectMenuItem("New Window")
end

-- lock screen by starting screensaver
hs.hotkey.bind({'shift', 'cmd'}, 'l', function() hs.caffeinate.startScreensaver() end)

-- simulate media keys for external keyboard
hs.hotkey.bind({'shift', 'cmd'}, 'pad5', function() systemKey('PLAY') end)
hs.hotkey.bind({'shift', 'cmd'}, 'pad4', function() systemKey('PREVIOUS') end)
hs.hotkey.bind({'shift', 'cmd'}, 'pad6', function() systemKey('NEXT') end)
hs.hotkey.bind({'shift', 'cmd'}, 'pad8', function() systemKey('SOUND_UP') end)
hs.hotkey.bind({'shift', 'cmd'}, 'pad2', function() systemKey('SOUND_DOWN') end)
hs.hotkey.bind({'shift', 'cmd'}, 'pad0', function() systemKey('MUTE') end)

-- ⌘ + ⏎ Opens New Terminal
hs.hotkey.bind({"cmd"}, "return", openTerminal)

-- ⌘ + ⇧ + ⏎ Opens New Browser Window
hs.hotkey.bind({"cmd","shift"}, "return", openBrowser)

-- Hyper+V types contents of clipboard
hs.hotkey.bind(hyper, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- Hyper+` Brings up Hammerspoon console
hs.hotkey.bind(hyper, "`", function() hs.openConsole() end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "M", function() hs.application.launchOrFocus("Activity Monitor") end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "S", function() hs.application.launchOrFocus("Slack") end)

-- Hyper+F makes toggles app zoom
hs.hotkey.bind(hyper, "F", function() hs.window.focusedWindow():toggleZoom() end)

-- Ctrl+Cmd + Escape -- Sleeps the Computer
hs.hotkey.bind({"ctrl", "cmd"}, "escape", function() hs.caffeinate.systemSleep() end)

-- Ctrl+Shift + Escape -- Sleeps the displays
hs.hotkey.bind({"ctrl", "shift"}, "escape", function() os.execute("pmset displaysleepnow") end)

-- Ctrl+Cmd+Alt + P -- Toggle Caps Lock
hs.hotkey.bind({"ctrl", "cmd", "alt"}, "P", function() hs.hid.capslock.toggle() end)
