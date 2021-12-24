
--[[
ReaScript name: Multi Format Render
Version: 1.0
Author: LorenzoTT
Version: 1.0
Changelog: Initial release
Licence: WTFPL
REAPER: at least v5.962
]]

-- Script generated by Lokasenna's GUI Builder


local lib_path = reaper.GetExtState("Lokasenna_GUI", "lib_path_v2")
if not lib_path or lib_path == "" then
    reaper.MB("Couldn't load the Lokasenna_GUI library. Please install 'Lokasenna's GUI library v2 for Lua', available on ReaPack, then run the 'Set Lokasenna_GUI v2 library path.lua' script in your Action List.", "Whoops!", 0)
    return
end
loadfile(lib_path .. "Core.lua")()




GUI.req("Classes/Class - Textbox.lua")()
GUI.req("Classes/Class - Options.lua")()
GUI.req("Classes/Class - Button.lua")()


-- If any of the requested libraries weren't found, abort the script.
if missing_lib then return 0 end

GUI.name = "Multi Format Renders"
GUI.x, GUI.y, GUI.w, GUI.h = 0, 0, 520, 250
GUI.anchor, GUI.corner = "mouse", "C"




--My Script----------------------------------------------------

--include external API
dofile(reaper.GetResourcePath().."/UserPlugins/ultraschall_api.lua")

--Variable Definitions
retval, projectTitle = reaper.GetSetProjectInfo_String(nil, "PROJECT_TITLE", "no", 0)
retval, projectName = reaper.GetSetProjectInfo_String(nil, "PROJECT_NAME", "no", 0)
local projectSR = reaper.GetSetProjectInfo( 0, "PROJECT_SRATE", 0, false )
local projectSR_INT = math.floor(projectSR)
local projectSR_short = string.sub(tostring(projectSR_INT), 1, 2)
--/ local FileNameWCPattern = "$region$track" /--
local presetFilepath = reaper.GetResourcePath().."/Scripts/LorenzoTT/(PRESETFILE_DONT OPEN!)_MultiRenderFormat_FileNamePattern.txt"
local _, AllRegionsAttr = ultraschall.GetAllRegions()


--Poroject filepath
local projectFilePath=""
proj, projectFilePath=reaper.EnumProjects(-1, projectFilePath)
local projectFilePathNoName = projectFilePath:gsub(projectName, "")

local OutputFilepath = projectFilePathNoName .. projectTitle .. " - MASTERED" .. "/" .. projectTitle

local PQSheet_Filepath = projectFilePathNoName .. "PQ-Sheet" .. " - " .. projectTitle .. ".pdf"
local PQSheet_name = "PQ SHEET" .. projectTitle


--Output FilePaths
local OutputFilepathWAV4424 = OutputFilepath .. " - " .. "WAV_4424"
local OutputFilepathWAV4416 = OutputFilepath .. " - " .. "WAV_4416"
local OutputFilepathWAV4824 = OutputFilepath .. " - " .. "WAV_4824"
local OutputFilepathWAV4816 = OutputFilepath .. " - " .. "WAV_4816"
local OutputFilepathWAVProjSR24 = OutputFilepath .. " - " .. "WAV_" ..  projectSR_short .. "24"
local OutputFilepathWAVProjSR16 = OutputFilepath .. " - " .. "WAV_" ..  projectSR_short .. "16"
local OutputFilepathMP3320CBR = OutputFilepath .. " - " .. "MP3_320_CBR"
local OutputFilepathMP3320CVBR = OutputFilepath .. " - " .. "MP3_320_VBR"

--RenderStrings
local toWAV24 = ultraschall.CreateRenderCFG_WAV(2, 2 , 3, 0, false)

local toWAV16 = ultraschall.CreateRenderCFG_WAV(1, 2 , 3, 0, false)

local toMP3320CBR = ultraschall.CreateRenderCFG_MP3CBR(16, 0, false, false)

local toMP3320VBR = ultraschall.CreateRenderCFG_MP3VBR(10, 0, false, false)

                                                    
                                                    
--GUI STUFF-------------------------- 

