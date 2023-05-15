push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'Pipepair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_WIDTH = 512
GAME_HEIGHT = 288

local background = love.graphics.newImage('assets/sprites/background.png')
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_SCROLL = 0
local BACKGROUND_LOOPING_POINT = 413
ground = love.graphics.newImage('assets/sprites/ground.png')
GROUND_SCROLL = 0
GROUND_SCROLL_SPEED = 60

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy bird')
    
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --sounds
    sounds = {
        ['jump'] = love.audio.newSource('audio/jump.wav', 'static'),
        ['hurt'] = love.audio.newSource('audio/hurt.wav', 'static'),
        ['explosion'] = love.audio.newSource('audio/explosion.wav', 'static'),
        ['score'] = love.audio.newSource('audio/score.wav', 'static'),

        ['music'] = love.audio.newSource('audio/marios_way.mp3', 'static')
    }
    
    sounds['music']:setLooping(true)
    sounds['music']:play()

    gStateMachine = StateMachine {
        ['title'] = function() return TitleSceenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end,
    } 
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    BACKGROUND_SCROLL = (BACKGROUND_SCROLL + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOPING_POINT
    GROUND_SCROLL = (GROUND_SCROLL + GROUND_SCROLL_SPEED * dt)
            % GAME_WIDTH

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()

    love.graphics.draw(background, -BACKGROUND_SCROLL, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -GROUND_SCROLL, GAME_HEIGHT-16)
    
    push:finish()
end