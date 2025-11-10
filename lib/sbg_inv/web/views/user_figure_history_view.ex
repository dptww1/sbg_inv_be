defmodule SbgInv.Web.UserFigureHistoryView do

  use SbgInv.Web, :view

  def render("history_list.json", %{history_items: list}) do
    %{
      data: render_many(list, __MODULE__, "history_item.json")
    }
  end

  def render("history_item.json", %{user_figure_history: item}) do
    %{
      "id" => item.id,
      "user_id" => item.user_id,
      "figure_id" => item.figure_id,
      "op" => item.op,
      "op_date" => item.op_date,
      "amount" => item.amount,
      "notes" => item.notes,
      "name" => item.figure.name,
      "plural_name" => item.figure.plural_name
    }
  end

end
