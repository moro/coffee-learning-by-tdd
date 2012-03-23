class TestCase
  constructor: (@name) ->

  setup: ->

  teardown: ->

  run: ->
    @setup()
    this[@name]()
    @teardown()
    new TestResult

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

  testResult: ->
    test = new WasRun 'testMethod'
    result = test.run()
    @assert '1 run, 0 failed' == result.summary()

class TestResult
  summary: ->
    '1 run, 0 failed'

(new TestCaseTest 'testTemplateMethod').run()
(new TestCaseTest 'testResult').run()

