function vs(t,i)local e="";i=i or"";for k,v in pairs(t)do if type(v)=="table" then e=e..i.."["..k.."]={\n";e=e..vs(v,i.."  ");e=e..i.."}\n";elseif v~=0 then e=e..i.."["..k.."]="..tostring(v).."\n";end end return e end
function spread(t,i)local e="";i=i or"";for k,v in pairs(t)do if type(v)=="table" then e=e..i..k.."={\n";e=e..spread(v,i.."  ");e=e..i.."}\n";else e=e..i..k.."="..tostring(v)..",\n";end end return e end

function log(...)
  runCoroutine(function(...) LogToConsole("`c[9@dreamzzwq Script`]`9>> `0"..table.concat({...}, " : ")) end, ...)
end
function write(name, s)
  local file = io.open("/storage/emulated/0/Android/data/launcher.powerkuy.growlauncher/ScriptLua/"..name, "a+")
  file:write(s.."\n\n")
  file:close()
  return "Done"
end
function sameLine(...)
  for k,v in pairs({...}) do
    ImGui.Text(tostring(v))
    if k ~= #({...}) then ImGui.SameLine() end
  end
end

pkt,raw,var,game = false, false, false, false
savepkt, savevar, saveraw = false, false, false

AddHook(function(dt)
ImGui.Begin("Mita HAck Simple Script By @dreamzzwq")
local sx,x = pcall(function() return GetLocal().posX//32 end)
local sy,y = pcall(function() return GetLocal().posY//32 end)
ImGui.Text("Position")
sameLine("X =", sx and x or 0, "Y =", sy and y or 0)
ImGui.Text("Menu")
if ImGui.Checkbox("Mods Menu", pkt) then
  pkt = not pkt
end
if pkt then
  ImGui.Text("Enabble fly?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
  ImGui.Text("Enabble Anti Gravity?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
  ImGui.Text("Enabble Fast Walk?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
if ImGui.Checkbox("FindPath", raw) then
  raw = not raw
end
if raw then
  ImGui.Text("     Save To PacketRawDebug.lua?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_2", saveraw) then saveraw = not saveraw end
end
if ImGui.Checkbox("Fast", game) then
  if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
  ImGui.SameLine()
  game = not game
end
if game then
  ImGui.Text("     Save To GamePacketRaw.lua?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_3", savegame) then savegame = not savegame end
end
if ImGui.Checkbox("Auto Farm", var) then
  var = not var
end
if var then
  ImGui.Text("     Save To VarlistDebug.lua?")
  ImGui.SameLine()
  if ImGui.Checkbox("##savetofile_4", savevar) then savevar = not savevar end
end
ImGui.Text("Dreamzzwq")
ImGui.End()
end, "onDrawImGui")
AddHook(function(t,s)
  if pkt then log("Type : "..t.."\n"..s) end
  if savepkt then
    write("PacketDebug.lua", "SendPacket("..t..", [["..s.."]])\n\n")
  end
end,"OnSendPacket")
AddHook(function(k)
  if raw then log(spread({pkt = k})) end
  if saveraw then
    write("PacketRawDebug.lua", spread({pkt = k}).."\n\n")
  end
end, "OnSendPacketRaw")
AddHook(function(k)
  if game then log(spread({pkt = k})) end
  if savegame then
    write("GamePacketRaw.lua", "sendPacketRaw(true, {"..spread(k).."})\n\n")
  end
end, "onGamePacket")
AddHook(function(k)
  if var then log(vs(k)) end
  if savevar then
    write("VarlistDebug.lua", vs(k).."\n\n")
  end
end, "OnVariant")