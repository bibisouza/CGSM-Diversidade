local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundPlaying = false
local audioChannel
local audioFile = audio.loadStream("Audios/audpag3.mp3")
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
        text = "A classificação dos seres vivos em cinco reinos foi proposta em 1969 pelo biólogo norte-americano Robert Whittaker. Essa divisão é um tipo de organização que agrupa os seres vivos de acordo com semelhanças entre suas características estruturais, anatômicas e genéticas.\n\nOs cinco reinos são: Animal, Planta, Fungo, Protoctista e Monera. Arraste a lupa para encontrá-los!",
        x = display.contentCenterX,
        y = 270,
        width = display.contentWidth - 40,
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 20,
        align = "justify"
    })
    explanation:setFillColor(1)

    -- Reinos escondidos
    local kingdomData = {
        { name = "Animal", x = display.contentCenterX - 250, y = 450 },
        { name = "Planta", x = display.contentCenterX, y = 750 },
        { name = "Fungo", x = display.contentCenterX + 280, y = 500 },
        { name = "Protoctista", x = display.contentCenterX + 50, y = 920 },
        { name = "Monera", x = display.contentCenterX - 280, y = 650 }
    }

    local hiddenGroup = display.newGroup()
    sceneGroup:insert(hiddenGroup)

    for _, kingdom in ipairs(kingdomData) do
        local text = display.newText({
            parent = hiddenGroup,
            text = kingdom.name,
            x = kingdom.x,
            y = kingdom.y,
            font = "Montserrat-VariableFont_wght.ttf",
            fontSize = 28,
            align = "center"
        })
        text:setFillColor(1, 1, 1)
        text.isVisible = false
    end

    local lupa = display.newCircle(sceneGroup, display.contentCenterX, display.contentCenterY, 100)
    lupa:setFillColor(1, 1, 1, 0.5)

    local function revealHiddenItems(event)
        for i = 1, hiddenGroup.numChildren do
            local item = hiddenGroup[i]
            if math.abs(item.x - event.x) < 100 and math.abs(item.y - event.y) < 100 then
                item.isVisible = true
            end
        end
        return true
    end
    
    lupa:addEventListener("touch", function(event)
        if event.phase == "moved" then
            lupa.x, lupa.y = event.x, event.y
            revealHiddenItems(event)
        end
    end)


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