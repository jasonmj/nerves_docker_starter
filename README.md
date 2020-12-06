* Getting Started
Clone the repo
Add .env containing:
```
MIX_TARGET=rpi0
MIX_ENV=prod
WPA_SSID=yourwifissid
WPA_PSK=yourwifipassword
```
Make to update these example values to values relevant to your use case.
Run `docker-compose up -d`
Enter the container with `docker-compose exec nerves bash`
Create your project with `mix nerves.new project_name_here`
Move the contents of the newly created project up one directory level with `mv project_name_here/* ./` and `mv project_name_here/.* ./`
Exit the docker container and burn the project contents with `sh ./burn.sh`
