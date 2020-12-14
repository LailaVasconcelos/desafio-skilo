defmodule BancoWeb.Schema do
  use Absinthe.Schema

  alias BancoWeb.Resolvers.ContaResolver

  import_types BancoWeb.Schema.DataTypes

  query do
    field :account, type: :conta do
      arg :uuid, non_null(:string)

      resolve &ContaResolver.account/3
    end
  end

  mutation do
    field :open_account, type: :conta do
      arg :balance, non_null(:string)

      resolve &ContaResolver.open_account/2
    end
  end

end


