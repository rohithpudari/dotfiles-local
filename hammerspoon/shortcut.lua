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
  k = hs.application.find("Safari")
  hs.application.launchOrFocus("Safari")
  k:selectMenuItem("New Window")
end

function openPrivateBrowser()
  k = hs.application.find("Safari")
  hs.application.open("Safari")
  k:selectMenuItem("New Private Window")
end

-- lock screen by starting lock screen
hs.hotkey.bind(hyper, 'q', function() hs.caffeinate.lockScreen() end)

-- simulate media keys for external keyboard
hs.hotkey.bind(hyper, 'k', function() systemKey('PLAY') end)
hs.hotkey.bind(hyper, 'j', function() systemKey('PREVIOUS') end)
hs.hotkey.bind(hyper, 'l', function() systemKey('NEXT') end)
hs.hotkey.bind(hyper, 'i', function() systemKey('SOUND_UP') end)
hs.hotkey.bind(hyper, ',', function() systemKey('SOUND_DOWN') end)
hs.hotkey.bind(hyper, '0', function() systemKey('MUTE') end)

-- ⌘ + ⏎ Opens New Terminal
hs.hotkey.bind(hyper, "return", openTerminal)

-- ⌘ + ⇧ + ⏎ Opens New Browser Window
hs.hotkey.bind(hyper, "return", openBrowser)

-- ⌘ + ⇧ + ⏎ Opens New private Browser Window
hs.hotkey.bind(hyper, "space", openPrivateBrowser)

-- Hyper+` Brings up Hammerspoon console
hs.hotkey.bind(hyper, "`", function() hs.openConsole() end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "m", function() hs.application.launchOrFocus("Activity Monitor") end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "s", function() hs.application.launchOrFocus("Slack") end)

-- Hyper+F makes toggles app zoom
hs.hotkey.bind(hyper, "f", function() hs.application.launchOrFocus("Finder") end)

-- Hyper+C opens VS Code
hs.hotkey.bind(hyper, "v", function() hs.application.launchOrFocus("Visual Studio Code") end)

-- Hyper+O opens obsidian
hs.hotkey.bind(hyper, "o", function() hs.application.launchOrFocus("Obsidian") end)

--Hyper+B opens BibDesk
hs.hotkey.bind(hyper, "b", function() hs.application.launchOrFocus("BibDesk") end)

--Hyper+Z opens Zoom
hs.hotkey.bind(hyper, "z", function() hs.application.launchOrFocus("zoom.us") end)

-- --Hyper+I opens Music
-- hs.hotkey.bind(hyper, "I", function() hs.application.launchOrFocus("Music") end)

-- Ctrl+Cmd + Escape -- Sleeps the Computer
hs.hotkey.bind(mod, "escape", function() hs.caffeinate.systemSleep() end)

-- Ctrl+Cmd+Alt + P -- Toggle Caps Lock -- do again to toggle off
hs.hotkey.bind(hyper, "P", function() hs.hid.capslock.toggle() end)
