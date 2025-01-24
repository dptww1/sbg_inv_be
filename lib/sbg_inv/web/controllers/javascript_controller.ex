defmodule SbgInv.Web.JavascriptController do
  use SbgInv.Web, :controller

  def show(conn, %{"id" => id}) do
    _show(conn, id)
  end

  defp _show(conn, "globals") do
    conn = put_resp_content_type(conn, "application/javascript")
    render(conn, "globals.html")
  end
  defp _show(conn, _), do: send_resp(conn, :forbidden, "")
end
