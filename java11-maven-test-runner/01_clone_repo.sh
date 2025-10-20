#!/bin/bash

# Define o diretório onde o repositório será clonado
PROJECT_DIR="cloned-repo"

# Verifica se a URL de clone foi fornecida
if [ -z "$CLONE_URL" ]; then
    echo "Erro: A variável de ambiente CLONE_URL não foi definida."
    echo "Uso: docker run -e CLONE_URL='sua_url' ..."
    exit 1
fi

echo "==============================================="
echo "| Iniciando o Clone"
echo "==============================================="
echo "URL de Clone: $CLONE_URL"

# Garante que o diretório de destino não exista para um clone limpo
if [ -d "$PROJECT_DIR" ]; then
    echo "Aviso: Removendo o diretório existente: $PROJECT_DIR"
    rm -rf "$PROJECT_DIR"
fi

# Clona o repositório para o diretório de destino
if ! git clone "$CLONE_URL" "$PROJECT_DIR"; then
    echo "ERRO: Falha ao clonar o repositório."
    exit 1
fi

cd "$PROJECT_DIR" || exit

echo "==============================================="
echo "| Validando Último Commit"
echo "==============================================="

# Exibe o último commit em um formato legível
echo "Detalhes do Último Commit:"
git log -1 --pretty=format:"  - Hash: %H%n  - Autor: %an <%ae>%n  - Data: %ad%n  - Mensagem: %s" --date=format:'%Y-%m-%d %H:%M:%S'

echo "==============================================="
echo "| Clone e Validação Concluídos"
echo "==============================================="

# O script sai com sucesso (código 0)
exit 0
