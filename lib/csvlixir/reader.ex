defmodule CSVLixir.Reader do

  @moduledoc """
  Reads a string or char_list and returns a list of lists whose values are
  of the same type.

  From http://www.trapexit.org/Comma_Separated_Values
  """

  def read(str) when is_binary(str) do
    read(:binary.bin_to_list(str), [])
    |> Enum.map(fn(row) ->
                    Enum.map(row, fn(col) -> :binary.list_to_bin(col) end)
                end)
  end

  def read(chars) when is_list(chars), do: read(chars, [])

  defp read([], acc), do: Enum.reverse(acc)

  defp read(chars, []) do
	  {line, rest} = read_line(chars)
	  read(rest, [line])
  end

  defp read([10|chars], acc) do
	  {line, rest} = read_line(chars)
	  read(rest, [line|acc])
  end

  defp read([13,10|chars], acc) do
	  {line, rest} = read_line(chars)
	  read(rest, [line|acc])
  end

  defp read_item([34|tail]), do: read_item_quoted(tail, [])
  defp read_item(other),     do: read_item(other, [])

  defp read_item([10|tail],    acc), do: {Enum.reverse(acc), [10|tail]}
  defp read_item([13,10|tail], acc), do: {Enum.reverse(acc), [13,10|tail]}
  defp read_item([13|tail],    acc), do: {Enum.reverse(acc), [13|tail]}
  defp read_item([?,|tail],    acc), do: {Enum.reverse(acc), [?,|tail]}
  defp read_item([],           acc), do: {Enum.reverse(acc), []}
  defp read_item([ch|tail],    acc), do: read_item(tail, [ch|acc])

  defp read_item_quoted([34,34|tail], acc), do: read_item_quoted(tail, [34|acc])
  defp read_item_quoted([34|tail],    acc), do: {Enum.reverse(acc), tail}
  defp read_item_quoted([ch|tail],    acc), do: read_item_quoted(tail, [ch|acc])

  defp read_line(chars), do: read_line(chars,[])

  defp read_line([10|tail],    acc), do: {Enum.reverse(acc), [10|tail]}
  defp read_line([13,10|tail], acc), do: {Enum.reverse(acc), [13|tail]}
  defp read_line([],           acc), do: {Enum.reverse(acc), []}
  defp read_line(chars,        []) do
    {item, rest} = read_item(chars)
    read_line(rest, [item])
  end
  defp read_line([?,|chars],   acc) do
    {item, rest} = read_item(chars)
    read_line(rest, [item|acc])
  end
end
