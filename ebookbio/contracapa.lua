local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundOn = true
local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Função para voltar pro início
local function goToNextPage()
    composer.gotoScene("capa")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("page5")
end

-- Criação da cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo Cor
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.07, 0.2, 0.07)

    -- Img folhas
    local leaf1 = display.newImageRect(sceneGroup, "Images/ImgCapa/leaf1.png", display.contentWidth, display.contentCenterX)
    leaf1.x, leaf1.y = 385, 150
    

    local leaf2 = display.newImageRect(sceneGroup, "Images/ImgCapa/leaf2.png", display.contentWidth, display.contentCenterX)
    leaf2.x, leaf2.y = 385, 830

    -- Título
    local title = display.newText({
        text = "Diversidade da Vida",
        x = 350,
        y = 420,
        font = "Montserrat-VariableFont_wght-Bold",
        fontSize = 67.72,
        align = "left",
    })
    title:setFillColor(1) 
    sceneGroup:insert(title)

    -- Subtítulo
    local subtitle = display.newText({
        text = "Classificação biológica\nCategorias taxonômicas\nRegras de nomenclatura",
        x = 200,
        y = 535,
        font = "Montserrat-VariableFont_wght",
        fontSize = 24,
        align = "left",
    })
    subtitle:setFillColor(1)
    sceneGroup:insert(subtitle)

    -- Fundo Autoria
    local authorBackground = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight - 145, display.contentWidth * 0.55, 155)
    authorBackground:setFillColor(0.07, 0.2, 0.07)
    sceneGroup:insert(authorBackground)

    -- Autoria
    local author = display.newText({
        text = "Autora: Beatriz Silva Souza Bezerra\nOrientador: Prof. Ewerton Mendonça\nDisciplina: Computação Gráfica e \nSistemas Multimídia\n2024.2",
        x = display.contentCenterX,
        y = 880,
        font = "Montserrat-VariableFont_wght",
        fontSize = 18,
        align = "left",
    })
    author:setFillColor(1, 0.6, 0)
    sceneGroup:insert(author)    

    -- Botão toggle de som
    local soundToggle = widget.newButton({
        label = "Som on/off",
        font = "Montserrat-VariableFont_wght",
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

    -- Botão "Início"
    local nextButton = widget.newButton({
        label = "Início",
        font = "Montserrat-VariableFont_wght",
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