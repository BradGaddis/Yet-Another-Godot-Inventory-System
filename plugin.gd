@tool
class_name GenericInventory extends EditorPlugin

const PLUGIN_NAME := "Generic Inventory System"
const PLUGIN_ICON_PATH : String = "uid://dxtmkv7huftji"
const PLUGIN_HANDLER_PATH := "uid://bbsgugbkn1q3t"
const MainPanel := preload("uid://d0mqmjfp7rxy5")

var inspector_plugin: EditorInspectorPlugin = null


## The root. What shows up in the editor
var editor_view: Control

func _init() -> void:
	self.name = "Generic Inventory System"


func _has_main_screen() -> bool:
	return true

func _get_plugin_name() -> String:
	return PLUGIN_NAME

func _get_plugin_icon() -> Texture2D:
	return load(PLUGIN_ICON_PATH)
	
func _enter_tree() -> void:
	editor_view = MainPanel.instantiate()
	editor_view.plugin_reference = self
	#editor_view.size_flags_vertical = Control.SIZE_EXPAND_FILL
	#editor_view
	EditorInterface.get_editor_main_screen().add_child(editor_view)
	

func _exit_tree() -> void:
	if editor_view:
		remove_control_from_bottom_panel(editor_view)
		editor_view.queue_free()

	if inspector_plugin:
		remove_inspector_plugin(inspector_plugin)

func _edit(object) -> void:
	if object == null:
		return
	_make_visible(true)

## Editor Interaction
func _make_visible(visible:bool) -> void:
	if not editor_view:
		return

	if editor_view.get_parent() is Window:
		if visible:
			get_editor_interface().set_main_screen_editor("Script")
			editor_view.show()
			editor_view.get_parent().grab_focus()
	else:
		editor_view.visible = visible
