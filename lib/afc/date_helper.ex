defmodule Afc.DateHelper do
  def parseDates(from, to) do
    case Timex.parse(from, "%d-%m-%Y", :strftime) do
      {:ok, from_date} ->
        case Timex.parse(to, "%d-%m-%Y", :strftime) do
          {:ok, to_date} ->
            to_date = Timex.end_of_day(to_date)
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

  def get_month_dates(from, to) do
    if from == nil && to == nil do
      now = Timex.now
      start_month = Timex.beginning_of_month(now)
      end_month = Timex.end_of_month(now)
      from = Timex.format!(start_month, "{0D}-{0M}-{YYYY}")
      to = Timex.format!(end_month, "{0D}-{0M}-{YYYY}")
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

  def get_monthly_url(from, to) do
    from_url = Timex.format!(from, "{0D}-{0M}-{YYYY}")
    to_url = Timex.format!(to, "{0D}-{0M}-{YYYY}")
    "/monthly-log?from=#{from_url}&to=#{to_url}"
  end
end
