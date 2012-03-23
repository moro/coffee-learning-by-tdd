class TestCase
  constructor: (@name) ->

  setup: ->

  teardown: ->

  run: ->
    result = new TestResult
    result.testStarted()
    @setup()
    try
      this[@name]()
    catch error
      result.testFailed

    @teardown()
    result

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

TestCase.TestResult = TestResult
exports.TestCase = TestCase

