/mob/living/simple_animal/hostile/retaliate/rogue/trollbog
	icon = 'icons/roguetown/mob/monster/trolls.dmi'
	name = "Bog Troll"
	icon_state = "Troll"
	icon_living = "Troll"
	icon_dead = "Trolld"
	gender = MALE
	emote_hear = null
	emote_see = null
	speak_chance = 1
	turns_per_move = 4
	see_in_dark = 10
	move_to_delay = 2
	base_intents = list(/datum/intent/simple/headbutt, /datum/intent/simple/bigbite)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/rawcutlet/xeno = 1,
						/obj/item/natural/hide = 2)
	faction = list("orcs")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 300
	maxHealth = 300
	melee_damage_lower = 30
	melee_damage_upper = 50
	vision_range = 6
	aggro_vision_range = 6
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_HEAVY
	pooptype = null
	STACON = 12
	STASTR = 14
	STASPD = 5
	STAEND = 14
	deaggroprob = 0
	defprob = 30
	defdrain = 13
	del_on_deaggro = 99 SECONDS
	retreat_health = 0
	food_max = 250
	food = 0
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')
	dodgetime = 15
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	remains_type = /obj/effect/decal/remains/xeno/troll // Placeholder until Troll remains are sprited.
	body_eater = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/death(gibbed)
	..()
	update_icon()

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/troll/aggro1.ogg','sound/vo/mobs/troll/aggro2.ogg')
		if("pain")
			return pick('sound/vo/mobs/troll/pain1.ogg','sound/vo/mobs/troll/pain2.ogg')
		if("death")
			return pick('sound/vo/mobs/troll/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/troll/idle1.ogg','sound/vo/mobs/troll/idle2.ogg')
		if("cidle")
			return pick('sound/vo/mobs/troll/cidle1.ogg','sound/vo/mobs/troll/aggro2.ogg')

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/taunted(mob/user)
	emote("aggro")
	Retaliate()
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)


/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/trollbog/after_creation()
	..()
	var/obj/item/organ/eyes/eyes = src.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(src,1)
		QDEL_NULL(eyes)
	eyes = new /obj/item/organ/eyes/night_vision/nightmare
	eyes.Insert(src)
