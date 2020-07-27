require 'csv'

class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
        csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []

        CSV.read("./db/gossip.csv").each do |csv_line|
          all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end

        return all_gossips
    end

    def self.find(id)
        found_gossip = []

        CSV.foreach("./db/gossip.csv").with_index do |row, i|
            if i == (id.to_i - 1)
                found_gossip << Gossip.new(row[0], row[1])
            end
        end

        return found_gossip
    end

    def self.update(id, author, content)
        updated_gossips = []
		CSV.foreach("./db/gossip.csv").with_index do |row, i|
			if i == (id.to_i - 1)
				updated_gossips << [author, content]
			else
				updated_gossips << [row[0], row[1]]
			end
        end
        CSV.open("./db/gossip.csv", "w") do |csv| 
		    updated_gossips.each do |row|
		        csv << row
            end
        end

    end
end