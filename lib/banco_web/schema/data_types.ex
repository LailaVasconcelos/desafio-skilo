defmodule BancoWeb.Schema.DataTypes do
  @moduledoc """
  Este módulo contém as estruturas usadas no schema da api.
  """
  use Absinthe.Schema.Notation

  object :conta do
    field :uuid, :string
    field :current_balance, :string
  end

end
