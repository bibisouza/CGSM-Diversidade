local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Variável global para estado do som
local isSoundOn = true

-- Função para alternar o estado do som
local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Função para avançar para a próxima página
local function goToNextPage()
    composer.gotoScene("page3") -- Crie a próxima página separadamente
end

-- Função para voltar à página anterior
local function goToPreviousPage()
    composer.gotoScene("page1") -- Retorna à página anterior
end



-- Função para exibir imagem correspondente ao botão
local function showImage(imagePath)
    local imageGroup = display.newGroup()

    -- Exibir imagem em tela cheia
    local fullScreenImage = display.newImageRect(imageGroup, imagePath, display.contentWidth, display.contentHeight)
    fullScreenImage.x = display.contentCenterX
    fullScreenImage.y = display.contentCenterY

    -- Função para remover a imagem ao clicar
    local function removeImage()
        display.remove(imageGroup)
        imageGroup = nil
    end

    -- Adicionar evento de toque para fechar a imagem
    fullScreenImage:addEventListener("tap", removeImage)
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da página
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.05, 0.2, 0.05) -- Fundo verde escuro

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
        text = "A identificação e a classificação dos seres vivos exigem regras, normas e um método particular de trabalho. Desde Aristóteles até Lineu, vários sistemas de classificação foram propostos.\n\nToque em cada botão abaixo para visualizar exemplos.",
        x = display.contentCenterX,
        y = 300,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    instruction:setFillColor(1)

    -- Função para criar botões
    local function createButton(x, y, label, imagePath)
        local button = widget.newButton({
            label = label,
            font = "Montserrat-VariableFont_wght.ttf",
            fontSize = 18,
            shape = "roundedRect",
            width = 200,
            height = 60,
            fillColor = { default = {0.1, 0.6, 0.9}, over = {0.2, 0.7, 1} },
            labelColor = { default = {1}, over = {0} },
            onRelease = function()
                showImage(imagePath)
            end
        })
        button.x = x
        button.y = y
        sceneGroup:insert(button)
    end

    -- Criar botões
    createButton(display.contentCenterX, 400, "Domínio", "Images.xcassets/ImgPag2/dominio_banner.png")
    createButton(display.contentCenterX, 500, "Reino", "Images.xcassets/ImgPag2/reino_banner.png")
    createButton(display.contentCenterX, 600, "Filo", "Images.xcassets/ImgPag2/filo_banner.png")

    -- Botão toggle de som
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
