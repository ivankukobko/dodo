module HumanizeDuration
  ##
  # Class should have an attribute :duration:
  #
  # Expect :duration_human: to have format "1d 2h 30m"
  def duration_human= value=nil
    if value && !value.blank?
      m = (value.upcase.scan(/(\d+\s*[M])/).flatten)[0]
      h = (value.upcase.scan(/(\d+\s*[H])/).flatten)[0]
      d = (value.upcase.scan(/(\d+\s*[D])/).flatten)[0]
      self.duration =
        ((m.scan(/\d+/).first if m) || 0).to_i +
        ((h.scan(/\d+/).first if h) || 0).to_i * 60 +
        ((d.scan(/\d+/).first if d) || 0).to_i * 480
    end
  end

  def duration_human
    if duration
      if duration.to_i < 60
        "#{duration}m"
      else
        minutes = duration%60
        hours = (duration - minutes)/60
        "#{hours}h #{(minutes.to_s + 'm') if minutes > 0 }"
      end
    end
  end
end
