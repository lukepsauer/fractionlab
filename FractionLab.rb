require 'rational'
#Method for splitting fractions around the '/' into arrays
def split (input, num)
	if num == 1
		fractions = input.split("/")
		fraction = fractions.collect do |convert|
			convert = convert.to_i
		end
	else
		fractions1 = input.split("/")
		fraction1 = fractions1.collect do |convert|
                        convert = convert.to_i
                end
	end
end
#Method for converting decimals to fractions by making the decimal a whole number and using that as the numerator and then simplfying it
def convert (dec)
	decPlace = 0
	while(dec != dec.to_i)
        	decPlace += 1
        	dec *= 10
	end
	decPlace = 10 ** decPlace
	outputFrac = [dec.to_i, decPlace]
	simplify outputFrac[0], outputFrac[1]	
end
#Methpd for subtraction by making one value negative then adding
def subtract (num1, den1, num2, den2)
		num2 = num2 * -1
		puts den1
	outputFrac = add num1, den1, num2, den2
end
#Method for adding fractions by making the denominators equal and adding the unmerators together and then simplifying them
def add (num1, den1, num2, den2)	
	gcd = den1 * den2
	change1 = gcd / den1
	change2 = gcd / den2
	totalNum = (change1 * num1) + (change2 * num2)
        outputFrac = [totalNum, gcd]
	simplify outputFrac[0], outputFrac[1]
end
#Method for multiplying fractions and simplifying them
def multiply (num1, den1, num2, den2)
        outputFrac = [(num1 * den1), (num2 * den2)]
	simplify outputFrac[0], outputFrac[1]
end
#Method for dividing fractions by inversely multiplying
def divide (num1, den1, num2, den2)
        change = den1
	den1 = den2
	den2 = change
	outputFrac = (multiply num1, den1, num2, den2)
end
#Method for simplifying fractions using gcd
def simplify (num, den)
	gcdDen = den
	totalNum = num
	simplify = totalNum.gcd(gcdDen)
        totalNum = totalNum / simplify
        gcdDen = gcdDen / simplify
        outputFrac = [totalNum, gcdDen]
end
if __FILE__ == $0
	#Retrive input from the user
	puts "Is your input a fraction or a decimal? (fraction, decimal)"
	fracDec = gets.chomp.downcase
	#Find if they want to use decimals for fractions
	if fracDec == "decimal"
		#If decimal ask for the decimals and then convert the decimal to a fraction
		puts "What decimal would you like to convert?"
		decimal = gets.to_f
		fracConvert = convert decimal
		#Output the answer to the user
		if fracConvert[1] == 1
			puts "The converted decimal is now: #{fracConvert[0]}."
		elsif fracConvert[0] > fracConvert[1]
	                #convert the improper fraction to a mixed number if so asked
	                puts "Your answer is an improper fraction. Would you like to make it a mixed number? (yes or no)"
	                yesNo = gets.chomp.downcase
	                if yesNo == "yes"
	                        leftOver = fracConvert[0] % fracConvert[1]
	                        mixedNumber = fracConvert[0] / fracConvert[1]
	                        puts "Your mixed number is: #{mixedNumber} and #{leftOver}/#{fracConvert[1]}."
	                elsif yesNo == "no"
				puts "Your new fraction is: #{fracConvert[0]}/#{fracConvert[1]}."
			elsif yesNo != "yes" && yesNo != "no"
	                        puts "ERROR: Not a valid option!"
	                end
		else
			puts "The converted decimal is now: #{fracConvert[0]}/#{fracConvert[1]}."	
		end
	elsif fracDec == "fraction"
		#Retrive input from the user
		puts "What fraction would you like to manipulate?(numerator/denominator)"
		input1 = gets.chomp
		num = 1
		fractions = split input1, num
		fractions = simplify fractions[0], fractions[1]
		puts "What would you like to change? (add, subtract, multiply, divide, simplify)"
		manipulateChoice = gets.chomp.downcase
		#If a second fraction is needed then ask for it
		if manipulateChoice == "add" || manipulateChoice == "subtract" || manipulateChoice == "multiply" || manipulateChoice == "divide"
			puts "What fraction would you like to change it with?(numerator/denominator)"
			input2 = gets.chomp
			num = 0
			fractions1 = split input2, num
			error = 0
		elsif manipulateChoice == "simplify"
			error = 0
		else 
			puts "ERROR: Not a valid option"
			error = 1
		end
		#Run according methods for calculating fractions
		if manipulateChoice == "add"
			outputFrac = add fractions[0], fractions[1],  fractions1[0], fractions1[1]
		elsif manipulateChoice == "subtract"
			#Use the addition method to subtract
			outputFrac = subtract fractions[0], fractions[1],  fractions1[0], fractions1[1]
		elsif manipulateChoice == "multiply"
			outputFrac = multiply fractions[0], fractions[1],  fractions1[0], fractions1[1]
		elsif manipulateChoice == "divide"
			outputFrac = divide fractions[0], fractions[1],  fractions1[0], fractions1[1]
		elsif manipulateChoice == "simplify"
			outputFrac = simplify fractions[0], fractions[1]
		end
		#Check to see if it is a mixed number, a whole number, or a proper fraction
		if outputFrac[1] == 1 && error == 0
		puts "Your new fraction is: #{outputFrac[0]}."
	    elsif outputFrac[0] > outputFrac[1] && error == 0
			#convert the improper fraction to a mixed number if so asked
			puts "Your answer is an improper fraction. Would you like to make it a mixed number? (yes or no)"
			yesNo = gets.chomp.downcase
			if yesNo == "yes"
				leftOver = outputFrac[0] % outputFrac[1]
				mixedNumber = outputFrac[0] / outputFrac[1]
				#Output to the user
				puts "Your mixed number is: #{mixedNumber} and #{leftOver}/#{(outputFrac[1]).to_i}."
			elsif yesNo != "yes" && yesNo != "no"
				#If not a valid choice output an error
				puts "ERROR: Not a valid option!"
			end
		elsif error == 0
			#Output to user
			puts "Your new fraction is: #{outputFrac[0]}/#{outputFrac[1]}."
		end
	else
		#If not a valid choice output an error
		puts "ERROR: Not a valid option."
	end
end
