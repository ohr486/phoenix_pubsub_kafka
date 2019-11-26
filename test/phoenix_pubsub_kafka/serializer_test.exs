defmodule Phoenix.PubSub.Kafka.SerializerTest do
  use ExUnit.Case

  # --- Phoenix.PubSub.Kafka.Serializer.Binary ---

  @data_map [
    %{term: "message", bin: <<131, 109, 0, 0, 0, 7, 109, 101, 115, 115, 97, 103, 101>>},
    %{term: :message,  bin: <<131, 100, 0, 7, 109, 101, 115, 115, 97, 103, 101>>},
    %{term: 123,       bin: <<131, 97, 123>>},
  ]

  test "Binary#encode_message encode erlang term to binary." do
    @data_map
    |> Enum.each(fn m ->
      assert m[:bin] == Phoenix.PubSub.Kafka.Serializer.Binary.encode_message(m[:term])
    end)
  end

  test "Binary#decode_message decode binary to erlang term." do
    @data_map
    |> Enum.each(fn m ->
      assert m[:term] == Phoenix.PubSub.Kafka.Serializer.Binary.decode_message(m[:bin])
    end)
  end
end
