ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Swep Aléatoires"
ENT.Category = "Swep Aléatoires"
ENT.Spawnable = true

ENT.Model = "models/props_junk/wood_crate002a.mdl"

ENT.randomDistribution = true

ENT.swepList = {
    {
        class = "tfa_rustalpha_mp5",
        chance = 50,
        message = "Vous avez reçu une mp5!"
    },
    {
        class = "tfa_rustalpha_revolver",
        chance = 30,
        message = "Vous avez reçu un revolver!"
    },
    {
        class = "tfa_rustalpha_torch",
        chance = 20,
        message = "Vous avez reçu une torch!"
    }
}

ENT.messageCooldown = 2
ENT.playerCooldowns = {}