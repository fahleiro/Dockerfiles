#!/bin/bash
set -e # Sai imediatamente se um comando falhar

# Diretório para o clone do projeto (deve ser o mesmo que em 01_clone_repo.sh)
PROJECT_DIR="cloned-repo"

echo "==============================================="
echo "| [1/3] Iniciando o Orquestrador de Testes"
echo "==============================================="

# 1. Executa a Clonagem e Validação (01_clone_repo.sh)
# Note: CLONE_URL deve ser passada via 'docker run -e CLONE_URL=...'
/usr/local/bin/01_clone_repo.sh

echo "==============================================="
echo "| [2/3] Entrando no Repositório Clonado"
echo "==============================================="

# 2. Entra no diretório clonado para executar os testes
cd "$PROJECT_DIR" || { echo "ERRO: Diretório do projeto não encontrado após o clone."; exit 1; }
pwd

echo "==============================================="
echo "| [3/3] Executando Testes (02_run_test.sh)"
echo "==============================================="

# 3. Executa a etapa de Testes
/usr/local/bin/02_run_test.sh

# Se 02_run_test.sh falhar, 'set -e' garante que o script pai também falhe.
echo "==============================================="
echo "| Orquestração Concluída com Sucesso"
echo "==============================================="
