# CSVLixir

A CSV reader/writer for Elixir. Operates on strings and char lists. It'd be
very simple to provide file I/O.

The reader takes a string or a char list and returns a list of lists of the
same type.

    iex> CSVLixir.read("abc,def,ghi\n123,456,789")
    [["abc","def","ghi"],["123","456","789"]]

    iex> CSVLixir.read('abc,def,"gh"",""i"')
    [['abc','def','gh","i"']]

    iex> CSVLixir.read(File.read!("foo.csv")
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

# To Do

I'm working on support for `Stream` I/O, but I'm having problems. The code
for reading from a stream can't work on a line at time, since column data
can span multiple lines. I can't seem to get
