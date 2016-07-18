local MAX_GARRISON_TUTORIAL = 9;
local cvar_fields = {
	"lastGarrisonMissionTutorial",
	"shipyardMissionTutorialFirst",
	"shipyardMissionTutorialBlockade",
	"shipyardMissionTutorialAreaBuff",
	"lastVoidStorageTutorial",
};
local bit_fields = {
	LE_FRAME_TUTORIAL_CLEAN_UP_BAGS,
	LE_FRAME_TUTORIAL_BAG_SETTINGS,
	LE_FRAME_TUTORIAL_REAGENT_BANK_UNLOCK,
	LE_FRAME_TUTORIAL_GAME_TIME_AUCTION_HOUSE,
	LE_FRAME_TUTORIAL_WORLD_MAP_FRAME,
	LE_FRAME_TUTORIAL_SPELLBOOK,
	LE_FRAME_TUTORIAL_GLYPH,
	LE_FRAME_TUTORIAL_TALENT,
	LE_FRAME_TUTORIAL_SPEC,
	LE_FRAME_TUTORIAL_PROFESSIONS,
	LE_FRAME_TUTORIAL_CORE_ABILITITES,
	LE_FRAME_TUTORIAL_PET_JOURNAL,
	LE_FRAME_TUTORIAL_TOYBOX,
	LE_FRAME_TUTORIAL_TOYBOX_FAVORITE,
	LE_FRAME_TUTORIAL_TOYBOX_MOUSEWHEEL_PAGING,
	LE_FRAME_TUTORIAL_GARRISON_LANDING,
	LE_FRAME_TUTORIAL_GARRISON_ZONE_ABILITY,
	LE_FRAME_TUTORIAL_GARRISON_BUILDING,
	LE_FRAME_TUTORIAL_LFG_LIST,
	LE_FRAME_TUTORIAL_HEIRLOOM_JOURNAL,
	LE_FRAME_TUTORIAL_HEIRLOOM_JOURNAL_TAB,
	LE_FRAME_TUTORIAL_HEIRLOOM_JOURNAL_LEVEL,
};

function TutorialBuster_OnLoad(self)
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TutorialBuster_OnEvent(self, event, ...)
	local arg1 = ...;
	if (event == "PLAYER_ENTERING_WORLD") then
		self:UnregisterEvent(event);

		if (not GetCVar("lastGarrisonMissionTutorial") or tonumber(GetCVar("lastGarrisonMissionTutorial")) < MAX_GARRISON_TUTORIAL) then
			SetCVar("lastGarrisonMissionTutorial", MAX_GARRISON_TUTORIAL);
		end

		local _, field;
		for _,field in pairs(cvar_fields) do
			if (tonumber(GetCVar(field)) == 0) then
				SetCVar(field, 1);
			end
		end
		for _,field in pairs(bit_fields) do
			if (not GetCVarBitfield("closedInfoFrames", field)) then
				SetCVarBitfield("closedInfoFrames", field, true);
			end
		end
	end
end