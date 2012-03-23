class WasRun
  constructor: (@name) ->
    @wasRun = false

  testMethod: ->
    @wasRun = 1

  run: ->
    this[@name]()

test = new WasRun 'testMethod'
console.log test.wasRun

test.run()
console.log test.wasRun

