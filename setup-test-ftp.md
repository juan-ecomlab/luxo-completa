# Test FTP Server Setup Guide

## Option 1: Using test.rebex.net (Public Test Server)

### Quick Setup
```
Host: test.rebex.net
Username: demo
Password: password
Port: 21
Protocol: FTP
Path: /test-luxo-theme/
```

### GitHub Secrets
```
TIENDANUBE_STAGING_FTP_HOST = test.rebex.net
TIENDANUBE_STAGING_FTP_USER = demo  
TIENDANUBE_STAGING_FTP_PASSWORD = password
TIENDANUBE_STAGING_FTP_PATH = /test-luxo-theme/
```

⚠️ **Note**: This is a public server - uploaded files may be visible to others and cleaned regularly.

## Option 2: DigitalOcean Droplet (Recommended)

### Step 1: Create Droplet
1. Sign up at digitalocean.com (free $200 credit)
2. Create Ubuntu 22.04 droplet ($4/month)
3. Note the IP address and root password

### Step 2: SSH Setup
```bash
# Connect to your droplet
ssh root@YOUR_DROPLET_IP

# Update system
apt update && apt upgrade -y

# Install FTP server
apt install vsftpd -y
```

### Step 3: Configure FTP
```bash
# Create FTP user
adduser ftpuser
# Set password when prompted

# Create theme directory
mkdir -p /home/ftpuser/themes
chown ftpuser:ftpuser /home/ftpuser/themes

# Configure vsftpd
nano /etc/vsftpd.conf
```

Add these lines to vsftpd.conf:
```
write_enable=YES
local_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
local_root=/home/ftpuser
```

### Step 4: Start FTP Service
```bash
systemctl restart vsftpd
systemctl enable vsftpd

# Open firewall
ufw allow 21/tcp
ufw allow 20/tcp
```

### Step 5: GitHub Secrets
```
TIENDANUBE_STAGING_FTP_HOST = YOUR_DROPLET_IP
TIENDANUBE_STAGING_FTP_USER = ftpuser
TIENDANUBE_STAGING_FTP_PASSWORD = YOUR_FTP_PASSWORD
TIENDANUBE_STAGING_FTP_PATH = /themes/luxo-test/
```

## Option 3: SFTP with DigitalOcean (More Secure)

### GitHub Secrets for SFTP
```
TIENDANUBE_STAGING_FTP_HOST = YOUR_DROPLET_IP
TIENDANUBE_STAGING_FTP_USER = ftpuser
TIENDANUBE_STAGING_FTP_PASSWORD = YOUR_FTP_PASSWORD  
TIENDANUBE_STAGING_FTP_PATH = /home/ftpuser/themes/luxo-test/
```

Update workflow to use SFTP:
```yaml
ftp_protocol: 'sftp'
ftp_port: 22
```

## Testing Connection

### Local Test (Mac/Linux)
```bash
# Test FTP
ftp YOUR_SERVER_IP
# Enter username and password
# Try: mkdir test-dir

# Test SFTP  
sftp ftpuser@YOUR_SERVER_IP
# Enter password
# Try: mkdir test-dir
```

### FileZilla Test
1. Download FileZilla
2. Host: your server IP
3. Username: ftpuser
4. Password: your password
5. Port: 21 (FTP) or 22 (SFTP)

## Cleanup After Testing
```bash
# Remove test files
rm -rf /home/ftpuser/themes/luxo-test/

# Or destroy droplet to stop billing
```