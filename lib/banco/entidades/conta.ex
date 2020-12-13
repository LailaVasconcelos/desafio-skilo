defmodule Banco.Entidades.Conta do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "conta" do
    field :current_balance, :decimal

    timestamps()
  end

  @doc false
  def changeset(conta, attrs) do
    conta
    |> cast(attrs, [:current_balance])
    |> validate_required([:current_balance])
  end
end
