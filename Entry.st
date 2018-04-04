Object subclass: Entry [
  | index incoming outgoing credits debits debit |
  Entry class >> new: idx [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init: idx.
    ^r
  ]
  init: idx [
    <category: 'initialization'>
    index := idx.
    incoming := 0.
    outgoing := 0.
    credits := Dictionary new.
    debits := Dictionary new.
    debit := self debit
  ]
  index [
    <category: 'accessing'>
    ^index
  ]
  credits [
    <category: 'accessing'>
    ^credits
  ]
  debits [
    <category: 'accessing'>
    ^debits
  ]
  incoming [
    <category: 'accessing'>
    ^incoming
  ]
  outgoing [
    <category: 'accessing'>
    ^outgoing
  ]
  credit [
    <category: 'accessing'>
    ^((self available) max: 0) min: incoming
  ]
  debit [
    <category: 'accessing'>
    ^debit
  ]
  beginCredit [
    <category: 'accessing'>
    ^(self credit) > 0
  ]
  beginDebit [
    <category: 'accessing'>
    debit := ((outgoing - incoming + (self sumDebits)) max: 0) min: outgoing.
    ^debit > 0
  ]
  endDebit [
    <category: 'accessing'>
    ^debit = 0
  ]
  sumCredits [
    <category: 'accessing'>
    ^credits inject: 0 into: [:sum :each | sum + each ]
  ]
  sumDebits [
    <category: 'accessing'>
    ^debits inject: 0 into: [:sum :each | sum + each ]
  ]
  available [
    <category: 'accessing'>
    ^incoming - outgoing + (self sumCredits) - (self sumDebits)
  ]
  deduct: x [
    debit := debit - x.
    ^x
  ]
  fulfill: e [
    ^self deduct: ((0 max: (e available)) min: debit)
  ]
  debit: e [
    ^debits at: (e index) put: (e fulfill: self)
  ]
  credit: e [
    ^credits at: (e index) put: (e credit)
  ]
  incoming: x [
    (x < 0)
      ifTrue: [self error: 'incoming cannot be less than zero']
      ifFalse: [incoming := x]
  ]
  outgoing: x [
    (x < 0)
      ifTrue: [self error: 'outgoing cannot be less than zero']
      ifFalse: [outgoing := x]
  ]
  printOn: stream [
    <category: 'printing'>
    stream nextPutAll: 'Entry{in=', (incoming asString), ',out=', (outgoing asString), ',cred=', (self sumCredits asString), ',deb=', (self sumDebits asString), ',av=', (self available asString), '}'
  ]
]
