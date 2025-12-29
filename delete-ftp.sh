#!/bin/bash

uapi Ftp list_ftp | while read -r line; do
    case "$line" in
        *"type: sub"*)
            DELETE_NEXT=1
            ;;
        *"user:"*)
            if [ "$DELETE_NEXT" = "1" ]; then
                fulluser=$(echo "$line" | awk '{print $2}')
                ftpuser="${fulluser%@*}"   # remove @domain
                echo "[+] Deleting FTP user: $ftpuser"
                uapi Ftp delete_ftp user="$ftpuser" delete_home_dir=0
                DELETE_NEXT=0
            fi
            ;;
    esac
done
