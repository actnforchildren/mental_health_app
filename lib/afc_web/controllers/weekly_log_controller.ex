defmodule AfcWeb.WeeklyLogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo, DateHelper}

  def index(conn, params) do
    {from, to} = DateHelper.get_week_dates(params["from"], params["to"])
    case DateHelper.parseDates(from, to) do
      %{from: from_date, to: to_date} ->
        logs = Emotion.get_emotion_report(conn.assigns.current_user, from_date, to_date)
        date_title_from = Timex.format!(from_date, "{D} {Mshort}")
        date_title_to = Timex.format!(to_date, "{D} {Mshort}")

        next_week_from = Timex.shift(from_date, weeks: 1)
        next_week_to = Timex.shift(to_date, weeks: 1)
        next_week = DateHelper.get_weekly_url(next_week_from, next_week_to)

        previous_week_from = Timex.shift(from_date, weeks: -1)
        previous_week_to = Timex.shift(to_date, weeks: -1)
        previous_week = DateHelper.get_weekly_url(previous_week_from, previous_week_to)

        render conn, "weekly.html",
          logs: logs,
          date_title: "#{date_title_from} - #{date_title_to}",
          next_week: next_week,
          previous_week: previous_week
      _ ->
        render conn, "error.html"
    end
  end
end
