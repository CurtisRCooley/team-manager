module WelcomeHelper
  def popup_link(link_text, action)
    link_to link_text, { :action => action }, 
      :popup => ['feature_note', 'location=0,scrollbars=1,resizable=0,width=400,height=300']
  end
end
