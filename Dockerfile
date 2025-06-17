# Estágio de Build 
# Usa uma imagem base oficial do Node.js - especificamente a versão 20 em Alpine Linux
FROM node:20-alpine AS build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de configuração do Node.js primeiro para aproveitar o cache do Docker
COPY package*.json ./

# Instala as dependências do Node.js
RUN npm install

# Copia todo o resto do código da aplicação para o diretório de trabalho
COPY . .

# Estágio de Produção
# Usa uma imagem base ainda mais leve - sem a parte do build
FROM node:20-alpine

# Define o diretório de trabalho
WORKDIR /app

# Copia apenas o que é essencial do estágio de build para o estágio final
COPY --from=build /app .

# Expõe a porta em que a aplicação Node.js vai escutar (porta 80 aqui)
EXPOSE 80

# Comando para iniciar a aplicação quando o container for executado
CMD ["npm", "start"]