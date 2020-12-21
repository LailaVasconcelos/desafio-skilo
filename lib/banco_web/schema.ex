defmodule BancoWeb.Schema do
  @moduledoc """
  Este módulo tem como objetivo definir o schema graphql da API.
  """

  use Absinthe.Schema

  alias BancoWeb.Resolvers.ContaResolver

  import_types(BancoWeb.Schema.DataTypes)

  query do
    @desc "Consulta as informações de uma conta"
    field :account, type: :conta do
      arg(:uuid, non_null(:string))

      resolve(&ContaResolver.account/3)
    end
  end

  mutation do
    @desc "Abre uma conta com saldo inicial"
    field :open_account, type: :conta do
      arg(:balance, non_null(:string))

      resolve(&ContaResolver.open_account/2)
    end

    @desc "Transfere ativos entre contas correntes"
    field :transfer_money, type: :transacao do
      arg(:sender, non_null(:string))
      arg(:addres, non_null(:string))
      arg(:amount, non_null(:string))

      resolve(&ContaResolver.transfer_money/2)
    end
  end
end
