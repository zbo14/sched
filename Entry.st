Object subclass: Entry [
  | available incoming outgoing under |
  Entry class >> new [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init.
    ^r
  ]
  init [
    <category: 'initialization'>
    available := 0.
    incoming := 0.
    outgoing := 0.
    under := 0
  ]
  available [
    <category: 'accessing'>
    ^available
  ]
  incoming [
    <category: 'accessing'>
    ^incoming
  ]
  outgoing [
    <category: 'accessing'>
    ^outgoing
  ]
  isUnder [
    <category: 'accessing'>
    ^under > 0
  ]
  diff [
    under := 0 max: (under + outgoing - incoming).
  ]
  debit: x [
    available := available - x.
    under := under + x
  ]
  fulfill: e [
    | x |
    x := under min: ((e incoming) min: (0 max: (e available))).
    (x > 0)
      ifTrue: [
        under := under - x.
        e debit: x
      ]
  ]
  products: products shelflife: shelflife [
    | i |
    available := available - outgoing.
    products add: (Product new: incoming).
    products sortBlock: [ :a :b | (a age) > (b age) ].
    i := 0.
    [(available < 0) & (i <= (products size))]
      whileTrue: [
        i := i + 1.
        available := available + ((products at: i) use: (available abs))
      ].
    i := i max: 1.
    [i <= (products size)]
      whileTrue: [
        available := available + (products at: i) quantity.
        i := i + 1
      ].
    ^products select: [ :p | (p hasQuantity) & (p isFresh: shelflife) ]
  ]
  incoming: x [
    (x < 0)
      ifTrue: [^self error: 'incoming cannot be less than zero'].
    incoming := x
  ]
  outgoing: x [
    (x < 0)
      ifTrue: [^self error: 'outgoing cannot be less than zero'].
    outgoing := x
  ]
  printOn: stream [
    <category: 'printing'>
    stream nextPutAll: 'Entry{in=', (incoming asString), ',out=', (outgoing asString), ',av=', (available asString), '}'.
  ]
]
