defmodule SbgInv.Web.AboutView do
  use SbgInv.Web, :view

  alias SbgInv.Web.FAQView

  def render("index.json", %{about: about}) do
    %{
      data: %{
        body_text: about.body_text,
        faqs: render_many(about.faqs, FAQView, "faq.json", as: :faq)
      }
    }
  end
end
