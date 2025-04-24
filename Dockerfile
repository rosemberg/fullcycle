# Estágio de build
FROM golang:alpine AS builder

WORKDIR /app
COPY . .

# Compilar aplicação Go com flags para reduzir o tamanho
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o app

# Imagem final
FROM scratch

# Copiar o binário compilado da etapa anterior
COPY --from=builder /app/app /

# Definir o comando de execução
ENTRYPOINT ["/app"]