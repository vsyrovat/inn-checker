defmodule App.Banhammer do
  @moduledoc """
  Keeps banned ips in memory
  """
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def ban(ip) do
    Agent.update(__MODULE__, &[ip | &1])
  end

  def unban(ip) do
    Agent.update(__MODULE__, &List.delete(&1, ip))
  end

  def banned?(ip) do
    Agent.get(__MODULE__, &Enum.member?(&1, ip))
  end

  def all, do: Agent.get(__MODULE__, & &1)
end
