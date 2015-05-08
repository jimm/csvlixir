# CSVLixir

A CSV reader/writer for Elixir. Operates on files or strings.

## Reading

### Files

To read CSV data from a file, use `CSVLixir.read`. It takes a path to a file
and returns a `Stream` that generates and returns rows of CSV data.

    iex> CSVLixir.read("path/to/my.csv") \
    ...>   |> Enum.to_list
    [["row", "one"], ["row", "two"]]
    
### Strings

Parsing CSV data from a string returns a list of lists. Use
`CSVLixir.parse`.

    iex> CSVLixir.parse("abc,def,ghi\n123,456,789")
    [["abc","def","ghi"],["123","456","789"]]

    iex> CSVLixir.parse(~s{abc,def,"gh"",""i"})
    [["abc", "def", "gh\",\"i"]]

    iex> CSVLixir.parse(File.read!("/tmp/foo.csv"))
    [["row", "one"], ["row", "two"]]

## Writing

`CSVLixir.write` transforms a possibly lazy list of lists into a stream of
CSV strings. Each generated string ends with a newline.

    iex> CSVLixir.write([["first", "row"], [123, 456]]) \
    ...>   |> Enum.to_list
    ["first,row\n", "123,456\n"]

    iex> CSVLixir.write([["abc", "def", "gh\",\"i"], [123, 456, 789]]) \
    ...>   |> Enum.each(&IO.write/1)
    abc,def,"gh"",""i"
    123,456,789
    :ok

`CSVLixir.write_row` takes a single list and returns a single string.

    iex> CSVLixir.write_row(["a", "b", "c"])
    "a,b,c\n"

### Writing to a file

Writing using streams:

    iex> f = File.open!("/tmp/csvlixir.csv", [:write])
    iex> 1..3 \
    ...>   |> Stream.map(&([&1, &1+1 ,&1+2])) \
    ...>   |> CSVLixir.write \
    ...>   |> Stream.each(&(IO.write(f, &1))) \
    ...>   |> Stream.run
    iex> File.close(f)
    iex> File.read!("/tmp/csvlixir.csv")
    "1,2,3\n2,3,4\n3,4,5\n"

Writing a line at a time:

    iex> f = File.open!("/tmp/csvlixir.csv", [:write, :utf8])
    iex> IO.write(f, CSVLixir.write_row(["garçon", "waiter"]))
    iex> IO.write(f, CSVLixir.write_row(["résumé", "resume"]))
    iex> File.close(f)
    iex> File.read!("/tmp/csvlixir.csv")
    "garçon,waiter\nrésumé,resume\n"

Don't forget to specify `:utf8` when opening the file for writing if needed.
(I often forget.)

# Changes from 1.0

Adds reading from/writing to files. Removes support for char lists.

# To Do

- Allow different separator characters besides comma.
