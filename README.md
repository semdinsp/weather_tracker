## Elixir post command to database:
:post
      |> Finch.build(
        state.weather_tracker_url,
        [{"Content-Type", "application/json"}],
        Jason.encode!(state.measurements)
      )
      |> Finch.request(WeatherTrackerClient)

## Proxy to FLY database for grafana
fly proxy 15432:5432 -a timedb-nerves-scottv2

## Ssetting up timescale db on FLY

## Create image
see https://fly.io/docs/postgres/getting-started/enabling-timescale/
fly pg create --image-ref flyio/postgres-flex-timescaledb:15



## Link app to new database

flyctl postgres attach timedb-nerves-scottv2  --verbose 

timedb-nerves-scott is the new db created above
Checking for existing attachments
Registering attachment
Creating database
Creating user

Postgres cluster timedb-nerves-scottv2 is now attached to weather-scott-nerves
The following secret was added to weather-scott-nerves:

## Lgoin admin Passowrd: admin123

 /opt/homebrew/opt/grafana/bin/grafana server --config /opt/homebrew/etc/grafana/grafana.ini --homepath /opt/homebrew/opt/grafana/share/grafana --packaging\=brew cfg:default.paths.logs\=/opt/homebrew/var/log/grafana cfg:default.paths.data\=/opt/homebrew/var/lib/grafana cfg:default.paths.plugins\=/opt/homebrew/var/lib/grafana/plugins


## Reset Grafana Password
/opt/homebrew/opt/grafana/bin/grafana cli --config /opt/homebrew/etc/grafana/grafana.ini --homepath /opt/homebrew/opt/grafana/share/grafana --configOverrides cfg:default.paths.data=/opt/homebrew/var/lib/grafana admin reset-admin-password admin
