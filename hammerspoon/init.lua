---@diagnostic disable: undefined-global
-- luacheck: globals hs

-- =========================
-- Core Modifier Definitions
-- =========================
local mod = { "ctrl", "cmd" }
local hyper = { "ctrl", "alt", "cmd" }

-- =========================
-- Config Options
-- =========================
local config = {
	monitors = {
		macbook = "Built-in Retina Display",
		right = "KB272HL",
		main = "DELL SE2722H",
		home = "HP Z24n G3",
		home2 = "BenQ GW2785TC",
	},
	ideApps = { "Code", "Kitty" },
}

-- =========================
-- Hammerspoon Global Options
-- =========================
hs.window.animationDuration = 0

-- =========================
-- Auto Reload On Config Change
-- =========================
local function reload(files)
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			hs.notify.new({ title = "Reloading", informativeText = "Reloading Hammerspoon config" }):send()
			hs.reload()
			return
		end
	end
end

local _reloadWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload):start()

-- =========================
-- Menubar Utilities
-- =========================
local utilMenu = hs.menubar.new()

local icon = [[
1 . . . . . . . . . . . 3
. # # . . . . . . . # # .
. # # # # . . . # # # # .
. . # # # # 2 # # # # . .
. . # # # # # # # # # . .
. . . # # # # # # # . . .
. . . 8 # # # # # 4 . . .
. . . # # # # # # # . . .
. . # # # # # # # # # . .
. . # # # # 6 # # # # . .
. # # # # . . . # # # # .
. # # . . . . . . . # # .
7 . . . . . . . . . . . 5
]]

utilMenu:setIcon("ASCII:" .. icon)

local menu

local function reloadMenu()
	utilMenu:setMenu(menu)
end

menu = {
	{
		title = "Mono Audio",
		checked = false,
		fn = function(_, menuItem)
			local script = [[
        tell application "System Preferences"
          reveal anchor "Hearing" of pane id "com.apple.preference.universalaccess"
        end tell

        tell application "System Events"
          tell application process "System Preferences"
            set frontmost to true
            tell group 1 of window "Accessibility"
              activate
              repeat until checkbox "Play stereo audio as mono" exists
                delay 0.05
              end repeat
              set monoStereoCheckbox to checkbox "Play stereo audio as mono"
              tell monoStereoCheckbox
                if (%s its value as boolean) then click monoStereoCheckbox
              end tell
            end tell
          end tell
        end tell

        tell application "System Preferences" to quit
      ]]

			local toggle = ""
			if not menuItem.checked then
				toggle = "not"
			end
			script = string.format(script, toggle)
			hs.osascript.applescript(script)

			menuItem.checked = not menuItem.checked
			reloadMenu()
		end,
	},
	{
		title = "Caffeinate",
		checked = false,
		fn = function(_, menuItem)
			local enabled = hs.caffeinate.toggle("displayIdle")
			if enabled then
				hs.notify.new({ title = "Caffeinate", informativeText = "Caffeinate on" }):send()
			else
				hs.notify.new({ title = "Caffeinate", informativeText = "Caffeinate off" }):send()
			end

			menuItem.checked = enabled
			reloadMenu()
		end,
	},
	{
		title = "-", -- separator
	},
}

reloadMenu()

-- =========================
-- Shortcuts And App Launchers
-- =========================
local function systemKey(key)
	hs.eventtap.event.newSystemKeyEvent(key, true):post()
	hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local function openPrivateBrowser()
	local app = hs.application.find("Firefox")
	if app == nil then
		hs.application.launchOrFocus("Firefox")
		app = hs.application.find("Firefox")
	end
	hs.application.launchOrFocus("Firefox")
	if app then
		app:selectMenuItem("New Private Window")
	end
end

-- Open or focus Safari and reuse an existing tab for the given URL when possible.
local function openOrFocusSafari(url)
	local safari = hs.application.find("Safari")
	if safari then
		safari:activate()
	else
		hs.application.launchOrFocus("Safari")
	end

	hs.timer.doAfter(0.3, function()
		hs.osascript.applescript([[
            tell application "Safari"
                activate

                set targetURL to "]] .. url .. [["
                set foundTab to false

                repeat with w in windows
                    repeat with t in tabs of w
                        if (URL of t contains targetURL) then
                            set current tab of w to t
                            set index of w to 1
                            set foundTab to true
                            exit repeat
                        end if
                    end repeat
                    if foundTab then exit repeat
                end repeat

                if foundTab is false then
                    if (count of windows) is 0 then
                        make new document
                    end if

                    tell front window
                        make new tab with properties {URL:targetURL}
                        set current tab to last tab
                    end tell
                end if
            end tell
        ]])
	end)
