defmodule Banco.TransacaoRepo do
  @moduledoc """
  The TransacaoRepo context.
  """

  import Ecto.Query, warn: false
  alias Banco.Repo

  alias Banco.Entidades.Transacao

  @doc """
  Returns the list of transacao.

  ## Examples

      iex> list_transacao()
      [%Transacao{}, ...]

  """
  def list_transacao do
    Repo.all(Transacao)
  end

  @doc """
  Gets a single transacao.

  Raises `Ecto.NoResultsError` if the Transacao does not exist.

  ## Examples

      iex> get_transacao!(123)
      %Transacao{}

      iex> get_transacao!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transacao!(id), do: Repo.get!(Transacao, id)

  @doc """
  Creates a transacao.

  ## Examples

      iex> create_transacao(%{field: value})
      {:ok, %Transacao{}}

      iex> create_transacao(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transacao(attrs \\ %{}) do
    %Transacao{}
    |> Transacao.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transacao.

  ## Examples

      iex> update_transacao(transacao, %{field: new_value})
      {:ok, %Transacao{}}

      iex> update_transacao(transacao, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transacao(%Transacao{} = transacao, attrs) do
    transacao
    |> Transacao.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transacao.

  ## Examples

      iex> delete_transacao(transacao)
      {:ok, %Transacao{}}

      iex> delete_transacao(transacao)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transacao(%Transacao{} = transacao) do
    Repo.delete(transacao)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transacao changes.

  ## Examples

      iex> change_transacao(transacao)
      %Ecto.Changeset{data: %Transacao{}}

  """
  def change_transacao(%Transacao{} = transacao, attrs \\ %{}) do
    Transacao.changeset(transacao, attrs)
  end
end
