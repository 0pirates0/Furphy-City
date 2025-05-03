extends Node

@export var day_canvas: CanvasLayer
@export var night_canvas: CanvasLayer

@export var day_rect: ColorRect
@export var night_rect: ColorRect
@onready var evilspell_part_1 = $evilspell_part1
@onready var evilspell_part_2 = $evilspell_part2
@onready var evilspell_part_3 = $evilspell_part3
@onready var evilspell_part_4 = $evilspell_part4
var chicks = preload("res://Scenes/NPCs/chick.tscn")
var cow_woman = preload("res://Scenes/NPCs/cow_woman.tscn")

@export var day_part: GPUParticles2D
@export var night_part: GPUParticles2D

@export var fade_duration: float = 2.0  # seconds to fully fade
@export var cycle_interval: float = 15.0  # 15 minutes = 900 seconds
@onready var chickspawner_1 = $chickspawner1
@onready var chickspawner_2 = $chickspawner2
@onready var chickspawner_3 = $chickspawner3
@onready var chickspawner_4 = $chickspawner4
@onready var chickspawner_5 = $chickspawner5
@onready var cow_womanspawner = $cow_womanspawner



var is_day = true

func _ready():
	day_part = $day/clouds
	night_part = $night/stars
	day_rect = $day/dayrect
	night_rect = $night/nightrect
	day_rect.modulate.a = 1.0
	night_rect.modulate.a = 0.0
	cow_womanspawner.add_child(cow_woman.instantiate())
	start_cycle()

func chickspawner():
	chickspawner_2.add_child(chicks.instantiate())
	chickspawner_1.add_child(chicks.instantiate())
	chickspawner_3.add_child(chicks.instantiate())
	chickspawner_4.add_child(chicks.instantiate())
	chickspawner_5.add_child(chicks.instantiate())

func start_cycle():
	chickspawner()
	# Start with day
	cycle()

func cycle():
	if is_day:
		fade(day_rect, 1.0, 0.0)  # fade out day
		fade(night_rect, 0.0, 1.0)  # fade in night
		day_part.visible = false
		night_part.visible = true
		#evil spell particles
		evilspell_part_1.visible = true
		evilspell_part_2.visible = true
		evilspell_part_3.visible = true
		evilspell_part_4.visible = true
	else:
		fade(night_rect, 1.0, 0.0)  # fade out night
		fade(day_rect, 0.0, 1.0)    # fade in day
		day_part.visible = true
		night_part.visible = false
		#evil spell particles
		evilspell_part_1.visible = false
		evilspell_part_2.visible = false
		evilspell_part_3.visible = false
		evilspell_part_4.visible = false
	
	is_day = !is_day
	# Schedule next switch
	await get_tree().create_timer(cycle_interval).timeout
	cycle()

func fade(rect: ColorRect, from_alpha: float, to_alpha: float):
	var tween = create_tween()
	rect.modulate.a = from_alpha
	tween.tween_property(rect, "modulate:a", to_alpha, fade_duration)
