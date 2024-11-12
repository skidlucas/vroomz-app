FROM oven/bun:latest as build

WORKDIR /app
COPY . .

RUN bun install && bun run build

FROM node:18-slim

WORKDIR /app

COPY --from=build /app/build /app/build

COPY package.json ./
RUN npm install --omit=dev

ENV PORT=5173
EXPOSE 5173

CMD ["node", "build"]