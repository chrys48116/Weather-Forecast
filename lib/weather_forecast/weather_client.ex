defmodule WeatherForecast.WeatherClient do
  @callback fetch_max_temperatures(WeatherForecast.City.t()) :: {:ok, list(float)} | {:error, term()}
end
