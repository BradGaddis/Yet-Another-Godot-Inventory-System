class_name Menu extends Control
## Base class for menus. Controls interactable gui elements.

## The default focus when opening a menu
@export var _default_focus_item: Control 
## The trail of menus open before the current one
@export var _breadcrumb : Menu

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	if not _default_focus_item: 
		_default_focus_item = find_children("*", "Control", true)[0]

## Makes visible and closes the previous menu breadcrumb
func open(breadcrumb: Menu = null):
	if breadcrumb:
		breadcrumb.close()
		_breadcrumb = breadcrumb
	visible = true
	_default_focus_item.grab_focus()

## Closes this menus and opens the previous menu breadcrumb
func close(close_all: bool = false):
	visible = false
	if _breadcrumb and not close_all:
		_breadcrumb.open()
		_breadcrumb = null
