defmodule Banco.ContaRepoTest do
  use Banco.DataCase

  alias Banco.ContaRepo

  describe "conta" do
    alias Banco.Entidades.Conta

    @valid_attrs %{current_balance: "120.5"}
    @update_attrs %{current_balance: "456.7"}
    @invalid_attrs %{current_balance: nil}

    def conta_fixture(attrs \\ %{}) do
      {:ok, conta} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContaRepo.create_conta()

      conta
    end

    test "list_conta/0 returns all conta" do
      conta = conta_fixture()
      assert ContaRepo.list_conta() == [conta]
    end

    test "get_conta!/1 returns the conta with given id" do
      conta = conta_fixture()
      assert ContaRepo.get_conta!(conta.uuid) == conta
    end

    test "create_conta/1 with valid data creates a conta" do
      assert {:ok, %Conta{} = conta} = ContaRepo.create_conta(@valid_attrs)
      assert conta.current_balance == Decimal.new("120.5")
    end

    test "create_conta/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContaRepo.create_conta(@invalid_attrs)
    end

    test "update_conta/2 with valid data updates the conta" do
      conta = conta_fixture()
      assert {:ok, %Conta{} = conta} = ContaRepo.update_conta(conta, @update_attrs)
      assert conta.current_balance == Decimal.new("456.7")
    end

    test "update_conta/2 with invalid data returns error changeset" do
      conta = conta_fixture()
      assert {:error, %Ecto.Changeset{}} = ContaRepo.update_conta(conta, @invalid_attrs)
      assert conta == ContaRepo.get_conta!(conta.uuid)
    end

    test "delete_conta/1 deletes the conta" do
      conta = conta_fixture()
      assert {:ok, %Conta{}} = ContaRepo.delete_conta(conta)
      assert_raise Ecto.NoResultsError, fn -> ContaRepo.get_conta!(conta.uuid) end
    end

    test "change_conta/1 returns a conta changeset" do
      conta = conta_fixture()
      assert %Ecto.Changeset{} = ContaRepo.change_conta(conta)
    end
  end
end
