defmodule LvDemoWeb.PostLive.Index do
  use LvDemoWeb, :live_view

  alias LvDemo.Blogs
  alias LvDemo.Blogs.Post
  alias LvDemo.Blogs.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :posts, list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Blogs.get_post!(id))
  end


  defp apply_action(socket, :new, %{"params" => id}) do
    socket
    |> assign(:page_title, "New Post for blog " <> id)
    |> assign(:post, %Post{})
  end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Post")
  #   |> assign(:post, %Post{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Blogs.get_post!(id)
    {:ok, _} = Blogs.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts())}
  end

  defp list_posts do
    Blogs.list_posts()
  end
end
