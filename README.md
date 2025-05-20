# Weather Forecast 🌤️

> Weather forecast for 3 Brazilian cities using Elixir and concurrency.

## 📌 Objective

Fetch the **maximum temperature forecast** for the next **6 days** for 3 Brazilian cities and calculate the **average maximum temperature** for each one.

## 📍 Cities

- São Paulo
- Belo Horizonte
- Curitiba

## 🧰 Technologies

- Elixir
- HTTPoison
- Jason
- Mox (for test mocking)
- Task.async_stream (concurrency)

## 🚀 How to run

```bash
mix deps.get
iex -S mix
WeatherForecast.run()
