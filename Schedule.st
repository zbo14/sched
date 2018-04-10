FileStream fileIn: 'Entry.st'.

Object subclass: Schedule [
  | entries products shelflife |
  Schedule class >> new: size [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init: size.
    ^r
  ]
  init: size [
    <category: 'initialization'>
    entries := (1 to: size) collect: [ :i | Entry new ].
    shelflife := 1
  ]
  clear [
    entries do: [ :e | e clear ]
  ]
  clear: i [
    self checkIndex: i.
    (entries at: i) clear
  ]
  available [
    <category: 'accessing'>
    ^entries collect: [ :e | e available ]
  ]
  available: i to: j [
    ^self available copyFrom: i to: j
  ]
  calculateAvailable [
    | j x |
    products := SortedCollection new.
    entries do: [ :e |
      products := e products: products shelflife: shelflife
    ].
    (entries size to: 1 by: -1) do: [ :i |
      j := i - 1.
      (entries at: i) diff.
      [(j > 0) & ((self reach: j) >= i) & ((entries at: i) isUnder)]
        whileTrue: [
          x := (entries at: i) fulfill: (entries at: j).
          ((j + 1) to: (i - 1)) do: [ :k | (entries at: k) deduct: x ].
          j := j - 1
        ]
    ].
    ^self available
  ]
  calculateAvailable: i to: j [
    ^self calculateAvailable copyFrom: i to: j
  ]
  reach: i [
    ^(entries size) min: (i - 1 + shelflife)
  ]
  checkQuantity: x [
    (x < 0)
      ifTrue: [
        ^SystemExceptions.InvalidValue signalOn: x
          reason: 'quantity cannot be less than zero'
      ]
  ]
  checkIndex: i [
    (i > 0)
      ifFalse: [
        ^SystemExceptions.InvalidValue signalOn: i
          reason: 'index must be greater than zero'
      ].
    (i > entries size)
      ifTrue: [
        ^SystemExceptions.InvalidValue signalOn: i
          reason: 'index must be less than/equal to number of entries'
      ]
  ]
  incoming: x outgoing: y at: i [
    self incoming: x at: i; outgoing: y at: i
  ]
  incoming: x at: i [
    self checkIndex: i; checkQuantity: x.
    (entries at: i) incoming: x
  ]
  outgoing: x at: i [
    self checkIndex: i; checkQuantity: x.
    (entries at: i) outgoing: x
  ]
  shelflife: shelf [
    (shelf <= 0)
      ifTrue: [
        ^SystemExceptions.InvalidValue signalOn: shelf
          reason: 'shelf life must be greater than zero'
      ].
    shelflife := shelf
  ]
  printOn: stream [
    <category: 'printing'>
    stream nextPutAll: 'Schedule (shelf = ', (shelflife asString), ') ['.
    entries do: [ :each | each printOn: (stream nlTab)].
    (stream nl) nextPutAll: ']'
  ]
]
