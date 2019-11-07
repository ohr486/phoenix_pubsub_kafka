defmodule Phoenix.PubSub.Kafka.Producer.Supervisor do
  @moduledoc nil

  use Supervisor
  alias Phoenix.PubSub.Kafka.Klogger

  def start_link(name, opts) do
    Klogger.debug("Producer.Supervisor.start_link(#{inspect name}, #{inspect opts})")
    name = Module.concat(name, Producer)
    sup_name = Module.concat(name, Supervisor)
    server_name = Module.concat(name, Server)
    Supervisor.start_link(__MODULE__, [server_name, opts], name: sup_name)
  end

  def init([server_name, opts]) do
    Klogger.debug("Producer.Supervisor.init([#{inspect server_name}, #{inspect opts}])")
    server_opts = opts
                  |> Keyword.merge(
                    name: server_name
                  )
    children = [
      worker(Phoenix.PubSub.Kafka.Producer.Server, [server_name, server_opts])
    ]
    supervise(children, strategy: :one_for_all)
  end
end
