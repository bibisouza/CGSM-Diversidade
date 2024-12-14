local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/audpag1.mp3")
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

-- Animação
local currentIndex = 1
local images = {}
local isAnimating = false


local function animateImage(image)
    if not isAnimating then
        isAnimating = true
        transition.to(image, { xScale = 1.5, yScale = 1.5, time = 500, onComplete = function()
            timer.performWithDelay(1000, function()
                transition.to(image, { xScale = 1, yScale = 1, time = 500, onComplete = function()
                    isAnimating = false
                end})
            end)
        end })
    end
end

-- Evento /agitar
local function onShake(event)
    if event.isShake and not isAnimating then
        animateImage(images[currentIndex])
        
        currentIndex = currentIndex + 1
        if currentIndex > #images then
            currentIndex = 1
        end
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
        text = "A biodiversidade é o termo que se refere à variedade de seres vivos, ecossistemas e genes que existem no planeta. Sua conservação é essencial para manter o equilíbrio da vida no planeta.\n\nAbaixo tem-se três exemplos de ecossistemas: as pradarias, as florestas e os desertos. Agite para ver melhor.",
        x = display.contentCenterX,
        y = 250,
        width = display.contentWidth * 0.9,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    description:setFillColor(1) 
    sceneGroup:insert(description)

    -- Imagem 1
    local image1 = display.newImageRect(sceneGroup, "Images/ImgPag1/pradaria.png", 200, 200)
    image1.x = display.contentCenterX - 250
    image1.y = display.contentCenterY
    images[#images + 1] = image1

    -- Imagem 2
    local image2 = display.newImageRect(sceneGroup, "Images/ImgPag1/floresta.png", 200, 200)
    image2.x = display.contentCenterX
    image2.y = display.contentCenterY
    images[#images + 1] = image2

    -- Imagem 3
    local image3 = display.newImageRect(sceneGroup, "Images/ImgPag1/deserto.png", 200, 200)
    image3.x = display.contentCenterX + 250
    image3.y = display.contentCenterY
    images[#images + 1] = image3

-- Listener
function scene:show(event)
    if event.phase == "did" then
        Runtime:addEventListener("accelerometer", onShake)
    end
end

function scene:hide(event)
    if event.phase == "will" then
        Runtime:removeEventListener("accelerometer", onShake)
    end
end

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