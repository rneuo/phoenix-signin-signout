defmodule MyApp.User do
  use MyApp.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> put_change(:encrypted_password, encrypted_password(params["password"]))
  end

  defp encrypted_password(password) do
    if password do
      Comeonin.Bcrypt.hashpwsalt(password)
    end
  end
end
