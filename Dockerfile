FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build

WORKDIR /app

COPY test-app .

RUN set -ex; \
    dotnet publish ./test-app.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:3.1

RUN useradd -m dotnet
USER dotnet

WORKDIR /app

COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "test-app.dll"]

EXPOSE 8080
