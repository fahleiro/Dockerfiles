FROM openjdk:11-jdk-slim

# Evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# O diretório de trabalho padrão.
WORKDIR /workspace

# O JAVA_HOME já está configurado na imagem base.
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

# Verificar instalações (Java já deve estar OK, mas verificamos git e mvn)
# O comando java -version deve funcionar, mas o PATH/JAVA_HOME é configurado pela imagem base.
RUN java -version && mvn -version && git --version

# ----------------------------------------------------------------------
# Adicionando a funcionalidade: Script de Clone
# ----------------------------------------------------------------------

# Adiciona o script de execução ao contêiner
# Certifique-se que o 01_clone_repo.sh esteja no mesmo diretório!
COPY 01_clone_repo.sh /usr/local/bin/01_clone_repo.sh

# Garante que o script é executável
RUN chmod +x /usr/local/bin/01_clone_repo.sh

# ----------------------------------------------------------------------
# Configurando o ENTRYPOINT e CMD
# ----------------------------------------------------------------------

# Define o ENTRYPOINT como o script de clone.
ENTRYPOINT ["/usr/local/bin/01_clone_repo.sh"]

# CMD (comando padrão) para flexibilidade (acesso ao shell)
CMD ["/bin/bash"]
