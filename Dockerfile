# Usar Alpine Linux como base
FROM alpine:3.19

# Instalar dependências necessárias para compilar o cpuminer
RUN apk update && apk add --no-cache \
    build-base \
    curl-dev \
    openssl-dev \
    jansson-dev \
    git \
    automake \
    autoconf \
    && rm -rf /var/cache/apk/*

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