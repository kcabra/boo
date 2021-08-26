extends Control
# Text typing challenge


signal completed
signal mistook

export (String, MULTILINE) var text
var current_index = 0

onready var hidden = self


func _ready():
	hidden.visible_characters = 0


func _input(event):
	if not (event is InputEventKey):
		return
	if event.is_echo() or (not event.pressed):
		return
	
	var key: String = event.as_text()
	print(key)
	# Only letters and numbers have length 1
	# Other symbols have long names
	
	if key == "Shift+1":
		attempt_key("!")
	elif key == "Shift+8":
		attempt_key("*")
	elif key == "Question" or key == "Shift+Slash":
		attempt_key("?")
	else:
		key = key.replace("Shift+", "")
	
	if key.length() == 1:
		attempt_key(key)
	elif key == "Space":
		attempt_key(" ")
	elif key == "Comma":
		attempt_key(",")
	elif key == "Period":
		attempt_key(".")


func attempt_key(guessed):
	var current = current_char()
	if not current:
		return
	
	current = normalize(current)
	
	if guessed != current:
		emit_signal("mistook")
	else:
		current_index += 1
		hidden.visible_characters += 1
		check_completion()


func current_char():
	if current_index >= text.length():
		return
	
	var next = text[current_index]
	
	if next == "\n":
		current_index += 1
		return current_char()
	else:
		return next


func normalize(letter: String):
	letter = letter.to_upper()
	var normal = letter
	
	if letter in "ÃÂÁÀ":
		normal = "A"
	elif letter in "ẼÊÉÈ":
		normal = "E"
	elif letter in "ĨÎÍÌ":
		normal = "I"
	elif letter in "ÕÔÓÒ":
		normal = "O"
	elif letter in "ŨÛÚÙ":
		normal = "U"
	
	return normal


func check_completion():
	if current_index >= text.length():
			emit_signal("completed")
