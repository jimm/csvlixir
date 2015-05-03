# CSVLixir

A CSV reader/writer for Elixir. Operates on files or strings.

## Files

To read CSV data from a file, use =CSVLirix.read=. It takes a path to a file
and returns a =Stream= that generates and returns rows of CSV data.

    iex> CSVLirix.read("path/to/my.csv")

    iex> CSVLixir.read("abc,def,ghi\n123,456,789")
    [["abc","def","ghi"],["123","456","789"]]

    iex> CSVLixir.read('abc,def,"gh"",""i"')
    [['abc','def','gh","i"']]

    iex> CSVLixir.read(File.read!("foo.csv"))
    [["row1", "has", "stuff"],["on", "many lines"]]

The writer takes a list of lists (write) or a list (write_row) and returns a
string. The writer always works with strings.

    iex> IO.puts CSVLixir.write([["abc", "def", "gh\",\"i"], [123, 456, 789]])
    abc,def,"gh"",""i"
    123,456,789

    iex> CSVLixir.write_row(["abc", "def", "gh\",\"i"])
    "abc,def,\"gh\"\",\"\"i\""

    iex> CSVLixir.write_row(["abc", "def", "gh\",\"i"]) |> File.write("bar.csv")
    :ok

## File I/O

If your CSV file can fit into memory, you can easily read the file into a
string and pass it into `CSVLixir.read`. See the example above. The same
goes for writing: use `CSVLixir.write` to create a string from data and
write that to a file.

# Changes from 1.0

File and string. No longer supports char lists.

# To Do

I'm working on support for `Stream` I/O, but I'm having problems. CSVLixir
needs to read data a character at a time, not a line at a time, since column
data can span multiple lines. I may have to do my own buffering.
