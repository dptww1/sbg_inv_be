defmodule SbgInv.Web.CharacterRuleView do

  use SbgInv.Web, :view

  def render("rule.json", %{rule: rule}) do
    %{
      "name_override" => rule.name_override,
      "book" => (if is_nil(rule.book), do: nil, else: rule.book.key),
      "issue" => rule.issue,
      "page" => rule.page,
      "url" => rule.url,
      "obsolete" => rule.obsolete,
      "sort_order" => rule.sort_order
    }
  end
end
