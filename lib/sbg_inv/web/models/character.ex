defmodule SbgInv.Web.Character do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, CharacterResource}

  schema "characters" do
    field :name, :string
    field :book, ScenarioResourceBook
    field :page, :integer

    timestamps()

    has_many :character_resources, CharacterResource
    many_to_many :figures, Figure,
             join_through: "character_figures",
             on_replace: :delete
  end

  @doc false
  def changeset(character, params \\ %{}) do

    figures =
      Map.get(params, "figure_ids", [])
      |> load_figures

    character
    |> cast(params, [:name, :book, :page])
    |> put_assoc(:figures, figures)
    |> validate_required([:name])
  end

  defp load_figures([]), do: []
  defp load_figures(figure_ids) do
    SbgInv.Repo.all(
      from f in Figure,
      where: f.id in ^figure_ids,
      order_by: f.name)
  end
end
