PackageLoader fileInPackage: 'SUnit'.
FileStream fileIn: 'Schedule.st'.

TestCase subclass: SchedTestCase [
  | s |
  calculateAvailable [
    s := Schedule new: 10.

    s shelflife: 2.

    s incoming: 5 outgoing: 2 at: 1.
    s incoming: 3 outgoing: 2 at: 2.
    self should: [
      (s calculateAvailable: 1 to: 3) = #(3 4 3)
    ].

    s incoming: 5 at: 1.
    s incoming: 3 at: 2.
    s outgoing: 3 at: 3.
    self should: [
      (s calculateAvailable: 1 to: 3) = #(1 1 0)
    ].

    s incoming: 5 outgoing: 4 at: 1.
    s incoming: 3 outgoing: 4 at: 2.
    s incoming: 2 outgoing: 3 at: 3.
    s incoming: 2 outgoing: 1 at: 4.
    self should: [
      (s calculateAvailable: 1 to: 4) = #(0 0 -1 1)
    ].

    s incoming: 6 outgoing: 5 at: 1.
    s incoming: 4 outgoing: 2 at: 2.
    s incoming: 2 outgoing: 3 at: 3.
    s incoming: 3 outgoing: 1 at: 4.
    self should: [
      (s calculateAvailable: 1 to: 4) = #(1 2 2 4)
    ].

    s incoming: 1 outgoing: 2 at: 1.
    s incoming: 2 outgoing: 3 at: 2.
    s incoming: 3 outgoing: 4 at: 3.
    s incoming: 4 outgoing: 5 at: 4.
    self should: [
      (s calculateAvailable: 1 to: 4) = #(-1 -1 -1 -1)
    ].

    s incoming: 5 outgoing: 0 at: 1.
    s incoming: 2 outgoing: 4 at: 2.
    s incoming: 1 outgoing: 2 at: 3.
    s incoming: 3 outgoing: 2 at: 4.
    self should: [
      (s calculateAvailable: 1 to: 4) = #(2 2 1 2)
    ].

    s incoming: 3 outgoing: 1 at: 1.
    s incoming: 1 outgoing: 2 at: 2.
    s incoming: 2 outgoing: 0 at: 3.
    s incoming: 3 outgoing: 1 at: 4.
    s incoming: 4 outgoing: 5 at: 5.
    s incoming: 2 outgoing: 1 at: 6.
    self should: [
      (s calculateAvailable: 1 to: 6) = #(1 1 3 3 2 3)
    ].

    s clear: 6.
    s shelflife: 3.

    s incoming: 2 outgoing: 0 at: 1.
    s incoming: 1 outgoing: 1 at: 2.
    s incoming: 3 outgoing: 4 at: 3.
    s incoming: 5 outgoing: 4 at: 4.
    s incoming: 4 outgoing: 6 at: 5.
    self should: [
      (s calculateAvailable: 1 to: 5) = #(0 0 0 0 0)
    ].

    s incoming: 1 outgoing: 0 at: 1.
    s incoming: 1 outgoing: 1 at: 2.
    s incoming: 3 outgoing: 4 at: 3.
    s incoming: 5 outgoing: 4 at: 4.
    s incoming: 4 outgoing: 6 at: 5.
    self should: [
      (s calculateAvailable: 1 to: 5) = #(0 0 0 0 -1)
    ].

    s incoming: 3 outgoing: 1 at: 1.
    s incoming: 1 outgoing: 2 at: 2.
    s incoming: 2 outgoing: 0 at: 3.
    s incoming: 3 outgoing: 1 at: 4.
    s incoming: 4 outgoing: 5 at: 5.
    s incoming: 2 outgoing: 1 at: 6.
    self should: [
      (s calculateAvailable: 1 to: 6) = #(1 1 3 4 4 5)
    ].

    s clear: 5; clear: 6.

    s incoming: 5 outgoing: 4 at: 1.
    s incoming: 3 outgoing: 4 at: 2.
    s incoming: 2 outgoing: 3 at: 3.
    s incoming: 2 outgoing: 1 at: 4.
    self should: [
      (s calculateAvailable: 1 to: 4) = #(0 0 -1 1)
    ]
  ]
  invalidValue: x reason: r block: aBlock [
    aBlock on: SystemExceptions.InvalidValue do: [ :signal |
      self should: [x = signal value].
      self should: [r = signal messageText]
    ]
  ]
  exceptions [
    s := Schedule new: 10.
    self invalidValue: 0
      reason: 'Invalid value 0: shelf life must be greater than zero'
      block: [s shelflife: 0].
    self invalidValue: 0
      reason: 'Invalid value 0: index must be greater than zero'
      block: [s incoming: 1 at: 0].
    self invalidValue: 11
      reason: 'Invalid value 11: index must be less than/equal to number of entries'
      block: [s outgoing: 1 at: 11].
    self invalidValue: -1
      reason: 'Invalid value -1: quantity cannot be less than zero'
      block: [s incoming: -1 at: 1]
  ]
]
