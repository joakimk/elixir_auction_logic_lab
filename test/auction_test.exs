defmodule AuctionTest do
  use ExUnit.Case
  doctest Auction

  test "placing a bid on an auction increases the leading_bid_amount" do
    Auction.start 1, %{ leading_bid: nil }

    Auction.place_bid(1, amount: 200, bidder_id: 10)

    state = Auction.get_state(1)
    assert state.leading_bid == %{ id: 1, amount: 200, bidder_id: 10 }

    #assert state.bids == [ %{ id: 1, amount: 200, bidder_id: 10 } ]
  end
end
