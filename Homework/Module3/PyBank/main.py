### Imports ###
import csv 
import os

### Assumptions: ###
# Dates are all in Month-Year format, such that 'Jan-10' is a different month than 'Jan-11' because they're January from different years
# Each entry is a month in one column and a profit/ loss in a second column
# The average change is the average of the month-to-month change in profits/losses
# Change between two months is assigned to the later month 

### Functions: ###

# Part 1 - Function to open the CSV file and parse it
    # Can be used on its own, or called from within the subsequent functions

def parse(csv_file):
    with open(csv_file,"r") as budget_data:
        # Parses file as a lot of dictionaries, with the column headers as keys
        row_dicts = csv.DictReader(budget_data)

        # Puts the dictionaries together as a list of dictionaries; each dictionary has a "Date" and a "Profit/Losses" key-value pair
        parsed = list(row_dicts)

        # Stores the header row (the keys of the dictionary) to variables; month_key = Date, profit_key = Profit/Losses
        month_key = list(parsed[0].keys())[0]
        profit_key = list(parsed[0].keys())[1]

    # Returns the list of dictionaries and the column headers for future use in a tuple ordered in the order of the return statement
    return parsed, month_key, profit_key

# Part 2 - Calculates the total number of months 

def find_months(csv_file):
    # Parses the csv file
    parsed, month_key, profit_key = parse(csv_file)

    # Returns the number of dates in the file
    return len(parsed)

# Part 3 - Calculates the net total of Profit/Losses 

def find_total(csv_file):
    # Parses the csv file
    parsed, month_key, profit_key = parse(csv_file)

    # Sets up a counter to hold all of the profit/ loss values
    total = 0
    
    # Loops through the list of dictionaries specifying dates and profits/ losses
    for dic in parsed:

        # Pulls out the values keyed to "Profit/Losses", converts them to an integer, and adds them to the total 
        total = total + int(dic[profit_key])

    # Returns the total profit/ losses
    return total

# Part 4 - Calculates the change in Profit/ Losses per month

def find_changes(csv_file):
    # Parses the csv file
    parsed, month_key, profit_key = parse(csv_file)
    
    # Sets up an empty list to hold a dictionary of the month-to-month change for each month excet the first, with the change assigned to the second month
    changes = []

    # Loops thorugh all of the dictionaries in parsed except the first  
    for x in range(1,len(parsed)):

        # Sets up an empty dictionary to hold the individual changes between each month and the month previous
        change = {}

        # Assigns the 'current' month as a value in the dictionary 'change' with a key of 'Date'
        change["Date"] = parsed[x][month_key]
        
        # Grabs the profit/ loss, calculates the change between each month and the previous, and assigns it as a value of the dictionary 'change' with a key of 'Change'
        change["Change"] = int(parsed[x][profit_key]) - int(parsed[x-1][profit_key])

        # Puts the new dictionary into the list of dictionaries, 'changes'
        changes.append(change)
    
    # Returns a list of changes by month
    return changes   

# Part 5 - Calculate the average change in Profit/Losses

def find_average_change(csv_file):
    # Finds the changes over each month
    changes = find_changes(csv_file)

    # Sets up a counter to keep track of total change
    total_change = 0

    # Loops through the monthly changes
    for change in changes:

        # Grabs the change, converts it to an integer, and adds it to the total
        total_change = total_change + int(change["Change"])

    # Calculates the average change
    average_change = total_change / len(changes)

    # Returns the average change, rounded to 2 decimal places
    return round(average_change, 2)

# Part 6 - Find the greatest increase in profits (date and amount)

def find_greatest_increase(csv_file):
    # Grabs the changes over each month, in a list of dictionaries
    monthly_change = find_changes(csv_file)

    # Finds the dictionary in the list of dictionaries with the max change and sets it to a variable
    max_change = max(monthly_change, key = lambda x: x["Change"])

    # Sets variables for the max change and the month of the max change
    date_max = max_change["Date"]
    max_profit_change = max_change["Change"]

    # Returns the max change and the month of max change
    return date_max, max_profit_change

# Part 7 - Find the greatest decrease in profits (date and amount)

def find_greatest_decrease(csv_file):
    # Grabs the changes over each month, in a list of dictionaries
    monthly_change = find_changes(csv_file)

    # Finds the dictionary in the list of dictionaries with the min change and sets it to a variable
    min_change = min(monthly_change, key = lambda x: x["Change"])

    # Sets variables for the min change and the month of the min change
    date_min = min_change["Date"]
    profit_change_min = min_change["Change"]

    # Returns the min change and the month of min change
    return date_min, profit_change_min

# Part 8 - Perform all calculations, print to terminal, and write to .txt file

def run_calculations(csv_file):

    # Performs all calculations and sets each required number equal to a variable
    months = find_months(csv_file)
    total = find_total(csv_file)
    average_change = find_average_change(csv_file)
    date_max, greatest_increase = find_greatest_increase(csv_file)
    date_min, greatest_decrease = find_greatest_decrease(csv_file)

    # Prints everything to the terminal
    print("Financial Analysis")
    print("----------------------------")
    print(f"Total Months: {months}" )
    print(f"Total: ${total}")  
    print(f"Average Change: ${average_change}")
    print(f"Greatest Increase in Profits: {date_max} (${greatest_increase})")
    print(f"Greatest Decrease in Profits: {date_min} (${greatest_decrease})")

    # Writes everything to a .txt file
    with open(os.path.join(".", "analysis", "Financial_Analysis.txt"), 'w') as f:
        f.write("Financial Analysis\n")
        f.write("----------------------------\n")
        f.write(f"Total Months: {months}\n" )
        f.write(f"Total: ${total}\n")  
        f.write(f"Average Change: ${average_change}\n")
        f.write(f"Greatest Increase in Profits: {date_max} (${greatest_increase})\n")
        f.write(f"Greatest Decrease in Profits: {date_min} (${greatest_decrease})")

# Run the code! 
# Opens the csv called 'budget_data.csv' in the file 'Resources' that is in the same file as this main.py file and saves it to a variable
pybank_file = os.path.join(".", "Resources", "budget_data.csv")

# Performs the run_calculations function on the variable pybank_file
run_calculations(pybank_file)
