GAMEN_YOKO = 1280
GAMEN_TATE = 720

enchant()

core = {}

window.onload = ->

  core = new Core(GAMEN_YOKO, GAMEN_TATE)

  core.onload = ->

  core.start()
