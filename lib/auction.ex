defmodule Auction do
  def start(id, state) do
    {:ok, agent} = Agent.start_link(fn ->
      state
    end)
    Process.register agent, :"auction %#{id}"
  end

  def place_bid(id, amount: amount, bidder_id: bidder_id) do
    process = Process.whereis(:"auction %#{id}")
    Agent.update(process, fn state ->
      %{state | leading_bid_amount: amount}
    end)
  end

  def get_state(id) do
    process = Process.whereis(:"auction %#{id}")
    Agent.get(process, fn state ->
      state
    end)
  end
end
