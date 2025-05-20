defmodule WeatherForecast.Forecast do
  @moduledoc """
  Module responsible for calculating average maximum temperatures for a list of cities.

  It uses a client module that implements the `WeatherForecast.WeatherClient` behaviour
  to fetch temperature data and calculates the average temperature for the next 6 days.
  """
  alias WeatherForecast.{City, OpenMeteoClient}

  @doc """
  Calculates the average maximum temperatures for all predefined cities using the given client.
  """
  def calculate_averages(client \\ OpenMeteoClient) do
    calculate_averages(City.all(), client)
  end

@doc """
  Calculates the average maximum temperature for each city in the given list.
  """
  def calculate_averages(cities, client) do
    cities
    |> Task.async_stream(&process_city(&1, client), timeout: 5_000)
    |> Enum.map(fn {:ok, result} -> result end)
  end

  defp process_city(city, client) do
    case client.fetch_max_temperatures(city) do
      {:ok, temps} when is_list(temps) ->
        average = Enum.sum(temps) / length(temps)
        {city.name, Float.round(average, 1)}

      {:error, _} ->
        {city.name, "Error fetching data"}
    end
  end
end
