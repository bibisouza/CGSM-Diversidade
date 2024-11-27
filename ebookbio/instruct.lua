local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo branco
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(1)

    -- Título
    local title = display.newText({
        parent = sceneGroup,
        text = "Instruções",
        x = display.contentCenterX,
        y = 100,
        font = "Montserrat-Bold.ttf",
        fontSize = 36,
    })
    title:setFillColor(0)

    -- Espaço para adicionar texto de instruções
    local instructions = display.newText({
        parent = sceneGroup,
        text = "Aqui você pode adicionar as instruções para o uso do e-book.",
        x = display.contentCenterX,
        y = display.contentCenterY,
        width = display.contentWidth - 50,
        font = "Montserrat-Regular.ttf",
        fontSize = 24,
        align = "center",
    })
    instructions:setFillColor(0)

    -- Botão para voltar à página inicial
    local backButton = widget.newButton({
        label = "Voltar",
        font = "Montserrat-Bold.ttf",
        fontSize = 18,
        shape = "roundedRect",
        width = 150,
        height = 40,
        fillColor = { default = {0.9, 0.9, 0.9}, over = {0.8, 0.8, 0.8} },
        labelColor = { default = {0}, over = {0.5} },
        onRelease = function()
            composer.gotoScene("page1")
        end
    })
    backButton.x = display.contentCenterX
    backButton.y = display.contentHeight - 100
    sceneGroup:insert(backButton)
end

scene:addEventListener("create", scene)

return scene
