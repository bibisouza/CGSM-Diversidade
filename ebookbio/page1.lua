local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundOn = true

local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Função para avançar para a próxima página
local function goToNextPage()
    composer.gotoScene("page2") -- Crie a próxima página separadamente
end

-- Função para voltar à página anterior
local function goToPreviousPage()
    composer.gotoScene("capa") -- Retorna à página anterior
end

-- Criação da cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo com cor sólida (verde escuro)
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.05, 0.2, 0.05) -- Verde escuro

    -- Título principal
    local title = display.newText({
        text = "Biodiversidade",
        x = display.contentCenterX,
        y = 100,
        font = "Montserrat-VariableFont_wght.ttf-Bold", -- Fonte em negrito
        fontSize = 64,
        align = "center"
    })
    title:setFillColor(1) -- Branco
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
    description:setFillColor(1) -- Branco
    sceneGroup:insert(description)

    -- Espaços para imagens
    local image1 = display.newImageRect(sceneGroup, "Images/ImgPag1/deserto.png", 240, 240)
    image1.x = display.contentWidth * 0.2
    image1.y = 560
    image1.name = "Deserto"

    local image2 = display.newImageRect(sceneGroup, "Images/ImgPag1/pradaria.png", 240, 240)
    image2.x = display.contentWidth * 0.8
    image2.y = 560
    image2.name = "Pradaria"

    local image3 = display.newImageRect(sceneGroup, "Images/ImgPag1/floresta.png", 240, 240)
    image3.x = display.contentWidth * 0.5
    image3.y = 820
    image3.name = "Floresta"

    -- Função validação
    local function checkMatch(wordGroup, target)
        local wordName = wordGroup.name or wordGroup[1].name
        local targetName = target.name

        if wordName == targetName then
            target:setFillColor(0.2, 0.8, 0.2)
            print(wordName .. " está correta!")
        else
            print(wordName .. " está incorreta!")
        end
    end

    -- Interação
    local function onDrag(event)
        local target = event.target

        if event.phase == "began" then
            display.getCurrentStage():setFocus(target)
            target.isFocus = true
        
            target.touchOffsetX = event.x - target.x
            target.touchOffsetY = event.y - target.y

            target[1]:setFillColor(1, 0.8, 0)


        elseif event.phase == "moved" and target.isFocus then
            target.x = event.x - target.touchOffsetX
            target.y = event.y - target.touchOffsetY

        elseif event.phase == "ended" or event.phase == "cancelled" then
            if target.isFocus then
                display.getCurrentStage():setFocus(nil)
                target.isFocus = false


                target[1]:setFillColor(1, 0.6, 0)


                local matched = false
                for _, ecosystem in ipairs({image1, image2, image3}) do
                    local bounds = ecosystem.contentBounds
                    if target.x > bounds.xMin and target.x < bounds.xMax and target.y > bounds.yMin and target.y < bounds.yMax then
                        checkMatch(target, ecosystem)
                        matched = true
                        break
                    end
                end


                if not matched then
                    transition.to(target, {x = target.startX, y = target.startY, time = 300})
                end
            end
        end
        return true
    end

    -- Caixas com texto
    local function createWord(sceneGroup, x, y, text, name)
        local group = display.newGroup()
        sceneGroup:insert(group)

        local box = display.newRect(group, 0, 0, 150, 40)
        box:setFillColor(1, 0.6, 0)
        box.name = name

        local boxText = display.newText({
            parent = group,
            text = text,
            x = 0,
            y = 0,
            font = "Montserrat-VariableFont_wght",
            fontSize = 18
        })

        group.x = x
        group.y = y
        group.startX = x
        group.startY = y

        -- Associar grupo
        group.name = name

        group:addEventListener("touch", onDrag)

        return group
    end

    -- Palavras
    local word1 = createWord(sceneGroup, display.contentWidth * 0.15, 380, "Pradaria", "Pradaria")
    local word2 = createWord(sceneGroup, display.contentWidth * 0.5, 380, "Floresta", "Floresta")
    local word3 = createWord(sceneGroup, display.contentWidth * 0.86, 380, "Deserto", "Deserto")

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

scene:addEventListener("create", scene)

return scene