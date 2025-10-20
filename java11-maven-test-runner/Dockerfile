FROM ubuntu:22.04

# Evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# O diretório de trabalho padrão.
WORKDIR /workspace

# Instalar dependências
# git, wget (para dependências), ca-certificates, software-properties-common
# o PPA para ter acesso a versões mais recentes do OpenJDK, o Java 11 e o Maven
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

# Configurar JAVA_HOME. O binário do 'mvn' e 'java' já estarão no PATH 
# devido à instalação via apt, mas definir JAVA_HOME é uma boa prática para o Maven.
# O diretório do Java 11 instalado via PPA é este:
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Note: Não é necessário adicionar $MAVEN_HOME/bin ao PATH, pois o 'apt install maven'
# já adiciona o binário 'mvn' ao /usr/bin.

# Verificar instalações
RUN java -version && mvn -version && git --version

# Comando padrão para quando o contêiner for executado sem argumentos
CMD ["/bin/bash"]
