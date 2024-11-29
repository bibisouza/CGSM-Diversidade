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

-- Exibir imagem
local function showImage(sceneGroup, imagePath)
    local imageGroup = display.newGroup()
    sceneGroup:insert(imageGroup)

    local background = display.newRect(imageGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 0, 0, 0.5)

    background:addEventListener("tap", function()
            display.remove(imageGroup)
            imageGroup = nil
    end)

    -- Carregar a imagem
    local success, bannerImage = pcall(function()
        return display.newImageRect(imageGroup, imagePath, 600, 300)
    end)

    if not success or not bannerImage then
        print("Erro: Imagem não carregada. Verifique o caminho:", imagePath)
        local errorMessage = display.newText({
            parent = imageGroup,
            text = "Erro ao carregar a imagem: " .. imagePath,
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.contentWidth - 40,
            font = native.systemFont,
            fontSize = 20,
            align = "center"
        })
        errorMessage:setFillColor(1, 0, 0)
    else
        bannerImage.x = display.contentCenterX
        bannerImage.y = display.contentCenterY
    end
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

    -- Dados dos botões
    local buttonData = {
        { label = "Domínio", color = {0.1, 0.6, 0.9}, image = "Images/ImgPag2/dominio.png" },
        { label = "Reino", color = {1, 0.6, 0.2}, image = "Images/ImgPag2/reino.png" },
        { label = "Filo", color = {0.3, 0.7, 0.3}, image = "Images/ImgPag2/filo.png" },
        { label = "Classe", color = {0.1, 0.6, 0.9}, image = "Images/ImgPag2/classe.png" },
        { label = "Ordem", color = {1, 0.6, 0.2}, image = "Images/ImgPag2/ordem.png" },
        { label = "Família", color = {0.3, 0.7, 0.3}, image = "Images/ImgPag2/familia.png" },
        { label = "Gênero", color = {0.1, 0.6, 0.9}, image = "Images/ImgPag2/genero.png" },
        { label = "Espécie", color = {1, 0.6, 0.2}, image = "Images/ImgPag2/especie.png" },
    }

    -- Criar botões dinamicamente
    local startX = display.contentCenterX - 120
    local startY = 500
    local spacing = 80


    for i, data in ipairs(buttonData) do
        local button = widget.newButton({
            label = data.label,
            font = "Montserrat-VariableFont_wght.ttf-Bold",
            fontSize = 25,
            shape = "roundedRect",
            width = 200,
            height = 50,
            fillColor = { default = data.color, over = {0.8, 0.8, 0.8} },
            labelColor = { default = {0}, over = {1} },
            onRelease = function()
                print("Tentando carregar a imagem: ", data.image)
                showImage(sceneGroup, data.image)
            end
        })
        button.x = startX + ((i - 1) % 2) * 240
        button.y = startY + math.floor((i - 1) / 2) * spacing
        sceneGroup:insert(button)
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