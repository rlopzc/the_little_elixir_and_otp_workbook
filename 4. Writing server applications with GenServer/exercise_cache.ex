defmodule Chapter4.Exercise.Cache do
  use GenServer

  @name CR
#   Write a GenServer that can store any valid Elixir term, given a key. Here are a few
# operations to get you started:
#  Cache.write(:stooges, ["Larry", "Curly", "Moe"])
#  Cache.read(:stooges)
#  Cache.delete(:stooges)
#  Cache.clear
#  Cache.exist?(:stooges)
#  Cache.update(:stooges, :new_value)
# Structure your program similar to how you did in this chapter. In particular, pay attention
# to which of these operations should be handle_calls or handle_casts.\

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, value) do
    GenServer.call(@name, {:store, key, value})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def clear do
    GenServer.cast(@name, :reset_cache)
  end

  def exist?(key) do
    GenServer.call(@name, {:exists, key})
  end

  def update(key, value) do
    GenServer.call(@name, {:update, key, value})
  end

  ## Server Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:store, key, value}, _from, cache) do
    if Map.has_key?(cache, key) do
      {:reply, "Key already in use, to update the value use Cache.update/2", cache}
    else
      new_cache = Map.put(cache, key, value)
      {:reply, "#{key} stored succesfully", new_cache}
    end
  end

  def handle_call({:read, key}, _from, cache) do
    case Map.fetch(cache, key) do
      {:ok, value} ->
        {:reply, value, cache}
      :error ->
        {:reply, "Key not in Cache", cache}
    end
  end

  def handle_call({:exists, key}, _from, cache) do
    if Map.has_key?(cache, key) do
      {:reply, true, cache}
    else
      {:reply, false, cache}
    end
  end

  def handle_call({:update, key, value}, _from, cache) do
    if Map.has_key?(cache, key) do
      new_cache = Map.put(cache, key, value)
      {:reply, "#{key} updated succesfully", new_cache}
    else
      {:reply, "Key #{key} not in Cache, store the key with Cache.write/2", cache}
    end
  end


  def handle_cast(:reset_cache, _cache) do
    {:reply, %{}}
  end

  ## Helper Functions

end
