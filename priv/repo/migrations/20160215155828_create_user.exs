defmodule Unsub.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :name, :string
      add :access_token, :map

      timestamps
    end

  end
end
