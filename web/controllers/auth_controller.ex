defmodule Unsub.AuthController do
  use Unsub.Web, :controller

  alias Unsub.Twitter

  def callback(conn, params) do
    {:ok, access_token} = get_access_token(params)

    Twitter.setup(access_token)
    ExTwitter.verify_credentials()
    |> IO.inspect

    conn |> redirect(to: "/")
  end

  def get_access_token(%{"oauth_verifier" => verifier, "oauth_token" => token}) do
    ExTwitter.access_token(verifier, token)
  end

end
