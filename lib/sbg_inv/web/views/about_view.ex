defmodule SbgInv.Web.AboutView do
  use SbgInv.Web, :view

  def render("index.json", %{about: about}) do
    %{
      data: %{
        about: about.body_text
      }
    }
  end
end
