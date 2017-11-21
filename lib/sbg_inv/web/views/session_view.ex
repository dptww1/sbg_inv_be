defmodule SbgInv.Web.SessionView do

  use SbgInv.Web, :view

  def render("show.json", %{session: session}) do
    %{data: render_one(session, __MODULE__, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{
      token: session.token,
      name: session.user.name,
      user_id: session.user.id,
      is_admin: session.user.is_admin
    }
  end

  def render("error.json", _anything) do
    %{errors: "failed to authenticate"}
  end
end
