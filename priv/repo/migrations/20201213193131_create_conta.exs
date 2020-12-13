defmodule Banco.Repo.Migrations.CreateConta do
  use Ecto.Migration

  def change do
    create table(:conta) do
      add :current_balance, :decimal

      timestamps()
    end

  end
end
