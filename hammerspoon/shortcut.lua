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

-- Hyper+` Brings up Hammerspoon console
hs.hotkey.bind(hyper, "`", function() hs.openConsole() end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "M", function() hs.application.launchOrFocus("Activity Monitor") end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "S", function() hs.application.launchOrFocus("Slack") end)

-- Hyper+F makes toggles app zoom
hs.hotkey.bind(hyper, "F", function() hs.application.launchOrFocus("Finder") end)

-- Hyper+C opens VS Code
hs.hotkey.bind(hyper, "C", function() hs.application.launchOrFocus("Visual Studio Code") end)

-- Hyper+O opens obsidian
hs.hotkey.bind(hyper, "O", function() hs.application.launchOrFocus("Obsidian") end)

--Hyper+B opens BibDesk
hs.hotkey.bind(hyper, "B", function() hs.application.launchOrFocus("BibDesk") end)

--Hyper+Z opens Zoom
hs.hotkey.bind(hyper, "Z", function() hs.application.launchOrFocus("zoom.us") end)

--Hyper+I opens Music
hs.hotkey.bind(hyper, "I", function() hs.application.launchOrFocus("Music") end)

-- Ctrl+Cmd + Escape -- Sleeps the Computer
hs.hotkey.bind({"ctrl", "cmd"}, "escape", function() hs.caffeinate.systemSleep() end)

-- Ctrl+Shift + Escape -- Sleeps the displays
hs.hotkey.bind({"ctrl", "shift"}, "escape", function() os.execute("pmset displaysleepnow") end)

-- Ctrl+Cmd+Alt + P -- Toggle Caps Lock -- do again to toggle off
hs.hotkey.bind(hyper, "P", function() hs.hid.capslock.toggle() end)