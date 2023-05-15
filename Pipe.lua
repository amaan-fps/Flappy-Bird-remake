Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('assets/sprites/pipe-green.png')
PIPE_SCROLL = -60

PIPE_HEIGHT = 320
PIPE_WIDTH = PIPE_IMAGE:getWidth()

function Pipe:init(orientation, y)
    self.x = GAME_WIDTH
    self.y = y

    self.orientation = orientation
end

function Pipe:update(dt)
    
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y, 0, 1, self.orientation == 'upper' and -1 or 1)
end