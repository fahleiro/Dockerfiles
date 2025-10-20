# Usa a imagem oficial OpenJDK 11 slim como base.
FROM openjdk:11-jdk-slim

# Evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# O diretório de trabalho padrão.
WORKDIR /workspace

# Instalar dependências necessárias: git para clonagem e maven para build.
RUN apt-get update && \
    apt-get install -y \
        git \
        maven \
        wget \
        ca-certificates \
        && \
    # Limpar o cache do apt para reduzir o tamanho da imagem (Prática importante)
    rm -rf /var/lib/apt/lists/*

# Verificar instalações (Java, Maven e Git)
RUN java -version && mvn -version && git --version

# ----------------------------------------------------------------------
# Adicionando a funcionalidade: Orquestração de Scripts
# Copia TUDO do diretório atual (incluindo start.sh, 01_clone_repo.sh, 02_run_test.sh)
# ----------------------------------------------------------------------

# Copia todos os arquivos da pasta atual do host para o WORKDIR /workspace
COPY . /workspace/

# Move os scripts para um local onde eles possam ser chamados de qualquer lugar e
# garante que todos são executáveis.
RUN mv /workspace/start.sh /usr/local/bin/start.sh && \
    mv /workspace/01_clone_repo.sh /usr/local/bin/01_clone_repo.sh && \
    mv /workspace/02_run_test.sh /usr/local/bin/02_run_test.sh && \
    chmod +x /usr/local/bin/*.sh

# ----------------------------------------------------------------------
# Configurando o ENTRYPOINT e CMD
# ----------------------------------------------------------------------

# Define o ENTRYPOINT como o script de orquestração.
ENTRYPOINT ["/usr/local/bin/start.sh"]

# CMD (comando padrão) para flexibilidade.
# Se o usuário rodar sem a CLONE_URL, o start.sh vai falhar.
# Se o usuário usar 'docker run --entrypoint /bin/bash', ele terá acesso ao shell.
CMD ["/bin/bash"]
