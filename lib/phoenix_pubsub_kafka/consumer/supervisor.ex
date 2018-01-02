defmodule Phoenix.PubSub.Kafka.Consumer.Supervisor do
  use Supervisor
  require Logger

  def start_link(opts) do
    Logger.debug "### Phoenix.PubSub.Kafka.Consumer.Supervisor.start_link(#{inspect opts}) ###"
    name = :cons_name
    cons_sup_name = :cons_sup
    Supervisor.start_link(__MODULE__, [name, opts], name: cons_sup_name)
  end

  def init([server_name, opts]) when is_atom(server_name) do
    Logger.debug "### Phoenix.PubSub.Kafka.Consumer.Supervisor.init(#{inspect server_name}, #{inspect opts}) ###"
    cons_grp_opts = [Phoenix.PubSub.Kafka.Consumer.Server, "kafka_ex_demo", ["direct_chat.176"], []]
    children = [
      supervisor(KafkaEx.ConsumerGroup, cons_grp_opts)
    ]
    supervise(children, strategy: :one_for_all)
  end
end
