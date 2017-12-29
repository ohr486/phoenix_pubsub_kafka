defmodule Phoenix.PubSub.Kafka do
  use Supervisor

  def start_link(name, opts) do
    sup_name = Module.concat(name, Supervisor)
    Supervisor.start_link(__MODULE__, {name, opts}, name: sup_name)
  end

  def init({server_name, opts}) when is_atom(server_name) do
    local_name = Module.concat(server_name, Local)
    node_name = self()
    server_opts = []

    fastlane = opts[:fastlane]
    pool_size = 1
    node_ref = :crypto.strong_rand_bytes(24)

    dispatch_rules = [
      {:broadcast, Phoenix.PubSub.Kafka.Producer.Server, [fastlane, pool_size, node_ref]},
      {:direct_broadcast, Phoenix.PubSub.Kafka.Producer.Server, []},
      {:node_name, __MODULE__, [node_name]}
    ]

    IO.puts "-------------------"
    IO.inspect server_name
    IO.puts "-------------------"

    children = [
      supervisor(Phoenix.PubSub.LocalSupervisor, [server_name, pool_size, dispatch_rules]),
      supervisor(Phoenix.PubSub.Kafka.Producer.Supervisor, [server_opts]),
      supervisor(Phoenix.PubSub.Kafka.Consumer.Supervisor, [server_opts])
    ]

    supervise(children, strategy: :one_for_all)
  end
end
