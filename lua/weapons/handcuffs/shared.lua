---------------------------------------------------------------------------|
---------------------------------------------------------------------------|
---------------------------------------------------------------------------|
if SERVER then

	AddCSLuaFile( "shared.lua" )
	
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_body.vmf")
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_body.vtf")
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_claw.vmf")
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_claw.vtf")
	resource.AddFile("models/katharsmodels/handcuffs/handcuffs-1.mdl")
	resource.AddFile("models/katharsmodels/handcuffs/handcuffs-3.mdl")
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_extras.vmf")
	resource.AddFile("materials/katharsmodels/handcuffs/handcuffs_extras.vtf")
	
end



---------------------------------------------------------------------------|
SWEP.Author   	    	= "Buzzofwar"
SWEP.Contact        	= "Buzzofwar"
SWEP.PrintName			= "Menottes"
SWEP.Purpose        	= "Mettez les criminels en deroute"
SWEP.Instructions   	= "Clic gauche pour mettre les menottes. Clic droit pour les enlever."
SWEP.Spawnable      	= true
SWEP.AdminSpawnable 	= true
SWEP.HoldType 			= "none"  
SWEP.Category 			= "Police Pack"    
SWEP.ViewModel      	= "models/katharsmodels/handcuffs/handcuffs-1.mdl"
SWEP.WorldModel   		= "models/weapons/w_stunbaton.mdl"
---------------------------------------------------------------------------|


-----------------------------Primary Info----------------------------------|
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Delay			= 0.9 	
SWEP.Primary.Recoil			= 0	
SWEP.Primary.Ammo         	= "none"	
SWEP.Primary.Damage			= 0	
SWEP.Primary.Cone			= 0 	
SWEP.Primary.ClipSize		= -1	
SWEP.Primary.DefaultClip	= -1	
SWEP.Primary.Automatic   	= false	
-----------------------------Primary Info----------------------------------|

 
----------------------------Secondary Info---------------------------------|
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
----------------------------Secondary Info---------------------------------|


---------------------------------------------------------------------------|
 function SWEP:Reload()
end 
---------------------------------------------------------------------------|


---------------------------------------------------------------------------|
 if ( CLIENT ) then
	function SWEP:GetViewModelPosition( pos, ang )
		ang:RotateAroundAxis( ang:Forward(), 90 ) 
		pos = pos + ang:Forward()*6
		return pos, ang
	end 
end
---------------------------------------------------------------------------|


---------------------------------------------------------------------------|
function SWEP:Think()
end
---------------------------------------------------------------------------|


-----------------------------Initialize------------------------------------|
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	if ( SERVER ) then
    self:SetWeaponHoldType(self.HoldType)
	end
end
-----------------------------Initialize------------------------------------|
function Slow( ply )
    ply:SetWalkSpeed( 50 )
end

-----------------------------PrimaryAttack---------------------------------|
function SWEP:PrimaryAttack()
	local trace = { }
	trace.start = self.Owner:EyePos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 95;
	trace.filter = self.Owner;
		
	
	local tr = util.TraceLine( trace );
	
	if( tr.Entity:IsValid() and ( tr.Entity:IsPlayer() ) ) then
		if( tr.Entity:GetNWBool( "FrozenYay" ) == true ) then
			return; end
		tr.Entity:SetNWBool( "FrozenYay", true )
		self.Owner:PrintMessage(HUD_PRINTCENTER,"Le malfaiteur a été menotté.");
		tr.Entity:PrintMessage(HUD_PRINTCENTER,"Vous avez été menotté.");
		
		tr.Entity:SetWalkSpeed(20)
		tr.Entity:SetRunSpeed(20)
		
	end
end
-----------------------------PrimaryAttack---------------------------------|


----------------------------SecondaryAttack--------------------------------|
function SWEP:SecondaryAttack()
	local trace = { }
	trace.start = self.Owner:EyePos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 95;
	trace.filter = self.Owner;
		
	local tr = util.TraceLine( trace );
		
	if ( tr.Entity:IsValid() and ( tr.Entity:IsPlayer() ) ) then
		if( tr.Entity:GetNWBool( "FrozenYay" ) == true ) then
			tr.Entity:SetNWBool( "FrozenYay", false )
			tr.Entity:SetWalkSpeed(160)
			tr.Entity:SetRunSpeed(240)

		else
			self.Owner:PrintMessage( HUD_PRINTCENTER, "Cette personne n'est pas menottée." );
			tr.Entity:PrintMessage(HUD_PRINTCENTER,"Vous avez été relaché.");
		end
	end
end
----------------------------SecondaryAttack--------------------------------|
---------------------------------------------------------------------------|
---------------------------------------------------------------------------|