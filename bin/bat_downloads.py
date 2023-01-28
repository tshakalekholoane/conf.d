#!/usr/bin/env python3
"""bat_downloads returns a table showing the number of bat
(https://tshaka.co/x/bat) downloads grouped by release version.
"""

import requests

URL = "https://api.github.com/repos/tshakalekholoane/bat/releases"
headers = {"Accept": "application/vnd.github.v3+json"}
response = requests.get(url=URL, headers=headers, timeout=10)

total_downloads = 0
print("ver.\tn")
print("-" * 6 + '\t' + "-" * 6)
for release in response.json():
    count = release["assets"][0]["download_count"]
    version = release["tag_name"]
    total_downloads += count
    print(f"{version}\t{count}")
print("-" * 14)
print(f"\t{total_downloads}")
