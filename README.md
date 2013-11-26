# CSVLixir

A CSV reader/writer for Elixir. Operates on strings and char lists. It'd be
very simple to provide file I/O.

The reader takes a string or a char list and returns a list of lists of the
same type.

    iex> CSV.read("abc,def,ghi\n123,456,789")
    [["abc","def","ghi"],["123","456","789"]]

    iex> CSV.read('abc,def,"gh"",""i"')
    [['abc','def','gh","i"']]

The writer takes a list of lists (write) or a list (write_row) and returns a
string. The writer always works with strings.

    iex> IO.puts CSV.write([["abc", "def", "gh\",\"i"], [123, 456, 789]])
    abc,def,"gh"",""i"
    123,456,789

    iex> CSV.write_row(["abc", "def", "gh\",\"i"])
    "abc,def,\"gh\"\",\"\"i\""

# To Do

* File I/O.
