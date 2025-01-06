defmodule WeatherTracker.WeatherConditions.WeatherCondition do
  use Ecto.Schema
  import Ecto.Changeset

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

  def create_changeset(weather_condition = %__MODULE__{}, attrs) do
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
