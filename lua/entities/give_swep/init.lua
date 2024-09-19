AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

local function GiveRandomSWEP(ply, ent)
    local randomValue = math.random(100)
    local cumulativeChance = 0

    for _, swepData in ipairs(ent.swepList) do
        cumulativeChance = cumulativeChance + swepData.chance
        if randomValue <= cumulativeChance then
            local swepClass = swepData.class
            local message = swepData.message or "Vous avez reçu une arme."

            if not ply:HasWeapon(swepClass) then
                ply:Give(swepClass)
                ply:ChatPrint(message)
                return true
            else
                ply:ChatPrint("Vous avez déjà cette arme.")
                return false
            end
        end
    end
end

util.AddNetworkString("OpenWeaponSelectionMenu")

function ENT:OpenWeaponMenu(ply)
    net.Start("OpenWeaponSelectionMenu")
    net.Send(ply)
end

function ENT:Use(ply)
    if not self.playerCooldowns[ply] then
        self.playerCooldowns[ply] = 0
    end

    if CurTime() > self.playerCooldowns[ply] then
        if self.randomDistribution then
            if GiveRandomSWEP(ply, self) then
                self:Remove()
            end
        else
            self:OpenWeaponMenu(ply)
        end
        self.playerCooldowns[ply] = CurTime() + self.messageCooldown
    end
end

util.AddNetworkString("SelectWeapon")

net.Receive("SelectWeapon", function(len, ply)
    local swepClass = net.ReadString()

    if swepClass and not ply:HasWeapon(swepClass) then
        ply:Give(swepClass)
        ply:ChatPrint("Vous avez choisi " .. swepClass .. " !")
    else
        ply:ChatPrint("Vous avez déjà cette arme.")
    end
end)
