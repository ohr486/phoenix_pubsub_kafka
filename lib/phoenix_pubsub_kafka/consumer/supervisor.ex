defmodule Phoenix.PubSub.Kafka.Consumer.Supervisor do
  use Supervisor
  alias Phoenix.PubSub.Kafka.Config
  require Logger

  def start_link(name, opts) do
    Logger.debug "## Phoenix.PubSub.Kafka.Consumer.Supervisor.start_link(#{inspect name}, #{inspect opts}) ##"
    name = Module.concat(name, Consumer)
    sup_name = Module.concat(name, Supervisor)
    server_name = Module.concat(name, Server)
    Supervisor.start_link(__MODULE__, [server_name, opts], name: sup_name)
  end

  def init([server_name, opts]) do
    Logger.debug "## Phoenix.PubSub.Kafka.Consumer.Supervisor.init(#{inspect server_name}, #{inspect opts}) ##"
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
end
