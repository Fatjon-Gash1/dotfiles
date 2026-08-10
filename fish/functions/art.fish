function art
    docker compose -f infra/docker-compose.yml exec app php artisan $argv
end
