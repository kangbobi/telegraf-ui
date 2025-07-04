
import frappe
import paramiko
from datetime import datetime

def ssh_connect(docname):
    doc = frappe.get_doc("Telegraf Host", docname)
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(
        hostname=doc.hostname,
        port=doc.ssh_port or 22,
        username=doc.username,
        password=frappe.get_password("Telegraf Host", doc.name, "password")
    )
    return ssh

@frappe.whitelist()
def check_telegraf_status(hostname):
    ssh = ssh_connect(hostname)
    stdin, stdout, stderr = ssh.exec_command("systemctl is-active telegraf")
    status = stdout.read().decode().strip()
    ssh.close()
    frappe.db.set_value("Telegraf Host", hostname, {
        "telegraf_status": status.capitalize(),
        "last_seen": datetime.now()
    })
    return status

@frappe.whitelist()
def get_config(hostname):
    ssh = ssh_connect(hostname)
    sftp = ssh.open_sftp()
    with sftp.open("/etc/telegraf/telegraf.conf") as f:
        config = f.read()
    sftp.close()
    ssh.close()
    return config

@frappe.whitelist()
def save_config(hostname, config):
    ssh = ssh_connect(hostname)
    sftp = ssh.open_sftp()
    with sftp.open("/etc/telegraf/telegraf.conf", "w") as f:
        f.write(config)
    sftp.close()
    ssh.exec_command("sudo systemctl restart telegraf")
    ssh.close()
    return "Saved & restarted"

def update_all_status():
    hosts = frappe.get_all("Telegraf Host", filters={"enabled": 1}, pluck="name")
    for h in hosts:
        try:
            check_telegraf_status(h)
        except Exception as e:
            frappe.log_error(f"Host {h}: {e}")
            frappe.db.set_value("Telegraf Host", h, "telegraf_status", "Error")
