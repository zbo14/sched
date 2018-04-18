# sched

Calculate available inventory from schedule of incoming/outgoing orders and product shelf life.


## Install

First make sure you have [GNU Smalltalk](http://smalltalk.gnu.org/download) installed, then clone the repo and `make`.

## Usage
Run `gst` and execute the following:
```
st> PackageLoader fileInPackage: 'sched'.
```
Then create a schedule with 3 entries:
```
st> s := Schedule new: 3.
Schedule (shelf = 1) [
	Entry{in=0,out=0,av=0}
	Entry{in=0,out=0,av=0}
	Entry{in=0,out=0,av=0}
]
```

## Example

```smalltalk
| sched |

"create a schedule with 3 entries"
sched := Schedule new: 3.

"set product shelf life"
sched shelflife: 2.

"set incoming/outgoing orders"
sched incoming: 5 outgoing: 2 at: 1.
sched incoming: 3 outgoing: 2 at: 2.
sched outgoing: 3 at: 3.

"calculates and prints available inventory: #(1 1 0)"
(sched calculateAvailable) printNl

```

## Test

`gst-sunit -f Test.st`
