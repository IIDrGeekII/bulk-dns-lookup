# bulk-dns-lookup
A simple Windows batch script that performs bulk DNS lookups for a list of domains/URLs and saves the results to a CSV file.

Bulk DNS lookup for Windows. Reads domains from a file, resolves IPs via nslookup, prints a neat table, and exports results to a timestamped CSV.

1. Prepare your input file: <br>
     <br>
     Create a plain text file with one domain/URL per line, e.g., *urls.txt*:
      ```
      google.com
      github.com
      example.org
      invalid-domain.test
      ```
     #### *Note: Place it in the same folder as bulk-dns-lookup.bat (or note its full path).*

2. Run the script: <br>
      <br>
      Open Command Prompt (or PowerShell) in the repo folder and run:
   
      <img width="717" height="250" alt="image" src="https://github.com/user-attachments/assets/98280912-6313-4474-940e-97700757152e" />

3. Enter your input filename: <br>
      - When prompted: <br>
        <br>
        - If the file is in the same folder: <br> 
        - `Enter the filename containing URLs: urls.txt` <br>
             <br>
        - If it’s elsewhere, give the full path (quotes if it has spaces): <br>
        - `Enter the filename containing URLs: "C:\path\to\Documents\urls.txt"`

4. View results: <br>
     - The console shows a table of **`URL | IP Address`** (with `[Lookup failed]` where applicable).  
     - A CSV is saved automatically in the same folder, in the following name format:  
       - `output_YYYY-MM-DD_HHMM.csv`

5. Sample output: <br>

     <img width="651" height="849" alt="image" src="https://github.com/user-attachments/assets/281dcc11-ed3b-4924-a8b2-092c5e4fb673" />

## Tips & troubleshooting: <br>

     - File not found: Make sure the path/filename you type is correct (include quotes if it contains spaces).
     - Corporate proxy/DNS: Results depend on the DNS your system uses; try from a different network if lookups fail unexpectedly.
     - Permissions: If saving to a protected folder, run the command prompt as Administrator or choose a user-writable folder (e.g., Desktop).
     - Large lists: The script handles many domains; if it seems slow, that’s nslookup latency. Consider splitting the list if needed.
