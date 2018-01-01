defmodule Phoenix.PubSub.Kafka.Producer.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Logger.debug "### Phoenix.PubSub.Kafka.Producer.Supervisor.start_link(#{inspect opts}) ###"
    name = :prod_name
    sup_name = :prod_sup
    Supervisor.start_link(__MODULE__, [name, opts], name: sup_name)
  end

  def init([server_name, opts]) when is_atom(server_name) do
    Logger.debug "### Phoenix.PubSub.Kafka.Producer.Supervisor.init(#{inspect server_name}, #{inspect opts}) ###"
    server_opts = []
    children = [
      worker(Phoenix.PubSub.Kafka.Producer.Server, [server_opts])
    ]
    supervise(children, strategy: :one_for_all)
  end
end
