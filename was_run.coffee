class TestCase
  constructor: (@name) ->

  setup: ->

  teardown: ->

  run: ->
    @setup()
    this[@name]()
    @teardown()

class WasRun extends TestCase

  constructor: (@name) ->
    super(@name)

  setup: ->
    @log = "setup "

  testMethod: ->
    @log += "testMethod "
  teardown: ->
    @log += "teardown "

class TestCaseTest extends TestCase

  assert: (bool) ->
     throw 'assertion failed' if(!bool)

  testTemplateMethod: ->
    test = new WasRun 'testMethod'
    test.run()
    @assert "setup testMethod teardown " == test.log

(new TestCaseTest 'testTemplateMethod').run()

