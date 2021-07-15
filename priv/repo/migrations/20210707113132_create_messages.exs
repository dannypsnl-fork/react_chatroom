defmodule ReactChatroom.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :room_id, references(:rooms)
      add :user_id, references(:users)
      add :body, :text

      timestamps()
    end

  end
end
