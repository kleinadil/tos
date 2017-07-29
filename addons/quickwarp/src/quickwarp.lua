local acutil = require("acutil");

function QUICKWARP_ON_INIT(addon, frame)
    acutil.slashCommand("/qw", QUICKWARP_COMMAND);
end

function QUICKWARP_COMMAND(command)
    local arg1 = table.remove(command, 1);
    if arg1 then
        local questID = tonumber(arg1);
        if questID ~= nil then
            local questIES = GetClassByType("QuestProgressCheck", questID);
            if questIES then
                local pc = SCR_QUESTINFO_GET_PC();
                local result = SCR_QUEST_CHECK_C(pc, questIES.ClassName);
                local questnpc_state = GET_QUEST_NPC_STATE(questIES, result);
                if questnpc_state ~= nil then
                    local mapProp = geMapTable.GetMapProp(questIES[questnpc_state..'Map']);
                    if mapProp ~= nil then
                        local npcProp = mapProp:GetNPCPropByDialog(questIES[questnpc_state..'NPC']);
                        if npcProp~= nil then
                            local genList = npcProp.GenList;
                            if genList ~= nil then
                                QUESTION_QUEST_WARP(nil, nil, nil, questID);
                                return;
                            end
                        end
                    end
                end
                CHAT_SYSTEM("Cannot jump to "..questIES.Name);
            else
                CHAT_SYSTEM("Cannot jump to ["..questID.."]");
            end
            return;
        end
    end

    CHAT_SYSTEM("/qw [questID]");
end
