/obj/item/organ/genital/womb
	name 			= "womb"
	desc 			= "A female reproductive organ."
	icon			= 'code/citadel/icons/vagina.dmi'
	icon_state 		= "womb"
	zone 			= "groin"
	slot 			= "womb"
	w_class 		= 3
	fluid_id 		= "femcum"
	var/obj/item/organ/genital/vagina/linked_vag

/obj/item/organ/genital/womb/Destroy()
	return ..()