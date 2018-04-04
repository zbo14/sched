Eval [
  | s |
  s := Schedule new: 3.

  s shelflife: 2.

  s incoming: 5 at: 1.
  s incoming: 3 at: 2.

  s outgoing: 2 at: 1.
  s outgoing: 2 at: 2.

  s printNl.

  s outgoing: 3 at: 3.

  s printNl
]
