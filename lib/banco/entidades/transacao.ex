defmodule Banco.Entidades.Transacao do
  @moduledoc """
  Esta entidade representa transação.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Banco.Entidades.Conta

  @primary_key {:uuid, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transacao" do
    field :address, :binary
    field :amount, :decimal
    field :when, :naive_datetime
    
    belongs_to :conta, Conta,
      foreign_key: :conta_uuid,
      references: :uuid

    timestamps()
  end

  @doc false
  def changeset(transacao, attrs) do
    transacao
    |> cast(attrs, [:address, :amount, :when, :conta_uuid])
    |> validate_required([:address, :amount, :when])
  end
end