local function gorenderst()

    local FileNameWCPattern = GUI.Val("File Name Pattern $") 
    _ = ultraschall.WriteValueToFile(presetFilepath, FileNameWCPattern, false, nil)
    local sel_WAVformat = GUI.Val("WAV Renders") 
    local sel_RenderFormats = GUI.Val("Render Selected Formats")
    local sel_DDP_Render = GUI.Val("DDP Render") 
    local sel_PQsheet = GUI.Val("PQ Sheet")
    local sel_MP3format = GUI.Val("MP3 Renders")
    local number_of_all_regions, allregionsarray = ultraschall.GetAllRegionsBetween(nil, nil, nil)
    
    --RenderTAbles
    local OutputWAV4424 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAV4424, FileNameWCPattern, 44100,
                                                        2, 0, true, 9, false, false, 4&8, toWAV24, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
    
    local OutputWAV4416 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAV4416,FileNameWCPattern, 44100,
                                                        2, 0, true, 9, false, false, 4&8, toWAV16, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
                                                        
    local OutputWAV4824 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAV4824,FileNameWCPattern, 48000,
                                                        2, 0, true, 9, false, false, 4&8, toWAV24, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
    
    local OutputWAV4816 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAV4816, FileNameWCPattern, 48000,
                                                        2, 0, true, 9, false, false, 4&8, toWAV16, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
                                                        
    local OutputWAVProjSR24 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAVProjSR24,FileNameWCPattern, projectSR_INT,
                                                        2, 0, true, 9, false, false, 4&8, toWAV24, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
                                                        
    local OutputWAVProjSR16 = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathWAVProjSR16,FileNameWCPattern, projectSR_INT,
                                                        2, 0, true, 9, false, false, 4&8, toWAV16, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
    
    local OutputMP3320CBR = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathMP3320CBR,FileNameWCPattern, projectSR_INT,
                                                        2, 0, true, 9, false, false, 4&8, toMP3320CBR, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
                                                        
    local OutputMP3320VBR = ultraschall.CreateNewRenderTable(8, 3, 0, 0, 18, 1000, OutputFilepathMP3320VBR,FileNameWCPattern, projectSR_INT,
                                                        2, 0, true, 9, false, false, 4&8, toMP3320VBR, false, false, false, false,
                                                        0, true, false, "", false, false, true, false, false, 
                                                        3, false, 24)
    
    
    if (sel_WAVformat[1] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputWAV4416, false, true, false) 
    end

    if (sel_WAVformat[2] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputWAV4424, false, true, false) 
    end

    if (sel_WAVformat[3] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputWAV4816, false, true, false) 
    end

    if (sel_WAVformat[4] == true) 
        then count4824,mediachunck4824,filearray4824 = ultraschall.RenderProject_RenderTable(nil, OutputWAV4824, false, true, false) 
        reaper.ShowConsoleMsg(tostring(mediachunck4824[1]))
    end

    if (sel_WAVformat[5] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputWAVProjSR16, false, true, false) 
    end

    if (sel_WAVformat[6] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputWAVProjSR24, false, true, false) 
    end

    if (sel_MP3format[1] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputMP3320CBR, false, true, false) 
    end

    if (sel_MP3format[2] == true) 
        then _,_,_ = ultraschall.RenderProject_RenderTable(nil, OutputMP3320VBR, false, true, false) 
    end
    
 
    if (sel_PQsheet == true) 
    then 
    _ = ultraschall.WriteValueToFile(PQSheet_Filepath, "" , false, nil)
    for region_i = 1, number_of_all_regions
                do region_i_length = allregionsarray[region_i][1] - allregionsarray[region_i][0]
                    region_i_name = allregionsarray[region_i][2]
                    region_i_index = allregionsarray[region_i][3]
                    trackNameToWrite = tostring(region_i_index) .. " - " .. region_i_name .. " " .. tostring(reaper.format_timestr(math.floor(region_i_length), "")):sub(1, -5)
                    _ = ultraschall.WriteValueToFile(PQSheet_Filepath, "s" , false, true)
                    _ = ultraschall.WriteValueToFile_Insert(PQSheet_Filepath, region_i , trackNameToWrite)
                  

                end
               
    end
end
    


GUI.New("WAV Renders", "Checklist", {
    z = 11,
    x = 16,
    y = 64,
    w = 200,
    h = 170,
    caption = "WAV Renders",
    optarray = {"WAV 4416", "WAV 4424", "WAV 4816", "WAV 4824", "WAV ($ProjectSampleRate)16", "WAV ($ProjectSampleRate)24"},
    dir = "v",
    pad = 4,
    font_a = 2,
    font_b = 3,
    col_txt = "txt",
    col_fill = "elm_fill",
    bg = "wnd_bg",
    frame = true,
    shadow = true,
    swap = nil,
    opt_size = 20
})

GUI.New("Render Selected Formats", "Button", {
    z = 11,
    x = 240,
    y = 208,
    w = 260,
    h = 24,
    caption = "Render Selected Formats",
    font = 2,
    col_txt = "black",
    col_fill = "white",
    func = gorenderst
})


GUI.New("MP3 Renders", "Checklist", {
    z = 11,
    x = 242,
    y = 64,
    w = 120,
    h = 70,
    caption = "MP3 Renders",
    optarray = {"MP3 320 CBR", "MP3 320 VBR"},
    dir = "v",
    pad = 4,
    font_a = 2,
    font_b = 3,
    col_txt = "txt",
    col_fill = "elm_fill",
    bg = "wnd_bg",
    frame = true,
    shadow = true,
    swap = nil,
    opt_size = 20
})

GUI.New("DDP Render", "Checklist", {
    z = 11,
    x = 388,
    y = 64,
    w = 110,
    h = 50,
    caption = "DDP Render",
    optarray = {"DDP 4416"},
    dir = "v",
    pad = 4,
    font_a = 2,
    font_b = 3,
    col_txt = "txt",
    col_fill = "elm_fill",
    bg = "wnd_bg",
    frame = true,
    shadow = true,
    swap = nil,
    opt_size = 20
})

GUI.New("PQ Sheet", "Checklist", {
    z = 11,
    x = 388,
    y = 140,
    w = 110,
    h = 50,
    caption = "PQ Sheet",
    optarray = {"to .pdf"},
    dir = "v",
    pad = 4,
    font_a = 2,
    font_b = 3,
    col_txt = "txt",
    col_fill = "elm_fill",
    bg = "wnd_bg",
    frame = true,
    shadow = true,
    swap = nil,
    opt_size = 20
})

GUI.New("File Name Pattern $", "Textbox", {
    z = 11,
    x = 128,
    y = 16,
    w = 370,
    h = 20,
    caption = "File Name Pattern $ : ",
    cap_pos = "left",
    font_a = 3,
    font_b = "monospace",
    color = "txt",
    bg = "wnd_bg",
    shadow = true,
    pad = 4,
    undo_limit = 20
})

tempFilnamePresetPath = ultraschall.ReadValueFromFile(presetFilepath,test45646446)

if tempFilnamePresetPath == nil then 
    FileNameWCPattern = "$region$track"
else FileNameWCPattern = tempFilnamePresetPath 
end 

GUI.Val("File Name Pattern $", FileNameWCPattern)



GUI.Init()
GUI.Main()
