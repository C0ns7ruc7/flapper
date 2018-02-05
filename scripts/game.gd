#script: game
extends Node

const GROUP_PIPES   = "pipes"
const GROUP_GROUNDS = "grounds"
const GROUP_BIRDS   = "birds"

var score_current   = 0 setget _set_score_current
var score_best      = 0 setget _set_score_best
var score_total     = 10 setget _set_score_total

signal score_best_changed
signal score_current_changed
signal score_total_changed

func _ready():
	pass

func _set_score_current(new_value):
	score_current = new_value
	emit_signal("score_current_changed")
	pass

func _set_score_best(new_value):
	score_best = new_value
	emit_signal("score_best_changed")
	pass

func _set_score_total(new_value):
	score_total = new_value
	emit_signal("score_total_changed")
	pass