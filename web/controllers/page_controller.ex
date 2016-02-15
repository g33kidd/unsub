defmodule Unsub.PageController do
  use Unsub.Web, :controller

  def index(conn, _params) do
    token = ExTwitter.request_token "http://localhost:4000/auth/callback"
    {:ok, authenticate_url} = ExTwitter.authenticate_url token.oauth_token
    render conn, "index.html",
      auth_url: authenticate_url
  end
end
