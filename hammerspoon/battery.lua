function battery_percent()
    percent = hs.battery.percentage()
    if percent > 80.0 and hs.battery.isCharging() then
        hs.notify.new({title='Battery-Remove', informativeText='Remove charger, Battery about 80'}):send()
    end
    if percent < 40.0 and not hs.battery.isCharging() then
        hs.notify.new({title='Battery-Charge', informativeText='Connect charger, Battery below 40'}):send()
    end
end

hs.battery.watcher.new(battery_percent):start()