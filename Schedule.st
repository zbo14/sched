Object subclass: Schedule [
  | entries shelflife |
  Schedule class >> new: size [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init: size.
    ^r
  ]
  init: size [
    <category: 'initialization'>
    entries := (1 to: size) collect: [ :idx | Entry new: idx ].
    shelflife := 1
  ]
  checkQuantity: x [
    (x < 0)
      ifTrue: [^self error: 'quantity cannot be less than zero']
  ]
  checkIndex: i [
    (i > 0)
      ifFalse: [^self error: 'index must be greater than zero'].
    (i > entries size)
      ifTrue: [^self error: 'index must be less than/equal to number of entries'].
  ]
  reach: i [
    ^(entries size) min: (i - 1 + shelflife)
  ]
  credit: i [
    ((entries at: i) beginCredit)
      ifTrue: [
        ((i + 1) to: (self reach: i)) do: [ :j |
          (entries at: j) credit: (entries at: i)
        ]
      ]
  ]
  debit: i at: j [
    ((j = 0) | ((entries at: i) endDebit))
      ifTrue: [^self debit: (i - 1)].
    (entries at: j) debit: (entries at: i).
    ^self debit: i at: (j - 1)
  ]
  debit: i [
    (i = 1)
      ifTrue: [^nil].
    ((entries at: i) beginDebit)
      ifTrue: [^self debit: i at: (i - 1)].
    ^self debit: (i - 1)
  ]
  incoming: x at: i [
    self checkIndex: i.
    self checkQuantity: x.
    (entries at: i) incoming: x.
    self credit: i.
    self debit: i
  ]
  outgoing: x at: i [
    self checkIndex: i.
    self checkQuantity: x.
    (entries at: i) outgoing: x.
    self credit: i.
    self debit: i
  ]
  shelflife: shelf [
    (shelf > 0)
      ifTrue: [shelflife := shelf]
      ifFalse: [self error: 'shelf life must be greater than zero']
  ]
  printOn: stream [
    <category: 'printing'>
    stream nextPutAll: 'Schedule (shelf = ', (shelflife asString), ') ['.
    entries do: [ :each | each printOn: (stream nlTab)].
    (stream nl) nextPutAll: ']'
  ]
]
