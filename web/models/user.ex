defmodule SbgInv.User do
  use SbgInv.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(name), [])
    |> validate_length(:name, min: 1, max: 255)
    |> update_email_changeset(params)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> update_password_changeset(params)
  end

  def update_password_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_password_hash
  end

  def update_email_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email), [])
    |> validate_length(:email, min: 1, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def update_changeset(struct, params \\ %{}) do
    struct
    |> update_email_changeset(params)
    |> update_password_changeset(params)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
