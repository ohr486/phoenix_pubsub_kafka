defmodule Phoenix.PubSub.Kafka do
  use Supervisor

  def start_link(name, opts) do
    sup_name = Module.concat(name, Supervisor)
    Supervisor.start_link(__MODULE__, [name, opts], name: sup_name)
  end

  def init([server_name, opts]) when is_atom(server_name) do
    local_name = Module.concat(server_name, Local)
    node_name = self()
    server_opts = []
    pool_size = 5

    dispatch_rules = [
      {:broadcast, Phoenix.PubSub.KafkaServer, []},
      {:direct_broadcast, Phoenix.PubSub.KafkaServer, []},
      {:node_name, __MODULE__, [node_name]}
    ]

    children = [
      supervisor(Phoenix.PubSub.LocalSupervisor, [server_name, pool_size, dispatch_rules]),
      worker(Phoenix.PubSub.KafkaServer, [server_opts])
    ]

    supervise(children, strategy: :one_for_all)
  end
end
