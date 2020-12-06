# About
This a project template for Less-Framework.

For the Less-Framework documentation se : https://packagist.org/packages/daiglej/less-framework

## File Structure
```
./
  lib/ # Autoloadable files (Classes defenitions)
  src/ # Other Application php-files
      config/ # Configurations
      www/
          index.php # Entrypoint for http requests.
      bootstrap.php # Initialize the Dependency Injection Container
  .editorconfig # Basic edetor configuration, identention, EOL encodeing... See http://editorconfig.org
  .env # Local configuration file
  .env.template # Initialization template for .env
  .gitignore # Files to be excluded by git
  composer.json # Configuration for composer (Edit with the composer comand)
  composer.lock # Lock file for php packages versions (Edit with the composer comand)
  craftman # Entrypoint for CLI commands (equivalent to laravel artisan)
  docker-compose.yml # Configuration for docker environment orchestration
  docker-compose-dev.yml # Extension for docker-compose.yml, to set an environment suitable for devlopment.
  Dockerfile # Instriction the build the main php image
  Makefile # Shortcuts to common environment operations.
  phpcs.xml # Configuration for phpcs & phpcbf
```

