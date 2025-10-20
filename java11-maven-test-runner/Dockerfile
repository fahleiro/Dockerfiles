# Usa a imagem base Ubuntu 22.04
FROM ubuntu:22.04

# Evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# O diretório de trabalho padrão.
WORKDIR /workspace

# Instalar dependências (git, Java 11, Maven, e ferramentas necessárias)
RUN apt-get update && \
    apt-get install -y \
        git \
        wget \
        ca-certificates \
        software-properties-common \
        && \
    # Adicionar PPA para OpenJDK (para garantir Java 11)
    add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update && \
    # Instalar Java 11 e Maven
    apt-get install -y \
        openjdk-11-jdk \
        maven \
        && \
    # Limpar o cache do apt para reduzir o tamanho da imagem
    rm -rf /var/lib/apt/lists/*

# Configurar JAVA_HOME.
# O diretório do Java 11 instalado via PPA é este:
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Verificar instalações
RUN java -version && mvn -version && git --version

# ----------------------------------------------------------------------
# Adicionando a nova funcionalidade: Script de Clone
# ----------------------------------------------------------------------

# Adiciona o script de execução ao contêiner
COPY 01_clone_repo.sh /usr/local/bin/01_clone_repo.sh

# Garante que o script é executável
RUN chmod +x /usr/local/bin/01_clone_repo.sh

# ----------------------------------------------------------------------
# Configurando o ENTRYPOINT e CMD
# ----------------------------------------------------------------------

# Define o ENTRYPOINT como o script.
# O ENTRYPOINT é o comando que sempre executa.
ENTRYPOINT ["/usr/local/bin/01_clone_repo.sh"]

# Define o CMD (comando padrão) a ser usado caso o ENTRYPOINT falhe
# ou se o usuário quiser usar o contêiner de forma interativa.
# Para manter a flexibilidade de um 'test-runner'
# vamos manter o CMD como /bin/bash, mas ele será ignorado se o ENTRYPOINT
# executar com sucesso (a menos que você use 'docker run --entrypoint').
CMD ["/bin/bash"]
