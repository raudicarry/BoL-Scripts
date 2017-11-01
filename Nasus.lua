local ScriptName = "Nasus God"
local Author = "Frank"
local version = 1
local AUTOUPDATE = true
local ran = math.random
local UPDATE_HOST = "raw.githubusercontent.com"
local UPDATE_PATH = "/LucasRPC/BoL-Scripts/Tw.lua".."?rand="..ran(3500,5500)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH
local FileName = _ENV.FILE_NAME

if myHero.charName ~= "Nasus" then return end

-- called once when the script is loaded
function OnLoad()
    Updater()
    local function UpdateSimpleLib()
        if FileExist(LIB_PATH .. "SimpleLib.lua") then
          require("SimpleLib")
        else
          DownloadFile("https://raw.githubusercontent.com/jachicao/BoL/master/SimpleLib.lua", LIB_PATH .. "SimpleLib.lua", function() UpdateSimpleLib() end)
        end
    end


    UpdateSimpleLib()
    DelayAction(function()
        print("<b><font color=\"#000000\"> | </font><font color=\"#FFFFFF\">Nasus: </font> <font color=\"#4AA02C\">God</font><font color=\"#000000\"> | </font></b><font color=\"#00FFFF\"> Loaded succesfully")
    end, 10)
    if OrbwalkManager.GotReset then return end
    if OrbwalkManager == nil then print("Check your SimpleLib file, isn't working... The script can't load without SimpleLib. Try to copy-paste the entire SimpleLib.lua on your common folder.") return end
    DelayAction(function() CheckUpdate() end, 5)
    DelayAction(function() _arrangePriorities() end, 10)
    TS = _SimpleTargetSelector(TARGET_LESS_CAST_PRIORITY, 1000, DAMAGE_PHYSICAL)
    Menu = scriptConfig(ScriptName.." by "..Author, ScriptName.."21072017")
    
    TS:AddToMenu(Menu)
        Menu:addSubMenu(myHero.charName.." - Combo Settings", "Combo")

        Menu.Combo:addSubMenu("                    | Q Settings |", "Q")

        Menu.Combo:addSubMenu("                    | W Settings |", "W")    

        Menu.Combo:addSubMenu("                    | E Settings |", "E")

        Menu.Combo:addSubMenu("                    | R Settings |", "R")
end

function Updater()
    if AUTOUPDATE then
        local ServerData = GetWebResult(UPDATE_HOST, "/LucasRPC/BoL-Scripts/version/Kayn.version")
            if ServerData then
                ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
                    if ServerVersion then
                        if tonumber(version) < ServerVersion then
                            DelayAction(function() print("<font color=\"#000000\"> | </font><font color=\"#FF0000\"><font color=\"#FFFFFF\">New version found for Spray and Pray... <font color=\"#000000\"> | </font><font color=\"#FF0000\"></font><font color=\"#FF0000\"><b> Version "..ServerVersion.."</b></font>") end, 3)
                            DelayAction(function() print("<font color=\"#FFFFFF\"><b> >> Updating, please don't press F9 << </b></font>") end, 4)
                            DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () print("<font color=\"#000000\"> | </font><font color=\"#FF0000\"><font color=\"#FFFFFF\">Twitch: </font> <font color=\"#4AA02C\">Spray and Pray</font> <font color=\"#000000\"> | </font><font color=\"#FF0000\">UPDATED <font color=\"#FF0000\"><b>("..version.." => "..ServerVersion..")</b></font> Press F9 twice to load the updated version.") end) end, 5)
                        else
                            DelayAction(function() print("<b><font color=\"#000000\"> | </font><font color=\"#FF0000\"><font color=\"#FFFFFF\">Twitch: </font> <font color=\"#4AA02C\">Spray and Pray</font><font color=\"#000000\"> | </font><font color=\"#FF0000\"><font color=\"#FF0000\"> Version "..ServerVersion.."</b></font>") end, 1)
                        end
                    end
                else
            DelayAction(function() print("<font color=\"#FFFFFF\"> Error while downloading version info, RE-DOWNLOAD MANUALLY.</font>")end, 1)
        end
    end
end
