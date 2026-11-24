# Stage 1: Build .NET 10 Web API
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy project files and restore dependencies
COPY ["src/Bookstore.API/Bookstore.API.csproj", "src/Bookstore.API/"]
COPY ["src/Bookstore.Application/Bookstore.Application.csproj", "src/Bookstore.Application/"]
COPY ["src/Bookstore.Domain/Bookstore.Domain.csproj", "src/Bookstore.Domain/"]
COPY ["src/Bookstore.Infrastructure/Bookstore.Infrastructure.csproj", "src/Bookstore.Infrastructure/"]

RUN dotnet restore "src/Bookstore.API/Bookstore.API.csproj"

# Copy source code and build
COPY . .
WORKDIR "/src/src/Bookstore.API"
RUN dotnet publish "Bookstore.API.csproj" -c Release -r linux-x64 --no-self-contained -o /app/publish /p:UseAppHost=false

# Stage 2: Final runtime container
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "Bookstore.API.dll"]
