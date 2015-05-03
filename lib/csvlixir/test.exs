File.stream!("/tmp/foo.csv", [raw: false], :bytes)
  |> Enum.map(&(IO.puts "byte = #{inspect &1}"))
