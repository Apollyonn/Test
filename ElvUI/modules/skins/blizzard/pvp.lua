local E, L, V, P, G = unpack(select(2, ...));
local S = E:GetModule("Skins");

local _G = _G;
local pairs, unpack = pairs, unpack;
local find = string.find;

local function LoadSkin()

	PVPUIFrame:StripTextures();
	PVPUIFrame:SetTemplate("Transparent");
	PVPUIFrame.LeftInset:StripTextures();
	PVPUIFrame.Shadows:StripTextures();

	S:HandleCloseButton(PVPUIFrameCloseButton);

	for i = 1, 3 do
		local button = _G["PVPQueueFrameCategoryButton"..i];

		button:SetTemplate("Default");
		button.Background:Kill();
		button.Ring:Kill();

		button:CreateBackdrop("Default");
		button.backdrop:SetOutside(button.Icon);
		button.backdrop:SetFrameLevel(button.backdrop:GetFrameLevel() + 2);

		button:StyleButton(nil, true);

		button.Icon:Size(58);
		button.Icon:SetTexCoord(.15, .85, .15, .85);
		button.Icon:Point("LEFT", button, 1, 0);
		button.Icon:SetParent(button.backdrop);
	end

	local factionGroup = UnitFactionGroup("player");

	PVPQueueFrame.CategoryButton1.CurrencyIcon:SetTexture("Interface\\Icons\\PVPCurrency-Honor-"..factionGroup);
	PVPQueueFrame.CategoryButton1.CurrencyIcon:SetTexCoord(unpack(E.TexCoords))
	PVPQueueFrame.CategoryButton1.CurrencyIcon:Size(20)
	PVPQueueFrame.CategoryButton1.CurrencyIcon:Point("TOPLEFT", PVPQueueFrame.CategoryButton1, "BOTTOMLEFT", 79, 30)
	PVPQueueFrame.CategoryButton1.CurrencyAmount:FontTemplate(nil, 13, "OUTLINE")
	PVPQueueFrame.CategoryButton1.CurrencyAmount:Point("LEFT", PVPQueueFrame.CategoryButton1.CurrencyIcon, "RIGHT", 7, 0)

	PVPQueueFrame.CategoryButton2.CurrencyIcon:SetTexture("Interface\\Icons\\PVPCurrency-Conquest-"..factionGroup);
	PVPQueueFrame.CategoryButton2.CurrencyIcon:SetTexCoord(unpack(E.TexCoords))
	PVPQueueFrame.CategoryButton2.CurrencyIcon:Size(20)
	PVPQueueFrame.CategoryButton2.CurrencyIcon:Point("TOPLEFT", PVPQueueFrame.CategoryButton2, "BOTTOMLEFT", 79, 30)
	PVPQueueFrame.CategoryButton2.CurrencyAmount:FontTemplate(nil, 13, "OUTLINE")
	PVPQueueFrame.CategoryButton2.CurrencyAmount:Point("LEFT", PVPQueueFrame.CategoryButton2.CurrencyIcon, "RIGHT", 7, 0)

	-- Honor Frame
	S:HandleDropDownBox(HonorFrameTypeDropDown);
	HonorFrameTypeDropDown:Width(200);
	HonorFrameTypeDropDown:ClearAllPoints();
	HonorFrameTypeDropDown:Point("TOP", HonorFrameSoloQueueButton, "TOP", 175, 315);

	HonorFrame.Inset:StripTextures();

	S:HandleScrollBar(HonorFrameSpecificFrameScrollBar);
	HonorFrameSpecificFrameScrollBar:Point("TOPLEFT", HonorFrameSpecificFrame, "TOPRIGHT", 0, -13);

	S:HandleButton(HonorFrameSoloQueueButton, true);
	HonorFrameSoloQueueButton:Point("BOTTOMLEFT", 7, 0);

	S:HandleButton(HonorFrameGroupQueueButton, true);
	HonorFrameGroupQueueButton:Point("BOTTOMRIGHT", -28, 0);

	hooksecurefunc("HonorFrameBonusFrame_Update", function()
		local englishFaction = UnitFactionGroup("player");
		local hasData, _, _, _, _, winHonorAmount, winConquestAmount = GetHolidayBGInfo();

		if(hasData) then
			local rewardIndex = 0;
			if(winConquestAmount and winConquestAmount > 0) then
				rewardIndex = rewardIndex + 1;
				local frame = HonorFrame.BonusFrame["BattlegroundReward"..rewardIndex];
				frame.Icon:SetTexture("Interface\\Icons\\PVPCurrency-Conquest-"..englishFaction);
				frame.Icon:SetTexCoord(unpack(E.TexCoords))
				frame.Icon:Size(18)
				frame.Icon:Point("LEFT", 0, 0)

				frame.Amount:FontTemplate(nil, 13)
				frame.Amount:ClearAllPoints()
				frame.Amount:Point("LEFT", frame.Icon, -25, 0)
			end

			if(winHonorAmount and winHonorAmount > 0) then
				rewardIndex = rewardIndex + 1;
				local frame = HonorFrame.BonusFrame["BattlegroundReward"..rewardIndex];
				frame.Icon:SetTexture("Interface\\Icons\\PVPCurrency-Honor-"..englishFaction);
				frame.Icon:SetTexCoord(unpack(E.TexCoords))
				frame.Icon:Size(18)

				frame.Amount:FontTemplate(nil, 13)
				frame.Amount:ClearAllPoints()
				frame.Amount:Point("LEFT", frame.Icon, -25, 0)
			end
		end
	end)

	HonorFrame.BonusFrame:StripTextures();
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures();
	HonorFrame.BonusFrame.RandomBGButton:StripTextures();
	HonorFrame.BonusFrame.RandomBGButton:SetTemplate();
	HonorFrame.BonusFrame.RandomBGButton:StyleButton(nil, true);
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetInside();
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 0.7, 1, 0.20);

	HonorFrame.BonusFrame.CallToArmsButton:StripTextures();
	HonorFrame.BonusFrame.CallToArmsButton:SetTemplate();
	HonorFrame.BonusFrame.CallToArmsButton:StyleButton(nil, true);
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetInside();
	HonorFrame.BonusFrame.CallToArmsButton.SelectedTexture:SetTexture(0, 0.7, 1, 0.20);

	HonorFrame.BonusFrame.DiceButton:DisableDrawLayer("ARTWORK");
	HonorFrame.BonusFrame.DiceButton:SetHighlightTexture("");

	HonorFrame.RoleInset:StripTextures();

	S:HandleCheckBox(HonorFrame.RoleInset.DPSIcon.checkButton, true);
	S:HandleCheckBox(HonorFrame.RoleInset.TankIcon.checkButton, true);
	S:HandleCheckBox(HonorFrame.RoleInset.HealerIcon.checkButton, true);

	HonorFrame.RoleInset.TankIcon:StripTextures();
	HonorFrame.RoleInset.TankIcon:CreateBackdrop();
	HonorFrame.RoleInset.TankIcon:Size(50);
	HonorFrame.RoleInset.TankIcon.texture = HonorFrame.RoleInset.TankIcon:CreateTexture(nil, "ARTWORK");
	HonorFrame.RoleInset.TankIcon.texture:SetTexture("Interface\\Icons\\Ability_Defend");
	HonorFrame.RoleInset.TankIcon.texture:SetTexCoord(unpack(E.TexCoords));
	HonorFrame.RoleInset.TankIcon.texture:SetInside(HonorFrame.RoleInset.TankIcon.backdrop);

	HonorFrame.RoleInset.HealerIcon:StripTextures();
	HonorFrame.RoleInset.HealerIcon:CreateBackdrop();
	HonorFrame.RoleInset.HealerIcon:Size(50);
	HonorFrame.RoleInset.HealerIcon.texture = HonorFrame.RoleInset.HealerIcon:CreateTexture(nil, "ARTWORK");
	HonorFrame.RoleInset.HealerIcon.texture:SetTexture("Interface\\Icons\\SPELL_NATURE_HEALINGTOUCH");
	HonorFrame.RoleInset.HealerIcon.texture:SetTexCoord(unpack(E.TexCoords));
	HonorFrame.RoleInset.HealerIcon.texture:SetInside(HonorFrame.RoleInset.HealerIcon.backdrop);

	HonorFrame.RoleInset.DPSIcon:StripTextures();
	HonorFrame.RoleInset.DPSIcon:CreateBackdrop();
	HonorFrame.RoleInset.DPSIcon:Size(50);
	HonorFrame.RoleInset.DPSIcon.texture = HonorFrame.RoleInset.DPSIcon:CreateTexture(nil, "ARTWORK");
	HonorFrame.RoleInset.DPSIcon.texture:SetTexture("Interface\\Icons\\INV_Knife_1H_Common_B_01");
	HonorFrame.RoleInset.DPSIcon.texture:SetTexCoord(unpack(E.TexCoords));
	HonorFrame.RoleInset.DPSIcon.texture:SetInside(HonorFrame.RoleInset.DPSIcon.backdrop);

	hooksecurefunc("LFG_PermanentlyDisableRoleButton", function(self)
		if(self.texture) then
			self.texture:SetDesaturated(true);
		end
	end)

	for i = 1, 2 do
		local button = HonorFrame.BonusFrame["WorldPVP"..i.."Button"];

		button:StripTextures();
		button:SetTemplate();
		button:StyleButton(nil, true);
		button.SelectedTexture:SetInside();
		button.SelectedTexture:SetTexture(0, 0.7, 1, 0.20);
	end

	HonorFrameSpecificFrame:CreateBackdrop("Transparent");
	HonorFrameSpecificFrame.backdrop:Point("TOPLEFT", -3, 1);
	HonorFrameSpecificFrame.backdrop:Point("BOTTOMRIGHT", -2, -2);

	for i = 1, 9 do
		local button = _G["HonorFrameSpecificFrameButton"..i];
		local icon = _G["HonorFrameSpecificFrameButton"..i].Icon;
		local selected = _G["HonorFrameSpecificFrameButton"..i].SelectedTexture;

		button:StripTextures();
		button:CreateBackdrop();
		button.backdrop:SetOutside(icon);
		button:StyleButton(nil, true);
		button:Width(305);

		selected:SetTexture(0, 0.7, 1, 0.20);

		icon:Point("TOPLEFT", 2, 0);
		icon:Size(38);
		icon:SetParent(button.backdrop);
	end

	-- Conquest Frame
	ConquestFrame.Inset:StripTextures();
	ConquestFrame:StripTextures();
	ConquestFrame.ShadowOverlay:StripTextures();

	ConquestPointsBar:StripTextures();
	ConquestPointsBar:CreateBackdrop("Default");
	ConquestPointsBar.backdrop:Point("TOPLEFT", ConquestPointsBar.progress, "TOPLEFT", -1, 1);
	ConquestPointsBar.backdrop:Point("BOTTOMRIGHT", ConquestPointsBar, "BOTTOMRIGHT", 1, 2);
	ConquestPointsBar.progress:SetTexture(E["media"].normTex);
	E:RegisterStatusBar(ConquestPointsBar.progress);

	ConquestFrame.ArenaReward.Icon:SetTexture("Interface\\Icons\\PVPCurrency-Conquest-"..factionGroup);
	ConquestFrame.ArenaReward.Icon:SetTexCoord(unpack(E.TexCoords))
	ConquestFrame.ArenaReward.Icon:Size(18)
	ConquestFrame.ArenaReward.Amount:FontTemplate(nil, 14)
	ConquestFrame.ArenaReward.Amount:ClearAllPoints()
	ConquestFrame.ArenaReward.Amount:Point("LEFT", ConquestFrame.ArenaReward.Icon, -27, 0)

	ConquestFrame.RatedBGReward.Icon:SetTexture("Interface\\Icons\\PVPCurrency-Conquest-"..factionGroup);
	ConquestFrame.RatedBGReward.Icon:SetTexCoord(unpack(E.TexCoords))
	ConquestFrame.RatedBGReward.Icon:Size(18)
	ConquestFrame.RatedBGReward.Amount:FontTemplate(nil, 14)
	ConquestFrame.RatedBGReward.Amount:ClearAllPoints()
	ConquestFrame.RatedBGReward.Amount:Point("LEFT", ConquestFrame.RatedBGReward.Icon, -27, 0)

	S:HandleButton(ConquestJoinButton, true);

	local function handleButton(button)
		button:StripTextures();
		button:SetTemplate();
		button:StyleButton(nil, true);
		button.SelectedTexture:SetInside();
		button.SelectedTexture:SetTexture(0, 0.7, 1, 0.20);
	end

	handleButton(ConquestFrame.RatedBG);
	handleButton(ConquestFrame.Arena2v2);
	handleButton(ConquestFrame.Arena3v3);
	handleButton(ConquestFrame.Arena5v5);

	ConquestFrame.Arena3v3:Point("TOP", ConquestFrame.Arena2v2, "BOTTOM", 0, -2);
	ConquestFrame.Arena5v5:Point("TOP", ConquestFrame.Arena3v3, "BOTTOM", 0, -2);

	-- Wargames Frame
	WarGamesFrame:StripTextures();
	WarGamesFrame.RightInset:StripTextures();
	WarGamesFrame.HorizontalBar:StripTextures();

	ConquestTooltip:SetTemplate("Transparent");

	S:HandleButton(WarGameStartButton, true);
	S:HandleScrollBar(WarGamesFrameScrollFrameScrollBar);

	WarGamesFrameScrollFrame:CreateBackdrop("Transparent");
	WarGamesFrameScrollFrame.backdrop:Point("TOPLEFT", 0, 1);
	WarGamesFrameScrollFrame.backdrop:Point("BOTTOMRIGHT", -2, -3);

	for i = 1, 8 do
		local warGamesEntry = _G["WarGamesFrameScrollFrameButton"..i].Entry;
		local warGamesIcon = _G["WarGamesFrameScrollFrameButton"..i].Entry.Icon;
		local warGamesSelected = _G["WarGamesFrameScrollFrameButton"..i].Entry.SelectedTexture;
		local warGamesHeader = _G["WarGamesFrameScrollFrameButton"..i].Header;

		warGamesEntry:StripTextures();
		warGamesEntry:CreateBackdrop();
		warGamesEntry.backdrop:SetOutside(warGamesIcon);
		warGamesEntry:StyleButton(nil, true);
		warGamesEntry:Width(305);

		warGamesSelected:SetTexture(0, 0.7, 1, 0.20);

		warGamesIcon:Point("TOPLEFT", 2, 0);
		warGamesIcon:Size(38);
		warGamesIcon:SetParent(warGamesEntry.backdrop);

		warGamesHeader:SetNormalTexture("Interface\\Buttons\\UI-PlusMinus-Buttons");
		warGamesHeader.SetNormalTexture = E.noop;
		warGamesHeader:GetNormalTexture():Size(13);
		warGamesHeader:GetNormalTexture():Point("LEFT", 3, 0);
		warGamesHeader:SetHighlightTexture("");
		warGamesHeader.SetHighlightTexture = E.noop;

		hooksecurefunc(warGamesHeader, "SetNormalTexture", function(self, texture)
			if(find(texture, "MinusButton")) then
				self:GetNormalTexture():SetTexCoord(0.5625, 1, 0, 0.4375);
			elseif(find(texture, "PlusButton")) then
				self:GetNormalTexture():SetTexCoord(0, 0.4375, 0, 0.4375);
 			end
		end);
	end
end

S:AddCallbackForAddon("Blizzard_PVPUI", "PVPUI", LoadSkin);