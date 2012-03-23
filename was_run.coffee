class WasRun
  constructor: (@name) ->
    @wasRun = false

test = new WasRun 'testMethod'
console.log test.wasRun

test.testMethod()
console.log test.wasRun

