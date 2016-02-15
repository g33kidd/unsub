defmodule Unsub.Twitter do
  @moduledoc """
  The purpose of this module is to make it easier to interface with ExTwitter.

  ExTwitter requires you to Configure the oauth config settings each time before
  you make calls to the Twitter API. This is great for server-side tasks, but not
  so great for multiple users.

  All you need is the users access_token, which is stored in the `users` table
  as a Map in the databse.

  **Note:** be sure to call `setup(access_token)` before using any of these other
  methods in this module.
  """

  @doc """
  Sets the ExTwitter configuration for the current process.
  """
  def setup(access_token) do
    ExTwitter.Config.set :process, [
      consumer_key: System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token: access_token.oauth_token,
      access_token_secret: access_token.oauth_token_secret
    ]
  end

  def get_access_token(%{"oauth_verifier" => verifier, "oauth_token" => token}) do
    {:ok, access_token} = ExTwitter.access_token(verifier, token)
    access_token
  end

  def basic_info(), do: current_account() |> basic_info()
  def basic_info(credentials) do
    %{
      username: credentials.screen_name,
      name: credentials.name
    }
  end

  def current_account(), do: ExTwitter.verify_credentials

  # def get_following() do
  # end
  #
  # def get_followers() do
  # end

end
