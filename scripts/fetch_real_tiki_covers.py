# -*- coding: utf-8 -*-
import urllib.request
import json
import time

categories = [8322, 844, 846, 870, 1754, 873, 845]
real_covers = []

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
    'Accept': 'application/json'
}

for cat in categories:
    try:
        url = f'https://tiki.vn/api/v2/products?limit=40&include=advertisement&aggregations=2&trackity_id=1&category={cat}'
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=5) as resp:
            data = json.loads(resp.read().decode('utf-8'))
            items = data.get('data', [])
            for it in items:
                img = it.get('thumbnail_url')
                if img and 'tikicdn.com' in img:
                    # Convert to high-res 750x750 or keep
                    img_hi = img.replace('/280x280/', '/750x750/')
                    real_covers.append(img_hi)
        print(f"Cat {cat}: collected {len(items)} items. Total now: {len(real_covers)}")
        time.sleep(0.3)
    except Exception as e:
        print(f"Cat {cat} err:", e)

# Deduplicate
unique_covers = list(dict.fromkeys(real_covers))
print(f"Unique covers collected: {len(unique_covers)}")

# Also add existing verified covers
with open('scripts/verified_real_covers.txt', 'r', encoding='utf-8') as f:
    for line in f:
        l = line.strip()
        if l and l not in unique_covers:
            unique_covers.append(l)

print(f"Combined pool: {len(unique_covers)} covers.")

# Verify each URL with a fast HEAD / GET
verified = []
for idx, c in enumerate(unique_covers):
    try:
        req = urllib.request.Request(c, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=3) as resp:
            if resp.status == 200:
                verified.append(c)
    except Exception:
        pass

print(f"Final 100% verified working real book covers: {len(verified)}")
with open('scripts/all_verified_covers.txt', 'w', encoding='utf-8') as f:
    for v in verified:
        f.write(v + '\n')
