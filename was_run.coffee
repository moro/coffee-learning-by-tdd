myUnit = require('./test_case')

class WasRun extends myUnit.TestCase

  constructor: (@name) ->
    super(@name)

  setup: ->
    @log = "setup "

  testMethod: ->
    @log += "testMethod "

  testBrokenMethod: ->
    throw 'broken'

  teardown: ->
    @log += "teardown "

class TestCaseTest extends myUnit.TestCase

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

  testFailedResult: ->
    test = new WasRun 'testBrokenMethod'
    result = test.run()
    @assert '1 run, 1 failed' == result.summary()

  testFailedResultFormatting: ->
    result = new myUnit.TestCase.TestResult
    result.testStarted()
    result.testFailed()
    @assert '1 run, 1 failed' == result.summary()

(new TestCaseTest 'testTemplateMethod').run()
(new TestCaseTest 'testResult').run()
(new TestCaseTest 'testFailedResult').run()
(new TestCaseTest 'testFailedResultFormatting').run()

