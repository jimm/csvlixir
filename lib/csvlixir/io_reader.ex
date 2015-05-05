defmodule CSVLixir.IOReader do

  @moduledoc """
  Reads characters from a device and returns a Stream of lists of strings.

  See http://www.trapexit.org/Comma_Separated_Values
  """

  # after_fun gets run when the stream is done. It is passed the pid.
  def rows(pid, after_fun) do
    Stream.resource(
      fn ->
        c = IO.read(pid, 1)
        {pid, c}
      end,
      fn {pid, c} ->
        if c == :eof do
          {:halt, {pid, nil}}
        else
          case read_row(pid, c, []) do
            {[""], next_char} -> {[[]], {pid, next_char}}
            {row, next_char} -> {[row], {pid, next_char}}
          end
        end
      end,
      fn {pid, _} -> after_fun.(pid) end
    )
  end

  defp read_row(_, :eof, row), do: {Enum.reverse(row), :eof}
  defp read_row(io, c, row) do
    case read_item(io, c) do
      {item, next_char, :eol} -> {Enum.reverse([item|row]), next_char}
      {item, _,         :eof} -> {Enum.reverse([item|row]), :eof}
      {item, next_char, :ok}  -> read_row(io, next_char, [item|row])
    end
  end    

  defp read_item(io, ","), do: {"", IO.read(io, 1), :ok}
  defp read_item(io, "\""), do: read_item_quoted(io, IO.read(io, 1), "")
  defp read_item(io, "\n"), do: {"", IO.read(io, 1), :eol}
  defp read_item(io, "\r") do
    c = IO.read(io, 1)
    case c do
      "\n" -> read_item(io, IO.read(io, 1), :eol)
      ch -> {"", ch, :eol}
    end
  end
  defp read_item(io, c), do: read_item(io, IO.read(io, 1), c)

  defp read_item(_, :eof, col), do: {col, :eof, :eof}
  defp read_item(io, ",", col), do: {col, IO.read(io, 1), :ok}
  defp read_item(io, "\n", col), do: {col, IO.read(io, 1), :eol}
  defp read_item(io, "\r", col) do
    c = IO.read(io, 1)
    case c do
      "\n" -> {col, IO.read(io, 1), :eol}
      ch -> {col, ch, :eol}
    end
  end
  defp read_item(io, c, col), do: read_item(io, IO.read(io, 1), col <> c)

  defp read_item_quoted(io, "\"", col) do
    case IO.read(io, 1) do
      "\"" -> read_item_quoted(io, IO.read(io, 1), col <> "\"")
      "\n" -> read_item(io, "\n", col)
      "\r" -> read_item(io, "\r", col)
      _ -> {col, IO.read(io, 1), :ok}
    end
  end
  defp read_item_quoted(io, c, col), do: read_item_quoted(io, IO.read(io, 1), col <> c)
end
