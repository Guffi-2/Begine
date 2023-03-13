_G.love = require("love")
--_G.gamera = require 'gamera'
--_G.button = require("button")

function love.load()
    -- цвета
    _G.black = {0, 0, 0}
    _G.grey_color = {151, 151, 151}
    _G.white = {1, 1, 1}
    _G.yellow = {238, 238, 25}

    _G.button = { -- кнопка которую я не использую
        x = 700,
        y = 10
    }

    _G.button_invent = { -- кнопка которую я буду использовать
        x = 110,
        y = 20
    }

    _G.invent_is_open = { -- проверка открытия инвентаря на "e"
        boolean = false
    }
   --_G.win_mashtab = {
    --    width = w,
    --    height = h
    --}

    _G.invent_text_txt = {} -- текст в инвентаре

    _G.invent_text = {black, invent_text_txt} -- собранный текст в инвентаре

    _G.mouses = { -- позиции мышки
        x = 0,
        y = 0
    }

    -- загрузка спрайтов
    _G.cursor = love.graphics.newImage("sprite/Sprite-cursor.png")
    _G.invent_1 = love.graphics.newImage("sprite/invent_1.png")
    _G.tree_texture = love.graphics.newImage("sprite/Tree.png")
    _G.back_g = love.graphics.newImage("sprite/Back-g.png")
    _G.bush_texture = love.graphics.newImage("sprite/Bush.png")

    love.mouse.setVisible(false) -- убирает системную мышь

    _G.player = { -- позиции игрока
        x = 10,
        y = 10
    }

    _G.window = { -- разрешение окна
        w = 800,
        h = 600
    }
        
    _G.bush = { -- куст и все переменные которые с ним связаны
        x = math.random(20, window.w - 20),
        y = math.random(20, window.h - 20),
        eaten = false,
        mouse = {
            ver = 0,
            func = false
        }
    }

    _G.tree = { -- дерево все переменные которые с ним связаны
        x = math.random(20, window.w - 20),
        y = math.random(20, window.h - 20),
        eaten = false,
        point = 0,
        stick = 0,
        mouse = {
            ver = 0,
            func = false
        }
    }

    _G.fps = 0 -- переменная для фпс

    love.window.setFullscreen(true, "desktop") -- развёртка игры на весь экран


end

function love.update(dt)
    --love.timer.sleep(0.001)

    window.w, window.h = love.window.getMode() -- получение разрешения окна


    invent_text_txt = "Tree sticks: "..tree.stick -- текст в инвентаре для показа сколько у меня есть палок

    invent_text = {black, invent_text_txt} -- текст в инвентаре

    fps = love.timer.getFPS() -- обновление счётчика фпс

    -- получение позиций мыши

    mouses.x = love.mouse.getX() 
    mouses.y = love.mouse.getY()


    -- управление перемещением
    if love.keyboard.isDown("a") then
        player.x = player.x - 1
    end
    if love.keyboard.isDown("d")  then
        player.x = player.x + 1
    end
    if love.keyboard.isDown("s") then
        player.y = player.y + 1
    end
    if love.keyboard.isDown("w") then
        if player.y <= tree.y + 159 and player.y >= tree.y + 150 and player.x + 15 > tree.x + 40 and player.x < tree.x + 35 + 45 - 15 + 10 - 2 * 2  then -- делаю так чтобы нельзя было проходить сквось дерево
        elseif player.y <= bush.y + 54 and player.y >= bush.y + 50 and player.x + 15 > bush.x - 20 + 2 * 16 and player.x < bush.x + 105 + 20 - 2 * 16  then -- делаю так чтобы нельзя было проходить сквось куст    
        else
                player.y = player.y - 1
    
        end
    end
    --if player.x + 15 > tree.x and player.x < tree.x + 10 and player.y + 15 > tree.y and player.y < tree.y + 10 then
    --    tree.eaten = true
    --    tree.point = tree.point + 1
        
        --love.timer.sleep(1)
    --end

    if mouses.x > tree.x - 20 and mouses.x < tree.x + 105 + 20 and mouses.y > tree.y and mouses.y < tree.y + 150 + 66 and love.mouse.isDown(1) then -- срубание деревьев
        if player.x + 15 > tree.x - 20 and player.x < tree.x + 105 + 20 and player.y + 15 > tree.y - 20 and player.y < tree.y + 150 + 20 then
            tree.mouse.ver = tree.mouse.ver + 1
            tree.mouse.func = true
        end
        if tree.mouse.ver == 100 then
            tree.eaten = true
            tree.point = tree.point + 1
            tree.mouse.ver = tree.mouse.ver - 100
            tree.mouse.func = false
        end
        --love.timer.sleep(1)
    end

    if mouses.x > bush.x - 20 and mouses.x < bush.x + 105 + 20 and mouses.y > bush.y and mouses.y < bush.y + 150 + 66 and love.mouse.isDown(1) then -- срубание кустов
        if player.x + 15 > bush.x - 20 and player.x < bush.x + 105 + 20 and player.y + 15 > bush.y - 20 and player.y < bush.y + 150 + 20 then
            tree.mouse.ver = tree.mouse.ver + 1
            tree.mouse.func = true
        end
        if tree.mouse.ver == 100 then
            bush.eaten = true
            tree.point = tree.point + 1
            tree.mouse.ver = tree.mouse.ver - 100
            tree.mouse.func = false
        end
        --love.timer.sleep(1)
    end

    --print("player.x: "..player.x.." player.y: "..player.y.." food.x: "..tree.x.." food.y: "..tree.y)
