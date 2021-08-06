----------------------------------------------------------------------
-- Creates a new layer that looks like a glass floor flattening the
-- selected layers in the timeline.
----------------------------------------------------------------------

do
  local spr = app.activeSprite
  if not spr then return app.alert "There is no active sprite" end

  local function activeFrameNumber()
    app.alert("In function")
    local f = app.activeFrame
    if f == nil then
      return 1
    else
      return f.frameNumber
    end
  end

  app.transaction(
    function()
        local spr = app.site.sprite
        local selection = spr.selection
        local bounds = selection.bounds
        if bounds.width <= 0 and bounds.height <= 0 then
            app.alert("No selection.")
            return
        end
        copyLayer = app.activeLayer
        ix = app.activeLayer.stackIndex
        frameIx = activeFrameNumber()
        toCopy = app.activeImage
        app.alert(copyLayer.name .. ": " .. ix)
        
        local newLayer = spr:newLayer()
        newLayer.stackIndex = ix + 1
        targetCel = spr:newCel(newLayer, frameIx)
        targetImage = targetCel.image
        for x = bounds.x, bounds.x+bounds.width-1 do
            for y = bounds.y, bounds.y + bounds.height-1 do
                local pixelInfo = toCopy:getPixel(x, y)
                targetImage:drawPixel(x, y, pixelInfo)
            end
        end

        app.alert("Done")
    end)
end