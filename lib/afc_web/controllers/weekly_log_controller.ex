defmodule AfcWeb.WeeklyLogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}

  def index(conn, params) do
    from = params["from"]
    to = params["to"]
    case parseDates(from, to) do
      %{from: from, to: to} ->
        IO.inspect Emotion.get_emotion_report(conn.assigns.current_user, from, to)
        render conn, "weekly.html"

      _ ->
        IO.inspect "error"
        render conn, "error.html"
    end
  end

  def parseDates(from, to) do
    case Timex.parse(from, "%d-%m-%Y", :strftime) do
      {:ok, from_date} ->
        case Timex.parse(to, "%d-%m-%Y", :strftime) do
          {:ok, to_date} ->
            %{from: from_date, to: to_date}

          _ -> nil
        end

      _ ->
        nil
    end
  end
end
