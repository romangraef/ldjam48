extends Level

onready var buttons = $ButtonHolder.get_children()
onready var timer_label = $TimerLabel
var sequence_index = 0

var timer = 0

func _total_time():
	if Settings.difficulty == Settings.Difficulty.HARD:
		return 6
	if Settings.difficulty == Settings.Difficulty.PEACEFUL:
		return 60
	return 10

func start():
	.start()

var started = false

func _ready():
	timer = 0
	started = false
	for i in range(buttons.size()):
		buttons[i].connect("on_click", self, "_on_Any_button_click", [i])
		buttons[i].text = str(i + 1)
		if i != 0:
			buttons[i].visible = false

func _process(delta):
	if running and started:
		timer += delta
	timer_label.text = str(_total_time() - timer)
	if timer >= _total_time():
		lose_all_hearts()

func _on_Any_button_click(btn_idx):
	started = true
	if btn_idx == sequence_index:
		sequence_index += 1
		if sequence_index == buttons.size():
			running = false
			finish_level()
			return
		buttons[sequence_index].visible = true
		print("Correct button: ", btn_idx)
	else:
		lose_heart()
		print("Incorrect button: ", btn_idx)
