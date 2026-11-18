# -*- coding: utf-8 -*-
import urllib.request

with open('scripts/working_covers.txt', 'r', encoding='utf-8') as f:
    working = [line.strip() for line in f if line.strip()]

print(f"Total verified working covers: {len(working)}")
