defmodule SbgInv.CharacterResourceControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.Web.{Book, Character, CharacterResource}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_test_resources do
    c1 = Repo.insert!(%Character{name: "C1"})
    c2 = Repo.insert!(%Character{name: "C2"})

    b = Book.query_by_key("fotr") |> Repo.one!

    c1r1 = Repo.insert!(%CharacterResource{character_id: c1.id, title: "C1R1", type: :painting_guide, url: "URL1", inserted_at: ~N[2026-02-28 00:00:00]})
    c2r2 = Repo.insert!(%CharacterResource{character_id: c2.id, title: "C2R2", type: :painting_guide, url: "URL2", inserted_at: ~N[2026-02-27 00:00:00]})
    c1r3 = Repo.insert!(%CharacterResource{character_id: c1.id, title: "C1R3", type: :painting_guide, url: "URL3", inserted_at: ~N[2026-03-01 00:00:00]})
    c1r4 = Repo.insert!(%CharacterResource{character_id: c1.id, title: "C1R4", type: :analysis,       url: "URL4", inserted_at: ~N[2026-02-24 00:00:00]})
    c2r5 = Repo.insert!(%CharacterResource{character_id: c2.id, title: "C2R5", type: :analysis,       url: nil,    inserted_at: ~N[2026-02-25 00:00:00], page: 32, book: b})
    _1r6 = Repo.insert!(%CharacterResource{character_id: c1.id, title: "C1R6", type: :analysis,       url: "URL6", inserted_at: ~N[2026-02-20 00:00:00]})

    %{
      c1r1_id: c1r1.id,
      c2r2_id: c2r2.id,
      c1r3_id: c1r3.id,
      c1r4_id: c1r4.id,
      c2r5_id: c2r5.id
    }
  end

  test "can get default list of recent character resources", %{conn: conn} do
    %{c1r1_id: c1r1_id, c2r2_id: c2r2_id, c1r3_id: c1r3_id, c1r4_id: c1r4_id, c2r5_id: c2r5_id} = create_test_resources()
    conn = get conn, Routes.character_character_resource_path(conn, :index, -1) # character_id is required by path but is unused
    assert json_response(conn, 200)["data"] == [
           %{"id" => c1r3_id, "book" => nil,    "issue" => nil, "page" => nil, "title" => "C1R3", "type" => "painting_guide", "url" => "URL3", "character_name" => "C1", "date" => "2026-03-01"},
           %{"id" => c1r1_id, "book" => nil,    "issue" => nil, "page" => nil, "title" => "C1R1", "type" => "painting_guide", "url" => "URL1", "character_name" => "C1", "date" => "2026-02-28"},
           %{"id" => c2r2_id, "book" => nil,    "issue" => nil, "page" => nil, "title" => "C2R2", "type" => "painting_guide", "url" => "URL2", "character_name" => "C2", "date" => "2026-02-27"},
           %{"id" => c2r5_id, "book" => "fotr", "issue" => nil, "page" => 32,  "title" => "C2R5", "type" => "analysis",       "url" => nil,    "character_name" => "C2", "date" => "2026-02-25"},
           %{"id" => c1r4_id, "book" => nil,    "issue" => nil, "page" => nil, "title" => "C1R4", "type" => "analysis",       "url" => "URL4", "character_name" => "C1", "date" => "2026-02-24"}
      ]
  end
end
