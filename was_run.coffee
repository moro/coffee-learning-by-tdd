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

  register: (testCase) ->
    for k, v of testCase.prototype
      if k.match(/^test/)
        @add(new testCase k)


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
    suite.add new WasRun 'testMethod'
    suite.add new WasRun 'testBrokenMethod'
    suite.run(@result)

    @assert '2 run, 1 failed' == @result.summary()

  testSuiteRegister: ->
    class SuiteRegisterTest extends TestCase
      testSucess: ->
      testFailure: ->
        throw 'failure test'

    suite = new TestSuite

    suite.register(SuiteRegisterTest)
    suite.run(@result)

    @assert '2 run, 1 failed' == @result.summary()


suite = new TestSuite
suite.register(TestCaseTest)
suite.run(result = new TestResult)

console.log result.summary()

