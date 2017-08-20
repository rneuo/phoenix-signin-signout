defmodule MyApp.SessionController do
  use MyApp.Web, :controller

  alias MyApp.User
  alias MyApp.Auth

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Auth.valid?(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Log In successfully.")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: user_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid password or email")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, %{}) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: login_path(conn, :new))
  end
end
