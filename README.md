## Getting Started

* Clone the repo
* Add a `.env` file containing:
```
MIX_TARGET=rpi0
MIX_ENV=prod
WPA_SSID=yourwifissid
WPA_PSK=yourwifipassword
```
Make sure to update these example values to values relevant to your use case. If you don't intend to use wifi, you can exclude the last two lines.
* Run `docker-compose up -d`
* Enter the container with `docker-compose exec nerves bash`
* Create your project with `mix nerves.new project_name_here`
* Move the contents of the newly created project up one directory level with `mv project_name_here/* ./` and `mv project_name_here/.* ./`
* If you want to use the `vintage_net_wifi` with the project add this to `/firmware/config/target.exs`:
```
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"wlan0",
     %{
       ipv4: %{method: :dhcp},
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [
           %{
             key_mgmt: :wpa_psk,
             psk: System.get_env("WPA_PSK"),
             ssid: System.get_env("WPA_SSID")
           }
         ]
       }
     }}
  ]
```
* Exit the docker container and burn the project contents with `sh ./burn.sh`
* If you want to perform over the air updates, make sure to include the IP address of the device on the last line of `update.sh`
* Once the device is running on your wifi network, you can update it over the air with `sh ./update.sh`
