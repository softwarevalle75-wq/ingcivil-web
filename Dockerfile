# Despliegue en Dokploy (proyecto Laboratorios-virtuales): ensambla el build
# web desde payload/ (igual que el workflow de GitHub Pages) y lo sirve con nginx.
FROM node:22-alpine AS build
WORKDIR /src
COPY assemble.cjs ./
COPY payload ./payload
COPY site ./site
RUN node assemble.cjs

FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /src/site /usr/share/nginx/html
EXPOSE 80
