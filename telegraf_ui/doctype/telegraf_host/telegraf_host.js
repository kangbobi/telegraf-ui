// Copyright (c) 2025, kangbobi and contributors
// For license information, please see license.txt

frappe.ui.form.on('Telegraf Host', {
	refresh: function(frm) {
		if (frm.doc.hostname && !frm.is_new()) {
			frm.add_custom_button(__('Test Connection'), function() {
				frappe.call({
					method: 'telegraf_ui.telegraf.test_connection',
					args: {
						hostname: frm.doc.hostname,
						username: frm.doc.username,
						password: frm.doc.password,
						ssh_port: frm.doc.ssh_port
					},
					callback: function(r) {
						if (r.message) {
							frappe.msgprint(__('Connection successful'));
						} else {
							frappe.msgprint(__('Connection failed'));
						}
					}
				});
			});
			
			frm.add_custom_button(__('Check Telegraf Status'), function() {
				frappe.call({
					method: 'telegraf_ui.telegraf.check_telegraf_status',
					args: {
						hostname: frm.doc.hostname
					},
					callback: function(r) {
						frm.reload_doc();
					}
				});
			});
		}
	}
});
