set -ex

cd $(dirname $0)/../src/

artifactsFolder="../artifacts"

if [ -d $artifactsFolder ]; then
  rm -R $artifactsFolder
fi

mkdir -p $artifactsFolder

dotnet restore ./DotBPE.Rpc.Hosting.sln
dotnet build ./DotBPE.Rpc.Hosting.sln -c Release



versionNumber="1.1.10"


dotnet pack ./DotBPE.Rpc.Hosting/DotBPE.Rpc.Hosting.csproj -c Release -o ../$artifactsFolder --version-suffix=$versionNumber
dotnet pack ./DotBPE.Hosting.Abstractions/DotBPE.Hosting.Abstractions.csproj -c Release -o ../$artifactsFolder --version-suffix=$versionNumber
dotnet pack ./DotBPE.Hosting/DotBPE.Hosting.csproj -c Release -o ../$artifactsFolder --version-suffix=$versionNumber



dotnet nuget push ./$artifactsFolder/DotBPE.Hosting.Abstractions.${versionNumber}.nupkg -k $NUGET_KEY -s https://www.nuget.org
dotnet nuget push ./$artifactsFolder/DotBPE.Hosting.${versionNumber}.nupkg -k $NUGET_KEY -s https://www.nuget.org
dotnet nuget push ./$artifactsFolder/DotBPE.Rpc.Hosting.${versionNumber}.nupkg -k $NUGET_KEY -s https://www.nuget.org



