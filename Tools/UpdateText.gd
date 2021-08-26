tool
extends RichTextLabel

func _process(delta):
	var owner_text = owner.get("text")
	if owner_text and (owner_text != text):
		text = owner_text
