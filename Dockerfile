# Stage 1: Build the React/Vite application
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN NODE_OPTIONS="--max-old-space-size=768" npm run build



# Stage 2: Serve the production build
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
