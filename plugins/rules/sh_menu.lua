
-----------------------------------------------------
if SERVER then return end
local PLUGIN = PLUGIN

local PANEL = {}

	function PANEL:Init()
		local W, H = self:GetParent():GetSize()
		self:SetPos((ScrW()-W)/2, (ScrH()-H)/1.5)
		--self:SetSize(ScrW() * menuWidth, ScrH() * menuHeight)
		--self:Center()
		self:SetSize(self:GetParent():GetSize())
		self:ShowCloseButton(false)
		--self:MakePopup()
		self:SetTitle(L"Rules")
		
		self.motd = self:Add("HTML")
		self.motd:Dock(FILL)
		self.motd:OpenURL( PLUGIN.url )

	end

	function PANEL:Think()
		if (!self:IsActive()) then
			self:MakePopup()
		end
	end
	
vgui.Register("nut_RULES", PANEL, "DFrame")

function PLUGIN:CreateMenuButtons(tabs)--menu, addButton)
		tabs["Rules"] = function(panel)
			--if removeGuiMenu then nut.gui.menu:Remove() end
			panel:Add("nut_RULES")--vgui.Create("nut_RULES")
		end
end