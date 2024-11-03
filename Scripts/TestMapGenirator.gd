extends GridMap

#index of selected maptiles
var Hallway_Tile = [0,1,2]
#8.305 is the current one i use for the grid map, double check if it is correct
var Hallway_Length = 8.305
#000 is temp but should be the exit location of the start map
var Start_Pos = Vector3(0,0,0)


func _ready() -> void:
	Generate_Hallways()
	pass 

func Generate_Hallways():
	var	Current_pos = Start_Pos
	var i = 0
	while i < 3:
	#for i in range(Hallway_Length):
		var index = Hallway_Tile[randi() % Hallway_Tile.size()]
		set_cell_item(Current_pos, index)
		
		Current_pos += Vector3(8.305,0,0)
		i += 1
	
