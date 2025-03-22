# Usar uma imagem com dependências pré-instaladas
FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências em uma camada separada
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libjansson-dev \
    git \
    automake \
    autoconf \
    && git clone https://github.com/pooler/cpuminer.git /opt/cpuminer \
    && cd /opt/cpuminer \
    && ./autogen.sh \
    && ./configure \
    && make

# Imagem final mínima
FROM ubuntu:22.04
COPY --from=builder /opt/cpuminer /opt/cpuminer
WORKDIR /opt/cpuminer
ENV WALLET_ADDRESS="your_bitcoin_wallet_address_here"
ENV CPU_THREADS="2"
ENV POOL_URL="stratum+tcp://solo.ckpool.org:3333"
CMD ["sh", "-c", "./minerd -a sha256d -o ${POOL_URL} -u ${WALLET_ADDRESS} -t ${CPU_THREADS}"]