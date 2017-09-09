
json.array! @programmeItems.each do |item|
    if item.parent_id == nil
        json.id             item.id.to_s    
        json.title          item.title ? item.title.html_safe : ''
        json.themes         item.theme_names.collect{|c| c.name}
        json.desc           item.precis ? item.precis.html_safe : ''
        json.format         item.format ? item.format.name : ''
        json.datetime       item.start_time
        json.date           item.start_time.strftime('%Y-%m-%d')
        json.day            item.start_time.strftime("%A")
        json.time           item.start_time.strftime('%H:%M')
        json.mins           item.duration.to_s
    
        if item.is_break
            loc = []
        else
            loc = [item.published_room_item_assignment.published_room.name]
            loc = loc << item.published_room_item_assignment.published_room.published_venue.name if !@singleVenue    
        end
            
        json.loc            loc
        json.tags           item.base_tags.collect{|t| t.name}
        json.people         item.published_programme_item_assignments.each do |assignment|
            if assignment.person
                json.id         assignment.person_id.to_s
                json.name       assignment.person.getFullPublicationName
                json.role       assignment.role.name if assignment.role
            end
        end
    end
end
