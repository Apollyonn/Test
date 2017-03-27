local E, L, V, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--Locked Settings, These settings are stored for your character only regardless of profile options.

V['general'] = {
	['loot'] = true,
	['lootRoll'] = true,
	["normTex"] = "ElvUI Norm",
	["glossTex"] = "ElvUI Norm",	
	["dmgfont"] = "Homespun",
	["namefont"] = "PT Sans Narrow",
	["chatBubbles"] = "backdrop",
	["chatBubbleFont"] = "PT Sans Narrow",
	["chatBubbleFontSize"] = 14,
	["chatBubbleFontOutline"] = "NONE",
	['pixelPerfect'] = true,
	["lfrEnhancement"] = true,
	["replaceBlizzFonts"] = true,
	['minimap'] = {
		['enable'] = true,
		['hideCalendar'] = true,
		["hideWorldMap"] = true,
		['hideZoomIn'] = true,
		['hideZoomOut'] = true
	},
	["classColorMentionsSpeech"] = true,
	["raidUtility"] = true
}

V['bags'] = {
	['enable'] = true,
	['bagBar'] = false
}

V["nameplates"] = {
	["enable"] = true,
}

V['auras'] = {
	['enable'] = true,
	['disableBlizzard'] = true
}

V['chat'] = {
	['enable'] = true,
}

V["skins"] = {
	["tradeSkillBig"] = true,
	["ace3"] = {
		["enable"] = true
	},
	['blizzard'] = {
		['enable'] = true,
		['achievement'] = true,
		['alertframes'] = true,
		['archaeology'] = true,
		['auctionhouse'] = true,
		['bags'] = true,
		['barber'] = true,
		['bgmap'] = true,
		['bgscore'] = true,
		['binding'] = true,
		['bmah'] = true,
		['calendar'] = true,
		['character'] = true,
		['debug'] = true,
		['dressingroom'] = true,
		['encounterjournal'] = true,
		['friends'] = true,
		['gbank'] = true,
		['glyph'] = true,
		["gmchat"] = true,
		['gossip'] = true,
		['greeting'] = true,
		['guild'] = true,
		['guildcontrol'] = true,
		['guildregistrar'] = true,
		['help'] = true,
		['inspect'] = true,
		['itemUpgrade'] = true,
		['lfg'] = true,
		["loot"] = true,
		["lootRoll"] = true,
		["losscontrol"] = true,
		['lfguild'] = true,
		['macro'] = true,
		['mail'] = true,
		['merchant'] = true,
		['misc'] = true,
		['nonraid'] = true,
		['movepad'] = true,
		['mounts'] = true,
		['petbattleui'] = true,
		['petition'] = true,
		['pvp'] = true,
		['quest'] = true,
		['raid'] = true,
		['reforge'] = true,
		['socket'] = true,
		['spellbook'] = true,
		['stable'] = true,
		['tabard'] = true,
		['talent'] = true,
		['taxi'] = true,
		['timemanager'] = true,
		['trade'] = true,
		['tradeskill'] = true,
		['trainer'] = true,
		['transmogrify'] = true,
		['tutorial'] = true,
		['voidstorage'] = true,
		['watchframe'] = true,
		['worldmap'] = true,
		["mirrorTimers"] = true
	},
}

V['tooltip'] = {
	['enable'] = true,
}

V['unitframe'] = {
	['enable'] = true,
	["disabledBlizzardFrames"] = {
		["player"] = true,
		["target"] = true,
		["focus"] = true,
		["boss"] = true,
		["arena"] = true,
		["party"] = true,
		['raid'] = true
	}
}

V["actionbar"] = {
	["enable"] = true,
}

V["cooldown"] = {
	enable = true
}