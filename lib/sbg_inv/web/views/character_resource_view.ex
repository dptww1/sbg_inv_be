defmodule SbgInv.Web.CharacterResourceView do

  use SbgInv.Web, :view

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, __MODULE__, "index_instance.json", as: :resource)}
  end

  def render("index_instance.json", %{resource: resource}) do
    base_map(resource)
    |> Map.put("character_name", resource.character.name)
    |> Map.put("date", String.slice(NaiveDateTime.to_string(resource.inserted_at), 0..9))
  end

  def render("resource.json", %{resource: resource}) do
    base_map(resource)
  end

  defp base_map(resource) do
    %{
      "id" => resource.id,
      "title" => resource.title,
      "book" => (if is_nil(resource.book), do: nil, else: resource.book.key),
      "issue" => resource.issue,
      "page" => resource.page,
      "type" => resource.type,
      "url" => resource.url
    }
  end
end
