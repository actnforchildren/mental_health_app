defmodule AfcWeb.MonthlyLogController do
  use AfcWeb, :controller
  alias Afc.{Emotion, Repo, DateHelper}

  def index(conn, params) do
    shared = params["shared"]
    {from, to} = DateHelper.get_month_dates(params["from"], params["to"])
    case DateHelper.parseDates(from, to) do
      %{from: from_date, to: to_date} ->
        logs = Emotion.get_emotion_report(conn.assigns.current_user, from_date, to_date)
        date_title = Timex.format!(from_date, "{Mshort} {YYYY}")

        next_month_from = Timex.shift(from_date, months: 1)
        next_month_to = Timex.end_of_month(next_month_from)
        next_month = DateHelper.get_monthly_url(next_month_from, next_month_to)

        previous_month_from = Timex.shift(from_date, months: -1)
        previous_month_to = Timex.end_of_month(previous_month_from)
        previous_month = DateHelper.get_monthly_url(previous_month_from, previous_month_to)

        number_of_days = Timex.days_in_month(from_date)

        render conn, "monthly.html",
          logs: logs,
          date_title: date_title,
          next_month: next_month,
          previous_month: previous_month,
          total_days: number_of_days,
          from: from,
          to: to,
          shared: shared
      _ ->
        render conn, "error.html"
      end
    end
end
