defmodule PhoenixPubsubKafkaTest do
  use ExUnit.Case
  doctest PhoenixPubsubKafka

  test "greets the world" do
    assert PhoenixPubsubKafka.hello() == :world
  end
end
