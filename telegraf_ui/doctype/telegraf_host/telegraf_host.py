# Copyright (c) 2025, kangbobi and contributors
# For license information, please see license.txt

import frappe
from frappe.model.document import Document

class TelegrafHost(Document):
	def validate(self):
		if not self.hostname:
			frappe.throw("Hostname is required")
		
	def on_update(self):
		# Update last seen when document is updated
		self.db_set('last_seen', frappe.utils.now(), update_modified=False)
