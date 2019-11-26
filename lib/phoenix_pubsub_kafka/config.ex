defmodule Phoenix.PubSub.Kafka.Config do
  @moduledoc nil

  alias Phoenix.PubSub.Kafka.{Serializer, Topic}

  @invalid_topic_chars %{
    ":" => "-rep1-",
    "#" => "-rep2-",
    "$" => "-rep3-"
  }

  @spec debug :: boolean() | atom()
  def debug do
    Application.get_env(:phoenix_pubsub_kafka, :debug)
    || false
  end

  @spec pubsub_name :: module()
  def pubsub_name do
    Application.get_env(:phoenix_pubsub_kafka, :pubsub_name)
    || raise "Define :pubsub_name for Phoenix.PubSub.Kafka"
  end

  @spec serializer :: module()
  def serializer do
    Application.get_env(:phoenix_pubsub_kafka, :serializer)
    || Serializer.Binary
  end

  @spec invalid_topic_chars :: %{required(String.t()) => String.t()}
  def invalid_topic_chars do
    diff = Application.get_env(:phoenix_pubsub_kafka, :invalid_topic_chars)
           || %{}
    Map.merge(@invalid_topic_chars, diff)
  end

  @spec topic_prefix :: String.t()
  def topic_prefix do
    Application.get_env(:phoenix_pubsub_kafka, :topic_prefix)
    || ""
  end

  @spec topic_convert_func :: function()
  def topic_convert_func do
    Application.get_env(:phoenix_pubsub_kafka, :topic_convert_func)
    || &(&1)
  end

  @spec listening_topics :: [String.t()] | []
  def listening_topics do
    topics = Application.get_env(:phoenix_pubsub_kafka, :listening_topics)
             || raise "set listening topics"
    Enum.map(topics, fn topic ->
      topic
      |> Topic.replace_invalid_chars
      |> Topic.add_prefix
    end)
  end

  @spec consumer_group_name :: String.t()
  def consumer_group_name do
    Application.get_env(:phoenix_pubsub_kafka, :consumer_group_name)
    || "phx_ps_kfk"
  end
end
