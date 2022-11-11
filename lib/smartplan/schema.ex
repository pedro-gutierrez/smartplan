defmodule Smartplan.Schema do
  @moduledoc false
  use Graphism, repo: Smartplan.Repo, styles: [:rest]

  role([:current_user, :roles])

  entity :user do
    unique(string(:email))
    string(:first_name)
    string(:last_name)
    string(:lang)
    has_many(:organisations)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:admin)
    end
  end

  entity :organisation do
    unique(string(:name))
    belongs_to(:user)
    has_many(:tags)
    has_many(:profiles)
    has_many(:members)
    has_many(:templates)
    has_many(:schedules)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :member do
    belongs_to(:user)
    belongs_to(:organisation)
    has_many(:member_tags, as: :tags)
    has_many(:member_profiles, as: :profiles)
    key([:user, :organisation])

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :profile do
    string(:name)
    belongs_to(:organisation)
    has_many(:rules)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :indicator do
    unique(string(:name))

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:admin)
    end
  end

  entity :rule do
    boolean(:strong)
    integer(:value)
    belongs_to(:profile)
    belongs_to(:indicator)
    key([:profile, :indicator])

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :tag do
    unique(string(:name))
    belongs_to(:organisation)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :member_tag do
    belongs_to(:member)
    belongs_to(:tag)
    key([:member, :tag])

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :member_profile do
    belongs_to(:member)
    belongs_to(:profile)
    key([:member, :profile])

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :template do
    string(:name)
    belongs_to(:organisation)
    key([:organisation, :name])
    has_many(:template_shifts, as: :shifts)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :template_shift do
    integer(:staffing)
    integer(:day)
    integer(:start)
    integer(:duration)
    belongs_to(:template)
    has_many(:shift_tags)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :shift_tag do
    belongs_to(:template_shift, as: :shift)
    belongs_to(:tag)
    key([:shift, :tag])
  end

  entity :schedule do
    integer(:year)
    integer(:week)
    belongs_to(:organisation)
    belongs_to(:template)
    has_many(:schedule_shifts, as: :shifts)
    key([:organisation, :template, :year, :week])

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end

  entity :schedule_shift do
    belongs_to(:member)
    belongs_to(:schedule)
    belongs_to(:template_shift, as: :template)

    action(:list)
    action(:read)
    action(:create)
    action(:update)

    allow do
      read(:user)
      write(:user)
    end
  end
end
