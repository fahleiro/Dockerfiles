#!/bin/bash

# Comando base do Maven
BASE_MAVEN_COMMAND="mvn -q clean test"

# Adiciona os parâmetros do Cucumber, se existirem
if [ -z "$CUCUMBER_PARAMS" ]; then
    FINAL_MAVEN_COMMAND="$BASE_MAVEN_COMMAND"
    echo "Nenhum parâmetro CUCUMBER_PARAMS fornecido."
else
    FINAL_MAVEN_COMMAND="$BASE_MAVEN_COMMAND $CUCUMBER_PARAMS"
    echo "Parâmetros Cucumber adicionados: $CUCUMBER_PARAMS"
fi

echo "Comando Final Maven: $FINAL_MAVEN_COMMAND"
echo "-----------------------------------------------"

# Executa o comando e propaga o código de saída (sucesso ou falha)
$FINAL_MAVEN_COMMAND
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "ERRO: O comando Maven falhou com código de saída $EXIT_CODE."
    exit $EXIT_CODE
else
    echo "Maven executado com sucesso."
    exit 0
fi
