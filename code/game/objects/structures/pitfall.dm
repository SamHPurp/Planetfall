/obj/structure/hole
	name = "hole"
	desc = "There probably isn't anything interesting down there."
	icon = 'icons/obj/hole.dmi'
	icon_state = "hole"
	layer = LOW_TURF_OVERLAY_LOW
	var/obj/hole_overlay/overlay
	var/turf/the_turf_under_this_thing
	var/has_spikes = FALSE

/obj/structure/hole/spikes
	desc = "There are spikes down there. Looks like a very intricate barbecue setup."
	has_spikes = TRUE
	icon_state = "hole_spikes"

/obj/hole_overlay
	mouse_opacity = 0
	layer = LOW_TURF_OVERLAY_HIGH
	icon = 'icons/obj/hole.dmi'
	icon_state = "hole_mask"

/obj/hole_overlay/Initialize(location, obj/structure/hole/parent_hole)
	..(location)

	var/icon/new_icon = icon(parent_hole.the_turf_under_this_thing.icon, parent_hole.the_turf_under_this_thing.icon_state)
	var/icon/mask_icon = icon('icons/obj/hole.dmi', "hole_mask")
	new_icon.Blend(mask_icon, ICON_ADD)
	icon = new_icon

/obj/structure/hole/Initialize()
	the_turf_under_this_thing = get_turf(src)
	the_turf_under_this_thing.layer = LOW_TURF//lower than regular turfs
	overlay = new(loc, src)

	for(var/mob/living/L in loc)
		L.layer = HUMAN_IN_HOLE
		animate(L, pixel_y = L.pixel_y - 6, time = 2)

/obj/structure/hole/Destroy()
	the_turf_under_this_thing.layer = initial(the_turf_under_this_thing.layer)
	QDEL_NULL(overlay)
	..()

/obj/structure/hole/Crossed(atom/movable/AM)
	if(!isliving(AM))
		return ..()
	var/mob/living/L = AM

	L.layer = HUMAN_IN_HOLE
	animate(L, pixel_y = L.pixel_y - 6, time = 2)

	if(L.m_intent != MOVE_INTENT_WALK)
		if(has_spikes)
			to_chat(L, "<span class='userdanger'>You trip and fall into [src], impaling yourself on the sharp spikes!\nIt hurts!</span>")
			L.Stun(100)
			L.Knockdown(100)
			L.apply_damage(40, BRUTE)
			playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)
		else
			to_chat(L, "<span class='danger'>You trip and fall into [src]!</span>")
			L.Stun(50)
			L.Knockdown(50)

/obj/structure/hole/Uncrossed(atom/movable/AM)
	if(!isliving(AM))
		return ..()
	var/mob/living/L = AM

	L.visible_message("<span class='notice'>[L] climbs out of [src]</span>", "<span class='notice'>You climb out of [src]</span>")

	L.layer = initial(L.layer)
	animate(L, pixel_y = L.pixel_y + 6, time = 2)

