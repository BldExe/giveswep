include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("OpenWeaponSelectionMenu", function()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Choisissez votre arme")
    frame:SetSize(300, 200)
    frame:Center()
    frame:MakePopup()

    local swepList = {
        { name = "mp5", class = "tfa_rustalpha_mp5" },
        { name = "revolver", class = "tfa_rustalpha_revolver" },
        { name = "torch", class = "tfa_rustalpha_torch" }
    }

    local listBox = vgui.Create("DComboBox", frame)
    listBox:SetPos(50, 50)
    listBox:SetSize(200, 30)

    for _, swep in ipairs(swepList) do
        listBox:AddChoice(swep.name, swep.class)
    end

    local selectButton = vgui.Create("DButton", frame)
    selectButton:SetText("Choisir l'arme")
    selectButton:SetPos(100, 100)
    selectButton:SetSize(100, 30)

    selectButton.DoClick = function()
        local _, swepClass = listBox:GetSelected()
        if swepClass then
            net.Start("SelectWeapon")
            net.WriteString(swepClass)
            net.SendToServer()
            frame:Close()
        else
            LocalPlayer():ChatPrint("Veuillez choisir une arme.")
        end
    end
end)
