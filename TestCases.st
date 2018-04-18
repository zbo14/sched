PackageLoader fileInPackage: 'SUnit'.
FileStream fileIn: 'Schedule.st'.

TestCase subclass: SchedTestCase [
  | sched |
  calculateAvailable [
    sched := Schedule new: 10.

    sched shelflife: 2.

    sched incoming: 5 outgoing: 2 at: 1.
    sched incoming: 3 outgoing: 2 at: 2.
    self should: [
      (sched calculateAvailable: 1 to: 3) = #(3 4 3)
    ].

    sched incoming: 5 at: 1.
    sched incoming: 3 at: 2.
    sched outgoing: 3 at: 3.
    self should: [
      (sched calculateAvailable: 1 to: 3) = #(1 1 0)
    ].

    sched incoming: 5 outgoing: 4 at: 1.
    sched incoming: 3 outgoing: 4 at: 2.
    sched incoming: 2 outgoing: 3 at: 3.
    sched incoming: 2 outgoing: 1 at: 4.
    self should: [
      (sched calculateAvailable: 1 to: 4) = #(0 0 -1 1)
    ].

    sched incoming: 6 outgoing: 5 at: 1.
    sched incoming: 4 outgoing: 2 at: 2.
    sched incoming: 2 outgoing: 3 at: 3.
    sched incoming: 3 outgoing: 1 at: 4.
    self should: [
      (sched calculateAvailable: 1 to: 4) = #(1 2 2 4)
    ].

    sched incoming: 1 outgoing: 2 at: 1.
    sched incoming: 2 outgoing: 3 at: 2.
    sched incoming: 3 outgoing: 4 at: 3.
    sched incoming: 4 outgoing: 5 at: 4.
    self should: [
      (sched calculateAvailable: 1 to: 4) = #(-1 -1 -1 -1)
    ].

    sched incoming: 5 outgoing: 0 at: 1.
    sched incoming: 2 outgoing: 4 at: 2.
    sched incoming: 1 outgoing: 2 at: 3.
    sched incoming: 3 outgoing: 2 at: 4.
    self should: [
      (sched calculateAvailable: 1 to: 4) = #(2 2 1 2)
    ].

    sched incoming: 3 outgoing: 1 at: 1.
    sched incoming: 1 outgoing: 2 at: 2.
    sched incoming: 2 outgoing: 0 at: 3.
    sched incoming: 3 outgoing: 1 at: 4.
    sched incoming: 4 outgoing: 5 at: 5.
    sched incoming: 2 outgoing: 1 at: 6.
    self should: [
      (sched calculateAvailable: 1 to: 6) = #(1 1 3 3 2 3)
    ].

    sched clear: 6.
    sched shelflife: 3.

    sched incoming: 2 outgoing: 0 at: 1.
    sched incoming: 1 outgoing: 1 at: 2.
    sched incoming: 3 outgoing: 4 at: 3.
    sched incoming: 5 outgoing: 4 at: 4.
    sched incoming: 4 outgoing: 6 at: 5.
    self should: [
      (sched calculateAvailable: 1 to: 5) = #(0 0 0 0 0)
    ].

    sched incoming: 1 outgoing: 0 at: 1.
    sched incoming: 1 outgoing: 1 at: 2.
    sched incoming: 3 outgoing: 4 at: 3.
    sched incoming: 5 outgoing: 4 at: 4.
    sched incoming: 4 outgoing: 6 at: 5.
    self should: [
      (sched calculateAvailable: 1 to: 5) = #(0 0 0 0 -1)
    ].

    sched incoming: 3 outgoing: 1 at: 1.
    sched incoming: 1 outgoing: 2 at: 2.
    sched incoming: 2 outgoing: 0 at: 3.
    sched incoming: 3 outgoing: 1 at: 4.
    sched incoming: 4 outgoing: 5 at: 5.
    sched incoming: 2 outgoing: 1 at: 6.
    self should: [
      (sched calculateAvailable: 1 to: 6) = #(1 1 3 4 4 5)
    ].

    sched clear: 5; clear: 6.

    sched incoming: 5 outgoing: 4 at: 1.
    sched incoming: 3 outgoing: 4 at: 2.
    sched incoming: 2 outgoing: 3 at: 3.
    sched incoming: 2 outgoing: 1 at: 4.
    self should: [
      (sched calculateAvailable: 1 to: 4) = #(0 0 -1 1)
    ]
  ]
  invalidValue: x reason: r block: aBlock [
    aBlock on: SystemExceptions.InvalidValue do: [ :signal |
      self should: [x = signal value].
      self should: [r = signal messageText]
    ]
  ]
  exceptions [
    sched := Schedule new: 10.
    self invalidValue: 0
      reason: 'Invalid value 0: shelf life must be greater than zero'
      block: [sched shelflife: 0].
    self invalidValue: 0
      reason: 'Invalid value 0: index must be greater than zero'
      block: [sched incoming: 1 at: 0].
    self invalidValue: 11
      reason: 'Invalid value 11: index must be less than/equal to number of entries'
      block: [sched outgoing: 1 at: 11].
    self invalidValue: -1
      reason: 'Invalid value -1: quantity cannot be less than zero'
      block: [sched incoming: -1 at: 1]
  ]
]
