defmodule SbgInv.Web.CharacterResourceView do

  use SbgInv.Web, :view

  def render("resource.json", %{resource: resource}) do
    %{
      "title" => resource.title,
      "book" => (if is_nil(resource.book), do: nil, else: resource.book.key),
      "issue" => resource.issue,
      "page" => resource.page,
      "type" => resource.type,
      "url" => resource.url
    }
  end
end
