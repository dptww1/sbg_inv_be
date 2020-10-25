defmodule SbgInv.Web.ScenarioResourceController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.{Authentication, ScenarioResource}

  import Ecto.Query

  def index(conn, params) do
    limit = Map.get(params, "n", 5)
    from  = string_to_naive_date_time(Map.get(params, "from"), ~N[2000-01-01 00:00:00])
    to    = string_to_naive_date_time(Map.get(params, "to"  ), ~N[3001-01-01 00:00:00])

    query = ScenarioResource
            |> preload(:scenario)
            |> limit(^limit)
            |> where([r], r.updated_at >= ^from)
            |> where([r], r.updated_at <= ^to)
            |> where([r], r.resource_type != 0)
            |> order_by([desc: :updated_at])

    resources = Repo.all(query)

    render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource" => params, "scenario_id" => scenario_id}) do
    conn = Authentication.admin_required(conn)

    if conn.halted do
      send_resp(conn, :unauthorized, "")

    else
      update_or_create(conn, %ScenarioResource{}, params, scenario_id)
    end
  end

  def update(conn, %{"resource" => params, "scenario_id" => scenario_id}) do
    conn = Authentication.admin_required(conn)

    if conn.halted do
      send_resp(conn, :unauthorized, "")

    else
      resource = Repo.get!(ScenarioResource, Map.get(params, "id"))
      update_or_create(conn, resource, params, scenario_id)
    end
  end

  defp string_to_naive_date_time(nil, default_date_time), do: default_date_time

  defp string_to_naive_date_time(str, default_date_time) do
    {res, dt} = NaiveDateTime.from_iso8601(str <> " 00:00:00")
    if res == :ok, do: dt, else: default_date_time
  end

  defp update_or_create(conn, resource, params, scenario_id) do
    params = add_sort_order_if_missing(params)
    changeset = ScenarioResource.changeset(resource, Map.put(params, "scenario_id", scenario_id))

    case Repo.insert_or_update(changeset) do
      {:ok, _resource} ->
        send_resp(conn, :no_content, "")

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
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
