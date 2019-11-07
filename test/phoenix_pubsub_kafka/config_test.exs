defmodule Phoenix.PubSub.Kafka.ConfigTest do
  use ExUnit.Case

  alias Phoenix.PubSub.Kafka.Config

  setup do
    env_before = Application.get_all_env(:phoenix_pubsub_kafka)

    on_exit(fn ->
      for {k, v} <- env_before do
        Application.put_env(:phoenix_pubsub_kafka, k, v)
      end
      :ok
    end)

    :ok
  end

  # --- Phoenix.PubSub.Kafka.Config.debug() ---

  test "#debug returns false when :debug of config is unset" do
    Application.put_env(:phoenix_pubsub_kafka, :debug, nil)
    assert false == Config.debug()
  end

  test "#debug returns false when :debug of config is false"do
    Application.put_env(:phoenix_pubsub_kafka, :debug, false)
    assert false == Config.debug()
  end

  test "#debug returns true when :debug of config is true"do
    Application.put_env(:phoenix_pubsub_kafka, :debug, true) 
    assert true == Config.debug()
  end

  test "#debug returns false when :debug of config is :foo"do
    Application.put_env(:phoenix_pubsub_kafka, :debug, :foo) 
    assert :foo == Config.debug()
  end

  # --- Phoenix.PubSub.Kafka.Config.pubsub_name() ---

  test "#pubsub_name raise error when :pubsub_name of config is unset"do
    Application.put_env(:phoenix_pubsub_kafka, :pubsub_name, nil) 
    assert_raise(RuntimeError, "Define :pubsub_name for Phoenix.PubSub.Kafka", fn -> Config.pubsub_name() end)
  end

  test "#pubsub_name returns :foo when :pubsub_name of config is :foo"do
    Application.put_env(:phoenix_pubsub_kafka, :pubsub_name, :foo) 
    assert :foo == Config.pubsub_name()
  end

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.serializer() ---
  test "#serializer"

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.invalid_topic_chars() ---
  test "#invalid_topic_chars"

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.topic_prefix() ---
  test "#topic_prefix"

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.topic_convert_func() ---
  test "#topic_convert_func"

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.listening_topics() ---
  test "#listening_topics"

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.consumer_group_name() ---
  test "#consumer_group_name"
end
