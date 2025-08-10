extends Area3D

@export var doors_open : Array[Node3D]
@export var doors_close : Array[Node3D]



func _on_body_entered(body:Node3D) -> void:
    if(body.get("is_player")):
        print("ye")
        for i in doors_open:
            print(i)
            i.open_door()
        for i in doors_close:
            i.close_door()
