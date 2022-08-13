defmodule SbgInv.Web.Session do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Session, User}

  schema "sessions" do
    field :token, :string

    belongs_to :user, User

    timestamps()
  end

  @required_fields [:user_id]

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> put_change(:token, SecureRandom.urlsafe_base64())
  end

  def query_by_token(token) do
    from s in Session,
    where: s.token == ^token
  end
end
