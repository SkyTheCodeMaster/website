-- This code follows the same licence as ComputerCraft: Tweaked, but is slightly modified as to make it `require`able.
local paintutils = {}

local function toBlit(color)
  local idx = select(2, math.frexp(color))
  return ("0123456789abcdef"):sub(idx, idx)
end

local function drawPixelInternal(nX,nY,nsCol,tOutput)
  tOutput = tOutput or term.current()
  nsCol = nsCol or tOutput.getBackgroundColour()
  if type(nsCol) == "number" then nsCol = toBlit(nsCol) end
  local fg = toBlit(tOutput.getTextColour())
  tOutput.setCursorPos(nX,nY)
  tOutput.blit(" ",fg,nsCol)
end

local tColourLookup = {}
for n = 1, 16 do
    tColourLookup[string.byte("0123456789abcdef", n, n)] = 2 ^ (n - 1)
end

-- Sorts pairs of startX/startY/endX/endY such that the start is always the min
local function sortCoords(startX, startY, endX, endY)
    local minX, maxX, minY, maxY

    if startX <= endX then
        minX, maxX = startX, endX
    else
        minX, maxX = endX, startX
    end

    if startY <= endY then
        minY, maxY = startY, endY
    else
        minY, maxY = endY, startY
    end

    return minX, maxX, minY, maxY
end

function paintutils.drawPixel(xPos, yPos, colour, tOutput)
    tOutput = tOutput or term.current()

    if colour then
        tOutput.setBackgroundColor(colour)
    end
    return drawPixelInternal(xPos, yPos, colour, tOutput)
end

function paintutils.drawLine(startX, startY, endX, endY, colour, tOutput)
    tOutput = tOutput or term.current()

    startX = math.floor(startX)
    startY = math.floor(startY)
    endX = math.floor(endX)
    endY = math.floor(endY)

    if colour then
        tOutput.setBackgroundColor(colour)
    end
    if startX == endX and startY == endY then
        drawPixelInternal(startX, startY, colour, tOutput)
        return
    end

    local minX, maxX, minY, maxY = sortCoords(startX, startY, endX, endY)

    -- do to: clip to screen rectangle?

    local xDiff = maxX - minX
    local yDiff = maxY - minY

    if xDiff > math.abs(yDiff) then
        local y = minY
        local dy = yDiff / xDiff
        for x = minX, maxX do
            drawPixelInternal(x, math.floor(y + 0.5), colour, tOutput)
            y = y + dy
        end
    else
        local x = minX
        local dx = xDiff / yDiff
        if maxY >= minY then
            for y = minY, maxY do
                drawPixelInternal(math.floor(x + 0.5), y, colour, tOutput)
                x = x + dx
            end
        else
            for y = minY, maxY, -1 do
                drawPixelInternal(math.floor(x + 0.5), y, colour, tOutput)
                x = x - dx
            end
        end
    end
end

function paintutils.drawBox(startX, startY, endX, endY, nColour, tOutput)
    tOutput = tOutput or term.current()

    startX = math.floor(startX)
    startY = math.floor(startY)
    endX = math.floor(endX)
    endY = math.floor(endY)

    if nColour then
        tOutput.setBackgroundColor(nColour) -- Maintain legacy behaviour
    else
        nColour = tOutput.getBackgroundColour()
    end
    local colourHex = toBlit(nColour)

    if startX == endX and startY == endY then
        drawPixelInternal(startX, startY, nColour, tOutput)
        return
    end

    local minX, maxX, minY, maxY = sortCoords(startX, startY, endX, endY)
    local width = maxX - minX + 1

    for y = minY, maxY do
        if y == minY or y == maxY then
            tOutput.setCursorPos(minX, y)
            tOutput.blit((" "):rep(width), colourHex:rep(width), colourHex:rep(width))
        else
            tOutput.setCursorPos(minX, y)
            tOutput.blit(" ", colourHex, colourHex)
            tOutput.setCursorPos(maxX, y)
            tOutput.blit(" ", colourHex, colourHex)
        end
    end
end

function paintutils.drawFilledBox(startX, startY, endX, endY, nColour, tOutput)
    tOutput = tOutput or term.current()

    startX = math.floor(startX)
    startY = math.floor(startY)
    endX = math.floor(endX)
    endY = math.floor(endY)

    if nColour then
        tOutput.setBackgroundColor(nColour) -- Maintain legacy behaviour
    else
        nColour = tOutput.getBackgroundColour()
    end
    local colourHex = toBlit(nColour)

    if startX == endX and startY == endY then
        drawPixelInternal(startX, startY, nColour, tOutput)
        return
    end

    local minX, maxX, minY, maxY = sortCoords(startX, startY, endX, endY)
    local width = maxX - minX + 1

    for y = minY, maxY do
        tOutput.setCursorPos(minX, y)
        tOutput.blit((" "):rep(width), colourHex:rep(width), colourHex:rep(width))
    end
end

return paintutils