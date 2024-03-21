sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd.service

#Создаём пользователя otusadm и otus
useradd otusadm
useradd otus

#Создаём пользователям пароли
echo "Otus2024!"| passwd --stdin otusadm && echo "Otus2024!" passwd --stdin otus

#Создаём группу admin
groupadd -f admin

#Добавляем пользователей root и otusadm в группу admin
usermod otusadm -a -G admin && usermod root -a -G admin

#Укажем в файле /etc/pam.d/sshd модуль pam_exec скрипт usr/local/bin/login.sh
sed -i '3 a auth required pam_exec.so debug /usr/local/bin/login.sh' /etc/pam.d/sshd
