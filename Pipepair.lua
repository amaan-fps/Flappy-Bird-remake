Pipepair = Class{}

local GAP_HEIGHT = 90

function Pipepair:init(y)
    self.x = GAME_WIDTH + 32
    self.y = y

    self.pipes = {
        ['upper'] = Pipe('upper', self.y + PIPE_HEIGHT),
        ['lower'] = Pipe('lower', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    self.remove = false
end

function Pipepair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x + PIPE_SCROLL * dt
        self.pipes['upper'].x = self.x
        self.pipes['lower'].x = self.x
    else
        self.remove = true
    end
end

function Pipepair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end