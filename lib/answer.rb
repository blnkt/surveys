class Answer < ActiveRecord::Base
  belongs_to :history
  belongs_to :question

  def total
    History.where(answer_id: self.id).count
  end

  def percentage
    grand_num = self.grand_total
    total_num = self.total
    ((total_num.to_f / grand_num.to_f) * 100).to_i
  end

  def grand_total
    History.where(question_id: self.question_id).count
  end
end
