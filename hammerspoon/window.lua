-- half of screen
hs.hotkey.bind('cmd', 'left', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 1}) end)
hs.hotkey.bind('cmd', 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 1}) end)
hs.hotkey.bind('cmd', 'up', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 0.5}) end)
hs.hotkey.bind('cmd', 'down', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 1, 0.5}) end)

-- quarter of screen
hs.hotkey.bind({'shift', 'cmd'}, 'left', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'cmd'}, 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0.5, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'cmd'}, 'up', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'cmd'}, 'down', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 0.5, 0.5}) end)

-- full screen
hs.hotkey.bind({'shift','cmd'}, 'f', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 1}) end)

-- center screen
hs.hotkey.bind({'shift','cmd'}, 'c', function() hs.window.focusedWindow():centerOnScreen() end)

-- move between displays
hs.hotkey.bind(hyper, 'right', function()
  local win = hs.window.focusedWindow()
  local next = win:screen():toEast()
  if next then
    win:moveToScreen(next, true)
  end
end)
hs.hotkey.bind(hyper, 'left', function()
  local win = hs.window.focusedWindow()
  local next = win:screen():toWest()
  if next then
    win:moveToScreen(next, true)
  end
end)

-- grid gui
hs.grid.setMargins({w = 0, h = 0})
hs.hotkey.bind(hyper, 'g', hs.grid.show)

-- auto layout
hs.hotkey.bind(hyper, 'l', function() autoLayout() end)
