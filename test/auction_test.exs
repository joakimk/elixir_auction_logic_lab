defmodule AuctionTest do
  use ExUnit.Case
  doctest Auction

  setup do
    Auction.start 1, %{ bids: [], leading_bid: nil, next_bid_id: 1, end_time: :erlang.system_time + 10000000}
    :ok
  end

  test "placing a bid on an auction increases the leading_bid_amount" do
    Auction.place_bid(1, amount: 200, bidder_id: 10)

    state = Auction.get_state(1)
    assert state.leading_bid == %{ id: 1, amount: 200, bidder_id: 10 }

    assert state.bids == [ %{ id: 1, amount: 200, bidder_id: 10 } ]
  end

  test "a new bid ends up on top of the bid history" do
    Auction.place_bid(1, amount: 200, bidder_id: 10)
    Auction.place_bid(1, amount: 300, bidder_id: 15)

    state = Auction.get_state(1)
    assert state.leading_bid == %{ id: 2, amount: 300, bidder_id: 15 }

    assert state.bids == [
      %{ id: 2, amount: 300, bidder_id: 15 },
      %{ id: 1, amount: 200, bidder_id: 10 },
    ]
  end

  test "does not change state for too low bids" do
    Auction.place_bid(1, amount: 200, bidder_id: 10)
    Auction.place_bid(1, amount: 199, bidder_id: 15)

    state = Auction.get_state(1)
    assert state.leading_bid.amount == 200
  end

  test "does not change state for equal bids" do
    Auction.place_bid(1, amount: 200, bidder_id: 10)
    Auction.place_bid(1, amount: 200, bidder_id: 15)

    state = Auction.get_state(1)
    assert state.leading_bid.amount == 200
    assert Enum.count(state.bids) == 1
  end

  test "does not change state for late bids" do
    Auction.start 2, %{ bids: [], leading_bid: nil, next_bid_id: 1, end_time: :erlang.system_time - 10000 }
    Auction.place_bid(2, amount: 200, bidder_id: 10)
    state = Auction.get_state(2)
    assert state.leading_bid == nil
  end
end
