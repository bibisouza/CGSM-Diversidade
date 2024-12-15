local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som 
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/audpag5.mp3")
local currentAudioPosition = 0

local function playAudio()
    audioChannel = audio.play(audioFile, { loops = -1, channel = 1, startTime = currentAudioPosition })
    isSoundPlaying = true
end

local function pauseAudio()
    if audioChannel then
        currentAudioPosition = audio.getDuration(audioFile) * (audio.getVolume(audioChannel) / 1000 )
        audio.stop(audioChannel)
        isSoundPlaying = false
    end
end

local function toggleSound()
    if isSoundPlaying then
        pauseAudio()
    else
        playAudio()
    end
end

-- Próxima página
local function goToNextPage()
    composer.gotoScene("contracapa")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("page4")
end

-- Referências Bibliográficas
local function showReferences(sceneGroup)
    local referencesGroup = display.newGroup()
    sceneGroup:insert(referencesGroup)

    local referencesBackground = display.newRect(referencesGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    referencesBackground:setFillColor(0, 0, 0, 0.8)

    -- Textos
    local referencesText = display.newText({
        parent = referencesGroup,
        text = "TODA MATÉRIA. Reinos dos Seres Vivos. Disponível em: <https://www.todamateria.com.br/reinos-dos-seres-vivos/>. Acesso em: 22 out. 2024.\n\nUOL EDUCAÇÃO. Taxonomia: como funciona o sistema de classificação dos seres vivos. Disponível em: <https://educacao.uol.com.br/disciplinas/biologia/taxonomia-como-funciona-o-sistema-de-classificacao-dos-seres-vivos.htm#:~:text=A%20classifica%C3%A7%C3%A3o%20b%C3%A1sica%20dos%20seres,ordem%2C%20classe%2C%20e%20esp%C3%A9cie>. Acesso em: 22 out. 2024.\n\nEDIÇÕES SM (Org.). Ser protagonista box: biologia, ensino médio: volume único. 1. ed. São Paulo: Edições SM, 2014. (Coleção ser protagonista box).",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = referencesBackground.width - 60,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 16,
        align = "justify"
    })
    referencesText:setFillColor(1)
    referencesGroup:insert(referencesText)

    -- Fechar \normal 
    local closeButton = widget.newButton({
        label = "Fechar",
        fontSize = 20,
        shape = "roundedRect",
        width = 120,
        height = 50,
        fillColor = { default = {1, 0, 0}, over = {0.8, 0, 0} },
        labelColor = { default = {1}, over = {0.8} },
        onRelease = function()
            referencesGroup:removeSelf()
            referencesGroup = nil
        end
    })
    closeButton.x = display.contentCenterX
    closeButton.y = display.contentHeight - 80
    referencesGroup:insert(closeButton)
end

-- Função lanterna
local function toggleFlashlight(sceneGroup)
    local flashlightOn = false
    local revealedImage

    -- Imagem lanterna /normal
    local flashlight = display.newImageRect(sceneGroup, "Images/ImgPag5/lanternadesl.png", 150, 150)
    flashlight.x = 650
    flashlight.y = 423

    -- Clique na lanterna
    local function onFlashlightTapped()
        flashlightOn = not flashlightOn

        if flashlightOn then
            flashlight.fill = { type = "image", filename = "Images/ImgPag5/lanterna.png" }

            revealedImage = display.newImageRect(sceneGroup, "Images/ImgPag5/virus.png", 450, 450)
            revealedImage.x = display.contentCenterX
            revealedImage.y = 645
        else
            flashlight.fill = { type = "image", filename = "Images/ImgPag5/lanternadesl.png" }

            if revealedImage then
                revealedImage:removeSelf()
                revealedImage = nil
            end
        end
    end

    -- Evento lanterna
    flashlight:addEventListener("tap", onFlashlightTapped)
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
        text = "E os Vírus?",
        x = display.contentCenterX,
        y = 135,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 70,
        align = "center"
    })
    title:setFillColor(1)

    -- Explicação
    local explanation = display.newText({
        parent = sceneGroup,
        text = "Os vírus não são considerados seres vivos porque não possuem células, que são a base de toda forma de vida, e não realizam funções vitais de forma independente, como metabolismo e reprodução.\nPara se replicar, dependem completamente de uma célula hospedeira, o que os coloca fora dos critérios para serem classificados como organismos vivos.\n\nToque na lanterna.",
        x = display.contentCenterX,
        y = 320,
        width = display.contentWidth - 60,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    explanation:setFillColor(1)

    -- Toggle lanterna
    toggleFlashlight(sceneGroup)

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

    -- Botão "Referências Bibliográficas"
    local referencesButton = widget.newButton({
        label = "Referências Bibliográficas",
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 18,
        shape = "roundedRect",
        width = 250,
        height = 50,
        fillColor = { default = {1, 0.8, 0}, over = {1, 0.9, 0.5} },
        labelColor = { default = {0}, over = {0} },
        onRelease = function() showReferences(sceneGroup) end
    })
    referencesButton.x = display.contentCenterX
    referencesButton.y = display.contentHeight - 130
    sceneGroup:insert(referencesButton)

end

function scene:show(event)
    if event.phase == "did" then
            playAudio()
    end
end

function scene:hide(event)
    if event.phase == "will" then
        pauseAudio()
    end
end

scene:addEventListener("create", scene)

return scene