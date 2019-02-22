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
      c = @colors
      for i from 0 til @text.length =>
        nodes.push """<span#{if c => ' style="color:' + c[i % c.length] + '"' else ''}>#{@text[i]}</span>"""
      for idx from 0 til @animations.length =>
        a = @animations[idx]
        cls = a.className
        ani = a.animation
        nodes = nodes.map (d,i) -> 
          delay = (a.latency or 1) * i / nodes.length
          """<span class="#cls" style="
          #{if ani => 'animation:' + ani + ';' else ''}animation-delay:#{delay}s">#d</span>"""
      @root.innerHTML = nodes.join('')

  if module? => module.exports = ldText
  if window => window.ldText = ldText
)!
