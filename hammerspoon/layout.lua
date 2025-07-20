local u = hs.geometry.unitrect

local detectIDE = function()
	local ide = nil
	for _, v in ipairs(IDEs) do
		if hs.application.get(v) then
			ide = v
			break
		end
	end
	return ide
end

layoutOffice = function()
	local ide = detectIDE()
	local right
	local left
	if ide then
		right = { { ide, nil, RIGHT_MONITOR, hs.layout.maximized, nil, nil, visible = true } }
		left = {
			{ "Slack", nil, MAIN_MONITOR, hs.layout.left50, nil, nil, visible = true },
			{ "Mail", nil, MAIN_MONITOR, hs.layout.right50, nil, nil, visible = true },
			{ "Firefox", nil, MAIN_MONITOR, hs.layout.maximized, nil, nil, visible = true },
		}
	else
		right = {
			{ "Firefox", nil, RIGHT_MONITOR, hs.layout.maximized, nil, nil, visible = true },
		}
		left = {
			{ "Slack", nil, MAIN_MONITOR, hs.layout.left50, nil, nil, visible = true },
			{ "Mail", nil, MAIN_MONITOR, hs.layout.right50, nil, nil, visible = true },
		}
	end
	local mb = {
		{ "Calendar", nil, MACBOOK_MONITOR, hs.layout.left50, nil, nil, visible = true },
		{ "Zotero", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil, visible = false },
		{ "Safari", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil, visible = true },
	}
	return ide, concat(left, right, mb)
end

layoutHome = function()
	local ide = detectIDE()
	local right
	local left
	if ide then
		left = { { ide, nil, HOME_MONITOR, hs.layout.maximized, nil, nil, visible = true } }
		right = {
			{ "Safari", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "Firefox", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "Zotero", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "zoom.us", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
		}
	else
		right = {
			{ "Zotero", nil, HOME_MONITOR, hs.layout.left50, nil, nil, visible = true },
			{ "Finder", nil, HOME_MONITOR, hs.layout.right50, nil, nil, visible = true },
		}
		left = {
			{ "Safari", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "Firefox", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "zoom.us", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
		}
	end
	local mb = {
		{ "Mail", nil, MACBOOK_MONITOR, hs.layout.left50, nil, nil, visible = true },
		{ "Slack", nil, MACBOOK_MONITOR, hs.layout.right50, nil, nil, visible = true },
		{ "Finder", nil, MACBOOK_MONITOR, hs.layout.left50, nil, nil, visible = true },
	}
	return concat(left, right, mb)
end

layoutHome2 = function()
	local ide = detectIDE()
	local right
	local left
	if ide then
		left = { { ide, nil, HOME_MONITOR, hs.layout.maximized, nil, nil, visible = true } }
		right = {
			{ "Firefox", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "Safari", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
			{ "Mail", nil, HOME_MONITOR2, hs.layout.left50, nil, nil, visible = true },
			{ "Slack", nil, HOME_MONITOR2, hs.layout.right50, nil, nil, visible = true },
			{ "zoom.us", nil, HOME_MONITOR2, hs.layout.maximized, nil, nil, visible = true },
		}
	else
		right = {
			{ "Mail", nil, HOME_MONITOR, hs.layout.left50, nil, nil, visible = true },
			{ "Slack", nil, HOME_MONITOR, hs.layout.right50, nil, nil, visible = true },
			{ "Zotero", nil, HOME_MONITOR, hs.layout.maximized, nil, nil, visible = true },
		}
		left = {
			{ "Firefox", nil, HOME_MONITOR2, u(0, 0, 1, 1), nil, nil, visible = true },
			{ "zoom.us", nil, HOME_MONITOR2, u(0, 0, 1, 1), nil, nil, visible = true },
			{ "Safari", nil, HOME_MONITOR2, u(0, 0, 1, 1), nil, nil, visible = true },
		}
	end
	return concat(left, right)
end

layoutLaptop = {
	{ "Calendar", nil, MACBOOK_MONITOR, hs.layout.left50, nil, nil },
	{ "Firefox", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil },
	{ "Kitty", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil },
	{ "Slack", nil, MACBOOK_MONITOR, hs.layout.right50, nil, nil },
	{ "Safari", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil },
	{ "Mail", nil, MACBOOK_MONITOR, hs.layout.left50, nil, nil },
	{ "zoom.us", nil, MACBOOK_MONITOR, hs.layout.maximized, nil, nil },
}

applyLayout = function(name, layout)
	for _, entry in ipairs(layout) do
		local name = entry[1]
		local show = entry["visible"]
		if show ~= nil then
			local app = hs.application.get(name)
			if app then
				if show then
					app:unhide()
				else
					app:hide()
				end
			end
		end
	end
	hs.layout.apply(layout)
	hs.notify.new({ title = "Layout", informativeText = "Applied layout: " .. name }):send()
end

rescue = function()
	local screen = hs.screen.mainScreen()
	local screenFrame = screen:fullFrame()
	local wins = hs.window.visibleWindows()
	for _, win in ipairs(wins) do
		local frame = win:frame()
		if not frame:inside(screenFrame) then
			win:moveToScreen(screen, true, true)
		end
	end
end

hasScreen = function(name)
	for _, screen in ipairs(hs.screen.allScreens()) do
		if screen:name() == name then
			return true
		end
	end
	return false
end

autoLayout = function()
	if hasScreen(RIGHT_MONITOR) and hasScreen(MAIN_MONITOR) then
		local ide, layout = layoutOffice()
		local name = ide or "Kitty"
		local description = "Office (" .. name .. ")"
		applyLayout(description, layout)
	elseif hasScreen(HOME_MONITOR) and hasScreen(HOME_MONITOR2) then
		if hasScreen(MACBOOK_MONITOR) then
			local layout = layoutHome()
			local name = "all screens"
			local description = "Home (" .. name .. ")"
			applyLayout(description, layout)
		else
			local layout = layoutHome2()
			local name = "two monitors"
			local description = "HomeScreen (" .. name .. ")"
			applyLayout(description, layout)
		end
	elseif hs.screen.allScreens() == 1 then
		applyLayout("Laptop", layoutLaptop)
	end
end

local prevScreens = hs.screen.allScreens()

screensEq = function(a, b)
	if #a ~= #b then
		return false
	end
	for i, x in ipairs(a) do
		if b[i] ~= x then
			return false
		end
	end
	return true
end

screenWatcher = hs.screen.watcher
	.new(function()
		local currScreens = hs.screen.allScreens()
		if screensEq(currScreens, prevScreens) then
			return
		end
		prevScreens = currScreens
		autoLayout()
	end)
	:start()
