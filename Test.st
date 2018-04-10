FileStream fileIn: 'TestCases.st'.

Eval [
  (SchedTestCase selector: #calculateAvailable) run.
  (SchedTestCase selector: #exceptions) run
]
