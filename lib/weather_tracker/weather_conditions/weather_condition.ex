defmodule WeatherTracker.WeatherConditions.WeatherCondition do
  use Ecto.Schema
  import Ecto.Changeset
  require Logger


  @allowed_fields [
    :altitude_m,
    :pressure_pa,
    :temperature_c,
    :voc_index,
   # :tvoc_ppb,
   # :co2_eq_ppm,
    :light_lumens,
    :humidity_rh,
    :hostname,
    :serial_number
  ]

  #@required_fields [
   # :temperature_c,
   # :tvoc_ppb,
   # :co2_eq_ppm,
   #  :hostname,
   #  :serial_number
  #]

  @derive {Jason.Encoder, only: @allowed_fields}
  @primary_key false
  schema "weather_conditions" do
    field :timestamp, :naive_datetime
    field :altitude_m, :decimal
    field :pressure_pa, :decimal
    field :temperature_c, :decimal
   # field :co2_eq_ppm, :decimal
    #field :tvoc_ppb, :decimal
    field :voc_index, :decimal
    field :light_lumens, :decimal
    field :humidity_rh, :decimal
    # scott
    field :hostname, :string
    field :serial_number, :string

  end

  #request_id=GBhREGAmxoCtOnwAAAIh [warning] params before create entry %{:temperature_c => 0, :pressure_pa => 0, :humidity_rh => 0.5, :altitude_m => 0, "hostname" => "nerves-8c5a", "light_lumens" => 6.2208, "serial_number" => "8c5a", "voc_index" => 133}

  def create_changeset(weather_condition = %__MODULE__{}, attrs) do
    Logger.warning("changeset: params before create changeset #{inspect(attrs)}")
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    weather_condition
    |> cast(attrs, @allowed_fields)
    |> put_change(:timestamp, timestamp)

    # was
    #|> cast(attrs, @allowed_fields)
   # |> validate_required(@allowed_fields)
   # |> put_change(:timestamp, timestamp)
  end
end
