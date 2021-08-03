defmodule LvDemoWeb.BlogLive.Show do
  use LvDemoWeb, :live_view

  alias LvDemo.Blogs
  alias LvDemo.Blogs.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end



  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    IO.inspect params
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, %Post{blog_id: id})
     |> assign(:blog, Blogs.get_blog!(id))}
  end

  defp page_title(:new_post), do: "New Post"
  defp page_title(:show), do: "Show Blog"
  defp page_title(:edit), do: "Edit Blog"
end
