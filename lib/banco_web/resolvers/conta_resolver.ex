defmodule BancoWeb.Resolvers.ContaResolver do
  alias Banco.ContaRepo

  def open_account(%{balance: balance_str}, _info) do
    ContaRepo.create_conta(%{current_balance: Decimal.new(balance_str)})
  end
end
