defmodule Auction do
  def start(id, state) do
    {:ok, agent} = Agent.start_link(fn ->
      state
    end)

    agent |> Process.register identifier(id)
  end

  def stop(id) do
    identifier(id)
    |> Agent.stop
  end

  def place_bid(id, amount: amount, bidder_id: bidder_id) do
    identifier(id)
    |> Agent.update(fn state ->
      if state.leading_bid && amount < state.leading_bid.amount do
        state
      else
        bid = %{ id: state.next_bid_id, amount: amount, bidder_id: bidder_id }

        state
        |> Map.put(:leading_bid, bid)
        |> Map.put(:bids, [bid | state.bids])
        |> Map.put(:next_bid_id, state.next_bid_id + 1)
      end
    end)
  end

  def get_state(id) do
    identifier(id)
    |> Agent.get(fn state -> state end)
  end

  defp identifier(id) do
    :"auction:#{id}"
  end
end
