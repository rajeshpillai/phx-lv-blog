defmodule LvDemoWeb.PostView do
  use Phoenix.HTML
  def tag_input(form, field, opts \\ []) do
    # get the input tags collection
    tags = Phoenix.HTML.Form.input_value(form, field)
    # render text using the text_input after converting tags to text
    Phoenix.HTML.Form.text_input(form, field, value: tags_to_text(tags))
  end

  defp tags_to_text(tags) do
    tags
    |> Enum.map(fn t -> t.title end)
    |> Enum.join(", ")
  end
end