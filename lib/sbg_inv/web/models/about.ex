defmodule SbgInv.Web.About do
  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{About, FAQ}

  schema "about" do
    field :body_text, :string

    timestamps()

    has_many(:faqs, FAQ, on_replace: :delete)
  end

  @required_fields [:body_text]

  def changeset(model, params \\%{}) do
    model
    |> cast(params, @required_fields)
    |> cast_assoc(:faqs)
    |> validate_required(@required_fields)
  end

  def query_singleton() do
    from a in About
  end

  def with_faqs(query) do
    fq = from faq in FAQ, order_by: faq.sort_order

    from q in query,
    preload: [faqs: ^fq]
  end
end
