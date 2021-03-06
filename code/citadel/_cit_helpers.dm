//THIS FILE CONTAINS CONSTANTS, PROCS, AND OTHER THINGS//
/////////////////////////////////////////////////////////

/mob/proc/setClickCooldown(var/timeout)
	next_move = max(world.time + timeout, next_move)

/proc/get_matrix_largest()
	var/matrix/mtrx=new()
	return mtrx.Scale(2)
/proc/get_matrix_large()
	var/matrix/mtrx=new()
	return mtrx.Scale(1.5)
/proc/get_matrix_norm()
	var/matrix/mtrx=new()
	return mtrx
/proc/get_matrix_small()
	var/matrix/mtrx=new()
	return mtrx.Scale(0.8)
/proc/get_matrix_smallest()
	var/matrix/mtrx=new()
	return mtrx.Scale(0.65)

proc/get_racelist(var/mob/user)//This proc returns a list of species that 'user' has available to them. It searches the list of ckeys attached to the 'whitelist' var for a species and also checks if they're an admin.
	for(var/spath in subtypesof(/datum/species))
		var/datum/species/S = new spath()
		var/list/wlist = S.whitelist
		if(S.whitelisted && (wlist.Find(user.ckey) || wlist.Find(user.key) || user.client.holder))  //If your ckey is on the species whitelist or you're an admin:
			whitelisted_species_list[S.id] = S.type 											//Add the species to their available species list.
		else if(!S.whitelisted && S.roundstart)														//Normal roundstart species will be handled here.
			whitelisted_species_list[S.id] = S.type

	return whitelisted_species_list

	//Mammal Species
var/global/list/mam_body_markings_list = list()
var/global/list/mam_ears_list = list()
var/global/list/mam_tails_list = list()
var/global/list/mam_tails_animated_list = list()
var/global/list/taur_list = list()

	//Exotic Species
var/global/list/exotic_tails_list = list()
var/global/list/exotic_tails_animated_list = list()
var/global/list/exotic_ears_list = list()
var/global/list/exotic_head_list = list()
var/global/list/exotic_back_list = list()

	//Xenomorph Species
var/global/list/xeno_head_list = list() //I forgot the ' = list()' part for the longest time and couldn't figure out what was wrong. *facepalm
var/global/list/xeno_tail_list = list()
var/global/list/xeno_dorsal_list = list()


	//Genitals and Arousal Lists
var/global/list/cock_shapes_list = list()//global_lists.dm for the list initializations
var/global/list/breasts_size_list = list()
var/global/list/cum_into_containers_list = list(/obj/item/weapon/reagent_containers/food/snacks/pie)
var/global/list/dick_nouns = list("dick","cock","member","shaft")
var/global/list/cum_id_list = list("semen")
var/global/list/milk_id_list = list("milk")
//mentor stuff
var/list/mentors = list()

//Looc stuff
var/global/looc_allowed = 1
var/global/dlooc_allowed = 1

/client/proc/reload_mentors()
		set name = "Reload Mentors"
		set category = "Admin"
		if(!src.holder)	return
		message_admins("[key_name_admin(usr)] manually reloaded mentors")

//Flavor Text
/mob/living/carbon/human/verb/set_flavor()
	set name = "Set Flavor Text"
	set desc = "Sets an extended description of your character's features."
	set category = "IC"

	flavor_text =  copytext(sanitize(input(usr, "Please enter your new flavor text.", "Flavor text", null)  as text), 1)

