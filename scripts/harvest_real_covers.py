# -*- coding: utf-8 -*-
import os
import re
import urllib.request

urls = set()
pattern = re.compile(r'https?://[^\s\'"<>]+?\.(?:jpg|jpeg|png|webp)', re.IGNORECASE)

# Scan all files in project
for root, dirs, files in os.walk('.'):
    if '.git' in root or 'node_modules' in root or 'bin' in root or 'obj' in root:
        continue
    for file in files:
        if file.endswith(('.sql', '.tsx', '.ts', '.py')):
            filepath = os.path.join(root, file)
            try:
                with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                    found = pattern.findall(content)
                    for u in found:
                        if 'tikicdn.com' in u or 'fahasa.com' in u or 'nhanam' in u:
                            urls.add(u)
            except Exception:
                pass

print(f"Discovered {len(urls)} book cover URLs in workspace files.")

# Test each URL
verified = []
for idx, u in enumerate(urls):
    try:
        req = urllib.request.Request(u, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
        with urllib.request.urlopen(req, timeout=3) as resp:
            if resp.status == 200:
                verified.append(u)
    except Exception:
        pass

print(f"Verified {len(verified)} working 200 OK real book covers.")
with open('scripts/verified_real_covers.txt', 'w', encoding='utf-8') as f:
    for v in verified:
        f.write(v + '\n')
