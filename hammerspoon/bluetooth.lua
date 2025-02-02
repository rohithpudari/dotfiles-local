-- script adapted from https://gist.github.com/ysimonson/fea48ee8a68ed2cbac12473e87134f58 

require "string"

function checkBluetoothResult(rc, stderr, stderr)
    if rc ~= 0 then
        print(string.format("Unexpected result executing `blueutil`: rc=%d stderr=%s stdout=%s", rc, stderr, stdout))
    end
end

function bluetooth(power)
    local living_speaker = "7c-d9-5c-84-16-d7"
    local t = hs.task.new("/opt/homebrew/bin/blueutil", checkBluetoothResult, {"--disconnect", living_speaker})
    t:start()
end

function f(event)
  if event == hs.caffeinate.watcher.systemWillSleep then
    bluetooth()
  end
end

hs.caffeinate.watcher.new(bluetooth):start()