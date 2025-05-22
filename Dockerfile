# Use ASP.NET 8.0 runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Use .NET 8.0 SDK for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ProductsApi.csproj .
RUN dotnet restore ProductsApi.csproj
COPY . .
RUN dotnet publish ProductsApi.csproj -c Release -o /app/publish

# Create final image using the base runtime
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "ProductsApi.dll"]