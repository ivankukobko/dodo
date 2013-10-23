class HelpLinkCell < Cell::Rails

  cache :display
  def display
    @help_links ||= InfoPage.promoted
    render
  end

end
