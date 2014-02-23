defmodule Fibs do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Fibs.Supervisor.start_link
  end

  @doc """
    Returns the nth Fibonacci number, where the 1st is 1,
    2nd is 2, etc.

      iex> Fibs.fib(5)
      8

      iex> Fibs.fib(10)
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

      iex> Fibs.fibgen |> Enum.take(5)
      [1, 2, 3, 5, 8]
  """
  def fibgen do
    Stream.unfold({1, 2}, fn {a, b} -> {a, {b, a+b}} end)
  end

  @doc """
    Returns the nth Fibonacci number, where the 1st is 1,
    2nd is 2, etc.
    Uses the fibgen stream.

      iex> Fibs.fib2(5)
      8

      iex> Fibs.fib(10)
      89
  """
  def fib2(n) do
    List.last(fibgen |> Enum.take(n))
  end

  @doc """
    Returns the sum of all Fibonacci numbers up to the nth number.

    iex> Fibs.sumToN(9)
    142
  """
  def sumToN(n) do
    Enum.reduce(fibgen |> Enum.take(n), fn (x,acc) -> x + acc end)
  end

  @doc """
    Returns the sum of all Fibonacci numbers that are below n.

    iex> Fibs.sumFibsBelow(10)
    19
  """
  def sumFibsBelow(n) do
    fibgen |> Enum.take_while(fn x -> x < n end) |> Enum.reduce(fn (x, acc) -> x + acc end)
  end

  @doc """
    Returns the sum of all even Fibonacci numbers that are below n.

    iex> Fibs.sumEvenFibsBelow(25)
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

ExUnit.start

defmodule FibTest do
  use ExUnit.Case
  doctest Fibs

  test "fib(5) should equal fib2(5)" do
    assert(Fibs.fib(5) == Fibs.fib2(5))
  end

  test "first 5 fibs should sum to 19" do
    assert(Fibs.sumToN(5) == 19)
  end

  test "all fibs below 10 sum to 19" do
    assert(Fibs.sumFibsBelow(10) == 19)
  end

  test "all even fibs below 10 sum to 10" do
    assert(Fibs.sumEvenFibsBelow(10) == 10)
  end
end
