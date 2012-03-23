class TestCase
  constructor: (@name) ->

  run: ->
    this[@name]()

class WasRun extends TestCase

  constructor: (@name) ->
    @wasRun = false
    super(@name)

  testMethod: ->
    @wasRun = 1

test = new WasRun 'testMethod'
console.log test.wasRun

test.run()
console.log test.wasRun

