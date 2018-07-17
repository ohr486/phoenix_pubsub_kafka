defmodule Phoenix.PubSub.Kafka.Consumer.RestartMonitor do
  @table_name :phoenix_pubsub_kafka_restart_count
  @count :count

  def get_count, do: confirm_table_existence() &&
    with [{@count, num}] <- :ets.lookup(@table_name, @count), do: num, else: (_ -> 0)

  def increment_count, do: get_count() |> Kernel.+(1) |> set_count()

  defp set_count(num), do: confirm_table_existence() && :ets.insert(@table_name, {@count, num})

  defp confirm_table_existence, do: table_exists?() || !!create_table()

  defp table_exists?, do: if :undefined == :ets.info(@table_name), do: false, else: true

  defp create_table, do: :ets.new(@table_name, [:named_table, :set])
end
