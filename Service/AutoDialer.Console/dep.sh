dotnet restore AutoDialer.Console.csproj
dotnet publish AutoDialer.Console.csproj -c Release --runtime linux-x64
ssh root@ast11 'systemctl stop Autodial.service'

scp bin/Release/netcoreapp2.2/linux-x64/publish/Auto* root@ast11:/home/asterisk/services/Autodial/ 
ssh root@ast11 ' chown asterisk:asterisk /home/asterisk/services/Autodial/*'

ssh root@ast11 'cp /home/asterisk/services/Autodial/Autodial.service /etc/systemd/system/'
ssh root@ast11 'service systemd-resolved restart'

ssh root@ast11 'systemctl enable Autodial.service'
ssh root@ast11 'systemctl start Autodial.service'

ssh root@ast11 'systemctl status Autodial.service'