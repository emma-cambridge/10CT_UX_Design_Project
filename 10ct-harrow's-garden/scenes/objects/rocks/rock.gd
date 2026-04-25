extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(_on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func _on_hurt(hit_damage: int) -> void:
	print("on hurt")
	damage_component.apply_damage(hit_damage)
	await get_tree().create_timer(1.0).timeout

func on_max_damage_reached() -> void:
	call_deferred("add_stone_scene")
	queue_free()

func add_stone_scene() -> void:
	var stone_instance = stone_scene.instantiate() as Node2D 
	stone_instance.global_position = global_position
	get_parent().add_child(stone_instance)
