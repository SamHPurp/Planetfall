/datum/round_event_control/wizard/darkness
	name = "Advanced Darkness"
	weight = 0
	typepath = /datum/round_event/wizard/darkness
	max_occurrences = 0
	earliest_start = 0

/datum/round_event/wizard/darkness
	endWhen = 0
	var/started = FALSE


/datum/round_event/wizard/darkness/start()
	if(!started)
		started = TRUE
		SSweather.run_weather("advanced darkness", ZLEVEL_STATION)
