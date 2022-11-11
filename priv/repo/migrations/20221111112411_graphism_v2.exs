defmodule(Graphism.Migration.V2) do
  use(Ecto.Migration)

  def(up) do
    create(table(:templates, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:name, :string, null: false)

      add(:organisation_id, references(:organisations, on_delete: :nothing, type: :uuid),
        null: false
      )

      timestamps()
    end

    create(table(:template_shifts, primary_key: false)) do
      add(:day, :integer, null: false)
      add(:duration, :integer, null: false)
      add(:id, :uuid, null: false, primary_key: true)
      add(:staffing, :integer, null: false)
      add(:start, :integer, null: false)
      add(:template_id, references(:templates, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(table(:schedules, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)

      add(:organisation_id, references(:organisations, on_delete: :nothing, type: :uuid),
        null: false
      )

      add(:template_id, references(:templates, on_delete: :nothing, type: :uuid), null: false)
      add(:week, :integer, null: false)
      add(:year, :integer, null: false)
      timestamps()
    end

    create(table(:schedule_shifts, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:member_id, references(:members, on_delete: :nothing, type: :uuid), null: false)
      add(:schedule_id, references(:schedules, on_delete: :nothing, type: :uuid), null: false)

      add(:template_id, references(:template_shifts, on_delete: :nothing, type: :uuid),
        null: false
      )

      timestamps()
    end

    create(table(:shift_tags, primary_key: false)) do
      add(:id, :uuid, null: false, primary_key: true)
      add(:shift_id, references(:template_shifts, on_delete: :nothing, type: :uuid), null: false)
      add(:tag_id, references(:tags, on_delete: :nothing, type: :uuid), null: false)
      timestamps()
    end

    create(
      unique_index(:templates, [:organisation_id, :name],
        name: :templates_organisation_id_name_key
      )
    )

    create(unique_index(:shift_tags, [:shift_id, :tag_id], name: :shift_tags_shift_id_tag_id_key))

    create(
      unique_index(:schedules, [:organisation_id, :template_id, :year, :week],
        name: :schedules_organisation_id_template_id_year_week_key
      )
    )
  end

  def(down) do
    []
  end
end
