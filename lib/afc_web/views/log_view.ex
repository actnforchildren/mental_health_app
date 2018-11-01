defmodule AfcWeb.LogView do
  use AfcWeb, :view
  def format_emotion(emotion) do
    if emotion == :unsure do
      "I don't know"
    else
      emotion
      |> Atom.to_string()
      |> String.capitalize()
    end
  end
end
