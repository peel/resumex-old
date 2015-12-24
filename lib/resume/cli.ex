defmodule Resume.CLI do

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                               aliases: [h: :help])
        case parse do
          { [help: true], _, _} -> :help
          _ -> :load
        end
  end

  def process(:help) do
    IO.puts """
    usage: resume
    """
    System.halt(0)
  end

  def process(:load) do
    Resume.Linkedin.Plug.start_link
    IO.puts "Please authorize application via: #{Resume.Linkedin.Client.authorize_url!}"
  end
end
