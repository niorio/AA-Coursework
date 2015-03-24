module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
    HTML

  end

  def delete_button(url)
    <<-HTML.html_safe

      <form action="#{url}" method="post">
        #{auth_token}
        <input type="hidden" name="_method" value="delete">
        <button>Delete</button>
      </form>

    HTML
  end

end
