defmodule WeatherTrackerWeb.WeatherConditionsController do
  use WeatherTrackerWeb, :controller

  require Logger

  alias WeatherTracker.{
    WeatherConditions,
    WeatherConditions.WeatherCondition
  }

  def create(conn, params) do
    Logger.warning("controller.create: --> entry inbound api call -  #{inspect(params)}")
     # old     nparams=if params["temperature_c"] == nil do

    nparams=if params["humidity_rh"] == "unknown" do
      Logger.warning("humidity unknown check")
     # Map.merge(params, %{"altitude_m" => 0.0, "pressure_pa" => 0.0, "temperature_c" => 0.0, "humidity_rh" => 0.5})
      Map.merge(params, %{ "humidity_rh" => 0.5})
    else params
    end
    Logger.warning("controller.create: params before create entry #{inspect(nparams)}")
    case WeatherConditions.create_entry(nparams) do
      {:ok, weather_condition = %WeatherCondition{}} ->
        #Logger.debug("Successfully created a weather condition entry")
        Logger.warning("success: inbound api call -  #{inspect(weather_condition )}")
        conn
        |> put_status(:created)
        |> json(weather_condition)

      error ->
        Logger.error("Failed to create a weather entry: #{inspect(error)} params: #{inspect(nparams)}")
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{message: "Poorly formatted payload params #{inspect(nparams)}"})
    end
  end
end
