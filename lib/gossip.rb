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

        CSV.foreach("./db/gossip.csv").with_index do |row, i| #pour chaque élément de ce CSV, on travaille sur row et index
            if i == (id.to_i - 1) #index commence de 0 alors que id commence à 1
                found_gossip << Gossip.new(row[0], row[1]) #on stocke le gossip correspondant dans un array
            end
        end

        return found_gossip
    end

    def self.update(id, author, content)
        updated_gossips = []
		CSV.foreach("./db/gossip.csv").with_index do |row, i|
			if i == (id.to_i - 1)
				updated_gossips << [author, content] #si l'id correspond on stocke dans l'array la row modifiée
			else
				updated_gossips << [row[0], row[1]] #sinon on garde l'originale
			end
        end
        CSV.open("./db/gossip.csv", "w") do |csv| #on ouvre le csv et sur le fichier
		    updated_gossips.each do |row| #pour chaque ligne de l'array
		        csv << row #on injecte cette ligne dans le csv ce qui remplace les valeurs précédentes en gardant l'indexation
            end
        end

    end
end