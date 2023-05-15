PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.bird = Bird()
    self.score = 0

    self.pipepairs = {}
    self.spawn_timer = 0

    self.lasty = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
        self.spawn_timer = self.spawn_timer + dt

        if self.spawn_timer > 2  then
                -- code for modifying y

                local y = math.max(-PIPE_HEIGHT + 10, self.lasty + math.random(-20, 20))
                -- math.min(lasty + math.random(-20, 20), GAME_HEIGHT - 90 - PIPE_HEIGHT))
                
                self.lasty = y

                table.insert(self.pipepairs, Pipepair(y))
                
                self.spawn_timer = 0
        end

        self.bird:update(dt)
        
        if self.bird.y > GAME_HEIGHT + 5 then
            gStateMachine:change('score', {score = self.score})
        end

        for k, pair in pairs(self.pipepairs) do
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    sounds['score']:play()
                    pair.scored = true
                end
            end
            
            pair:update(dt)

            for l, pipe in pairs(pair.pipes) do
                if self.bird:collision(pipe) then
                    gStateMachine:change('score', {
                        score = self.score
                    })
                    sounds['hurt']:play()
                    sounds['explosion']:play()
                end
            end
        end

        for k, pair in pairs(self.pipepairs) do
            if pair.remove then
                table.remove(self.pipepairs, k)
            end
        end
    end

function PlayState:render()
    for i, pair in pairs(self.pipepairs) do
        pair:render()
    end
    
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: '.. tostring(self.score), 8, 8)

    self.bird:render()
end