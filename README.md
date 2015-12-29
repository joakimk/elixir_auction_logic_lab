# Auction

A lab on doing bidding logic in elixir where each auction is represented by it's own process.

Initially created on the "Holiday hacknight" (<http://www.meetup.com/stockholm-elixir/events/227496385/>).

Usage:

    mix test

## Todo

Things that would be interesting to try.

* [ ] Add the max bid concept (since this affects persistence)
* [ ] Add persistence
* [ ] Add benchmark suite simulating users viewing and placing bids in a realistic manner and a realistic number of bids for any particular auction
  - How many auctions could a small computer, e.g. heroku instance or laptop, handle?
* [ ] Add auction-closing logic and a event to hook into when that happens
* [ ] Add supervision and restarting of auctions
* [ ] Figure out how to ensure only one machine handles the same unique auction at a time, and handle failover

## License

Copyright (c) 2015 [Joakim Kolsjö](https://twitter.com/joakimk)

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
