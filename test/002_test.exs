defmodule FibTest do
  use ExUnit.Case
  doctest Euler.Problem2

  test "fib(5) should equal fib2(5)" do
    assert(Euler.Problem2.fib(5) == Euler.Problem2.fib2(5))
  end

  test "first 5 fibs should sum to 19" do
    assert(Euler.Problem2.sumToN(5) == 19)
  end

  test "all fibs below 10 sum to 19" do
    assert(Euler.Problem2.sumFibsBelow(10) == 19)
  end

  test "all even fibs below 10 sum to 10" do
    assert(Euler.Problem2.sumEvenFibsBelow(10) == 10)
  end
end
