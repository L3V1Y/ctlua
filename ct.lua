utils.print_dev_console("🞄cyber.technology🞄")
utils.print_dev_console("🞄recoded version🞄")
--ну чё начинаем - обозначение функций типо чекбокс итд
local cb = gui.add_checkbox
local sl = gui.add_slider
local cmb = gui.add_combo
local mc = gui.add_multi_combo
local btn = gui.add_button
local txt = gui.add_textbox
local lb = gui.add_listbox
local kb = gui.add_keybind
local cp = gui.add_colorpicker
local find = gui.get_config_item
local error = utils.error_print

--начало скрипта
--рагубоб (мейн)
local menu = cmb("cyber.technology recode", "lua>tab a", {"Main", "Anti-Aim", "Visual features", "Misc"})
local da = cb("Dormant on key", "lua>tab b")
local dakb = kb("lua>tab b>Dormant on key")
local osf = cb("OS-AA fix", "lua>tab b")
local os = cmb("OS-AA", "lua>tab b", {"Firerate", "Lagcomp break", "Full fakelag"})
local sfix = cb("Scout fix (maybe)", "lua>tab b")
--аашки
local rjt = cb("Random jitter", "lua>tab b")
local rjt1 = sl("Random jitter 1", "lua>tab b", -360, 360, 0)
local rjt2 = sl("Random jitter 2", "lua>tab b", -360, 360, 0)
local rjc = cb("Random desync comp", "lua>tab b")
local rjc1 = sl("Random desync comp 1", "lua>tab b", 0, 100, 0)
local rjc2 = sl("Random desync comp 2", "lua>tab b", 0, 100, 0)
local rdj = cb("Random desync", "lua>tab b")
local rdj1 = sl("Random desync 1", "lua>tab b", -100, 100, 0)
local rdj2 = sl("Random desync 2", "lua>tab b", -100, 100, 0)
--визуалы индикаторы итд
local visual = cb("Indicators", "lua>tab b")
local visualm = cmb("Indicator selection", "lua>tab b", {"-", "Pixel", "Re-newed"})
local watermark = cb("Side watermark", "lua>tab b")
local cn = cb("Custom Watermark name", "lua>tab b")
local name = txt("Name", "lua>tab b")
--миски
local sm = cb("Static on manual", "lua>tab b")
local rl = cb("Ragebot logs", "lua>tab b")
local tag = cb("Clantag", "lua>tab b")

function MenuElements()
   local tab = menu:get_int()
   local ryjc = rjt:get_bool()
   local rjcc = rjc:get_bool()
   local rdjc = rdj:get_bool()
   local osc = osf:get_bool()
   local indc = visual:get_bool()
   local cnc = cn:get_bool()
   gui.set_visible("lua>tab b>Dormant on key", tab == 0);
   gui.set_visible("lua>tab b>OS-AA fix", tab == 0);
   gui.set_visible("lua>tab b>OS-AA", tab == 0 and osc);
   gui.set_visible("lua>tab b>Scout fix (maybe)", tab == 0);
   gui.set_visible("lua>tab b>Random jitter", tab == 1)
   gui.set_visible("lua>tab b>Random jitter 1", tab == 1 and ryjc)
   gui.set_visible("lua>tab b>Random jitter 2", tab == 1 and ryjc)
   gui.set_visible("lua>tab b>Random desync comp", tab == 1)
   gui.set_visible("lua>tab b>Random desync comp 1", tab == 1 and rjcc)
   gui.set_visible("lua>tab b>Random desync comp 2", tab == 1 and rjcc)
   gui.set_visible("lua>tab b>Random desync", tab == 1)
   gui.set_visible("lua>tab b>Random desync 1", tab == 1 and rdjc)
   gui.set_visible("lua>tab b>Random desync 2", tab == 1 and rdjc)
   gui.set_visible("lua>tab b>Indicators", tab == 2)
   gui.set_visible("lua>tab b>Indicator selection", tab == 2 and indc)
   gui.set_visible("lua>tab b>Side watermark", tab == 2)
   gui.set_visible("lua>tab b>Custom Watermark name", tab == 2)
   gui.set_visible("lua>tab b>Name", tab == 2 and cnc)
   gui.set_visible("lua>tab b>Static on manual", tab == 3);
   gui.set_visible("lua>tab b>Ragebot logs", tab == 3);
   gui.set_visible("lua>tab b>Clantag", tab == 3);
end


