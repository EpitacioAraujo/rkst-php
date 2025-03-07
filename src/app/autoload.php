<?php

spl_autoload_register(function (string $namespace) {
    $caminhoArquivo = str_replace("Alura\\", __DIR__ . DIRECTORY_SEPARATOR, $namespace);
    $caminhoArquivo = str_replace("\\", DIRECTORY_SEPARATOR, $caminhoArquivo);
    $caminhoArquivo .= ".php";

    if (file_exists($caminhoArquivo)) {
        require_once $caminhoArquivo;
    }
});
