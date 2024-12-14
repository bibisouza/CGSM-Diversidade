local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som 
local isSoundOn = true

local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Próxima página
local function goToNextPage()
    composer.gotoScene("page3")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("page1")
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.05, 0.2, 0.05)

    local treeBg = display.newImageRect(sceneGroup, "Images/ImgPag2/arvore.png", 360, 450)
    treeBg.x = 360
    treeBg.y = 700

    -- Título
    local title = display.newText({
        parent = sceneGroup,
        text = "Classificação Biológica",
        x = display.contentCenterX,
        y = 135,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 70,
        align = "center"
    })
    title:setFillColor(1)

    -- Explicação
    local instruction = display.newText({
        parent = sceneGroup,
        text = "A identificação e a classificação dos seres vivos exigem regras, normas e um método particular de trabalho. Desde Aristóteles até Lineu, vários sistemas de classificação foram propostos.\n\nToque em cada botão para ampliar.",
        x = display.contentCenterX,
        y = 300,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    instruction:setFillColor(1)

    -- Toque para ampliar
    local function zoomButton(button)
        transition.to(button, {time = 500, xScale = 1.2, yScale = 1.2, onComplete = function()
            transition.to(button, {time = 500, xScale = 1, yScale = 1})
        end})
    end

    -- Dados das folhas
    local leafData = {
        { label = "Ordem", color = {0.1, 0.6, 0.9}, x = 360, y = 580 },
        { label = "Classe", color = {1, 0.6, 0.2}, x = 180, y = 580},
        { label = "Reino", color = {0.3, 0.7, 0.3}, x = 240, y = 685 },
        { label = "Domínio", color = {0.1, 0.6, 0.9}, x = 360, y = 775 },
        { label = "Filo", color = {1, 0.6, 0.2}, x = 480, y = 685 },
        { label = "Família", color = {0.3, 0.7, 0.3}, x = 540, y = 580 },
        { label = "Espécie", color = {0.1, 0.6, 0.9}, x = 485, y = 485 },
        { label = "Gênero", color = {1, 0.6, 0.2}, x = 245, y = 485 },
    }

    -- Criar caixas
    for _, leaf in ipairs(leafData) do
        local buttonGroup = display.newGroup()
        local buttonBackground = display.newRect(buttonGroup, 0, 0, 150, 50)
        buttonBackground:setFillColor(unpack(leaf.color))
        local buttonText = display.newText({
            parent = buttonGroup,
            text = leaf.label,
            font = "Montserrat-VariableFont_wght.ttf",
            fontSize = 18,
            x = 0,
            y = 0
        })
        buttonText:setFillColor(1)

        buttonGroup.x = leaf.x
        buttonGroup.y = leaf.y

        buttonGroup:addEventListener("tap", function()
            transition.to(buttonGroup, { time = 500, xScale = 1.2, yScale = 1.2, onComplete = function()
                transition.to(buttonGroup, { time = 500, xScale = 1.0, yScale = 1.0 })
            end })
        end)

        sceneGroup:insert(buttonGroup)
    end


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