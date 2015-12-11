module Csscss
  class JSONReporter
    def initialize(redundancies)
      @redundancies = redundancies
    end

    def report(offset_container)
      JSON.dump(@redundancies.map {|selector_groups, declarations|
		#print create_hash(get_file_list(selector_groups, offset_container), selector_groups.map(&:to_s))
        {
          "selectors"    => create_hash(get_file_list(selector_groups, offset_container), selector_groups.map(&:to_s)),#selector_groups.map(&:to_s),
          "count"        => declarations.count,
          "declarations" => declarations.map(&:to_s)
        }
      })
    end
	
	private
	def get_file_list(selector_groups, offset_container)
	  selector_groups.map{ |selector|
		offset_container.select{|file_offset| file_offset === selector.offset}.values.first
	  }
	end
	
	def create_hash(files, selectors)
	  res = {}
	  files.zip(selectors).each{ |file, selector|
		if not res.has_key? file
		  res[file] = [selector]
	    end
		res[file] << selector
	  }
	  res
	end
  end
end
