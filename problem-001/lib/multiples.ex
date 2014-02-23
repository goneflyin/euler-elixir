defmodule Multiples do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Multiples.Supervisor.start_link
  end

  @doc """
    Returns a stream of all natural numbers [0,1,2,...]

    Example:
      iex> Multiples.natgen |> Enum.take(5)
      [0, 1, 2, 3, 4]
  """
  def natgen do
    Stream.iterate(0, fn (n) -> n+1 end)
  end

  @doc """
    Returns a stream of all natural numbers that are a multiple of
    3 or 5.

    iex> Multiples.multsgen |> Enum.take(6)
    [0, 3, 5, 6, 9, 10]
  """
  def multsgen do
    natgen |> Stream.filter(fn (n) -> rem(n,3) == 0 || rem(n,5) == 0 end)
  end

  @doc """
    Returns the sum of all elements in the enumerable that are below limit.

    iex> Multiples.multsgen |> Multiples.sumBelow(11)
    33
  """
  def sumBelow(enum, limit) do
    enum
      |> Enum.take_while(fn (x) -> x < limit end)
      |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end

  @doc """
    Returns the sum of all natural numbers that are multiples of 3 or 5
    below the limit provided.

    iex> Multiples.sumMultsBelow(10)
    23
  """
  def sumMultsBelow(limit) do
    multsgen |> sumBelow(limit)
  end

  def solution do
    sumMultsBelow(1000)
  end

  def solution2 do
    Stream.iterate(0, fn (n) -> n+1 end)
      |> Stream.filter(fn (n) -> rem(n,3) == 0 || rem(n,5) == 0 end)
      |> Enum.take_while(fn (x) -> x < 1000 end)
      |> Enum.reduce(0, fn(x, acc) -> x + acc end)
  end
end

ExUnit.start

defmodule MultiplesDocTest do
  use ExUnit.Case
  doctest Multiples
end
