# TODO: convert fs.readFile with Do.convert
# TODO: refactor loading code

sys = require 'sys'
http = require 'http'
crypto = require 'crypto'
fs = require 'fs'

Do = require 'do'
Haml = require 'hamljs'
Sass = require 'sass'
CoffeeScript = require 'coffee-script'

fs = Do.convert fs, ['readFile']

fileNames = ['test.haml', 'client.coffee', 'test.sass']
files = {}

runServer = ->
  sys.puts "Haml = \n" + files['test.haml'] +"\n"
  sys.puts "Sass = \n" + files['test.sass'] + "\n"
  sys.puts "CoffeeScript = \n" + files['client.coffee'] + "\n"
  client_html = Haml.render files['test.haml']
  client_css = Sass.render files['test.sass']
  client_js = CoffeeScript.compile files['client.coffee']
  http.createServer (req, res) ->
    if req.method is 'GET'
      if req.url is '/'
        res.writeHead 200, {'Content-Type': 'text/html'}
        res.end client_html
      else if req.url is '/client.js'
        res.writeHead 200, {'Content-Type': 'text/javascript'}
        res.end client_js
      else if req.url is '/test.css'
        res.writeHead 200, {'Content-Type': 'text/css'}
        res.end client_css
      else
        res.writeHead 404, {'Content-Type': 'text/html'}
        res.end 'Bad luck!'
  .listen 8000

  sys.puts 'Server running at http://127.0.0.1:8000/'

sys.puts ('fileNames.length = ' + fileNames.length)

loadFiles = Do.map fileNames, (fileName, callback, errback) ->
  storeFile = (file) ->
    files[fileName] = file
    sys.puts ("Loaded = " + fileName)
    callback()
  (fs.readFile fileName, 'utf8') storeFile, errback

loadFiles runServer, (err) -> throw err

