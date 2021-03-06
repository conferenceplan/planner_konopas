
module PlannerKonopas
  class ProgramController < ApplicationController
    caches_action :index,
                :cache_path => Proc.new { |c| c.params.delete_if { |k,v| k.starts_with?('sort')  || k.starts_with?('_dc') || k.starts_with?('undefined')} }
    caches_action :participants,
                :cache_path => Proc.new { |c| c.params.delete_if { |k,v| k.starts_with?('sort')  || k.starts_with?('_dc') || k.starts_with?('undefined')} }
    
    protect_from_forgery except: [:index, :participants]
    
    #
    # Get the program items in the JS form that Konapas wants
    #
    def index
      day = params[:day]
      @singleVenue = Venue.count == 1
      
      PublishedProgrammeItem.uncached do
        conditions = getConditions(params)
        
        @programmeItems = PublishedProgramItemsService.getPublishedProgramItems day
      end
      
      @result = render_to_string( template: 'planner_konopas/program/_index.json.jbuilder', locals: { programmeItems: @programmeItems})
      if FeatureService.has? 'konopas'
        render js: "var program = " + @result #, :content_type => 'application/json'
      else
        render js: "var program = []"
      end
    end
    
    #
    #
    #
    def participants
      peopleIds = params[:people_ids] ? params[:people_ids].split(',') : nil
      # logger.debug peopleIds
      
      Person.uncached do
        @cloudinaryURI = Cloudinary::Utils.cloudinary_url('A').sub(/\/A/,'')
        @partition_val = @cloudinaryURI ? @cloudinaryURI.sub(/http\:\/\/a[0-9]*\./,'') : ''
        @participants = PublishedProgramItemsService.findParticipants peopleIds
      end
      
      @result = render_to_string( template: 'planner_konopas/program/_participants.json.jbuilder', locals: { participants: @participants})
      if FeatureService.has? 'konopas'
        render js: "var people = " + @result #, :content_type => 'application/json'
      else
        render js: "var people = []"
      end
    end  

    #
    # Get the full programme
    # If the day is specified then just return the items for that day
    # Can return formatted as an Atom feed or plain HTML
    #
    def getConditions(params)
      day = params[:day] # Day
      name = params[:name]
      lastname = params[:lastname]
      
      conditionStr = "" if day || name || lastname
      conditionStr += '(published_room_item_assignments.day = ?) ' if day
      conditionStr += ' AND ' if day && (name || lastname)
      conditionStr += '(people.last_name like ? OR pseudonyms.last_name like ? OR people.first_name like ? OR pseudonyms.first_name like ? )' if name && !lastname
      conditionStr += '((people.last_name like ? OR pseudonyms.last_name like ?) AND (people.first_name like ? OR pseudonyms.first_name like ?))' if name && lastname
      conditionStr += '(people.last_name like ? OR pseudonyms.last_name like ?)' if lastname && !name
      conditions = [conditionStr] if day || name || lastname
      conditions += [day] if day 
      lastname = name if !lastname
      conditions += ['%'+lastname+'%', '%'+lastname+'%', '%'+name+'%', '%'+name+'%'] if name
      conditions += ['%'+lastname+'%', '%'+lastname+'%'] if lastname && !name
      
      return conditions
    end
    
  end
end
