local E, L, V, P, G = unpack(select(2, ...));
local UF = E:GetModule("UnitFrames");

local CreateFrame = CreateFrame

function UF:Construct_Stagger(frame)
	local stagger = CreateFrame("Statusbar", nil, frame)
	UF["statusbars"][stagger] = true
	stagger:CreateBackdrop("Default", nil, nil, self.thinBorders, true)
	stagger:SetOrientation("VERTICAL")
	stagger.PostUpdate = UF.PostUpdateStagger
	stagger:SetFrameStrata("LOW")

	return stagger
end

function UF:Configure_Stagger(frame)
	local stagger = frame.Stagger
	local db = frame.db

	frame.STAGGER_WIDTH = stagger and frame.STAGGER_SHOWN and (db.stagger.width + (frame.BORDER*2)) or 0;

	local color = E.db.unitframe.colors.borderColor
	stagger.backdrop:SetBackdropBorderColor(color.r, color.g, color.b)

	if(db.stagger.enable) then
		if(not frame:IsElementEnabled("Stagger")) then
			frame:EnableElement("Stagger")
		end

		stagger:ClearAllPoints()
		if not frame.USE_MINI_POWERBAR and not frame.USE_INSET_POWERBAR and not frame.POWERBAR_DETACHED and not frame.USE_POWERBAR_OFFSET then
			if(frame.ORIENTATION == "RIGHT") then
				stagger:Point("BOTTOMRIGHT", frame.Power, "BOTTOMLEFT", -frame.BORDER*2 + (frame.BORDER - frame.SPACING*3), 0)
				stagger:Point("TOPLEFT", frame.Health, "TOPLEFT", -frame.STAGGER_WIDTH, 0)
			else
				stagger:Point("BOTTOMLEFT", frame.Power, "BOTTOMRIGHT", frame.BORDER*2 + (-frame.BORDER + frame.SPACING*3), 0)
				stagger:Point("TOPRIGHT", frame.Health, "TOPRIGHT", frame.STAGGER_WIDTH, 0)
			end
		else
			if(frame.ORIENTATION == "RIGHT") then
				stagger:Point("BOTTOMRIGHT", frame.Health, "BOTTOMLEFT", -frame.BORDER*2 + (frame.BORDER - frame.SPACING*3), 0)
				stagger:Point("TOPLEFT", frame.Health, "TOPLEFT", -frame.STAGGER_WIDTH, 0)
			else
				stagger:Point("BOTTOMLEFT", frame.Health, "BOTTOMRIGHT", frame.BORDER*2 + (-frame.BORDER + frame.SPACING*3), 0)
				stagger:Point("TOPRIGHT", frame.Health, "TOPRIGHT", frame.STAGGER_WIDTH, 0)
			end
		end
	elseif(frame:IsElementEnabled("Stagger")) then
		frame:DisableElement("Stagger")
	end
end

function UF:PostUpdateStagger(maxHealth, stagger, staggerPercent, r, g, b)
	local frame = self:GetParent()
	local db = frame.db

	if (stagger and stagger > 0) then
 		self:Show()
 	else
 		self:Hide()
	end

	local stateChanged = false
	local isShown = self:IsShown()

	if (frame.STAGGER_SHOWN and not isShown) or (not frame.STAGGER_SHOWN and isShown) then
		stateChanged = true
	end

	frame.STAGGER_SHOWN = isShown

	if(stateChanged) then
		UF:Configure_Stagger(frame)
		UF:Configure_HealthBar(frame)
		UF:Configure_Power(frame)
		UF:Configure_InfoPanel(frame, true)
	end
end