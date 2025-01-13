defmodule SbgInv.Web.FAQ do
  use SbgInv.Web, :model

  alias SbgInv.Web.About

  schema "faqs" do
    field :question, :string
    field :answer, :string
    field :sort_order, :integer

    timestamps()

    belongs_to :about, About
  end

  @required_params [:question, :answer, :sort_order]

  def changeset(faq, params \\ %{}) do
    faq
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end

end
