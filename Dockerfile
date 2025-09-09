# Stage 1: Build Angular
FROM node:20-alpine as build
WORKDIR /app

# Copier seulement package.json pour installer les dépendances d'abord
COPY package*.json ./

# Forcer npm à ignorer les conflits de peer dependencies
RUN npm install --legacy-peer-deps

# Copier le reste du projet
COPY . .

# Build Angular en mode production
RUN npm run build --configuration production

# Stage 2: Serve avec Nginx
FROM nginx:alpine
COPY --from=build /app/dist/andresjosehr-portfolio /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
