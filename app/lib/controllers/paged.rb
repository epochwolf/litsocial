module Controllers::Paged  
  # see sort_link in application helper
  def paged(where, options={})
    options = {
      :page => 1,
      :per_page => 50,
      #:sort => nil,
      #:sort_desc => '0',
    }.update options
    page = params[:page] || options[:page]
    per_page = params[:per_page] || options[:per_page]
    #sort = params[:sort] || options[:sort]
    #direction = params[:sort_desc] || options[:sort_desc]
    paginator = if where.respond_to? :sorted
      where.sorted
    else
      where
    end
    #paginator = paginator.default_sort if where.respond_to?(:default_sort)
    #if where.sortable_columns.include?(sort.to_s)
    #  direction = sort.to_sym.send(Sorting.asc?(direction) ? :asc : :desc)
    #  paginator = paginator.order(direction) 
    #end
    paginator.page(page).per(per_page)
  end
end