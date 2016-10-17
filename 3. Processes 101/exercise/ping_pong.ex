defmodule Chapter3.Exercise.PingPong do

  def ping do
    receive do
      {from, :ping} ->
        IO.puts "Ping received, sending Pong"
        :timer.sleep(1_000)
        send(from, {self(), :pong})
    end
    ping
  end

  def pong do
    receive do
      {from, :pong} ->
        IO.puts "Pong received, sending Ping"
        :timer.sleep(1_000)
        send(from, {self(), :ping})
    end
    pong
  end

  def start do
    ping_pid = spawn __MODULE__, :ping, []
    pong_pid = spawn __MODULE__, :pong, []
    send(ping_pid, {pong_pid, :ping})
    "Starting ping pong"
  end
end
