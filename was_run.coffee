class TestCase
  constructor: (@name) ->

  setup: ->

  run: ->
    @setup()
    this[@name]()

class WasRun extends TestCase

  constructor: (@name) ->
    super(@name)

  setup: ->
    @wasRun = false
    @log = "setup "

  testMethod: ->
    @wasRun = 1
    @log += "testMethod "

class TestCaseTest extends TestCase

  assert: (bool) ->
     throw 'assertion failed' if(!bool)

  testTemplateMethod: ->
    test = new WasRun 'testMethod'
    test.run()
    @assert "setup testMethod " == test.log

(new TestCaseTest 'testTemplateMethod').run()

