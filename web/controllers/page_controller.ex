defmodule Unsub.PageController do
  use Unsub.Web, :controller

  alias Unsub.{Repo, User, Twitter}

  def index(conn, _params) do
    token = ExTwitter.request_token "http://localhost:4000/auth/callback"
    {:ok, authenticate_url} = ExTwitter.authenticate_url token.oauth_token
    render conn, "index.html",
      auth_url: authenticate_url
  end

  def friends(conn, _params) do
    user = Repo.get User, get_session(conn, :current_user)
    Twitter.setup(user.access_token)
    creds = Twitter.current_account()
    following = Map.from_struct(Twitter.get_following(200))
    IO.inspect following
    render conn, "friends.html", following: following.items
  end

end
