defmodule BancoWeb.Errors do
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
