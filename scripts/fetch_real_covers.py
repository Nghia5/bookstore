import subprocess
import json
import urllib.parse
import unicodedata
import re
import sys
import time

sys.stdout.reconfigure(encoding='utf-8')

def strip_accents(text):
    return ''.join(c for c in unicodedata.normalize('NFD', text) if unicodedata.category(c) != 'Mn').replace('đ','d').replace('Đ','D')

# 1. Fetch books from DB
cmd = [
    'sqlcmd', '-S', 'localhost', '-d', 'BookstoreDb', '-f', '65001',
    '-Q', 'SET NOCOUNT ON; SELECT Id, Title FROM Books ORDER BY Id;'
]
res = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8')
lines = [l.strip() for l in res.stdout.splitlines() if l.strip() and not l.startswith('-')]

books = []
for line in lines:
    parts = line.split(maxsplit=1)
    if len(parts) == 2 and parts[0].isdigit():
        book_id = int(parts[0])
        title = parts[1].strip()
        books.append((book_id, title))

print(f"Loaded {len(books)} books from database.")

def clean_title(t):
    # Remove subtitles in parentheses e.g. " (The Alchemist)"
    t = re.sub(r'\(.*?\)', '', t)
    # Remove author suffixes or dashes
    t = t.split('-')[0].split(':')[0].strip()
    return t

updates = []
cache = {}

for idx, (bid, title) in enumerate(books):
    c_title = clean_title(title)
    q_str = strip_accents(c_title).strip()
    if not q_str:
        q_str = strip_accents(title)

    cover_url = None
    if q_str in cache:
        cover_url = cache[q_str]
    else:
        url = f"https://tiki.vn/api/v2/products?q={urllib.parse.quote(q_str)}&limit=1"
        try:
            r = subprocess.run(['curl.exe', '-s', url], capture_output=True, text=True, encoding='utf-8')
            if r.stdout:
                data = json.loads(r.stdout)
                if data.get('data') and len(data['data']) > 0:
                    thumb = data['data'][0].get('thumbnail_url')
                    if thumb and 'salt.tikicdn.com' in thumb:
                        # Upgrade to 750x750 high resolution
                        thumb = re.sub(r'cache/\d+x\d+/', 'cache/750x750/', thumb)
                        cover_url = thumb
            time.sleep(0.08)
        except Exception as e:
            pass

    if cover_url:
        cache[q_str] = cover_url
        updates.append((bid, title, cover_url))
        print(f"[{idx+1}/{len(books)}] [SUCCESS] {title[:32]} -> {cover_url[:65]}...")
    else:
        print(f"[{idx+1}/{len(books)}] [NOT_FOUND] {title[:32]}")

print(f"\nCompleted! Found real covers for {len(updates)} / {len(books)} books.")

# Generate SQL script with transaction
sql_lines = [
    "USE BookstoreDb;",
    "SET NOCOUNT ON;",
    "BEGIN TRANSACTION;"
]
for bid, title, url in updates:
    clean_url = url.replace("'", "''")
    sql_lines.append(f"UPDATE Books SET CoverImageUrl = N'{clean_url}' WHERE Id = {bid};")
sql_lines.append("COMMIT TRANSACTION;")
sql_lines.append(f"PRINT N'Updated {len(updates)} books with real Vietnamese book covers!';")

with open('scripts/update_real_covers.sql', 'w', encoding='utf-8') as f:
    f.write("\n".join(sql_lines))

print(f"Generated scripts/update_real_covers.sql.")
