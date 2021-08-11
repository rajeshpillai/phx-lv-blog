defmodule LvDemoWeb.PostLive.FormComponent do
  use LvDemoWeb, :live_component

  alias LvDemo.Blogs

  @impl true
  def update(%{post: post} = assigns, socket) do
    changeset = Blogs.change_comment()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  # If tags change, do nothing (form input)
  # https://elixirforum.com/t/phx-change-on-input-themselves/34230/2
  def handle_event("validate", %{"_target" => ["post", "tags"], "post" => %{"tags" => tags}}, socket) do
    IO.puts "Form Validate: Tags change"

    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    IO.puts "Form Validate: "
    IO.inspect post_params
    changeset =
      socket.assigns.post
      |> Blogs.change_post(post_params)
      |> Map.put(:action, :validate)

    # {:noreply, assign(socket, :changeset, changeset)}
    {:noreply, socket}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    IO.puts "++++++"
    IO.inspect post_params
    IO.inspect socket.assigns.action
    save_post(socket, socket.assigns.action, post_params)
  end

  defp save_post(socket, :edit_post, post_params) do

    IO.puts "+++++Updating post: "
    IO.inspect socket.assigns.post

    case Blogs.update_post(socket.assigns.post, post_params) do
      {:ok, _post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_post(socket, :new_post, post_params) do
    case Blogs.create_post(post_params) do
      {:ok, _post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
