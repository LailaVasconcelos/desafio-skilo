defmodule BancoWeb.ContaResolverTest do
  @moduledoc false
  use Banco.DataCase

  alias Banco.ContaRepo
  alias BancoWeb.Resolvers.ContaResolver

  describe "ContaResolver" do
    @valid_attrs  %{current_balance: "100"}

    def conta_fixture(attrs \\ %{}) do
      {:ok, conta} =
        attrs
        |> Enum.into(@valid_attrs )
        |> ContaRepo.create_conta()

      conta
    end

    test "account/3 obtém as informações de uma conta corrente existente" do
      conta = conta_fixture()
      assert ContaResolver.account("", %{uuid: conta.uuid}, "") == {:ok, conta}
    end

    test "account/3 erro ao consultar uma conta corrente inexistente" do
      assert ContaResolver.account("", %{uuid: "b0963dda-5f70-4ff8-a08d-8a32064b2940"}, "") == {
        :error,
        %{
          code: :not_found,
          message: "Conta não encontrado(a)"
        }
      }
    end

    test "open_account/2 abre uma conta bancária com saldo" do
      assert {:ok, conta} = ContaResolver.open_account(%{balance: "120.5"}, "")
      assert conta.current_balance == Decimal.new("120.5")
    end

    test "open_account/2 erro ao abrir uma conta corrente com saldo negativo" do
      assert ContaResolver.open_account(%{balance: "-120.5"}, "") == {
        :error,
        %{
          code: :request_invalid,
          message: "Não é permitido abrir uma conta corrente com saldo negativo."
        }
      }
    end

    test "transfer_money/2 erro ao transferir para a mesma conta" do
      assert ContaResolver.transfer_money(%{
          sender: "b0963dda-5f70-4ff8-a08d-8a32064b2940",
          address: "b0963dda-5f70-4ff8-a08d-8a32064b2940",
          amount: "150"
        }, "") == {
          :error,
          %{
            code: :request_invalid,
            message: "Não é permitido transferir dinheiro pra conta de origem."
          }
        }
    end

    test "transfer_money/2 erro ao transferir valores negativos" do
      assert ContaResolver.transfer_money(%{
        sender: "hgad738hjak9",
        address: "adjhaskdhlakdh",
        amount: "-155.00"
      }, "") == {
        :error,
        %{
          code: :request_invalid,
          message: "Não é permitido transferir valores negativos."
        } 
      }
    end

    test "transfer_money/2 saldo insuficiente" do
      conta_origem = conta_fixture(%{current_balance: "300"})
      assert ContaResolver.transfer_money(%{
        sender: conta_origem.uuid,
        address: "jgjh687hkh0",
        amount: "3000"
      }, "") == {
        :error,
        %{
          code: :saldo_insuficiente,
          message: "A conta de origem não tem saldo suficiente para a transação."
        }
      }
    end

    test "transfer_money/2 transferencia com sucesso" do
      conta_origem = conta_fixture(%{current_balance: "300"})
      conta_destino = conta_fixture(%{current_balance: "250"})
      assert {:ok, transacao_origem} = ContaResolver.transfer_money(%{
        sender: conta_origem.uuid,
        address: conta_destino.uuid,
        amount: "60"
      }, "")
      assert transacao_origem.conta_uuid == conta_origem.uuid
      assert transacao_origem.address == conta_destino.uuid
      assert transacao_origem.amount == Decimal.new("-60")
    end
  end
end 
