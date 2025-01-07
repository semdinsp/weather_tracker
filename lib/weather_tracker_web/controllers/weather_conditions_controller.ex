defmodule WeatherTrackerWeb.WeatherConditionsController do
  use WeatherTrackerWeb, :controller

  require Logger

  alias WeatherTracker.{
    WeatherConditions,
    WeatherConditions.WeatherCondition
  }

  def create(conn, params) do
    params=if params["temperature_c"] == nil do
      Logger.warning("Nulls to temperature. check")
      Map.merge(params, %{altitude_m: 0.0, pressure_pa: 0.0, temperature_c: 0.0, humidity_rh: 0.5})
    end
    Logger.warning("params before create entry #{inspect(params)}")
    case WeatherConditions.create_entry(params) do
      {:ok, weather_condition = %WeatherCondition{}} ->
        #Logger.debug("Successfully created a weather condition entry")
        Logger.debug("success: inbound api call -  #{inspect(weather_condition )}")
        conn
        |> put_status(:created)
        |> json(weather_condition)

      error ->
        Logger.warning("Failed to create a weather entry: #{inspect(error)} params: #{inspect(params)}")
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Poorly formatted payload params #{inspect(params)}"})
    end
  end
end
