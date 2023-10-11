//
// Worthwhile Gwent - Reforged 1.0.0 by K1ngTr4cker
//
//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function WWG_IsGenericNPCEnabled(): bool 
{
	return (bool) theGame.GetInGameConfigWrapper().GetVarValue('WWG_GenericNPCSettings', 'wwg_Toggle_Enabled1');
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function WWG_IsQuestNPCEnabled(): bool 
{
	return (bool) theGame.GetInGameConfigWrapper().GetVarValue('WWG_QuestNPCSettings', 'wwg_Toggle_Enabled2');
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function WWG_GetMaxBetValue(rewardName : name, isGwentMode : bool): int 
{
	var rewrd: SReward;
	
	if ( !isGwentMode || !WWG_IsGenericNPCEnabled() ) 
	{
		theGame.GetReward(rewardName, rewrd );
		return rewrd.gold;
	}
	return (int) theGame.GetInGameConfigWrapper().GetVarValue('WWG_GenericNPCSettings', 'wwg_Gold_Value');
}

//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function RewardGenericPlayer(questName : string, exp : int) 
{
	var cfg: CInGameConfigWrapper = theGame.GetInGameConfigWrapper();
	
	if ( WWG_IsGenericNPCEnabled() ) 
	{
		if ( exp > 0 ) 
		{	
			GetWitcherPlayer().AddPoints(EExperiencePoint, exp, (bool) cfg.GetVarValue('WWG_NotificationSettings', 'wwg_Toggle_Enabled4') );	
		}
		
		if ( (int) cfg.GetVarValue('WWG_GenericNPCSettings', 'wwg_Skpo_Value') > 0 ) 
		{
			GetWitcherPlayer().AddPoints(ESkillPoint, (int) cfg.GetVarValue('WWG_GenericNPCSettings', 'wwg_Skpo_Value'), true);
		}
	}
}
	
//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function RewardQuestNPCPlayer(questName : string, goldreward : int, experiencepoints : int, skillpoints : int)
{
	
	var cfg: CInGameConfigWrapper = theGame.GetInGameConfigWrapper();
			
	if ( WWG_IsQuestNPCEnabled() ) 
	{	
		if ( (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalG') > 0 ) 
		{
			thePlayer.AddMoney( (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalG'));
			
			if ( (bool) cfg.GetVarValue('WWG_NotificationSettings', 'wwg_Toggle_Enabled3') ) 
			{
				thePlayer.DisplayItemRewardNotification('Crowns', (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalG'));
			}	
		}
		else 
		{
			if ( goldreward > 0 )
			{
				thePlayer.AddMoney(goldreward);
				
				if ( (bool) cfg.GetVarValue('WWG_NotificationSettings', 'wwg_Toggle_Enabled3') ) 
				{
					thePlayer.DisplayItemRewardNotification('Crowns', goldreward);
				}	
			}		
		}
		
		if ( (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalE') > 0 ) 
		{
			GetWitcherPlayer().AddPoints(EExperiencePoint, (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalE'), (bool) cfg.GetVarValue('WWG_NotificationSettings', 'wwg_Toggle_Enabled4') );	
		}
		else 
		{
			if ( experiencepoints > 0 ) 
			{	
				GetWitcherPlayer().AddPoints(EExperiencePoint, experiencepoints, (bool) cfg.GetVarValue('WWG_NotificationSettings', 'wwg_Toggle_Enabled4') );	
			}		
		}		
		
		if ( (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalS') > 0 )
		{
			GetWitcherPlayer().AddPoints(ESkillPoint, (int) cfg.GetVarValue('WWG_QuestNPCSettings', 'wwg_slider_GlobalS'), true);	
		}
		
		else 
		{
			if ( skillpoints > 0 ) 
			{	
				GetWitcherPlayer().AddPoints(ESkillPoint, skillpoints, true);
			}		
		}		
	}
}
	
//---------------------------------------------------
//-- Functions --------------------------------------
//---------------------------------------------------

function WWG_GetGwentReward(str :string)
{
	var cfg: CInGameConfigWrapper = theGame.GetInGameConfigWrapper();

	switch(str) 
	{
		
		// Generic NPC's
		
		case "generic_gwint_reward":
			RewardGenericPlayer(str, (int) cfg.GetVarValue('WWG_GenericNPCSettings', 'wwg_Expe_Value'));
			break;

		case "high_price_gwint_reward":
			RewardGenericPlayer(str, (int) cfg.GetVarValue('WWG_GenericNPCSettings', 'wwg_Expe_Value'));
			break;

		case "cg700_generic_gwint_reward":
			RewardGenericPlayer(str, (int) cfg.GetVarValue('WWG_GenericNPCSettings', 'wwg_Expe_Value'));
			break;
		
		// Big City Players
		
		case "cg_vimme_vivaldi":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Vimme_g'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Vimme_e'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Vimme_s') );
			break;

		case "cg_dijkstra":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Dijkstra_g'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Dijkstra_e'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Dijkstra_s') );
			break;

		case "cg_markiza_serenity":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Marquise_g'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Marquise_e'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Marquise_s') );
			break;

		case "cg_scojateal_trader":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Scoiatael_g'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Scoiatael_e'), (int) cfg.GetVarValue('WWG_BCP', 'wwg_cg_BCP_Scoiatael_s') );
			break;	

		// High Stakes
		
		case "sq306_01_defeated_bernard":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Bernard_g'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Bernard_e'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Bernard_s') );
			break;

		case "sq306_02_defeated_sacha":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Sasha_g'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Sasha_e'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Sasha_s') );
			break;

		case "sq306_03_defeated_finneas":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Finneas_g'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Finneas_e'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Finneas_s') );
			break;

		case "sq306_04_defeated_tybalt":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Tybalt_g'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Tybalt_e'), (int) cfg.GetVarValue('WWG_HS', 'wwg_cg_HS_Tybalt_s') );
			break;	

		// Old Pals
		
		case "cg_roche":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Roche_g'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Roche_e'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Roche_s') );
			break;

		case "cg_talar":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Thaler_g'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Thaler_e'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Thaler_s') );
			break;

		case "cg_lambert":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Lambert_g'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Lambert_e'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Lambert_s') );
			break;

		case "cg_zoltan":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Zoltan_g'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Zoltan_e'), (int) cfg.GetVarValue('WWG_OP', 'wwg_cg_OP_Zoltan_s') );
			break;

		// Playing InnKeepers
		
		case "cg_stjepan":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_stjepan_g'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_stjepan_e'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_stjepan_s') );
			break;

		case "cg_olivier":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_olivier_g'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_olivier_e'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_olivier_s') );
			break;

		case "cg_crossroads_innkeeper":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_innkeep_g'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_innkeep_e'), (int) cfg.GetVarValue('WWG_PI', 'wwg_cg_PI_innkeep_s') );
			break;

		// Skellige Style
		
		case "cg_mousesack":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Ermion_g'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Ermion_e'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Ermion_s') );
			break;

		case "cg_crach_an_craite":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Crach_g'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Crach_e'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Crach_s') );
			break;

		case "cg_gremista":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Gremist_g'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Gremist_e'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Gremist_s') );
			break;
		
		case "cg_sjusta_the_tailor":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Sjusta_g'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Sjusta_e'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Sjusta_s') );
			break;
			
		case "cg_lugos_the_mad":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Lugos_g'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Lugos_e'), (int) cfg.GetVarValue('WWG_SS', 'wwg_cg_SS_Lugos_s') );
			break;

		// Velen Players
		
		case "cg_baron":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Baron_g'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Baron_e'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Baron_s') );
			break;

		case "cg_boat_builder_nml":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Boatwright_g'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Boatwright_e'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_Boatwright_s') );
			break;

		case "cg_hermit":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_SoothSayer_g'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_SoothSayer_e'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_SoothSayer_s') );
			break;
		
		case "cg_card_prodigy":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_HaddyProdigy_g'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_HaddyProdigy_e'), (int) cfg.GetVarValue('WWG_VP', 'wwg_cg_VP_HaddyProdigy_s') );
			break;

		// Misc Quests
		
		case "sq301_3_won_cards_on_party":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Party_g'), (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Party_e'), (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Party_s') );
			break;

		case "cg_academic":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Tutorial_g'), (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Tutorial_e'), (int) cfg.GetVarValue('WWG_MI', 'wwg_cg_mi_Tutorial_s') );
			break;

		// Hearts of Stone
		
		case "cg600_shani":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_shani_g'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_shani_e'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_shani_s') );
			break;

		case "cg600_olgierd":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_olgierd_g'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_olgierd_e'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_olgierd_s') );
			break;

		case "q602_wedding_gwent_won":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_wedding_g'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_wedding_e'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_wedding_s') );
			break;
		
		case "q603_02a_gambler":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_g'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_e'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_s') );
			break;

		case "q603_02b_gambler_no_money":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_g'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_e'), (int) cfg.GetVarValue('WWG_HOS', 'wwg_cg_hos_hilbert_s') );
			break;

		// Blood and Wine
		
		case "cg700_wager_sword":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_hamal_g'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_hamal_e'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_hamal_s') );
			break;

		case "cg700_tournament_win_alternate":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Tourn_g'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Tourn_e'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Tourn_s') );
			break;
			
		case "cg700_tournament_card":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_yaki_g'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_yaki_e'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_yaki_s') );
			break;
		
		case "mq7001_gwent":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_trentin_g'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_trentin_e'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_trentin_s') );
			break;

		case "mq7011_gwent":
			RewardQuestNPCPlayer(str, (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Customer_g'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Customer_e'), (int) cfg.GetVarValue('WWG_BAW', 'wwg_cg_baw_Customer_s') );
			break;
			
		// End
		
		default:
			break;
	}
}