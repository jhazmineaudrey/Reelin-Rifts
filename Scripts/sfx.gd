extends Node
@onready var cat_meow: AudioStreamPlayer = $CatMeow
@onready var fish_start: AudioStreamPlayer = $FishStart
@onready var water_splash: AudioStreamPlayer = $WaterSplash
@onready var reel_in: AudioStreamPlayer = $ReelIn
@onready var laser: AudioStreamPlayer = $Laser
@onready var laser_retract: AudioStreamPlayer = $LaserRetract
@onready var light_dimension_fish: AudioStreamPlayer = $LightDimensionFish
@onready var light_dimension_hit: AudioStreamPlayer = $LightDimensionHit
@onready var light_dimension_fish_end: AudioStreamPlayer = $LightDimensionFishEnd
@onready var open_bag: AudioStreamPlayer = $OpenBag
@onready var successfully_fished: AudioStreamPlayer = $SuccessfullyFished
@onready var drag: AudioStreamPlayer = $Drag
@onready var drag_reset: AudioStreamPlayer = $DragReset
@onready var fish_thud: AudioStreamPlayer = $FishThud

@onready var normal_bgs: AudioStreamPlayer = $NormalBGS
@onready var void_bgs: AudioStreamPlayer = $VoidBGS
@onready var light_bgs: AudioStreamPlayer = $LightBGS
@onready var cat_scene_bgm: AudioStreamPlayer = $CatSceneBGM

func _on_normal_bgs_finished() -> void:
	normal_bgs.play()

func _on_void_bgs_finished() -> void:
	void_bgs.play()

func _on_light_bgs_finished() -> void:
	light_bgs.play()

func _on_reel_in_finished() -> void:
	reel_in.play()

func _on_cat_scene_bgm_finished() -> void:
	cat_scene_bgm.play()
