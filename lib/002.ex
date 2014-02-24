defmodule Euler.Problem2 do
  @moduledoc """
    http://projecteuler.net/problem=2
    By considering the terms in the Fibonacci sequence whose values do not exceed four million,
    find the sum of the even-valued terms.
  """

  @doc """
    Returns the nth Fibonacci number, where the 1st is 1,
    2nd is 2, etc.

      iex> Euler.Problem2.fib(5)
      8

      iex> Euler.Problem2.fib(10)
      89
  """
  def fib(n) do
    {x, _} = _fib(n, HashDict.new)
    x
  end

  def _fib(n, cache) do
    case n do
      0 -> { 1, cache }
      1 -> { 1, cache }
      n ->
        { a, cache } = _fib(n-1, cache)
        { b, cache } = _fib(n-2, cache)
        { a + b, HashDict.put(cache, n, a + b) }
    end
  end

  @doc """
    Returns a stream that generates Fibonacci numbers.

      iex> Euler.Problem2.fibgen |> Enum.take(5)
      [1, 2, 3, 5, 8]
  """
  def fibgen do
    Stream.unfold({1, 2}, fn {a, b} -> {a, {b, a+b}} end)
  end

  @doc """
    Returns the nth Fibonacci number, where the 1st is 1,
    2nd is 2, etc.
    Uses the fibgen stream.

      iex> Euler.Problem2.fib2(5)
      8

      iex> Euler.Problem2.fib(10)
      89
  """
  def fib2(n) do
    List.last(fibgen |> Enum.take(n))
  end

  @doc """
    Returns the sum of all Fibonacci numbers up to the nth number.

    iex> Euler.Problem2.sumToN(9)
    142
  """
  def sumToN(n) do
    Enum.reduce(fibgen |> Enum.take(n), fn (x,acc) -> x + acc end)
  end

  @doc """
    Returns the sum of all Fibonacci numbers that are below n.

    iex> Euler.Problem2.sumFibsBelow(10)
    19
  """
  def sumFibsBelow(n) do
    fibgen |> Enum.take_while(fn x -> x < n end) |> Enum.reduce(fn (x, acc) -> x + acc end)
  end

  @doc """
    Returns the sum of all even Fibonacci numbers that are below n.

    iex> Euler.Problem2.sumEvenFibsBelow(25)
    10
  """
  def sumEvenFibsBelow(n) do
    fibgen |> Enum.take_while(fn x -> x < n end) |> Enum.reduce(0, fn (x, acc) ->
                                                                     if rem(x, 2) == 0 do
                                                                       x + acc
                                                                     else
                                                                       acc
                                                                     end
                                                                end)
  end
end

