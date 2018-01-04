defmodule Phoenix.PubSub.Kafka.Serializer do
  defmodule Binary do
    def encode_message(message) do
      :erlang.term_to_binary(message)
    end

    def decode_message(message) do
      :erlang.binary_to_term(message)
    end
  end

  # TODO: impl JSON
end
