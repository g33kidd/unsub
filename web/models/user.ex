defmodule Unsub.User do
  use Unsub.Web, :model

  alias Unsub.{Repo, User, Twitter}

  schema "users" do
    field :username, :string
    field :name, :string
    field :access_token, :map

    timestamps
  end

  @required_fields ~w(username name access_token)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def find_or_create(access_token) do
    account = Twitter.basic_info()
    case Repo.get_by User, username: account.username do
      nil -> create(account, access_token)
      user -> {:ok, user}
    end
  end

  def create(params, access_token) do
    user = Map.merge(params, %{ access_token: Map.from_struct(access_token) })
    changeset = User.changeset %User{}, user
    case Repo.insert changeset do
      {:ok, user} ->
        user = Map.delete(user, :access_token)
        {:ok, user}
      {:error, changeset} ->
        IO.inspect changeset
        {:error, changeset.errors}
    end
  end

  def logged_in?(conn) do
    if Plug.Conn.get_session(conn, :current_user) do
      true
    else
      false
    end
  end

  def current_user(conn) do
    if logged_in?(conn) do
      Repo.get User, Plug.Conn.get_session(conn, :current_user)
    end
  end

end
