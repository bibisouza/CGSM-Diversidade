local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()

-- Som
local isSoundOn = true

local function toggleSound()
    isSoundOn = not isSoundOn
    print("Som:", isSoundOn and "Ligado" or "Desligado")
end

-- Instruções
local function goToPreviousPage()
    composer.gotoScene("capa")
end

-- Cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0.07, 0.2, 0.07)

    -- Título
    local title = display.newText({
        parent = sceneGroup,
        text = "Instruções de navegação:",
        x = display.contentCenterX,
        y = 140,
        font = "Montserrat-VariableFont_wght.ttf-Bold",
        fontSize = 50,
        align = "center"
    })
    title:setFillColor(1)
    
    -- Texto instruções
    local subtitle = display.newText({
        text = "Bem-vindo(a) ao nosso e-book interativo! Aqui estão algumas dicas de como navegar e interagir:\n\n\n- Avançar e Voltar: Use os botões 'Avançar' e 'Voltar' para se mover entre as páginas.\n- Interações: Cada página oferece elementos interativos. Clique ou toque nos itens destacados para descobrir surpresas ou explorar conteúdos extras!\n- Som On/Off: Controle a narração e os efeitos sonoros pelo botão 'Som On/Off'. Ative ou desative o som conforme sua preferência.\n- Voltar ao Início: Quando terminar, você pode retornar à primeira página usando a opção 'Início'.\n\nDivirta-se e explore o conteúdo do seu jeito! 😊",
        x = display.contentCenterX,
        y = 560,
        width = display.contentWidth - 60,
        font = "Montserrat-VariableFont_wght",
        fontSize = 24,
        align = "justify",
    })
    subtitle:setFillColor(1)
    sceneGroup:insert(subtitle)

    -- Botão "?"
    local backButton = widget.newButton({
        label = "?",
        font = "Montserrat-VariableFont_wght.ttf",
        fontSize = 24,
        shape = "circle",
        radius = 25,
        fillColor = { default = {0.1, 0.5, 0.1}, over = {0.8, 0.8, 0.8} },
        labelColor = { default = {0}, over = {0} },
        onRelease = goToPreviousPage
    })
    backButton.x = 60
    backButton.y = display.contentHeight - 60
    sceneGroup:insert(backButton)
end

scene:addEventListener("create", scene)

return scene