defmodule BancoWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  object :conta do
    field :uuid, :string
    field :current_balance, :string
  end

end
