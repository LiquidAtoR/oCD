--[[
-- The code is largly based on GTB: http://shadowed-wow.googlecode.com/svn/trunk/GTB/
]]

local fmod, floor, abs, upper, format = math.fmod, math.floor, math.abs, string.upper, string.format

local framePool = {}
local groups = {}

local L = {
	["BAD_ARGUMENT"] = "bad argument #%d for '%s' (%s expected, got %s)",
	["MUST_CALL"] = "You must call '%s' from a registered GTB object.",
	["GROUP_EXISTS"] = "The group '%s' already exists.",
}

local function getFrame()
	-- Check for an unused bar
	if( #(framePool) > 0 ) then
		return table.remove(framePool, 1)
	end

	local frame = CreateFrame"Frame"
	frame:Hide()
	frame:SetParent(UIParent)
	frame:SetBackdrop{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 8,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}
	frame:SetBackdropColor(0, 0, 0)
	frame:SetBackdropBorderColor(1, 1, 1)
	frame:SetFrameStrata("BACKGROUND")
	--cd gloss texture
		local gloss = frame:CreateTexture(nil,"Overlay")
		gloss:SetTexture("Interface\\Addons\\vMinimap\\textures\\glazzed64.tga")
	    gloss:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
	    gloss:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
		  --apply user alpha
		  local r,g,b,a = gloss:GetVertexColor()
		  gloss:SetVertexColor(r,g,b,a)
	
	
	local cd = CreateFrame"Cooldown"
	--cd.noomnicc = true
	cd.noCooldownCount = true
	cd:SetParent(frame)
	-- local glosscd = cd:CreateTexture(nil,"Overlay")
		-- glosscd:SetTexture("Interface\\Addons\\vMinimap\\textures\\glazzed64.tga")
	    -- glosscd:SetPoint("TOPLEFT", cd, "TOPLEFT", 2, -2)
	    -- glosscd:SetPoint("BOTTOMRIGHT", cd, "BOTTOMRIGHT", -2, 2)
	cd:SetBackdrop{
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 6,
		insets = {left = 3, right = 3, top = 3, bottom = 3},
	}
	cd:SetBackdropColor(0, 0, 0, 0)
	cd:SetBackdropBorderColor(1, 1, 1)
	cd:SetFrameStrata("BACKGROUND")	
		

	local font, size = GameFontNormal:GetFont()
	local text = cd:CreateFontString()
	text:SetDrawLayer"OVERLAY"
	--text:SetFont(font, size, "OUTLINE")
	text:SetFont(font, 10, "OUTLINE")
	text:SetTextColor(188/255, 188/255, 188/255)
	-- text:SetPoint("BOTTOM", frame, 1, -2)
	text:SetPoint("LEFT", frame, "RIGHT", 0, 0)
	text:SetJustifyH("LEFT")

	local icon = cd:CreateTexture()
	icon:SetDrawLayer"BACKGROUND"
	icon:SetTexCoord(.07, .93, .07, .93)
	icon:ClearAllPoints()
	icon:SetAllPoints(cd)

	local sb = CreateFrame"StatusBar"
	sb:SetParent(frame)
	sb:SetMinMaxValues(0, 1)
	
	-- All the Children Are Dead
	local OnUpdate
	do
		-- OnUpdate for a bar
		local frequency, timer, forced = 1, 0, true -- first update == LE FORCED!
		local secondsLeft, startSeconds
		local fill, gradients, min, sec, percent
		function OnUpdate(self, elapsed)
			timer = timer + elapsed

			if(timer >= frequency or forced) then
				-- Check if times ran out and that we need to start fading it out
				secondsLeft = secondsLeft - timer
				if(secondsLeft <= 0) then
					frequency = 1
					self.group:UnregisterBar(self.id)
					return
				end

				min, sec = floor(secondsLeft / 60), fmod(secondsLeft, 60)
				if(min > 0) then
					text:SetFormattedText("%d:%02d", min, sec)
					text:SetTextColor(188/255, 188/255, 188/255)
				elseif(sec < 10) then
					frequency = .05
					text:SetFormattedText("%.1f", sec)
					text:SetTextColor(188/255, 188/255, 188/255)
					if(sec < 4) then
						text:SetTextColor(.98, .38, .09)
					end
				else
					text:SetFormattedText("%d", sec)
					text:SetTextColor(188/255, 188/255, 188/255)
				end
		        
				percent = secondsLeft / startSeconds
				-- Color gradient towards red
				if(gradients) then
					-- finalColor + (currentColor - finalColor) * percentLeft
					sb:SetStatusBarColor(1.0 + (self.r - 1.0) * percent, self.g * percent, self.b * percent)
				end

				-- Now update the actual displayed bar
				if(fill) then
					sb:SetValue(1-percent)
				else
					sb:SetValue(percent)
				end

				timer = 0
				if(forced) then forced = nil end
			end
		end

		frame.SetVars = function(s, sl, gr, f)
			if(s) then
				startSeconds = s
				secondsLeft = sl
				forced = true
			end

			gradients = gr
			fill = f
		end
	end

	frame:SetScript("OnUpdate", OnUpdate)

	frame.update = update
	frame.cd = cd
	frame.text = text
	frame.sb = sb
	frame.icon = icon

	return frame
end

local function releaseFrame(frame)
	-- Stop updates
	frame:Hide()

	-- And now read to the frame pool
	table.insert(framePool, frame)
end

-- Reposition the group
local function sortBars(a, b)
	return a.endTime > b.endTime
end

local function getRelativePointAnchor(point)
	point = upper(point)
	if (point == "TOP") then
		return "BOTTOM", 0, -1
	elseif (point == "BOTTOM") then
		return "TOP", 0, 1
	elseif (point == "LEFT") then
		return "RIGHT", 1, 0
	elseif (point == "RIGHT") then
		return "LEFT", -1, 0
	elseif (point == "TOPLEFT") then
		return "BOTTOMRIGHT", 1, -1
	elseif (point == "TOPRIGHT") then
		return "BOTTOMLEFT", -1, -1
	elseif (point == "BOTTOMLEFT") then
		return "TOPRIGHT", 1, 1
	elseif (point == "BOTTOMRIGHT") then
		return "TOPLEFT", -1, 1
	else
		return "CENTER", 0, 0
	end
end

local function repositionFrames(group)
	local bars = #group.usedBars
	-- if we have less bars, we don't need to re-arrange anything.
	if(bars < group.lastUpdate) then return end

	table.sort(group.usedBars, sortBars)
	local frame = group.frame
	local point = frame.point
	local relativePoint, xOffsetMult, yOffsetMult = getRelativePointAnchor(point)
	local xMultiplier, yMultiplier = abs(xOffsetMult), abs(yOffsetMult)
	local xOffset = frame.xOffset
	local yOffset = frame.yOffset
	local columnSpacing = frame.columnSpacing

	local columnMax = frame.columnMax
	local numColumns
	if ( columnMax and bars > columnMax ) then
		numColumns = ceil(bars / columnMax)
	else
		columnMax = bars
		numColumns = 1
	end

	local columnAnchorPoint, columnRelPoint, colxMulti, colyMulti
	if(numColumns > 1) then
		columnAnchorPoint = frame.columnAnchorPoint
		columnRelPoint, colxMulti, colyMulti = getRelativePointAnchor(columnAnchorPoint)
	end

	local columnNum = 1
	local columnCount = 0
	local currentAnchor = group
	for i = 1, bars do
		columnCount = columnCount + 1
		if ( columnCount > columnMax ) then
			columnCount = 1
			columnNum = columnNum + 1
		end

		local bar = group.usedBars[i]
		bar:ClearAllPoints()
		if ( i == 1 ) then
			bar:SetPoint(point, currentAnchor, point, 0, 0)
			if ( columnAnchorPoint ) then
				bar:SetPoint(columnAnchorPoint, currentAnchor, columnAnchorPoint, 0, 0)
			end
		elseif ( columnCount == 1 ) then
			local columnAnchor = group.usedBars[(i - columnMax)]
			bar:SetPoint(columnAnchorPoint, columnAnchor, columnRelPoint, colxMulti * columnSpacing, colyMulti * columnSpacing)
		else
			bar:SetPoint(point, currentAnchor, relativePoint, xMultiplier * xOffset, yMultiplier * yOffset)
		end

		currentAnchor = bar
	end

	group.lastUpdate = bars
end

local display = {
	-- Group related:
	RegisterGroup = function(self, name, ...)
		assert(3, not groups[name], string.format(L["GROUP_EXISTS"], name))
		local obj = CreateFrame"Frame"
		obj:SetParent(UIParen)

		obj.name = name
		obj.bars = {}
		obj.usedBars = {}

		-- Register
		groups[name] = obj

		-- Set defaults
		obj:SetHeight(1)
		obj:SetWidth(1)

		obj.RegisterBar = self.RegisterBar
		obj.UnregisterBar = self.UnregisterBar

		if(select("#", ...) > 0) then
			obj:SetPoint(...)
		else
			obj:SetPoint"CENTER"
		end

		return obj
	end,

	-- Bar related:
	RegisterBar = function(group, id, startTime, seconds, icon, r, g, b)
		assert(3, group.name and groups[group.name], string.format(L["MUST_CALL"], "RegisterBar"))

		-- Already exists, remove the old one quickly
		if( group.bars[id] ) then
			group:UnregisterBar(id)
		end

		-- Retrieve a frame thats either recycled, or a newly created one
		local frame = getFrame()

		-- So we can do sorting and positioning
		table.insert(group.usedBars, frame)

		-- Grab basic info about the font
		local path, size, style = GameFontHighlight:GetFont()
		local textSize = group.text.size
		local timerSize = group.timer.size

		local width, height, point = group.frame.width, group.frame.height, group.statusbar.point
		local mod = (point == "LEFT" and 1) or -1
		frame:SetWidth(width)
		frame:SetHeight(height)

		frame.cd:ClearAllPoints()
		frame.cd:SetPoint(point == "LEFT" and "RIGHT" or "LEFT", -3*mod, 0)
		frame.cd:SetPoint("TOP", 0, -3)
		frame.cd:SetPoint("BOTTOM", 0, 3)
		frame.cd:SetPoint(point == "LEFT" and "LEFT" or "RIGHT", (width-height+3)*mod, 0)

		local sb = frame.sb
		sb:SetPoint("TOP", frame, 0, -3)
		sb:SetPoint("BOTTOM", 0, 3)
		sb:SetPoint(point == "LEFT" and "LEFT" or "RIGHT", 3*mod, 0)
		if(point == "LEFT") then
			sb:SetPoint("RIGHT", frame.cd, "LEFT")
		else
			sb:SetPoint("LEFT", frame.cd, "RIGHT")
		end
		sb:SetOrientation(group.statusbar.orientation)

		-- Set info the bar needs to know
		frame.r = r or group.baseColor.r
		frame.g = g or group.baseColor.g
		frame.b = b or group.baseColor.b
		frame.group = group
		frame.endTime = startTime + seconds
		frame.secondsLeft = startTime - GetTime() + seconds
		frame.startSeconds = seconds
		frame.gradients = group.statusbar.gradients
		frame.fill = group.statusbar.fill
		frame.id = id

		frame.SetVars(seconds, frame.secondsLeft, group.statusbar.gradients, group.statusbar.fill)

		-- Reset last update.
		group.lastUpdate = 0
		-- Reposition this group
		repositionFrames(group)

		-- Start it up
		frame.icon:SetTexture(icon)
		sb:SetStatusBarTexture(group.statusbar.texture)
		sb:SetStatusBarColor(frame.r, frame.g, frame.b)
		sb:SetValue(group.statusbar.fill and 0 or 1)
		frame.cd:SetCooldown(startTime, seconds)
		frame:Show()

		-- Register it
		group.bars[id] = frame
	end,

	UnregisterBar = function(group, id)
		assert(3, group.name and groups[group.name], string.format(L["MUST_CALL"], "UnregisterBar"))

		-- Remove the old entry
		if( group.bars[id] ) then
			-- Remove from list of used bars
			for i=#(group.usedBars), 1, -1 do
				if( group.usedBars[i].id == id ) then
					table.remove(group.usedBars, i)
					break
				end
			end

			releaseFrame(group.bars[id])
			repositionFrames(group)
			group.bars[id] = nil
			return true
		end

		return
	end,
}

oCD.display = display
