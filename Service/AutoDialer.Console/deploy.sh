dotnet publish AutoDialer.Console.csproj -c Release --runtime linux-x64 --self-contained
tar -czvf bin/AutoDialer.Console.tar.gz -C bin/Release/netcoreapp3.1/linux-x64/publish/ .
scp bin/AutoDialer.Console.tar.gz dotnet@dev02:/home/dotnet/apps/Autodial
ssh dotnet@dev02 'cd /home/dotnet/apps/Autodial && tar -xzvf /home/dotnet/apps/Autodial/AutoDialer.Console.tar.gz'
