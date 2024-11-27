local composer = require("composer")
local widget = require("widget")
local physics = require("physics")
local scene = composer.newScene()

-- Física
physics.start()
physics.setGravity(0, 9.8)

-- Caixas (criar e soltar)
local function createFallingBoxes()
    local boxData = { "Animal", "Planta", "Fungo", "Protoctista", "Monera"}
    local colors = {
        {0.2, 0.6, 1},
        {0.3, 0.8, 0.4},
        {0.2, 0.6, 1},
        {0.3, 0.8, 0.4},
        {0.2, 0.6, 1},
    }

    local startY = 100
    local delay = 500

    local ground = display.newRect(display.contentCenterX, display.contentHeight - 150, display.contentWidth, 10)
    ground:setFillColor(0, 0, 0, 0)
    physics.addBody(ground, "static", { bounce = 0.2 })
    scene.view:insert(ground)

    for i = 1, #boxData do
        timer.performWithDelay(delay * i, function()
        local box = display.newRoundedRect(display.contentCenterX, startY, 200, 50, 12)
        box:setFillColor(unpack(colors[i]))
        box.strokeWidth = 2
        box:setStrokeColor(0)

        local boxText = display.newText({
            text = boxData[i],
            x = box.x,
            y = box.y,
            font = "Montserrat-VariableFont_wght.ttf-Bold",
            fontSize = 25,
        })
        boxText:setFillColor(1)

        local boxGroup = display.newGroup()
        boxGroup:insert(box)
        boxGroup:insert(boxText)

        box.enterFrame = function()
            boxText.x = box.x
            boxText.y = box.y
        end
        Runtime:addEventListener("enterFrame", box)
        
        -- Ativar
        physics.addBody(box, "dynamic", { density = 1, friction = 0.5, bounce = 0.2})
        box.angularDamping = 3

        -- Add ao grupo da cena
        scene.view:insert(boxGroup)
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
        text = "A classificação dos seres vivos em cinco reinos foi proposta em 1969 pelo biólogo norte-americano Robert Whittaker. Essa divisão é um tipo de organização que agrupa os seres vivos de acordo com semelhanças entre suas características estruturais, anatômicas e genéticas.\n\nToque no botão amarelo para empilhar as caixas com os nomes dos reinos biológicos.",
        x = display.contentCenterX,
        y = 270,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    explanation:setFillColor(1)

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

background:addEventListener("tap", createFallingBoxes)

end

scene:addEventListener("create", scene)

return scene