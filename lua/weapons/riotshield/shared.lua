-----------------------------------------------------------------------------------------|
-----------------------------By BuzzOfwar------------------------------------------------|
-----------------------------------------------------------------------------------------|
SWEP.WorldModel = "models/Items/AR2_Grenade.mdl"
SWEP.ViewModel = "models/hunter/plates/plate025x025.mdl"
SWEP.Category = "Police Pack"    
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.HoldType = "slam"  
SWEP.Author = "Fisk"
SWEP.Contact = "Fisk"
SWEP.Purpose = "Hold"
SWEP.Instructions = "Look Forward Dont move And Deploy it"
-----------------------------------------------------------------------------------------|
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize  = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic  = true

SWEP.Secondary.ClipSize 	= -1                    
SWEP.Secondary.Delay 		= 0.7              
SWEP.Secondary.Ammo 		= "none"

-----------------------------------------------------------------------------------------|
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	if ( SERVER ) then
    self:SetWeaponHoldType(self.HoldType)
	end
end
-----------------------------------------------------------------------------------------|
function SWEP:Deploy()
	if SERVER then
		self.ent = ents.Create("prop_physics")
			self.ent:SetModel("models/arleitiss/riotshield/shield.mdl")
			self.ent:SetPos(self.Owner:GetPos() + Vector(0,0,7) + (self.Owner:GetForward()*20))
			self.ent:SetAngles(Angle(0,self.Owner:EyeAngles().y,self.Owner:EyeAngles().r))
			self.ent:SetParent(self.Owner)
			self.ent:SetCollisionGroup( COLLISION_GROUP_WORLD ) 
			self.ent:Fire("SetParentAttachmentMaintainOffset", "chest", 0) 
			self.ent:Spawn()
			self.ent:Activate()
	end
	return true
end
-----------------------------------------------------------------------------------------|
function SWEP:Holster()
	if SERVER then
		self.ent:Remove()
		return true
	end
end
-----------------------------------------------------------------------------------------|
function SWEP:OnDrop()
	if SERVER then
		self.ent:Remove()
	end
end

-----------------------------------------------------------------------------------------|
if SERVER then
	AddCSLuaFile("shared.lua")
	
	resource.AddFile("materials/arleitiss/riotshield/shield_edges.vmt")
	resource.AddFile("materials/arleitiss/riotshield/shield_glass.vmt")
	resource.AddFile("materials/arleitiss/riotshield/shield_grip.vmt")
	resource.AddFile("materials/arleitiss/riotshield/shield_gripbump.vtf")
	resource.AddFile("models/arleitiss/riotshield/shield.mdl")
	resource.AddFile("materials/arleitiss/riotshield/riot_metal.vmt")
	resource.AddFile("materials/arleitiss/riotshield/riot_metal_bump.vtf")
	resource.AddFile("materials/arleitiss/riotshield/shield_cloth.vmt")

end
-----------------------------------------------------------------------------------------|
if CLIENT then
	SWEP.PrintName = "RiotShield"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

-----------------------------------------------------------------------------------------|
function getChestPosAng(Chest)
    local attachmentID=Chest:LookupAttachment("chest");
    return Chest:GetAttachment(attachmentID)
end
-----------------------------------------------------------------------------------------|