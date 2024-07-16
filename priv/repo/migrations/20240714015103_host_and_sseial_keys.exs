defmodule WeatherTracker.Repo.Migrations.HostAndSseialKeys do
  use Ecto.Migration

  def change do
    alter table(:weather_conditions) do
      add :hostname, :string, default: ""
      add :serial_number, :string, default: ""
      add :humidity_rh, :decimal, null: false

    end
  end
end
