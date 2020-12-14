defmodule BancoWeb.Resolvers.ContaResolver do
  alias Banco.ContaRepo
  alias BancoWeb.Errors

  def open_account(%{balance: balance_str}, _info) do
    ContaRepo.create_conta(%{current_balance: Decimal.new(balance_str)})
  end

  def account(_parent, %{uuid: uuid_conta}, _resolution) do
    try do
      {:ok, ContaRepo.get_conta!(uuid_conta)}
    rescue
      _ in Ecto.NoResultsError -> Errors.not_found("Conta")
    end
  end  
end
