server {
    server_name example.com;

    gzip             on;
    gzip_proxied     any;
    gzip_types       text/css text/plain text/xml application/xml application/javascript application/x-javascript text/javascript application/json text/x-json image/svg image/svg+xml;
    gzip_vary        on;
    gzip_disable     "MSIE [1-6]\.";

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://unix:/tmp/example.socket:/;
    }
}
