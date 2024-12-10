local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/a.mp3")
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
    composer.gotoScene("page2")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("capa")
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.05, 0.2, 0.05)

    -- Título
    local title = display.newText({
        text = "Biodiversidade",
        x = display.contentCenterX,
        y = 100,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 64,
        align = "center"
    })
    title:setFillColor(1)
    sceneGroup:insert(title)

    -- Texto explicativo
    local description = display.newText({
        text = "A biodiversidade é o termo que se refere à variedade de seres vivos, ecossistemas e genes que existem no planeta. Sua conservação é essencial para manter o equilíbrio da vida no planeta.\n\nAbaixo tem-se três exemplos de ecossistemas. Arraste os nomes às suas respectivas imagens.",
        x = display.contentCenterX,
        y = 250,
        width = display.contentWidth * 0.9,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    description:setFillColor(1) 
    sceneGroup:insert(description)

    -- Função animação
    local function animateBiome(biome)
        if biome.name == "Pradaria" then
            local grass = display.newImageRect(sceneGroup, "Images/ImgPag1/pradaria.png", 450, 450)
            grass.x, grass.y = biome.x, biome.y
            transition.to(grass, {xScale = 1.2, yScale = 1.2, time = 1000, iterations = 2, onComplete = function() grass:removeSelf() grass = nil end})
        end
    end

    -- Evento -> Imagens
    local function addBiomeInteraction(biome)
        biome:addEventListener("tap", function() animateBiome(biome) end)
    end

    -- Interatividade
    local image1 = display.newImageRect(sceneGroup, "Images/ImgPag1/pradaria.png", 450, 450)
    image1.x = display.contentCenterX
    image1.y = display.contentCenterY + 100
    image1.name = "Pradaria"
    sceneGroup:insert(image1)


    addBiomeInteraction(image1)

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

    -- Botão "Voltar"
    local backButton = widget.newButton({
        label = "Voltar",
        font = "Montserrat-VariableFont_wght",
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
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene