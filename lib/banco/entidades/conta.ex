defmodule Banco.Entidades.Conta do
  @moduledoc """
  Esta entidade representa a conta corrente.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Banco.Entidades.Transacao

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "conta" do
    field :current_balance, :decimal

    has_many :transactions, Transacao, references: :uuid, foreign_key: :conta_uuid

    timestamps()
  end

  def changeset(conta, attrs) do
    conta
    |> cast(attrs, [:current_balance])
    |> validate_required([:current_balance])
  end
end