end

-- Hyper+Q: Lock the screen
hs.hotkey.bind(hyper, "q", function()
	hs.caffeinate.lockScreen()
end)

-- Hyper media controls for external keyboards
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

-- Hyper+T: Open Kitty
hs.hotkey.bind(hyper, "t", function()
	hs.application.launchOrFocus("Kitty")
end)

-- Hyper+Space: Open Firefox
hs.hotkey.bind(hyper, "space", function()
	hs.application.launchOrFocus("Firefox")
end)

-- Hyper+Return: Open Firefox private window
hs.hotkey.bind(hyper, "return", openPrivateBrowser)

-- Hyper+`: Open Hammerspoon console
hs.hotkey.bind(hyper, "`", function()
	hs.openConsole()
end)

-- App launcher shortcuts
hs.hotkey.bind(hyper, "m", function()
	hs.application.launchOrFocus("Mail")
end)

hs.hotkey.bind(hyper, "a", function()
	hs.application.launchOrFocus("Activity Monitor")
end)

hs.hotkey.bind(hyper, "s", function()
	hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind(hyper, "f", function()
	hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind(hyper, "v", function()
	hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind(hyper, "o", function()
	hs.application.launchOrFocus("Obsidian")
end)

hs.hotkey.bind(hyper, "b", function()
	hs.application.launchOrFocus("Zotero")
end)

hs.hotkey.bind(hyper, "z", function()
	hs.application.launchOrFocus("zoom.us")
end)

hs.hotkey.bind(hyper, "p", function()
	hs.application.launchOrFocus("Passwords")
end)

-- Quick AI site shortcuts in Safari
hs.hotkey.bind({ "cmd", "alt" }, "c", function()
	openOrFocusSafari("https://chatgpt.com")
end)

hs.hotkey.bind({ "cmd", "alt" }, "p", function()
	openOrFocusSafari("https://perplexity.ai")
end)

hs.hotkey.bind({ "cmd", "alt" }, "g", function()
	openOrFocusSafari("https://gemini.google.com/app")
end)

-- Hyper+Escape: Sleep machine
hs.hotkey.bind(hyper, "escape", function()
	hs.caffeinate.systemSleep()
end)

-- Mod+P: Start Pomodoro shortcut
hs.hotkey.bind(mod, "p", function()
	hs.shortcuts.run("Start Pomodoro")
end)

-- =========================
-- Bluetooth Automation
-- =========================

-- Define the target monitor used to trigger Bluetooth power-on.
local targetMonitor = config.monitors.home
local monitorWasConnected = false

local function checkBluetoothResult(rc, stdout, stderr)
	if rc ~= 0 then
		print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
	end
end

local function bluetooth(power)
	print("Setting bluetooth to " .. power)
	local task = hs.task.new("/opt/homebrew/bin/blueutil", checkBluetoothResult, { "--power", power })
	task:start()
end

-- Turn Bluetooth off right before sleep.
local function sleepCallback(event)
	if event == hs.caffeinate.watcher.systemWillSleep then
		bluetooth("off")
	end
end

local sleepWatcher = hs.caffeinate.watcher.new(sleepCallback)
sleepWatcher:start()

local function checkTargetMonitorPresent()
	local screens = hs.screen.allScreens()
	for _, screen in ipairs(screens) do
		if screen:name() == targetMonitor then
			return true
		end
	end
	return false
end

-- Initialize monitor state on startup/reload.
monitorWasConnected = checkTargetMonitorPresent()

-- Turn Bluetooth on only when the target monitor transitions to connected.
local function screenCallback()
	local monitorIsConnected = checkTargetMonitorPresent()

	if monitorIsConnected and not monitorWasConnected then
		print(targetMonitor .. " connected. Turning Bluetooth on.")
		bluetooth("on")
	end

	monitorWasConnected = monitorIsConnected
end

local screenWatcher = hs.screen.watcher.new(screenCallback)
screenWatcher:start()
