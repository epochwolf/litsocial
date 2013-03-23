module IconHelper
  ICONS = {
    :_default => 'na',
    :flash_notice => 'tick-circle',
    :flash_error => 'exclamation-red',
    :flash_warning => 'exclamation',
    :flash_info => 'information',
    :locked_message => 'lock',
    :banned => 'user--exclaimation',
    
    :user => 'user',
    :user_epoch => 'user-detective',
    :user_admin => 'user-detective',
    :user_moderator => 'user-business',
    :user_member => 'user',
    :user_banned => 'user--exclamation',
    :user_internal => 'user-silhouette-question',
    :edit_user => "user--pencil",
    :masquerade => 'user-silhouette-question',
    
    :edit => 'wrench',
    :delete => 'cross',
    :locks => 'lock',
    :lock => 'lock',
    
    :new_report => 'flag--plus',
    :view_report => "flag--arrow",
    :reports => 'flag--arrow',
    :delete_report => 'flag--minus',
    :report => 'flag',
    :reported => 'flag',
    
    
    :new_follow => 'binocular--plus',
    :edit_follow => 'binocular--pencil',
    :delete_follow => 'binocular--minus',
    :follow => 'binocular',
    
    :new_reading_list => 'bookmarks--plus',
    :edit_reading_list => 'bookmarks--pencil',
    :delete_reading_list => 'bookmarks--minus',
    :public_reading_list => 'bookmarks-share',
    :reading_list => 'bookmarks',
    :subscribe_reading_list => 'binocular--plus',
    :unsubscribe_reading_list => 'binocular--minus',
    :add_to_public_reading_list => 'bookmark-share--plus',
    :remove_from_public_reading_list => 'bookmark-share--minus',
    :add_to_reading_list => 'bookmark--plus',
    :remove_from_reading_list => 'bookmark--minus',
    
    :friend => 'user--plus',
    :unfriend => 'user--minus',
    
    :new_generic => 'document--plus',
    :delete_generic => 'document--minus',
    :generic => 'document--plus',
    
    :new_message => 'mail--plus',
    :delete_message => 'mail--minus',
    :edit_message => 'mail--pencil',
    :message => 'mail',
    :message_reply => 'mail-reply',
    :starred_message => 'star-small',
    :star_message => 'star',
    :unstar_message => 'star-empty',
    :read_message => 'mail-open',
    :unread_message => 'mail',
    
    :new_comment => 'balloon--plus',
    :reply_comment => 'balloon--arrow',
    :edit_comment => 'balloon--pencil',
    :comment => 'balloon',
    
    :star => 'star',
    :unstar => 'star-empty',
    
    :new_tag => 'tag--plus',
    :edit_tag => 'tag--pencil',
    :delete_tag => 'tag---minus',
    :tag => 'tag',
    :download_txt => 'blue-documents-text',
    
    :new_folder => 'blue-folder--plus',
    :delete_folder => 'blue-folder--minus',
    :edit_folder => 'blue-folder--pencil',
    :folder => 'blue-folder',
    :open_folder => 'blue-folder-open',
    
    :new_story => 'quill--plus',
    :delete_story => 'quill--minus',
    :edit_story => 'quill--arrow',
    :story => 'quill',
    :stories => 'book-open-text',
    
    :new_journal => 'book--plus',
    :delete_journal => 'book--minus',
    :edit_journal => 'book--pencil',
    :journal => 'book',
    
    :new_forum => 'drawer--plus',
    :delete_forum => 'drawer--minus',
    :edit_forum => 'drawer--pencil',
    :forum => 'drawer',
    :reorder_forum => 'drawer--arrow',
    
    :new_thread => 'balloon-white-left',
    :delete_thread => 'balloon-white-left',
    :edit_thread => 'balloon-white-left',
    :thread => 'balloons-white',
    :forum_thread => 'balloons-white',
    :admin_thread => 'balloon-white-left',
    
    :new_wiki => 'blue-document--plus',
    :edit_wiki => 'blue-document--pencil',
    :delete_wiki => 'blue-document--minus',
    :wiki_history => 'blue-document-clock',
    :wiki_talk => 'blue-document-sticky-note',
    :wiki => 'blue-document-text',
  }
  
  def reading_list_icon(list)
    list.public?
    
  end
  
  # shiny icon :)
  def sicon(name, *options)
    name = ICONS.fetch(name, ICONS[:_default]) #if Symbol === name
    #image_tag "icons/#{name}.png", *options
    raw("<i class='sicon-#{name} sicon'></i>")
  end
  
  def sicon_link(icon_name, text, *args)
    text = raw(sicon(icon_name) + " " + text)
    link_to text, *args
  end
end