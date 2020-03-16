extends Control

var AbilityItem = preload("res://Interface/Components/AbilityItem.tscn")

func _ready():
	var first_el = $Core/ShipList/ShipItem
	
	for el in $Core/ShipList.get_children():
		el.connect("pressed", self, "_change_ship_details", [
			el.ship_id,
			el.ship_scene_path,
			el.ship_type,
			el.lore,
			el.abilities
		])
		
	_change_ship_details(
		first_el.ship_id, 
		first_el.ship_scene_path,
		first_el.ship_type,
		first_el.lore,
		first_el.abilities
	)

func _change_ship_details(id, path, type, lore, abilities):
	
	$Core/LeftSegment/DetailsContainer/Details/RichTextLabel.set_text(lore)
	$Core/LeftSegment/DetailsContainer/Details/Title.set_text(type)
	
	var children = $Core/LeftSegment/DetailsContainer/Abilities/AbilityContainer.get_children()
	
	for i in children:
		i.queue_free()
	
	for ab in abilities:
		var item = AbilityItem.instance()
		item.find_node("Label").set_text(ab)
		# item.find_node("Icon").set()
		$Core/LeftSegment/DetailsContainer/Abilities/AbilityContainer.add_child(item)
		
	load_mesh(path)
	
func load_mesh(path):
	print("Loading mesh from " + path)
	var ShipMesh = load(path)
	var viewport = $Core/LeftSegment/ViewportContainer/Viewport/Ships
	
	for i in viewport.get_children():
		i.queue_free()
	# find the previous mesh node if it exists and remove it.
	
	var ship = ShipMesh.instance()
	
	#ship.scale = Vector3()
	ship.translation = Vector3(0, 2, 0)
	#ship.start_animation()
	viewport.add_child(ship)
	
