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

class TestCaseTest extends TestCase

  assert: (bool) ->
     throw 'assertion failed' if(!bool)

  testRunning: ->
    test = new WasRun 'testMethod'
    @assert !test.wasRun

    test.run()
    @assert test.wasRun

(new TestCaseTest 'testRunning').run()
