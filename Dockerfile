FROM nginx:alpine

# Remove página padrão do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia os arquivos de produção para o diretório web do Nginx
COPY dist /usr/share/nginx/html

# Configuração de roteamento com fallback e tipos MIME corretos
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
        try_files $uri $uri/ /index.html; \
    } \
    error_page 500 502 503 504 /50x.html; \
    location = /50x.html { \
        root /usr/share/nginx/html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
