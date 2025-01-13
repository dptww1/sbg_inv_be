defmodule SbgInv.Web.AboutControllerTest do
  use Pathex
  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{About, FAQ}

  @valid_attrs %{
    body_text: "new text",
    faqs: [
      %{question: "new Q3", answer: "new A3", sort_order: 3},
      %{question: "new Q2", answer: "new A2", sort_order: 2},
      %{question: "new Q1", answer: "new A1", sort_order: 1}
    ]
  }

  setup _context do
    about = Repo.insert!(%About{body_text: "<p>first</p><p>second</p>"})
    faq2 = Repo.insert!(%FAQ{about_id: about.id, question: "Q2", answer: "A2", sort_order: 2})
    faq1 = Repo.insert!(%FAQ{about_id: about.id, question: "Q1", answer: "A1", sort_order: 1})

    {:ok,
      %{
        ids: %{
          about_id: about.id,
          faq1_id: faq1.id,
          faq2_id: faq2.id
        }
      }
    }
  end

  test "anonymous user can get About text + FAQs", %{conn: conn} = context do
    conn = get conn, Routes.about_path(conn, :index)
    assert json_response(conn, 200)["data"] == %{
             "about" => "<p>first</p><p>second</p>",
             "faqs" => [
               %{"id" => context.ids.faq1_id, "question" => "Q1", "answer" => "A1", "sort_order" => 1},
               %{"id" => context.ids.faq2_id, "question" => "Q2", "answer" => "A2", "sort_order" => 2}
             ]
           }
  end

  test "admin user can update About text + FAQs", %{conn: conn} = context do
    conn = TestHelper.create_logged_in_user(conn, "jon", "a@b.com", true)

    update_params = @valid_attrs
                    |> Pathex.force_set!(path(:faqs / 2 / :id), context.ids.faq1_id)
                    |> Pathex.force_set!(path(:faqs / 1 / :id), context.ids.faq2_id)

    conn = put conn, Routes.about_path(conn, :update, -1), about: update_params

    # Is there a better way to verify IDs for new content?
    about_model = About.query_singleton()
                  |> About.with_faqs()
                  |> Repo.one!

    assert json_response(conn, 200)["data"] == %{
             "about" => @valid_attrs.body_text,
             "faqs" => [
               %{
                 "id" => context.ids.faq1_id,
                 "question" => Enum.at(@valid_attrs.faqs, 2).question,
                 "answer" => Enum.at(@valid_attrs.faqs, 2).answer,
                 "sort_order" => Enum.at(@valid_attrs.faqs, 2).sort_order
               },
               %{
                 "id" => context.ids.faq2_id,
                 "question" => Enum.at(@valid_attrs.faqs, 1).question,
                 "answer" => Enum.at(@valid_attrs.faqs, 1).answer,
                 "sort_order" => Enum.at(@valid_attrs.faqs, 1).sort_order
               },
               %{
                 "id" => Pathex.get(about_model, path(:faqs / 2 / :id)),
                 "question" => Enum.at(@valid_attrs.faqs, 0).question,
                 "answer" => Enum.at(@valid_attrs.faqs, 0).answer,
                 "sort_order" => Enum.at(@valid_attrs.faqs, 0).sort_order
               }
             ]
           }
  end

  test "logged-in user cannot update About text", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "jon", "a@b.com")
    conn = put conn, Routes.about_path(conn, :update, -1), about: @valid_attrs
    assert conn.status == 401
  end

  test "anonymous user cannot update About text", %{conn: conn} do
    conn = put conn, Routes.about_path(conn, :update, -1), about: @valid_attrs
    assert conn.status == 401
  end
end
