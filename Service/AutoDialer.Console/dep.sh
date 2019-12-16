dotnet restore AutoDialer.Console.csproj
dotnet publish AutoDialer.Console.csproj -c Release --runtime linux-x64
ssh $1 'sudo systemctl stop Autodial.service'

ssh $1 'sudo mkdir -p /home/asterisk/services/Autodial'
ssh $1 'sudo mkdir -p /home/asterisk/services'

scp bin/Release/netcoreapp2.2/linux-x64/publish/* $1:/home/asterisk/services/Autodial
ssh $1 'sudo chown asterisk:asterisk /home/asterisk/services/Autodial/*'
ssh $1 'sudo chown asterisk:asterisk /home/asterisk/services/Autodial'
ssh $1 'sudo chown asterisk:asterisk /home/asterisk/services'

ssh $1 'sudo cp /home/asterisk/services/Autodial/Autodial.service /etc/systemd/system/'
ssh $1 'sudo service systemd-resolved restart'

ssh $1 'sudo systemctl enable Autodial.service'
ssh $1 'sudo systemctl start Autodial.service'

ssh $1 'sudo systemctl status Autodial.service'