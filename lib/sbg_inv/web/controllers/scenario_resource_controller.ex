defmodule SbgInv.Web.ScenarioResourceController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.{Authentication, ScenarioResource}

  import Ecto.Query

  def create(conn, %{"resource" => params, "scenario_id" => scenario_id}) do
    conn = Authentication.admin_required(conn)

    if conn.halted do
      send_resp(conn, :unauthorized, "")

    else
      params = add_sort_order_if_missing(params)
      changeset = ScenarioResource.changeset(%ScenarioResource{}, Map.put(params, "scenario_id", scenario_id))

      case Repo.insert(changeset) do
        {:ok, _resource} ->
          send_resp(conn, :no_content, "")

        {:error, _changeset} ->
          IO.inspect changeset
          send_resp(conn, :unprocessable_entity, "")
      end
    end
  end

  defp add_sort_order_if_missing(params) do
    if !Map.has_key? params, "sort_order" do
      type = Map.get(params, "resource_type")

      sort_order =
        if is_nil type do
          1
        else
          query = from sr in ScenarioResource,
                  where: sr.scenario_id == sr.scenario_id and
                         sr.resource_type == ^type,
                  select: count(sr.id)
          Repo.one(query) + 1
        end

      Map.put params, "sort_order", sort_order
    end
  end
end
