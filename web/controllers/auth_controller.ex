defmodule Unsub.AuthController do
  use Unsub.Web, :controller

  alias Unsub.{Twitter, User}

  def callback(conn, params) do
    access_token = Twitter.get_access_token(params)
    Twitter.setup(access_token)
    case User.find_or_create(access_token) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "You are now signed in!")
        |> redirect(to: "/")
      {:error, reason} ->
        IO.puts reason
        conn |> redirect(to: "/")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out!")
    |> redirect(to: "/")
  end

end
