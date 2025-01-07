defmodule WeatherTracker.WeatherConditions do
  alias WeatherTracker.{
    Repo,
    WeatherConditions.WeatherCondition
  }
  require Logger


  def create_entry(attrs) do
    Logger.warning("weather_condition.ex params before create entry #{inspect(attrs)}")
    %WeatherCondition{}
      |> WeatherCondition.create_changeset(attrs)
      |> Repo.insert()
  end
end
