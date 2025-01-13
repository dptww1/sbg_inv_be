defmodule SbgInv.Web.FAQView do
  use SbgInv.Web, :view

  def render("faq.json", %{faq: faq}) do
    %{
      id: faq.id,
      question: faq.question,
      answer: faq.answer,
      sort_order: faq.sort_order
    }
  end
end
