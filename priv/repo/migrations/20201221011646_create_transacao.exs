defmodule Banco.Repo.Migrations.CreateTransacao do
  use Ecto.Migration

  def change do
    create table(:transacao) do
      add :address, :binary
      add :amount, :decimal
      add :when, :naive_datetime
      add :conta_uuid, references(:conta, on_delete: :nothing)

      timestamps()
    end

    create index(:transacao, [:conta_uuid])
  end
end
