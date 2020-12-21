defmodule BancoWeb.Resolvers.ContaResolver do
  @moduledoc """
  Este modulo possui os métodos necessários para as queries e mutations referentes a conta corrente.
  """

  alias Banco.ContaRepo
  alias Banco.TransacaoRepo
  alias BancoWeb.Errors
  alias Banco.Repo

  @doc """
  Abre uma conta bancária com saldo.

  ## Parâmetros

  - params: Map com o valor do balance. Formato: %{balance: "100"}
  - _info: parâmetro que será ignorado.
  """

  def open_account(%{balance: balance_str}, _info) do   
    if Decimal.positive?(Decimal.new(balance_str)) do
      ContaRepo.create_conta(%{current_balance: Decimal.new(balance_str)})
    else
      {
        :error,
        %{
          code: :request_invalid,
          message: "Não é permitido abrir uma conta corrente com saldo negativo."
        }
      }
    end
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
      {:ok, ContaRepo.get_conta!(uuid_conta) |> Repo.preload(:transactions)}
    rescue
      _ in Ecto.NoResultsError -> Errors.not_found("Conta")
    end
  end
  
  def transfer_money(%{sender: uuid_conta_origem, address: uuid_conta_destino, amount: valor_str}, _info) do
    case {uuid_conta_origem, uuid_conta_destino, Decimal.new(valor_str)} do
      {origem, destino, _} when origem == destino -> {
        :error,
        %{
          code: :request_invalid,
          message: "Não é permitido transferir dinheiro pra conta de origem."
        }
      }
      {origem, destino, valor} ->
        if Decimal.negative?(valor) do
          {
            :error,
            %{
              code: :request_invalid,
              message: "Não é permitido transferir valores negativos."
            }
          }
        else
          try do
            conta_origem = ContaRepo.get_conta!(origem)
            if Decimal.negative?(Decimal.sub(conta_origem.current_balance, valor)) do
              {
                :error,
                %{
                  code: :saldo_insuficiente,
                  message: "A conta de origem não tem saldo suficiente para a transação."
                }
              }
            else
              conta_destino = ContaRepo.get_conta!(destino)
              # Adiciona a transacao negativa na conta de origem
              {:ok, transacao_origem} = TransacaoRepo.create_transacao(%{
                conta_uuid: conta_origem.uuid,
                address: conta_destino.uuid,
                when: DateTime.utc_now,
                amount: Decimal.mult(valor, -1)
              })
              # Adiciona uma transacao positiva na conta de destino
              TransacaoRepo.create_transacao(%{
                conta_uuid: conta_destino.uuid,
                address: conta_origem.uuid,
                when: DateTime.utc_now,
                amount: valor,
              })
              # Alterar o saldo da conta de origem
              ContaRepo.update_conta(conta_origem, %{current_balance: Decimal.sub(conta_origem.current_balance, valor)})
              # Alterar o saldo da conta de destino
              ContaRepo.update_conta(conta_destino, %{current_balance: Decimal.add(conta_destino.current_balance, valor)})
              {:ok, transacao_origem}
            end
          rescue
            _ in Ecto.NoResultsError -> Errors.not_found("Conta")
          end
        end
    end
  end
end

