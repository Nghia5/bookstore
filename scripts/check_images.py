# -*- coding: utf-8 -*-
import urllib.request
import re

content = open('scripts/assign_authentic_covers.sql', encoding='utf-8').read()
urls = list(set(re.findall(r"CoverImageUrl = N'([^']+)'", content)))

working = []
broken = []

for u in urls:
    try:
        req = urllib.request.Request(u, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
        with urllib.request.urlopen(req, timeout=3) as resp:
            if resp.status == 200:
                working.append(u)
            else:
                broken.append(u)
    except Exception:
        broken.append(u)

print(f"Total: {len(urls)}, Working: {len(working)}, Broken: {len(broken)}")
with open('scripts/working_covers.txt', 'w', encoding='utf-8') as f:
    for w in working:
        f.write(w + '\n')
