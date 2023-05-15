Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage('assets/sprites/yellowbird-upflap.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = GAME_WIDTH / 2 - (self.width / 2)
    self.y = GAME_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:collision(pipe)
    if self.x < PIPE_WIDTH + (pipe.x - 2) and (pipe.x + 2) < (self.x + self.width) then
        if pipe.orientation == "upper" and self.y < (pipe.y - 2) then
            return true
        elseif pipe.orientation == "lower" and (self.y + self.height) > (pipe.y + 2) then
            return true
        end
    end

    return false
end

local temp = 0
function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    
    if love.keyboard.wasPressed('space') then
       self.dy = -5
       sounds['jump']:play()
    end

    --if not (temp == 0) then
      --  self.y = self.y + temp
        --self.dy = temp
        --temp = 0
    --else
        self.y = self.y + self.dy
    --end
end

--function love.mousepressed(x, y, button, istouch)
  --  if button == 1 then
    --    temp = -5
        --sounds['jump']:play()
    --end
--end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
