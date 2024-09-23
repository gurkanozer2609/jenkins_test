# Temel imaj olarak .NET 6.0 SDK kullan
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Proje dosyalarını kopyala ve bağımlılıkları yükle
COPY *.csproj ./
RUN dotnet restore

# Uygulama kaynaklarını kopyala ve publish et
COPY . ./
RUN dotnet publish -c Release -o out

# Çalışma imajı olarak .NET 6.0 Runtime kullan
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/out ./

# Uygulamayı başlat
ENTRYPOINT ["dotnet", "JenkinsTest.dll"]
