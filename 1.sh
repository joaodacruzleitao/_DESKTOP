#!/usr/bin/env bash

FICHEIRO=/root/.virus/fullscan/__clamdscan_fullscan.log

while read -r line; do
  temporario=$(echo "$line" | grep -i "/root/.virus")
  if [ "$temporario" != "" ]; then
    HOMEUSER=$(echo "$line" | cut -d' ' -f1 | cut -d':' -f1)
    ROOTVIRUS=$(echo "$line" | cut -d' ' -f4 | cut -d"'" -f2)
    # RVIRUS=$(sed "s#//#/fullscan/#g" <<<"$ROOTVIRUS")
    RVIRUS=$(ROOTVIRUS//#/fullscan/#g <<<"$ROOTVIRUS")
    mv "${RVIRUS}" "${HOMEUSER}"
    echo "--> A mover $RVIRUS para $HOMEUSER"
    echo
  fi
done <$FICHEIRO
