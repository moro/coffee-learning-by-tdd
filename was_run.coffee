class WasRun
  constructor: (@name) ->
    @wasRun = false

  testMethod: ->
    @wasRun = 1

test = new WasRun 'testMethod'
console.log test.wasRun

test.testMethod()
console.log test.wasRun

