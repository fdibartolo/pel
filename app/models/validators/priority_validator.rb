class PriorityValidator < ActiveModel::Validator
  def validate(record)
    questions_count = record.questions.length
    record.questions.each do |question|
      if question.priority < 1
        record.errors[:questions] << "priority must be greater than 0"
      elsif question.priority > questions_count
        record.errors[:questions] << "priority cannot be greater than #{questions_count}"
      end
    end
  end
end
