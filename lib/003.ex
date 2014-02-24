defmodule Euler.Problem3 do

  @moduledoc """
    http://projecteuler.net/problem=3
    The prime factors of 13195 are 5, 7, 13 and 29.

    What is the largest prime factor of the number 600851475143?
  """

  @doc """
    Returns the stream of prime numbers.

      iex> primes |> Enum.take(5)
        [2,3,5,7,11]
  """
  def primes do
    Stream.unfold([2,3], &findNextPrime/1)
  end

  def findNextPrime(knownPrimes) do
    _findNextPrime(List.last(knownPrimes), knownPrimes)
  end

  def _findNextPrime(next, knownPrimes) do
    trialPrime = next + 2
    if isPrime(trialPrime, knownPrimes) do
      { trialPrime, knownPrimes ++ [trialPrime] }
    else
      _findNextPrime(trialPrime, knownPrimes)
    end
  end

  def isPrime(n, knownPrimes) do
    knownPrimes
      |> Enum.reduce(true, fn(prime, stillPrime) -> stillPrime && rem(n, prime) != 0 end)
  end

  @doc """
    Finds the largest prime factor of the number provided.

      iex> solve(30)
      5
  """
  def solve(n \\ 600851475143) do
    hd factor(n)
  end
  def factor(n) do
    _factor(2, [], n)
  end
  def _factor(divisor, factors, n) when n < divisor do
    factors
  end
  def _factor(divisor, factors, n) when rem(n, divisor) == 0 do
    IO.write("[#{n}]:")
    IO.inspect(factors)
    _factor(divisor, [divisor|factors], div(n, divisor))
  end
  def _factor(divisor, factors, n) when rem(n, divisor) != 0 do
    _factor(divisor + 1, factors, n)
  end

  @doc """
    Prints the solution to Project Euler Problem 3.
  """
  def print do
    IO.puts solve(600851475143)
  end
end