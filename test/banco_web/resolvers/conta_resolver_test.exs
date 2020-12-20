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
  end
end 
