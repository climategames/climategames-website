backdropBreathe =
  container: $(".container.backdrop")
  mouseX: 0
  mouseY: 0
  traceStep: 10
  breathPhase: 0
  active:true
  offsetScale: 0
  offsetX: 0
  offsetY: 0

  breathSize: ->
    scale = backdropBreathe.offsetScale + (Math.sin(backdropBreathe.breathPhase * 0.07))
    scale + '%'

  xPos: ->
    distance = backdropBreathe.mouseX / 200
    emPos = backdropBreathe.offsetX + distance
    emPos + 'em'

  yPos: ->
    distance = backdropBreathe.mouseY / 200
    emPos = backdropBreathe.offsetY + distance
    emPos + 'em'

  tickBreath: ->
    backdropBreathe.breathPhase += 1

  updateScaling: ->
    backdropBreathe.container.css { "background-size":backdropBreathe.breathSize() }
    backdropBreathe.container.css { "background-position": backdropBreathe.xPos() + " " + backdropBreathe.yPos() }

  updateMouseLocation: (e) ->
    backdropBreathe.mouseX = e.pageX
    backdropBreathe.mouseY = e.pageY

  tick: ->
    if backdropBreathe.active
      backdropBreathe.updateScaling()
      backdropBreathe.tickBreath()

  init: ->
    $(document).mousemove backdropBreathe.updateMouseLocation
    backdropBreathe.loop = setInterval backdropBreathe.tick, 50
    backdropBreathe.offsetScale = backdropBreathe.container.data("scale") || 30
    backdropBreathe.offsetX = backdropBreathe.container.data("x") || 32
    backdropBreathe.offsetY = backdropBreathe.container.data("y") || 1

  start: ->
    backdropBreathe.active = true

  stop: ->
    backdropBreathe.active = false

backdropBreathe.init()
window.backdropBreathe = backdropBreathe
