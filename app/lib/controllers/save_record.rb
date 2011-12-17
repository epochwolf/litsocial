module Controllers::SaveRecord
  
  def attached_events
    @_attached_events ||= []
  end
  
  
  def save_events(&block)
    save_events!(&block)
  rescue ActiveRecord::RecordNotSaved
    false
  rescue ActiveRecord::RecordInvalid
    false
  end
  
  def save_events!(&block)
    Event.transaction do
      block.call if block
      attached_events.compact.each do |args|
        Event.from(current_user, *args).save!
      end
      attached_events.clear
    end
  end
  
  
  # For use with save_record to set the creator of a record
  # Example usage: save_record @literature, &set_creator
  def set_creator(user=nil)
    proc {|record| record.user = user || current_user }
  end
  
  # Creates an event using the current user
  # See Event.from for behavior (current_user is passed as the first argument)
  # See Event.wrap for behavior with a block
  def event(*args)
    @_attached_events ||= []
    @_attached_events << args
  end
  
  # Automates the saving of records
  # Returns result of record.save
  # Params
  #   record     : Active Record object to be saved
  #   options    : Hash
  #   tap_record : called before saving the record (passes the record as the first parameter)
  # Options
  #  params        : params to use for create/update. (default: record.class.name.underscore)
  #  as            : role to use for mass assignment (default: nil)
  #  add_params    : combine hash with params after params have been filtered
  #  user          : user to use for saving. (default: current_user)
  def save_record(record, options={}, &tap_record)
    return nil if record.nil?
    options = {
      :add_params => {},
      :as => nil,
      :without_protection => false,
      :params => params[record.class.name.underscore.to_sym],
      :user => current_user,
    }.update options

    options[:params].update(options[:add_params])
    
    # save the record, handling events if needed
    record.attributes = options[:params]
    record.tap(&tap_record) if block_given?    
    # Save any attached events
    # save_events do
    #   record.save!
    # end
    record.save
  end

  # Automates deletion of records, abstracts from soft delete. 
  # Params
  #   record     : Active Record object to be saved
  #   options    : Hash
  #   tap_record : called before soft deleting the record (passes the record as the first parameter)
  # Options
  #  user        : user to use for saving. (default: current_user)
  def delete_record(record, options={}, &tap_record)
    options = {
      :user => current_user,
    }.update options
    if record.respond_to? :soft_delete
      record.tap(&tap_record)  if block_given?
      record.soft_delete!
    else
      record.destroy
    end
  end
end