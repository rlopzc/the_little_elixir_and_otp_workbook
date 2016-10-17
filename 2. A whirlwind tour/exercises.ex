defmodule Exercises do
  # 1.- Implement sum/1. This function should take in a list of numbers and
  #     return the sum of the list.
  def sum(list) when is_list(list),
    do: Enum.reduce(list, 0, fn(x, acc) -> x + acc end)

  # 3.- Transform [1,[[2],3]] to [9, 4, 1] with and without the pipe operator.
  def transform_with_pipe do
    [1, [[2], 3]]
    |> List.flatten
    |> Enum.reverse
    |> Enum.map(fn(x) -> x * x end)
  end

  def transform_without_pipe do
    Enum.map(Enum.reverse(List.flatten([1, [[2], 3]])), fn(x) -> x * x end)
  end

  # 4.- Translate crypto:md5("Tales from the Crypt"). from Erlang to Elixir.
  def translate do
    :crypto.md5("Tales from the Crupt")
  end

  # 6.- Take a look at an IPV4 packet. Try writing a parser for it.
  def ipv4_parser(packet) do
    <<
      version :: size(4),
      ihl :: size(4),
      dscp :: size(6),
      ecn :: size(2),
      total_length :: binary-size(2),
      identification :: binary-size(2),
      flags :: size(3),
      fragment_offset :: size(13),
      ttl :: binary-size(1),
      protocol :: binary-size(1),
      header_checksum :: binary-size(2),
      source_ip_address :: binary-size(4),
      destination_ip_address :: binary-size(4),
      options :: binary
     >> = packet

     # Example of parsed data
     %{
       source_ip: bytes_to_dotted_decimal_notation(source_ip_address),
       destination_ip: bytes_to_dotted_decimal_notation(destination_ip_address)
     }
  end

  defp bytes_to_dotted_decimal_notation(ip) do
    <<
      first_number :: size(8),
      second_number :: size(8),
      third_number :: size(8),
      fourth_number :: size(8)
    >> = ip

    [first_number, second_number, third_number, fourth_number]
    |> Enum.map(fn(x) -> Integer.to_string(x) end)
    |> Enum.join(".")
  end
end
