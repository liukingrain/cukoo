class SummaryDecorator < Draper::Decorator
  decorates_association :items, with: CartItemDecorator
  decorates_association :billing_address
  decorates_association :shipping_address
  delegate_all
  
  def user_comment
    (comment_heading + comment_paragraph).html_safe if model.comment.present?
  end
  
  private
  
  def comment_heading
    h.content_tag :h2, I18n.t("summary.comment"), class: "heading"
  end
  
  def comment_paragraph
    h.content_tag :p, model.comment, class: "comment"
  end
end
