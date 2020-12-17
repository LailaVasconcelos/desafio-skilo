defmodule BancoWeb.ContaResolverTest do
  @moduledoc false
  use Banco.DataCase

  alias Banco.ContaRepo
  alias BancoWeb.Resolvers.ContaResolver

  describe "ContaResolver" do
    @valida_conta_attrs %{current_balance: "100"}

    def conta_fixture(attrs \\ %{}) do
      {:ok, conta} =
        attrs
        |> Enum.into(@valida_conta_attrs)
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
  end
end

  
