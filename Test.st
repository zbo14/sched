FileStream fileIn: 'TestCases.st'.

(TestSuite named: 'sched')
  addTest: (SchedTestCase selector: #calculateAvailable);
  addTest: (SchedTestCase selector: #exceptions);
  run
