/*
Ledges!
*/


/obj/structure/ledge
	name = "ledge"
	desc = "You could probably jump over it or something."
	anchored = TRUE
	opacity = 0
	density = FALSE
	icon = 'icons/obj/smooth_structures/ledges.dmi'
	icon_state = "initial"
	var/overlays_file = 'icons/obj/smooth_structures/ledges.dmi'
	var/facesdirection = 0
	var/staircase = FALSE //Has someone built stairs into the rockface?
	pixel_x = -3
	pixel_y = -3
	layer = ABOVE_OPEN_TURF_LAYER

/obj/structure/ledge/Initialize()
	..()
	icon_state = "generic" //Totally hacky but it gets the job done
	update_icon()

/obj/structure/ledge/update_icon()
	..()
	cut_overlays()
	for(var/D in GLOB.cardinals)
		if(!(facesdirection & D))
			continue
		if(istype(src, /obj/structure/ledge/crumbling))
			staircase ? add_overlay("crumblingstairs[dir2text(D)]") : add_overlay("crumbling[dir2text(D)]")
		else
			add_overlay("[dir2text(D)]")
	queue_smooth(src)

/obj/structure/ledge/proc/ledgeCheck(mob/living/M)
	if(M.movement_type == FLYING) //Flying mobs can fly over ledges!
		return FALSE
	else if(staircase)
		return FALSE
	else if(facesdirection & NORTH && y < M.y)
		return TRUE
	else if(facesdirection & EAST && x < M.x)
		return TRUE
	else if(facesdirection & SOUTH && y > M.y)
		return TRUE
	else if(facesdirection & WEST && x > M.x)
		return TRUE

/obj/structure/ledge/CanPass(mob/living/M)
	if(ismob(M) && ledgeCheck(M))
		return FALSE
	else
		return ..()

/obj/structure/ledge/Uncrossed(mob/living/M)
	if(ismob(M) && !(M.incapacitated()) && ledgeCheck(M) && !M.buckled) // If they're not a mob, incapacitated, buckled to anything or other, don't do the hop thing
		to_chat(M, "<span class = 'notice'>You hop over [src]!</span>")
		animate(M, pixel_y = M.pixel_y + 8, time = 2, easing = QUAD_EASING)
		sleep(2)
		animate(M, pixel_y = M.pixel_y - 8, time = 2, easing = QUAD_EASING)
	..()

/obj/structure/ledge/ex_act()
	return

/obj/structure/ledge/crumbling/attackby(obj/item/weapon/pickaxe/W, mob/user)
	if(!istype(W, /obj/item/weapon/pickaxe) || staircase)
		return ..()
	user.visible_message("<span class = 'notice'>[user] is digging into [src]...</span>", "<span class = 'notice'>You begin to hew a crude staircase from the ledge...</span>")
	W.playDigSound()
	if(do_after(user, 100, target = src) && !staircase)
		user.visible_message("<span class = 'notice'>[user] finishes crafting a flight of stairs in [src]!</span>", "<span class = 'notice'>You finish fashioning a flight of rough stone stairs, and clear away the loose rock from your new creation.</span>")
		staircase = TRUE
		W.playDigSound()
		update_icon()
		desc = "A set of rough stone steps allows passage here."

//crumbling ledges can have stairs built into them
/obj/structure/ledge/crumbling
	name = "crumbling ledge"
	desc = "This ledge looks somewhat weathered. You reckon you could dig some stairs into it, if you had the tools and the time."

//Directional ledges for mapping
/obj/structure/ledge/north
	facesdirection = NORTH
	icon_state = "north"

/obj/structure/ledge/northeast
	facesdirection = NORTH|EAST
	icon_state = "northeast"

/obj/structure/ledge/east
	facesdirection = EAST
	icon_state = "east"

/obj/structure/ledge/southeast
	facesdirection = SOUTH|EAST
	icon_state = "southeast"

/obj/structure/ledge/south
	facesdirection = SOUTH
	icon_state = "south"

/obj/structure/ledge/southwest
	facesdirection = SOUTH|WEST
	icon_state = "southwest"

/obj/structure/ledge/west
	facesdirection = WEST
	icon_state = "west"

/obj/structure/ledge/northwest
	facesdirection = NORTH|WEST
	icon_state = "northwest"

/obj/structure/ledge/opentonorth
	facesdirection = EAST|SOUTH|WEST
	icon_state = "opentonorth"

/obj/structure/ledge/opentoeast
	facesdirection = NORTH|SOUTH|WEST
	icon_state = "opentoeast"

/obj/structure/ledge/opentosouth
	facesdirection = NORTH|EAST|WEST
	icon_state = "opentosouth"

/obj/structure/ledge/opentowest
	facesdirection = NORTH|EAST|SOUTH
	icon_state = "opentowest"

/obj/structure/ledge/crumbling/north
	facesdirection = NORTH
	icon_state = "crumblingnorth"

/obj/structure/ledge/crumbling/east
	facesdirection = EAST
	icon_state = "crumblingeast"

/obj/structure/ledge/crumbling/south
	facesdirection = SOUTH
	icon_state = "crumblingsouth"

/obj/structure/ledge/crumbling/west
	facesdirection = WEST
	icon_state = "crumblingwest"
