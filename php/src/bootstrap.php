<?php
/**
 * @return \Psr\Container\ContainerInterface
 */

declare(strict_types=1);

/** @var \Psr\Container\ContainerInterface $dic */
$dic = null;
if(!$dic) {
    require __DIR__ . '/../vendor/autoload.php';

    $dic = 'something';
}


return $dic;
