# https://minhajuddin.com/2020/05/03/many-to-many-relationships-in-ecto-and-phoenix-for-products-and-tags/

defmodule LvDemoWeb.BlogLive.Read do
  use LvDemoWeb, :live_view

  alias LvDemo.Blogs
  alias LvDemo.Blogs.Post

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # Post Edit
  def handle_params(%{"post_id" => post_id, "id" => id} = params, _, socket) do
    IO.puts "+++READ POST-----"
    IO.inspect params
    post = Blogs.get_post!(post_id)
    IO.inspect post
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, post)
     |> assign(:blog, Blogs.get_blog!(id))}
  end


  defp page_title(:read_post), do: "Read Post"

end
