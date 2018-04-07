Object subclass: Product [
  | quantity age |
  Product class >> new: qty [
    <category: 'instance creation'>
    | r |
    r := super new.
    r init: qty.
    ^r
  ]
  init: qty [
    <category: 'initialization'>
    quantity := qty.
    age := 0
  ]
  quantity [
    <category: 'accessing'>
    ^quantity
  ]
  age [
    <category: 'accessing'>
    ^age
  ]
  hasQuantity [
    <category: 'accessing'>
    ^quantity > 0
  ]
  use: x [
    | y |
    y := x min: quantity.
    quantity := quantity - y.
    ^y
  ]
  quantity: qty [
    quantity := qty
  ]
  isFresh: shelflife [
    age := age + 1.
    ^age < shelflife
  ]
  printOn: stream [
    <category: 'printing'>
    stream nextPutAll: 'Product{qty=', (quantity asString), ',age=', (age asString), '}'.
  ]
]
