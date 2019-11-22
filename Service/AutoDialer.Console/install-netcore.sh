
ssh root@$1 'sudo rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm'
ssh root@$1 'sudo yum -y install dotnet-sdk-2.2'