#!/usr/bin/env python3
'''using 'http://slowwly.robertomurray.co.uk' to simulate a slow response and test catching. '''

from web import get_page

url = 'http://slowwly.robertomurray.co.uk/delay/3000/url/http://www.example.com'
print("First access (this may take a few seconds):")
page_content = get_page(url)
print(f"Content fetched:\n{page_content[:200]}...")
print("\nSecond access (should be fast due to caching):")
cached_content = get_page(url)
print(f"Content fetched:\n{cached_content[:200]}...")
import time
print("\nWaiting for 11 seconds for the cache to expire...")
time.sleep(11)

print("Third access after cache expiration (this will fetch from the web again):")
expired_content = get_page(url)
print(f"Content fetched:\n{expired_content[:200]}...")
