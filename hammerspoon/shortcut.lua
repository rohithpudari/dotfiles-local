function systemKey(key)
	hs.eventtap.event.newSystemKeyEvent(key, true):post()
	hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

function openPrivateBrowser()
	a = hs.application.find("Firefox")
	if a == nil then
		hs.application.launchOrFocus("Firefox")
	end
	a:selectMenuItem("New Private Window")
end

-- lock screen by starting lock screen
hs.hotkey.bind(hyper, "q", function()
	hs.caffeinate.lockScreen()
end)

-- simulate media keys for external keyboard
hs.hotkey.bind(hyper, "k", function()
	systemKey("PLAY")
end)
hs.hotkey.bind(hyper, "j", function()
	systemKey("PREVIOUS")
end)
hs.hotkey.bind(hyper, "l", function()
	systemKey("NEXT")
end)
hs.hotkey.bind(hyper, "i", function()
	systemKey("SOUND_UP")
end)
hs.hotkey.bind(hyper, ",", function()
	systemKey("SOUND_DOWN")
end)
hs.hotkey.bind(hyper, "0", function()
	systemKey("MUTE")
end)

-- ⌘ + ⏎ Opens New Kitty Terminal
hs.hotkey.bind(hyper, "t", function()
	hs.application.launchOrFocus("Kitty")
end)

-- ⌘ + ⇧ + ⏎ Opens New Browser Window
hs.hotkey.bind(hyper, "space", function()
	hs.application.launchOrFocus("Firefox")
end)

-- ⌘ + ⇧ + ⏎ Opens New private Browser Window
hs.hotkey.bind(hyper, "return", openPrivateBrowser)

-- Hyper+` Brings up Hammerspoon console
hs.hotkey.bind(hyper, "`", function()
	hs.openConsole()
end)

-- Launch or Focus Mail
hs.hotkey.bind(hyper, "m", function()
	hs.application.launchOrFocus("Mail")
end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "a", function()
	hs.application.launchOrFocus("Activity Monitor")
end)

-- Launch or Focus Activity Monitor
hs.hotkey.bind(hyper, "s", function()
	hs.application.launchOrFocus("Slack")
end)

-- Hyper+F makes toggles app zoom
--hs.hotkey.bind(hyper, "f", function() hs.application.launchOrFocus("Finder") end)

-- Hyper+C opens VS Code
hs.hotkey.bind(hyper, "v", function()
	hs.application.launchOrFocus("Visual Studio Code")
end)

-- Hyper+O opens obsidian
hs.hotkey.bind(hyper, "o", function()
	hs.application.launchOrFocus("Obsidian")
end)

--Hyper+B opens zotero
hs.hotkey.bind(hyper, "b", function()
	hs.application.launchOrFocus("Zotero")
end)

--Hyper+Z opens Zoom
hs.hotkey.bind(hyper, "z", function()
	hs.application.launchOrFocus("zoom.us")
end)

--Hyper+p opens Passwords
hs.hotkey.bind(hyper, "p", function()
	hs.application.launchOrFocus("Passwords")
end)

--Hyper+D opens frequently opened apps and does autolayout
hs.hotkey.bind(hyper, "d", function()
	hs.application.launchOrFocus("Mail")
	hs.application.launchOrFocus("Slack")
	hs.application.launchOrFocus("Firefox")
	autoLayout()
end)

--Hyper+D opens OneDrive
-- hs.hotkey.bind(hyper, "1", function() hs.applicatFocus("Music") end)

-- Ctrl+Cmd + Escape -- Sleeps the Computer
hs.hotkey.bind(hyper, "escape", function()
	hs.caffeinate.systemSleep()
end)

-- Ctrl+Cmd+Alt + P -- Toggle Caps Lock -- do again to toggle off
-- hs.hotkey.bind(hyper, "", function()
--	hs.hid.capslock.toggle()
-- end)

-- Mod + L -- run autLayout function
hs.hotkey.bind(mod, "l", function()
	autoLayout()
end)

-- MOd + R -- run rescue
hs.hotkey.bind(mod, "r", function()
	rescue()
end)

-- Mod + P -- toggle shortcut pomodoro
hs.hotkey.bind(mod, "p", function()
	hs.shortcuts.run("Start Pomodoro")
end)
