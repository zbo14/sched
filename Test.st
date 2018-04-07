FileStream fileIn: 'TestCases.st'.

Eval [
  (CalculateAvailable selector: #scenario1) run.
  (CalculateAvailable selector: #scenario2) run.
  (CalculateAvailable selector: #scenario3) run
]
