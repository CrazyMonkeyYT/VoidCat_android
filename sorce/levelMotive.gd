extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():

	pass

func _process(delta):
	position.x -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_charater_keepMoving(velocityOut):
	position -= velocityOut
#	if position.x - velocityOut.x <= -35:
#		position.x += 35
#		var tmp_cells_loc = get_used_cells()
#		var tmp_cell_type = []
#		for cell in len(tmp_cells_loc):
#			tmp_cell_type.append(get_cell(tmp_cells_loc[cell].x, tmp_cells_loc[cell].y))
#			tmp_cells_loc[cell].x -= 1
#		clear()
#		for cell in len(tmp_cells_loc):
#			set_cell(tmp_cells_loc[cell].x,tmp_cells_loc[cell].y, tmp_cell_type[cell])
#	else:
 
#
