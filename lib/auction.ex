defmodule Auction do
  def start(id, state) do
    {:ok, agent} = Agent.start_link(fn -> state end, name: identifier(id))
  end

  def stop(id) do
    identifier(id)
    |> Agent.stop
  end

  def place_bid(id, amount: amount, bidder_id: bidder_id) do
    place_bid(id, amount: amount, bidder_id: bidder_id, placed_at: :erlang.system_time)
  end
  def place_bid(id, amount: amount, bidder_id: bidder_id, placed_at: placed_at) do
    identifier(id)
      |> Agent.update(fn state ->
        bid = %{ id: state.next_bid_id, amount: amount, bidder_id: bidder_id }
        calculate_next_state(state, bid, placed_at)
      end)
  end

  def get_state(id) do
    identifier(id)
    |> Agent.get(fn state -> state end)
  end

  defp calculate_next_state(state, bid, placed_at) do
    if allowed_to_place_bid?(state, bid, placed_at) do
      update_bids state, bid
    else
      state
    end
  end

  defp allowed_to_place_bid?(state, bid, placed_at) do
    auction_ongoing?(state, placed_at) &&
      bid_above_leading_bid?(bid, state.leading_bid)
  end

  defp auction_ongoing?(state, placed_at) do
    placed_at <= state.end_time
  end

  defp bid_above_leading_bid?(_, nil), do: true
  defp bid_above_leading_bid?(bid, leading_bid) do
    bid.amount > leading_bid.amount
  end

  defp update_bids(state, bid) do
    state
    |> Map.put(:leading_bid, bid)
    |> Map.put(:bids, [bid | state.bids])
    |> Map.put(:next_bid_id, state.next_bid_id + 1)
  end

  defp identifier(id), do: :"auction_#{id}"
end
