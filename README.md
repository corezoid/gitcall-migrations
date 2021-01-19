# gitcall-migrations

## Setup

The `setup.sh` command creates database `gitcall` and the database owner, one user that performs migrations and one for gitcall application.

The `setup.sh` command must be run only once. All tables, indexes  etc will be created by `gitcall_migrations` component:    

Before you start, make sure:
* You have postgres server up and running.
* You have admin access. 
* The server is reachable.

As docker:
```sh
docker run --network=host --rm \
-e ADMIN_USERNAME=postgres \
-e ADMIN_PASSWORD=postgres_pass \
-e OWNER_PASSWORD=gitcall_owner_pass \
-e MIGRATOR_USERNAME=gitcall_migrator \
-e MIGRATOR_PASSWORD=gitcall_migrator_pass \
-e APP_USERNAME=gitcall_user \
-e APP_PASSWORD=gitcall_user_pass \
-e DB=gitcallv2 \
-e HOST=postgre.host \
docker-hub.middleware.biz/public/gitcall/gitcall-migrations:2.0.0 \
setup.sh
```

* `ADMIN_USERNAME`: The super user from whom all setup commands are executed. Most like it is `postgres`.
* `ADMIN_PASSWORD`: The super user password
* `OWNER_PASSWORD`: The setup script creates `gitcall_owner` user with this password. The user owns gitcall database. It's not supposed to be used by any application.
* `MIGRATOR_USERNAME`: The setup script creates a user for `gitcall_migrations` component. This user would have alter-table kind of permissions on gitcall database.
* `MIGRATOR_PASSWORD`: The password for migrator user.
* `APP_USERNAME`: The setup script creates a user for `gitcall` component.
* `APP_PASSWORD`: The password for app user.
* `DB`: The script creates the database. Grants permissions to migration and app user to it.
* `HOST`: The database host, must be reachable from where you run this script.
* Take `gitcall-migrations` image version from your `release.yml` file.
* SQL migrations are inside container at path `/migrations/migrations/gitcall`.

## Migration

Configure migrations like this:

```yaml
gitcall_migrations:
    # [REQUIRED]: object.
    # GitCall Migrations
    config:
        migrator_username: 'gitcall_migrator'
        migrator_password: 'gitcall_migrator_pass'
        host: 'postgre.host'
        dir: 'migrations/gitcall'
        port: 5432
        db: 'gitcallv2'
    helm:
        image_pull_secrets: []
```
