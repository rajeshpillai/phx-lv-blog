# https://minhajuddin.com/2020/05/03/many-to-many-relationships-in-ecto-and-phoenix-for-products-and-tags/

defmodule LvDemoWeb.BlogLive.Read do
  use LvDemoWeb, :live_view

  alias LvDemo.Blogs
  alias LvDemo.Blogs.Post
  alias LvDemo.Blogs.Comment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # Post Edit
  @impl true
  def handle_params(%{"post_id" => post_id, "id" => id} = params, _, socket) do
    IO.puts "+++READ POST-----"
    IO.inspect params
    post = Blogs.get_post_with_comments!(post_id)
    IO.inspect post
    changeset = Blogs.change_comment(%Comment{})

    {:noreply,
     socket
     |> assign(:changeset, changeset)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, post)
     |> assign(:blog, Blogs.get_blog!(id))}
  end

  @impl true
  def handle_event("save_comment", %{"comment" => comment_params}, socket) do
    IO.puts "++++SAVE COMMENT-----"
    IO.inspect comment_params
    IO.inspect socket.assigns

    # post = Blogs.get_post!(socket.assigns.post.id)

    case Blogs.create_comment(comment_params) do
      {:ok, _comment} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comment created successfully")
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


  defp page_title(:read_post), do: "Read Post"

end
