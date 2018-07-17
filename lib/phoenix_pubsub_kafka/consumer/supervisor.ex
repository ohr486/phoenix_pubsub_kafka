defmodule Phoenix.PubSub.Kafka.Consumer.Supervisor do
  use Supervisor
  alias Phoenix.PubSub.Kafka.Config

  def start_link(name, opts) do
    name = Module.concat(name, Consumer)
    sup_name = Module.concat(name, Supervisor)
    server_name = Module.concat(name, Server)
    Supervisor.start_link(__MODULE__, [server_name, opts], name: sup_name)
  end

  def init([server_name, opts]) do

    sleep_when_restarting()

    server_opts = opts
                  |> Keyword.merge(
                    name: server_name
                  )
    cons_grp_opts = [Phoenix.PubSub.Kafka.Consumer.Server, Config.consumer_group_name(), Config.listening_topics(), server_opts]
    children = [
      supervisor(KafkaEx.ConsumerGroup, cons_grp_opts)
    ]
    supervise(children, strategy: :one_for_all)
  end

  defp sleep_when_restarting do
    alias Phoenix.PubSub.Kafka.Consumer.RestartMonitor

    if RestartMonitor.get_count() > Config.restart_count_threshold() do
      Process.sleep(Config.restart_interval())
    end

    RestartMonitor.increment_count()
  end
end
