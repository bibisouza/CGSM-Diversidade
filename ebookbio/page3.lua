local composer = require("composer")
local widget = require("widget")
local physics = require("physics")
local scene = composer.newScene()

-- Física
physics.start()
physics.setGravity(0, 9.8)

-- Base
local function createBase(sceneGroup)
    local base = display.newRect(display.contentCenterX, display.contentHeight - 50, display.contentWidth, 10)
    base:setFillColor(0.8, 0.8, 0.8)
    physics.addBody(base, "static", { bounce = 0.1 })
    sceneGroup:insert(base)
end

-- Caixas (criar e soltar)
local function createFallingBoxes(sceneGroup)
    local boxData = { "Animal", "Planta", "Fungo", "Protoctista", "Monera"}
    local colors = {
        {0.2, 0.6, 1},
        {0.3, 0.8, 0.4},
        {0.2, 0.6, 1},
        {0.3, 0.8, 0.4},
        {0.2, 0.6, 1},
    }

    local positions = {
        display.contentCenterX - 200,
        display.contentCenterX - 100,
        display.contentCenterX,
        display.contentCenterX + 100,
        display.contentCenterX + 200
    }

    for i = 1, #boxData do
        timer.performWithDelay(500 * i, function()
        local box = display.newRoundedRect(positions[i], -50, 120, 60, 12)
        box:setFillColor(unpack(colors[i]))
        box.strokeWidth = 2
        box:setStrokeColor(0)

        local text = display.newText({
            text = boxData[i],
            x = box.x,
            y = box.y,
            font = "Montserrat-VariableFont_wght.ttf-Bold",
            fontSize = 25,
        })
        text:setFillColor(1)

        local group = display.newGroup()
        group:insert(box)
        group:insert(text)

        physics.addBody(box, "dynamic", { density = 0.8, friction = 0.3, bounce = 0.1})
        box.angularDamping = 1.5

        transition.to(box, { time = 1000, y = display.contentHeight - 100, rotation = 0, transition = easing.outBounce })

        -- Add ao grupo da cena
        sceneGroup:insert(group)
    end)
end
end

-- Som 
local isSoundOn = true
local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Próxima página
local function goToNextPage()
    composer.gotoScene("page4")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("page2")
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.05, 0.2, 0.05)

    -- Título
    local title = display.newText({
        parent = sceneGroup,
        text = "Explorando os cinco Reinos",
        x = display.contentCenterX,
        y = 110,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 54,
        align = "center"
    })
    title:setFillColor(1)

    -- Explicação
    local explanation = display.newText({
        parent = sceneGroup,
        text = "A classificação dos seres vivos em cinco reinos foi proposta em 1969 pelo biólogo norte-americano Robert Whittaker. Essa divisão é um tipo de organização que agrupa os seres vivos de acordo com semelhanças entre suas características estruturais, anatômicas e genéticas.\n\nEmpilhE as caixas com os nomes dos reinos biológicos.",
        x = display.contentCenterX,
        y = 270,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    explanation:setFillColor(1)

    -- Base
    createBase(sceneGroup)

    -- Caixas
    createFallingBoxes(sceneGroup)

 -- Botão som
 local soundToggle = widget.newButton({
    label = "Som on/off",
    font = "Montserrat-VariableFont_wght.ttf",
    fontSize = 18,
    shape = "roundedRect",
    width = 150,
    height = 40,
    fillColor = { default = {0.1, 0.5, 0.9}, over = {0.8, 0.8, 0.8} },
    labelColor = { default = {1}, over = {0} },
    onRelease = toggleSound
})
soundToggle.x = display.contentWidth - 90
soundToggle.y = display.contentHeight - 60
sceneGroup:insert(soundToggle)

-- Botão "Avançar"
local nextButton = widget.newButton({
    label = "Avançar",
    font = "Montserrat-VariableFont_wght.ttf",
    fontSize = 18,
    shape = "roundedRect",
    width = 150,
    height = 40,
    fillColor = { default = {0.9, 0.9, 0.9}, over = {0.8, 0.8, 0.8} },
    labelColor = { default = {0}, over = {0.5} },
    onRelease = goToNextPage
})
nextButton.x = display.contentWidth - 90
nextButton.y = display.contentHeight - 120
sceneGroup:insert(nextButton)

-- Botão "Voltar"
local backButton = widget.newButton({
    label = "Voltar",
    font = "Montserrat-VariableFont_wght.ttf",
    fontSize = 18,
    shape = "roundedRect",
    width = 150,
    height = 40,
    fillColor = { default = {0.9, 0.9, 0.9}, over = {0.8, 0.8, 0.8} },
    labelColor = { default = {0}, over = {0.5} },
    onRelease = goToPreviousPage
})
backButton.x = 90
backButton.y = display.contentHeight - 120
sceneGroup:insert(backButton)
end

scene:addEventListener("create", scene)

return scene