#!/usr/bin/env python3
"""Download statistics for https://tshaka.dev/x/bat."""

from urllib.request import Request
from urllib import request
import json

url = "https://api.github.com/repos/tshakalekholoane/bat/releases"
headers = {"Accept": "application/vnd.github.v3+json"}

req = Request(url=url, headers=headers)
with request.urlopen(req) as resp:
    total = 0
    data = resp.read().decode()
    for release in json.loads(data):
        count = release["assets"][0]["download_count"]
        version = release["tag_name"]
        total += count
        print(f"{version}\t{count}")
    print(f"\t{total}")
