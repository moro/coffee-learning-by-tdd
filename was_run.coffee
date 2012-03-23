class TestCase
  constructor: (@name) ->

  setup: ->

  teardown: ->

  run: (result) ->
    result.testStarted()
    @setup()
    try
      this[@name]()
    catch error
      result.testFailed()

    @teardown()

class TestResult
  constructor: ->
    @runCount = 0
    @errorCount = 0

  testStarted: ->
    @runCount += 1

  testFailed: ->
    @errorCount += 1

  summary: ->
    "#{@runCount} run, #{@errorCount} failed"

class TestSuite
  constructor: ->
    @tests = []

  add: (test)->
    @tests = @tests.concat test

  run: (result)->
    for test in @tests
      test.run(result)


class WasRun extends TestCase

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

class TestCaseTest extends TestCase

  setup: ->
    @result = new TestResult

  assert: (bool) ->
     throw 'assertion failed' if(!bool)

  testTemplateMethod: ->
    test = new WasRun 'testMethod'
    test.run(@result)
    @assert "setup testMethod teardown " == test.log

  testResult: ->
    test = new WasRun 'testMethod'
    test.run(@result)
    @assert '1 run, 0 failed' == @result.summary()

  testFailedResult: ->
    test = new WasRun 'testBrokenMethod'
    test.run(@result)
    @assert '1 run, 1 failed' == @result.summary()

  testFailedResultFormatting: ->
    @result.testStarted()
    @result.testFailed()
    @assert '1 run, 1 failed' == @result.summary()

  testSuite: ->
    suite = new TestSuite
    result = new TestResult
    suite.add new WasRun 'testMethod'
    suite.add new WasRun 'testBrokenMethod'
    suite.run(result)

    @assert '2 run, 1 failed' == result.summary()

suite = new TestSuite
suite.add(new TestCaseTest 'testTemplateMethod')
suite.add(new TestCaseTest 'testResult')
suite.add(new TestCaseTest 'testFailedResult')
suite.add(new TestCaseTest 'testFailedResultFormatting')
suite.add(new TestCaseTest 'testSuite')

result = new TestResult
suite.run(result)

console.log result.summary()

