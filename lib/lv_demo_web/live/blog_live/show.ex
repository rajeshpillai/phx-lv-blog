# https://minhajuddin.com/2020/05/03/many-to-many-relationships-in-ecto-and-phoenix-for-products-and-tags/

defmodule LvDemoWeb.BlogLive.Show do
  use LvDemoWeb, :live_view

  alias LvDemo.Blogs
  alias LvDemo.Blogs.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # Post Edit
  def handle_params(%{"post_id" => post_id, "id" => id} = params, _, socket) do
    IO.puts "+++EDIT POST-----"
    IO.inspect params
    post = Blogs.get_post!(post_id)
    IO.inspect post
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, post)
     |> assign(:blog, Blogs.get_blog!(id))}
  end


  @impl true
  def handle_params(%{"id" => id} = params, _, socket) do
    IO.puts "+++DEFAULT NEW POST-----"
    IO.inspect params
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, %Post{blog_id: id, tags: []})
     |> assign(:blog, Blogs.get_blog!(id))}
  end

  

  defp page_title(:new_post), do: "New Post"
  defp page_title(:edit_post), do: "Edit Post"
  defp page_title(:show), do: "Show Blog"
  defp page_title(:edit), do: "Edit Blog"
end
