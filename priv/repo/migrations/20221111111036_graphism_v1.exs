defmodule(Graphism.Migration.V1) do
  use(Ecto.Migration)

  def(up) do
    create(table(:users, primary_key: false)) do
      add(:email, :string, unique: true, null: false)
      add(:first_name, :string, null: false)
      add(:id, :uuid, null: false, primary_key: true)
      add(:lang, :string, null: false)
      add(:last_name, :string, null: false)
      timestamps()
    end

    create(table(:organisations, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:name, :string, unique: true, null: false)
      add(:user_id, references(:users, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(table(:tags, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:name, :string, unique: true, null: false)

      add(:organisation_id, references(:organisations, on_delete: :nothing, type: :uuid),
        null: false
      )

      timestamps()
    end

    create(table(:profiles, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:name, :string, null: false)

      add(:organisation_id, references(:organisations, on_delete: :nothing, type: :uuid),
        null: false
      )

      timestamps()
    end

    create(table(:indicators, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:name, :string, unique: true, null: false)
      timestamps()
    end

    create(table(:rules, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:indicator_id, references(:indicators, on_delete: :nothing, type: :uuid), null: false)
      add(:profile_id, references(:profiles, on_delete: :nothing, type: :uuid), null: false)
      add(:strong, :boolean, null: false)
      add(:value, :integer, null: false)
      timestamps()
    end

    create(table(:members, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)

      add(:organisation_id, references(:organisations, on_delete: :nothing, type: :uuid),
        null: false
      )

      add(:user_id, references(:users, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(table(:member_tags, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:member_id, references(:members, on_delete: :nothing, type: :uuid), null: false)
      add(:tag_id, references(:tags, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(table(:member_profiles, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:member_id, references(:members, on_delete: :nothing, type: :uuid), null: false)
      add(:profile_id, references(:profiles, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(unique_index(:users, [:email], name: :users_email_key))
    create(unique_index(:tags, [:name], name: :tags_name_key))

    create(
      unique_index(:rules, [:profile_id, :indicator_id], name: :rules_profile_id_indicator_id_key)
    )

    create(unique_index(:organisations, [:name], name: :organisations_name_key))

    create(
      unique_index(:members, [:user_id, :organisation_id],
        name: :members_user_id_organisation_id_key
      )
    )

    create(
      unique_index(:member_tags, [:member_id, :tag_id], name: :member_tags_member_id_tag_id_key)
    )

    create(
      unique_index(:member_profiles, [:member_id, :profile_id],
        name: :member_profiles_member_id_profile_id_key
      )
    )

    create(unique_index(:indicators, [:name], name: :indicators_name_key))
  end

  def(down) do
    []
  end
end
