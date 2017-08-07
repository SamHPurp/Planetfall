/turf/open/floor/planet
 icon_state = "dirt"
 initial_gas_mix = PLANET_DEFAULT_ATMOS
 planetary_atmos = TRUE

/turf/open/floor/planet/grass
	icon_state = "grass"

/turf/open/floor/planet/dirt

/turf/open/floor/planet/greenerdirt
	icon_state = "greenerdirt"

/turf/open/floor/planet/wood
	icon_state = "wood"
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")

/turf/open/floor/planet/sand
	icon_state = "sand"

/turf/open/floor/planet/fine_sand
	icon_state = "asteroid"

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
	canSmoothWith = list(/turf/closed/wall/mineral/wood, /obj/structure/falsewall/wood)

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
