defmodule AfcWeb.WeeklyLogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo}

  def index(conn, params) do
    {from, to} = get_week_dates(params["from"], params["to"])
    case parseDates(from, to) do
      %{from: from_date, to: to_date} ->
        logs = Emotion.get_emotion_report(conn.assigns.current_user, from_date, to_date)
        date_title_from = Timex.format!(from_date, "{D} {Mshort}")
        date_title_to = Timex.format!(to_date, "{D} {Mshort}")

        next_week_from = Timex.shift(from_date, weeks: 1)
        next_week_to = Timex.shift(to_date, weeks: 1)
        next_week = get_weekly_url(next_week_from, next_week_to)

        previous_week_from = Timex.shift(from_date, weeks: -1)
        previous_week_to = Timex.shift(to_date, weeks: -1)
        previous_week = get_weekly_url(previous_week_from, previous_week_to)

        render conn, "weekly.html",
          logs: logs,
          date_title: "#{date_title_from} - #{date_title_to}",
          next_week: next_week,
          previous_week: previous_week
      _ ->
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

  def get_week_dates(from, to) do
    if from == nil && to == nil do
      now = Timex.now
      start_week = Timex.beginning_of_week(now, :mon)
      end_week = Timex.end_of_week(now, :mon)
      from = Timex.format!(start_week, "{0D}-{0M}-{YYYY}")
      to = Timex.format!(end_week, "{0D}-{0M}-{YYYY}")
      {from, to}
    else
      {from, to}
    end
  end

  def get_weekly_url(from, to) do
    from_url = Timex.format!(from, "{0D}-{0M}-{YYYY}")
    to_url = Timex.format!(to, "{0D}-{0M}-{YYYY}")
    "/weekly-log?from=#{from_url}&to=#{to_url}"
  end
end
