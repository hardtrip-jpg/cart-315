extends SubViewportContainer
class_name DitherPort

@export var mat_ref : ShaderMaterial

var desirable_bit : float = 1
var current_bit : float = 1

func _ready() -> void:
	Global.view = self
	Global.transition.connect(transition)

func transition(on : bool) -> void:
	if on:
		desirable_bit = 8
	else:
		desirable_bit = 1

func _process(delta: float) -> void:
	desirable_bit = clamp(desirable_bit, 1, 100)
	if int(current_bit) != int(desirable_bit):
		current_bit = lerp(current_bit, desirable_bit, 0.2)
		print(current_bit)
		material.set_shader_parameter(StringName("u_dither_size"),current_bit)
