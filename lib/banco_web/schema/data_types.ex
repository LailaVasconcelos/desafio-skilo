defmodule BancoWeb.Schema.DataTypes do
  @moduledoc """
  Este módulo contém as estruturas usadas no schema da api.
  """
  use Absinthe.Schema.Notation

  object :conta do
    field :uuid, :string
    field :current_balance, :string
    field :transactions, non_null(list_of(:transacao))
  end

  object :transacao do
    field :uuid, :string
    field :address, :string
    field :amount, :string
    field :when, :string
  end

end
