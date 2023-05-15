CountdownState = Class{__includes = BaseState}

function CountdownState:init()
    self.timer = 0
    self.count = 3
end

function CountdownState:update(dt)
    self.timer = self.timer + dt
    
    if self.timer > 1 then
        self.timer = self.timer % 1
        self.count = self.count - 1
    end

    if self.count == 0 then
        gStateMachine:change('play')
    end
end

function CountdownState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf(tostring(self.count), 0, 64, GAME_WIDTH, "center")
end