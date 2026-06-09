# Static host for Block Forge legal pages (privacy policy + app-ads.txt).
#
# Coolify setup:
#   Build Pack     = Dockerfile
#   Base Directory = /legal          (keeps the build context to this folder)
#   Port           = 80
#
# After deploy:
#   Privacy policy → https://<domain>/   and   https://<domain>/privacy-policy.html
#   AdMob app-ads  → https://<domain>/app-ads.txt   (root, text/plain — validates)
FROM nginx:1.27-alpine

COPY privacy-policy.html /usr/share/nginx/html/privacy-policy.html
COPY app-ads.txt         /usr/share/nginx/html/app-ads.txt
COPY nginx.conf          /etc/nginx/conf.d/default.conf

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=3s \
  CMD wget -qO- http://127.0.0.1/privacy-policy.html >/dev/null 2>&1 || exit 1
