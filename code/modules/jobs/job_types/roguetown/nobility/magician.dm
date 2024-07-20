/datum/job/roguetown/magician
	title = "Court Magician"
	flag = WIZARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Aasimar",
		"Dwarf",
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_MAGICIAN
	tutorial ="Dream interpreter, soothsayer, astrologer and valued courtier. \
	Indebted to the ruler for funding yils of mystical studies in these dark times, \
	only wisdom and arcane knowledge amassed during a long life will allow a mage to unlock their full potential."
	outfit = /datum/outfit/job/roguetown/magician
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	give_bank_account = 120
	min_pq = 0

/datum/outfit/job/roguetown/magician
	allowed_patrons = list(/datum/patron/divine/noc)

/datum/outfit/job/roguetown/magician/pre_equip(mob/living/carbon/human/H)
	..()

	head = /obj/item/clothing/head/roguetown/wizhat/gen
	backr = /obj/item/storage/backpack/rogue/satchel
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	id = /obj/item/clothing/ring/gold/protection
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/keyring/mage
	backl = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(/obj/item/scrying = 1)
	switch(pick(1,2))
		if (1)
			shoes = /obj/item/clothing/shoes/roguetown/shalal	
		if (2)
			shoes = /obj/item/clothing/shoes/roguetown/shortboots

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	H.virginity = TRUE

	H.change_stat("strength", -2)
	H.change_stat("intelligence", 5)
	H.change_stat("constitution", -2)
	H.change_stat("speed", -2)

	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball/greater)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/ethereal_jaunt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/knock)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/projectile/magic_missile)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/repulse)
		if(H.age == AGE_OLD)
			armor = /obj/item/clothing/suit/roguetown/shirt/robe/courtmage
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			if(H.dna.species.id == "human")
				belt = /obj/item/storage/belt/rogue/leather/plaquegold
				head = /obj/item/clothing/head/roguetown/wizhat
				armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
		if(H.age == AGE_MIDDLEAGED)
			cloak = /obj/item/clothing/cloak/black_cloak
			H.mind.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/knock)

/datum/outfit/job/roguetown/magician/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, pick(6,5), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)

	if(H.patron != /datum/patron/divine/noc)
		H.patron = GLOB.patronlist[/datum/patron/divine/noc]
		to_chat(H, "<span class='warning'>My long studies of magicks has drawn me to [H.patron], no matter what other gods I might have preferred in the past.")


//............... Unique Court Mage Stuff ...........................
/*
/obj/item/clothing/head/roguetown/wizhat/equipped(mob/living/user, slot)
	. = ..()
	if(user.mind && user.mind.assigned_role == "Court Magician")
		if(slot == SLOT_HEAD && istype(user))
			user.apply_status_effect(/datum/status_effect/buff/thinking_cap)
		else
			user.remove_status_effect(/datum/status_effect/buff/thinking_cap)
	else return

/obj/item/clothing/head/roguetown/wizhat/dropped(mob/living/user, slot)
	. = ..()
	user.remove_status_effect(/datum/status_effect/buff/thinking_cap)


/datum/status_effect/buff/thinking_cap
	id = "thinkingcap"
	alert_type = /atom/movable/screen/alert/status_effect/buff/thinking_cap
	effectedstats = list("intelligence" = 2)
	duration = 240 MINUTES

/datum/status_effect/buff/thinking_cap/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.remove_stress(/datum/stressevent/wheresmyhat)

/datum/status_effect/buff/thinking_cap/on_remove()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.add_stress(/datum/stressevent/wheresmyhat)

/datum/stressevent/wheresmyhat
	timer = 0
	stressadd = 1
	desc = "<span class='red'>I miss my hat....</span>"

/atom/movable/screen/alert/status_effect/buff/thinking_cap
	name = "My mind is clear"
	desc = "<span class='nicegreen'>My hat deflects mind-clouding rays of Zizo...</span>\n"
	icon = 'icons/mob/actions/roguespells.dmi'
	icon_state = ""
*/