local hs = gui.get_config_item("Rage>Aimbot>Aimbot>Hide shot")
local dt = gui.get_config_item("Rage>Aimbot>Aimbot>Double tap")
local limit = gui.get_config_item("Rage>Anti-Aim>Fakelag>Limit")
local desynccache = gui.get_config_item("Rage>Anti-Aim>Desync>Fake amount")
local cacache = gui.get_config_item("Rage>Anti-Aim>Desync>Compensate angle")
local jitcache = gui.get_config_item("Rage>Anti-Aim>Angles>Jitter range")
-- cache fakelag limit
local cache = {
  backup = limit:get_int(),
  override = false,
}
  
local aacache = {
    backup = desynccache:get_int(),
    override = false,
  }  
  local compcache = {
    backup = cacache:get_int(),
    override = false,
  }  
  local jtcache = {
    backup = jitcache:get_int(),
    override = false,
  }  
function randomdesync()
    if rdj:get_bool() then
        desynccache:set_int(global_vars.tickcount % 8 >= 2 and rdj1:get_int() or rdj2:get_int())
        aacache.override = true
    else
        if aacache.override then
            desynccache:set_int(aacache.backup)
            aacache.override = false
        else
            aacache.backup = desynccache:get_int()
        end
      end
    end

    function randomjitter()
        if rjt:get_bool() then
            jitcache:set_int(global_vars.tickcount % 8 >= 2 and rjt1:get_int() or rjt2:get_int())
            jtcache.override = true
        else
            if jtcache.override then
                jitcache:set_int(jtcache.backup)
                jtcache.override = false
            else
                jtcache.backup = jitcache:get_int()
            end
          end
        end
        function randomcomp()
            if rjc:get_bool() then
                cacache:set_int(global_vars.tickcount % 8 >= 2 and rjc1:get_int() or rjc2:get_int())
                compcache.override = true
            else
                if compcache.override then
                    cacache:set_int(compcache.backup)
                    compcache.override = false
                else
                    compcache.backup = cacache:get_int()
                end
              end
            end






--фейклаги спасченые с авроры 
--бтв я их зафиксил
function OSFF()

    if osf:get_bool() then
        if os:get_int() == 0 and not dt:get_bool() then
          if hs:get_bool() then
              limit:set_int(1)
              cache.override = true
          else
              if cache.override then
              limit:set_int(cache.backup)
              cache.override = false
              else
              cache.backup = limit:get_int()
              end
            end
          end
        end
    
      if osf:get_bool() then
        if os:get_int() == 1 and not dt:get_bool() then
          if hs:get_bool() then
              limit:set_int(global_vars.tickcount % 32 >= 30 and 6 or 1)
              cache.override = true
          else
              if cache.override then
              limit:set_int(cache.backup)
              cache.override = false
              else
              cache.backup = limit:get_int()
              end
            end
          end
        end
    
    if osf:get_bool() then
        if os:get_int() == 2 and not dt:get_bool() then
            if hs:get_bool() then
                limit:set_int(6)
                cache.override = true
            else
                if cache.override then
                limit:set_int(cache.backup)
                cache.override = false
                else
                cache.backup = limit:get_int()
                end
            end
        end
    end
    end

--визуалы
pixel = render.font_esp
screen_center = {
    w = 0,
    h = 0
}

screen_size_x, screen_size_y = render.get_screen_size()
x = screen_size_x / 2
y = screen_size_y / 2

local lp = entities.get_entity(engine.get_local_player())


function wm()
    if not lp then return end
if not lp:is_alive() then return end

if not engine.is_in_game() then return end
    alpha2 = math.floor(math.abs(math.sin(global_vars.realtime) * 1) * 255)
    wm_text1 = "+/- cyber.technology"
    wm_text2 = "+/- version: "
    wm_debug = "debug"
    nm = name:get_string()
    wm_text3 = "+/- user: " .. nm .. ""
    if watermark:get_bool() then
    render.text(pixel, x - 766, y + 0, wm_text1, render.color(255, 255, 255));
    render.text(pixel, x - 766, y + 10, wm_text2, render.color(255, 255, 255));
    render.text(pixel, x - 712, y + 10, wm_debug, render.color(255, 255,255, alpha2));
    render.text(pixel, x - 766, y + 20, wm_text3, render.color(255, 255, 255));
    
end
end

function indic()
if not lp:is_alive() then return end

if not engine.is_in_game() then return end

