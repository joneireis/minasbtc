# Usar uma versão oficial do Ubuntu como base
FROM ubuntu:22.04

# Configurar o ambiente para evitar interatividade
ENV DEBIAN_FRONTEND=noninteractive

# Forçar servidores DNS do Google
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf \
    && echo "nameserver 8.8.4.4" >> /etc/resolv.conf

# Substituir os espelhos padrão do Ubuntu por um alternativo confiável
RUN sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirror.us.leaseweb.net/ubuntu|' /etc/apt/sources.list \
    && sed -i 's|http://security.ubuntu.com/ubuntu|http://mirror.us.leaseweb.net/ubuntu|' /etc/apt/sources.list

# Atualizar pacotes e instalar dependências com retries
RUN apt-get clean \
    && apt-get update -y || apt-get update -y \
    && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libjansson-dev \
    git \
    automake \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

# Clonar e compilar o cpuminer
RUN git clone https://github.com/pooler/cpuminer.git /opt/cpuminer \
    && cd /opt/cpuminer \
    && ./autogen.sh \
    && ./configure \
    && make

# Definir diretório de trabalho
WORKDIR /opt/cpuminer

# Variáveis de ambiente padrão
ENV WALLET_ADDRESS="your_bitcoin_wallet_address_here"
ENV CPU_THREADS="2"
ENV POOL_URL="stratum+tcp://solo.ckpool.org:3333"

# Comando para iniciar o minerador
CMD ["sh", "-c", "./minerd -a sha256d -o ${POOL_URL} -u ${WALLET_ADDRESS} -t ${CPU_THREADS}"]