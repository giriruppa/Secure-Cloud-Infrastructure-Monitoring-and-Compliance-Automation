🖥️ Step 1: Connect to Puppet-Nagios VM

In PowerShell or Windows Terminal, run:

ssh azureuser@52.140.97.222


Enter the password you set in Terraform (for example Giri@2025Secure#).

🧰 Step 2: Update and Prepare the System

Once logged in:

sudo apt update -y && sudo apt upgrade -y
sudo hostnamectl set-hostname puppet-master

🐶 Step 3: Install Puppet Server (Master)

Run these commands:

# Add Puppet repository
wget https://apt.puppetlabs.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update -y

# Install Puppet Server
sudo apt install -y puppetserver

# Enable and start Puppet Server
sudo systemctl enable puppetserver
sudo systemctl start puppetserver


✅ Puppet Master service should now be running:

sudo systemctl status puppetserver

⚙️ Step 4: Configure Puppet Memory (optional but recommended)

By default, Puppet Server uses 2 GB RAM.
If your VM is smaller (like D2s_v3), limit it to 512MB:

sudo sed -i 's/-Xms2g -Xmx2g/-Xms512m -Xmx512m/g' /etc/default/puppetserver
sudo systemctl restart puppetserver

🖥️ Step 5: Install Nagios Core

Now let’s install Nagios Core on the same VM.

sudo apt install -y apache2 libapache2-mod-php build-essential libgd-dev unzip
cd /tmp
sudo wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
sudo tar -xvzf nagios-4.4.6.tar.gz
cd nagios-4.4.6

sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all
sudo make install-groups-users
sudo usermod -a -G nagios www-data
sudo make install
sudo make install-daemoninit
sudo make install-commandmode
sudo make install-config
sudo make install-webconf

🔐 Step 6: Create Nagios Admin User
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin


→ Enter a password (remember it for login later).

Then restart Apache:

sudo systemctl restart apache2


✅ Access Nagios Web UI:

👉 http://52.140.97.222/nagios

Username: nagiosadmin

Password: (what you set above)

🧩 Step 7: Install NRPE Plugin (for checking other VMs)
sudo apt install -y nagios-nrpe-plugin

🧑‍💻 Step 8: Connect Puppet Agent VM

Now, SSH into your second VM:

ssh azureuser@4.213.34.190


Then install the Puppet Agent:

wget https://apt.puppetlabs.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update -y
sudo apt install -y puppet-agent


Configure the Puppet Master server address:

echo "server=puppet-master" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf
sudo systemctl enable puppet
sudo systemctl start puppet


Back on the Puppet Master, sign the agent’s certificate:

sudo /opt/puppetlabs/bin/puppetserver ca list
sudo /opt/puppetlabs/bin/puppetserver ca sign --all

✅ Verification

On the agent VM, test communication:

sudo /opt/puppetlabs/bin/puppet agent --test


If successful, Puppet Master ↔ Agent communication is working.

📈 Next: Integrate Nagios Monitoring

You can now add the Puppet Agent VM to Nagios monitoring by editing:

sudo nano /usr/local/nagios/etc/servers/puppet-agent.cfg


Add:

define host {
    use                     linux-server
    host_name               puppet-agent
    alias                   Puppet Agent Node
    address                 4.213.34.190
    max_check_attempts      5
    check_period            24x7
    notification_interval   30
    notification_period     24x7
}


Then restart Nagios:

sudo systemctl restart nagios
