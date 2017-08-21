/turf/open/floor/planet
	name = "bare earth"
	gender = PLURAL
	icon = 'icons/turf/floors/planet.dmi'
	icon_state = "dirt"
	initial_gas_mix = PLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	layer = HIGH_TURF_LAYER
	light_power = 3
	light_range = 3
	var/turfverb = "dig up"
	var/candigturf = TRUE
	var/ore_type = /obj/item/weapon/ore/glass

/turf/open/floor/planet/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/stack/tile))
		if(!broken && !burnt)
			var/obj/item/stack/tile/W = C
			if(!W.use(1))
				return
			var/turf/open/floor/T = ChangeTurf(W.turf_type)
			if(istype(W, /obj/item/stack/tile/light)) //TODO: get rid of this ugly check somehow
				var/obj/item/stack/tile/light/L = W
				var/turf/open/floor/light/F = T
				F.state = L.state
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
	else if(istype(C, /obj/item/weapon/crowbar))
		return
	else if(istype(C, /obj/item/weapon/shovel))
		if(!candigturf)
			to_chat(user, "<span class = 'warning'>You can't dig that!</span>")
			return ..()
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1)
		if(do_after(user, 20, target = src) && candigturf)
			user.visible_message("<span class = 'notice'>[user] digs up [src].</span>", "<span class = 'notice'>You [turfverb] [src].</span>")
			digDown(dropsloot = TRUE) //Make some sand after the user digs up some turf
	else
		..()

/turf/open/floor/planet/ex_act(severity, target, destructionoverride = TRUE)
	..()
	if(severity == 1)
		digDown(toBedrock = TRUE)
	else if(severity == 2 && prob(60))
		digDown(toBedrock = TRUE)
	else if(severity == 2)
		digDown(dropsloot = TRUE, fire = TRUE)
	else if(severity == 3 && prob(75))
		digDown(dropsloot = TRUE, fire = TRUE)

/turf/open/floor/planet/proc/addTurfEdge(turfedgefile = 'icons/turf/floors/turf-overlays.dmi', overlayname) //Normally you'd probably use the icon_smoothing stuff but that doesn't allow for multiple icon_state of the same turf
	var/mutable_appearance/turfedge = mutable_appearance(turfedgefile, overlayname, layer - 0.001) //Slightly hacky fix to make the border go beneath the actual turf
	turfedge.pixel_x -= 4
	turfedge.pixel_y -= 4
	add_overlay(turfedge)

/turf/open/floor/planet/proc/digDown(dropsloot = FALSE, fire = FALSE, toBedrock = FALSE)
	if(!candigturf)
		return
	if(dropsloot)
		new ore_type(src)
		new ore_type(src)
	if(toBedrock)
		ChangeTurf(baseturf)
	else if(layer == HIGH_TURF_LAYER)
		ChangeTurf(/turf/open/floor/planet/dirt)
	else if(layer == MID_TURF_LAYER)
		ChangeTurf(baseturf)
	if(fire)
		hotspot_expose(1000,CELL_VOLUME)

///////////BEDROCK/////////

/turf/open/floor/planet/bedrock
	name = "bedrock"
	desc = "This is solid rock. Good luck getting through this."
	layer = BEDROCK_TURF_LAYER //Lowest layer
	icon_state = "bedrock-1"
	candigturf = FALSE

/turf/open/floor/planet/bedrock/Initialize()
	icon_state = "bedrock-[rand(1, 8)]"
	return ..()

////////////GRASS///////////////

/turf/open/floor/planet/grass
	name = "grass"
	icon_state = "grass-1"
	turfverb = "uproot"

/turf/open/floor/planet/grass/Initialize()
	icon_state = "grass-[rand(1, 4)]"
	addTurfEdge(overlayname = "grass-border")
	..()

/////////////DIRT///////////

/turf/open/floor/planet/dirt
	name = "dirt"
	layer = MID_TURF_LAYER
	candigturf = FALSE

/turf/open/floor/planet/dirt/greenerdirt
	icon_state = "greenerdirt"
	turfverb = "uproot"

turf/open/floor/planet/dirt/Initialize()
	addTurfEdge(overlayname = "dirt-border")
	..()

///////////WOOD////////////

/turf/open/floor/planet/wood
	gender = NEUTER
	name = "wooden floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wood"
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")
	light_power = 0
	light_range = 0
	candigturf = FALSE

/turf/open/floor/planet/wood/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/screwdriver))
		pry_tile(C, user)
		return
	else if(intact && istype(C, /obj/item/weapon/crowbar))
		return pry_tile(C, user)
	else if(istype(C, /obj/item/stack/tile))
		return
	else
		..()

///////////SAND///////////

/turf/open/floor/planet/sand
	name = "sand"
	icon_state = "sand"

/turf/open/floor/planet/sand/fine
	icon_state = "asteroid"

/turf/open/floor/planet/sand/fine/Initialize()
	if(prob(5))
		icon_state = "asteroid[rand(0,12)]"
	..()

//////////WATER//////////
/turf/open/floor/planet/water
	name = "ocean"
	icon_state = "riverwater"
	gender = NEUTER
	candigturf = FALSE
	layer = BEDROCK_TURF_LAYER

/turf/open/floor/planet/water/ocean
	name = "ocean"

/turf/open/floor/planet/water/lake
	name = "lake"

/turf/open/floor/planet/water/river
	name = "river"

/turf/open/floor/planet/water/break_tile()
	return

//////////WALLS//////////

/turf/closed/wall/planet
	initial_gas_mix = PLANET_DEFAULT_ATMOS

/turf/closed/wall/planet/wood_wall
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood"
	sheet_type = /obj/item/stack/sheet/mineral/wood
	hardness = 70
	explosion_block = 0
	canSmoothWith = list(/turf/closed/wall/mineral/wood, /obj/structure/falsewall/wood, /turf/closed/wall/planet/wood_wall)

/turf/closed/wall/planet/shuttle
	icon = 'icons/turf/shuttle.dmi'

/turf/closed/wall/planet/indestructible
	explosion_block = 50

/turf/closed/wall/planet/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/wall/planet/indestructible/rock
	name = "dense rock"
	desc = "An extremely densely-packed rock, most mining tools or explosives would never get through this."
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"
