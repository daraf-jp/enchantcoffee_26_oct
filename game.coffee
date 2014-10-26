GAMEN_YOKO = 1280
GAMEN_TATE = 720

enchant()

core = {}

window.onload = ->

  core = new Core(GAMEN_YOKO, GAMEN_TATE)

  gazou = []
  gazou.push 'title.png'
  gazou.push 'game.png'
  gazou.push 'game_over1.png'
  gazou.push 'game_over2.png'
  gazou.push 'mol.png'
  gazou.push 'print.png'

  core.preload gazou

  core.onload = ->
    @titleGamen = new TitleGamen()
    @pushScene @titleGamen

  core.start()

class TitleGamen extends Scene
  constructor: ->
    super()
    haikei = new Sprite(GAMEN_YOKO, GAMEN_TATE)
    haikei.image = core.assets['title.png']
    @addChild haikei

  ontouchstart: ->
    core.gameGamen = new GameGamen()
    core.replaceScene core.gameGamen

class GameGamen extends Scene
  constructor: ->
    super()

    haikei = new Sprite(GAMEN_YOKO, GAMEN_TATE)
    haikei.image = core.assets['game.png']
    @addChild haikei

    @mol = new Mol()
    @addChild @mol

    @seigenJikan = new SeigenJikan(30)
    @addChild @seigenJikan

class Mol extends Sprite
  constructor: ->
    super 151, 169
    @image = core.assets['mol.png']
    @moveTo GAMEN_YOKO / 2 - @width, 500

  ontouchmove: (e) ->
    if e.x - @width / 2 > @x
      @frame = 0
    else
      @frame = 1

    @x = e.x - @width / 2
    # @y = e.y - @height / 2
