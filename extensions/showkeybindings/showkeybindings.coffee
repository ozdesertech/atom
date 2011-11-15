_ = require 'underscore'
$ = require 'jquery'
fs = require 'fs'

Browser = require 'browser'

module.exports =
class Showkeybindings extends Browser
  window.resourceTypes.push this

  constructor: ->
    atom.keybinder.load require.resolve "showkeybindings/key-bindings.coffee"
    @running = true

  open: (url) ->
    return if not url

    if url is 'atom://keybindings'
      @title = 'Keybindings'
      @url = url
      @show()
      true

  innerHTML: ->
    html = '''
      <link rel="stylesheet" href="http://twitter.github.com/bootstrap/1.4.0/bootstrap.min.css">
      <style>body { padding:10px; }</style>
    '''
    html += '<h1>Keybindings</h1>'
    for name, bindings of atom.keybinder.keymaps
      html += "<h3>#{name}</h3>"
      html += "<ul>"
      for binding, method of bindings
        html += """
        <li>#{atom.keybinder.bindingFromAscii(binding)} - #{method}</li>
        """
      html += "</ul>"
    html

  show: ->
    super @innerHTML()
