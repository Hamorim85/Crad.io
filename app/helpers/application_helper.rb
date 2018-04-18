module ApplicationHelper
  def number_humanizer(value)
    number = value.to_i
    return "#{(number / 1_000_000.0).round(1)}m" if number > 999_999
    return "#{(number / 1_000.0).round(1)}k" if number > 999
    number
  end
end
