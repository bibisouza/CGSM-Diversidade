local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

local isDefaultImage = true
local isTextVisible = false

-- Som
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/audpag4.mp3")
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
    composer.gotoScene("page5")
end

-- Página anterior
local function goToPreviousPage()
    composer.gotoScene("page3")
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
        text = "Regras de Nomenclatura",
        x = display.contentCenterX,
        y = 110,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 56,
        align = "center"
    })
    title:setFillColor(1)

    -- Explicação
    local explanation = display.newText({
        parent = sceneGroup,
        text = "As regras de nomenclatura garantem que os seres vivos sejam nomeados de forma universal. Exemplo: o nome científico do cachorro é Canis lupus familiaris.\n\nToque na imagem do cachorro abaixo.",
        x = display.contentCenterX,
        y = 270,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    explanation:setFillColor(1)

    -- Imagem do cachorro
    local dogImage = display.newImageRect(sceneGroup, "Images/ImgPag4/dog.png", 600, 600)
    dogImage.x = display.contentCenterX + 50
    dogImage.y = display.contentCenterY + 150


    -- Balão
    local textBubble = display.newRoundedRect(sceneGroup, dogImage.x - 200, dogImage.y - 135, 350, 115, 50)
    textBubble:setFillColor(1, 1, 1, 0.5)
    textBubble.isVisible = false

    local scientificName = display.newText({
        parent = sceneGroup,
        text = "Canis lupus familiaris\n(Família: Canidae)",
        x = textBubble.x,
        y = textBubble.y,
        width = textBubble.width - 20,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "center"
    })
    scientificName:setFillColor(0)
    scientificName.isVisible = false

    -- Animação
    local function toggleDogImage()
        if isDefaultImage then
            dogImage.fill = { type = "image", filename = "Images/ImgPag4/dogalt.png" }
            textBubble.isVisible = true
            scientificName.isVisible = true
        else
            dogImage.fill = { type = "image", filename = "Images/ImgPag4/dog.png" }
            textBubble.isVisible = false
            scientificName.isVisible = false
        end

        isDefaultImage = not isDefaultImage

        transition.to(dogImage, { yScale = 1.1, xScale = 1.1, time = 150, transition = easing.outQuad })
        transition.to(dogImage, { yScale = 1, xScale = 1, time = 150, delay = 150 })
    end


    dogImage:addEventListener("tap", toggleDogImage)

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