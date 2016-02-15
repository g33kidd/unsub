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
        |> redirect(to: "/")
      {:error, reason} ->
        IO.puts reason
        conn |> redirect(to: "/")
    end
  end

end
