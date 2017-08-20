defmodule MyApp.Auth do
  alias MyApp.Repo
  alias MyApp.User

  def valid?(changeset) do
    Repo.get_by(User, email: String.downcase(changeset.changes.email))
    |> Comeonin.Bcrypt.check_pass(changeset.changes.password)
  end
end
