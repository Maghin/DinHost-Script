# DinHost-Script
Python and Bash scripts to update DinHost account with a public IP

## Dependancies
- linx
- Python libraries

## Files
- **ipcheck.sh** gets your current public IP, compares with the old one and then executes ipcheck.py if needed
- **ipcheck.py** updates the DynHost account

## Usage
- Copy both files in a root's home directory and fix access
```sh
mkdir /root/ipcheck
cp * /root/ipcheck/
chmod -R 700 /root/ipcheck
```
- Edit ipcheck.sh with right host, login and password
```sh
HOST=*hostname_to_update*
LOGIN=*DynHost_account*
PASSWORD=*DynHost_password*
```
- Create a crontab under root account that often execute ipcheck.sh
```sh
# Execute every 6 hour
* */6 * * * /root/ipcheck/ipcheck.sh
```
