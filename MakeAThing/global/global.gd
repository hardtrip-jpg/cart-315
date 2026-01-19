extends Node

var label : Label

var view : DitherPort

signal disable_all
signal transition(on: bool)

var def_framerate := 15

func _ready() -> void:
	Engine.max_fps = def_framerate
