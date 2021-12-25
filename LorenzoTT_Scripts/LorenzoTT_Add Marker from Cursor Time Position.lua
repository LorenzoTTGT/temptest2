--[[
ReaScript name: LorenzoTT_Cursor Time Position To Marker
Version: 1.0
Author: LorenzoTT
]]

local cursPosSecs = reaper.GetCursorPosition()
local cursPosHHMMSS = reaper.format_timestr(cursPosSecs,"...")

reaper.AddProjectMarker(0,false,cursPosSecs,0,cursPosHHMMSS,-1)

