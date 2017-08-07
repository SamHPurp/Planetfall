/*
Colony Director
*/
/datum/job/cd
	title = "Colony Director"
	flag = CAPTAIN
	department_flag = CIVILIAN
	faction = "Colony"
	total_positions = 1
	spawn_positions = 1
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 0

	outfit = /datum/outfit/job/cd

/datum/outfit/job/cd
	name = "Colony Director"
	jobtype = /datum/job/cd

	belt = /obj/item/device/pda/captain
	uniform =  /obj/item/clothing/under/rank/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat

	backpack = /obj/item/weapon/storage/backpack/captain
	satchel = /obj/item/weapon/storage/backpack/satchel/cap
	duffelbag = /obj/item/weapon/storage/backpack/duffelbag/captain

/*
Basic Colonist
*/
/datum/job/colonist
	title = "Colonist"
	flag = ASSISTANT
	department_flag = CIVILIAN
	faction = "Colony"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Colony Director"
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/colonist

/datum/outfit/job/colonist
  name = "Colonist"
  jobtype = /datum/job/colonist
