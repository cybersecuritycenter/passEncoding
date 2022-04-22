# Main author: Kevin Ramirez
# Project: Cybersecurity center git project
# Built for IT Practicum course at CSUDH

# Password Security check script
# This script can be used to check a given password against a large dataset of known bad 
# passwords that have been recovered and included in past security breaches.
# See readme.md for more background information about HaveIBeenPwned API and script usage/setup.

# Steps taken to check a password that is given by user
# ------------------------------------------------------
# 1. Get password input from user as command line argument
# 2. Create password hash using SHA-1 algorithm (creates 40 character hex hash)
# 3. Retrieve first five characters of the password hash, this is the prefix
# 4. Use the hash prefix as input and make HTTP GET request to PwnedPasswords(HIBP) API
# 5. Parse the reponse data into objects that can be easily worked with
# 6. Run a check to see if the original password hash matches the prefix + any of the suffixes in the response data
# 7. If there is a match, password has been located in known bad password data and is NOT secure
# 8. If there is no match, the password being checked is not found and is fine to use (according HIBP API)
# 

require "uri"
require "net/http"
require "digest/sha1"

# METHODS
# ------------------
# create_hash method:
# Input: raw password text to check
# Return: SHA-1 hash of inputted password text
def create_hash(password)
    hash = Digest::SHA1.hexdigest password
    hash.upcase
end

# check_password method:
# Check password against dataset of known bad password
# using HIBP API (https://haveibeenpwned.com/API/v3#PwnedPasswords)
# Input: raw password text to check
# Return: If inputted password is found in the bad password data, return 
# found password object containing the hash and the number of occurences found in the data.
# Match ouput looks like this -> {:full_hash=> "FFB4761CBA839470133BEE36AEB139F58D7DBAA9", :count=>"802"}
def check_password(password)
    hashed_password = create_hash(password)
    hash_prefix = hashed_password.upcase[0,5]

    # make request to HIBP API
    url = URI("https://api.pwnedpasswords.com/range/#{hash_prefix}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    results = response.body.split("\n")

    # parse response data
    final_results = parse_response(results, hash_prefix)

    match = final_results.find { |p| p[:full_hash] == hashed_password }

    # if original full password hash is found in response data (prefix + any of the suffixes returned)
    # return the object, if no match then return nil
    if match 
        return match
    else
        return nil
    end
end

# parse_response method:
# Parse the raw response data from the api request into an array of ruby objects
# Input: raw response data from the api request & the original password hash prefix
# Return: Array of objects containing parsed response data (hash suffix and count)
def parse_response(response_data, prefix)
    results_ar = []
    response_data.each do |r|
        hash_suffix = r.split(":")[0] # isolate suffix
        count = r.split(":")[1].chomp # isolate count
        results_ar << {:full_hash => "#{prefix}#{hash_suffix}", :count => count}
    end
    results_ar
end


# PROGRAM START
if ARGV[0]
    password_to_check = ARGV[0]
    start_time = Time.now 
    password_check_result = check_password(password_to_check)
    stop_time = Time.now
    delta = stop_time - start_time

    if password_check_result
        puts "\'#{password_to_check}\' found in bad password data!\nHash Found: #{password_check_result[:full_hash]}\nCount: #{password_check_result[:count]}" 
        puts "#{delta} seconds elapsed\n\n"
    else
        puts "\'#{password_to_check}\' NOT found! Password is not located in known bad password data."
        puts "#{delta} seconds elapsed\n\n"
    end
else
    puts "ERROR: Invalid input. Please enter a string to check as comand line argument!"
end

# PROGRAM END
