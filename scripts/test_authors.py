# -*- coding: utf-8 -*-
import urllib.request

test_authors = [
    (1, "Paulo Coelho", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Paulo_Coelho_14112007.jpg/440px-Paulo_Coelho_14112007.jpg"),
    (2, "Dale Carnegie", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Dale_Carnegie.jpg/440px-Dale_Carnegie.jpg"),
    (3, "Yuval Noah Harari", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Yuval_Noah_Harari_in_2024.jpg/440px-Yuval_Noah_Harari_in_2024.jpg"),
    (4, "James Clear", "https://images.gr-assets.com/authors/1534063231p8/7327369.jpg"),
    (5, "Nguyễn Nhật Ánh", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Nguyen_Nhat_Anh.jpg/440px-Nguyen_Nhat_Anh.jpg"),
    (6, "Tô Hoài", "https://upload.wikimedia.org/wikipedia/vi/thumb/9/91/To_Hoai.jpg/440px-To_Hoai.jpg"),
    (7, "Nguyên Phong", "https://salt.tikicdn.com/cache/750x750/ts/product/07/47/18/c2b4715eb2e56d0e33f4b6788532b182.jpg"),
    (8, "Robert Kiyosaki", "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Robert_Kiyosaki_by_Gage_Skidmore.jpg/440px-Robert_Kiyosaki_by_Gage_Skidmore.jpg"),
    (9, "Morgan Housel", "https://images.gr-assets.com/authors/1598375628p8/14073357.jpg"),
    (10, "Daniel Kahneman", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Daniel_Kahneman_%28Nobel_laureate_2002%29_at_the_World_Economic_Forum_Annual_Meeting_2008.jpg/440px-Daniel_Kahneman_%28Nobel_laureate_2002%29_at_the_World_Economic_Forum_Annual_Meeting_2008.jpg"),
    (11, "Antoine de Saint-Exupéry", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Antoine_de_Saint-Exup%C3%A9ry.jpg/440px-Antoine_de_Saint-Exup%C3%A9ry.jpg"),
    (12, "George Orwell", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/George_Orwell_press_photo.jpg/440px-George_Orwell_press_photo.jpg"),
    (13, "Franz Kafka", "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Franz_Kafka%2C_1923.jpg/440px-Franz_Kafka%2C_1923.jpg"),
    (14, "Haruki Murakami", "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/HarukiMurakami.png/440px-HarukiMurakami.png"),
    (15, "Nguyễn Du", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Nguyen_Du.jpg/440px-Nguyen_Du.jpg"),
    (16, "Nam Cao", "https://upload.wikimedia.org/wikipedia/vi/thumb/f/f6/Nam_Cao.jpg/440px-Nam_Cao.jpg"),
    (17, "Vũ Trọng Phụng", "https://upload.wikimedia.org/wikipedia/vi/thumb/9/90/Vu_Trong_Phung.jpg/440px-Vu_Trong_Phung.jpg"),
    (18, "Stephen Hawking", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Stephen_Hawking.StarChild.jpg/440px-Stephen_Hawking.StarChild.jpg"),
    (19, "Robert C. Martin", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Robert_Cecil_Martin.png/440px-Robert_Cecil_Martin.png"),
    (20, "Martin Fowler", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Martin_Fowler_2008.jpg/440px-Martin_Fowler_2008.jpg"),
    (21, "Andrew Ng", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Andrew_Ng_at_the_2018_AI_Conference_in_San_Francisco_%28cropped%29.jpg/440px-Andrew_Ng_at_the_2018_AI_Conference_in_San_Francisco_%28cropped%29.jpg"),
    (22, "Carl Sagan", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Carl_Sagan_Planetary_Society_romance_cropped.jpg/440px-Carl_Sagan_Planetary_Society_romance_cropped.jpg"),
    (26, "Victor Hugo", "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Victor_Hugo_001.jpg/440px-Victor_Hugo_001.jpg"),
    (27, "Arthur Conan Doyle", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Arthur_Conan_Doyle_by_Herbert_Rose_Barraud_1893.jpg/440px-Arthur_Conan_Doyle_by_Herbert_Rose_Barraud_1893.jpg"),
    (28, "Lev Tolstoy", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/L.N.Tolstoy_Prokudin-Gorsky.jpg/440px-L.N.Tolstoy_Prokudin-Gorsky.jpg"),
    (29, "J.K. Rowling", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/J._K._Rowling_2010.jpg/440px-J._K._Rowling_2010.jpg"),
    (30, "Dan Brown", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Dan_Brown_bookjacket_cropped.jpg/440px-Dan_Brown_bookjacket_cropped.jpg"),
    (31, "Walter Isaacson", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Walter_Isaacson_at_the_2011_Miami_Book_Fair_International.jpg/440px-Walter_Isaacson_at_the_2011_Miami_Book_Fair_International.jpg"),
    (32, "Malcolm Gladwell", "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Malcolm_Gladwell_PopTech_2008.jpg/440px-Malcolm_Gladwell_PopTech_2008.jpg"),
    (33, "Thích Nhất Hạnh", "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Thich_Nhat_Hanh_in_Bordeaux_2006.jpg/440px-Thich_Nhat_Hanh_in_Bordeaux_2006.jpg"),
    (34, "Marcus Aurelius", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Marcus_Aurelius_Glyptothek_Munich.jpg/440px-Marcus_Aurelius_Glyptothek_Munich.jpg"),
    (35, "Sun Tzu", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Enshrined_Sun_Tzu.jpg/440px-Enshrined_Sun_Tzu.jpg"),
    (36, "Robin Sharma", "https://images.gr-assets.com/authors/1360677130p8/73427.jpg"),
    (37, "Brian Tracy", "https://images.gr-assets.com/authors/1202241604p8/22033.jpg"),
    (38, "Cal Newport", "https://images.gr-assets.com/authors/1471378370p8/147891.jpg"),
    (39, "Donald Knuth", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/KnuthAtOpenContentAlliance.jpg/440px-KnuthAtOpenContentAlliance.jpg"),
    (40, "Richard Feynman", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/RichardFeynman-PVP.jpg/440px-RichardFeynman-PVP.jpg")
]

working_authors = []
broken_authors = []

for aid, name, url in test_authors:
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'})
        with urllib.request.urlopen(req, timeout=4) as resp:
            if resp.status == 200:
                working_authors.append((aid, name, url))
            else:
                broken_authors.append((aid, name, url, resp.status))
    except Exception as e:
        broken_authors.append((aid, name, url, str(e)))

print(f"Working authors: {len(working_authors)}, Broken: {len(broken_authors)}")
if broken_authors:
    for b in broken_authors:
        print("Broken:", b)
