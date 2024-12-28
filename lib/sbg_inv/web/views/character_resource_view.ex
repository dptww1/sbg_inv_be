defmodule SbgInv.Web.CharacterResourceView do

  use SbgInv.Web, :view

  def render("resource.json", %{resource: resource}) do
    %{
      "title" => resource.title,
      "book" => resource.book,
      "issue" => resource.issue,
      "page" => resource.page,
      "type" => resource.type,
      "url" => resource.url
    }
  end
end
