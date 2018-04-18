FileStream fileIn: 'Schedule.st'.

| sched |

"create a schedule with 3 entries"
sched := Schedule new: 3.

"set product shelf life"
sched shelflife: 2.

"set incoming/outgoing orders"
sched incoming: 5 outgoing: 2 at: 1.
sched incoming: 3 outgoing: 2 at: 2.
sched outgoing: 3 at: 3.

"calculates and prints available inventory: (1 1 0)"
(sched calculateAvailable) printNl
