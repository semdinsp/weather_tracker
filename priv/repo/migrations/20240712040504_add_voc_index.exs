defmodule WeatherTracker.Repo.Migrations.AddVocIndex do
  use Ecto.Migration

  def change do
    alter table(:weather_conditions) do
      add :voc_index, :decimal, null: false
      remove :co2_eq_ppm
      remove :tvoc_ppb
    end
  end
end
