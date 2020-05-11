#Este proceso debe correr cada 3 minutos , asi se asegura que si la cam no levanta se cierra el proceso.

ps axu | grep ffmpeg >& catch_proccess_list

numcam="cam71122"
ip="admin:123456@192.168.1.65"
mediastream = "54.86.75.129"
procexct="ffmpeg -i rtsp://$ip -threads 1 -c:v libx264 -b:v 350K -s 640x360 -c:v copy -c:a copy -f flv rtmp://$mediastream/show/$numcam"
now=$( date )

if grep -qF "$numcam" catch_proccess_list;
    then 
        printf "Proceso en ejecucion '%s' \n" "$now $procexct" >> cam_log_status
    else
        printf "Proceso se restablece '%s' \n" "$now $procexct" >> cam_log_status
        $procexct;
fi