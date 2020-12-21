defmodule BancoWeb.Errors do
  @moduledoc """
  Módulo de suporte que tem como objetivo padronizar os erros da api.
  """
  def not_found(element_type) do
    {
      :error,
      %{
        code: :not_found,
        message: "#{element_type} não encontrado(a)"
      }
    }
  end
end
