#!/bin/bash
# Sincronizar index.html y fotos de conferencistas al servidor micro-red

REMOTE="micro-red"
REMOTE_HTML="/home/dochoa/thingsboard-pe/nginx/html/cybercon.html"
REMOTE_IMG_DIR="/home/dochoa/thingsboard-pe/nginx/html/conferencistas"
REMOTE_LOGOS_DIR="/home/dochoa/thingsboard-pe/nginx/html/logos"

# Sincronizar index.html como cybercon.html
echo ">>> Subiendo index.html -> $REMOTE_HTML"
scp index.html "$REMOTE:$REMOTE_HTML"

# Sincronizar conferencistas
echo ">>> Sincronizando conferencistas/"
ssh "$REMOTE" "mkdir -p $REMOTE_IMG_DIR"
rsync -avz --progress conferencistas/ "$REMOTE:$REMOTE_IMG_DIR/"

# Sincronizar solo los logos usados en index.html
echo ">>> Sincronizando logos/"
ssh "$REMOTE" "mkdir -p $REMOTE_LOGOS_DIR/GrupoRadical $REMOTE_LOGOS_DIR/IronCybersec $REMOTE_LOGOS_DIR/FernandoIllescas"
scp "logos/GrupoRadical/GRD_horizontal_color.png" "$REMOTE:$REMOTE_LOGOS_DIR/GrupoRadical/"
scp "logos/IronCybersec/logo-nobackground-500.png" "$REMOTE:$REMOTE_LOGOS_DIR/IronCybersec/"
scp "logos/FernandoIllescas/FERNANDO ILLESCAS 1.png" "$REMOTE:$REMOTE_LOGOS_DIR/FernandoIllescas/"

echo ">>> Listo"
