defmodule SbgInv.Web.User do

  use SbgInv.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean

    timestamps()
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 255)
    |> update_email_changeset(params)
    |> update_password_changeset(params)
  end

  def update_password_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 3)
    |> put_password_hash
  end

  def update_email_changeset(struct, params \\ %{}) do
   struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> validate_length(:email, min: 3, max: 255)
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
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end
end
