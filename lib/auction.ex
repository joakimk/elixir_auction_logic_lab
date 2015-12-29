defmodule Auction do
  def start(id, state) do
    {:ok, agent} = Agent.start_link(fn ->
      state
    end)

    agent |> Process.register identifier(id)
  end

  def place_bid(id, amount: amount, bidder_id: bidder_id) do
    identifier(id)
    |> Agent.update(fn state ->
      %{state | leading_bid: %{ id: 1, amount: amount, bidder_id: bidder_id } }
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
