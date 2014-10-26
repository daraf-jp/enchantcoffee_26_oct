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

    @taniGoukei = new TaniGoukei()
    @addChild @taniGoukei

  onenterframe: ->
    if @seigenJikan.nokoriFrame < 0
      core.gameOverGamen = new GameOverGamen()
      core.replaceScene core.gameOverGamen

    if @age % 30 is 0
      tani = new Tani()
      @addChild tani

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

class SeigenJikan extends Label
  constructor: (jikan) ->
    super()
    @width = 180
    @textAlign = 'center'
    @moveTo(25, 60)
    @font = '48px Serif'
    @color = 'white'

    @nokoriFrame = jikan * core.fps

  onenterframe: ->
    @nokoriFrame--
    nokoriJikan = @nokoriFrame / core.fps
    @text = nokoriJikan.toFixed(2).toString()

class TaniGoukei extends Label
  constructor: ->
    super()
    @text  = '0'
    @width = 600
    @textAlign = 'center'
    @font = '80px Serif'
    @color = 'white'
    @moveTo 325, 250

    @tani = 0

  rishu: ->
    @tani++
    @text = @tani.toString()

class Tani extends Sprite
  constructor: ->
    super 95, 100
    @image = core.assets['print.png']

    @x = Math.random() * (GAMEN_YOKO - @width)
    @y = -@height

  onenterframe: ->
    @y += 4

class GameOverGamen extends Scene
  constructor: () ->
    super()
    haikei = new Sprite(GAMEN_YOKO, GAMEN_TATE)

    haikei.image = core.assets['game_over1.png']

    @addChild haikei

  ontouchstart: ->
    core.replaceScene core.titleGamen
