defmodule Phoenix.PubSub.Kafka do
  use Supervisor
  require Logger

  def start_link(name, opts) do
    #Logger.debug "# Phoenix.PubSub.Kafka.start_link(#{inspect name}, #{inspect opts}) #"
    sup_name = Module.concat(name, Supervisor)
    Supervisor.start_link(__MODULE__, [name, opts], name: sup_name)
  end

  def init([name, opts]) do
    #Logger.debug "# Phoenix.PubSub.Kafka.init(#{inspect name}, #{inspect opts}) #"
    node_name = node()
    fastlane = opts[:fastlane]
    pool_size = 1
    node_ref = :crypto.strong_rand_bytes(24)

    kafka_opts = opts
                 |> Keyword.merge(
                   node_ref: node_ref
                 )

    dispatch_rules = [
      {:broadcast, Phoenix.PubSub.Kafka.Producer.Server, [fastlane, pool_size, node_ref]},
      {:direct_broadcast, Phoenix.PubSub.Kafka.Producer.Server, []}, # TODO: handle it
      {:node_name, __MODULE__, [node_name]}
    ]

    children = [
      supervisor(Phoenix.PubSub.LocalSupervisor, [name, pool_size, dispatch_rules]),
      supervisor(Phoenix.PubSub.Kafka.Producer.Supervisor, [name, kafka_opts]),
      supervisor(Phoenix.PubSub.Kafka.Consumer.Supervisor, [name, kafka_opts])
    ]

    supervise(children, strategy: :one_for_all)
  end
end
