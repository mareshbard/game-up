extends Node2D

@onready var cut_1 = $Cut1
@onready var cut_2 = $Cut2
@onready var cut_3 = $Cut3
@onready var cut_4 = $Cut4
@onready var cut_5 = $Cut5
@onready var cut_6 = $Cut6
@onready var cut_7 = $Cut7
@onready var cut_8 = $Cut8
@onready var cut_9 = $Cut9
@onready var cut_10 = $Cut10
@onready var cut_11 = $Cut11

func _on_botao_1_pressed() -> void:
	cut_1.hide()
	cut_2.show()

func _on_botao_2_pressed() -> void:
	cut_2.hide()
	cut_3.show()

func _on_botao_3_pressed() -> void:
	cut_3.hide()
	cut_4.show()

func _on_botao_4_pressed() -> void:
	cut_4.hide()
	cut_5.show()

func _on_boato_5_pressed() -> void:
	cut_5.hide()
	cut_6.show()

func _on_boato_6_pressed() -> void:
	cut_6.hide()
	cut_7.show()

func _on_botao_7_pressed() -> void:
	cut_7.hide()
	cut_8.show()

func _on_botao_8_pressed() -> void:
	cut_8.hide()
	cut_9.show()

func _on_botao_9_pressed() -> void:
	cut_9.hide()
	cut_10.show()

func _on_botao_10_pressed() -> void:
	cut_10.hide()
	cut_11.show()
