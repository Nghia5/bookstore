# -*- coding: utf-8 -*-
import urllib.request
import json
from concurrent.futures import ThreadPoolExecutor

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'application/json'
}

categories = [8322, 844, 846, 870, 1754, 873, 845]
collected = []

for cat in categories:
    try:
        url = f'https://tiki.vn/api/v2/products?limit=40&include=advertisement&aggregations=2&trackity_id=1&category={cat}'
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=4) as resp:
            data = json.loads(resp.read().decode('utf-8'))
            for it in data.get('data', []):
                img = it.get('thumbnail_url')
                if img and 'tikicdn.com' in img:
                    img_hi = img.replace('/280x280/', '/750x750/')
                    collected.append(img_hi)
    except Exception as e:
        print(f"Cat {cat} err:", e)

# Add existing verified covers
with open('scripts/verified_real_covers.txt', 'r', encoding='utf-8') as f:
    for line in f:
        l = line.strip()
        if l:
            collected.append(l)

unique = list(dict.fromkeys(collected))
print(f"Total unique URLs to verify: {len(unique)}")

def check_url(url):
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=3) as resp:
            if resp.status == 200:
                return url
    except Exception:
        return None

verified = []
with ThreadPoolExecutor(max_workers=25) as executor:
    results = executor.map(check_url, unique)
    for r in results:
        if r:
            verified.append(r)

print(f"100% Verified working real covers: {len(verified)}")
with open('scripts/all_verified_covers.txt', 'w', encoding='utf-8') as f:
    for v in verified:
        f.write(v + '\n')
