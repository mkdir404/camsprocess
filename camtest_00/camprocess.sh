#Este proceso debe correr cada 3 minutos , asi se asegura que si la cam no levanta se cierra el proceso.
# orden camnumero , ip cam  , mediastream 
# Ejmplpo de como se pone en el cron ./camprocess.sh cam711220 admin:123456@192.168.1.65 54.86.75.129
args=("$@")
numcam=${args[0]}
ip=${args[1]}
mediastream=${args[2]}

ps axu | grep ffmpeg >& catch_proccess_list
procexct="ffmpeg -i rtsp://$ip -threads 1 -c:v libx264 -b:v 350K -s 640x360 -c:v copy -c:a copy -f flv rtmp://$mediastream/show/$numcam"
now=$( date )

if grep -qF "$numcam" catch_proccess_list;
    then 
        printf "Proceso en ejecucion '%s' \n" "$now $procexct" >> cam_log_status
    else
        printf "Proceso se restablece '%s' \n" "$now $procexct" >> cam_log_status
        $procexct;
fi