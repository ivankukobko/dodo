class HelpLinkCell < Cell::Rails

  def display
    @help_links ||= InfoPage.promoted
    render
  end

end
