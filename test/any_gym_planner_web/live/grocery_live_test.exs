defmodule AnyGymPlannerWeb.GroceryLiveTest do
  use AnyGymPlannerWeb.ConnCase

  import AnyGymPlannerWeb.ConnCase

  @path "/grocery/2020-07-05"

  describe "user behavior" do
    test "handles date click", %{conn: conn} do
      {:ok, view, _html} = live(conn, @path)

      # :ok = File.write("output.html", html)

      view
      |> element("div", "7/12")
      |> render_click()

      assert_redirected(view, "/grocery/2020-07-12")
    end
  end
end
