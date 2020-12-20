defmodule BancoWeb.Resolvers.ContaResolver do
  @moduledoc """
  Este modulo possui os métodos necessários para as queries e mutations referentes a conta corrente.
  """

  alias Banco.ContaRepo
  alias BancoWeb.Errors

  @doc """
  Abre uma conta bancária com saldo.

  ## Parâmetros

  - params: Map com o valor do balance. Formato: %{balance: "100"}
  - _info: parâmetro que será ignorado.
  """

  def open_account(%{balance: balance_str}, _info) do  
    ContaRepo.create_conta(%{current_balance: Decimal.new(balance_str)})
  end

  @doc """
  Obtém as informações de uma conta bancária.
  
  ## Parâmetros

  - _parent: parâmetro que será ignorado.
  - params: Map com o uuid da conta. Formato: %{uuid: "..."}
  - _resolution: parâmetro que será ignorado.
  """
  def account(_parent, %{uuid: uuid_conta}, _resolution) do
    try do
      {:ok, ContaRepo.get_conta!(uuid_conta)}
    rescue
      _ in Ecto.NoResultsError -> Errors.not_found("Conta")
    end
  end  
end