//LOOC toggles
/client/verb/listen_looc()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat"
	prefs.chat_toggles ^= CHAT_LOOC
	prefs.save_preferences()
	src << "You will [(prefs.chat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel."
	feedback_add_details("admin_verb","TLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/togglelooc()
	set category = "Server"
	set desc="Fukken metagamers"
	set name="Toggle LOOC"
	toggle_looc()
	log_admin("[key_name(usr)] toggled LOOC.")
	message_admins("[key_name_admin(usr)] toggled LOOC.")
	feedback_add_details("admin_verb","TLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_looc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != looc_allowed)
			looc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		looc_allowed = !looc_allowed
	world << "<B>The LOOC channel has been globally [looc_allowed ? "enabled" : "disabled"].</B>"

/datum/admins/proc/toggleloocdead()
	set category = "Server"
	set desc="Toggle dis bitch"
	set name="Toggle Dead LOOC"
	dlooc_allowed = !( dlooc_allowed )

	log_admin("[key_name(usr)] toggled OOC.")
	message_admins("[key_name_admin(usr)] toggled Dead OOC.")
	feedback_add_details("admin_verb","TDLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/mob/living/carbon/proc/has_penis()
	if(getorganslot("penis"))//slot shared with ovipositor
		if(istype(getorganslot("penis"), /obj/item/organ/genital/penis))
			return 1
	return 0

/mob/living/carbon/proc/has_balls()
	if(getorganslot("balls"))
		if(istype(getorganslot("balls"), /obj/item/organ/genital/testicles))
			return 1
	return 0

/mob/living/carbon/proc/has_vagina()
	if(getorganslot("vagina"))
		return 1
	return 0

/mob/living/carbon/proc/has_breasts()
	if(getorganslot("breasts"))
		return 1
	return 0

/mob/living/carbon/proc/has_ovipositor()
	if(getorganslot("penis"))//shared slot
		if(istype(getorganslot("penis"), /obj/item/organ/genital/ovipositor))
			return 1
	return 0

/mob/living/carbon/human/proc/has_eggsack()
	if(getorganslot("balls"))
		if(istype(getorganslot("balls"), /obj/item/organ/genital/eggsack))
			return 1
	return 0

/mob/living/carbon/human/proc/is_bodypart_exposed(bodypart)

/mob/living/carbon/proc/is_groin_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & GROIN)
			return 0
	return 1

/mob/living/carbon/proc/is_chest_exposed(var/list/L)
	if(!L)
		L = get_equipped_items()
	for(var/obj/item/I in L)
		if(I.body_parts_covered & CHEST)
			return 0
	return 1

////////////////////////
//DANGER | DEBUG PROCS//
////////////////////////

/client/proc/give_humans_genitals()
	set name = "Mass Give Genitals"
	set category = "Dangerous"
	set desc = "Gives every human mob genitals for testing purposes. WARNING: NOT FOR LIVE SERVER USAGE!!"

	log_admin("[src] gave everyone genitals.")
	message_admins("[src] gave everyone genitals.")
	for(var/mob/living/carbon/human/H in mob_list)
		if(H.gender == MALE)
			H.give_penis()
			H.give_balls()
		else
			H.give_vagina()
			H.give_womb()
			H.give_breasts()

/client/proc/test_mammal_overlays()
	set name = "Mass Give Mammalitus"
	set category = "Dangerous"
	set desc = "Turns every human into a mammal with tails, ears, etc. WARNING: NOT FOR LIVE SERVER USAGE!!"

	log_admin("[src] turned everyone into mammals.")
	message_admins("[src] turned everyone into mammals.")
	for(var/mob/living/carbon/human/H in mob_list)
		if(!H.dna)
			continue
		var/datum/dna/hdna = H.dna
		H.set_species(/datum/species/mammal)
		var/subspec = pick("Fox","Wolf","Fennec")
		switch(subspec)
			if("Wolf")
				hdna.features["mam_tail"] = "Wolf"
				hdna.features["mam_ears"] = "Wolf"
				hdna.features["snout"] = "Wolf"
				hdna.features["mam_body_markings"] = "Wolf"
				hdna.features["mcolor"] = "555"
				hdna.features["mcolor2"] = "999"
				hdna.features["mcolor3"] = "999"
			if("Fox")
				hdna.features["mam_tail"] = "Fox"
				hdna.features["mam_ears"] = "Fox"
				hdna.features["snout"] = "Fox, Long"
				hdna.features["mam_body_markings"] = "Fox"
				hdna.features["mcolor"] = "f60"
				hdna.features["mcolor2"] = "fff"
				hdna.features["mcolor3"] = "fff"
			if("Fennec")
				hdna.features["mam_tail"] = "Fennec"
				hdna.features["mam_ears"] = "Fennec"
				hdna.features["snout"] = "Fox, Short"
				hdna.features["mam_body_markings"] = "Fox"
		H.regenerate_icons()
