
frappe.provide("telegraf_ui");

telegraf_ui.ConfigEditor = class {
  constructor(wrapper) {
    this.wrapper = wrapper;
    this.page = null;
    this.hosts = [];
    this.current_host = null;
    this.init();
  }

  async init() {
    this.page = frappe.ui.make_app_page({
      parent: this.wrapper,
      title: "Telegraf Config Editor",
      single_column: true,
    });

    this.body = $(`<div class="p-4">
      <select id="host-select" class="mb-2 form-control"></select>
      <textarea id="config-box" class="form-control" rows="25" style="width:100%"></textarea>
      <div class="mt-3">
        <button class="btn btn-primary" id="save-btn">Save</button>
        <button class="btn btn-secondary ml-2" id="reload-btn">Reload Telegraf</button>
        <span id="status" class="ml-4 text-muted"></span>
      </div>
    </div>`).appendTo(this.page.body);

    await this.load_hosts();

    this.body.find("#host-select").on("change", () => {
      this.current_host = this.body.find("#host-select").val();
      this.load_config();
    });

    this.body.find("#save-btn").on("click", () => this.save_config());
    this.body.find("#reload-btn").on("click", () => this.reload_telegraf());

    this.current_host = this.hosts.length ? this.hosts[0].name : null;
    if (this.current_host) this.load_config();
  }

  async load_hosts() {
    const res = await frappe.call("frappe.client.get_list", {
      doctype: "Telegraf Host",
      fields: ["name", "hostname"],
      filters: { enabled: 1 },
    });
    this.hosts = res.message || [];
    const select = this.body.find("#host-select").empty();
    this.hosts.forEach(h => {
      select.append(`<option value="${h.name}">${h.name} (${h.hostname})</option>`);
    });
  }

  async load_config() {
    if (!this.current_host) return;
    const res = await frappe.call("telegraf_ui.telegraf.get_config", {
      hostname: this.current_host,
    });
    this.body.find("#config-box").val(res.message || "");
    this.set_status("Loaded.");
  }

  async save_config() {
    const config = this.body.find("#config-box").val();
    await frappe.call("telegraf_ui.telegraf.save_config", {
      hostname: this.current_host,
      config,
    });
    this.set_status("✅ Config saved & Telegraf reloaded.");
  }

  async reload_telegraf() {
    await frappe.call("telegraf_ui.telegraf.check_telegraf_status", {
      hostname: this.current_host,
    });
    this.set_status("🔄 Telegraf reloaded.");
  }

  set_status(msg) {
    this.body.find("#status").text(msg);
  }
};
