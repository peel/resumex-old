defmodule Resume.CliTest do
  use ExUnit.Case

  import Resume.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "lorem"]) == :help
    assert parse_args(["--help", "lorem"]) == :help
  end

  test "no option runs load" do
    assert parse_args([]) == :load
  end

end
