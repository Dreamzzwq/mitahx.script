----created for doremita----
LogToConsole("`0[`2Starting`0]`o[`2Script `cby `4dreamzzwq`]")
growtopia.notify("`2Start `4Script")
----Patokan----
tw = "doremita"----ambil di world name
tx = 1701 -----ambil cor x
ty = 1698 -----ambil cor y
dw = "doredorebreaksmw:mmk"-----drop world name
dx = 410 -----drop cor x
dy = 738 -----drop cor y
blockid = 0 -----ID Block you want to move
delay = 500 -----delay findpath
----Script----
 function warp(worldname)
    SendPacket(3, "action|join_request\nname|"..worldname.."\ninvitedWorld|0")
    Sleep(4000)
end

 function inv(item)
    for _, object in pairs(GetInventory()) do
        if object.id == item then
            return object.amount
        end
    end
    return 0
end

function drop()
SendPacket(2,"action|drop\n|itemID|"..blockid)
SendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|"..blockid.."|\ncount|200")
end

function take()
if inv(blockid) >= 200 then
    warp(dw)
    FindPath(dx,dy)
    sleep(delay)
    drop(blockid)
    elseif inv(blockid) < 200 then
        warp(tw)
        FindPath(tx,ty)
        sleep(delay)
    end
end

while true do
pcall(take(), 1)
end