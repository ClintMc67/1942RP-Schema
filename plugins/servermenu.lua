
-----------------------------------------------------
PLUGIN.name = "Server Selector Menu"
PLUGIN.desc = "A menu to let players connect to another server in-game"
PLUGIN.author = "Robert Bearson"

--Settings
local servers = {}
servers[1] = {
	name = "Vacant Server",
	ip = "1"
}

servers[2] = {
	name = "Vacant Server",
	ip = "2"
}

--The command...
nut.command.add("servers", {
	syntax = "",
	onRun = function(ply, args)
		netstream.Start(ply, "openServersMenu", servers)
	end,
})

--Das Menu
if CLIENT then
	netstream.Hook("openServersMenu", function(servers)
		local frame = vgui.Create("DFrame")
		frame:SetSize(600,450)
		frame:Center()
		frame:MakePopup()
		frame:SetTitle("")
		frame:SetAlpha(0)
		frame:AlphaTo(255,0.2)
		function frame:Paint(w,h)
			nut.util.drawBlur(self, 10)
			draw.RoundedBox(4,0,0,w,h,Color(30,30,30,200))
		end
		function frame:OnKeyCodePressed(key)
			if key == KEY_F1 then
				self:Remove()
			end
		end

		frame.title = frame:Add("DLabel")
		frame.title:SetText("SERVERS")
		frame.title:SetColor(color_white)
		frame.title:SetFont("nutMediumFont")
		frame.title:SizeToContents()
		frame.title:SetPos(0,10)
		frame.title:CenterHorizontal()

		frame.scroll = frame:Add("DScrollPanel")
		frame.scroll:SetSize(frame:GetWide(), frame:GetTall()-(20+frame.title:GetTall()))
		frame.scroll:SetPos(0,20+frame.title:GetTall())

		frame.list = frame.scroll:Add("DIconLayout")
		frame.list:SetSize(frame.scroll:GetSize())

		for k,v in pairs(servers) do
			local s = frame.list:Add("DPanel")
			s:SetSize((frame.list:GetWide()/#servers),frame.list:GetTall())
			function s:Paint(w,h)
				if self:IsHovered() or self.hovered then
					draw.RoundedBoxEx(4,0,0,w,h,Color(40,40,40,175),false,false,true,true)
				else
					draw.RoundedBoxEx(4,0,0,w,h,Color(34,35,35,175),false,false,true,true)
				end
			end

			s.name = s:Add("DLabel")
			s.name:SetText(v.name)
			s.name:SetColor(color_white)
			s.name:SetFont("nutBigFont")
			s.name:SizeToContents()
			s.name:CenterHorizontal()
			s.name:CenterVertical(0.2)

			s.join = s:Add("DButton")
			s.join:SetSize(s:GetWide(), 60)
			s.join:SetText("JOIN")
			s.join:SetFont("nutMediumFont")
			s.join:Dock(BOTTOM)
			function s.join:Paint(w,h)
				if self:IsHovered() then
					self:GetParent().hovered = true
					draw.RoundedBoxEx(4,0,0,w,h, Color(48,140,247),false,false,true,true)
				else
					draw.RoundedBoxEx(4,0,0,w,h,Color(30,30,30),false,false,true,true)
				end
			end
			function s.join:DoClick()
				LocalPlayer():ConCommand("connect " .. v.ip)
			end
		end
	end)
end
