### Imports ###
import csv 
import os

### Functions: ###

# Part 1 - Function to open the CSV file and parse it
    # Can be used on its own, or called from within the subsequent functions

def parse(csv_file):
    with open(csv_file,"r") as election_data:
        # Parses file as a lot of dictionaries, with the column headers as keys
        row_dicts = csv.DictReader(election_data)

        # Puts the dictionaries together as a list of dictionaries; each dictionary has a "Ballot ID" a "County" and a "Candidate" key-value pair
        parsed = list(row_dicts)

        # Stores the header row (the keys of the dictionary) to variables; ballot_key = 'Ballot', county_key = 'County', candidate_key = 'Candidate'
        ballot_key = list(parsed[0].keys())[0]
        county_key = list(parsed[0].keys())[1]
        candidate_key = list(parsed[0].keys())[2]

    # Returns the list of dictionaries and the column headers for future use in a tuple ordered in the order of the return statement
    return parsed, ballot_key, county_key, candidate_key

# Part 2 - Finds total number of votes cast
    # Input is parsed dictionaries, NOT csv file

def find_total_votes(parsed):
    # Returns the number of lines in the file
    return len(parsed)

# Part 3 - Comes up with a list of unique candidates
    # Input is parsed votes, NOT csv file

def find_candidates(parsed):
    # Sets up a list for unique candidates
    candidates = []

    # Loops through all the votes, and adds any candidates that are not already in the candidates list into the list
    for x in range(len(parsed)):
        if parsed[x]["Candidate"] in candidates:
            pass
        else:
            candidates.append(parsed[x]["Candidate"])
    
    # Returns the list of candidates 
    return candidates

# Part 4 - Determines number of votes a candidate won, both the number and the percent
    # Input is a candidate's name and the parsed dictionaries, NOT csv file

def find_candidate_votes(candidate, parsed):
    # Sets up a variable to hold the number of votes cast for the input candidate
    number_votes = 0

    # Loops through the votes and counts up the total votes cast for the input candidate
    for x in range(len(parsed)):
        if parsed[x]["Candidate"] == candidate:
            number_votes += 1

    # Calculates the percent of votes the candidate received 
    percent_votes = round(((number_votes / find_total_votes(parsed)) * 100), 3)

    # Returns the percent of votes and the number of votes the candidate received
    return percent_votes, number_votes

# Part 5 - Determines the winner of the election
    # Input is the parsed dictionaries, NOT csv file

def find_winner(parsed):
    # Grabs the list of candidates
    candidates = find_candidates(parsed)

    # Initializes an empty list for candidates and # votes
    votes = []

    # Loops through the unique candidates 
    for candidate in candidates:

        # Finds the number and percentage of votes candidates received
        percent_votes, number_votes = find_candidate_votes(candidate, parsed)

        # Stores stats to a dictionary 
        stats = {'candidate': candidate, 'percent': percent_votes, 'number': number_votes}

        # Adds the stats dictionary to the list 'votes'
        votes.append(stats)

    # Finds the winner and assigns the dictionary containing it to a variable
    winner_full = max(votes, key = lambda x: x["number"])

    # Grabs the name of the winner and assigns to a variable
    winner = winner_full["candidate"]

    # Returns the stats for each candidate and the overall winner
    return votes, winner

# Part 6 - Prints everything and writes a .txt file

def run_calculations(csv_file):
    # Parses csv file
    parsed, ballot_key, county_key, candidate_key = parse(csv_file)

    # Performs calculations
    total_votes = find_total_votes(parsed)
    votes, winner = find_winner(parsed)

    # Prints everything to the terminal
    print("Election Results")
    print("-------------------------")   
    print(f"Total Votes: {total_votes}")
    print("-------------------------")
    for vote in votes:
        print(f"{vote['candidate']}: {vote['percent']}% ({vote['number']})")
    print("-------------------------")
    print(f"Winner: {winner}")
    print("-------------------------")

    # Writes everything to a .txt file
    with open(os.path.join(".", "analysis", "Election_Analysis.txt"), 'w') as f:
        f.write("Election Results\n")
        f.write("-------------------------\n")   
        f.write(f"Total Votes: {total_votes}\n")
        f.write("-------------------------\n")
        for vote in votes:
            f.write(f"{vote['candidate']}: {vote['percent']}% ({vote['number']})\n")
        f.write("-------------------------\n")
        f.write(f"Winner: {winner}\n")
        f.write("-------------------------\n")


# Runs the code! 
# Opens the csv called 'budget_data.csv' in the file 'Resources' that is in the same file as this main.py file and saves it to a variable
pypoll_file = os.path.join(".", "Resources", "election_data.csv")

# Performs the run_calculations function on the variable pybank_file
run_calculations(pypoll_file)