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

layoutHome = function()
  local ide = detectIDE()
  local right
  local left
  if ide then
    right = {{ide, nil, RIGHT_HOME_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true}}
    left = {
      {'Safari', nil, MAIN_HOME_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},
      {'Terminal', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true}
    }
  else
    right = {{'ProtonVPN', nil, RIGHT_HOME_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},
            {'Terminal',nil,MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true}}
    left = {{'Safari', nil, MAIN_HOME_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true}}
  end
  local mb = {
    {'Things', nil, MACBOOK_MONITOR, u(0, 0, 1/2, 1), nil, nil, visible=true},
    {'Calendar', nil, MACBOOK_MONITOR, u(1/2, 0, 1/2, 1), nil, nil, visible=true},
    {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=true},
    {'Mail', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false},
    {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil, visible=false}
  }
  return ide, concat(left, right, mb)
end

layoutLaptop = {
  {'Calendar', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Slack', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Safari', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Mail', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Spotify', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Things', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'iTerm2', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil},
  {'Zoom', nil, MACBOOK_MONITOR, u(0, 0, 1, 1), nil, nil}
}

applyLayout = function(name, layout)
  for _, entry in ipairs(layout) do
    local name = entry[1]
    local show = entry['visible']
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
  hs.notify.new({title='Layout', informativeText='Applied layout: ' .. name}):send()
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
  if hasScreen(RIGHT_HOME_MONITOR) and hasScreen(MAIN_HOME_MONITOR) then
    local ide, layout = layoutHome()
    local name = ide or 'Terminal'
    local description = 'Home (' .. name .. ')'
    applyLayout(description, layout)
  elseif #hs.screen.allScreens() == 1 then
    applyLayout('Laptop', layoutLaptop)
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

screenWatcher = hs.screen.watcher.new(function()
  local currScreens = hs.screen.allScreens()
  if screensEq(currScreens, prevScreens) then
    return
  end
  prevScreens = currScreens
  autoLayout()
end):start()
