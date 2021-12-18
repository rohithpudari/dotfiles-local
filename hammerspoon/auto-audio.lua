function chooseAudio()
	devs = hs.audiodevice.allOutputDevices()
	function contains(item)
	    for _, value in pairs(devs) do
		if value:name() == item then
		    return true
		end
	    end
	    return false
	end
    
	builtin = hs.audiodevice.findOutputByName("Built-in Output")
	source = builtin:currentOutputDataSource():name()
    
	if source == "Headphones" then
	    builtin:setDefaultOutputDevice()
	    return
	end
    
	outOrder = {"WH-1000XM4", "Rohith bedroom speaker", "Rohith's AirPods", "Rohith's Powerbeats Pro", "MacBook Pro Speakers"}
    
	for i = 1, #outOrder do
	    if contains(outOrder[i]) then
		d = hs.audiodevice.findOutputByName(outOrder[i])
		d:setDefaultOutputDevice()
		return
	    end
	end
    
	builtin:setMuted(true)
	builtin:setDefaultOutputDevice()
    end
    
    function audioCallback(msg)
	if msg == "dev#" then
	    print("Choosing Audio")
	    chooseAudio()
	end
    end
    
    -- hs.audiodevice.watcher.setCallback(audioCallback)
    -- hs.audiodevice.watcher.start()
    hs.hotkey.bind(hyper, "'", chooseAudio)