local DT = find("rage>aimbot>aimbot>double tap"):get_bool()
local OS = find("rage>aimbot>aimbot>hide shot"):get_bool()
local DMG = find("rage>aimbot>ssg08>scout>override"):get_bool()
local SP = find("rage>aimbot>aimbot>force extra safety"):get_bool()
local AP = find("misc>movement>peek assist"):get_bool()
local FD = find("misc>movement>fake duck"):get_bool()
local text =  "cyber."
local text2 = "tech"
local text3 = "DOUBLETAP"
local text4 = "OS-AA"
local text5 = "AUTOPEEK"
local text6 = "SAFEPOINT"
local text7 = "FAKEDUCK"
local text8 = "DAMAGE"
local textx, texty = render.get_text_size(pixel, text)
local text2x, text2y = render.get_text_size(pixel, text2)
local text3x, text3y = render.get_text_size(pixel, text3)
local text4x, text4y = render.get_text_size(pixel, text4)
local text5x, text5y = render.get_text_size(pixel, text5)
local text6x, text6y = render.get_text_size(pixel, text6)
local text7x, text7y = render.get_text_size(pixel, text7)
local scoped = lp:get_prop("m_bIsScoped")

local function Clamp(Value, Min, Max)
    return Value < Min and Min or (Value > Max and Max or Value)
end
ay = 0

    if visual:get_bool() then
        if visualm:get_int() == 1 then
            if not scoped then
            render.text(pixel, x - 23, y + 20, text, render.color(255,255, 255, 255))
            render.text(pixel, x + 3, y + 20, text2, render.color(255,255, 255, alpha2))
            if OS then
                render.text(pixel, x - 12, y + 30 + ay, text4, render.color(255,255, 255, 255)) 
                ay = ay + 10
            end
            if DT then
                render.text(pixel, x - 22, y + 30 + ay, text3, render.color(255,255, 255, 255)) 
                ay = ay + 10
            end
            if DMG then
                render.text(pixel, x - 15, y + 30 + ay, text8, render.color(255,255, 255, 255)) 
                ay = ay + 10
            end
            else
                if scoped then
                    render.text(pixel, x+10, y + 20, text, render.color(255,255, 255, 255))
                    render.text(pixel, x + 36, y + 20, text2, render.color(255,255, 255, alpha2))
                    if OS then
                        render.text(pixel, x + 10, y + 30 + ay, text4, render.color(255,255, 255, 255)) 
                        ay = ay + 10
                    end
                    if DT then
                        render.text(pixel, x + 10, y + 30 + ay, text3, render.color(255,255, 255, 255)) 
                        ay = ay + 10
                    end
                    if DMG then
                        render.text(pixel, x + 10, y + 30 + ay, text8, render.color(255,255, 255, 255)) 
                        ay = ay + 10
                    end


        end
    end
end
end
end

--[[
    local desynccache = gui.get_config_item("Rage>Anti-Aim>Desync>Fake amount")
local cacache = gui.get_config_item("Rage>Anti-Aim>Desync>Compensate angle")
local jitcache = gui.get_config_item("Rage>Anti-Aim>Angles>Jitter range")
]]
left = find("rage>anti-aim>angles>left"):get_bool()
right = find("rage>anti-aim>angles>right"):get_bool()
freestand = find("rage>anti-aim>angles>freestand"):get_bool()



--логи да
local function hitlogs(shot)
    if shot.manual then return end
        local hitgroup_names = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"}
        local p = entities.get_entity(shot.target)
        local n = p:get_player_info()
        local hitgroup = shot.server_hitgroup
        local clienthitgroup = shot.client_hitgroup
        local health = p:get_prop("m_iHealth")
    
            if rl:get_bool() then
                if shot.server_damage > 0 then
                    print( "cyber.tech | Registered shot to " , n.name  , "'s ", hitgroup_names[hitgroup + 1]," for " , shot.server_damage, " damage (hc=", math.floor(shot.hitchance), ", bt=", math.floor(shot.backtrack),")")
                else
                    print( "cyber.tech | Missed " , n.name  , "'s ", hitgroup_names[shot.client_hitgroup + 1]," due to ", shot.result,  " (hc=", math.floor(shot.hitchance), ", bt=", math.floor(shot.backtrack),")")
                end
            end
    
    end


    function on_shot_registered(shot)
        hitlogs(shot)
    end

function on_create_move()
    OSFF()
    randomdesync()
    randomjitter()
    randomcomp()
end

function on_shutdown()
    limit:set_int(cache.backup)
    desynccache:set_int(aacache.backup)
    cacache:set_int(compcache.backup)
    jitcache:set_int(jtcache.backup)
end




function on_paint()
    MenuElements()
    wm()
    indic()
end






