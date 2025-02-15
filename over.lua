pkt, raw, var, game = false, false, false, false
savepkt, savevar, saveraw, savegame = false, false, false, false

function sameLine(...)
  for k,v in pairs({...}) do
    ImGui.Text(tostring(v))
    if k ~= #({...}) then ImGui.SameLine() end
  end
end

AddHook(function(dt)
  ImGui.Begin("ImGui Packet Var Debugger By Erzy.sh")
  local sx,x = pcall(function() return GetLocal().posX//32 end)
  local sy,y = pcall(function() return GetLocal().posY//32 end)
  ImGui.Text("Position")
  sameLine("X =", sx and x or 0, "Y =", sy and y or 0)
  ImGui.Text("Debugger")
  if ImGui.Checkbox("Packet Text", pkt) then
    pkt = not pkt
  end
  if pkt then
    ImGui.Text("     Save To PacketDebug.lua?")
    ImGui.SameLine()
    if ImGui.Checkbox("##savetofile_1", savepkt) then savepkt = not savepkt end
  end
  if ImGui.Checkbox("Packet Raw", raw) then
    raw = not raw
  end
  if raw then
    ImGui.Text("     Save To PacketRawDebug.lua?")
    ImGui.SameLine()
    if ImGui.Checkbox("##savetofile_2", saveraw) then saveraw = not saveraw end
  end
  if ImGui.Checkbox("Game Packet Raw", game) then
    game = not game
  end
  if game then
    ImGui.Text("     Save To GamePacketRaw.lua?")
    ImGui.SameLine()
    if ImGui.Checkbox("##savetofile_3", savegame) then savegame = not savegame end
  end
  if ImGui.Checkbox("Variant List", var) then
    var = not var
  end
  if var then
    ImGui.Text("     Save To VarlistDebug.lua?")
    ImGui.SameLine()
    if ImGui.Checkbox("##savetofile_4", savevar) then savevar = not savevar end
  end
  ImGui.Text("ImGui Packet and Varlist Debugger by Erzy.sh.\nThis is simple example script for using ImGui API\nand Hooks in Growlauncher.")
  ImGui.End()
end, "onDrawImGui")