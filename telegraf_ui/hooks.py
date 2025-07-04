
app_name = "telegraf_ui"
app_title = "Telegraf UI"
app_publisher = "You"
app_description = "Multi-host Telegraf Config UI"
app_email = "you@example.com"
app_license = "MIT"

app_include_js = "public/js/telegraf_editor.js"

scheduler_events = {
    "cron": {
        "*/5 * * * *": ["telegraf_ui.telegraf.update_all_status"]
    }
}
