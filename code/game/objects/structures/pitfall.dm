/obj/structure/hole
	name = "hole"
	desc = "There probably isn't anything interesting down there."
	icon = 'icons/obj/hole.dmi'
	icon_state = "hole"
	layer = 1.4
	var/obj/hole_overlay_fuck_byond/overlay
	var/turf/base_turf
	var/has_spikes = FALSE

/obj/structure/hole/spikes
	desc = "There are spikes down there. Looks like a very intricate barbecue setup."
	has_spikes = TRUE
	icon_state = "hole_spikes"

/obj/hole_overlay_fuck_byond
	mouse_opacity = 0
	layer = 1.8
	icon = 'icons/obj/hole.dmi'
	icon_state = "hole_mask"

/obj/hole_overlay_fuck_byond/Initialize(location, var/obj/structure/hole/parent_hole)
	..(location)
	var/icon/new_icon = icon(parent_hole.base_turf.icon, parent_hole.base_turf.icon_state)
	var/icon/mask_icon = icon('icons/obj/hole.dmi', "hole_mask")
	new_icon.Blend(mask_icon, ICON_ADD)
	icon = new_icon

/obj/structure/hole/Initialize()
	base_turf = get_turf(src)
	base_turf.layer = 1.3//lower than regular turfs
	overlay = new(loc, src)

	for(var/mob/living/L in loc)
		L.layer = 1.5
		animate(L, pixel_y = L.pixel_y - 6, time = 2)

/obj/structure/hole/Destroy()
	base_turf.layer = initial(base_turf.layer)
	QDEL_NULL(overlay)

/obj/structure/hole/Crossed(atom/movable/AM)
	if(!istype(AM, /mob/living))
		return
	var/mob/living/L = AM

	L.layer = 1.5
	animate(L, pixel_y = L.pixel_y - 6, time = 2)

	if(L.m_intent != MOVE_INTENT_WALK)
		if(has_spikes)
			to_chat(L, "<span class='userdanger'>You trip and fall into [src], impaling yourself on the sharp spikes!\nIt hurts!</span>")
			L.Stun(100)
			L.Knockdown(100)
			L.adjustBruteLoss(40)
		else
			to_chat(L, "<span class='userdanger'>You trip and fall into [src]!</span>")
			L.Stun(50)
			L.Knockdown(50)
			playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)

/obj/structure/hole/Uncrossed(atom/movable/AM)
	if(!istype(AM, /mob/living))
		return
	var/mob/living/L = AM

	L.layer = initial(L.layer)
	animate(L, pixel_y = L.pixel_y + 6, time = 2)

