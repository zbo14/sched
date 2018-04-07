PackageLoader fileInPackage: 'SUnit'.

TestCase subclass: CalculateAvailable [
  | s |
  scenario1 [
    s := Schedule new: 3.
    s shelflife: 2.
    s incoming: 5 outgoing: 2 at: 1.
    s incoming: 3 outgoing: 2 at: 2.
    s run.
    self should: [s available = #(3 4 3)]
  ]
  scenario2 [
    s := Schedule new: 3.
    s shelflife: 2.
    s incoming: 5 outgoing: 2 at: 1.
    s incoming: 3 outgoing: 2 at: 2.
    s outgoing: 3 at: 3.
    s run.
    self should: [s available = #(1 1 0)]
  ]
  scenario3 [
    s := Schedule new: 6.
    s shelflife: 3.
    s incoming: 3 outgoing: 1 at: 1.
    s incoming: 1 outgoing: 2 at: 2.
    s incoming: 2 outgoing: 0 at: 3.
    s incoming: 3 outgoing: 1 at: 4.
    s incoming: 4 outgoing: 5 at: 5.
    s incoming: 2 outgoing: 1 at: 6.
    s run.
    self should: [s available = #(1 1 3 4 4 5)]
  ]
]
