defmodule Phoenix.PubSub.Kafka.Logger do
  @moduledoc nil

  alias Phoenix.PubSub.Kafka.Config
  require Logger

  def debug(msg) do
    case Config.debug() do
      true -> Logger.debug fn -> "[PubSub.Kafka] #{inspect msg}" end
      _ -> nil
    end
  end
end
