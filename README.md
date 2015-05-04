# CSVLixir

A CSV reader/writer for Elixir. Operates on files or strings.

## Reading

### Files

To read CSV data from a file, use `CSVLixir.read`. It takes a path to a file
and returns a `Stream` that generates and returns rows of CSV data.

    iex> CSVLixir.read("path/to/my.csv")
           |> Enum.to_list
    [["row", "one"], ["row", "two"]]
    
### Strings

Reading CSV data from a string is similar. Use `CSVLixir.parse`.

    iex> CSVLixir.parse("abc,def,ghi\n123,456,789")
    [["abc","def","ghi"],["123","456","789"]]

    iex> CSVLixir.parse(~s{abc,def,"gh"",""i"})
    [["abc", "def", "gh\",\"i"]]

    iex> CSVLixir.read(File.read!("foo.csv"))
    [["row", "one"], ["row", "two"]]

## Writing

### Files

To write CSV data to a file, use CSVLixir.write

### Strings

The writer takes a list of lists (write) or a list (write_row) and returns a
string. The writer always works with strings.

    iex> IO.puts CSVLixir.write([["abc", "def", "gh\",\"i"], [123, 456, 789]])
    abc,def,"gh"",""i"
    123,456,789

    iex> CSVLixir.write_row(["abc", "def", "gh\",\"i"])
    "abc,def,\"gh\"\",\"\"i\""

    iex> CSVLixir.write_row(["abc", "def", "gh\",\"i"]) |> File.write("bar.csv")
    :ok

# Changes from 1.0

Adds reading from/writing to files. Removes support for char lists.
