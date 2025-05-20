defmodule WeatherForecast.OpenMeteoClient do
  @moduledoc """
  API client for Open-Meteo.

  Fetches maximum temperature forecasts for a given city over the next 6 days.
  """
  @base_url "https://api.open-meteo.com/v1/forecast"
  @timezone "America/Sao_Paulo"
  @behaviour WeatherForecast.WeatherClient

  @doc """
  Fetches the next 6 days of maximum temperatures for the given city.
  """
  def fetch_max_temperatures(%WeatherForecast.City{latitude: lat, longitude: lon}) do
    url = "#{@base_url}?latitude=#{lat}&longitude=#{lon}&daily=temperature_2m_max&timezone=#{@timezone}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
        |> Jason.decode!()
        |> get_temperatures()

      {:error, %HTTPoison.Error{} = err} ->
        {:error, err}
    end
  end

  defp get_temperatures(%{"daily" => %{"temperature_2m_max" => temps}}) do
    temps = temps |> Enum.take(6)
    {:ok, temps}
  end

  defp get_temperatures(_), do: {:error, :invalid_response}
end
