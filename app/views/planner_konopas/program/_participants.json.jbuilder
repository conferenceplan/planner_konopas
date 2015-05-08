
json.array! @participants.each do |person|
    if person
        json.id     person.id.to_s
        json.name   [person.pubFirstName, person.pubLastName, person.pubPrefix, person.pubSuffix ? person.pubSuffix : ""]
        json.bio    person.bio ? person.bio : ''
        if person.edited_bio
            json.links do
                if person.bio_image && @partition_val
                    listImage = person.bio_image
                    listImage.scale = 1
                    json.photo      listImage.bio_picture.standard.url
                end
                json.url        person.edited_bio.website if person.edited_bio.website && person.edited_bio.website.length > 0
                json.twitter    person.edited_bio.twitterid if person.edited_bio.twitterinfo && person.edited_bio.twitterinfo.length > 0
                json.fb         person.edited_bio.facebookid if person.edited_bio.facebook && person.edited_bio.facebook.length > 0
            end
        end
        json.prog       person.published_programme_items.collect{|i| i.id.to_s }
    end
end
