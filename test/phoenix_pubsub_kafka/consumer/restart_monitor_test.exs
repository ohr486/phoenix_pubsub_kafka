defmodule Phoenix.PubSub.Kafka.Consumer.RestartMonitorTest do
  use ExUnit.Case
  alias Phoenix.PubSub.Kafka.Consumer.RestartMonitor
  test "get_count is called first" do
    assert RestartMonitor.get_count() == 0

    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 1

    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 2

    RestartMonitor.increment_count()
    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 4
  end

  test "increment_count is called first" do
    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 1

    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 2

    RestartMonitor.increment_count()
    RestartMonitor.increment_count()
    assert RestartMonitor.get_count() == 4
  end
end
