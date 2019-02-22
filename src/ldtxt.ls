(->
  ldText = (opt = {}) ->
    @opt = opt
    @root = if !opt.root => document.createElement("div")
    else if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
    @root.classList.add \ldtxt
    @set-text(@opt.text or @root.textContent)
    @animations = opt.animations or []
    @colors = opt.colors or null
    @prepare!
    @

  ldText.prototype = Object.create(Object.prototype) <<< do
    set-text: -> @text = it or " ... oi.loading.io ..."
    prepare: ->
      nodes = []
      text = @text
      c = @colors
      if @opt.by-word =>
        [text,_] = [[], @text.split(' ')]
        _ = @text.split(' ')
        for i from 0 til _.length => text.push _[i]; text.push ' '
      for i from 0 til text.length =>
        nodes.push """<span#{if c => ' style="color:' + c[i % c.length] + '"' else ''}>#{text[i]}</span>"""
      for idx from 0 til @animations.length =>
        a = @animations[idx]
        [cls,ani,dur,lat,delay] = [a.className, a.animation, a.duration, a.latency, a.delay]
        nodes = nodes.map (d,i) -> 
          _delay = (delay or 0) + (lat or 1) * i / nodes.length
          """<span class="#cls" style="
          #{if ani => 'animation:' + ani + ';' else ''}animation-delay:#{_delay}s;
          #{if dur => 'animation-duration:' + dur + 's;' else ''}">#d</span>"""
      @root.innerHTML = nodes.join('')

  if module? => module.exports = ldText
  if window => window.ldText = ldText
)!
