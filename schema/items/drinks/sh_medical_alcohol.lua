
-----------------------------------------------------
ITEM.name = "75% Isopropyl Alcohol"
ITEM.category = "Medical Products"
ITEM.desc = "Alcohol used for disinfection. Non-toxic."
ITEM.model = "models/props_junk/garbage_glassbottle003a.mdl"
ITEM.uniqueID = "morphine"
ITEM.price = 10
ITEM.permit = "medical"
ITEM.hunger = 0
ITEM.thirst = 30
ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	onRun = function(item)
		item.player:SetHealth(math.min(item.player:Health() + 20, 110))
	end
}