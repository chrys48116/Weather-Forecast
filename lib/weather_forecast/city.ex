defmodule WeatherForecast.City do
  @moduledoc """
  Represents a city with a name and geographical coordinates.
  """
  defstruct name: "", latitude: 0.0, longitude: 0.0

  @doc """
  Returns the list of cities to be used in the forecast.
  """
  def all do
    [
      %__MODULE__{name: "São Paulo", latitude: -23.55, longitude: -46.63},
      %__MODULE__{name: "Belo Horizonte", latitude: -19.92, longitude: -43.94},
      %__MODULE__{name: "Curitiba", latitude: -25.43, longitude: -49.27}
    ]
  end
end
