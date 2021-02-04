module ApplicationHelper
  def full_title(page_title = "")
    base_title = t("page_title")

    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def flash_message_prefix(message_type)
    case message_type
    when "success" then t("alert_prefix.success")
    when "info"    then t("alert_prefix.info")
    when "warning" then t("alert_prefix.warning")
    when "danger"  then t("alert_prefix.danger")
    else ""
    end
  end
end
