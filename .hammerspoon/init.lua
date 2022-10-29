-- HANDLE SCROLLING

local deferred = false

overrideMiddleMouseDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) ~= 31 then
        return false
    end

    deferred = true
    return true
end)

overrideMiddleMouseUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) ~= 31 then
        return false
    end

    if (deferred) then
        overrideMiddleMouseDown:stop()
        overrideMiddleMouseUp:stop()
        hs.eventtap.middleClick(e:location(), 10)
        overrideMiddleMouseDown:start()
        overrideMiddleMouseUp:start()
        return true
    end

    return false
end)


local oldmousepos = {}
local beta = -20
dragMiddleToScroll = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) ~= 31 then
        return false
    end

    deferred = false

    oldmousepos = hs.mouse.getAbsolutePosition()

    local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
    local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
    local scroll = hs.eventtap.event.newScrollEvent({dx * beta, dy * beta},{},'pixel')

    -- put the mouse back
    hs.mouse.setAbsolutePosition(oldmousepos)

    return true, {scroll}
end)

overrideMiddleMouseDown:start()
overrideMiddleMouseUp:start()
dragMiddleToScroll:start()

-- Put the foreground window at the center of the screen (for screen capture)
hs.hotkey.bind({'cmd', 'ctrl'}, '1', function (mods, key)
  local window = hs.window.frontmostWindow()
  if window then
    print(window)
    local w = 1920
    local h = 1080
    window:move({w/2, h/2, w, h}, nil, false, 0)
  end
end, nil, nil)
