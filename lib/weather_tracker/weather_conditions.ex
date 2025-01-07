defmodule WeatherTracker.WeatherConditions do
  alias WeatherTracker.{
    Repo,
    WeatherConditions.WeatherCondition
  }

  def create_entry(attrs) do
    Logger.warning("params before create entry #{inspect(attrs)}")
    %WeatherCondition{}
      |> WeatherCondition.create_changeset(attrs)
      |> Repo.insert()
  end
end
