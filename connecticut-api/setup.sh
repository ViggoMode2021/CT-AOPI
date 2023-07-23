#!/env/bin/bash

sudo apt-get update
sudo apt install git
yes | sudo add-apt-repository universe # ‘Universe‘ is one of the standard repositories in Ubuntu,
# which contains community maintained free and open-source software,
# as opposed to ‘Main‘, which contains free and open-source software maintained by Ubuntu’s parent company Canonical.

yes | sudo apt-get install python3-pip apache2 libapache2-mod-wsgi-py3 # Apache 2 and Python module

yes | sudo apt install python3-virtualenv # Install virtual environment

git clone https://github.com/ViggoMode2021/CT-AOPI.git # Clone Django-API repository

cd connecticut-api # Change to directory

virtualenv myprojectenv # Create virtual environment

source myprojectenv/bin/activate # Activate virtual environment

pip install django # Install Django
pip install djangorestframework # Install REST framework
pip install django-extensions # Install Django-Extensions

python3 manage.py migrate # Run initial migrations

python3 manage.py runscript load # Load data from csv information into database

sudo chmod 777 /etc/apache2/sites-available # Make sites available read write accessible

sudo cat > /etc/apache2/sites-available/djangoproject.conf << EOF
<VirtualHost *:80>

	<Directory /home/ubuntu/connecticut-api/words>
		<Files wsgi.py>
			Require all granted
		</Files>
	</Directory>

	WSGIDaemonProcess connecticut-api python-path=/home/ubuntu/connecticut-api python-home=/home/ubuntu/connecticut-api/myprojectenv
	WSGIProcessGroup django_project
	WSGIScriptAlias / /home/ubuntu/connecticut-api/myprojectenv/wsgi.py
</VirtualHost>

EOF

sudo chmod 444 /etc/apache2/sites-available # Make sites available read accessible only

cd schools

sudo sed -i "s/DEBUG = True/DEBUG = False/" settings.py # Change DEBUG to False with Sed in settings.py
testp=$(curl http://checkip.amazonaws.com) # Curl server public IP and save to testp variable
sed -i "28s/\[\]/\['$testp']/" settings.py # Add server public IP to ALLOWED_HOSTS in settings.py

sudo apt-get install tmux # Install terminal multiplexer

cd .. # Cd into previous directory

tmux new -s connecticut-api # Create new tmux session

python3 manage.py runserver 0.0.0.0:80 # Run Django app
