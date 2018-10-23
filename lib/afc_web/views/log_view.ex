defmodule AfcWeb.LogView do
  use AfcWeb, :view
  def format_emotion(emotion) do
    emotion
    |> Atom.to_string()
    |> String.capitalize()
  end
end
