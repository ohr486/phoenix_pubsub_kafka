defmodule Phoenix.PubSub.Kafka.KloggerTest do
  use ExUnit.Case

  import ExUnit.CaptureLog
  alias Phoenix.PubSub.Kafka.Klogger

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

  test "#debug is disabled when debug flag is off" do
    Application.put_env(:phoenix_pubsub_kafka, :debug, false)
    fun = fn -> Klogger.debug("foo") end
    assert capture_log(fun) == ""

  end

  test "#debug outputs foo(str) when debug flag is on" do
    Application.put_env(:phoenix_pubsub_kafka, :debug, true)
    fun = fn -> Klogger.debug("foo") end
    assert capture_log(fun) =~ "[PubSub.Kafka] \"foo\""
  end

  test "#debug outputs :foo(atom) when debug flag is on" do
    Application.put_env(:phoenix_pubsub_kafka, :debug, true)
    fun = fn -> Klogger.debug(:foo) end
    assert capture_log(fun) =~ "[PubSub.Kafka] :foo"
  end
end
