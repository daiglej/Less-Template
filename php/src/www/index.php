<?php

declare(strict_types=1);

$DependencyInjectionContainer = require __DIR__ . '/src/bootstrap.php';

echo 'FIXME: Not implemented';
exit(1);

$httprequest = $DependencyInjectionContainer->get(\Psr\Http\Message\ServerRequestInterface::class);
$httpRequestHandler = $DependencyInjectionContainer->get(\Psr\Http\Server\RequestHandlerInterface::class);
$response = $httpRequestHandler->handle($request);
