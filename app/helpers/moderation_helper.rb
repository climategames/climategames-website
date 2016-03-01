module ModerationHelper
  def yes_or_no(boolean)
    if boolean
      "<td class='green'>#{t('moderation.xyes')}</td>"
    else
      "<td class='red'>#{t('moderation.xno')}</td>"
    end.html_safe
  end

  def moderation_outcome_colored(report)
    color = ""
    # Can be contentious if already checked
    color = " class='yellow'" if report.checked_at
    # But becomes green or red if outcome is conclusive
    color = " class='green'" if report.approved?
    color = " class='red'" if report.rejected?
    "<td#{color}>#{report.moderation_outcome}</td>".html_safe
  end

  def hover_memo(report)
    if report.internal_memo.present?
      image_tag('refinery/icons/user_comment.png', alt: t('moderation.report.internal_memo'))
    end
  end
end
