ExUnit.start
defmodule Chapter2.ExercisesTest do
  use ExUnit.Case, async: true
  import Chapter2.Exercises

  test "sum list of numbers" do
    assert sum([1,2,3]) == 6
  end

  test "transform  w/pipe [1,[[2],3]] to [9, 4, 1]" do
    assert transform_with_pipe([1,[[2],3]]) == [9, 4, 1]
  end

  test "transform  wout/pipe [1,[[2],3]] to [9, 4, 1]" do
    assert transform_without_pipe([1,[[2],3]]) == [9, 4, 1]
  end

  test "translate in md5 Tales from the Crypt" do
    assert translate("Tales from the Crypt") ==
      <<79, 132, 235, 77, 3, 224, 121, 88, 98, 75, 61, 67, 62, 16, 233, 91>>
  end

  test "ipv4 parser" do
    packet = <<
     4 :: size(4), # version
     5 :: size(4), # ihl
     1 :: size(6), # dscp
     1 :: size(2), # ecn
     1 :: size(16), # total_length
     1 :: size(16), # identification
     1 :: size(3), # flags
     1 :: size(13), # fragment_offset
     1 :: size(8), # ttl
     6 :: size(8), # protocol
     1 :: size(16), # header_checksum
     192 :: size(8), 168 :: size(8), 0 :: size(8), 1 :: size(8), # src_ip_address (32 bits)
     192 :: size(8), 168 :: size(8), 0 :: size(8), 2 :: size(8), # dest_ip_address (32 bits)
     1 :: size(8) # rest
   >>
   assert %{
    source_ip: "192.168.0.1",
    destination_ip: "192.168.0.2"
   } == ipv4_parser(packet)
  end
end
