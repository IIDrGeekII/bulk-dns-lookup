# bulk-dns-lookup
A simple Windows batch script that performs bulk DNS lookups for a list of domains/URLs and saves the results to a CSV file.

Bulk DNS lookup for Windows. Reads domains from a file, resolves IPs via nslookup, prints a neat table, and exports results to a timestamped CSV.

1. Prepare your input file: <br>
     Create a plain text file with one domain/URL per line, e.g., *urls.txt*:
      ```
      google.com
      github.com
      example.org
      invalid-domain.test
      ```
     #### *Note: Place it in the same folder as bulk-dns-lookup.bat (or note its full path).*

2. Run the script: <br>
      Open Command Prompt (or PowerShell) in the repo folder and run:
   
      <img width="717" height="250" alt="image" src="https://github.com/user-attachments/assets/98280912-6313-4474-940e-97700757152e" />

3. Enter your input filename: <br>
      When prompted: <br>
        *If the file is in the same folder:* <br>
             ```
             Enter the filename containing URLs: urls.txt
             ``` <br>
        *If it’s elsewhere, give the full path (quotes if it has spaces):* <br>
             ```
             Enter the filename containing URLs: "C:\path\to\Documents\urls.txt"
             ```
