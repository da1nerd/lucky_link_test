class Home::Index < BrowserAction
  include Auth::AllowGuests

  get "/" do
    if current_user?
      redirect Me::Show.with(0)
    else
      # When you're ready change this line to:
      #
      #   redirect SignIns::New
      #
      # Or maybe show signed out users a marketing page:
      #
      #   html Marketing::IndexPage
      redirect SignIns::New
    end
  end
end