end
    
function love.draw()
    love.graphics.draw(back_g, 0, 0) -- задний фон
    if not tree.eaten then -- телепортация деревьев послуе срубания
        if player.x > tree.x - 15 and player.x < tree.x + 16 * 3 + 15 and player.y > tree.y + 161 - 16 and player.y < tree.y + 15 + 161 then  -- !!!!!
            love.graphics.draw(tree_texture, tree.x, tree.y)
            love.graphics.rectangle("line", player.x, player.y, 15, 15)
        else
            love.graphics.rectangle("line", player.x, player.y, 15, 15)
            love.graphics.draw(tree_texture, tree.x, tree.y)
        end
        
    else
        tree.x = math.random(20, window.w - 15) -- рандом спавн
        tree.y = math.random(20, window.h - 15)
        tree.eaten = false
    end

    if not bush.eaten then -- телепортация кустов послуе срубания
        if player.x > bush.x - 15 and player.x < bush.x + 16 * 3 + 15 and player.y > bush.y + 105 - 16 and player.y < bush.y + 15 + 105 then
            love.graphics.draw(bush_texture, bush.x, bush.y)
            love.graphics.rectangle("line", player.x, player.y, 15, 15)
        else
            love.graphics.rectangle("line", player.x, player.y, 15, 15)
            love.graphics.draw(bush_texture, bush.x, bush.y)
        end
        
    else
        bush.x = math.random(20, window.w - 50) -- рандом спавн
        bush.y = math.random(20, window.h - 50)
        bush.eaten = false
    end

    --love.graphics.rectangle("fill", button.x, button.y, 50, 25)

    love.graphics.print("tree: "..tree.point, 0, 10)
    love.graphics.print(""..fps, 0, 0)
    love.graphics.print("tree sticks: "..tree.stick, 0, 20)
    
    if tree.mouse.func == true then
        love.graphics.print(""..tree.mouse.ver.."%", 300, 500)
    end
    if invent_is_open.boolean == true then
        love.graphics.rectangle("fill", 100, 10, 600, 300)
        
        love.graphics.print(invent_text, 110, 20)
    end

    love.graphics.draw(invent_1, 140 / 800 * window.w + 5 * 50 / 800 * window.w - 5*50, 470 / 600 * window.h + 2.7 * 50 / 600 * window.h - 2.7 * 50)
    love.graphics.draw(cursor, mouses.x - 17, mouses.y - 14)
end

function love.mousepressed(x, y, button_o, istouch)
    --if x > button.x and x < button.x + 200 and y > button.y and y < button.y + 150 then
    --    if button_o == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
    --        tree.stick = tree.stick + 1
    --    end
    --end
    if invent_is_open.boolean == true then
        if x > button_invent.x and x < button_invent.x + 200 and y > button_invent.y and y < button_invent.y + 150 then
            if button_o == 1 then 
                if tree.point == 10 then
                    tree.stick = tree.stick + 1
                    tree.point = tree.point - 10
                end
            end
        end
    end
    

 end

 function love.keypressed(key, scancode, isrepeat)
    if key == "e" and invent_is_open.boolean == false then
       invent_is_open.boolean = true
    elseif key == "e" and invent_is_open.boolean == true then
        invent_is_open.boolean = false
       end
 end