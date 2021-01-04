sudo docker exec docker-pulse_c-pulse_1 python -m data.update --scan=here >> update.log
sudo docker-compose restart
