defmodule SbgInv.Web.ScenarioResourceController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.{BookUtils, ScenarioResource}

  import SbgInv.Web.ControllerMacros

  def index(conn, params) do
    limit = Map.get(params, "n", 5)
    from  = string_to_naive_date_time(Map.get(params, "from"), ~N[2000-01-01 00:00:00])
    to    = string_to_naive_date_time(Map.get(params, "to"  ), ~N[3001-01-01 00:00:00])

    resources =
      ScenarioResource.query_by_date_range(from, to, limit)
      |> Repo.all
      |> BookUtils.add_book_refs()

    render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource" => params, "scenario_id" => scenario_id}) do
    with_admin_user conn do
      update_or_create(conn, %ScenarioResource{}, params, scenario_id)
    end
  end

  def update(conn, %{"resource" => params, "scenario_id" => scenario_id}) do
    with_admin_user conn do
      resource =
        ScenarioResource.query_by_id(Map.get(params, "id"))
        |> Repo.one
      update_or_create(conn, resource, params, scenario_id)
    end
  end

  defp string_to_naive_date_time(nil, default_date_time), do: default_date_time
  defp string_to_naive_date_time(str, default_date_time) do
    {res, dt} = NaiveDateTime.from_iso8601(str <> " 00:00:00")
    if res == :ok, do: dt, else: default_date_time
  end

  defp update_or_create(conn, resource, params, scenario_id) do
    params = params
    |> add_sort_order_if_missing(scenario_id)
    |> BookUtils.add_book_ref()
    changeset = ScenarioResource.changeset(resource, Map.put(params, "scenario_id", scenario_id))

    case Repo.insert_or_update(changeset) do
      {:ok, _resource} ->
        send_resp(conn, :no_content, "")

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp add_sort_order_if_missing(params, scenario_id) do
    if Map.has_key? params, "sort_order" do
      params
    else
      type = Map.get(params, "resource_type")

      sort_order =
        if (is_nil type) or (is_nil scenario_id) do
          1
        else
          prev_max = Repo.one(
                  from sr in ScenarioResource,
                  where: sr.scenario_id == ^scenario_id,
                  select: max(sr.sort_order))
          if is_nil prev_max do
            1
          else
            prev_max + 1
          end
        end

      Map.put params, "sort_order", sort_order
    end
  end
end
