local E, L, V, P, G = unpack(select(2, ...))
local UF = E:GetModule("UnitFrames")

local unpack = unpack

local CreateFrame = CreateFrame

function UF:Construct_AuraBars(statusBar)
	statusBar:CreateBackdrop(nil, nil, nil, UF.thinBorders, true)
	statusBar:SetScript("OnMouseDown", UF.Aura_OnClick)
	statusBar:Point("LEFT")
	statusBar:Point("RIGHT")

	statusBar.icon:CreateBackdrop(nil, nil, nil, UF.thinBorders, true)

	UF.statusbars[statusBar] = true
	UF:Update_StatusBar(statusBar)

	UF:Configure_FontString(statusBar.timeText)
	UF:Configure_FontString(statusBar.nameText)

	UF:Update_FontString(statusBar.timeText)
	UF:Update_FontString(statusBar.nameText)

	statusBar.nameText:SetJustifyH("LEFT")
	statusBar.nameText:SetJustifyV("MIDDLE")
	statusBar.nameText:Point("RIGHT", statusBar.timeText, "LEFT", -4, 0)
	statusBar.nameText:SetWordWrap(false)

	statusBar.bg = statusBar:CreateTexture(nil, "BORDER")
	statusBar.bg:Show()

	local frame = statusBar:GetParent()
	statusBar.db = frame.db and frame.db.aurabar
end

function UF:AuraBars_SetPosition(from, to)
	local height = self.height
	local spacing = self.spacing
	local anchor = self.initialAnchor
	local growth = self.growth == "BELOW" and -1 or 1
	local border = UF.thinBorders and E.mult or E.Border

	for i = from, to do
		local button = self[i]
		if not button then break end

		button:ClearAllPoints()
		if i == 1 then
			button:SetPoint(anchor, self, anchor, -border, 0)
		else
			button:SetPoint(anchor, self, anchor, -(border), growth * ((i - 1) * (height + spacing + 1)))
		end
	end
end

function UF:Construct_AuraBarHeader(frame)
	local auraBar = CreateFrame("Frame", nil, frame)
	auraBar:SetFrameLevel(frame.RaisedElementParent:GetFrameLevel() + 10)
	auraBar:SetHeight(1)
	auraBar.PreSetPosition = UF.SortAuras
	auraBar.PostCreateBar = UF.Construct_AuraBars
	auraBar.PostUpdateBar = UF.PostUpdateBar_AuraBars
	auraBar.CustomFilter = UF.AuraFilter
	auraBar.SetPosition = UF.AuraBars_SetPosition

	auraBar.gap = UF.thinBorders and 1 or 6
	auraBar.sparkEnabled = true
	auraBar.initialAnchor = "BOTTOMRIGHT"
	auraBar.type = "aurabar"

	return auraBar
end

