import urllib.request, urllib.error, json

statuses = ["Pending", "Processing", "Shipped", "Shipping", "Completed", "Delivered", "Cancelled"]
for st in statuses:
    body = json.dumps({"status": st}).encode('utf-8')
    req = urllib.request.Request('http://localhost:5000/api/admin/orders/2/status', data=body, headers={'Content-Type':'application/json'}, method='PUT')
    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode())
            print(f"[{st}] -> 200 OK -> {data}")
    except urllib.error.HTTPError as e:
        print(f"[{st}] -> ERROR {e.code} -> {e.read().decode()}")
