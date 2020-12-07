# About
This a project template for Less-Framework.

For the Less-Framework documentation se : https://packagist.org/packages/daiglej/less-framework

## File Structure
```bash
./
├- .editorconfig # Basic edetor configuration, identention, EOL encodeing... See http://editorconfig.org
├- .env # Configuration file for the docker environment
├- .env.template # Initialization template for .env
├- .gitignore # Files to be excluded by git
├- docker-compose.yml # Docker environment orchestration
├- docker-compose-dev.yml # Extension for docker-compose.yml, to set an environment suitable for devlopment.
├- Makefile # Shortcuts to common environment operations.
├- nginx/ # nginx container related files
└- php/ # php container related files
   ├-- composer.json # Configuration for composer (Edit with the composer comand)
   ├-- composer.lock # Lock file for php packages versions (Edit with the composer comand)
   ├-- craftsman # Entrypoint for CLI commands (equivalent to laravel artisan)
   ├-- Dockerfile # Instruction the build the php image
   ├-- phpcs.xml # Configuration file for phpcs & phpcbf
   ├-- .psysh.php # Configuration file for PsySH See: https://psysh.org
   ├-- lib/ # Autoloadable files (Classes defenitions)
   ├-- src/ # Other Application php-files
   |   ├-- bootstrap.php # Initialize the Dependency Injection Container
   |   ├-- config/ # Configurations
   |   └-- www/
   |       └-- index.php # Entrypoint for http requests.
   └-- vendor/ # php 3rd party libraries
```
