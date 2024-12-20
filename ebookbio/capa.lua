local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/audcapa.mp3")
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
    composer.gotoScene("page1")
end

-- Instruções
local function showInstructions()
    composer.gotoScene("instructions")
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
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
    local authorBackground = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight - 150, display.contentWidth * 0.5, 105)
    authorBackground:setFillColor(0.07, 0.2, 0.07)
    sceneGroup:insert(authorBackground)

    -- Autoria
    local author = display.newText({
        text = "Autora: Beatriz Silva Souza Bezerra\n2024.2",
        x = display.contentCenterX,
        y = 880,
        font = "Montserrat-VariableFont_wght",
        fontSize = 18,
        align = "center",
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

    -- Botão "?"
    local helpButton = widget.newButton({
        label = "?",
        font = "Montserrat-VariableFont_wght",
        fontSize = 24,
        shape = "circle",
        radius = 25,
        fillColor = { default = {0.1, 0.5, 0.1}, over = {0.8, 0.8, 0.8} },
        labelColor = { default = {0}, over = {0} },
        onRelease = showInstructions
    })
    helpButton.x = 60
    helpButton.y = display.contentHeight - 60
    sceneGroup:insert(helpButton)

    -- Botão "Avançar"
    local nextButton = widget.newButton({
        label = "Avançar",
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
end

function scene:show(event)
end

function scene:hide(event)
    if event.phase == "will" then
        pauseAudio()
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene