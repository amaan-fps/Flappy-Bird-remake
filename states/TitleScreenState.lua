TitleSceenState = Class{__includes = BaseState}

function TitleSceenState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleSceenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fucky Bird', 0, 64, GAME_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, GAME_WIDTH, 'center')
end