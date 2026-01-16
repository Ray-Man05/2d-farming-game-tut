class_name Player
extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var base_player_speed: int = 50

var player_direction: Vector2
