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

  # --- Phoenix.PubSub.Kafka.Config.serializer() ---

  test "#serializer returns Phoenix.PubSub.Kafka.Serializer.Binary when :serializer of config is unset" do
    Application.put_env(:phoenix_pubsub_kafka, :serializer, nil)
    assert Phoenix.PubSub.Kafka.Serializer.Binary == Config.serializer()
  end

  test "#serializer returns :foo when :serializer of config is :foo" do
    Application.put_env(:phoenix_pubsub_kafka, :serializer, :foo)
    assert :foo == Config.serializer()
  end

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.invalid_topic_chars() ---
  test "#invalid_topic_chars"

  # --- Phoenix.PubSub.Kafka.Config.topic_prefix() ---

  test "#topic_prefix returns blank str when :topic_prefix of config is unset" do
    Application.put_env(:phoenix_pubsub_kafka, :topic_prefix, nil)
    assert "" == Config.topic_prefix()
  end

  test "#topic_prefix returns :foo when :topic_prefix of config is :foo" do
    Application.put_env(:phoenix_pubsub_kafka, :topic_prefix, :foo)
    assert :foo == Config.topic_prefix()
  end

  # --- Phoenix.PubSub.Kafka.Config.topic_convert_func() ---

  test "#topic_convert_func returns &(&1) when :topic_convert_func of config is unset" do
    Application.put_env(:phoenix_pubsub_kafka, :topic_convert_func, nil)
    func = Config.topic_convert_func()
    assert :foo == Config.topic_convert_func().(:foo)
  end

  test "#topic_convert_func returns :foo when :topic_convert_func of config is :foo" do
    Application.put_env(:phoenix_pubsub_kafka, :topic_convert_func, :foo)
    assert :foo == Config.topic_convert_func()
  end

  @tag :skip
  # --- Phoenix.PubSub.Kafka.Config.listening_topics() ---
  test "#listening_topics"

  # --- Phoenix.PubSub.Kafka.Config.consumer_group_name() ---

  test "#consumer_group_name returns phx_ps_kfk when :consumer_group_name of config is unset" do
    Application.put_env(:phoenix_pubsub_kafka, :consumer_group_name, nil)
    assert "phx_ps_kfk" == Config.consumer_group_name()
  end

  test "#consumer_group_name returns :foo when :consumer_group_name of config is :foo" do
    Application.put_env(:phoenix_pubsub_kafka, :consumer_group_name, :foo)
    assert :foo == Config.consumer_group_name()
  end
end
