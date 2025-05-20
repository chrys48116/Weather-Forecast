defmodule WeatherForecastTest do
  use ExUnit.Case
  import Mox

  alias WeatherForecast.{City, Forecast}

  setup :verify_on_exit!

  test "calculates the average temperature correctly" do
    mock_city = %City{name: "Test City", latitude: 0.0, longitude: 0.0}

    WeatherForecast.MockClient
    |> expect(:fetch_max_temperatures, fn ^mock_city ->
      {:ok, [25.0, 26.0, 27.0, 24.0, 28.0, 26.0]}
    end)

    result = Forecast.calculate_averages([mock_city], WeatherForecast.MockClient)
    assert result == [{"Test City", 26.0}]
  end

  test "returns error if the client fails to fetch data" do
    city = %City{name: "Error City", latitude: 0.0, longitude: 0.0}

    WeatherForecast.MockClient
    |> expect(:fetch_max_temperatures, fn ^city -> {:error, :network_issue} end)

    result = Forecast.calculate_averages([city], WeatherForecast.MockClient)
    assert result == [{"Error City", "Error fetching data"}]
  end

  test "returns error for malformed API response" do
    city = %City{name: "Malformed City", latitude: 1.0, longitude: 1.0}

    WeatherForecast.MockClient
    |> expect(:fetch_max_temperatures, fn ^city -> {:error, :invalid_response} end)

    result = Forecast.calculate_averages([city], WeatherForecast.MockClient)
    assert result == [{"Malformed City", "Error fetching data"}]
  end

end
