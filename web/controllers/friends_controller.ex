defmodule Unsub.FriendsController do
  use Unsub.Web, :controller

  alias Unsub.{Twitter, User, Repo}

  def delete(conn, %{"id" => id}) do
    user = Repo.get User, get_session(conn, :current_user)
    Twitter.setup(user.access_token)
    ExTwitter.unfollow(id)
    conn |> redirect(to: page_path(conn, :friends))
  end

end
