defmodule Euler.Problem1 do
  @moduledoc """
    http://projecteuler.net/problem=1
    If we list all the natural numbers below 10 that are multiples of 3 or 5,
    we get 3, 5, 6 and 9. The sum of these multiples is 23.

    Find the sum of all the multiples of 3 or 5 below 1000.
  """

  @doc """
    Returns a stream of all natural numbers [0,1,2,...]

    Example:
      iex> Euler.Problem1.natgen |> Enum.take(5)
      [0, 1, 2, 3, 4]
  """
  def natgen do
    Stream.iterate(0, fn (n) -> n+1 end)
  end

  @doc """
    Returns a stream of all natural numbers that are a multiple of
    3 or 5.

    iex> Euler.Problem1.multsgen |> Enum.take(6)
    [0, 3, 5, 6, 9, 10]
  """
  def multsgen do
    natgen |> Stream.filter(fn (n) -> rem(n,3) == 0 || rem(n,5) == 0 end)
  end

  @doc """
    Returns the sum of all elements in the enumerable that are below limit.

    iex> Euler.Problem1.multsgen |> Euler.Problem1.sumBelow(11)
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

    iex> Euler.Problem1.sumMultsBelow(10)
    23
  """
  def sumMultsBelow(limit) do
    # multsgen |> sumBelow(limit)
    1..limit-1
      |> Stream.filter(fn (n) -> rem(n,3) == 0 || rem(n,5) == 0 end)
      |> Enum.reduce 0, &(&1 + &2)

  end

  def solution do
    sumMultsBelow(1000)
  end

  def solution2 do
    1..1000-1
      |> Stream.filter(fn (n) -> rem(n,3) == 0 || rem(n,5) == 0 end)
      |> Enum.reduce 0, &(&1 + &2)
  end
end

