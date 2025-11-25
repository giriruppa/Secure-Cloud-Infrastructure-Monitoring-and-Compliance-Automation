**Configuration & Implementation**
----------------------------------

Now we’ll:

1.  SSH into your Puppet-Nagios VM (52.140.97.222)
    
2.  Install **Puppet Master**
    
3.  Install **Nagios Core**
    
4.  Then we’ll install **Puppet Agent** on the second VM (4.213.34.190) and connect it back.
    

🖥️ **Step 1: Connect to Puppet-Nagios VM**
-------------------------------------------

In PowerShell or Windows Terminal, run:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   ssh azureuser@52.140.97.222   `

Enter the password you set in Terraform (for example Giri@2025Secure#).

🧰 **Step 2: Update and Prepare the System**
--------------------------------------------

Once logged in:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo apt update -y && sudo apt upgrade -y  sudo hostnamectl set-hostname puppet-master   `

🐶 **Step 3: Install Puppet Server (Master)**
---------------------------------------------

Run these commands:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   # Add Puppet repository  wget https://apt.puppetlabs.com/puppet7-release-focal.deb  sudo dpkg -i puppet7-release-focal.deb  sudo apt update -y  # Install Puppet Server  sudo apt install -y puppetserver  # Enable and start Puppet Server  sudo systemctl enable puppetserver  sudo systemctl start puppetserver   `

✅ Puppet Master service should now be running:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo systemctl status puppetserver   `

⚙️ **Step 4: Configure Puppet Memory (optional but recommended)**
-----------------------------------------------------------------

By default, Puppet Server uses 2 GB RAM.If your VM is smaller (like D2s\_v3), limit it to 512MB:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo sed -i 's/-Xms2g -Xmx2g/-Xms512m -Xmx512m/g' /etc/default/puppetserver  sudo systemctl restart puppetserver   `

🖥️ **Step 5: Install Nagios Core**
-----------------------------------

Now let’s install **Nagios Core** on the same VM.

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo apt install -y apache2 libapache2-mod-php build-essential libgd-dev unzip  cd /tmp  sudo wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz  sudo tar -xvzf nagios-4.4.6.tar.gz  cd nagios-4.4.6  sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled  sudo make all  sudo make install-groups-users  sudo usermod -a -G nagios www-data  sudo make install  sudo make install-daemoninit  sudo make install-commandmode  sudo make install-config  sudo make install-webconf   `

🔐 **Step 6: Create Nagios Admin User**
---------------------------------------

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin   `

→ Enter a password (remember it for login later).

Then restart Apache:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo systemctl restart apache2   `

✅ Access Nagios Web UI:

> 👉 http://52.140.97.222/nagios

*   Username: nagiosadmin
    
*   Password: _(what you set above)_
    

🧩 **Step 7: Install NRPE Plugin (for checking other VMs)**
-----------------------------------------------------------

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo apt install -y nagios-nrpe-plugin   `

🧑‍💻 **Step 8: Connect Puppet Agent VM**
-----------------------------------------

Now, SSH into your second VM:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   ssh azureuser@4.213.34.190   `

Then install the Puppet Agent:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   wget https://apt.puppetlabs.com/puppet7-release-focal.deb  sudo dpkg -i puppet7-release-focal.deb  sudo apt update -y  sudo apt install -y puppet-agent   `

Configure the Puppet Master server address:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   echo "server=puppet-master" | sudo tee -a /etc/puppetlabs/puppet/puppet.conf  sudo systemctl enable puppet  sudo systemctl start puppet   `

Back on the **Puppet Master**, sign the agent’s certificate:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo /opt/puppetlabs/bin/puppetserver ca list  sudo /opt/puppetlabs/bin/puppetserver ca sign --all   `

✅ **Verification**
------------------

On the **agent VM**, test communication:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   sudo /opt/puppetlabs/bin/puppet agent --test   `