--[[-------------------------------------------------------------------------
  Copyright (c) 2006-2008, Trond A Ekseth
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of oCD nor the names of its contributors may
        be used to endorse or promote products derived from this
        software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]

local db = {
	spells = {
		
--RACIALS
		["Shadowmeld"] = true,
		["Escape Artist"] = true,
		["Gift of the Naaru"] = true,
		["Stoneform"] = true,
		["Arcane Torrent"] = true,
		["Berserking"] = true,
		["Blood Fury"] = true,
		["Cannibalize"] = true,
		["Mana Tap"] = true,
		["War Stomp"] = true,
		["Will of the Forsaken"] = true,
		["Every Man for Himself"] = true,
		["Lifebloom"] = true,
--DRUID
		["Barkskin"] = true,
		["Thorns"] = true,
		["Nature's Grasp"] = true,
		["Tree of Life"] = true,
		["Nature's Swiftness"] = true,
		["Swiftmend"] = true,
		["Rebirth"] = true,
		["Innervate"] = true,
		["Tranquility"] = true,
		["Hurricane"] = true,
		["Dash"] = true,
		["Prowl"] = true,
		["Cower"] = true,
		["Feral Charge (Cat)"] = true,
		["Tiger's Fury"] = true,
		["Mangle (Cat)"] = true,
		["Skull Bash (Cat)"] = true,
		["Stampeding Roar (Cat)"] = true,
		["Challenging Roar"] = true,
		["Growl"] = true,
		["Enrage"] = true,
		["Bash"] = true,
		["Feral Charge (Bear)"] = true,
		["Mangle (Bear)"] = true,
		["Skull Bash (Bear)"] = true,
		["Stampeding Roar (Bear)"] = true,
		["Swipe (Bear)"] = true,
		["Survival Instincts"] = true,
		["Frenzied Regeneration"] = true,
		["Trash"] = true,
--HUNTER
		["Feed Pet"] = true,
		["Kill Command"] = true,
		["Master's Call"] = true,
		["Concussive Shot"] = true,
		["Kill Shot"] = true,
		["Distractive Shot"] = true,
		["Scatter Shot"] = true,
		["Flare"] = true,
		["Rapid Fire"] = true,
		["Raptor Strike"] = true,
		["Deterrence"] = true,
		["Feign Death"] = true,
		["Misdirection"] = true,
		["Immolation Trap"] = true,
		["Freezing Trap"] = true,
		["Explosive Trap"] = true,
		["Ice Trap"] = true,
		["Snake Trap"] = true,
		["Camouflage"] = true,
--MAGE
		["Blast Wave"] = true,
		["Dragon's Breath"] = true,
		["Fire Blast"] = true,
		["Fire Ward"] = true,
		["Combustion"] = true,
		["Invisibility"] = true,
		["Presence of Mind"] = true,
		["Arcane Power"] = true,
		["Counterspell"] = true,
		["Evocation"] = true,
		["Blink"] = true,
		["Icy Veins"] = true,
		["Frost Nova"] = true,
		["Cold Snap"] = true,
		["Ice Block"] = true,
		["Cone of Cold"] = true,
		["Summon Water Elemental"] = true,
		["Blink"] = true,
		["Mana Shield"] = true,
		["Flame Orb"] = true,
		["Ring of Frost"] = true,
		["Time Warp"] = true,
--WARRIOR
		["Bloodthirst"] = true,
		["Intervene"] = true,
		["Mortal Strike"] = true,
		["Shield Slam"] = true,
		["Intercept"] = true,
		["Thunder Clap"] = true,
		["Mocking Blow"] = true,
		["Shield Bash"] = true,
		["Spell Reflection"] = true,
		["Revenge"] = true,
		["Overpower"] = true,
		["Pummel"] = true,
		["Charge"] = true,
		["Whirlwind"] = true,
		["Berserker Rage"] = true,
		["Death Wish"] = true,
		["Concussion Blow"] = true,
		["Sweeping Strikes"] = true,
		["Challenging Shout"] = true,
		["Last Stand"] = true,
		["Disarm"] = true,
		["Shield Block"] = true,
		["Taunt"] = true,
		["Recklessness"] = true,
		["Shield Wall"] = true,
		["Blink"] = true,
		["Retaliation"] = true,
--PALADIN
		["Holy Shock"] = true,
		["Judgement"] = true,
		["Divine Protection"] = true,
		["Hammer of Justice"] = true,
		["Blessing of Protection"] = true,
		["Lay on Hands"] = true,
		["Righteous Defense"] = true,
		["Blessing of Freedom"] = true,
		["Consecration"] = true,
		["Exorcism"] = true,
		["Turn Undead"] = true,
		["Divine Favor"] = true,
		["Divine Intervention"] = true,
		["Divine Shield"] = true,
		["Holy Shield"] = true,
		["Repentance"] = true,
		["Hammer of Wrath"] = true,
		["Blessing of Sacrifice"] = true,
		["Avenger's Shield"] = true,
		["Crusader Strike"] = true,
		["Divine Illumination"] = true,
		["Holy Wrath"] = true,
		["Turn Evil"] = true,
		["Avenging Wrath"] = true,
		["Lay on Hands"] = true,
--WARLOCK
		["Death Coil"] = true,
		["Howl of Terror"] = true,
		["Fel Domination"] = true,
		["Summon Infernal"] = true,
		["Summon Doomguard"] = true,
		["Demonic Empowerment"] = true,
		["Demonic Rebirth"] = true,
		["Ritual of Souls"] = true,
		["Ritual of Summoning"] = true,
		["Shadow Ward"] = true,
		["Soulshatter"] = true,
		["Shadowburn"] = true,
		["Soul Fire"] = true,
		["Shadowfury"] = true,
		["Conflagrate"] = true,
		["Chaos Bolt"] = true,
		["Metamorphosis"] = true,
		["Demon Leap (Demon)"] = true,
		["Immolation Aura (Demon)"] = true,
		["Soulburn"] = true,
		["Soul Harvest"] = true,
		["Demonic Circle: Teleport"] = true,
		["Demon Soul (Demon)"] = true,
		["Haunt"] = true,
		["Hand of Gul'dan"] = true,
		["Nether Ward"] = true,
--ROGUE
		["Gouge"] = true,
		["Kidney Shot"] = true,
		["Vanish"] = true,
		["Blind"] = true,
		["Sprint"] = true,
		["Evasion"] = true,
		["Cloak of Shadow"] = true,
		["Kick"] = true,
		["Cold Blood"] = true,
		["Premeditation"] = true,
		["Blade Furry"] = true,
		["Adrenaline Rush"] = true,
		["Shadowstep"] = true,
		["Riposte"] = true,
		["Ghostly Strike"] = true,
--PRIEST
		["Symbol of Hope"] = true,
		["Consume Magic"] = true,
		["Elune's Grace"] = true,
		["Desperate Prayer"] = true,
		["Chastise"] = true,
		["Fear Ward"] = true,
		["Power Infusion"] = true,
		["Pain Suppression"] = true,
		["Lightwell"] = true,
		["Prayer of Mending"] = true,
		["Silence"] = true,
		["Vampiric Touch"] = true,
		["Shadow Word: Death"] = true,
		["Psychic Scream"] = true,
		["Shadowfiend"] = true,
		["Mind Blast"] = true,
		["Fade"] = true,
--SHAMAN
		["Bloodlust"] = true,
		["Heroism"] = true,
		["Chain Lightining"] = true,
		["Earth Shock"] = true,
		["Earthbind Totem"] = true,
		["Elemental Mastery"] = true,
		["Fire Elemental Totem"] = true,
		["Fire Nova Totem"] = true,
		["Flame Shock"] = true,
		["Frost Shock"] = true,
		["Stoneclaw Totem"] = true,
		["Astral Recall"] = true,
		["Earth Elemental Totem"] = true,
		["Grounding Totem"] = true,
		["Shamanistic Rage"] = true,
		["Stormstrike"] = true,
		["Mana Tide Totem"] = true,
		["Nature's Swiftness"] = true,
		["Riptide"] = true,
		["Reincarnation"] = true,		
	},

	items = {
		--["Icon of the Silver Crescent"] = true,
		--["Mana Emerald"] = true,
	},
	settings = {
		-- statusbar
		statusbar = {
			point = "LEFT",
			fill = true,
			gradients = true,
			orientation = "VERTICAL",
			texture = [[Interface\AddOns\oCD\textures\smooth]],
		},
		frame = {
			width = 30,
			height = 26,
			scale = 0.9,
			point = "TOP",
			xOffset = 5,
			yOffset = -1,
			columnSpacing = 0,
			columnMax = 12,
			columnAnchorPoint = "LEFT",
		},
		timer = {
			size = 11,
		},
		text = {
			size = 11,
		},
	},
}

local addon = CreateFrame"Frame"
local print = function(...) ChatFrame1:AddMessage(...) end
local printf = function(...) ChatFrame1:AddMessage(string.format(...)) end

local tip = CreateFrame"GameTooltip"
tip:SetOwner(WorldFrame, "ANCHOR_NONE")
tip.r, tip.l = {}, {}

for i=1,3 do
	tip.l[i], tip.r[i] = tip:CreateFontString(nil, nil, "GameFontNormal"), tip:CreateFontString(nil, nil, "GameFontNormal")
	tip:AddFontStrings(tip.l[i], tip.r[i])
end

local SetSpell = function(id, type)
	tip:ClearLines()
	tip:SetSpell(id, type)
end

-- TODO: This should be the defaults of ../locale/enUS.lua.
local min = SPELL_RECAST_TIME_MIN:gsub("%%%.3g", "%(%%d+%%.?%%d*%)")
local sec = SPELL_RECAST_TIME_SEC:gsub("%%%.3g", "%(%%d+%%.?%%d*%)")

function addon:PLAYER_LOGIN()
	self.group = self.display:RegisterGroup("oCD", "CENTER", UIParent, -140, 170)
	for k, v in pairs(db.settings) do
		self.group[k] = v
	end

	self.group:SetBackdropColor(0, 0, 0)
	self.group:SetBackdropBorderColor(0, 0, 0)

	self.group:SetHeight(18 * 3)
	self.group:SetWidth(18 * 2)
end

function addon:parseSpellBook(type)
	local i = 1
	while true do
		local name = GetSpellName(i, type)
		local next = GetSpellName(i+1, type)
		if(not name) then break end
		
		if(name ~= next) then
			SetSpell(i, type)

			local line = tip.r[3]:GetText() or tip.r[2]:GetText()
			if(line and (line:match(sec) or line:match(min))) then
				spells[name] = line:match(sec) or line:match(min)*60
			end
		end

		i = i + 1
	end
end


function addon:SPELL_UPDATE_COOLDOWN()
	for name, obj in pairs(db.spells) do
		local startTime, duration, enabled = GetSpellCooldown(name)

		if(enabled == 1 and duration > 1.5) then
			self.group:RegisterBar(name, startTime, duration, GetSpellTexture(name), 0, 1, 0)
		elseif(enabled == 1) then
			self.group:UnregisterBar(name)
		end
	end
end

function addon:BAG_UPDATE_COOLDOWN()
	for item, obj in pairs(db.items) do
		local startTime, duration, enabled = GetItemCooldown(item)
		if(enabled == 1) then
			self.group:RegisterBar(item, startTime, duration, select(10, GetItemInfo(item)), 0, 1, 0)
		end
	end
end

addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

addon:RegisterEvent"PLAYER_LOGIN"
addon:RegisterEvent"SPELL_UPDATE_COOLDOWN"
-- TODO: Only register if we actually are watching a cooldown in the container.
addon:RegisterEvent"BAG_UPDATE_COOLDOWN"

_G.oCD = addon
