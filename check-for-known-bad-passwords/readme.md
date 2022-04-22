# Password security check script (Powered by HaveIBeenPwned API)

Main author: [Kevin Ramirez](https://www.linkedin.com/in/kevin-ramirez-b37326183/)

This project is a simple script written in [Ruby](https://www.ruby-lang.org/en/) to check a potential password against a dataset of known bad passwords (via [HIBP](https://haveibeenpwned.com/)). This is a school project that was built for the git project in IT Practicum course at [CSUDH.](https://www.csudh.edu/)

## Installation

 [Install the Ruby](https://www.ruby-lang.org/en/documentation/installation/) programming language on your local machine to run the script.

You may already have Ruby installed.  This can be checked by typing:
```bash
ruby -v
```

### Install Ruby on MacOS
Follow official [guide here](https://www.ruby-lang.org/en/documentation/installation/#homebrew) to install via [Homebrew](https://brew.sh/) 

### Install Ruby on Windows
Follow official [guide here](https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller) for windows installer.

## Script Usage & Example Run
The script can be ran via the terminal and requires a password to check as a command line argument.  See example  below (done on Windows):
```bash
ruby .\checkPass.rb password123  
```

NOTE: If the password text input (cmd line arg) has a space, then wrap the text in quotes. See example (done on Windows):
```bash
ruby .\checkPass.rb "my password"  
```

### Example output:
```bash
ruby .\checkPass.rb password123        

'password123' found in bad password data!
Hash Found: CBFDAC6008F9CAB4083784CBD1874F76618D2A97
Count: 248071
0.2220112 seconds elapsed
```

NOTE: Not including a string as a command line arg will result in this error message.  See example below:

```bash
ruby .\checkPass.rb  

ERROR: Invalid input. Please enter a string to check as command line argument!
```

## Background Info on HIBP Project
In this script, the check against known bad passwords is done by making a request to the [HaveIBeenPwned API](https://haveibeenpwned.com/API/v3#PwnedPasswords)

HaveIBeenPwned is an amazing project started by [Troy Hunt]() as a service to check for bad passwords, bad emails, and data from security breaches in the past.  Please read more about HaveIBeenPwned on the [official site](https://haveibeenpwned.com/About) and [Troy Hunt's blog](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/)

### Acknowledgement
Big thank you to [Troy Hunt](https://www.linkedin.com/in/troyhunt/) and all HaveIBeenPwned project contributors!! 


## Contributing
Pull requests are welcome. This is currently a small project and its open to expansion and improvement.  
