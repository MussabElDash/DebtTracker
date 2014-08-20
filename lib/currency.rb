class Currency
	def self.currencies
		# File.open( "Common-Currency", "r" ) do |f|
		File.open( "currencies", "r" ) do |f|
			JSON.load( f )
		end
	end