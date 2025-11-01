📘 Description

This script automates the backup of a specified directory to a remote server or cloud storage (e.g., Azure Blob Storage).
It ensures that important files are regularly backed up and includes a detailed log report of each backup operation.

🧠 Features

Scheduled or manual backup execution

Supports remote/cloud targets

Logs backup status (success/failure)

Displays timestamps for traceability

⚙️ Usage
# Clone the repository
git clone https://github.com/Jashhh3/azure-backup-script.git
cd azure-backup-script

# Make the script executable
chmod +x azure_backup.sh

# Run the script
./azure_backup.sh

🪵 Sample Log (azure_backup.log)
[2025-11-01 20:41:12] Starting backup of /home/wisecow/mydata
[2025-11-01 20:41:30] Backup uploaded successfully to Azure container 'mybackup'
[2025-11-01 20:41:30] Backup completed successfully.
