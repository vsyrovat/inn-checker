defmodule App.Checksum do
  @moduledoc """
  Calculates checksum of Russian ITN (individual taxpayer number, for physical persons, 10 digits)
  or TIN (taxpayer identification number, for commercial orgranizations, 12 digits)
  ("ИНН" in Russian).
  """

  @doc """
  Examples:
    iex> App.Checksum.check "3664069397"
    {:ok, true}

    iex> App.Checksum.check "2731347080"
    {:ok, true}

    iex> App.Checksum.check "2731347081"
    {:ok, false}

    iex> App.Checksum.check "732897853530"
    {:ok, true}

    iex> App.Checksum.check "123456789012"
    {:ok, false}

    iex> App.Checksum.check "123"
    {:error, "Length mismatch"}

    iex> App.Checksum.check "abc"
    {:error, "Invalid chars"}
  """
  def check(string) when is_bitstring(string) do
    if match?({_, ""}, Integer.parse(string)) do
      string
      |> String.graphemes()
      |> Enum.map(fn x -> String.to_integer(x) end)
      |> check_digits
    else
      {:error, "Invalid chars"}
    end
  end

  defp check_digits(digits) do
    case length(digits) do
      10 -> {:ok, check10(digits)}
      12 -> {:ok, check12(digits)}
      _ -> {:error, "Length mismatch"}
    end
  end

  defp check10(digits) do
    csum(digits, [2, 4, 10, 3, 5, 9, 4, 6, 8, 0]) == Enum.at(digits, 9)
  end

  defp check12(digits) do
    csum(digits, [7, 2, 4, 10, 3, 5, 9, 4, 6, 8, 0]) == Enum.at(digits, 10) &&
      csum(digits, [3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8, 0]) == Enum.at(digits, 11)
  end

  defp csum(digits, weights) do
    Enum.zip(digits, weights)
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.sum()
    |> rem(11)
    |> (&if(&1 > 9, do: rem(&1, 10), else: &1)).()
  end
end
