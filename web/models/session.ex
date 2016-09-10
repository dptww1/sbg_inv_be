defmodule SbgInv.Session do
  use SbgInv.Web, :model

  schema "sessions" do
    field :token, :string
    belongs_to :user, SbgInv.User

    timestamps()
  end
  @required_fields ~w(user_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> put_change(:token, SecureRandom.urlsafe_base64())
  end
end
