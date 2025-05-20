defmodule WeatherForecast do
  alias WeatherForecast.Forecast

  def run do
    IO.puts("Average maximum temperature forecast for the next 6 days:\n")

    Forecast.calculate_averages()
    |> Enum.each(fn {city, temp} ->
      IO.puts("#{city}: #{temp}°C")
    end)
  end
end
