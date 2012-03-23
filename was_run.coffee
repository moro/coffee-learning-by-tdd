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
    @wasSetup = 1

  testMethod: ->
    @wasRun = 1

class TestCaseTest extends TestCase

  setup: ->
    @test = new WasRun 'testMethod'

  assert: (bool) ->
     throw 'assertion failed' if(!bool)

  testRunning: ->
    @test.run()
    @assert @test.wasRun

  testSetup: ->
    @test.run()
    @assert @test.wasSetup

(new TestCaseTest 'testRunning').run()
(new TestCaseTest 'testSetup').run()

