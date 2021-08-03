defmodule LvDemoWeb.BlogLiveTest do
  use LvDemoWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LvDemo.Blogs

  @create_attrs %{desc: "some desc", is_published: true, name: "some name", slug: "some slug", url: "some url"}
  @update_attrs %{desc: "some updated desc", is_published: false, name: "some updated name", slug: "some updated slug", url: "some updated url"}
  @invalid_attrs %{desc: nil, is_published: nil, name: nil, slug: nil, url: nil}

  defp fixture(:blog) do
    {:ok, blog} = Blogs.create_blog(@create_attrs)
    blog
  end

  defp create_blog(_) do
    blog = fixture(:blog)
    %{blog: blog}
  end

  describe "Index" do
    setup [:create_blog]

    test "lists all blogs", %{conn: conn, blog: blog} do
      {:ok, _index_live, html} = live(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Listing Blogs"
      assert html =~ blog.desc
    end

    test "saves new blog", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("a", "New Blog") |> render_click() =~
               "New Blog"

      assert_patch(index_live, Routes.blog_index_path(conn, :new))

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#blog-form", blog: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Blog created successfully"
      assert html =~ "some desc"
    end

    test "updates blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("#blog-#{blog.id} a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(index_live, Routes.blog_index_path(conn, :edit, blog))

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#blog-form", blog: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Blog updated successfully"
      assert html =~ "some updated desc"
    end

    test "deletes blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("#blog-#{blog.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#blog-#{blog.id}")
    end
  end

  describe "Show" do
    setup [:create_blog]

    test "displays blog", %{conn: conn, blog: blog} do
      {:ok, _show_live, html} = live(conn, Routes.blog_show_path(conn, :show, blog))

      assert html =~ "Show Blog"
      assert html =~ blog.desc
    end

    test "updates blog within modal", %{conn: conn, blog: blog} do
      {:ok, show_live, _html} = live(conn, Routes.blog_show_path(conn, :show, blog))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(show_live, Routes.blog_show_path(conn, :edit, blog))

      assert show_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#blog-form", blog: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_show_path(conn, :show, blog))

      assert html =~ "Blog updated successfully"
      assert html =~ "some updated desc"
    end
  end
end