function UF:Configure_AuraBars(frame)
	if not frame.VARIABLES_SET then return end
	local auraBars = frame.AuraBars
	local db = frame.db
	auraBars.db = db.aurabar

	if db.aurabar.enable then
		if not frame:IsElementEnabled("AuraBars") then
			frame:EnableElement("AuraBars")
		end

		for _, statusBar in ipairs(auraBars) do
			statusBar.db = auraBars.db
			UF:Update_FontString(statusBar.timeText)
			UF:Update_FontString(statusBar.nameText)
		end

		auraBars:Show()

		auraBars.height = db.aurabar.height
		auraBars.growth = db.aurabar.anchorPoint
		auraBars.friendlyAuraType = db.aurabar.friendlyAuraType
		auraBars.enemyAuraType = db.aurabar.enemyAuraType
		auraBars.disableMouse = db.aurabar.clickThrough
		auraBars.maxBars = db.aurabar.maxBars
		auraBars.spacing = db.aurabar.spacing
		auraBars.width = frame.UNIT_WIDTH - auraBars.height - (frame.BORDER * 4) + (UF.thinBorders and 1 or -4)

		local attachTo = frame
		local colors = UF.db.colors.auraBarBuff

		if E:CheckClassColor(colors.r, colors.g, colors.b) then
			local classColor = E:ClassColor(E.myclass, true)
			colors.r, colors.g, colors.b = classColor.r, classColor.g, classColor.b
		end

		colors = UF.db.colors.auraBarDebuff
		if E:CheckClassColor(colors.r, colors.g, colors.b) then
			local classColor = E:ClassColor(E.myclass, true)
			colors.r, colors.g, colors.b = classColor.r, classColor.g, classColor.b
		end

		if not auraBars.Holder then
			local holder = CreateFrame("Frame", nil, auraBars)
			holder:Point("BOTTOM", frame, "TOP", 0, 0)
			holder:Size(db.aurabar.detachedWidth, 20)

			if frame.unitframeType == "player" then
				E:CreateMover(holder, "ElvUF_PlayerAuraMover", L["Player Aura Bars"], nil, nil, nil, "ALL,SOLO", nil, "unitframe,individualUnits,player,aurabar")
			elseif frame.unitframeType == "target" then
				E:CreateMover(holder, "ElvUF_TargetAuraMover", L["Target Aura Bars"], nil, nil, nil, "ALL,SOLO", nil, "unitframe,individualUnits,target,aurabar")
			elseif frame.unitframeType == "pet" then
				E:CreateMover(holder, "ElvUF_PetAuraMover", L["Pet Aura Bars"], nil, nil, nil, "ALL,SOLO", nil, "unitframe,individualUnits,pet,aurabar")
			elseif frame.unitframeType == "focus" then
				E:CreateMover(holder, "ElvUF_FocusAuraMover", L["Focus Aura Bars"], nil, nil, nil, "ALL,SOLO", nil, "unitframe,individualUnits,focus,aurabar")
			end

			auraBars.Holder = holder
		end

		auraBars.Holder:Size(db.aurabar.detachedWidth, 20)

		if db.aurabar.attachTo ~= "DETACHED" then
			E:DisableMover(auraBars.Holder.mover:GetName())
		end

		if db.aurabar.attachTo == "BUFFS" then
			attachTo = frame.Buffs
		elseif db.aurabar.attachTo == "DEBUFFS" then
			attachTo = frame.Debuffs
		elseif db.aurabar.attachTo == "PLAYER_AURABARS" and ElvUF_Player then
			attachTo = ElvUF_Player.AuraBars
		elseif db.aurabar.attachTo == "DETACHED" then
			attachTo = auraBars.Holder
			E:EnableMover(auraBars.Holder.mover:GetName())
			auraBars.width = db.aurabar.detachedWidth - db.aurabar.height
		end

		local anchorPoint, anchorTo = "BOTTOM", "TOP"
		if db.aurabar.anchorPoint == "BELOW" then
			anchorPoint, anchorTo = "TOP", "BOTTOM"
		end

		local yOffset
		local spacing = (((db.aurabar.attachTo == "FRAME" and 3) or (db.aurabar.attachTo == "PLAYER_AURABARS" and 4) or 2) * frame.SPACING)
		local border = (((db.aurabar.attachTo == "FRAME" or db.aurabar.attachTo == "PLAYER_AURABARS") and 0 or 1) * frame.BORDER)

		if db.aurabar.anchorPoint == "BELOW" then
			yOffset = -spacing + border - (not db.aurabar.yOffset and 0 or db.aurabar.yOffset)
		else
			yOffset = spacing - border + (not db.aurabar.yOffset and 0 or db.aurabar.yOffset)
		end
		local xOffset = (db.aurabar.attachTo == "FRAME" and frame.SPACING or 0)
		local offsetLeft = xOffset + ((db.aurabar.attachTo == "FRAME" and ((anchorTo == "TOP" and frame.ORIENTATION ~= "LEFT") or (anchorTo == "BOTTOM" and frame.ORIENTATION == "LEFT"))) and frame.POWERBAR_OFFSET or 0)
		local offsetRight = -xOffset - ((db.aurabar.attachTo == "FRAME" and ((anchorTo == "TOP" and frame.ORIENTATION ~= "RIGHT") or (anchorTo == "BOTTOM" and frame.ORIENTATION == "RIGHT"))) and frame.POWERBAR_OFFSET or 0)

		auraBars:ClearAllPoints()
		auraBars:Point(anchorPoint.."LEFT", attachTo, anchorTo.."LEFT", offsetLeft, db.aurabar.attachTo == "DETACHED" and 0 or yOffset)
		auraBars:Point(anchorPoint.."RIGHT", attachTo, anchorTo.."RIGHT", offsetRight, db.aurabar.attachTo == "DETACHED" and 0 or yOffset)
	elseif frame:IsElementEnabled("AuraBars") then
		frame:DisableElement("AuraBars")

		auraBars:Hide()
	end
end

function UF:PostUpdateBar_AuraBars(unit, statusBar, index, position, duration, expiration, debuffType, isStealable)
	local spellID = statusBar.spellID
	local spellName = statusBar.spell

	statusBar.db = self.db
	statusBar.icon:SetTexCoord(unpack(E.TexCoords))

	local colors = E.global.unitframe.AuraBarColors[spellID] and E.global.unitframe.AuraBarColors[spellID].enable and E.global.unitframe.AuraBarColors[spellID].color

	if E.db.unitframe.colors.auraBarTurtle and (E.global.unitframe.aurafilters.TurtleBuffs.spells[spellID] or E.global.unitframe.aurafilters.TurtleBuffs.spells[spellName]) and not colors then
		colors = E.db.unitframe.colors.auraBarTurtleColor
	end

	if not colors then
		if UF.db.colors.auraBarByType and statusBar.filter == "HARMFUL" then
			if not debuffType or (debuffType == "" or debuffType == "none") then
				colors = UF.db.colors.auraBarDebuff
			else
				colors = DebuffTypeColor[debuffType]
			end
		elseif statusBar.filter == "HARMFUL" then
			colors = UF.db.colors.auraBarDebuff
		else
			colors = UF.db.colors.auraBarBuff
		end
	end

	statusBar.custom_backdrop = UF.db.colors.customaurabarbackdrop and UF.db.colors.aurabar_backdrop

	if statusBar.bg then
		if (UF.db.colors.transparentAurabars and not statusBar.isTransparent) or (statusBar.isTransparent and (not UF.db.colors.transparentAurabars or statusBar.invertColors ~= UF.db.colors.invertAurabars)) then
			UF:ToggleTransparentStatusBar(UF.db.colors.transparentAurabars, statusBar, statusBar.bg, nil, UF.db.colors.invertAurabars)
		else
			local sbTexture = statusBar:GetStatusBarTexture()
			if not statusBar.bg:GetTexture() then UF:Update_StatusBar(statusBar.bg, sbTexture:GetTexture()) end

			UF:SetStatusBarBackdropPoints(statusBar, sbTexture, statusBar.bg)
		end
	end

	if colors then
		statusBar:SetStatusBarColor(colors.r, colors.g, colors.b)

		if not statusBar.hookedColor then
			UF.UpdateBackdropTextureColor(statusBar, colors.r, colors.g, colors.b)
		end
	else
		local r, g, b = statusBar:GetStatusBarColor()
		UF.UpdateBackdropTextureColor(statusBar, r, g, b)
	end
end