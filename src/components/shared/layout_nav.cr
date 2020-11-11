class Shared::LayoutNav < BaseComponent
  # These are the regular navigation links
  @nav_links = [] of NavLink

  # Define your menu links here (outside of the html layout)
  private def build_menu
    @nav_links << NavLink.new "Home", Me::Show.with(0)
    @nav_links << NavLink.new "Login", SignIns::New
  end

  def render
    build_menu
    nav do
      # Renders the nav links. This might be executed elsewhere in this layout so we can format links with some mobile friendly css classes.
      render_links(@nav_links) do |is_active, is_first|
        "some css class"
      end
    end
  end

  # Renders an array of navigation data
  # The block allows you to pass in some custom css classes
  private def render_links(links : Array(NavLink))
    is_first = true
    links.each do |l|
      is_active = false
      classes = yield is_active, is_first
      if l.to.is_a?(Lucky::RouteHelper)
        link l.title, to: l.to.as(Lucky::RouteHelper), class: classes
      end
      if l.to.is_a?(Lucky::Action.class)
        # TODO: I can't use this commented out line because of https://github.com/luckyframework/lucky/issues/1243
        # link l.title, to: l.to.as(Lucky::Action.class), class: classes
        link l.title, to: Home::Index, class: classes
      end
      is_first = false
    end
  end

  # Just a helper to hold link information
  struct NavLink
    getter title, to

    def initialize(@title : String, @to : Lucky::Action.class | Lucky::RouteHelper)
    end
  end
end
