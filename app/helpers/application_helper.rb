module ApplicationHelper
  def address_formatter(address)
    address.split(',').first(2).join(',').gsub(',', '')
  end

  def participation_history(participation)
    case participation.action_type.name
    when "water spot"
      return "#{participation.user.username} a arrosé  #{time_difference_in_days(participation.created_at)}"
    when "care"
      return "#{participation.user.username} a désherbé #{time_difference_in_days(participation.created_at)}"
    when "plant"
      "#{participation.user.username} a planté #{time_difference_in_days(participation.created_at)}"
    when "denounce"
      return "#{participation.user.team.name} vous a trash #{time_difference_in_days(participation.created_at)}!"
    end
  end

  def time_difference_in_days(from_time, to_time = Time.now)
    distance_in_days = ((to_time - from_time) / 1.day).round
    return "il y a #{distance_in_days} jour#{'s' unless distance_in_days == 1}"
  end
end
