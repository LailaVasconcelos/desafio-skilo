defmodule Banco.TransacaoRepoTest do
  use Banco.DataCase

  alias Banco.TransacaoRepo

  describe "transacao" do
    alias Banco.Entidades.Transacao

    @valid_attrs %{address: "some address", amount: "120.5", when: ~N[2010-04-17 14:00:00]}
    @update_attrs %{
      address: "some updated address",
      amount: "456.7",
      when: ~N[2011-05-18 15:01:01]
    }
    @invalid_attrs %{address: nil, amount: nil, when: nil}

    def transacao_fixture(attrs \\ %{}) do
      {:ok, transacao} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TransacaoRepo.create_transacao()

      transacao
    end

    test "list_transacao/0 returns all transacao" do
      transacao = transacao_fixture()
      assert TransacaoRepo.list_transacao() == [transacao]
    end

    test "get_transacao!/1 returns the transacao with given id" do
      transacao = transacao_fixture()
      assert TransacaoRepo.get_transacao!(transacao.uuid) == transacao
    end

    test "create_transacao/1 with valid data creates a transacao" do
      assert {:ok, %Transacao{} = transacao} = TransacaoRepo.create_transacao(@valid_attrs)
      assert transacao.address == "some address"
      assert transacao.amount == Decimal.new("120.5")
      assert transacao.when == ~N[2010-04-17 14:00:00]
    end

    test "create_transacao/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TransacaoRepo.create_transacao(@invalid_attrs)
    end

    test "update_transacao/2 with valid data updates the transacao" do
      transacao = transacao_fixture()

      assert {:ok, %Transacao{} = transacao} =
               TransacaoRepo.update_transacao(transacao, @update_attrs)

      assert transacao.address == "some updated address"
      assert transacao.amount == Decimal.new("456.7")
      assert transacao.when == ~N[2011-05-18 15:01:01]
    end

    test "update_transacao/2 with invalid data returns error changeset" do
      transacao = transacao_fixture()

      assert {:error, %Ecto.Changeset{}} =
               TransacaoRepo.update_transacao(transacao, @invalid_attrs)

      assert transacao == TransacaoRepo.get_transacao!(transacao.uuid)
    end

    test "delete_transacao/1 deletes the transacao" do
      transacao = transacao_fixture()
      assert {:ok, %Transacao{}} = TransacaoRepo.delete_transacao(transacao)
      assert_raise Ecto.NoResultsError, fn -> TransacaoRepo.get_transacao!(transacao.uuid) end
    end

    test "change_transacao/1 returns a transacao changeset" do
      transacao = transacao_fixture()
      assert %Ecto.Changeset{} = TransacaoRepo.change_transacao(transacao)
    end
  end
end
