﻿local E, L, V, P, G = unpack(select(2, ...));

G["general"] = {
	["autoScale"] = true,
	["minUiScale"] = 0.64,
	["eyefinity"] = false,
	["smallerWorldMap"] = true,
	["mapAlphaWhenMoving"] = 0.35,
	["WorldMapCoordinates"] = {
		["enable"] = true,
		["position"] = "BOTTOMLEFT",
		["xOffset"] = 0,
		["yOffset"] = 0
	},
	["animateConfig"] = true
};

G["classtimer"] = {};

G["nameplates"] = {};

G["unitframe"] = {
	["aurafilters"] = {},
	["buffwatch"] = {}
};

G["chat"] = {
	["classColorMentionExcludedNames"] = {},
}

G["bags"] = {
	["ignoredItems"] = {},
}

G["datatexts"] = {
	["customCurrencies"] = {}
}